import tkinter as tk
from tkinter import ttk
import customtkinter as ctk


def main():
    # Δημιουργία αρχικού παραθύρου.
    window = ctk.CTk()
    window.title("Virtual Assistant")
    window.geometry("720x480")
    ctk.set_appearance_mode("dark")

    label = ctk.CTkLabel(
        master=window, text="Virtual  Assistant", font=("TimeBurner", 24, "bold")
    )
    label.pack(pady=10)

    button = ctk.CTkButton(
        master=window,
        text="Enter",
        font=("TimeBurner", 20, "bold"),
    )
    button.pack(pady=10)

    # Τρέχουμε το παράθυρο μέχρι να τερματίσει η εφαρμογή.
    window.mainloop()


if __name__ == "__main__":
    main()
