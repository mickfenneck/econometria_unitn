%% STIMA DEL TEST DEL CAPM (Paragrafo 2.7.2)
% carichiamo i dati

clear
load DATI_CAPM

% Cerchiamo di riprodurre i dati della tabella a pagina 36
% costruiamo le regressioni del CAPM (senza intercetta) per i 3 protafogli
% settoriali (alimentari, beni durevoli e costruzioni).

%TABELLA 1: regressione del CAPM (senza intercetta)

ols_alimentari = regstats((RFOOD),(RMRF),1); % 1 toglie l'intercetta
ols_beni_durevoli = regstats((RDUR),(RMRF),1);
ols_costruzioni = regstats((RCON),(RMRF),1);

% estraiamo i dati fondamentali da ogni regressione
% beta, std err, R2

tab_a = dataset({ols_alimentari.tstat.beta,'Coeff'}, ...
                {ols_alimentari.tstat.se,'Std_Err'}, ...
                {ols_alimentari.rsquare,'R_square'});
            
tab_b = dataset({ols_beni_durevoli.tstat.beta,'Coeff'}, ...
                {ols_beni_durevoli.tstat.se,'Std_Err'}, ...
                {ols_beni_durevoli.rsquare,'R_square'});
            
tab_c = dataset({ols_costruzioni.tstat.beta,'Coeff'}, ...
                {ols_costruzioni.tstat.se,'Std_Err'}, ...
                {ols_costruzioni.rsquare,'R_square'});
            
% Nel momento in cui la stima non contiene l'intercetta regstats perde di
% precisione. 

%Usiamo la funzione lm

%Regressione alimentari
tbl = table(RMRF,RFOOD);
ols_alimentari_lm = fitlm(tbl, 'RFOOD~RMRF', 'Intercept', false);

beta_a = ols_alimentari_lm.Coefficients.Estimate;
se_a = ols_alimentari_lm.Coefficients.SE;
R2_a = ols_alimentari_lm.Rsquared.Ordinary;

tab_a_lm = dataset({beta_a,'beta'}, {se_a,'StdErr'}, {R2_a, 'Rsquared'});
%Regressione beni
tbl = table(RMRF,RDUR);
ols_durevoli_lm = fitlm(tbl, 'RDUR~RMRF', 'Intercept', false);

beta_b = ols_durevoli_lm.Coefficients.Estimate;
se_b = ols_durevoli_lm.Coefficients.SE;
R2_b = ols_durevoli_lm.Rsquared.Ordinary;

tab_b_lm = dataset({beta_b,'beta'}, {se_b,'StdErr'}, {R2_b, 'Rsquared'});

%Regressione costruzioni
tbl = table(RMRF,RCON);
ols_costruzioni_lm = fitlm(tbl, 'RCON~RMRF', 'Intercept', false);

beta_c = ols_costruzioni_lm.Coefficients.Estimate;
se_c = ols_costruzioni_lm.Coefficients.SE;
R2_c = ols_costruzioni_lm.Rsquared.Ordinary;

tab_c_lm = dataset({beta_c,'beta'}, {se_c,'StdErr'}, {R2_c, 'Rsquared'});

% Test di significatività per i 3 beta
test_a = ols_alimentari_lm.Coefficients;
test_b = ols_durevoli_lm.Coefficients;
test_c = ols_costruzioni_lm.Coefficients;

test_a
test_b
test_c

% I beta sono significativi

%% Test di ipotesi
% testiamo l'ipotesi H0: beta = 1, ovvero vogliamo verificare se l'extra
% rendimento di mercato dell'1% porta ad un parti extra rendimento del
% titolo dell'1%

th_1 = (beta_a-1)/se_a;
th_2 = (beta_b-1)/se_b;
th_3 = (beta_c-1)/se_c;

th_1
th_2
th_3

% verifica a validità regressione CAPM: aggiungiamo l'intercetta. Se
% l'intercetta è significativa il CAPM non è valido.


%Regressione alimentari
tbl = table(RMRF,RFOOD);
ols_alimentari_lm_int = fitlm(tbl, 'RFOOD~RMRF', 'Intercept', true);

beta_a_int = ols_alimentari_lm_int.Coefficients.Estimate;
se_a_int = ols_alimentari_lm_int.Coefficients.SE;
R2_a_int = ols_alimentari_lm_int.Rsquared.Ordinary;

tab_a_lm_int = dataset({beta_a_int(1,1),'beta_int'}, ...
                       {se_a_int(1,1),'StdErr_int'}, ...
                       {R2_a_int(1,1), 'Rsquared_int'});


%Regressione beni
tbl = table(RMRF,RDUR);
ols_durevoli_lm_int = fitlm(tbl, 'RDUR~RMRF', 'Intercept', true);

beta_b_int = ols_durevoli_lm_int.Coefficients.Estimate;
se_b_int = ols_durevoli_lm_int.Coefficients.SE;
R2_b_int = ols_durevoli_lm_int.Rsquared.Ordinary;

tab_b_lm_int = dataset({beta_b_int(1,1),'beta_int'}, ...
                       {se_b_int(1,1),'StdErr_int'}, ...
                       {R2_b_int(1,1), 'Rsquared_int'});

%Regressione costruzioni
tbl = table(RMRF,RCON);
ols_costruzioni_lm_int = fitlm(tbl, 'RCON~RMRF', 'Intercept', true);

beta_c_int = ols_costruzioni_lm_int.Coefficients.Estimate;
se_c_int = ols_costruzioni_lm_int.Coefficients.SE;
R2_c_int = ols_costruzioni_lm_int.Rsquared.Ordinary;

tab_c_lm_int = dataset({beta_c_int(1,1),'beta_int'}, ...
                       {se_c_int(1,1),'StdErr_int'}, ...
                       {R2_c_int(1,1), 'Rsquared_int'});
                   
tab_a_lm_int
tab_b_lm_int
tab_c_lm_int

% Test di significatività per i 3 beta
test_a_int = ols_alimentari_lm_int.Coefficients;
test_b_int = ols_durevoli_lm_int.Coefficients;
test_c_int = ols_costruzioni_lm_int.Coefficients;

test_a_int
test_b_int
test_c_int

th_1_int = (beta_a_int-1)/se_a_int;
th_2_int = (beta_b_int-1)/se_b_int;
th_3_int = (beta_c_int-1)/se_c_int;

th_1_int
th_2_int
th_3_int


%% verifichiamo la presenza dell'effetto gennaio
% se effetto gennaio esiste davvero, la validità del CAPM 
tbl = table(JANDUM, RMRF, RFOOD);
ols_a_3 = fitlm(tbl,'RFOOD~JANDUM+RMRF', 'Intercept', true);
ols_a_3.Coefficients

tbl = table(JANDUM, RMRF, RDUR);
ols_b_3 = fitlm(tbl,'RDUR~JANDUM+RMRF', 'Intercept', true);
ols_b_3.Coefficients

tbl = table(JANDUM, RMRF, RCON);
ols_c_3 = fitlm(tbl,'RCON~JANDUM+RMRF', 'Intercept', true);
ols_c_3.Coefficients