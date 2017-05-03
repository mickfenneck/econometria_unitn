%% UN'ANALISI DEI PREZZI DELLE ABITAZIONI (3.4 P.57)


% importazione dei dati usando la funzione

filename = 'housing.dat';
startRow = 3;
endRow = 548;

[price,lotsize,bedrooms,bathrms,stories,driveway,recroom,fullbase,gashw,airco,garagepl,prefarea] = importfile(filename, startRow, endRow);

pricelog = log(price);
lotsizelog = log(lotsize);

%% COSTRUZIONE PRIMA REGRESSIONE
tbl=table(lotsizelog,bedrooms,bathrms,airco,pricelog);