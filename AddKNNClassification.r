library( "clue" );
library( "kernlab" );
library( "class" );

source( "KNN.r" );

#Add KNN

knn.trainAllPredicted = matrix( knn.trainAllPredicted, ncol = 1, byrow=TRUE );
colnames( knn.trainAllPredicted) <- c( "KNN" );
knn.trainPredicted = matrix( knn.trainPredicted, ncol = 1, byrow=TRUE );
colnames( knn.trainPredicted) <- c( "KNN" );
knn.validPredicted = matrix( knn.validPredicted, ncol = 1, byrow=TRUE );
colnames( knn.validPredicted ) <- c( "KNN" );
knn.testPredicted = matrix( knn.testPredicted, ncol = 1, byrow=TRUE );
colnames( knn.testPredicted ) <- c( "KNN" );

myTrainAllSub <- cbind( myTrainAllSub, knn.trainAllPredicted );
myTrainSub <- cbind( myTrainSub, knn.trainPredicted );
myValidSub <- cbind( myValidSub, knn.validPredicted );
myTestSub <- cbind( myTestSub, knn.testPredicted );

dimTrainAllSub <- dim( myTrainAllSub );
dimTrainSub <- dim( myTrainSub );
dimValidSub <- dim( myValidSub );
dimTestSub <- dim( myTestSub );






