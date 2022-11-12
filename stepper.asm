#start=stepper_motor.exe#


name "stepper motor"

#make_bin#

steps_before_direction_change = 20h 

jmp start




datclock    db 0000_0110b
         db 0000_0100b    
         db 0000_0011b
         db 0000_0010b


datcounterclock   db 0000_0011b
         db 0000_0001b    
         db 0000_0110b
         db 0000_0010b



datclock_fs db 0000_0001b
         db 0000_0011b    
         db 0000_0110b
         db 0000_0000b


datcounterclock_fs db 0000_0100b
          db 0000_0110b    
          db 0000_0011b
          db 0000_0000b


start:
mov bx, offset datclock
mov si, 0
mov cx, 0 

follow:

wait:   in al, 7     
        test al, 10000000b
        jz wait

mov al, [bx][si]
out 7, al

inc si

cmp si, 4
jb follow
mov si, 0

inc cx
cmp cx, steps_before_direction_change
jb  follow

mov cx, 0
add bx, 4 

cmp bx, offset datclock_fs
jbe  follow
mov bx, offset datcounterclock
jmp follow




