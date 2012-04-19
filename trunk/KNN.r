library( class );
library( "ROCR" );
                

knn.trainClass <-  knn.cv( myTrainAllSub[,-1],
                           myTrainAllSub[,1],
                           l = 0,
                           k = 1,
                           prob=TRUE );

tmpProb <- attr( knn.trainClass, "prob" );                              
knn.trainPredicted <- ( tmpProb^(as.numeric(knn.trainClass) - 1.0 ) )*( ( 1.0 - tmpProb )^( 2.0 - as.numeric( knn.trainClass)) );

knn.testClass <- knn(  myTrainAllSub[,-1],
                           myTestSub,
                           as.factor( myTrainAllSub[,1] ),
                           l=0,
                           prob=TRUE,
                           k = 1 );
                           
tmpProb <- attr( knn.testClass, "prob" );                              
knn.testPredicted <- ( tmpProb^(as.numeric(knn.testClass) - 1.0 ) )*( ( 1.0 - tmpProb )^( 2.0 - as.numeric( knn.testClass) ) );

#measure performance                                                                                                
scoreKNN <- logLoss( myTrainAllSub[,1], abs( 0.00000001 - knn.trainPredicted ) );
accuracyKNN <- sum( myTrainAllSub[,1] == ( knn.trainPredicted > 0.5 ) ) / nrow( myTrainAllSub );
