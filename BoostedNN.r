library( "nnet" );
library( "ROCR" );

#init
TNNs = 6;
NetsPerIter = 4;
bnnet.exampleWeights <- rep( 1, nrow( myTrainSub ) ) * ( 1.0 / nrow( myTrainSub ) );
bnnet.networks <- list(dim=TNNs );
bnnet.alphas <- rep( 0, TNNs );
bnnet.sumClassifier <- rep( 0, nrow( myTrainSub ) );
bnnet.realTrainConv <- 2 * ( myTrainSub[,1] - 1.0 / 2.0 );

#train
for( i in 1:TNNs )
{
  bnnet.currentNetworks <- list( dim=NetsPerIter );
  bnnet.maxNetworkIdx = 0;
  bnnet.tmpEps = .Machine$double.xmax;

  for(  j in 1:NetsPerIter )
  {
    bnnet.currentNetworks[[j]] <-   nnet(  myTrainSub[,-1],
                                           myTrainSub[,1],
                                           size = 40,
                                           decay = 0.10,
                                           maxit = 200,
                                           MaxNWts = 30000 );

    bnnet.curPredicted <- predict( bnnet.currentNetworks[[j]], newdata = myTrainSub[,-1], type="raw" );
    bnnet.curPredictedConv <- 2 * ( bnnet.tmpPredicted - 1.0 / 2.0 );
    bnnet.curEps <- sum( abs( bnnet.tmpPredicted - myTrainSub[,1] ) * bnnet.exampleWeights );
    
    if( bnnet.tmpEps > bnnet.curEps )
    {
      bnnet.tmpPredicted <- bnnet.curPredicted;
      bnnet.tmpPredictedConv <- bnnet.curPredictedConv;
      bnnet.tmpEps <- bnnet.curEps;
      bnnet.maxNetworkIdx = j;
    }
  }
  

  

  bnnet.networks[[ i ]] <- bnnet.currentNetworks[[bnnet.maxNetworkIdx]];
  
  bnnet.alphas[ i ] <- 1.0 / 2.0 * log( ( 1 - bnnet.tmpEps ) / bnnet.tmpEps );

  bnnet.sumClassifier <- bnnet.sumClassifier + bnnet.alphas[ i ] * bnnet.tmpPredictedConv;

  bnnet.exampleWeights <- ( 1.0 - as.numeric( ( bnnet.realTrainConv * bnnet.sumClassifier ) > 0 ) ) + 0.5;
  
  bnnet.exampleWeights <- bnnet.exampleWeights / sum( bnnet.exampleWeights );
}


#test
bnnet.validPredicted = rep( 0, nrow( myValidSub ) );

for( i in 1:TNNs )
{
  bnnet.tmpValid <- predict( bnnet.networks[[i]], newdata = myValidSub[,-1], type="raw" );
  bnnet.validPredicted <- bnnet.validPredicted + bnnet.alphas[ i ] * bnnet.tmpValid;
}

bnnet.validPredicted <- bnnet.validPredicted / sum( bnnet.alphas );


#measure performance
scoreBNNet <- logLoss( myValidSub[,1], abs( 0.000001 - bnnet.validPredicted ) );
accuracyBNNet <- sum( myValidSub[,1] == ( bnnet.validPredicted > 0.5 ) ) / nrow( myValidSub );
confusionBNNet <- table( myValidSub$Activity, bnnet.validPredicted > 0.5);
bnnet.pred <- prediction( bnnet.validPredicted, myValidSub[,1] );
bnnet.perf <- performance( bnnet.pred, "tpr", "fpr" );