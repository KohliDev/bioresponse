library( "clue" );

myKMeans <- kmeans( myTrainAllSub[,-1], centers = 5, nstart = 20 );

myClustersTrainAllSub <- matrix( cl_predict( myKMeans, myTrainAllSub ), ncol=1 );
colnames( myClustersTrainAllSub ) <- c( "Cluster" );
myClustersTrainSub <- matrix( cl_predict( myKMeans, myTrainSub ), ncol=1 );
colnames( myClustersTrainSub ) <- c( "Cluster" );
myClustersValidSub <- matrix( cl_predict( myKMeans, myValidSub ), ncol=1 );
colnames( myClustersValidSub ) <- c( "Cluster" );
myClustersTestSub <- matrix( cl_predict( myKMeans, myTestSub ), ncol=1 );
colnames( myClustersTestSub ) <- c( "Cluster" );

myTrainAllSub <- cbind( myTrainAllSub, myClustersTrainAllSub   );
myTrainSub <- cbind( myTrainSub, myClustersTrainSub );
myValidSub <- cbind( myValidSub, myClustersValidSub );
myTestSub <- cbind( myTestSub, myClustersTestSub );

dimTrainAllSub <- dim( myTrainAllSub );
dimTrainSub <- dim( myTrainSub );
dimValidSub <- dim( myValidSub );
dimTestSub <- dim( myTestSub );




