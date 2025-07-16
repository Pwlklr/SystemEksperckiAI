# SystemEksperckiAI

Ekspercki system wspomagający podejmowanie decyzji wykorzystujący reguły w silniku CLIPS, interfejs GUI w Tkinter oraz logikę napisaną w Pythonie.

---

## Autorzy

- **Filip Urbański**
- **Paweł Kelar**

---

## ⚙️ Technologie

- **Python 3.12.1** – główny język implementacji  
- **CLIPS 1.0.4** – regułowy silnik ekspercki  
- **Tkinter 8.6** – GUI (formularze, widoki wyników)

---

## Opis projektu

System pozwala na definiowanie i egzekwowanie reguł eksperckich, umożliwiając:

- Wprowadzanie danych przez użytkownika przez proste GUI (Tkinter),
- Przekazywanie faktów do silnika CLIPS,
- Przetwarzanie wiedzy przez CLIPS i wyciąganie wniosków,
- Prezentację wyników oraz rekomendacji w czytelnym interfejsie.

---

## Przykład działania

1. Użytkownik uzupełnia formularz.
2. Dane są przekazywane do reguł zapisanych w plikach `.clp`.
3. CLIPS wykonuje inferencję (matching + firing).
4. Wyniki wyświetlane są jako tekst w GUI.

---
