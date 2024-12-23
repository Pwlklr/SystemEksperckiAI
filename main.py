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

        # Dynamiczna lista przycisków odpowiedzi
        self.answer_buttons = []

        # Przycisk "Back"
        self.back_button = tk.Button(root, text="Back", command=self.back)

        # Pytania z pliku JSON
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

        # Wczytanie reguł wnioskowania z pliku
        self.env.load("clips_engine.clp")

        # Przygotowanie szablonów do komunikacji
        self.template_to_modify = self.env.find_template("to-modify")
        self.template_back = self.env.find_template("back")
        self.template_set_unknown = self.env.find_template("set-unknown")
        self.template_question = self.env.find_template("answer-to-question")

        # Rozpoczęcie pętli wnioskowania
        self.loop()

    def loop(self):
        # Ukrycie elementów GUI
        self.question_label.pack_forget()
        for button in self.answer_buttons:
            button.pack_forget()
        self.back_button.pack_forget()

        # Uruchomienie procesu wnioskowania
        self.env.run()

        # Sprawdzenie wyników w pamięci roboczej (faktów)
        facts = list(self.env.facts())

        # Wyświetlenie wyników w GUI
        if facts:
            food_facts = [fact for fact in facts if 'food-result' in str(fact)]
            ask_facts = [fact for fact in facts if 'ask' in str(fact)[:4]]

            if food_facts:
                result = '\n'.join(str(fact)[13:-1] for fact in food_facts)
                self.result_label.config(text=f"Suggested foods:\n{result}")
                self.result_label.pack(pady=20)

                # Restart
                self.button.config(text="Restart")
                self.button.pack(pady=10)

            elif ask_facts:
                if self.question and self.question != str(ask_facts[0])[16:-3]:
                    self.prev_questions.append(self.question)
                self.question = str(ask_facts[0])[16:-3]
                self.questions()
        else:
            self.result_label.config(text="No facts found.")

    def questions(self):
        """Wyświetlenie pytania i odpowiedzi na podstawie danych z CLIPS"""
        self.result_label.pack_forget()

        # Odczytanie możliwych odpowiedzi z CLIPS
        allowed_values = []
        for slot in self.template_question.slots:
            if slot.name == 'answer' and slot.allowed_values:
                allowed_values = list(slot.allowed_values)
        if "unknown" in allowed_values:
            allowed_values.remove("unknown")
        # print(f"Allowed Values: {allowed_values}")

        # Ustawianie pytania
        question_label_text = self.question_list.get(self.question, "Unknown question")
        self.question_label.config(text=question_label_text)
        self.question_label.pack(pady=(30, 10))

        # Usunięcie poprzednich przycisków odpowiedzi
        for button in self.answer_buttons:
            button.destroy()
        self.answer_buttons = []

        # Tworzenie dynamicznych przycisków odpowiedzi
        for value in allowed_values:
            button = tk.Button(self.root, text=value, command=lambda val=value: self.answer_func(val))
            button.pack(pady=15, padx=30)
            self.answer_buttons.append(button)

        # Wyświetlenie przycisku "Back", jeśli wymagane
        if self.prev_questions:
            self.back_button.pack(pady=15, padx=30)

    def answer_func(self, answer):
        """Przekazanie odpowiedzi użytkownika do CLIPS"""
        print(f"User selected: {answer}")
        self.template_to_modify.assert_fact(question=self.question, answer=answer)
        self.loop()

    def back(self):
        """Powrót do poprzedniego pytania"""
        if self.prev_questions:
            self.template_back.assert_fact(question=self.question)
            self.template_set_unknown.assert_fact(question=self.prev_questions[-1])
            self.question = self.prev_questions.pop()
        self.loop()

def main():
    """Tworzenie głównego okna aplikacji GUI"""
    root = tk.Tk()
    app = ExpertSystemApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()
