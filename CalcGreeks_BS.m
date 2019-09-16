function Greeks = CalcGreeks_BS(Spot, Strike, DomesticRate, ...,
    ForeignRate, Volatility, Maturity, PutCallInd)
% -------------------------------------------------------------------------
% Summary: To calculate vanilla option greeks by B/S
% Author: Zhang Wei (eileen.wei.zhang@gmail.com)
% Last Modified: November 12 2013
% Example: Greeks = CalcGreeks_BS(100, 100, 0.05, 0.01, 0.25, 1, 1)
%          Greeks = 0.6061 0.0152 37.9253 48.8894 -6.5790 -0.0531 1.5132
% -------------------------------------------------------------------------
	d1 = (log(Spot/Strike) + (DomesticRate - ForeignRate + 0.5 * ...,
        Volatility * Volatility) * Maturity) / Volatility / sqrt(Maturity);
	d2 = (log(Spot/Strike) + (DomesticRate - ForeignRate - 0.5 * ...,
        Volatility * Volatility) * Maturity) / Volatility / sqrt(Maturity);
    
    Delta = PutCallInd * normcdf(PutCallInd * d1) * ...,
        exp(-ForeignRate * Maturity);
    
    Gamma = exp(-ForeignRate * Maturity) * normpdf(d1) / Spot / ...,
        Volatility / sqrt(Maturity);
    
    Vega = Spot * exp(-ForeignRate * Maturity) * normpdf(d1) * ...,
        sqrt(Maturity);
    
    Theta = -Spot * exp(-ForeignRate * Maturity) * normpdf(d1) * ...,
        Volatility / 2 / sqrt(Maturity) - PutCallInd * DomesticRate...,
        * Strike * exp(-DomesticRate * Maturity) * ...,
        normcdf(PutCallInd * d2) + PutCallInd * ForeignRate * Spot ...,
        * exp(-ForeignRate * Maturity) * normcdf(PutCallInd * d1);
    
    Rho = PutCallInd * Strike * Maturity * exp(-DomesticRate * ...,
        Maturity) * normcdf(PutCallInd * d2);
    
    Vanna = -exp(-ForeignRate * Maturity) * normpdf(d1) * d2 / Volatility;
    
    Volga = Spot * sqrt(Maturity) * exp(-Maturity * ForeignRate) * ...,
        d1 * d2 * normpdf(d1) / Volatility;
    
    Greeks = [Delta, Gamma, Vega, Rho, Theta, Vanna, Volga];