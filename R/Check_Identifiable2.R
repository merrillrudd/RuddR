#' Check for identifiability of fixed effects
#'
#' \code{Check_Identifiable} calculates the matrix of second-derivatives of the marginal likelihood w.r.t. fixed effects, to see if any linear combinations are unidentifiable
#'
#' @param obj, The compiled object
#'
#' @return A tagged list of the hessian and the message

#' @export
Check_Identifiable2 = function( obj ){
  # Finite-different hessian
  ParHat = TMBhelper:::extract_fixed( obj )
  List = NULL
  List[["Hess"]] = optimHess( par=ParHat, fn=obj$fn, gr=obj$gr )

  # Check eigendecomposition
  List[["Eigen"]] = eigen( List[["Hess"]] )
  List[["WhichBad"]] = which( List[["Eigen"]]$values < sqrt(.Machine$double.eps) )

  # Check for parameters
  if(is.matrix(List[["Eigen"]]$vectors[,List[["WhichBad"]]])) RowMax = apply( List[["Eigen"]]$vectors[,List[["WhichBad"]]], MARGIN=1, FUN=function(vec){max(abs(vec))} )
  if(!is.matrix(List[["Eigen"]]$vectors[,List[["WhichBad"]]])) RowMax = max(abs(List[["Eigen"]]$vectors[,List[["WhichBad"]]]))
  List[["BadParams"]] = data.frame("Param"=names(obj$par), "MLE"=ParHat, "Param_check"=ifelse(RowMax>0.1, "Bad","OK"))

  # Message
  if( length(List[["WhichBad"]])==0 ){
    message( "All parameters are identifiable" )
  }else{
    print( List[["BadParams"]] )
  }

  # Return
  return( invisible(List) )
}