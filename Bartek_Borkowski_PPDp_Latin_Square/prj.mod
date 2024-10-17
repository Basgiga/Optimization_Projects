/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Bartek
 * Creation Date: 15 kwi 2024 at 20:06:44
 *********************************************/
 using CP;

/**
 int n = 8;
 
 range N = 1..n;
 
 int Z[1..8] = [1,2,3,4,5,6,7,8];
 
  **/
 
 int n = ...;
 range N = 1..n;
 int R[N][N] = ...;
 
 dvar int+ x[N][N];
 
 subject to{
   
   forall(i in N, j in N ){
      1 <= x[i][j] <=n; //ograniczenie liczby
   }
 
	forall(i in N){
    	forall(j1 in N, j2 in N: j1 < j2){ // zasada wierszy
        	x[i][j1] != x[i][j2];
    	}		
	}
	
   	forall(i in N){
    	forall(j1 in N, j2 in N: j1 < j2){ // zasada kolumn
        	x[j1][i] != x[j2][i];
    	}		
	}
	
	
	forall(i in N, j in N){
	  if(R[i][j] != 0)(x[i][j] == R[i][j]);
	};
	
	/**
	forall(i in N){
     sum(j in N) x[i][j] == 36; // zasada sumy dla wierszy
   }
   
   forall(j in N){
     sum(i in N) x[i][j] == 36; // zasada sumy dla kolumn
   }
	**/

}