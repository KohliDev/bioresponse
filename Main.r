#Packages
library( "R.utils" );

#Function Includes
source( "Helpers.r" );


#===Main====

#Load data
source( "DataLoader.r" );

#Feature selection
setwd( "../" );
source( "FeatureSelection.r" );

#Add cluster feature
source( "AddCluster.r" );
#Execute predictors

#source( "RandomForests.r" );
source( "GBM.r" );

