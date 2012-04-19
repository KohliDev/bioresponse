library( "kernlab" );
library( "ROCR" );


rx <- as.matrix( myTrainSub[,-1] );
ry <- as.matrix( myTrainSub[,1], drop=FALSE );
mySVM <- ksvm(rx,
              ry,
              kernel="polydot",
              type="C-svc",
              C=5,
              prob.model=TRUE );


svm.validPredictions <- predict( mySVM, myValidSub[,-1], type="probabilities" );
svm.testPredictions <- predict( mySVM, myTestSub, type="probabilities" );                                                         

#measure performance
scoreSVM <- logLoss( myValidSub[,1], abs( 1e-10 - svm.validPredictions[,2] ) );
accuracySVM <- sum( myValidSub[,1] == ( svm.validPredictions[,2] > 0.5 ) ) / nrow( myValidSub );
confusionSVM <- table( myValidSub$Activity, svm.validPredictions[,2] > 0.5);
svm.pred <- prediction( svm.validPredictions[,2], myValidSub[,1] );
svm.perf <- performance( svm.pred, "tpr", "fpr" );

              


