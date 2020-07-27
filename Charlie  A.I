import google as g
#import boto3
import speech_recognition as sr
import os
from playsound import playsound
import webbrowser
import random
import time

speech = sr.Recognizer()

greeting_dict = {'hello':'hello','hi':'hi','how are you':'how are you','how far':'how far'}
open_launch_dict = {'open':'open','launch':'launch'}
google_searches_dict = {'what': 'what', 'why': 'why', 'who': 'who', 'which':'which', 'define':'define', 'when': 'when','the': 'the'}
social_media_dict = {'internet speed':'https://www.fast.com','facebook':'https://www.facebook.com','football':'https://www.goal.com','youtube':'https://www.youtube.com','anchor':'https://www.aul.edu.ng','portal':'http://portal.aul.edu.ng/login','bank':'https://www.piggybank.com',}


def play_sound(mp3_list):
    mp3 = random.choice(mp3_list)
    playsound(mp3)

def is_valid_google_search(phrase):
    if(google_searches_dict.get(phrase.split(' ')[0]) == phrase.split(' ')[0]):
        return True

def read_voice_cmd():
    voice_text = ''
    print('listening...')

    global error_occurrence
    
    try:
        with sr.Microphone() as source:
            audio = speech.listen(source=source,timeout=5,phrase_time_limit=5)
        voice_text = speech.recognize_google(audio)
    except sr.UnknownValueError:
        
        if error_occurrence == 0:
            play_sound(mp3_listening_problem_list)
            error_occurrence += 1
        elif error_occurrence == 1:
            play_sound(mp3_strugging_list)
            error_occurrence += 1


def is_valid_note(greeting_dict,voice_note):
    for key, value in greeting_dict.items():
        #'Hello zira'
        try:
            if value == voice_note.split(' ')[0]:
                return True
                break
            if key == voice_note.split(' ')[1]:
                return True
                break 
        except IndexError:
            pass

    return False


if __name__ == '__main__':

    #playsound ('C:\Users\TIMIAK\Desktop\Alex Official\creator.mp3')



    while True:

        voice_note = read_voice_cmd().lower()
        print('cmd : {}'.format(voice_note))

        if is_valid_note(greeting_dict,voice_note):
            print('in greeting...')
            play_sound(mp3_greeting_list)
            continue
        elif is_valid_note(open_launch_dict,voice_note):
            print('in open...')
            play_sound(mp3_launch_list)
            #__launch applications__
            if (is_valid_note(social_media_dict,voice_note)):
                key = voice_note.split(' ')[1]
                webbrowser.open(social_media_dict.get(key))
            else:
                os.system('explorer C:\\"{}"'.format(voice_note.replace('open ', '').replace('launch ', '')))
            continue
        elif is_valid_google_search(voice_note):
            print('in google search...')
            webbrowser.open('https://www.google.co.in/search?q={}'.format(voice_note))
            playsound('/Users/ADENIJI SAMUEL/Music/zira google search.mp3')
            continue
