# Removendo fundo de foto
# pip install rembg
# conda install rembg

from rembg import Removendofrom PIL import Image

entrada = "Arquivo.jpg"
saida = "Arquivo.png"
entrar = Image.open(entrada)
sair = remove(entrar)

sair.save(saida)

