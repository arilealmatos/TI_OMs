# Convertendo Texto em Aúdio

from gtts import gTTS

texto = "Coloque seu Texto"
audio = "meu_audio.mp3"

tts = gTTS(texto, lang='pt-br')
tts.save(audio)