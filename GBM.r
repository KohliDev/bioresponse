#Packages
library( "gbm" );
library( "ROCR" );

#Settings
GBM_TREES = 40000;



myGBM <- gbm( formula( myTrainSub ),
              data = myTrainSub,
              distribution = "bernoulli",
              cv.folds = 4,
              n.trees = GBM_TREES,
              interaction.depth = 9,
              n.minobsinnode = 10 );

gbm.validPredicted <- predict( myGBM,
                               myValidSub[,-1],
                               type = "response",
                               n.trees = GBM_TREES );

gbm.testPredicted <- predict( myGBM,
                          myTestSub,
                          type = "response",
                          n.trees = GBM_TREES );

#measure performance
scoreGBM <- logLoss( myValidSub[,1], abs( 0.0000001 - gbm.validPredicted ) );
accuracyGBM <- sum( myValidSub[,1] == ( gbm.validPredicted > 0.5 ) ) / nrow( myValidSub );
confusionGBM <- table( myValidSub$Activity, gbm.validPredicted > 0.5 );
gbm.pred <- prediction( gbm.validPredicted, myValidSub[,1] );
gbm.perf <- performance( gbm.pred, "tpr", "fpr" );

