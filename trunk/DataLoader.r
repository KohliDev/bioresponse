#DataLoader
setwd( "data" );

myTrainAll <- read.csv( "train.csv", head = TRUE, sep = "," );
myTest  <- read.csv( "test.csv", head = TRUE, sep = "," );
  
dimTrainAll <- dim( myTrainAll );

validSplitPortion <- 0.8;
validSplitIdx <- validSplitPortion * dimTrainAll[1]; 
myTrain <- myTrainAll[1:validSplitIdx,];
myValid <- myTrainAll[validSplitIdx:dimTrainAll[1],];

dimValid <- dim( myValid );
dimTrain <- dim( myTrain );
dimTest <- dim( myTest );
