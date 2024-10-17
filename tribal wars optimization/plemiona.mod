/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Bartek
 * Creation Date: 19 Jul 2024 at 12:56:29
 *********************************************/

using CP;


 dvar int+ p0; // pikinierzy do amatorzy
 dvar int+ p1; // pikinierzy do cilaczy
 dvar int+ p2; //pikinierzy do zbieraczy
 dvar int+ m0;
 dvar int+ m1; // miecznicy do ciulaczy
 dvar int+ m2; // itd ...
 dvar int+ t0;
 dvar int+ t1;
 dvar int+ t2;
 dvar int+ p3;
 dvar int+ t3;
 dvar int+ m3;
 
 //dvar int+ k0;
 //dvar int+ k1;
 //dvar int+ k2;
 
 int czas = 8497;

// (p0*25 + m0*15 + t0*10) to waga amatorow
// (p1*25 + m1*15 + t1*10) to waga ciulaczy
// (p2*25 + m2*15 + t2*10) to waga zbieraczy

dexpr float c0 = 1273 /** czas startowy dla zbieractwa minimalnego (waga 100) **/ + ((((p0*25 + m0*15 + t0*10) -100)/10)*3 /** ta trojka oznacza ile sekund dodaje 10 wagi **/);
dexpr float c1 = 1328 + ((((p1*25 + m1*15 + t1*10) -100)/10)*8);
dexpr float c2 = 1413 + ((((p2*25 + m2*15 + t2*10) -100)/10)*15); // to sa czasy dla konkretnego zbieractwa
dexpr float c3 = 1494 + ((((p3*25 + m3*15 + t3*10) -100)/10)*20);
// c za to jest suma zebranych surowcow
dexpr float c = (p0*25 + m0*15 + t0*10)*0.1 + (p1*25 + m1*15 + t1*10)*0.25 + (p2*25 + m2*15 + t2*10)*0.5 +(p3*25 + m3*15 + t3*10)*0.75; // 0.25 to Ciulacze, 0.5 to zbieraczne
maximize c;
 
 subject to {
   p0+p1+p2+p3 <=720; //+4; // ile pikinierow
   m0+m1+m2+m3 <=80; // ile miecznikow
   t0+t1+t2+t3 <=198; //ile topornikow
   //k0+k1+k2 <= 7;
   
   //p0+m0+t0 >=10; //conajmniej 10 typkow na ekspedycje
   //p1+m1+t1 >= 10; // conajmniej 10 typkow na ekspedycje
   //p2+m2+t2 >= 10; // conajmniej 10 typkow na ekspedycje
   
   
   // wylaczenie cyfry (np. 2):
   //p2 == 0;
   //t2 == 0;
   //m2 == 0;
   
   c0 <= czas;
   c1 <= czas; //limit 50 min (3000 sekund = 50 min)
   c2 <= czas; //limit 50 min (3000 sekund = 50 min)
   c3 <= czas;
   
	//10800
	//107 = 1142.5
	//55 + 55 = 771.25 + 771.25 ~~ 1540
	//60 + 47 = 806 + 614 ~~ 1400
	//60+40 = 743 + 460 ~~ 1150
	//
	//130 = 1467
	//65+65 = 1005+1005 ~~ 2010
	//45+45+45 = 646 * 3 ~~ 1950
	//
	//145 = 1700
	//73+73 =  1173+1173 ~~ 2350  (czas =4380)
	//50+50+50= 790+790+790 ~2330
	//
	//
	//
	//175 = 2117
	//90+90 =  1500 + 1500 = 3000
	//60 + 60 + 60 = 1071 *3 ~~ 3250
	//
	//
	// 222 = 3000
	// 
	//
	//
	//
	
	//ROXY
	//118 = 1300
	//60+60 = 885*2 = 1770
	
	//KAMIL
	//
	//
	//66 = 562
	//33+33 = 230*2
	//
	//
	//
	//142 = 1637
	//71+71 = 1130+1130 = 2260
	//
	//190 = 2450
	//
	//
	// 
	
	
	
	
 }
 