logLoss <- function( y, yhat )
{
  ylen <- length( y );
  loss <- 0.0;
  for( i in 1:ylen )
  {
    loss <- loss + y[i]*log( yhat[i] ) + ( 1 - y[i])*log( 1.0 - yhat[ i ] );
  }

  loss <- - loss / ylen;
  
  return( loss );
};