# language: ru
@novelties @controller
@wip
Свойство: Правач новин
   Предыстория:
      * є буко
      * є новина сѫ даными:
         | id        | 100001             |
         | title     | Текст 1            |
         | text      | Текстовая строка   |
      * є користник сѫ прѣзвищем 'user' и токеном
      * є користник сѫ даными:
         | id        | 10000              |
         | email     | mylo@koristnika.ru |
         | password  | 1234567890         |
      * єсм приявєным

   Пример: Користник углѧдає списъ новин
      Пусть є новина сѫ даными:
         | title     | Текст 2      |
         | text      | Тесто сто    |
      Если посєчям странку "/news"
      То добѫдѫ кодъ поврата "200"
      И углѧдаѫ новину:
         """
         Текст 1
         Текстовая строка
         Текст 2
         Тесто сто
         """

   Пример: Користник углѧдає иззначену новину
      Если посєчям странку "/news/100001"
      То добѫдѫ кодъ поврата "200"
      И углѧдаѫ новину:
         """
         Текст 1
         Текстовая строка
         """

   Пример: Користник прави иззначену новину
      Если посєчям странку "/news/100001/edit"
      То добѫдѫ кодъ поврата "200"
      И углѧдаѫ новину:
         """
         Текст 1
         Текстовая строка
         """
      Если правим свою назву новине яко "Текст 2"
      И правим своє дане новине яко "Текстовая строка 2"
      И запишем форму правке
      То добѫдѫ кодъ поврата "200"
      И правке сѫчасне новине будꙛ єствовати яко:
         | title  | Текст 2            |
         | text   | Текстовая строка 2 |

   Пример: Користник изтьрає иззначену новину
      Если кушам изтрѣти странку "/news/100001"
      То добѫдѫ кодъ поврата "200"
      И новина сѫ озом "100001" не будє єствовати

   @json
   Пример: Користник створяє новину
      Если є створенје новине сѫ даными:
         | author_id | 10000              |
         | title     | Текст 3            |
         | text      | Текстовая строка 3 |
      И послѣдня изнаходь новине бѫдє яко:
         """
         ---
         title: Текст 3
         text: Текстовая строка 3
         """

   @json
   Пример: Користник поновяє дане
      Если сꙛ правке сѫчасне новине сѫ даными:
         | title  | Текст 2            |
         | text   | Текстовая строка 2 |
      И запытам добыванје из изнаходи "/news/100001.json"
      То добѫдѫ вывод:
         """
         ---
         id: 100001
         title: Текст 2
         text: Текстовая строка 2
         """

   @json
   Пример: Користник добыває дане новину
      Если запытам добыванје из изнаходи "/news/100001.json"
      То добѫдѫ вывод:
         """
         ---
         id: 100001
         title: Текст 1
         text: Текстовая строка
         """

   @json
   Пример: Користник добыває списъ даных
      Если запытам добыванје из изнаходи "/news.json"
      То добѫдѫ вывод:
         """
         ---
         list:
          - id: 100001
            title: Текст 1
            text: Текстовая строка
         total: 1
         """

   @json
   Пример: Користник изтьрає иззначену новину
      Если запытам изтрѣнје изнаходи "/news/100001.json"
      То добѫдѫ кодъ поврата "200"
      И новина сѫ озом "100001" не будє єствовати
