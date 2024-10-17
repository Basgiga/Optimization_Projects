import random
import math
import copy
import time

def inicjacja_kwadratu(dlugosc, przedzial):
    kwadrat = [[0 for i in range(dlugosc)] for j in range(dlugosc)]
    zarezerwowany_spot = [[0 for i in range(dlugosc)] for j in range(dlugosc)]
    mozliwosc = list(range(dlugosc))
    mozliwosc = [x + 1 for x in mozliwosc]
    print(mozliwosc)

    czy_input = input("Czy chcesz wpisać liczby startowe do latin square? y/n\n")
    if(czy_input == 'y'):
        ile = input('Podaj ile cyfr chcesz wpisać\n')
        for i in range(int(ile)):
            print(f'{i+1} cyfra:\n')

            x = int(input(f'Podaj kolumne, cyfry którą chcesz wpisać:\n'))
            while(x not in mozliwosc):
                print("BLAD: podano nieprawdidlowy numer kolumny\n")
                x = int(input(f'Podaj kolumne cyfry, którą chcesz wpisać:\n'))
            y = int(input(f'Podaj wiersz cyfry, którą chcesz wpisać:\n'))
            while (y not in mozliwosc):
                print("BLAD: podano nieprawdidlowy numer wiersza\n")
                y = int(input(f'Podaj wiersz cyfry, którą chcesz wpisać:\n'))
            c = int(input(f'\nPodaj cyfre, którą chcesz wpisać:\n'))
            while (c not in przedzial):
                print("BLAD: cyfra ktora podales nie miesci sie we wcześniej podanym przedziale\n")
                c = int(input(f'Podaj cyfre, którą chcesz wpisać:\n'))
            kwadrat[y-1][x-1] = c
            zarezerwowany_spot[y-1][x-1] = c

    print(f'\ntwoj kwadrat:\n')
    for line in kwadrat:
        print(line)
    return kwadrat, zarezerwowany_spot

def tabu_search(kwadrat, przedzial, zarezerwowane_spoty, tabu_size=5, iteracje=1000):

    def f_energi(kwadrat):
        wartosc_f = 0

        # kolumny
        for i in range(len(kwadrat)):
            for j in range(len(kwadrat)):
                for k in range(j + 1, len(kwadrat)):
                    if kwadrat[i][j] == kwadrat[i][k]:
                        wartosc_f += 1
        # wiersze
        for j in range(len(kwadrat)):
            for i in range(len(kwadrat)):
                for k in range(i + 1, len(kwadrat)):
                    if kwadrat[i][j] == kwadrat[k][j]:
                        wartosc_f += 1
        return wartosc_f

    def f_startowa(kwadrat, przedzial):
        for i in range(len(kwadrat)):
            dostepne_cyfry = set(przedzial) - set([kwadrat[i][j] for j in range(len(kwadrat)) if kwadrat[i][j] != 0])
            dostepne_cyfry = list(dostepne_cyfry)
            random.shuffle(dostepne_cyfry)
            for j in range(len(kwadrat)):
                if kwadrat[i][j] == 0:
                    kwadrat[i][j] = dostepne_cyfry.pop(0)
        return kwadrat

    def f_kandydatow(kwadrat, tabu_list):
        def zamien_wiersz(kwadrat):
            i = random.randint(0, len(kwadrat) - 1)
            j, k = random.sample(range(len(kwadrat)), 2)
            while (kwadrat[i][j] == zarezerwowane_spoty[i][j] or kwadrat[i][k] == zarezerwowane_spoty[i][k]):
                i = random.randint(0, len(kwadrat) - 1)
                j, k = random.sample(range(len(kwadrat)), 2)
            kwadrat[i][j], kwadrat[i][k] = kwadrat[i][k], kwadrat[i][j]
            return i, j, k  # Zwracamy ruch

        def zamien_kolumne(kwadrat):
            j = random.randint(0, len(kwadrat) - 1)
            i, k = random.sample(range(len(kwadrat)), 2)
            while (kwadrat[i][j] == zarezerwowane_spoty[i][j] or kwadrat[k][j] == zarezerwowane_spoty[k][j]):
                j = random.randint(0, len(kwadrat) - 1)
                i, k = random.sample(range(len(kwadrat)), 2)
            kwadrat[i][j], kwadrat[k][j] = kwadrat[k][j], kwadrat[i][j]
            return i, j, k  # Zwracamy ruch

        # Generowanie kandydatów z uwzględnieniem tabu_list
        while True:
            if random.random() < 0.5:
                ruch = zamien_wiersz(kwadrat)
            else:
                ruch = zamien_kolumne(kwadrat)

            # Sprawdzamy, czy ruch jest dozwolony (nie ma go na liście tabu)
            if ruch not in tabu_list:
                return kwadrat, ruch

    def tabu_search_czesc_glowna(kwadrat, przedzial, tabu_size):
        kwadrat1 = f_startowa(kwadrat, przedzial)
        E = f_energi(kwadrat1)
        najlepsze_rozwiazanie = copy.deepcopy(kwadrat1)
        najlepsza_energia = E
        tabu_list = []

        for _ in range(iteracje):
            kwadrat_nowy, ruch = f_kandydatow(copy.deepcopy(kwadrat1), tabu_list)
            E_nowy = f_energi(kwadrat_nowy)

            if E_nowy < najlepsza_energia or not any(f_energi(f_kandydatow(copy.deepcopy(kwadrat1), tabu_list)[0]) < E_nowy for _ in range(10)):
                kwadrat1 = kwadrat_nowy
                E = E_nowy

                if E < najlepsza_energia:
                    najlepsze_rozwiazanie = copy.deepcopy(kwadrat1)
                    najlepsza_energia = E

                tabu_list.append(ruch)
                if len(tabu_list) > tabu_size:
                    tabu_list.pop(0)

        return najlepsze_rozwiazanie

    najlepsze_rozwiazanie = tabu_search_czesc_glowna(kwadrat, przedzial, tabu_size)
    print(f'\ntwoj kwadrat:\n')
    for line in kwadrat:
        print(line)

    print(f'\ntwoj wypelniony kwadrat, f_energi(najlepsze_rozwiazanie): {f_energi(najlepsze_rozwiazanie)}:\n')
    for line in najlepsze_rozwiazanie:
        print(line)

dlugosc = 4
przedzial = [1, 2, 3, 4]

kwadrat, zarezerwowane_spoty = inicjacja_kwadratu(dlugosc, przedzial)
start = time.time()
wynik = tabu_search(kwadrat, przedzial, zarezerwowane_spoty, tabu_size=5, iteracje=1000)
koniec = time.time()

print(f'\nWykonano w {koniec - start}')