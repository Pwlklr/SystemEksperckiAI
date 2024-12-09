import tkinter as tk
import clips


class ExpertSystemApp:
    def __init__(self, root):
        # Inicjalizacja głównego okna
        self.root = root
        self.root.title("Expert System - What Should I Eat?")
        self.root.geometry("400x300")

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
        
        # Przyciski do odpowiadania
        self.yes_button = tk.Button(root, text="Yes", command=self.yes)
        self.no_button = tk.Button(root, text="No", command=self.no)
        self.back_button = tk.Button(root, text="Back", command=self.back)


        
        

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
        self.template = self.env.find_template("to-modify")
        self.template_back = self.env.find_template("back")
        self.template_set_unknown = self.env.find_template("set-unknown")

        self.loop()
    def loop(self):
        # Chowanie elementow
        self.question_label.pack_forget() 
        self.yes_button.pack_forget() 
        self.no_button.pack_forget() 
        self.back_button.pack_forget()

        # Uruchomienie procesu wnioskowania
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
                self.prev_questions.append(self.question)
                self.question = str(ask_facts[0])[16:-3]
                self.questions()
        else:
            self.result_label.config(text="No facts found.")

    def questions(self):
        self.result_label.pack_forget()
        
        
        print(self.question)

        match self.question:
            case 'japan':
                question_label_text = 'Are you from Japan?'
            case 'unemployed':
                question_label_text = 'Are you unemployed?'
            case 'alaska':
                question_label_text = 'Are you in Alaska?'
            case 'diet':
                question_label_text = 'Are you on a diet?'
            case 'vegetarian':
                question_label_text = 'Are you a vegetarian?'
            case 'vegan':
                question_label_text = 'Are you vegan?'
            case 'pizza':
                question_label_text = 'Do you want pizza?'
            case 'with-parents':
                question_label_text = 'Are you still living with your parents?'
            case 'cleaning':
                question_label_text = 'Do you need good "cleaning"?'
            case 'who':
                question_label_text = 'Are you Doctor Who?'
            case 'impress':
                question_label_text = 'Are you trying to impress?'
            case 'thirsty':
                question_label_text = 'Are you thirsty?'
            case 'breakfast':
                question_label_text = 'Do you want breakfast?'
            case 'summer-2010':
                question_label_text = 'Is it summer 2010?'
            case 'jewish':
                question_label_text = 'Are you Jewish?'
            case 'elaine-benes':
                question_label_text = 'Are you Elaine Benes?'
            case 'wow':
                question_label_text = 'Are you playing WoW?'
            case 'foreman':
                question_label_text = 'Are you using a foreman?'
            case 'dessert':
                question_label_text = 'Do you want dessert?'
            case 'childhood':
                question_label_text = 'Are you trying to relieve?'
            case 'pie':
                question_label_text = 'Do you want pie?'
            case 'school':
                question_label_text = 'Did you just get home from school?'
            case 'drunk-high':
                question_label_text = 'Are you drunk and/or high?'
            case 'ice-cream':
                question_label_text = 'Do you want ice cream?'
            case 'lactose-intolerant':
                question_label_text = 'Are you lactose intolerant?'
            case 'spoon':
                question_label_text = 'Do you have a spoon?'
            case 'ethnic':
                question_label_text = 'Are you in the mood for ethnic food?'
            case 'chain':
                question_label_text = 'Do you like chain restaurants?'
            case 'pre-heat':
                question_label_text = 'Do you know hot to pre-heat the oven?'
            case _:
                question_label_text = 'Unknown question.'

        
        
        # Ustawianie pytania i odpowiedzi
        self.question_label.config(text=question_label_text)
        self.question_label.pack(pady=(30, 10))  # Space above, smaller space below
        self.yes_button.pack(pady=15, padx=30)  # More horizontal space, stretch horizontally
        self.no_button.pack(pady=15, padx=30)   # Matching with the yes_button
        self.back_button.pack(pady=15, padx=30)    # More balanced padding

    def yes(self):
        self.template.assert_fact(question = self.question, answer = "yes")
        self.loop()
    def no(self):
        self.template.assert_fact(question = self.question, answer = "no")
        self.loop()
    def back(self):
        self.template_back.assert_fact(question = self.question)
        self.template_set_unknown.assert_fact(question = self.prev_questions[-1])
        self.prev_questions = self.prev_questions[:-1] 
        self.loop()
        
        

def main():
    """Tworzenie głównego okna aplikacji GUI"""
    root = tk.Tk()
    app = ExpertSystemApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()