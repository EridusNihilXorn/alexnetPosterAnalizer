%Assuming Python script sorted images in folders.
%Loading images into memory, trainset + testset.
cd 'D:\warGaming\2';
pathToImages = fullfile(cd, 'Posters\train');
trainImages = imageDatastore(pathToImages,...
    'IncludeSubfolders',true,'LabelSource','foldernames', 'ReadFcn', @readAndResize);
pathToImages = fullfile(cd, 'Posters\analize');
testImages = imageDatastore(pathToImages,...
     'IncludeSubfolders',true,'LabelSource','foldernames', 'ReadFcn', @readAndResize);
 
%Numbers for checking amount of loaded images.
%labelCount = countEachLabel(trainImages)
%labelCount = countEachLabel(testImages)

%Using alexnet with changed last layers for 2 classes.
network = alexnet;
network.Layers;
layersTransfer = network.Layers(1:end-3);
numClasses = numel(categories(trainImages.Labels))
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor', 25,'BiasLearnRateFactor',25)
    softmaxLayer
    classificationLayer];
options = trainingOptions('sgdm',...
    'MiniBatchSize', 20,...
    'MaxEpochs',6,...
    'InitialLearnRate',1e-4,...
    'Verbose',false);

%Using trained network to get predictions.
trainedNetwork = trainNetwork(trainImages,layers,options);
predictedLabels = classify(trainedNetwork,testImages);
predictions = predict(trainedNetwork, testImages);
%Save matlab file "predictions" to folder and use "writeToCSV".