
#Packages
library( "R.utils" );

#Function Includes
source( "Helpers.r" );

#load data
load( "Latest.RData");
#===Main====

#Load data
source( "DataLoader.r" );

#Feature selection
setwd( "../" );
source( "FeatureSelection.r" );

#Add cluster feature

#Execute predictors
#Add Classification
source( "AddKNNClassification.r" );

source( "GBM.r" );
source( "RandomForests.r" );
source( "EnsembledSVM.r" );
save.image( "Latest.RData" );
