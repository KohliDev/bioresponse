#Packages
library( "gbm" );

#Settings
GBM_TREES = 50000;



myGBM <- gbm( formula( myTrainSub ),
              data = myTrainSub,
              distribution = "bernoulli",
              cv.folds = 4,
              n.trees = GBM_TREES,
              interaction.depth = 11,
              n.minobsinnode = 10 );

gbm.trainPredicted <- predict( myGBM,
                               myTrainSub[,-1],
                               type = "response",
                               n.trees = GBM_TREES );

scoreGBM = logLoss( myTrain[,1], gbm.predicted );


gbm.testPredicted <- predict( myGBM,
                          myTestSub,
                          type = "response",
                          n.trees = GBM_TREES );
