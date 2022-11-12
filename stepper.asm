#how stepper motor works without any feedback mechanism
#we all know stepper motor is a brushless, synchronous dc motor that is used in CNC milling machine or automatic milling machine and it doesnot need feedback mechanism considering it's operation happens in step-wise format


name "stepper motor"

#make_bin#

steps_before_direction_change = 20h 

jmp start




datcw    db 0000_0110b
         db 0000_0100b    
         db 0000_0011b
         db 0000_0010b


datccw   db 0000_0011b
         db 0000_0001b    
         db 0000_0110b
         db 0000_0010b



datcw_fs db 0000_0001b
         db 0000_0011b    
         db 0000_0110b
         db 0000_0000b


datccw_fs db 0000_0100b
          db 0000_0110b    
          db 0000_0011b
          db 0000_0000b


start:
mov bx, offset datcw
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

cmp bx, offset datcw_fs
jbe  follow
mov bx, offset datccw
jmp follow




