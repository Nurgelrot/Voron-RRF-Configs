G92 X0

if !move.axes[1].homed
	; raise Z a bit
	G91
	G1 H2 Z5 F2400
	G90


M913 X75 Y75 ; lower the power bucuse we have been burned.

; Move quickly to X axis endstop and stop there (first pass)
G91
G1 X355 F6000 H1
; Go back a few mm
;M119
G1 X-5 F8000
; Move slowly to X axis endstop once more (second pass)
G1 X10 F255 H1
G90
M913 X100 Y100; back to full power