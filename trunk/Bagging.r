library( "ipred" );
library( "ROCR" );

myBagging <- bagging( Activity~., myTrainSub, nbagg=30, control = rpart.control( cp=0.001, maxcompete=8, maxsurrogate=8, xval=6 ) );
  
bagging.validPredictions <- predict( myBagging, myValidSub[,-1], type="prob" );
bagging.testPredictions <- predict( myBagging, myTestSub, type="prob" );


#measure performance
scoreBagging <- logLoss( myValidSub[,1], abs( 0.0000001 - bagging.validPredictions ) );
accuracyBagging <- sum( myValidSub[,1] == ( bagging.validPredictions > 0.5 ) ) / nrow( myValidSub );
confusionBagging <- table( myValidSub$Activity, bagging.validPredictions > 0.5 );
bagging.pred <- prediction( bagging.validPredictions, myValidSub[,1] );
bagging.perf <- performance( bagging.pred, "tpr", "fpr" );                                                
