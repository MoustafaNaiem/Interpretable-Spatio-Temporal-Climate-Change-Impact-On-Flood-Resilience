# Interpretable-Spatio-Temporal-Climate-Change-Impact-On-Flood-Resilience
This repository set is for the case study discussed in the manuscript titled "Interpretable Spatiotemporal Climate Change Impact on Flood Resilience"
Interpretable Spatiotemporal Climate Change Impact on Flood Resilience
Moustafa Naiem Abdel-Mooty*, Paulin Coulibaly, and Wael El-Dakhakhni. Depratment of Civil Engineering, McMaster University, Hamilton, Canada.

Overview: 
We developed a data-driven methodology to investigate the impact of climate change induced flood hazard on the community reslience. We employed a resilience-based categorization from the study published by Abdel-Mooty et. al. (2021), where an unsupervised ML model was employed to develop a 5-category based system. The model was applied to all mainland states in the USA, and the results were comprehensive for a country-wide spatial analysis at a state-level resolution. 
For the study developed herein, the State of Texas was chosen, and the resolution was changed to county-wide resolution. For this study, multiple supervised ML models were developed and optimized for multiple climate change emission scenarios (i.e., RCP 6.0 and RCP 8.5), where 45 counties within the state of texas were identified, and the collection stations within them were used for the collection, synchronization, and employment of the multiple datasets needed in the study. 

Datasets: 
The datasets used in this article are publicly available. The meteorological disaster database used in the generation of the resilience categories is provided by the NWS, a sub-agency under the National Oceanic and Atmospheric Administration (NOAA), available at  (https://www.ncei.noaa.gov/pub/data/swdi/stormevents/csvfiles/). The historical climate data used is provided by Global Historical Climatology Network, a sub-agency under NOAA, and is available at (https://www.ncdc.noaa.gov/cdo-web/search?datasetid=GHCND), and the BCSD CMIP5 projections and simulations can be conducted and accessed through (https://gdo-dcp.ucllnl.org/downscaled_cmip_projections/). 

Data gathering:
The datasets included in this study are all publicly available, and unique to each specific location, study duration, resolution, and objective. One file is included in this repository, the RCP 8.5 raw dataset, named: Merged_Texascounties_RCP8_3Cats

Date Cleaning and preprocessing:
The flood disaster records for each of the 45 counties in the state of texas were gathered and assigned a resilience category for each data record. These categories were coupled with climate information at the location and exact time of the recorded disaster. for each month, the disaster categories were aggregated, and an average index was assigned for each month from the year 1996 up to the year 2020, and coupled with the average climate information for said month. Monthly Climate projections were gathered from the collection stations at each of those locations, and added as variables. The projections employed were the results of 16 GCMs, and thus, the variables were repeated 16 times (once for each model). Misclassification Error was used and employed through all possible combination from those models, and the best performing model (for both emission scenarios RCP 6.0 and 8.5) were employed for RandomForest, and Bagged Decision Trees. More details on these models  can be found in the main Manuscript.

Data File:
Merged_Texascounties_RCP8_3Cats
This dataset contains 167 variable, and 4325 observations. The variables are the historic disaster records, and the corresponding climate information from the different GCMs. This dataset was used in the development of the ML model.

Code Contents:
The main Code files: 
1- Bagged DT RCP8.R
2- Bagged DT RCP6.R
3- RandomForest 300 RCP 8.R
4- RandomForest 300 RCP 6.R

Bagged Dt RCP8.R : This model calls the dataset with the best-fit model for RCP 8.5, then conduct data transformation and preprocessing for the development of the ML model. The data is then split between training and testing at a 70%-30% ratio, respectively. The model then identifies the independent variable and the dependent variables, then employs the Bagged Decision Tree model to train the data on the training subset. Model performance is then assessed against the testing dataset, and if appropriate, the model is then employed on the monthly projections (2021-2050), and the prediction result is recorded and saved in an excel file for further investigation. The Code also includes determining the Variable importance.

Bagged Dt RCP6.R : This model calls the dataset with the best-fit model for RCP 6.0, then conduct data transformation and preprocessing for the development of the ML model. The data is then split between training and testing at a 70%-30% ratio, respectively. The model then identifies the independent variable and the dependent variables, then employs the Bagged Decision Tree model to train the data on the training subset. Model performance is then assessed against the testing dataset, and if appropriate, the model is then employed on the monthly projections (2021-2050), and the prediction result is recorded and saved in an excel file for further investigation. The Code also includes determining the Variable importance.

RandomForest 300 RCP 8.R : This model calls the dataset with the best-fit model for RCP 8.5, then conduct data transformation and preprocessing for the development of the ML model. The data is then split between training and testing at a 70%-30% ratio, respectively. The model then identifies the independent variable and the dependent variables, then employs the Random Forest model to train the data on the training subset. Model performance is then assessed against the testing dataset. The model is then optimized using the Out-of-Bag error, and the number of trees in the RF can be adjusted accordingly. The code attached runs for 300 trees. If appropriate, the model is then employed on the monthly projections (2021-2050), and the prediction result is recorded and saved in an excel file for further investigation. 

RandomForest 300 RCP 6.R : This model calls the dataset with the best-fit model for RCP 6.0, then conduct data transformation and preprocessing for the development of the ML model. The data is then split between training and testing at a 70%-30% ratio, respectively. The model then identifies the independent variable and the dependent variables, then employs the Random Forest model to train the data on the training subset. Model performance is then assessed against the testing dataset. The model is then optimized using the Out-of-Bag error, and the number of trees in the RF can be adjusted accordingly. The code attached runs for 300 trees. If appropriate, the model is then employed on the monthly projections (2021-2050), and the prediction result is recorded and saved in an excel file for further investigation. 

Hardware Requirements:
An Intel-compatible platform running Windows 11, 10 /8.1/8 /7 /Vista /XP /2000 Windows Server 2022, 2019 /2016 /2012 /2008 /2003
At least 256 MB of RAM, a mouse, and enough disk space for recovered files, image files, etc.
The administrative privileges are required to install and run R‑Studio utilities.
A network connection for data recovering over network.

Software Requirements:
The code developed and run using RStudio operating systems. Installation Guide: No installation required.
