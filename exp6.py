# -*- coding: utf-8 -*-
"""Exp6.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1o_6HZSK7wuav6LKurIfF855tUP7XDIdh
"""

# Install the required library
!pip install SpeechRecognition

import speech_recognition as sr

# Path to the audio file
audio_file = 'Conference.wav'

def recognize_speech(audio_file):
    """
    Recognize speech from an audio file and return the text.

    Parameters:
        audio_file (str): Path to the audio file.

    Returns:
        str: Recognized text from the audio file, or None if recognition fails.
    """
    # Create a recognizer object
    recognizer = sr.Recognizer()

    try:
        # Load the audio file
        with sr.AudioFile(audio_file) as source:
            audio = recognizer.record(source)

        # Recognize the speech in the audio file
        text = recognizer.recognize_google(audio)
        print(f"Recognized text: {text}")
        return text

    except sr.UnknownValueError:
        print("Speech Recognition could not understand the audio.")
        return None
    except sr.RequestError as e:
        print(f"Could not request results from the Speech Recognition service: {e}")
        return None

# Call the function to recognize speech
recognized_text = recognize_speech("harvard.wav")