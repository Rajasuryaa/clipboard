include 'emu8086.inc'
org 100h 

     
    #start=final.exe#
    in al,200
    lea DI,fno
    mov [DI],ax 
    mov ax,0
    mov al,fno[0] 
    
    
    in al,199 
    mov bl,fno
    dec bl
    lea DI,filesize
    mov bh,0
    add DI,bx
    mov [DI],al 
    mov ax,0
    mov al,filesize[1]   
    
    print "Enter the instance to be displayed" 
    printn 
    mov ah,01h
    int 21h 
    printn 
    sub al,30h
    mov na,al 
    
    mov al,na[0]
    sub al,1
    jz one
    mov al,na[0]
    sub al,2
    jz two
    mov al,na[0]
    sub al,3
    jz three
    mov al,na[0]
    sub al,4
    jz four
    mov al,na[0]
    sub al,5
    jz five 
    
    
one:


    ;open file 1.txt
    mov dx, offset filename
    mov ah, 3dh
    int 21h
    jc err
    mov handle, ax
    jmp k
    filename db "1.txt"
    handle dw ?
    err:
        printn "not file 1"
    k:    
    mov handle, ax  
    
    
    ;pointer in the file
    mov al, 0
    mov bx, handle
    mov cx, 0
    mov dx, 1
    mov ah, 42h
    int 21h 
    
    
    ;reading from the file
    mov bx, handle
    mov dx, offset buffer
    mov ch,0
    mov cl, filesize[0]
    mov ah, 3fh
    int 21h                       
    
    
    ;close file
    mov bx, handle
    mov ah, 3eh
    int 21h    
    ;displaying the read characters
    xor bx, bx
    mov dx, offset buffer
    mov ah, 9
    int 21h
    
    jmp exit    



    
two:


    ;open existing file "2.txt"              
    mov dx, offset filename2
    mov ah, 3dh
    int 21h
    jc err2
    mov handle2, ax
    jmp k2
    filename2 db "2.txt"
    handle2 dw ?
    err2:
      printn "not file 2"
    k2:                        
    mov handle2, ax            
    
    
    ;pointing in the file
    mov al, 0
    mov bx, handle2
    mov cx, 0
    mov dx, 1
    mov ah, 42h
    int 21h
    
    
    ;reading from the file
    mov bx, handle2
    mov dx, offset buffer
    mov ch,0
    mov cl, filesize[1]
    mov ah, 3fh
    int 21h
    
    
    ;closing the file
    mov bx, handle2
    mov ah, 3eh
    int 21h    
            
            
    ;displaying the read information
    xor bx, bx
    mov dx, offset buffer
    mov ah, 9
    int 21h 
    jmp exit  
    
    
    
    
    
three:   


    ;opening a existing file
    mov dx, offset filename3
    mov ah, 3dh
    int 21h
    jc err3
    mov handle3, ax
    jmp k3
    filename3 db "3.txt"
    handle3 dw ?
    err3:
    printn "not file 3"
    k3:
     
     
    ;infile operations    
    mov handle3, ax
    mov al, 0
    mov bx, handle3
    mov cx, 0
    mov dx, 1
    mov ah, 42h
    int 21h 
    
    
    ;reading from a file
    mov bx, handle3
    mov dx, offset buffer
    mov ch,0
    mov cl, filesize[2]
    mov ah, 3fh
    int 21h
    
    
    ;closing a file
    mov bx, handle3
    mov ah, 3eh
    int 21h   
    
    
    ;displayin the read characters
    xor bx, bx
    mov dx, offset buffer
    mov ah, 9
    int 21h 
    jmp exit




four:                 


    ;opening the file "4.txt"
    mov dx, offset filename4
    mov ah, 3dh
    int 21h
    jc err4
    mov handle4, ax
    jmp k4
    filename4 db "4.txt"
    handle4 dw ?
    err4:
    printn "not file 4"
    k4:                      
    
    
    ;infile operations
    mov handle4, ax
    mov al, 0
    mov bx, handle4
    mov cx, 0
    mov dx, 1
    mov ah, 42h
    int 21h 
    
    
    ;reading from the file
    mov bx, handle4
    mov dx, offset buffer
    mov ch,0
    mov cl, filesize[3]
    mov ah, 3fh
    int 21h 
    
    
    ;closing the file
    mov bx, handle4
    mov ah, 3eh
    int 21h 
    
       
    ;displaying the read characters
    xor bx, bx
    mov dx, offset buffer
    mov ah, 9
    int 21h
    jmp exit 
    
    
    
    
five:


    ;opening the file "5.txt"
    mov dx, offset filename5
    mov ah, 3dh
    int 21h
    jc err5
    mov handle5, ax
    jmp k5
    filename5 db "5.txt"
    handle5 dw ?
    err5:
    printn "not file5"
    k5:                      
    
    
    ;infile operations
    mov handle5, ax
    mov al, 0
    mov bx, handle5
    mov cx, 0
    mov dx, 1
    mov ah, 42h
    int 21h 
    
    
    ;reading from the file
    mov bx, handle5
    mov dx, offset buffer
    mov ch,0
    mov cl, filesize[4]
    mov ah, 3fh
    int 21h
    
    
    ;closing the file
    mov bx, handle5
    mov ah, 3eh
    int 21h   
           
           
    ;displaying the read characters       
    xor bx, bx
    mov dx, offset buffer
    mov ah, 9
    int 21h    
    
    
    
exit:   
printn
printn
printn
print 'place the cursor where to edit and press a key'
mov ah,01h
int 21h   
printn
printn
printn
print 'enter the string to be replaced'
printn
printn
printn
mov dx, offset buffer
mov ah, 0ah
int 21h
xor bx, bx
mov bl, buffer[1]
mov buffer[bx+2], '$'
       
       
       
lea si, buffer
lea di, str	 
mov cl,buffer[1]
add cl,2
mov ch,0

cpy_nxt:
    mov bl, [si]
	mov [di], bl
	inc si
	inc di	
	dec cx
	jnz cpy_nxt;
	

xor bx, bx
mov bl, str[1]
mov str[bx+2], '$'       
mov ax, 3
int 33h   
         
         
mov mx,cx
mov my,dx         

mov ax,cx
mov bl,8
div bl
xor bx,bx
mov bl,al
mov ax,bx 
mov mcol,al  
mov mco,al


mov ax,dx
mov bl,8
div bl
xor bx,bx
mov bl,al
mov ax,bx 
mov mrow,al  
mov mro,al

mov ah,01h
int 21h

lea di,temp
mov cx,80 


read:


mov dh, mro
mov dl, mco
mov bh, 0
mov ah, 2
int 10h  
mov ah,08h
int 10h  

mov [di],al

inc di

cmp al,00h
  
jz carriagereturn  

cmp al,2Eh
jz end1     


increment:
mov bl,mco
inc bl
mov mco,bl  
jmp loop1

carriagereturn:
dec di
mov [di],0Ah
inc di  
mov [di],13
inc di
mov bl,mro
inc bl
mov mro,bl
mov mco,0

loop1:
loop read        



 
end1:
mov [di],'$'


mov ah,01h
int 21h    
            
            
mov al, 1
mov bh, 0           
mov bl, 0011_1011b
mov cl, str[1] 
mov ch,0
mov dl, mcol
mov dh, mrow
push cs
pop es
mov bp, offset str[2]
mov ah, 13h
int 10h    


mov dx, offset temp 
mov ah, 9
int 21h
jmp msg1end              



msg1end:
     

hlt
filesize db 5 dup(?)          
fno db ?              
na db ?
buffer db 1000 dup(' ')   
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_SCAN_NUM


mx dw ?
my dw ? 
mrow db ?
mcol db ?
temp db 25 dup(?)       
mro db ?
mco db ?
demo db '12345678',10,13,'123456',10,13,'qwertyui.$'
str  db 1000 dup(?)