#' Empty figure
#'
#' \code{eplot} Plot empty figure to fill with base plotting (e.g. lines, polygons, points, etc.)
#' @author M.B. Rudd
#' 
#' @param base_size default text size for figure, default=14
#' @param base_family font type for figure, default=""
#' 
#' @return empty plot 
#' @export
eplot <- function(...){
	plot(x=1,y=1,type="n",axes=F,ann=F,...)
}