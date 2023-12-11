"""
Substituindo caractere repetido

1-Escreva um programa Python para 
obter uma string de uma determinada 
string em que todas as ocorrências 
de seu primeiro caractere foram 
alteradas para '$', exceto o 
próprio primeiro caractere

2-Escreva um programa Python para 
obter uma única string de duas 
strings fornecidas, separadas 
por um espaço e troque os dois 
primeiros caracteres de cada string.

"""
# Desafio 1
name = 'Fifa 23'

character = name[0].lower()
new = name.replace(character, '#')
new = character +  new[1:]
print(new)

# Desafio 2
st1 = 'abc'
st2 = 'xyz'

new_st1 = st2[:2] + st1[2:]
new_st2 = st1[:2] + st2[2:]

print(f"{new_st1} {new_st2}")