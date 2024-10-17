using CP;
// Definicja wymiarów planszy
int b_h = 5; // wysokość planszy
int b_w = 5; // szerokość planszy

// Definicja zmiennych decyzyjnych
dvar boolean x[1..b_h][1..b_w][1..9]; // x[i][j][k], gdzie k jest w zakresie od 1 do 9

// Zdefiniowanie zbioru wszystkich wskazówek poziomych
tuple HorizontalClue {
    int Ch; // Wartość wskazówki poziomej
    int i;  // Indeks wiersza wskazówki poziomej
    int j;  // Indeks kolumny wskazówki poziomej
    int lpc; // Liczba całkowita sumy wskazówki poziomej
    int hub;  // Górna granica pozioma
    int hlb;  // Dolna granica pozioma
}

{HorizontalClue} horizontalClues = {
	<4, 2, 1, 4, 3, 1>, 
    <30, 3, 1, 30, 5, 1>, 
    <19, 4, 1, 19, 5, 1>,
    <4, 5, 3, 4, 5, 1>
};

// Zdefiniowanie zbioru wszystkich wskazówek pionowych
tuple VerticalClue {
    int Cv; // Wartość wskazówki pionowej
    int i;  // Indeks wiersza wskazówki pionowej
    int j;  // Indeks kolumny wskazówki pionowej
    int lpc; // Liczba całkowita sumy wskazówki pionowej
    int vub;  // Górna granica pionowa
    int vlb;  // Dolna granica pionowa
}

{VerticalClue} verticalClues = {
    <19, 1, 2, 19, 5, 1>, 
    <18, 1, 3, 18, 5, 1>,   
    <9, 2, 4, 9, 5, 1>,
    <11, 2,5, 11, 5, 1>
};

// Zbiór początkowo pustych komórek
tuple coord {
    int i;
    int j;
}

// otwarte komorki
{coord} E = {
    <2,2>,<2,3>,
    <3,2>,<3,3>,<3,4>,<3,5>,
    <4,2>,<4,3>,<4,4>,<4,5>,
    <5,4>,<5,5>
};
// zablokowane komorki
{coord} P = {
  <1,1>, <1,2>, <1,3>, <1,4>, <1,5>,
  <2,1>, <2,4>, <2,5>,
  <3,1>,
  <4,1>,
  <5,1>, <5,2>, <5,3>
};

// Ograniczenia
subject to {
    // Ograniczenie (1): Co najwyżej jedno wystąpienie każdej liczby w każdej wskazówce poziomej
    forall(hc in horizontalClues) {
        forall(k in 1..9)
            sum(j in 1..b_w) x[hc.i][j][k] <= 1;
    }
    // Ograniczenie (2): Suma liczb równa się wartości wskazówki poziomej dla każdej wskazówki poziomej
    forall(hc in horizontalClues) {
        sum(j in hc.hlb..hc.hub, k in 1..9) x[hc.i][j][k] * k == hc.Ch;
    }
    
    // Ograniczenie (3): Co najwyżej jedno wystąpienie każdej liczby w każdej wskazówce pionowej
    forall(vc in verticalClues) {
        forall(k in 1..9)
            sum(i in 1..b_h) x[i][vc.j][k] <= 1;
    }
    // Ograniczenie (4): Suma liczb równa się wartości wskazówki pionowej dla każdej wskazówki pionowej
    forall(vc in verticalClues) {
        sum(i in vc.vlb..vc.vub, k in 1..9) x[i][vc.j][k] * k == vc.Cv;
    }
    
    // Ograniczenie (5): Każda początkowo pusta komórka musi być wypełniona dokładnie raz
    forall(e in E)
        sum(k in 1..9) x[e.i][e.j][k] == 1;
    
    // Ograniczenie (6): Każda początkowo zablokowana komórka nie może zostać wypełniona
    forall(e in P)
      sum(k in 1..9) x[e.i][e.j][k] == 0;
      
}
