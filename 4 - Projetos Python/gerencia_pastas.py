import PySimpleGUI as sg
import os
import glob
import shutil

LOGIN1 = 'blog'
PASSWORD = 'Gu4r4n1@2022'

# dicionário mapeando cada extensão com sua pasta correspondente
# Por exemplo, os arquivos 'jpg', 'png', 'ico', 'gif', 'svg' serão movidos para a pasta 'imagens'
# sinta-se à vontade para mudar de acordo com suas necessidades

extensions = {
     "apk": "1 - Apk",
     "rar": "2 - Arquivo",
     "zip": "2 - Arquivo",
     "gz": "2 - Arquivo",
     "tar": "2 - Arquivo",
     "iso": "2 - Arquivo",
     "bz2": "2 - Arquivo",
     "deb": "2 - Arquivo",
     "mp3": "3 - Áudio",
     "wav": "3 - Áudio",
     "sql": "4 - BD",
     "xlsx": "5 - Documento(Excel)",
     "csv": "5 - Documento(Excel)",
     "ods": "5 - Documento(Excel)",
     "pdf": "6 - Documento(PDF)",
     "pptx": "7 - Documento(Powerpoint)",
     "ppt": "7 - Documento(Powerpoint)",
     "odp": "7 - Documento(Powerpoint)",
     "txt": "8 - Documento(TXT)",
     "log": "8 - Documento(TXT)",
     "docx": "9 - Documento(Word)",
     "odt": "9 - Documento(Word)",
     "doc": "9 - Documento(Word)",
     "mobi": "9 - Documento(Word)",
     "cbr": "9 - Documento(Word)",
     "cbz": "9 - Documento(Word)",
     "jpg": "10 - Imagens",
     "jpge": "10 - Imagens",
     "png": "10 - Imagens",
     "ico": "10 - Imagens",
     "gif": "10 - Imagens",
     "svg": "10 - Imagens",
     "exe": "11 - Programas",
     "msi": "11 - Programas",
     "ipynb": "12 - Python",
     "py": "12 - Python",
     "torrent": "13 - Torrents",
     "mp4": "14 - Vídeo",
     "m3u8": "14 - Vídeo",
     "webm": "14 - Vídeo",
     "ts": "14 - Vídeo",
     "css": "15 - Web",
     "js": "15 - Web",
     "html": "15 - Web",
}

#Caminho da pasta a ser gerenciada
path = r"D:\Ari Leal Matos\Downloads"

class Tela:

    sg.theme('Black')

    def __init__(self):
        # Login
        layout = [
            [sg.Text('Login', size=(18, 0)), sg.Input(size=(18, 0), key='login')],
            [sg.Text('Senha', size=(18, 0)), sg.Input(size=(18, 0), key='senha', password_char='*')],
            [sg.Button('Entrar'), sg.Button('Fechar')]
        ]
        self.janela = sg.Window("Gerencia de Pastas", layout=layout)

    def layout2(self):
        # tela 2
        layout2 = [
            [sg.Text('Usuário Confirmado!', size=(20, 0), key='login')]
        ]
        return sg.Window("Login", layout=layout2, element_justification='center')

    def iniciar(self):
        self.button, self.values = self.janela.Read()

        while True:
            # checar login
            if self.button == 'Entrar':
                if self.values['login'] == LOGIN1 and self.values['senha'] == PASSWORD:
                    self.janela2 = self.layout2()
                    self.button, self.values = self.janela2.Read()
                    [sg.popup("Gerencia de Pastas!")]
                    self.janela.hide()
                    # Executa o Gerenciamento de Pastas
                    for extension, folder_name in extensions.items():
                        # Pega todos os arquivos que terminam com a extensão
                        files = glob.glob(os.path.join(path, f"*.{extension}"))
                        print(f"[*] Encontrados {len(files)} arquivos com extensão '{extension}'")

                        if not os.path.isdir(os.path.join(path, folder_name)) and files:
                            # Cria a pasta se não existir
                            print(f"[+] Making {folder_name} folder")
                            os.mkdir(os.path.join(path, folder_name))

                        for file in files:
                            # Para cada arquivo, move para a pasta correspondente
                            basename = os.path.basename(file)
                            dst = os.path.join(path, folder_name, basename)

                            print(f"[*] Movendo {file} para {dst}")
                            shutil.move(file, dst)
                    pass
                    [sg.popup("Pastas OK!")]
                    self.janela.hide()

                else:
                    [sg.popup("Usuário ou senha incorreto.")]
                    break

            # fechar o app
            if self.button == 'Fechar' or self.button == sg.WIN_CLOSED:
                break

        login = self.values['login']
        senha = self.values['senha']
        print(f'Login: {login}')
        print(f'Senha: {senha}')

tela = Tela()
tela.iniciar()