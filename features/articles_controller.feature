# language: ru
@article @controller
@wip
Свойство: Правач чланъков
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
      * є користник сѫ прѣзвищем 'user' и токеном

   @json @create
   Пример: Користник створяє чланъкъ
      Если є створение чланка сѫ даными:
         | id           | 200002       |
         | meaning_id   | 200001       |
         | grammar_id   | 200001       |
         | token_ids    | [2]          |
         | tag_ids      | [1]          |
         | separators   | ['_']        |
         | kind         | idiom        |
         | meta         | {data: "1"}  |
      И послѣдня изнаходь чланка бѫдє яко:
         """
         ---
         id: 200002
         meaning_id: 200001
         grammar_id: 200001
         token_ids: [2]
         tag_ids: [1]
         separators: ['_']
         kind: idiom
         meta: {data: "1"}
         """

   @json @update
   Пример: Користник поновяє дане чланка
      Если запытам одсланје чланка во изнаходь "/c/200001.json" сѫ даными:
         | meaning_id   | 200001       |
         | grammar_id   | 200001       |
         | token_ids    | [2]          |
         | tag_ids      | [1]          |
         | separators   | ['_']        |
         | kind         | idiom        |
         | meta         | {}           |
      То добѫдѫ кодъ поврата "200"
      Если запытам добыванје из изнаходи "/c/200001.json"
      То добѫдѫ кодъ поврата "200"
      И добѫдѫ вывод:
         """
         ---
         id: 200001
         meaning_id: 200001
         grammar_id: 200001
         token_ids: [2]
         tag_ids: [1]
         separators: ['_']
         kind: idiom
         meta: {}
         """

   @json @get
   Пример: Користник добыває дане чланка
      Если запытам добыванје из изнаходи "/c/200001.json"
      То добѫдѫ вывод:
         """
         ---
         id: 200001
         meaning_id: 200001
         grammar_id: 200001
         token_ids: [1]
         tag_ids: [2]
         separators: ['-']
         kind: regular
         meta: {}
         """

   @json @index
   Пример: Користник добыває списъ чланков
      Если запытам добыванје из изнаходи "/c.json"
      То добѫдѫ вывод:
         """
         ---
         list:
          - id: 200001
            meaning_id: 200001
            grammar_id: 200001
            token_ids: [1]
            tag_ids: [2]
            separators: ['-']
            kind: regular
            meta: {}
         total: 1
         """

   @json @delete
   Пример: Користник изтьрає иззначене чланка
      Если запытам изтрѣнје изнаходи "/c/200001.json"
      То добѫдѫ кодъ поврата "200"
      И чланък сѫ озом "200001" не будє єствовати
