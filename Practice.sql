# Для базы данных издательства написать следующие запросы:
USE Publishing;

# 1. Вывести информацию обо всех книгах, в имени которых больше 4-х слов.
SELECT NameBook, T.NameTheme, A.FirstName, A.LastName
FROM Books
         JOIN Themes T ON T.ID_THEME = Books.ID_THEME
         JOIN Authors A ON A.ID_AUTHOR = Books.ID_AUTHOR
WHERE ((LENGTH(NameBook) - LENGTH(REPLACE(NameBook, ' ', '')) + 1) > 4);

# 2. Показать количество авторов в базе данных. Результат сохранить в другую таблицу.
CREATE TEMPORARY TABLE tmpAuthors
SELECT COUNT(*)
FROM Authors;

SELECT *
FROM tmpAuthors;

# 3. Показать среднеарифметическую цену продажи всех книг. Результат сохранить в временную таблицу.
CREATE TEMPORARY TABLE avgPriceBook
SELECT AVG(Price)
FROM Sales;

SELECT *
FROM avgPriceBook;

# 4. Вывести информацию о книгах по «Computer Science» с наибольшим количеством страниц.
SELECT NameTheme, NameBook, MAX(Pages)
FROM Books
         JOIN Themes T ON T.ID_THEME = Books.ID_THEME
GROUP BY NameTheme;

# 5. Показать на экран сумму страниц по каждой из тематик, при этом учитывать только книги одной из следующих тематик: «Computer
# Science», «Science Fiction», «Web Development» и с количеством страниц более 300.
SELECT NameTheme, NameBook, SUM(Pages)
FROM Books
         JOIN Themes T ON T.ID_THEME = Books.ID_THEME
WHERE NameTheme IN ('Computer Science', 'Science Fiction', 'Web Development')
GROUP BY NameTheme;

# 6. Создать временную таблицу, содержащую самую дорогую книгу тематики, например, «Web Technologies».
CREATE TEMPORARY TABLE maxPriceInTheme
SELECT NameTheme, NameBook, MAX(Price)
FROM Books
         JOIN Themes T ON T.ID_THEME = Books.ID_THEME
WHERE T.NameTheme = 'Web Development'
GROUP BY NameTheme;

SELECT *
FROM maxPriceInTheme;

# 7. Создать запрос, который позволяет вывести всю информацию о
# работе магазинов. Отсортировать выборку по странам в возрастающем и по названиям магазинов в убывающем порядке.


# 8. Создать запрос, показывающий самую популярную книгу
# 9. Создать временную таблицу, в которой предоставляется информация об авторах, имена которых начинаются с А или В.

