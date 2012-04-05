library( "randomForest" );

myRF <- randomForest( myTrain[,-1], as.factor( myTrain[,1] ), ntree = 100);

rf.predictions <- predict( myRF, myTrain[,-1], type = "prob" );

scoreRF <- logLoss( myTrain[,1], rf.predictions );