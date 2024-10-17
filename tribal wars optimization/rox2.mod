/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Bartek
 * Creation Date: 20 Sep 2024 at 13:04:55
 *********************************************/
using CP;


int limit_zel = 250;
int limit_dre = 232;
int limit_ceg = 270;

dvar int czy_upgrade_drewna;
dvar int czy_upgrade_zelaza;
dvar int czy_upgrade_cegly;


/**
chcemy 164k drewna
chcemy 190k gliny
chcemy 175k zelaza
**/
dvar int+ czas;

dexpr float ilosc_zel = 0 + czas*(1.3 + 0.18*czy_upgrade_zelaza)+ 3.4*czas/2 - czy_upgrade_zelaza*5 - czy_upgrade_drewna*9.5 - czy_upgrade_cegly*8.6;
dexpr float ilosc_dre = 0 + czas*(2.9 + 0.40*czy_upgrade_drewna)+ 3.4*czas/2- czy_upgrade_zelaza*6.7 - czy_upgrade_drewna*13.2 - czy_upgrade_cegly*25.5;
dexpr float ilosc_ceg = 0 + czas*(2.9 + 0.40*czy_upgrade_cegly)+ 3.4*czas/2- czy_upgrade_zelaza*8.3 - czy_upgrade_drewna*26 - czy_upgrade_cegly*17.8;
minimize czas; 


subject to {
  ilosc_zel >= limit_zel;
  ilosc_dre >= limit_dre;
  ilosc_ceg >= limit_ceg;
  
  czy_upgrade_drewna >=0;
  czy_upgrade_zelaza >=0;
  czy_upgrade_cegly >=0;
  
  czy_upgrade_drewna<=2;
  czy_upgrade_zelaza <=2;
  czy_upgrade_cegly <=2;
  
  /**
  3.400 kazdego za 2h
  **/
}