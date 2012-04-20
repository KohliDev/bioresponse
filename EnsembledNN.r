
ennet.validPredictions <- rep( 0, nrow( myValidSub ) );
ennet.testPredictions <- rep( 0, nrow( myTestSub ) );
NetsCount = 40;
for( i in 1:NetsCount )
{
  ennet.myTrainSub <- myTrainSub[sample( 1:nrow(myTrainSub),nrow(myTrainSub), replace=TRUE ), ];

  myNNetEnsembled <- nnet( ennet.myTrainSub[,-1],
                           ennet.myTrainSub[,1],
                           size = 40,
                           decay=0.1,
                           maxit=600,
                           MaxNWts=15000 );

  ennet.temp <- predict( myNNetEnsembled, newdata= myValidSub[,-1], type="raw" );
  ennet.validPredictions  <- ennet.validPredictions + ennet.temp;
  ennet.temp <- predict( myNNetEnsembled, newdata=myTestSub, type="raw" );
  ennet.testPredictions <- ennet.testPredictions + ennet.temp;
  
  #write.csv( c( i ), "ennet_iter.csv", row.names=FALSE );
  print( paste( "Iter:", as.character( i ) ) );
}

ennet.validPredictions <- ennet.validPredictions / NetsCount;
ennet.testPredictions <- ennet.testPredictions / NetsCount;



#measure performance
scoreENNet <- logLoss( myValidSub[,1], abs( 0.000001 - ennet.validPredictions ) );
accuracyENNet <- sum( myValidSub[,1] == ( ennet.validPredictions > 0.5 ) ) / nrow( myValidSub );
confusionENNet <- table( myValidSub$Activity, ennet.validPredictions > 0.5);
ennet.pred <- prediction( ennet.validPredictions, myValidSub[,1] );
ennet.perf <- performance( ennet.pred, "tpr", "fpr" );
