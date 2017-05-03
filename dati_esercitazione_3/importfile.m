function [price,lotsize,bedrooms,bathrms,stories,driveway,recroom,fullbase,gashw,airco,garagepl,prefarea] = importfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [PRICELOTSIZ1,EBEDROOMSB1,ATHR1,MSS1,TORI1,ESD1,RIVE1,WAY1,RECR1,OOM1,FULL2,BASEGASHWAIRCO1]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [PRICELOTSIZ1,EBEDROOMSB1,ATHR1,MSS1,TORI1,ESD1,RIVE1,WAY1,RECR1,OOM1,FULL2,BASEGASHWAIRCO1]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [pricelotsiz1,ebedroomsb1,athr1,mss1,tori1,esd1,rive1,way1,recr1,oom1,full2,basegashwairco1] = importfile('housing.dat',3, 548);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2017/04/27 13:27:34

%% Initialize variables.
if nargin<=2
    startRow = 3;
    endRow = inf;
end

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%12f%12f%4f%4f%4f%4f%4f%4f%4f%4f%4f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
price = dataArray{:, 1};
lotsize = dataArray{:, 2};
bathrms = dataArray{:, 3};
bedrooms = dataArray{:, 4};
stories = dataArray{:, 5};
driveway = dataArray{:, 6};
recroom = dataArray{:, 7};
fullbase = dataArray{:, 8};
gashw = dataArray{:, 9};
airco = dataArray{:, 10};
garagepl = dataArray{:, 11};
prefarea = dataArray{:, 12};
