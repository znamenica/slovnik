# language: ru
@dictum @controller
@wip
Свойство: Правач твьрꙉенјев
   Предыстория:
      * є значение сѫ даными:
         | id           | 200001 |
         | tag_ids      | []     |
         | article_ids  | []     |
      * є ѧзык сѫ даными:
         | id           | 200001 |
         | code         | rus    |
         | meta         | {}     |
      * є азбука сѫ даными:
         | id           | 200001 |
         | code         | rus    |
         | meta         | {}     |
      * є словник сѫ даными:
         | id           | 200001                |
         | uri          | https://glosbe.com/en |
         | meta         | {}                    |
      * є граматика сѫ даными:
         | id              | 200001 |
         | language_id     | 200001 |
         | alphabeth_id    | 200001 |
         | dictionary_id   | 200001 |
         | meta            | {}     |
      * є чланък сѫ даными:
         | id           | 200001    |
         | meaning_id   | 200001    |
         | grammar_id   | 200001    |
         | token_ids    | [1]       |
         | tag_ids      | [2]       |
         | separators   | ['-']     |
         | kind         | regular   |
         | meta         | {}        |
      * є твьрꙉение сѫ даными:
         | id              | 200001    |
         | text            | Текст     |
         | language_id     | 200001    |
         | alphabeth_id    | 200001    |
         | dictumable_id   | 200001    |
         | dictumable_type | Article   |
         | type            | Sentence  |
      * є користник сѫ прѣзвищем 'user' и токеном

   @json @create
   Пример: Користник створяє твьрꙉенје
      Если є створение твьрꙉенја сѫ даными:
         | id              | 200002    |
         | text            | Текст     |
         | language_id     | 200001    |
         | alphabeth_id    | 200001    |
         | dictumable_id   | 200001    |
         | dictumable_type | Article   |
         | type            | Name      |
      И послѣдня изнаходь твьрꙉенја бѫдє яко:
         """
         ---
         id: 200002
         text: Текст
         language_id: 200001
         alphabeth_id: 200001
         dictumable_id: 200001
         dictumable_type: Article
         type: Name
         """

   @json @update
   Пример: Користник поновяє дане твьрꙉенја
      Если запытам одсланје твьрꙉенја во изнаходь "/s/200001.json" сѫ даными:
         | text            | Текст 1   |
         | language_id     | 200001    |
         | alphabeth_id    | 200001    |
         | dictumable_id   | 200001    |
         | dictumable_type | Article   |
         | type            | Title     |
      То добѫдѫ кодъ поврата "200"
      Если запытам добыванје из изнаходи "/s/200001.json"
      То добѫдѫ кодъ поврата "200"
      И добѫдѫ вывод:
         """
         ---
         id: 200001
         text: Текст 1
         language_id: 200001
         alphabeth_id: 200001
         dictumable_id: 200001
         dictumable_type: Article
         type: Title
         """

   @json @get
   Пример: Користник добыває дане твьрꙉенја
      Если запытам добыванје из изнаходи "/s/200001.json"
      То добѫдѫ вывод:
         """
         ---
         id: 200001
         text: Текст
         language_id: 200001
         alphabeth_id: 200001
         dictumable_id: 200001
         dictumable_type: Article
         type: Sentence
         """

   @json @index
   Пример: Користник добыває списъ твьрꙉенјев
      Если запытам добыванје из изнаходи "/s.json"
      То добѫдѫ вывод:
         """
         ---
         list:
          - id: 200001
            text: Текст
            language_id: 200001
            alphabeth_id: 200001
            dictumable_id: 200001
            dictumable_type: Article
            type: Sentence
         total: 1
         """

   @json @delete
   Пример: Користник изтьрає иззначене твьрꙉенја
      Если запытам изтрѣнје изнаходи "/s/200001.json"
      То добѫдѫ кодъ поврата "200"
      И твьрꙉение сѫ озом "200001" не будє єствовати
