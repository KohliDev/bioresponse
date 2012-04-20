
#Combine
combined.validPredictions <- ( rf.predictions[,2] +  esvm.validPredictions ) / 2.0;
combined.testPredictions <- ( rf.testPredictions[,2] + svm.testPredictions[,2] +  ennet.testPredictions ) / 2.0;
#Measure
scoreCombined <-  logLoss( myValidSub[,1], abs( 0.000001 - combined.validPredictions ) );
accuracyCombined <- sum( myValidSub[,1] == ( combined.validPredictions > 0.5 ) ) / nrow( myValidSub );
confusionCombined <- table( myValidSub$Activity, combined.validPredictions > 0.5);
combined.pred <- prediction( combined.validPredictions, myValidSub[,1] );
combined.perf <- performance( combined.pred, "tpr", "fpr" );