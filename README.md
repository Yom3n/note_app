# note_app

Simple note manager that let you read, create, edit and store notes in sql lite database


Rebuilding stubs for mockito:
flutter pub run  build_runner build --delete-conflicting-outputs



Zadanie

Do zaprogramowania jest aplikacja umożliwiająca tworzenie notatek przez użytkownika i zarządzanie nimi.


Baza danych

Notatki przechowywane są w bazie danych (SQLite).

Do obsługi polecana jest wtyczka: https://pub.dev/packages/sqflite

W aplikacji potrzebna będzie tylko jedna tabela, z kolumnami podanymi poniżej:

Nazwa kolumny

Typ

Opis

id

int

Identyfikator notatki

nazwa

text

Nazwa (temat) notatki

data

text

Data dodania notatki

tresc

text

Treść notatki

stan

int

Stan notatki

 

Pola wymagane:

    id
    nazwa
    data
    stan

 

Dostępne stany:

    0 - nowa notatka (w edycji)
    1 - notatka zatwierdzona
    2 - notatka zarchiwizowana 

W związku z istnieniem stanu 2, notatki nie są usuwane z bazy, tylko są archiwizowane.


Ekrany aplikacji

W aplikacji dostępne będą następujące ekrany:

    ekran główny z listą notatek
    ekran dodawania/edycji notatki

 
1.   Ekran główny

Na ekranie ekranie głównym powinna być widoczna:

    lista dostępnych notatek 
    przycisk umożliwiający dodanie notatki 
    dodatkowe pola umożliwiające filtrowanie notatek.


Lista notatek

Większość ekranu powinna zajmować lista dostępnych notatek.

Każdy wiersz listy powinien zawierać:

    pogrubioną nazwę notatki w pierwszej linii 
    datę dodania (w formacie, np. 2022-08-18 15:04) w drugiej linii 
    ikonę na końcu wiersza umożliwiającą zarchiwizowanie notatki

 

Dodatkowo wiersz powinien mieć tło w określonym kolorze:

    niebieski - jeśli notatka jest nowa (w edycji)

    zielony - jeśli notatka jest zatwierdzona
    czerwony - jeśli notatka jest zarchiwizowana

 

Dwukrotne kliknięcie wiersza z notatką powinno otworzyć ekran edycji wybranej notatki.


Filtrowanie

Aplikacja powinna obsługiwać następujące filtry:

    pole tekstowe do filtrowania po nazwie i treści (filtrujemy na bieżąco po wpisaniu znaku przez użytkownika, jednak filtrujemy dopiero po wpisaniu przynajmniej trzech znaków). Potrzebne jest jedno pole, które umożliwia szukanie na raz po nazwie i po treści.
    datePicker do wybrania daty, z której chcemy wyświetlić notatkę
    comboBox do wybrania stanu notatki (poza stanami dostępnymi w bazie powinna być dostępna także opcja umożliwiająca wyświetlanie notatek w dowolnym stanie, np. opcja “Wszystkie”)

 

Użytkownik może korzystać z dowolnej kombinacji filtrów (np. można wyświetlić wszystkie notatki z dziś w statusie ‘nowe’).

Domyślne ustawienie filtrów (czyli co aplikacja powinna wyświetlać po uruchomieniu):

    puste pole z nazwą/treścią
    datePicker ustawiony na dziś
    comboBox ustawione na “wszystkie”


Przycisk dodający nową notatkę

W AppBar albo we floating action button należy umieścić przycisk umożliwiający dodanie notatki.

Po jego wciśnięciu użytkownik powinien zostać przeniesiony na pusty ekran dodawania nowej notatki.


Archiwizacja notatki

Po wciśnięciu ikony w danym wierszu notatkę można zarchiwizować.

Przed zarchiwizować notatki należy wyświetlić użytkownikowi pytanie, czy chce zarchiwizować daną notatkę.

 

 
2.   Ekran dodawania/edycji notatki

Jest to ekran zawierający:

    pole tekstowe do wpisania nazwy (pole wymagane)
    pole tekstowe (kilka linii) do wpisania treści notatki
    informację o dacie utworzenia notatki (tylko w przypadku edycji)
    informację o stanie notatki (tylko w przypadku edycji)

Pola informacyjne nie są edytowalne.

W przypadku dodawania nowej notatki ekran powinien być pusty. W przypadku edycji istniejącej notatki - należy wstawić dane wybranej notatki.

Jeśli otworzona została notatka archiwalna, to oba pola powinny być niedostępne do edycji.

Zapis notatki możliwy jest tylko po wpisaniu wartości w wymagane pola (czyli nazwę). Jeśli pole jest puste, należy wyświetlić stosowny komunikat (sugerowane jest wyświetlenie komunikatu pod polem i oznaczenie pola na czerwono).

Identyfikator nowej notatki powinien zostać ustawiony według wzoru:

ilość notatek w bazie + 1

Czyli pierwsza notatka powinna mieć id ustawione na 1.

Data dodania powinna być ustawiona automatycznie na aktualną datę w czasie dodawania notatki.

Na ekranie powinny być dostępne dwa przyciski:

    jeden do zapisu
    drugi do archiwizacji notatki (ten przycisk dostępny jest tylko w przypadku notatki w stanie 0 lub 1). Po jego wciśnięciu powinno zostać wyświetlone pytanie czy użytkownik na pewno chce zarchiwizować notatkę.


Dodatkowe uwagi

Aplikację należy napisać stosując praktyki dobrego programowania (chodzi o wydajny i czytelny kod, a nie tylko o taki, który działa).

Aplikacja nie musi być piękna pod względem wizualnym. Istotne jest by była spójna i czytelna.

Wymagane jest napisanie testu integracyjnego, który doda nową notatkę.

Projektując aplikację należy zwrócić uwagę na to, by poprawnie się wyświetlała na różnych ekranach. Wystarczy, by się poprawnie skalowała, nie trzeba projektować różnych widoków.

Wskazane byłoby użycie bloca do zarządzania stanem aplikacji.

Wtyczka do bazy danych nie działa w przeglądarce, dlatego do testowania aplikacji niezbędny będzie emulator/urządzenie fizyczne.

Można korzystać z dodatkowych wtyczek wedle własnego uznania. 