M290 R0 S0    ;  clear baby stepping
M561          ;  reset all bed adjustments
M400 S1         ;  flush move queue

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
	echo "not all axes homed, homing axes first"
	G28


G90
G1 Z10 ;F2000
M913 X75 Y75 Z75
G30 K0 P0 X15 Y15 Z-99999
G30 K0 P1 X15 Y105 Z-99999
G30 K0 P2 X105 Y105 Z-99999
G30 K0 P3 X105 Y15 Z-99999 S4
echo "Current course pass deviation: " ^ move.calibration.initial.deviation
;

while move.calibration.initial.deviation > 0.008
	if iterations >= 5
		echo "Error: Max attemps failed. Deviation: " ^ move.calibration.initial.deviation
		break
	echo "Deviation over threshold. Executing pass" , iterations+3, "deviation", move.calibration.initial.deviation
	G30 K0 P0 X15 Y15 Z-99999
	G30 K0 P1 X15 Y105 Z-99999
	G30 K0 P2 X105 Y105 Z-99999
	G30 K0 P3 X105 Y15 Z-99999 S4
	echo "Current deviation: " ^ move.calibration.initial.deviation
	continue
echo "Final deviation: " ^ move.calibration.initial.deviation
G28 Z
M913 X100 Y100 Z100
