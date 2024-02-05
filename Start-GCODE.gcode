; MODIFIED PRUSA ORIGINAL START G-CODE


M17 ; enable steppers
M862.3 P "[printer_model]" ; printer model check
M862.1 P[nozzle_diameter] ; nozzle diameter check
M115 U5.1.2+13478
M555 X{(min(print_bed_max[0], first_layer_print_min[0] + 32) - 32)} Y{(max(0, first_layer_print_min[1]) - 4)} W{((min(print_bed_max[0], max(first_layer_print_min[0] + 32, first_layer_print_max[0])))) - ((min(print_bed_max[0], first_layer_print_min[0] + 32) - 32))} H{((first_layer_print_max[1])) - ((max(0, first_layer_print_min[1]) - 4))}

G90 ; use absolute coordinates
M83 ; extruder relative mode

M140 S[first_layer_bed_temperature] ; set bed temp
M104 T0 S{((filament_type[0] == "PC" or filament_type[0] == "PA") ? (first_layer_temperature[0] - 25) : (filament_type[0] == "FLEX" ? 210 : (filament_type[0]=~/.*PET.*/ ? 175 : 170)))} ; set extruder temp for bed leveling
M109 T0 R{((filament_type[0] == "PC" or filament_type[0] == "PA") ? (first_layer_temperature[0] - 25) : (filament_type[0] == "FLEX" ? 210 : (filament_type[0]=~/.*PET.*/ ? 175 : 170)))} ; wait for temp

M84 E ; turn off E motor

G28 ; home all without mesh bed level

G1 X{10 + 32} Y-4 Z5 F4800

M302 S160 ; lower cold extrusion limit to 160C

{if filament_type[initial_tool]=="FLEX"}
G1 E-4 F2400 ; retraction
{else}
G1 E-2 F2400 ; retraction
{endif}

M84 E ; turn off E motor

G29 P9 X10 Y-4 W32 H4

{if first_layer_bed_temperature[initial_tool]<=60}M106 S100{endif}

G0 Z40 F10000

M190 S[first_layer_bed_temperature] ; wait for bed temp

M107

;
; MBL
;
M84 E ; turn off E motor
G29 P1 ; invalidate mbl & probe print area
G29 P1 X0 Y0 W50 H20 C ; probe near purge place
G29 P3.2 ; interpolate mbl probes
G29 P3.13 ; extrapolate mbl outside probe area
G29 A ; activate mbl

; prepare for purge
M104 S{first_layer_temperature[0]}
G0 X0 Y-4 Z15 F4800 ; move away and ready for the purge
M109 S{first_layer_temperature[0]}

G92 E0
M569 S0 E ; set spreadcycle mode for extruder

;
; Extrude purge line - MODIFIED TO CENTER OF BUILD PLATE
;

G92 E0 ; reset extruder position
G1 E{(filament_type[0] == "FLEX" ? 4 : 2)} F2400 ; deretraction after the initial one before nozzle cleaning
G0 Z7 X7 ;  move closer to print bed
G0 E25 F1000 ;  GLOB purge
G0 E4 X20 Z0.2 F500 ; purge
G0 X30 E4 F500 ; purge
G0 X40 E4 F650 ; purge
G0 X50 E4 F800 ; purge
G0 X{50 + 3} Z{0.05} F{8000} ; wipe, move close to the bed
G0 X{50 + 3 * 2} Z0.2 F{8000} ; wipe, move quickly away from the bed

G92 E0
M221 S100 ; set flow to 100%