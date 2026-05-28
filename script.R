library(terra)

# List mask files
files <- list.files("segmentation_A", pattern = ".png$")

# Class definitions
classes <- c(
  "glomerulus" = 1,
  "vessels" = 2,
  "tubules" = 3,
  "interstitium" = 4
)

# Minimum number of pixels required
min_pixels <- 50

# Empty dataframe
results <- data.frame()

# Loop through files
for (f in files) {
  
  # Load masks
  img1 <- rast(paste0("segmentation_A/", f))
  img2 <- rast(paste0("segmentation_B/", f))
  
  # Convert to matrices
  img1 <- as.matrix(img1)
  img2 <- as.matrix(img2)
  
  # Loop through classes
  for (class_name in names(classes)) {
    
    class_value <- classes[class_name]
    
    # Binary masks
    mask1 <- img1 == class_value
    mask2 <- img2 == class_value
    
    # Number of pixels for each annotator
    size1 <- sum(mask1)
    size2 <- sum(mask2)
    
    intersection <- sum(mask1 & mask2)
    
    # Ignore tiny structures
    if (size1 < min_pixels & size2 < min_pixels) {
      
      dice <- NA
      iou <- NA
      
    } else {
      
      # Dice
      denominator <- size1 + size2
      
      if (denominator == 0) {
        dice <- NA
      } else {
        dice <- (2 * intersection) / denominator
      }
      
      # IoU
      union <- size1 + size2 - intersection
      
      if (union == 0) {
        iou <- NA
      } else {
        iou <- intersection / union
      }
    }
    
    # Save result
    results <- rbind(
      results,
      data.frame(
        file = f,
        class = class_name,
        dice = dice,
        iou = iou
      )
    )
  }
}

# Show results
print(results)

# Save to CSV
write.csv(results, "dice_iou_results.csv", row.names = FALSE)

# Mean per class
aggregate(cbind(dice, iou) ~ class,
          data = results,
          FUN = mean,
          na.rm = TRUE)

# Standard deviation per class
aggregate(cbind(dice, iou) ~ class,
          data = results,
          FUN = sd,
          na.rm = TRUE)