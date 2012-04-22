#Packages
library( "R.utils" );

#Function Includes
source( "Helpers.r" );

#===Main====

load( "Latest.RData" );

#Load data
source( "DataLoader.r" );


#Feature selection
setwd( "../" );
source( "FeatureSelection.r" );

#Add cluster feature

#Execute predictors

source( "EnsembledSVM.r" );
#source( "EnsembledNN.r" );
#Add Classification
source( "AddKNNClassification.r" );

source( "GBM.r" );


source( "RandomForests.r" );

save.image( "Latest.RData" );
