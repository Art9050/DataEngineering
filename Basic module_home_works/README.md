# домашки для базового модуля
---
### 8. Строки

[Check pass](https://github.com/Art9050/DataEngineering/blob/main/Basic%20module_home_works/Check_pass.py)

##### Задание 3
Пароль считается надежным, если его длина составляет не менее 12 символов, при этом он должен содержать хотя бы одну заглавную букву, хотя бы одну строчную букву, хотя бы одну цифру и хотя бы один спецсимвол. Напишите код, который обрабатывает строковые данные и выводит сообщение о том, надежен ли пароль или нет. В случае, если пароль не надежен, код должен выдавать рекомендации для усиления надежности пароля.

Примечание: Цифры, которые можно использовать для пароля: '1234567890' Строчные буквы, которые можно использовать для пароля: 'abcdefghijklmnopqrstuvwxyz' Заглавные буквы, которые можно использовать для пароля: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' Спецсимволы, которые можно использовать для пароля: '!@#$%^&*()-+'

Подставьте "Входные данные" в свою программу и сравните результат с выходными данными.

1) Входные данные: 'qwerty'.
>Выходные данные: 'Слабый пароль. Рекомендации: увеличить число символов - 6, добавить 1 заглавную букву, добавить 1 цифру, добавить 1 спецсимвол '
2) Входные данные: 'Qwert_Y'.
>Выходные данные: 'Ошибка. Запрещенный спецсимвол'
3) Входные данные: 'Q123wer123tY'.
>Выходные данные: 'Слабый пароль. Рекомендации: добавить 1 спецсимвол'
4) Входные данные: '@PowerRangers123@'.
>Выходные данные: 'Сильный пароль.'
---
### 17. Регулярные выражения
##### Итоговый проект

[Final Project](https://github.com/Art9050/DataEngineering/blob/main/Basic%20module_home_works/final_project.py "Необязательная подсказка")

Для выполнения данного упражнения вам необходимо использовать некоторые программы из предыдущих упражнений.
Вам нужно написать программу, которая будет читать файл из предыдущего упражнения, заниматься его чисткой, формировать почтовые адреса для сотрудников, генерировать пароли безопасности для входа в почту, заносить информацию в этот файл и перезаписывать его.

1. Вы можете использовать предыдущие наработки
2. Ваша программа должна очистить файл от всех невалидных данных (строки с пустыми данными, некорректными именами, некорректными телефонами и городами)
3. При очистке исходного файла, все невалидные данные должны удаляться из него и сохраняться в отдельный текстовый файл
4. Поиск информации в файле должен осуществляться с помощью регулярных выражений
5. Разрешается использовать готовую функцию формирования почтового адреса или написать свою
6. Сгенерированные пароли должны заноситься в исходный файл в отдельный столбец "PASSWORD"
