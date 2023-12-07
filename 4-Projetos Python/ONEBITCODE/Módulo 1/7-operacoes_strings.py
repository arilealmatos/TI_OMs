gameName = "Fifa"
gameVersion = " 23"
line = "="

# 1 - Operação de concatenação de Strings
print(line * 50)
gameFullName = gameName + gameVersion
print(gameFullName)

# 2 - Multiplicação de Strings
print(line * 50)

gameDescription = '''
Fifa 23 é um jogo de futebol
desenvolvido pela EA Sports
e que possibilita jogar localmente ou online.
'''
print(gameDescription)
print(line * 50)

# 3 - Procura Palavras dentro de um texto
print("fifa" in gameDescription)
print("futebol" in gameDescription)
print(line * 50)



