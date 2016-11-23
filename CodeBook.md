#CodeBook - Getting and Cleaning Data Course Project


This CodeBook provides information on the dataset created by the R script ```run_analysis.R```, which is available in the same Github repository.

###Source Data

The script is based on the "UCI Human Activity Recognition database", built from the recordings of 30 subjects performing activities of daily living (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while carrying a waist-mounted smartphone with embedded inertial sensors.
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals (Frequency domain).

```

####Signals used:

**Time Domain:**
* Body Acceleration Jerk Magnitude
* Body Acceleration Jerk (3 axial)
* Body Acceleration Magnitude
* Body Acceleration (3 axial)
* Body Angularvelocity Jerk Magnitude
* Body Angularvelocity Jerk (3 axial)
* Body Angularvelocity Magnitude
* Body Angularvelocity (3 axial)
* Gravity Acceleration Magnitude
* Gravity Acceleration (3 axial)

**Frequency Domain**
* Body Acceleration Jerk Magnitude
* Body Acceleration Jerk (3 axial)
* Body Acceleration Magnitude
* Body Acceleration (3 axial)
* Body Angularvelocity Jerk Magnitude
* Body Angularvelocity Magnitude
* Body Angularvelocity (3 axial)

A broad range of variables were estimated from these signals, two of which are relevant for this analysis:
* mean: 	Mean value
* stddev: Standard deviation

```

For more details on the source data, see: 
*Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science.*
<https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

###Resulting Data

The resulting data file provides an aggregated list of subjects and activities with an average of each measured variable.

####subject
Identifier of the subject performing the experiment.

Type: numeric

Possible values: 1 - 30

####activity
Name of the activity performed

Type: char

Possible values:
* LAYING
* SITTING
* STANDING
* WALKING
* WALKING_DOWNSTAIRS
* WALKING_UPSTAIRS

####measurement
Variable calculated for each variable and domain (time / frequency). Names of the variables can be found in the table below.

Type: float


| Variable | Time Domain| Frequency Domain | 
| ---------------------------------------------------------------------- | ----------------------------------------------------------------------| ---------------------------------------------------------------------- | 
| **Body Acceleration Jerk Magnitude Mean** | *time-body-acceleration-jerk-magnitude-mean* | *frequency-body-acceleration-jerk-magnitude-mean* | 
| **Body Acceleration Jerk Magnitude Standard Deviation** | *time-body-acceleration-jerk-magnitude-stddev* | *frequency-body-acceleration-jerk-magnitude-stddev* | 
| **Body Acceleration Jerk Mean X-Axis** | *time-body-acceleration-jerk-mean-x* | *frequency-body-acceleration-jerk-mean-x* | 
| **Body Acceleration Jerk Mean Y-Axis** | *time-body-acceleration-jerk-mean-y* | *frequency-body-acceleration-jerk-mean-y* | 
| **Body Acceleration Jerk Mean Z-Axis** | *time-body-acceleration-jerk-mean-z* | *frequency-body-acceleration-jerk-mean-z* | 
| **Body Acceleration Jerk Standard Deviation X-Axis** | *time-body-acceleration-jerk-stddev-x* | *frequency-body-acceleration-jerk-stddev-x* | 
| **Body Acceleration Jerk Standard Deviation Y-Axis** | *time-body-acceleration-jerk-stddev-y* | *frequency-body-acceleration-jerk-stddev-y* | 
| **Body Acceleration Jerk Standard Deviation Z-Axis** | *time-body-acceleration-jerk-stddev-z* | *frequency-body-acceleration-jerk-stddev-z* | 
| **Body Acceleration Magnitude Mean** | *time-body-acceleration-magnitude-mean* | *frequency-body-acceleration-magnitude-mean* | 
| **Body Acceleration Magnitude Standard Deviation** | *time-body-acceleration-magnitude-stddev* | *frequency-body-acceleration-magnitude-stddev* | 
| **Body Acceleration Mean X-Axis** | *time-body-acceleration-mean-x* | *frequency-body-acceleration-mean-x* | 
| **Body Acceleration Mean Y-Axis** | *time-body-acceleration-mean-y* | *frequency-body-acceleration-mean-y* | 
| **Body Acceleration Mean Z-Axis** | *time-body-acceleration-mean-z* | *frequency-body-acceleration-mean-z* | 
| **Body Acceleration Standard Deviation X-Axis** | *time-body-acceleration-stddev-x* | *frequency-body-acceleration-stddev-x* | 
| **Body Acceleration Standard Deviation Y-Axis** | *time-body-acceleration-stddev-y* | *frequency-body-acceleration-stddev-y* | 
| **Body Acceleration Standard Deviation Z-Axis** | *time-body-acceleration-stddev-z* | *frequency-body-acceleration-stddev-z* | 
| **Body Angular Velocity Jerk Magnitude Mean** | *time-body-angularvelocity-jerk-magnitude-mean* | *frequency-body-angularvelocity-jerk-magnitude-mean* | 
| **Body Angular Velocity Jerk Magnitude Standard Deviation** | *time-body-angularvelocity-jerk-magnitude-stddev* | *frequency-body-angularvelocity-jerk-magnitude-stddev* | 
| **Body Angular Velocity Jerk Mean X-Axis** | *time-body-angularvelocity-jerk-mean-x* | | 
| **Body Angular Velocity Jerk Mean Y-Axis** | *time-body-angularvelocity-jerk-mean-y* | | 
| **Body Angular Velocity Jerk Mean Z-Axis** | *time-body-angularvelocity-jerk-mean-z* | | 
| **Body Angular Velocity Jerk Standard Deviation X-Axis** | *time-body-angularvelocity-jerk-stddev-x* | | 
| **Body Angular Velocity Jerk Standard Deviation Y-Axis** | *time-body-angularvelocity-jerk-stddev-y* | | 
| **Body Angular Velocity Jerk Standard Deviation Z-Axis** | *time-body-angularvelocity-jerk-stddev-z* | | 
| **Body Angular Velocity Magnitude Mean** | *time-body-angularvelocity-magnitude-mean* | *frequency-body-angularvelocity-magnitude-mean* | 
| **Body Angular Velocity Magnitude Standard Deviation** | *time-body-angularvelocity-magnitude-stddev* | *frequency-body-angularvelocity-magnitude-stddev* | 
| **Body Angular Velocity Mean X-Axis** | *time-body-angularvelocity-mean-x* | *frequency-body-angularvelocity-mean-x* | 
| **Body Angular Velocity Mean Y-Axis** | *time-body-angularvelocity-mean-y* | *frequency-body-angularvelocity-mean-y* | 
| **Body Angular Velocity Mean Z-Axis** | *time-body-angularvelocity-mean-z* | *frequency-body-angularvelocity-mean-z* | 
| **Body Angular Velocity Standard Deviation X-Axis** | *time-body-angularvelocity-stddev-x* | *frequency-body-angularvelocity-stddev-x* | 
| **Body Angular Velocity Standard Deviation Y-Axis** | *time-body-angularvelocity-stddev-y* | *frequency-body-angularvelocity-stddev-y* | 
| **Body Angular Velocity Standard Deviation Z-Axis** | *time-body-angularvelocity-stddev-z* | *frequency-body-angularvelocity-stddev-z* | 
| **Gravity Acceleration Magnitude Mean** | *time-gravity-acceleration-magnitude-mean* | | 
| **Gravity Acceleration Magnitude Standard Deviation** | *time-gravity-acceleration-magnitude-stddev* | | 
| **Gravity Acceleration Mean X-Axis** | *time-gravity-acceleration-mean-x* | | 
| **Gravity Acceleration Mean Y-Axis** | *time-gravity-acceleration-mean-y* | | 
| **Gravity Acceleration Mean Z-Axis** | *time-gravity-acceleration-mean-z* | | 
| **Gravity Acceleration Standard Deviation X-Axis** | *time-gravity-acceleration-stddev-x* | | 
| **Gravity Acceleration Standard Deviation Y-Axis** | *time-gravity-acceleration-stddev-y* | | 
| **Gravity Acceleration Standard Deviation Z-Axis** | *time-gravity-acceleration-stddev-z* | | 

