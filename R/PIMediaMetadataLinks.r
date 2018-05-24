PIMediaMetadataLinks <- function(self = NULL, owner = NULL, mediaData = NULL) {
	if (is.null(self) == FALSE) {
		if (is.character(self) == FALSE) {
			return (print(paste0("Error: self must be a string.")))
		}
	}
	if (is.null(owner) == FALSE) {
		if (is.character(owner) == FALSE) {
			return (print(paste0("Error: owner must be a string.")))
		}
	}
	if (is.null(mediaData) == FALSE) {
		if (is.character(mediaData) == FALSE) {
			return (print(paste0("Error: mediaData must be a string.")))
		}
	}
	value <- list(
	Self = self,
	Owner = owner,
	MediaData = mediaData)
	valueCleaned <- rmNullObs(value)
	attr(valueCleaned, "className") <- "PIMediaMetadataLinks"
	return(valueCleaned)
}
