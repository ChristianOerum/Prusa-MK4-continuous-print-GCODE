; MODIFIED PRUSA ORIGINAL START G-CODE

{if layer_z < max_print_height}G1 Z{z_offset+min(layer_z+1, max_print_height)} F720 ; Move print head up{endif}

G1 Y210 X110 ; Controlled move to Y-axis maximum and X-center

M107 ; turn off fan
M140 S0 ; Set bed temperature to 0
M190 R0 ; Wait for the bed to cool down to 30

G28 Z     ; Home the Z-axis
G1 Z2     ; Move the Z-axis to 2mm above the build plate

; PUSH PUSH PUSH..
G1 Y0 F1000   ; Move Y-axis to 0 slowly
G1 Y210 F1000 ; Move Y-axis back to maximum slowly


M900 K0 ; reset LA
M142 S36 ; reset heatbreak target temp
M84 X Y E ; disable motors
; max_layer_z = [max_layer_z]

