library( "randomForest" );
library( "ROCR" );


myRF <- randomForest( myTrainSub[,-1],
                      as.factor( myTrainSub[,1] ),
                      ntree = 4000,
                      type="classification",
                      mtry=50);

rf.predictions <- predict( myRF, myValidSub[,-1], type = "prob" );
rf.testPredictions <- predict( myRF, myTestSub, type = "prob" );

#measure performance
scoreRF <- logLoss( myValidSub[,1], abs( 0.000001 - rf.predictions[,2] ) );
accuracyRF <- sum( myValidSub[,1] == ( rf.predictions[,2] > 0.5 ) ) / nrow( myValidSub );
confusionRF <- table( myValidSub$Activity, rf.predictions[,2] > 0.5 );
rf.pred <- prediction( rf.predictions[,2], myValidSub[,1] );
rf.perf <- performance( rf.pred, "tpr", "fpr" );



