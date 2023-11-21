%{
http://www.dimensionetrading.com/Pattern_e_indicatori/Ehlers%20_Optimal%20Tracking%20Filters_.pdf
https://www.tradingview.com/script/LvaRO3Un-powerful-moving-average-crossover/
study("powerful moving average crossover",shorttitle="Ehlers_Kalman_cross_mcbw_",overlay=true)

// This script is a simplified version of John Ehlers's adaption of Dr. Kalman's optimum estimator as applied to price 
// action (More can be found on this here: http://www.dimensionetrading.com/Pattern_e_indicatori/Ehlers%20_Optimal%20Tracking%20Filters_.pdf). 
// Here I have adapted two of these optimum estimators to work together to provide crossover signals. 
// The user can choose the input of this filter in the 'input source'. 
//The 'Ratio of Uncertainties' controls how adaptive the moving averages are, increasing this number will increase adaptivity and vice versa for decreasing. 
// The 'Kalman Gain' allows the user to choose how much error to let into the calculation. The smaller this number is the quicker the moving average will approach price action.
// In practice this indicator is much smoother than most other moving averages and has significantly less whiplash while still getting very early entries.
// If anyone wants to adapt this script for their own uses please feel free. Message me what you make with it, I am very curious what this can do when in the right hands! 
// Happy trading! 

// User inputs -----------------------------------------------------------------

src_in = input(hlc3,title = 'input source')
trackinrat_01 = input(defval=2.0, minval=0.01, step=0.1, title = "Ratio of Uncertainties 01")
kgain_01 = input(defval=0.7, minval=0.01, maxval=1.1, step=0.01, title = "Kalman Gain 01")
trackinrat_02 = input(defval=2.0, minval=0.01, step=0.1, title = "Ratio of Uncertainties 02")
kgain_02 = input(defval=0.8, minval=0.01, maxval=1.1, step=0.01, title = "Kalman Gain 02")
//trackinrat_03 = input(defval=2.0, minval=0.01, step=0.1, title = "Ratio of Uncertainties 03")
//kgain_03 = input(defval=0.8, minval=0.01, maxval=1.1, step=0.01, title = "Kalman Gain 03")
bgcolor_io = input(true, title ='Show background color')

// Functions -------------------------------------------------------------------

ehlers_optimal_filter(varin_func, trackinrat_func, kgain_func)=>
    movement_uncertainty = trackinrat_func*(varin_func-varin_func[1]) + kgain_func*nz(movement_uncertainty[1])
    measurement_uncertainty_mcbw = 1*(high[1]-low[1])+kgain_func*nz(measurement_uncertainty_mcbw[1])
    lambda = abs(movement_uncertainty/measurement_uncertainty_mcbw)
    alpha = ( -pow(lambda,2) + pow(  (pow(lambda,4) + 16*pow(lambda,2))  ,0.5) )/ 8
    ehlers_optimal_price = alpha*varin_func + (1-alpha)*nz(ehlers_optimal_price[1])

// Function calls  -------------------------------------------------------------

filter_01 = ehlers_optimal_filter(src_in, trackinrat_01, kgain_01)
filter_02 = ehlers_optimal_filter(src_in, trackinrat_02, kgain_02)
//filter_03 = ehlers_optimal_filter(src_in, trackinrat_03, kgain_03)
%}
function out = EhlerPowMA(H,L,C)
src_in = (H+L+C)/3;
trackinrat_01 = 2.0;
kgain_01 = 0.7;
trackinrat_02 = 2.0;
kgain_02 = 0.8;
trackinrat_03 = 2.0;
kgain_03 = 0.85;
Z = zeros(1,length(H));
persistent Xepma
if isempty(Xepma)
    Xepma.varin_funcp = src_in;
    Xepma.Hp = H;
    Xepma.Lp = L;
    Xepma.movement_uncertainty1p = Z;
    Xepma.movement_uncertainty2p = Z;
    Xepma.movement_uncertainty3p = Z;
    Xepma.measurement_uncertainty_mcbw1p = H-L;
    Xepma.measurement_uncertainty_mcbw2p = H-L;
    Xepma.measurement_uncertainty_mcbw3p = H-L;
    Xepma.ehlers_optimal_price1p = src_in;
    Xepma.ehlers_optimal_price2p = src_in;
    Xepma.ehlers_optimal_price3p = src_in;
end
varin_func = src_in;
trackinrat_func = trackinrat_01;kgain_func = kgain_01;
movement_uncertainty1 = ...
    trackinrat_func*(varin_func - Xepma.varin_funcp) + ...
    kgain_func*Xepma.movement_uncertainty1p;
measurement_uncertainty_mcbw1 = Xepma.Hp - Xepma.Lp + ...
    kgain_func*Xepma.measurement_uncertainty_mcbw1p;
lambda = abs(movement_uncertainty1./...
    measurement_uncertainty_mcbw1);
alpha = ...
    ( -power(lambda,2) + ...
    power( (power(lambda,4) + 16*power(lambda,2)),0.5))/ 8;
ehlers_optimal_price1 = alpha.*varin_func + ...
    (1-alpha).*Xepma.ehlers_optimal_price1p;
trackinrat_func = trackinrat_02;kgain_func = kgain_02;
movement_uncertainty2 = ...
    trackinrat_func*(varin_func - Xepma.varin_funcp) + ...
    kgain_func*Xepma.movement_uncertainty2p;
measurement_uncertainty_mcbw2 = Xepma.Hp - Xepma.Lp + ...
    kgain_func*Xepma.measurement_uncertainty_mcbw2p;
lambda = abs(movement_uncertainty2./...
    measurement_uncertainty_mcbw2);
alpha = ...
    ( -power(lambda,2) + ...
    power( (power(lambda,4) + 16*power(lambda,2)),0.5))/ 8;
ehlers_optimal_price2 = alpha.*varin_func + ...
    (1-alpha).*Xepma.ehlers_optimal_price2p;
trackinrat_func = trackinrat_03;kgain_func = kgain_03;
movement_uncertainty3 = ...
    trackinrat_func*(varin_func - Xepma.varin_funcp) + ...
    kgain_func*Xepma.movement_uncertainty3p;
measurement_uncertainty_mcbw3 = Xepma.Hp - Xepma.Lp + ...
    kgain_func*Xepma.measurement_uncertainty_mcbw3p;
lambda = abs(movement_uncertainty3./...
    measurement_uncertainty_mcbw3);
alpha = ...
    ( -power(lambda,2) + ...
    power( (power(lambda,4) + 16*power(lambda,2)),0.5))/ 8;
ehlers_optimal_price3 = alpha.*varin_func + ...
    (1-alpha).*Xepma.ehlers_optimal_price3p;
Xepma.varin_funcp = varin_func;
Xepma.movement_uncertainty1p = movement_uncertainty1;
Xepma.movement_uncertainty2p = movement_uncertainty2;
Xepma.movement_uncertainty3p = movement_uncertainty3;
Xepma.measurement_uncertainty_mcbw1p = measurement_uncertainty_mcbw1;
Xepma.measurement_uncertainty_mcbw2p = measurement_uncertainty_mcbw2;
Xepma.measurement_uncertainty_mcbw3p = measurement_uncertainty_mcbw3;
Xepma.Hp = H;
Xepma.Lp = L;
Xepma.ehlers_optimal_price1p = ehlers_optimal_price1;
Xepma.ehlers_optimal_price2p = ehlers_optimal_price2;
Xepma.ehlers_optimal_price3p = ehlers_optimal_price3;
out(1,:) = ehlers_optimal_price1;
out(2,:) = ehlers_optimal_price2;
out(3,:) = ehlers_optimal_price3;
out(4,:) = ehlers_optimal_price1-ehlers_optimal_price2;
out(5,:) = ehlers_optimal_price1-ehlers_optimal_price3;
end
