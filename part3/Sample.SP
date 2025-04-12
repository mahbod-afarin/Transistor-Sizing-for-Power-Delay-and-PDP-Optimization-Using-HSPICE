Title

.option  post
.option nomod
.option  measdgt=6
.temp  27
.param  vdd=1.8v  pulsew=10n  delay=10p  loadc=1f  LenTran='13*pulsew'

***************************************************************************************
***************************************************************************************
**********************************  TRANSITIONS  **************************************
***************************************************************************************
***************************************************************************************

*.tran  10p  LenTran  sweep  vdd    0.8v  2.4v  0.4v
*.tran  10p  LenTran  sweep  vdd    0.8v   2.4v  0.05v
*.tran  10p  LenTran  
*.tran  10p  LenTran  sweep  W   0.13u    0.28u   0.001u
*.tran  10p  LenTran   sweep   k7    0.26    1.5    0.02
***************************************************************************************
***************************************************************************************
*******************************  TRANSISTOR SIZING  ***********************************
***************************************************************************************
***************************************************************************************

.param  Lmin=0.13u  Wmin=0.13u
.param  K1=1 	K2=1 	K3=1 	K4=1 	K5=1 	K6=1      K7=1	 K8=1

.param  wp_l1='Lmin*5'    wn_l1='Lmin*3'
.param  wp_l2='Lmin*12'   wn_l2='Lmin*5'


***************************************************************************************
***************************************************************************************

vdd  vdd  0  vdd
.global  vdd  0

***************************************************************************************
***************************************************************************************

.include 'pmos-13u.lib'
.include 'nmos-13u.lib' *Set 0.13um library

***************************************************************************************
***************************************************************************************
******************************  2-INPUT PULSE TRANSITIONS  ****************************
***************************************************************************************
***************************************************************************************

va a_in 0 pwl (0p 0v, '2*pulsew' 0v, '2*pulsew+delay' vdd, '5*pulsew' vdd, '5*pulsew+delay' 0v, '7*pulsew' 0v, '7*pulsew+delay' vdd, '8*pulsew' vdd, '8*pulsew+delay' 0v, '9*pulsew' 0v, '9*pulsew+delay' vdd, '10*pulsew' vdd, '10*pulsew+delay' 0v, '11*pulsew' 0v, '11*pulsew+delay' vdd, '12*pulsew' vdd, '12*pulsew+delay' 0v)

van an_in 0 pwl (0p vdd, '2*pulsew' vdd, '2*pulsew+delay' 0v, '5*pulsew' 0v, '5*pulsew+delay' vdd, '7*pulsew' vdd, '7*pulsew+delay' 0v, '8*pulsew' 0v, '8*pulsew+delay' vdd, '9*pulsew' vdd, '9*pulsew+delay' 0v, '10*pulsew' 0v, '10*pulsew+delay' vdd, '11*pulsew' vdd, '11*pulsew+delay' 0v, '12*pulsew' 0v, '12*pulsew+delay' vdd)

vb b_in 0 pwl (0p 0v, '1*pulsew' 0v, '1*pulsew+delay' vdd, '3*pulsew' vdd, '3*pulsew+delay' 0v, '4*pulsew' 0v, '4*pulsew+delay' vdd, '6*pulsew' vdd, '6*pulsew+delay' 0v, '7*pulsew' 0v, '7*pulsew+delay' vdd, '8*pulsew' vdd, '8*pulsew+delay' 0v, '10*pulsew' 0v, '10*pulsew+delay' vdd, '11*pulsew' vdd, '11*pulsew+delay' 0v)

***************************************************************************************
***************************************************************************************
**********************************  INPUT BUFFERS  ************************************
***************************************************************************************
***************************************************************************************

MA_InBuff_P1	A_N	  A_IN	  VDD 	 VDD	PMOS		w=wp_l1		 L=Lmin
MA_InBuff_N1	A_N	  A_IN	  0   	 0	NMOS  		w=wn_l1 	 L=Lmin
MA_InBuff_P2	A	  A_N	  VDD	 VDD	PMOS		w=wp_l2 	 L=Lmin
MA_InBuff_N2	A	  A_N	  0	 0	NMOS		w=wp_l2 	 L=Lmin

MAN_InBuff_P1	AN_N	  AN_IN	  VDD 	 VDD	PMOS		w=wp_l1		 L=Lmin
MAN_InBuff_N1	AN_N	  AN_IN	  0   	 0	NMOS  		w=wn_l1 	 L=Lmin
MAN_InBuff_P2	AN	  AN_N	  VDD	 VDD	PMOS		w=wp_l2 	 L=Lmin
MAN_InBuff_N2	AN	  AN_N	  0	 0	NMOS		w=wp_l2 	 L=Lmin

MB_InBuff-P1	B_N	  B_IN	  VDD 	 VDD	PMOS	        w=wp_l1		 L=Lmin
MB_InBuff-N1	B_N	  B_IN	  0   	 0	NMOS  		w=wn_l1 	 L=Lmin
MB_InBuff-P2	B	  B_N	  VDD	 VDD	PMOS		w=wp_l2 	 L=Lmin
MB_InBuff-N2	B	  B_N	  0	 0	NMOS		w=wp_l2 	 L=Lmin

***************************************************************************************
***************************************************************************************
********************************** CIRCUIT DESIGN  ************************************
***************************************************************************************
***************************************************************************************

***************************************************************************************
***************************************************************************************
*********************************  PMOS TRANSISTORS  **********************************
***************************************************************************************
***************************************************************************************
MT1 Y A B VDD PMOS W=Wmin L=0.13u
MT2 Y B A VDD PMOS W=Wmin L=0.13u

MF2	VDD Y YN VDD PMOS W=Wmin L=0.13u
***************************************************************************************
***************************************************************************************
*********************************  NMOS TRANSISTORS  **********************************
***************************************************************************************
***************************************************************************************
MT3 YN A B 0 NMOS W=Wmin L=0.13u
MT4 YN B A 0 NMOS W=Wmin L=0.13u

MF1	0 YN Y 0 NMOS W=Wmin L=0.13u

***************************************************************************************
***************************************************************************************
*******************************  OUTPUT BUFFERS  **************************************
***************************************************************************************
***************************************************************************************

MY_OutBuff_P1  		xorb   	Y   	vdd  	vdd	 pmos  w=wp_l1  L=Lmin
MY_OutBuff_N1  		xorb   	Y   	0    	0	 nmos  w=wn_l1  L=Lmin
MY_OutBuff_P2  		xor    	xorb   	vdd  	vdd	 pmos  w=wp_l2  L=Lmin
MY_OutBuff_N2 		xor    	xorb   	0    	0	 nmos  w=wn_l2  L=Lmin

MYN_OutBuff_P1 	xnorb  	YN  	vdd  	vdd	 pmos  w=wp_l1  L=Lmin
MYN_OutBuff_N1		xnorb  	YN  	0    	0	 nmos  w=wn_l1  L=Lmin
MYN_OutBuff_P2		xnor   	xnorb  	vdd  	vdd	 pmos  w=wp_l2  L=Lmin
MYN_OutBuff_N2		xnor   	xnorb  	0    	0	 nmos  w=wn_l2  L=Lmin

***************************************************************************************
***************************************************************************************
*********************************  MEASUREMENTS  **************************************
***************************************************************************************
***************************************************************************************

.measure  tran  average_power  avg  power  from=0ns  to=LenTran


***************************************************************************************
***************************************************************************************

.measure  tran  tda_f_xor1   trig  v(a)  val='vdd/2'  TD=15n   rise=1  targ  v(Y)   val='vdd/2'  fall=1
.measure  tran  tda_r_xor2   trig  v(a)  val='vdd/2'  TD=45n   fall=1  targ  v(Y)   val='vdd/2'  rise=1
.measure  tran  tda_r_xor3   trig  v(a)  val='vdd/2'  TD=85n   rise=1  targ  v(Y)   val='vdd/2'  rise=1
.measure  tran  tda_f_xor4   trig  v(a)  val='vdd/2'  TD=115n  fall=1  targ  v(Y)   val='vdd/2'  fall=1

***************************************************************************************
***************************************************************************************

.measure  tran  tda_xor1   param='MAX(tda_f_xor1,tda_r_xor2)'
.measure  tran  tda_xor2   param='MAX(tda_r_xor3,tda_f_xor4)'
.measure  tran  tda_xor    param='MAX(tda_xor1,tda_xor2)'

***************************************************************************************
***************************************************************************************

.measure  tran  tda_r_xnor1  trig  v(a)  val='vdd/2'  TD=15n   rise=1  targ  v(YN)  val='vdd/2'  rise=1
.measure  tran  tda_f_xnor2  trig  v(a)  val='vdd/2'  TD=45n   fall=1  targ  v(YN)  val='vdd/2'  fall=1
.measure  tran  tda_f_xnor3  trig  v(a)  val='vdd/2'  TD=85n   rise=1  targ  v(YN)  val='vdd/2'  fall=1
.measure  tran  tda_r_xnor4  trig  v(a)  val='vdd/2'  TD=115n  fall=1  targ  v(YN)  val='vdd/2'  rise=1

***************************************************************************************
***************************************************************************************

.measure  tran  tda_xnor1   param='MAX(tda_r_xnor1,tda_f_xnor2)'
.measure  tran  tda_xnor2   param='MAX(tda_f_xnor3,tda_r_xnor4)'
.measure  tran  tda_xnor    param='MAX(tda_xnor1,tda_xnor2)'

***************************************************************************************
***************************************************************************************

.measure  tran  tdb_r_xor1   trig  v(b)  val='vdd/2'  TD=5n   rise=1  targ  v(Y)   val='vdd/2'  rise=1
.measure  tran  tdb_r_xor2   trig  v(b)  val='vdd/2'  TD=25n  fall=1  targ  v(Y)   val='vdd/2'  rise=1
.measure  tran  tdb_f_xor3   trig  v(b)  val='vdd/2'  TD=35n  rise=1  targ  v(Y)   val='vdd/2'  fall=1
.measure  tran  tdb_f_xor4   trig  v(b)  val='vdd/2'  TD=55n  fall=1  targ  v(Y)   val='vdd/2'  fall=1

***************************************************************************************
***************************************************************************************

.measure  tran  tdb_xor1   param='MAX(tdb_r_xor1,tdb_r_xor2)'
.measure  tran  tdb_xor2   param='MAX(tdb_f_xor3,tdb_f_xor4)'
.measure  tran  tdb_xor    param='MAX(tdb_xor1,tdb_xor2)'

***************************************************************************************
***************************************************************************************

.measure  tran  tdb_f_xnor1  trig  v(b)  val='vdd/2'  TD=5n   rise=1  targ  v(YN)  val='vdd/2'  fall=1
.measure  tran  tdb_f_xnor2  trig  v(b)  val='vdd/2'  TD=25n  fall=1  targ  v(YN)  val='vdd/2'  fall=1
.measure  tran  tdb_r_xnor3  trig  v(b)  val='vdd/2'  TD=35n  rise=1  targ  v(YN)  val='vdd/2'  rise=1
.measure  tran  tdb_r_xnor4  trig  v(b)  val='vdd/2'  TD=55n  fall=1  targ  v(YN)  val='vdd/2'  rise=1

***************************************************************************************
***************************************************************************************

.measure  tran  tdb_xnor1   param='MAX(tdb_f_xnor1,tdb_f_xnor2)'
.measure  tran  tdb_xnor2   param='MAX(tdb_r_xnor3,tdb_r_xnor4)'
.measure  tran  tdb_xnor    param='MAX(tdb_xnor1,tdb_xnor2)'

***************************************************************************************
***************************************************************************************

.measure  tran  tda  param='MAX(tda_xor,tda_xnor)'
.measure  tran  tdb  param='MAX(tdb_xor,tdb_xnor)'
.measure  tran  td   param='MAX(tda,tdb)'
.measure  tran  PDP  param='td*average_power'
***************************************************************************************
***************************************************************************************

.end
	