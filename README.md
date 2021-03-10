# Data-cleaning-Project_HCM
# March 10, 2021/ R studio version 1.3.959

# Comments and Checklist:
# Downloaded all files using download.file() and unzipped files with unzip()
# pulled out files needed for new data set and defined the wanted features
# Using cbind(), combined all three training files and all three testing files
# Using rbind() created "newdata" by binding "train" ontop of "test"
# Then got mean and standard deviation of "newdata" columns using grep()
# Reshaped the data so that subjects and activities become variables of two independent columns using a pipe and select()
# added on mean and standard deviation columns
# The residual columns were named using names() and gsub (accelerometer and gyroscope etc.)










