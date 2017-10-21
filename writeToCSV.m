cd 'D:\warGaming\2';
predictions = load('predictions.mat');
predictionsCell = struct2cell(predictions);
headers = {'ID', 'Comedy', 'Other'}
imageNumbers = [];
for i = 3636:4544
    imageNumbers = vertcat(imageNumbers, i);
end

%Concating IDs and predictions + headers.
csvwrite(fullfile(cd, 'IDs.csv'), imageNumbers, 0, 0);
csvwrite(fullfile(cd, 'predictions.csv'), predictionsCell, 0, 0);
csv1 = csvread(fullfile(cd, 'IDs.csv'));
csv2 = csvread(fullfile(cd, 'predictions.csv'));
csvres = [csv1 csv2];
csvwrite_with_headers(fullfile(cd, 'result.csv'),csvRes, headers);

