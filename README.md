# DICE-Sorensen-Coefficient-in-R

# Kidney Segmentation Validation

This repository contains R scripts for interobserver validation of kidney histology segmentation masks using the Dice similarity coefficient.

## Structures analyzed
- Glomerulus
- Vessels
- Tubules
- Interstitium

## Method
Multiclass segmentation masks exported from QuPath were compared using Dice coefficient calculations in R.

## Requirements
- R
- terra package

## Usage
Run:

```r
source("dice_segmentation_validation.R")
```
