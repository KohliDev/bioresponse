library(kernlab);
library( ROCR );

esvm.validPredictions <- rep( 0, nrow( myValidSub ) );
esvm.testPredictions <- rep( 0, nrow( myTestSub ) );
SVMsCount = 60;
for( i in 1:SVMsCount )
{
  esvm.myTrainSub <- myTrainSub[sample( 1:nrow(myTrainSub),nrow(myTrainSub), replace=TRUE ), ];

  rx <- as.matrix( myTrainSub[,-1] );
  ry <- as.matrix( myTrainSub[,1], drop=FALSE );
  mySVMEnsembled <- ksvm( rx,
                          ry,
                          kernel="rbfdot",
                          type="C-svc",
                          C=5,
                          prob.model=TRUE );

  esvm.temp <- predict( mySVMEnsembled, myValidSub[,-1], type="probabilities" );
  esvm.validPredictions  <- esvm.validPredictions + esvm.temp[,2];
  esvm.temp <- predict( mySVMEnsembled, myTestSub, type="probabilities" );
  esvm.testPredictions <- esvm.testPredictions + esvm.temp[,2];

  #write.csv( c( i ), "esvm_iter.csv", row.names=FALSE );
  print( paste( "Iter:", as.character( i ) ) );
}

esvm.validPredictions <- esvm.validPredictions / SVMsCount;
esvm.testPredictions <- esvm.testPredictions / SVMsCount;



#measure performance
scoreESVM <- logLoss( myValidSub[,1], abs( 0.000001 - esvm.validPredictions ) );
accuracyESVM <- sum( myValidSub[,1] == ( esvm.validPredictions > 0.5 ) ) / nrow( myValidSub );
confusionESVM <- table( myValidSub$Activity, esvm.validPredictions > 0.5);
esvm.pred <- prediction( esvm.validPredictions, myValidSub[,1] );
esvm.perf <- performance( esvm.pred, "tpr", "fpr" );
