; MODIFIED PRUSA ORIGINAL END G-CODE

{if layer_z < max_print_height}G1 Z{z_offset+min(layer_z+1, max_print_height)} F720 ; Move print head up{endif}

G1 Y210 X7 ; Controlled move to Y-axis maximum and X-start

M107 ; turn off fan
M104 S0 ; Set extruder temperature to 0
M140 S0 ; Set bed temperature to 0
M190 R30 ; Wait for the bed to cool down to 30
    
G1 Z0     ; Move the Z-axis to 0.1mm above the build plate

; PUSH PUSH PUSH...
; Already at X30
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F5000 ; Move Y-axis back to maximum

G1 X47 F5000   ; Move X-axis to 47
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F5000 ; Move Y-axis back to maximum 

G1 X87 F5000   ; Move X-axis to 87
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F5000 ; Move Y-axis back to maximum 

G1 X127 F5000   ; Move X-axis to 127
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F5000 ; Move Y-axis back to maximum

G1 X167 F5000   ; Move X-axis to 167
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F5000 ; Move Y-axis back to maximum

G1 X207 F5000   ; Move X-axis to 207
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F5000 ; Move Y-axis back to maximum

G1 X221 F5000   ; Move X-axis to 221 FINAL STROKE
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F5000 ; Move Y-axis back to maximum


M140 S0 ; Set bed temperature to 0
M900 K0 ; reset LA
M142 S36 ; reset heatbreak target temp
M84 X Y E ; disable motors
; max_layer_z = [max_layer_z]

