library( "nnet" );
library( "ROCR" );


myNNet <- nnet( myTrainSub[,-1],
                myTrainSub[,1],
                size = 35,
                decay=0.1,
                maxit=100,
                MaxNWts=15000 );                                                                                                                     

nnet.validPredictions <- predict( myNNet, newdata= myValidSub[,-1], type="raw" );
nnet.testPredictions <- predict( myNNet, newdata=myTestSub, type="raw"  );


#measure performance
scoreNNet <- logLoss( myValidSub[,1], abs( 0.000001 - nnet.validPredictions ) );
accuracyNNet <- sum( myValidSub[,1] == ( nnet.validPredictions > 0.5 ) ) / nrow( myValidSub );
confusionNNet <- table( myValidSub$Activity, nnet.validPredictions > 0.5);
nnet.pred <- prediction( nnet.validPredictions, myValidSub[,1] );
nnet.perf <- performance( nnet.pred, "tpr", "fpr" );

