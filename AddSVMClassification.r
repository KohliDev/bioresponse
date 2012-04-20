source( "SVMs.r" );

addsvm.CVNum = 4;
addsvm.smallN <- round( nrow( myTrainSub ) / addsvm.CVNum ) * addsvm.CVNum;
addsvm.trainPredictions <- NULL;

for( i in 1:addsvm.CVNum )
{
  addsvm.valids <- ( addsvm.smallN* ( i - 1 ) / addsvm.CVNum + 1 ):( addsvm.smallN * i / addsvm.CVNum);
  rx <- as.matrix( myTrainSub[-addsvm.valids,-1] );
  ry <- as.matrix( myTrainSub[-addsvm.valids,1], drop=FALSE );
  myAddSVM <- ksvm(rx,
                    ry,
                    kernel="rbfdot",
                    type="C-svc",
                    C=5,
                    prob.model=TRUE );

  addsvm.tempPreds <- predict( myAddSVM, myTrainSub[addsvm.valids,-1], type="probabilities" );
  
  addsvm.trainPredictions <- rbind( addsvm.trainPredictions, addsvm.tempPreds );
}

if(addsvm.smallN < nrow( myTrainSub ) )
{
  addsvm.tempPreds <- predict( myAddSVM, myTrainSub[addsvm.smallN:nrow(myTrainSub),-1], type="probabilities" );
  addsvm.trainPredictions <- rbind( addsvm.trainPredictions, addsvm.tempPreds );
}

#Add to data
addsvm.trainAllPredicted <- rbind( addsvm.trainPredictions, svm.validPredictions )[,2];
addsvm.trainAllPredicted = matrix( addsvm.trainAllPredicted, ncol = 1, byrow=TRUE );
colnames( addsvm.trainAllPredicted) <- c( "SVM" );

addsvm.trainPredicted <- addsvm.trainPredictions[,2];
addsvm.trainPredicted = matrix( addsvm.trainPredicted , ncol = 1, byrow=TRUE );
colnames( addsvm.trainPredicted) <- c( "SVM" );

addsvm.validPredicted <- svm.validPredictions[,2];
addsvm.validPredicted = matrix( addsvm.validPredicted, ncol = 1, byrow=TRUE );
colnames( addsvm.validPredicted ) <- c( "SVM" );

addsvm.testPredicted <- svm.testPredictions[,2];
addsvm.testPredicted = matrix( addsvm.testPredicted, ncol = 1, byrow=TRUE );
colnames( addsvm.testPredicted ) <- c( "SVM" );

myTrainAllSub <- cbind( myTrainAllSub, addsvm.trainAllPredicted );
myTrainSub <- cbind( myTrainSub, addsvm.trainPredicted );
myValidSub <- cbind( myValidSub, addsvm.validPredicted );
myTestSub <- cbind( myTestSub, addsvm.testPredicted );

dimTrainAllSub <- dim( myTrainAllSub );
dimTrainSub <- dim( myTrainSub );
dimValidSub <- dim( myValidSub );
dimTestSub <- dim( myTestSub );



