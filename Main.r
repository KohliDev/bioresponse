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

#Execute predictors

source( "EnsembledSVM.r" );
source( "GBM.r" );


#Add Classification
source( "AddKNNClassification.r" );
source( "RandomForests.r" );

