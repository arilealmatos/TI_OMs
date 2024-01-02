# Extraindo Texto de PDF

import PyPDF2 as lpdf

try:
    with open('seuarquivo.pdf', 'rb') as arquivo.pdf:
        ler_pdf = lpdf.PdfFileReader(arquivo_pdf)
        if ler_pdf.numPages > 0:
            extrai_texto = ''
            for num_pagina in range(ler_pdf.numPages):
                pagina = lpdf.getPage(num_pagina)
                extrai_texto += pagina.extractText()
                
            print(extrai_texto)
        else:
            print('O arquivo PDF está vazio ou não é válido.')
except FileNotFoundError:
    print('O arquivoPDF não foi encontrado.')
    
except Exception as e:
    print(f'Ocorreu um erro ao processar o arquivo PDF: {str(e)}')