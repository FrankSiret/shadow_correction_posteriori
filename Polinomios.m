function [Background]= Polinomios(data)
addpath(genpath(cd));
Background = double(data);
n=2;
for casos=1:2
	SD = size(Background);
	for kk=1:SD(1)
		Profile = Background(kk,:);
		xx= 1:SD(2);
		% Ajuste de la curva cuadrada
		[CoefFit] = polyfit(xx,Profile,n);
		yfit = 0.;
		for i=0:1:n
			 yfit = yfit + (CoefFit(i+1)).*(xx.^(n-i));
		end   
		Background(kk,:) = yfit;
	end
	Background = Background';
end
Background = double(Background);
 
