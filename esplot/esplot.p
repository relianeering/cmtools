# CM Point sE spectrum plot
# CBM Dreamer, Relianeering AB
# The plot is designed to gnerate in pdf multispectra plots from sE data
#
# startF = 0
# endF = 500
# rpm = 60
# datafile = "data.env"
#
# Define line colors
#
set style line 1 lt 1 lc rgb "orange" pt 2
# round function 7.4 -> 7 | 7.6 -> 8
round(x) = x - floor(x) < 0.5 ? floor(x) : ceil(x)
#
# Compute plot data
#
fMax = 2000.0
lines = 3200.0
resolution = fMax / lines
set1X = rpm / 60
windowF = 1.5
#
startInd = round(startF / resolution) + 1
endInd = round(endF / resolution) + 1
bandLines = endInd - startInd
myXtics = round((endF - startF) / 20)
#
# compute stat data 
#
stats datafile every ::1 using 2 name "A" nooutput
stats datafile every ::startInd::endInd using (($0 + startInd - 1)):2 name "B" nooutput
rms_A = sqrt(A_sumsq / windowF)
rms_B = sqrt(B_sumsq_y / windowF)
#
# set labels on the bottom of the graph
#
set xlabel "Frequency in Hz"
set ylabel "sE"
set label 1 sprintf("Resolution: %1.3f Hz | RPM: %d | 1X: %3.3f Hz", resolution, rpm, set1X) at graph 0, graph -0.1
set label 2 sprintf("Spectrum max: %3.3f sE at %4.3f Hz | Overall: %3.3f sE rms", A_max, (A_index_max * resolution), rms_A) at graph 0, graph -0.15
set label 3 sprintf("Band (%d to %d Hz) max: %3.3f sE at %4.3f Hz | Overall: %3.3f sE rms", startF, endF, B_max_y, ((B_index_max_y + startInd -1) * resolution), rms_B) at graph 0, graph -0.2
#
# Plot and grid setup
#
set border 0
set grid
set xtics 0, myXtics

plot [startF:endF] datafile every ::startInd::endInd using (($0 + startInd - 1)*resolution):2 ls 1 with lines title("sE")
