# Kidney Segmentation Validation using DSC and IoU

This repository contains R scripts for interobserver validation of kidney histology segmentation in unstained brightfield images using the Dice similarity coefficient (DSC) and intersection over union (IoU).

## Structures analyzed
- Glomerulus
- Vessels
- Tubules
- Interstitium

## Method
Multiclass segmentation masks exported from QuPath were compared using DSC calculations in R. The 512x512 masks exported are in PNG format and the following values were atributed to each class:
- Glomerulus - 1
- Vessels - 2
- Tubules - 3 
- Interstitium - 4 

A minimum sum of 50 pixels of structure representation is required to perform calculations.

## Requirements
- R
- terra package

## Usage

Download and extract the ValidationSegmentation zipped folder.

Set Working Directory to ValidationSegmentation folder. In this folder you should find two other folders: segmentation_A and segmentation_B.

Run:

```r
source("script.R")
```
## Results

This script will return a results.csv file containing all data extracted for each tile. It will also return in the console the Mean and standard deviation of Dice and IoU per class.
