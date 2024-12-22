import tkinter as tk
import clips
import json

class ExpertSystemApp:
    def __init__(self, root):
        # Inicjalizacja głównego okna
        self.root = root
        self.root.title("Expert System - What Should I Eat?")
        self.root.geometry("400x400")

        # Etykieta powitalna
        self.label = tk.Label(root, text="Welcome to the Expert System!", font=("Arial", 14))
        self.label.pack(pady=20)

        # Przycisk startowy
        self.button = tk.Button(root, text="Start", command=self.start_inference)
        self.button.pack(pady=10)

        # Wynik wnioskowania
        self.result_label = tk.Label(root, text="", font=("Arial", 12))
        self.result_label.pack(pady=20)

        # Pytanie
        self.question_label = tk.Label(root, text="", font=("Arial", 12))

        #Odpowiedz
        self.answer = "unnkown"
        
        # Przyciski do odpowiadania
        self.answer_button_1 = tk.Button(root, text="", command= self.answer_func)
        self.answer_button_2 = tk.Button(root, text="", command= self.answer_func)
        self.answer_button_3 = tk.Button(root, text="")

        self.back_button = tk.Button(root, text="Back", command=self.back)

        # Pytania z pliku json
        with open('questions.json', 'r', encoding='utf-8') as file:
            self.question_list = json.load(file)



        
        

    def start_inference(self):
        """Metoda wywołująca proces wnioskowania w CLIPS i wyświetlająca wynik w GUI"""
        print("Start button clicked!")
        self.button.pack_forget()
        # Inicjalizacja środowiska CLIPS
        self.env = clips.Environment()
        self.question = ''
        self.prev_questions = []

        # Wczytanie reguł wnioskowania z tekstu w formie stringów
        self.env.load("clips_engine.clp")

        # Przygotowanie templatki do modyfikacji
        self.template_to_modify = self.env.find_template("to-modify")
        self.template_back = self.env.find_template("back")
        self.template_set_unknown = self.env.find_template("set-unknown")
        self.template_question = self.env.find_template("answer-to-question")

        self.loop()
    def loop(self):
        # Chowanie elementow
        self.question_label.pack_forget() 
        self.answer_button_1.pack_forget() 
        self.answer_button_2.pack_forget()
        self.answer_button_3.pack_forget() 
        self.back_button.pack_forget()

        # Uruchomienie procesu wnioskowania
        self.env.run()
        self.env.run()
    
        # Sprawdzenie wyników w pamięci roboczej (faktów)
        facts = list(self.env.facts())  # Konwertowanie generatora na listę
        
        # Wyświetlenie wyników w GUI
        if facts:
            food_facts = [fact for fact in facts if 'food-result' in str(fact)]
            ask_facts = [fact for fact in facts if 'ask' in str(fact)[:4]]
            if food_facts:
                result =''
                for i in food_facts:
                    result+=str(i)[13:-1:]
                    result+="\n"  # Pobranie faktu z wynikiem
                self.result_label.config(text=f"Suggested foods:\n{result}")
                self.result_label.pack(pady=20)
                
                # Restart
                self.button.config(text="Restart")
                self.button.pack(pady=10)
            elif ask_facts:
                # Zadawanie pytania
                if self.question and self.question != str(ask_facts[0])[16:-3]:
                    self.prev_questions.append(self.question)
                self.question = str(ask_facts[0])[16:-3]
                self.questions()
        else:
            self.result_label.config(text="No facts found.")

    def questions(self):
        self.result_label.pack_forget()
        
        

# Extract slot information and allowed values
        for slot in self.template_question.slots:
            allowed_values = slot.allowed_values
            if allowed_values is not None and slot.name == 'answer':
                print("Allowed Values:", list(allowed_values))
        print(self.question)

        #Dobór pytania z pliku json
        question_label_text = self.question_list[self.question]
        
        # Ustawianie pytania i odpowiedzi
        self.question_label.config(text=question_label_text)
        self.question_label.pack(pady=(30, 10))  # Space above, smaller space below

        self.answer_button_1.configure(text=list(allowed_values)[0], command= lambda: self.answer_func(list(allowed_values)[0]))
        self.answer_button_2.configure(text=list(allowed_values)[1], command= lambda: self.answer_func(list(allowed_values)[1]))
        self.answer_button_3.configure(text=list(allowed_values)[2])

        self.answer_button_1.pack(pady=15, padx=30)  # More horizontal space, stretch horizontally
        self.answer_button_2.pack(pady=15, padx=30)   # Matching with the yes_button
        self.answer_button_3.pack(pady=15, padx=30)   # Matching with the yes_button

        if len(self.prev_questions) >= 1:
            self.back_button.pack(pady=15, padx=30)    # More balanced padding

    def answer_func(self, answer):
        self.template_to_modify.assert_fact(question = self.question, answer = answer)
        self.loop()
    def back(self):
        self.template_back.assert_fact(question = self.question)
        self.template_set_unknown.assert_fact(question = self.prev_questions[-1])
        self.question = self.prev_questions[-1]
        self.prev_questions = self.prev_questions[:-1] 
        self.loop()
        
        

def main():
    """Tworzenie głównego okna aplikacji GUI"""
    root = tk.Tk()
    app = ExpertSystemApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()