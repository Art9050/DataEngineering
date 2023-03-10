#@title Чистка данных, Заполнение почты и пароля - финальное решение
"""
Для выполнения данного упражнения вам необходимо использовать некоторые программы из предыдущих упражнений.
Вам нужно написать программу, которая будет читать файл из предыдущего упражнения, заниматься его чисткой, формировать почтовые адреса для сотрудников, генерировать пароли безопасности для входа в почту, заносить информацию в этот файл и перезаписывать его.

1. Вы можете использовать предыдущие наработки
2. Ваша программа должна очистить файл от всех невалидных данных (строки с пустыми данными, некорректными именами, некорректными телефонами и городами)
3. При очистке исходного файла, все невалидные данные должны удаляться из него и сохраняться в отдельный текстовый файл
4. Поиск информации в файле должен осуществляться с помощью регулярных выражений
5. Разрешается использовать готовую функцию формирования почтового адреса или написать свою
6. Сгенерированные пароли должны заноситься в исходный файл в отдельный столбец "PASSWORD" """"

# Генератор пароля
def pas_gen(pas):
    import random
    requirements = {'diget' : '1234567890', 'letter_up' : 'abcdefghijklmnopqrstuvwxyz', 'letter_low' : 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'symbol' : '!@#$%^&*()-+'}
    keys = list(requirements.keys())
    pas = []
    while len(pas) < 4:
        for i in keys:
            pas.append(random.choice(requirements[i]))
    while len(pas) < 12:
        for i in keys:
            pas.append(random.choice(keys[random.randint(0, 3)]))
    random.shuffle(pas)
    s =''
    return s.join(pas)

# Генератор почтового адреса
def email_gen(list_of_names):
    emails = []
    for i in list_of_names:
        letter = 1
        while i[1] + '.' + i[0][0:letter] + '@company.io' in emails:
            letter+=1
        emails.append(i[1] + '.' + i[0][0:letter] + '@company.io')
    return emails

import re
lines = [] # чистовой список
with open('task_file.txt', 'r') as f, open('invalid_data.txt', 'w') as invalid_data:
    for j in f:
        if re.findall(r'[A-Z]+\b,\s[A-Z]+\b,\s[A-Z]+_[A-Z]+\b,\s[A-Z]+\b,\s[A-Z]+\b',j):
            invalid_data.write(j)
            lines.append(j.split(', ')) #запись первой строки в оба файла
        elif re.findall(r',\s[A-Z][a-z]+\b,\s[A-Z][a-z]+\b,\s\d{7}\b,\s[A-Z][a-z]+\b',j):
            lines.append(j.split(', '))
        else:
            invalid_data.write(j)
    f.close()
    invalid_data.close()
list_of_names = []
for i in lines:
    if i[0] == 'EMAIL':
        i.insert(1, 'PASSWORD')
    else:
        list_of_names.append([i[1], i[2]])
        i.insert(0, email_gen(list_of_names)[0])
        i.pop(1)
        i.insert(1, pas_gen(pas))
        list_of_names.clear()
a = ', '
with open('task_file_final.txt', 'w') as f: # переименовать файл
    for i in lines:
            f.write(a.join(i))
