/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Bartek
 * Creation Date: 28 kwi 2024 at 11:57:39
 *********************************************/
/**
//zadanie 1 (euklides plus koszt)
int L = 4;
int K = 5;
int P = 2;


int L_xy[1..L][1..2] = 
[
[3,3],
[5,5],
[7,7],
[5,6]
];

int K_xy[1..K][1..2]=
[
[3,2],
[2,3],
[5,6],
[7,8],
[6,6]
];

int C[1..L] = [1,2,3,99999];
int V = 7;

dvar boolean x[1..2][1..L];
dvar float c;

minimize c;

subject to {
  
  forall(i in 1..2){
    sum(j in 1..L) x[i][j] == 1;
  }
  
  forall(i in 1..L){
    sum(j in 1..2) x[j][i] <=1;
  }
  
  c >= sum(i in 1..P, j in 1..L)min(k in 1..K) sqrt(pow(L_xy[j][1] - K_xy[k][1],2) + pow(L_xy[j][1]- K_xy[k][2],2)) *x[i][j];
  

   sum(i in 1..P, j in 1..L) x[i][j]*C[j] <= V;
}

**/

/**
// zadanie 2 (euklides przypisany, mini sum max)
int L = 3;
int K = 4;
int P = 2;

range doP  = 1..P;
range doK = 1..K;
range doL = 1..L;

float L_xy[doL][doP] = [[2,6],[1,2],[3,3]];
float K_xy[1..2][doP][1..2] = [
								[[1,3],[2,3]],
								[[2,5.3],[3.4,3]]
							];	

dvar boolean x[doP][doL];
dvar float c;

minimize c;

subject to
{
  forall(i in doP){
    sum(j in doL)(x[i][j]) == 1;
  };
  forall(i in doL){
    sum(j in doP)(x[j][i]) <=1;
  };
  
  forall (m in 1..2){
  c >= sum(p in doP, l in doL)max(k in 1..2)
  (sqrt(pow(L_xy[l][1] - K_xy[k][1][m],2) + pow(L_xy[l][2] - K_xy[k][2][m],2))*x[p][l]);
	}  
}
**/


/**

//zadanie 3 (euklides przypisany z mini max)

int L = 3;
int K = 4;
int P = 2;

range doP  = 1..P;
range doK = 1..K;
range doL = 1..L;

float L_xy[doL][doP] = [[3.4,5.3],[1,2],[3,3]];
float K_xy[1..2][doP][1..2] = [
								[[1,3],[2,3]],
								[[2,5.3],[3.4,3]]
							];	

dvar boolean x[doP][doL];
dvar float c;

minimize c;

subject to
{
  forall(i in doP){
    sum(j in doL)(x[i][j]) == 1;
  };
  forall(i in doL){
    sum(j in doP)(x[j][i]) <=1;
  };
  
  forall (m in 1..2){
  c >= max(p in doP, l in doL)max(k in 1..2)
  (sqrt(pow(L_xy[l][1] - K_xy[k][1][m],2) + pow(L_xy[l][2] - K_xy[k][2][m],2))*x[p][l]);
	}  
}
**/


/**

//zadanie 4 (maszyny)
 int P = 5;
 int M = 3;
 
 
 int p_czas[1..P] = [1,2,4,5,3];
 
 dvar boolean x[1..P][1..M];
 
 dvar float c;
 
 minimize c;
 
 subject to {
   
   forall(p in 1..P){
     sum(m in 1..M) x[p][m] == 1;
   }
   
   forall(m in 1..M){
   		c >= sum(p in 1..P) x[p][m] * p_czas[p];
   
 }
} 

**/


/**

//zadanie 1 (sshort path)
int V=6;
int start = 1;
int koniec = 3;

int odl[1..V][1..V] = [
[99,3,99,99,99,99],
[3,99,99,1,10,99],
[99,99,99,99,99,7],
[99,1,99,99,5,8],
[99,10,99,5,99,99],
[99,99,7,8,99,99]
];


dvar boolean x[1..V][1..V];

dexpr int c = sum(i in 1..V, j in 1..V) x[i][j] * odl[i][j];

minimize c;
 
 subject to {
   
   forall(i in 1..V){
     sum(j in 1..V)(x[i][j]) <= 1; // jeden w pionie
   };
   
   forall(j in 1..V){
     sum(i in 1..V)(x[i][j]) <= 1; // jeden w pozomie
   };
   
   forall(i in 1..V){
     sum(i in 1..V)(x[i][i]) == 0; // po przekatnej same zera
   };
   
   forall(i in 1..V, j in 1..V){
     x[i][j] + x[j][i] <=1;     // musza byc albo zera albo jedynki polaczen
   };
   
   sum(j in 1..V)(x[start][j]) == 1; // jedno polaczenie od startu
   sum(i in 1..V)(x[i][koniec]) == 1; // jedno polaczenie do konca
   
   
   forall ( i in 1..V : i not in {start, koniec}){
     sum(j in 1..V)(x[i][j]) == sum(j in 1..V)(x[j][i]); // polaczenia pomiedzy startem i koncem
   };
   
}	

**/


/**

// zadanie 2 ( komiwo)
 int V = 6;
 
 int odl2[1..V][1..V] = [
 [99,1,1,1,1,1],
 [1,99,1,1,1,1],
 [1,1,99,1,1,1],
 [1,1,1,99,1,1],
 [1,1,1,1,99,1],
 [1,1,1,1,1,99]
 ];
 
 
  int odl[1..V][1..V] = [
 [99,1,7,1,8,1],
 [8,99,1,9,1,8],
 [7,1,99,1,7,9],
 [1,9,1,99,9,9],
 [8,1,7,9,99,1],
 [1,8,9,9,1,99]
 ];
 
 
 dvar boolean x[1..V][1..V];
 dvar float+ u[1..V];
 
 dexpr int c = sum(i in 1..V, j in 1..V) x[i][j] * odl[i][j];

 minimize c;
 
 subject to {
   
   forall( i in 1..V){
     sum(j in 1..V)(x[i][j]) == 1;
   };
   
   forall(j in 1..V){
     sum(i in 1..V)(x[i][j]) == 1;
   };
   
   forall(i in 1..V){
     sum(i in 1..V)(x[i][i]) == 0; // po przekatnej same zera
   };
   
   forall(i in 1..V, j in 1..V){
     x[i][j]+x[j][i] <=1;
   };
   
   forall ( i in 1..V){
     sum(j in 1..V)(x[i][j]) == sum(j in 1..V)(x[j][i]); // polaczenia pomiedzy startem i koncem
   };
   
   forall (i,j in 1..V : j != 1){
     	u[i] + x[i][j] <= u[j] + (V-1) * (1-x[i][j]) ;
     }
   u[1] == 0;
 } 
 **/
 
 
 
 /**
 
 // zadanie 3 (wegierski)
 
  int N = 3;
 int c_m = 3;
 
 int inne[1..N][1..c_m] =
 [
 [1,2,2],
 [4,6,3],
 [8,3,3]
 ];
 
 int koszt[1..N] = [8,6,1];
 int zysk[1..N] = [10,15,10];
 
 dvar int+ X[1..N];
 
 dexpr int c = sum(i in 1..N) X[i] * (zysk[i] - koszt[i]);
 
 maximize c;
 
 subject to
 {
   sum(i in 1..N) X[i] * inne[1][i] <= 24; // czas krotszy od 24 (lacznie)
   
   sum(i in 1..N) X[i] * inne[2][i] <= 101; // surowiec jeden <=101
   
   sum(i in 1..N) X[i] * inne[3][i] <= 100; // surowiec dwa <=100
  
 };
 
 **/
 
 
 /**

//zadanie 1 (szukanie w zbiorze)
int n = 2;
int Z[1..3*n] = [1,2,3,4,5,6];
int W = 11;

dvar boolean x[1..20][1..3*n];

minimize max(j in 1..3*n)sum(i in 1..20)x[i][j];

subject to {
  
  forall(i in 1..20){
    sum(j in 1..3*n)(x[i][j]*Z[j]) == W;
  };
  
  forall(i in 1..20){
    sum(j in 1..3*n)(x[i][j]) == 3;
  };
  
}

**/


/**
//zadanie 2 (z wypelnianiem prostokatami)
using CP;

//wymiary dużego prostokąta
int Wmax = 9; //szerokość
int Hmax = 10; //wysokość

int nR = 8; //ilość małych prostokątów
int R[1..nR][1..2] = [ //wymiary małych prostokątów
	[2,4],
	[7,4],
	[5,3],
	[3,3],
	[2,3],
	[4,6],
	[5,5],
	[10,10]
	];
	
dvar int+ x[1..nR] in 0..Wmax; //współrzędne x lewych dolnych wierzchołków prostokątów

dvar int+ y[1..nR] in 0..Hmax; //współrzędne y lewych dolnych wierzchołków prostokątów

dvar boolean X[1..nR]; //macierz wyboru

subject to{
  
  sum(i in 1..nR)X[i]*R[i][1]*R[i][2] == Wmax*Hmax;
  
  forall(i in 1..nR){
    (x[i] + R[i][1])*X[i] <= Wmax;
  };
  
  forall(i in 1..nR){
    (y[i] + R[i][2])*X[i] <= Hmax;
  }
  
  forall(i in 1..nR, j in 1..nR : i<j){
    x[i] + R[i][1] <= x[j] || x[j] + R[j][1] <= x[i] || y[i] + R[i][2] <= y[j] || y[j] + R[j][2] <= y[i];
  }
  
}
**/

/**

// zadanie 3

int n = 6; 
int p = 6; //liczba zbiorów

int G[1..n] = [1,2,3,4,5,6]; 

int Z[1..p][1..n] = [
	[1,1,0,0,0,0],
	[1,0,1,0,0,0],
	[0,1,1,0,0,0],
	[0,1,0,1,0,1],
	[0,0,1,0,1,1],
	[0,0,0,1,1,0]
	];

dvar boolean x[1..p];

minimize sum(i in 1..p)x[i];

subject to{
  forall(i in 1..n){
    sum(j in 1..p)x[j]*Z[j][i] >= 1;
  }
}

**/



/**
// zadanie 4 maszyny deadline/realease

using  CP;

int P = 5; //liczba zadań
range zadania = 1..P;

int M = 2; //liczba maszyn
range maszyny = 1..M;

int J[zadania][maszyny] = [
	[2,3],
	[4,2],
	[6,5],
	[3,4],
	[1,4]]; //czas realizacji

int K[zadania] = [1,1,1,1,1]; //release

int V[zadania] = [10,15,20,14,5]; //due

int O[maszyny]= [15,15]; //ograniczenia maszyn

dvar interval task[i in zadania] in K[i]..V[i];
dvar interval opttask[i in zadania][m in maszyny] optional size J[i][m];

dvar sequence tool[m in maszyny] in all(i in zadania) opttask[i][m];

minimize max(i in zadania)endOf(task[i]);

subject to{
  forall(m in maszyny){
    noOverlap(tool[m]);
  };
  
  forall(i in zadania){
    alternative(task[i], all(m in maszyny) opttask[i][m]);
  };
  
  forall(m in maszyny){
    sum(i in zadania)endOf(opttask[i][m]) <= O[m];
  }
}

**/





/**
//zad 1 z kolosow (maszyny ze skonczeniem zadaniem)
// zalozenie ze sortujemy po kolumnach momenty wykonywania zadan
int P[1..5] = [5,4,3,2,1];
int M = 3;

int czasy[1..5][1..M] = 
[
[1,1,1],
[1,1,1],
[1,1,1],
[1,1,1],
[1,2,3]
];

int v[1..M] = [1,1,1];

int skoncz[1..5] = [15,16,17,18,19];

dvar boolean x[1..5][1..M];
dvar int u[1..5];
dvar int+ c;

minimize c;

subject to {
  
 forall(i in 1..5){
   sum(j in 1..M) x[i][j] == 1;
	}
	
 c >= max(i in 1..M)sum(j in 1..5) czasy[j][i]*x[j][i];
		
 forall(i in 1..5){
   sum(j in 1..M) czasy[i][j]*x[i][j] <= skoncz[i];
 }
	
 forall(i in 1..M){
   forall(j in 1..5) {
     sum(k in 1..i) x[j][k]*czasy[j][k] <= v[i];
   }
 }

}

**/

/**
//zadanie 2 (euklides plus koszt)
int L = 4;
int K = 5;
int P = 2;


int L_xy[1..L][1..2] = 
[
[3,3],
[5,5],
[7,7],
[5,6]
];

int K_xy[1..K][1..2]=
[
[3,2],
[2,3],
[5,6],
[7,8],
[6,6]
];

int C[1..L] = [1,2,3,99999];
int V = 7;

dvar boolean x[1..2][1..L];
dvar float c;

minimize c;

subject to {
  
  forall(i in 1..2){
    sum(j in 1..L) x[i][j] == 1;
  }
  
  forall(i in 1..L){
    sum(j in 1..2) x[j][i] <=1;
  }
  
  c >= sum(i in 1..P, j in 1..L)min(k in 1..K) sqrt(pow(L_xy[j][1] - K_xy[k][1],2) + pow(L_xy[j][1]- K_xy[k][2],2)) *x[i][j];
  

   sum(i in 1..P, j in 1..L) x[i][j]*C[j] <= V;
}

**/

/**

// Zadanie 3 (plecaki)
int N=2;

int poj[1..N] = [10,10];

int mn[1..N] = [1,2];

int Z=5;
int ZB[1..Z] = [1,8,3,2,5];

dvar boolean x[1..N][1..5];
dvar int+ c;

minimize c;

subject to {
 
 forall(i in 1..5){
   sum(j in 1..N) x[j][i] <= 1;
 }
 
 forall(i in 1..N){
   sum(j in 1..Z) x[i][j]*mn[i]*ZB[j] <= poj[i];
 }
 
 c >= sum(i in 1..Z) ZB[i] - sum(i in 1..Z, j in 1..N)ZB[i]*x[j][i]; 
}

**/
