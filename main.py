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

    def start_inference(self):
        """Metoda wywołująca proces wnioskowania w CLIPS i wyświetlająca wynik w GUI"""
        print("Start button clicked!")

        # Inicjalizacja środowiska CLIPS
        env = clips.Environment()

        # Wczytanie reguł wnioskowania z tekstu w formie stringów
        env.load("clips_engine.clp")

        # Uruchomienie procesu wnioskowania
        env.run()

        # Sprawdzenie wyników w pamięci roboczej (faktów)
        facts = list(env.facts())  # Konwertowanie generatora na listę

        # Wyświetlenie wyników w GUI
        if facts:
            food_fact = [fact for fact in facts if 'food-result' in str(fact)]
            if food_fact:
                result = food_fact[0]  # Pobranie faktu z wynikiem
                self.result_label.config(text=f"Suggested food: {result}")
            else:
                self.result_label.config(text="No suggestion found.")
        else:
            self.result_label.config(text="No facts found.")


def main():
    """Tworzenie głównego okna aplikacji GUI"""
    root = tk.Tk()
    app = ExpertSystemApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()