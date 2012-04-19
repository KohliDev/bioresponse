library( "FSelector" );

#weightsChiSquared <- chi.squared( Activity~., myTrain );
#write.csv(weightsChiSquared, file = "findings/chi.csv", row.names=TRUE, col.names=TRUE );
#weightsInfoGain <- information.gain( Activity~., myTrain );
#write.csv(weightsInfoGain, file ="findings/info.csv", row.names=TRUE, col.names=TRUE );
#weightsGainRatio <- gain.ratio( Activity~., myTrain );
#write.csv(weightsGainRatio, file ="findings/ratio.csv", row.names=TRUE, col.names=TRUE );
#weightsUncertainty <- symmetrical.uncertainty( Activity~., myTrain );
#write.csv(weightsUncertainty, file ="findings/symmetric.csv", row.names=TRUE, col.names=TRUE );
#weightsRFI <- random.forest.importance( Activity~., myTrain );                                          
#write.csv( weightsRFI, file ="findings/rfi.csv", row.names=TRUE, col.names=TRUE );
#weightsOneR <- oneR( Activity~., myTrain );
#write.csv(weightsOneR, file ="findings/oner.csv", row.names=TRUE, col.names=TRUE );

#Selection criteria
intersectedFeatures <- 1*( weightsInfoGain > 0 );

subsetFeatures <- cutoff.k( weightsRFI, 200 );
#subsetFeatures <- cutoff.k( weightsInfoGain, 50 );

subsetFeaturesTarget <- c( "Activity", subsetFeatures );

myTrainAllSub <- myTrainAll[,subsetFeaturesTarget];
myTrainSub <- myTrain[ , subsetFeaturesTarget ];
myValidSub <- myValid[, subsetFeaturesTarget ];
myTestSub <- myTest[ , subsetFeatures ];

dimTrainAllSub <- dim( myTrainAllSub );
dimTrainSub <- dim( myTrainSub );
dimValidSub <- dim( myValidSub );
dimTestSub <- dim( myTestSub );

