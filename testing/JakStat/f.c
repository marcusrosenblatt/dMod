/** Code auto-generated by cOde 0.2 **/
#include <R.h> 
 #include <math.h> 

static double parms[17];
static double forc[1];
static double cons[0];

#define p1 parms[0] 
 #define p5 parms[1] 
 #define p2 parms[2] 
 #define p3 parms[3] 
 #define p4 parms[4] 
 #define s_STAT parms[5] 
 #define y0_0 parms[6] 
 #define y1_0 parms[7] 
 #define y2_0 parms[8] 
 #define y3_0 parms[9] 
 #define y4_0 parms[10] 
 #define y5_0 parms[11] 
 #define y6_0 parms[12] 
 #define y7_0 parms[13] 
 #define y8_0 parms[14] 
 #define y9_0 parms[15] 
 #define y10_0 parms[16] 
 #define pEpoR forc[0] 

void initmod(void (* odeparms)(int *, double *)) {
	 int N=17;
	 odeparms(&N, parms);
}

void initforc(void (* odeforcs)(int *, double *)) {
	 int N=1;
	 odeforcs(&N, forc);
}

/** Derivatives (ODE system) **/
void derivs (int *n, double *t, double *y, double *ydot, double *RPAR, int *IPAR) {

	 double time = *t;

	 ydot[0] = -1*p1*pEpoR*y[0]+1*p5*y[8];
 	 ydot[1] = 1*p1*pEpoR*y[0]-2*p2*y[1]*y[1];
 	 ydot[2] = 1*p2*y[1]*y[1]-1*p3*y[2];
 	 ydot[3] = 1*p3*y[2]-1*p4*y[3];
 	 ydot[4] = 2*p4*y[3]-1*p5*y[4];
 	 ydot[5] = 1*p5*y[4]-1*p5*y[5];
 	 ydot[6] = 1*p5*y[5]-1*p5*y[6];
 	 ydot[7] = 1*p5*y[6]-1*p5*y[7];
 	 ydot[8] = 1*p5*y[7]-1*p5*y[8];
 	 ydot[9] = (1)*(-1*p1*pEpoR*y[0]+1*p5*y[8])+(1)*(1*p1*pEpoR*y[0]-2*p2*y[1]*y[1])+(2)*(1*p2*y[1]*y[1]-1*p3*y[2]);
 	 ydot[10] = 0+(s_STAT)*(1*p1*pEpoR*y[0]-2*p2*y[1]*y[1])+(s_STAT*2)*(1*p2*y[1]*y[1]-1*p3*y[2]);

	 RPAR[0] = pEpoR;
}

