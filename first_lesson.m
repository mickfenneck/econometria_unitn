%% Esercitazione 1
%  Carichiamo i dati con un comando load

clear
load data

%% Esempio 2.1.3
%approssimioamo i salari con una combinazione lineare della costante e di
%una variabile dummy che indice se l'individuo � uomo o donna
%(approccio OLS) wage = beta1+beta2*male

ols1=regstats(WAGE,MALE,'linear');

ols1.beta

%Calcoliamo le medie dei salari di uomini e donne
% sappiamo che la miglior approssimazione del salario di una donna �
% 5,15=5,15+0*1,17

salario_tutti = [WAGE MALE];
[n_righe, n_colonne]=size(salario_tutti);
%trovo numero uomini/donne
%n_uomini = find(salario_tutti(2)>0);
%n_donne = n_righe - n_uomini;
%istanzio vettori
%salario_donne = zeros(n_donne,1);
%salario_uomini = zeros(n_uomini,1);

i_donne = 1;
i_uomini = 1;
for i=1:n_righe
    if salario_tutti(i,2)== 0   %donne
        salario_donne(i_donne) = salario_tutti(i,1);
        i_donne = i_donne + 1;
    else
        salario_uomini(i_uomini) = salario_tutti(i,1);
        i_uomini = i_uomini + 1;
    end
end

%donne = find(salario_donne>0);
%uomini = find(salario_uomini>0);

salario_medio_donne = mean(salario_donne);
salario_medio_uomini = mean(salario_uomini);

%% altra roba

Coeff_OLS = dataset({ols1.tstat.beta,'beta'},...    %1 col.
                    {ols1.tstat.se,'StdErr'},...    %2 col.
                    {ols1.tstat.t,'tStat'},...      %3 col.
                    {ols1.tstat.pval,'pValue'});    %4 col.
                
                
                % calcola nella media anche zeri, tolgo zeri da vettore
                
                
%% Esempio: analisi salario individuale 2.5.2
% semplice test partendo da dati tabella
%verifichiamo b2=0 e costruiamo la statistica test
% dividendo la stima del parametro per il suo std err:

stat_test_t = ols1.tstat.beta(2,1)/ols1.tstat.se(2,1);
val_critico = 1.96;

if stat_test_t > val_critico
    disp('Rifiuto H0');
else
    disp('Non si rifiuta H0');
end

%intervallo di confidenza
sx = ols1.tstat.beta(2,1)-val_critico.*ols1.tstat.se(2,1);
dx = ols1.tstat.beta(2,1)+val_critico.*ols1.tstat.se(2,1);

%% Esempio: analisi salario individuale 2.5.5 (pag26)
% precedentemente regressione wage=b1+b2male+e
% L'analisi fin qui considerata non ci permette di affermare che esiste
% discriminazione tra lavoratori maschi e femmine.
% Pu� darsi che anche istruzione e esperienza abbiano un ruolo nella
% determinazione del salario. Costruiamo una nuova regressione

% wage =  b1 + b2male + b3school + b4exper + e

% Costruiamo il nuovo modello:

Y = WAGE;                       % variabile dipendente
X = [MALE, SCHOOL, EXPER];      % matrice regressioni

ols2= regstats(Y,X,'linear');

Coeff_OLS21 = dataset({ols2.tstat.beta,'beta'},...    %1 col.
                      {ols2.tstat.se,'StdErr'},...    %2 col.
                      {ols2.tstat.t,'tStat'},...      %3 col.
                      {ols2.tstat.pval,'pValue'});    %4 col.
                  
Coeff_OLS22 = dataset({ols2.rsquare,'R_square'},...
                      {ols2.adjrsquare,'R_square_adj'},...
                      {ols2.fstat.f,'F'});
                  
                  
% Calcoliamo la statistica f per stabilire quale fra i due modelli ols1 e
% ols2 sia il migliore
n_donne = i_donne-1;                %sistemo indice
n_uomini = i_uomini-1;              %togliendo successivo

stat_f = ((ols2.rsquare-ols1.rsquare)./2)./...
         ((1-ols2.rsquare)/(n_donne+n_uomini-4));
         