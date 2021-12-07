# Для базы данных издательства написать следующие запросы:
USE Publishing;

# 1. Вывести информацию обо всех книгах, в имени которых больше 4-х слов.
SELECT NameBook, T.NameTheme, A.FirstName, A.LastName
FROM Books
         JOIN Themes T ON T.ID_THEME = Books.ID_THEME
         JOIN Authors A ON A.ID_AUTHOR = Books.ID_AUTHOR
WHERE NameBook LIKE '% % % % %';

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
# Использовать внутренние запросы
SELECT NameTheme, NameBook, Pages
FROM Books
         JOIN Themes T ON T.ID_THEME = Books.ID_THEME
WHERE Pages = (SELECT MAX(Pages)
               FROM Books
                        JOIN Themes T2 ON T2.ID_THEME = Books.ID_THEME
               WHERE NameTheme = 'Computer Science');

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
SELECT ID_SALE, Price, Quantity, NameShop, NameCountry
FROM Sales
         JOIN Shops S ON S.ID_SHOP = Sales.ID_SHOP
         JOIN Country C ON C.ID_COUNTRY = S.ID_COUNTRY
ORDER BY NameCountry, NameShop DESC;

# 8. Создать запрос, показывающий самую популярную книгу
# Использовать внутренние запросы

SELECT NameBook, Quantity
FROM Sales
         JOIN Books B ON B.ID_BOOK = Sales.ID_BOOK
WHERE Quantity = (SELECT MAX(Quantity) FROM Sales);

# 9. Создать временную таблицу, в которой предоставляется информация об авторах, имена которых начинаются с А или В.
CREATE TEMPORARY TABLE authorsAOrB
SELECT *
FROM Authors
WHERE FirstName LIKE 'A%'
   OR FirstName LIKE 'B%';

SELECT *
FROM authorsAOrB;
