
# Simulation of Time signal polar plot
# CBM Dreamer, Relianeering AB
# The plot is designed for maximum 5 shaft turns
#
# Define line colors
#
set style line 1 lt 1 lc rgb "gray" pt 1
set style line 2 lt 1 lc rgb "purple" pt 1
set style line 3 lt 1 lc rgb "blue" pt 1
set style line 4 lt 1 lc rgb "black" pt 1
set style line 5 lt 1 lc rgb "orange" pt 1
#
# Compute plot data
#
timeLS = 3
# multiplier = 1
# toffset = 5
# rpm = 1500.0
# datafile = "data.twf"
sampleN = 44100
turnTS = 60 / rpm
numberT = timeLS / turnTS
numberRad = numberT * 2 * pi
turnS = int(sampleN * turnTS)
pangle = 2 * pi / turnS


sturn1 = 1
sturn2 = sturn1 + turnS
sturn3 = sturn2 + turnS
sturn4 = sturn3 + turnS
sturn5 = sturn4 + turnS
sturnL = sturn5 + turnS
toff1 = toffset
toff2 = 2 * toffset
toff3 = 3 * toffset
toff4 = 4 * toffset
toff5 = 5 * toffset

#
# Get statistical data from the time signal
#
stats datafile every ::1 using 1 name "A" nooutput
#
# set labels on the bottom of the graph
set label 1 sprintf("Scale: 1g is %d graph unit(s)", multiplier) at graph -0.07, graph 0.03
set label 2 sprintf("Turns offset: %d", toffset) at graph -0.07, graph 0
set label 3 sprintf("Max: %2.3f g | Min: %2.3f g | Standard DEV: %2.4f g",A_max, A_min, A_stddev) at graph -0.07, graph -0.07
set label 4 sprintf("RPM: %d | Turns: %3.0f | Turn time: %1.5f s | Samples in a turn: %d", rpm, numberT, turnTS, turnS) at graph -0.07, graph -0.1

#
# Plot and grid setup
#
# set size square
set border 0
set polar
set grid r polar 15
set rrange[0:toffset*6]
set ttics 0,15
set mttics 3
unset xtics
unset ytics
unset raxis

plot datafile every ::sturn1::sturn2 using (($0 - sturn1) * pangle):($1*multiplier+toff1) ls 1 with lines title 'Turn 1', \
	 datafile every ::sturn2::sturn3 using (($0 - sturn2) * pangle):($1*multiplier+toff2) ls 2 with lines title 'Turn 2', \
	 datafile every ::sturn3::sturn4 using (($0 - sturn3) * pangle):($1*multiplier+toff3) ls 3 with lines title 'Turn 3', \
	 datafile every ::sturn4::sturn5 using (($0 - sturn4) * pangle):($1*multiplier+toff4) ls 4 with lines title 'Turn 4', \
	 datafile every ::sturn5::sturnL using (($0 - sturn5) * pangle):($1*multiplier+toff5) ls 5 with lines title 'Turn 5'
