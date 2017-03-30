%% Esercitazione 2
%  lo stesso esercizio può essere svolto utilizzando anche la seguente
%  funzione alternativa:

clear
load data

% preparazione dati: prima regressori, ultima var dipendente
tbl = table(MALE,EXPER,SCHOOL,WAGE);

% costruisco prima regressione
ols1_new = fitlm(tbl,'WAGE~MALE');
% costruisco seconda regressione
ols2_new = fitlm(tbl,'WAGE~MALE+SCHOOL+EXPER');

% intervalli di confidenza e test di ipotesi
intervallo = coefCI(ols1_new,0.05);
test1= coefTest(ols1_new);

plot(ols2_new)