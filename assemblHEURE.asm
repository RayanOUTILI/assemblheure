PILE SEGMENT STACK
    DW 256 DUP(?)  
    base:
PILE ENDS

DATA SEGMENT 
    msg db 'Heure actuelle est : $'
    hour db ?
    minute db ?
    second db ?
    centisecond db ?
DATA ENDS

CODE SEGMENT
    ;ceci est un commentaire
    ; positionnement des registres de segment.
    ASSUME CS:CODE, DS:DATA, SS:PILE 

main PROC

    MOV AX,DATA ; initialisation du segment de données
    MOV DS,AX
    MOV AX,PILE
    MOV SS,AX ; initialisation du segment de pile
    MOV SP,Base
    

    boucle:
    mov ah, 2ch   ; appel de l'interruption de l'horloge
    int 21h

    ; stockage des valeurs dans les variables
    mov hour, ch
    mov minute, cl                         
    mov second, dh
    mov centisecond, dl
    
    mov ah, 09h   ; appel de l'interruption pour affichage de la chaîne
    mov dx, offset msg
    int 21h 	
    ; conversion en ASCII        
    MOV AH, 0
    MOV AL, hour
    PUSH AX 
    PUSH 0
    call convertionValeurASCII     
    POP DX
    
    ; affichage
  
    
    MOV AH,2
    INT 21H
    POP DX
    MOV AH,2
    INT 21h
    
    MOV DL,104
    MOV AH,2
    INT 21h

    
        ; conversion en ASCII        
    MOV AH, 0
    MOV AL, minute
    PUSH AX 
    PUSH 0
    call convertionValeurASCII     
    POP DX
     
    
    MOV AH,2
    INT 21H
    POP DX
    MOV AH,2
    INT 21h
    
    MOV DL,109
    MOV AH,2
    INT 21h
    
    
        ; conversion en ASCII        
    MOV AH, 0
    MOV AL, second
    PUSH AX 
    PUSH 0
    call convertionValeurASCII     
    POP DX
     
    
    MOV AH,2
    INT 21H
    POP DX
    MOV AH,2
    INT 21h
    
    MOV DL,115
    MOV AH,2
    INT 21h
    
        ; conversion en ASCII        
    MOV AH, 0
    MOV AL, centisecond
    PUSH AX 
    PUSH 0
    call convertionValeurASCII     
    POP DX
      
    
    MOV AH,2
    INT 21H
    POP DX
    MOV AH,2
    INT 21h
    
    MOV DL,13
    MOV AH,2
    INT 21h
    
    
    jmp boucle
    
    
    

    ; fin code

    MOV AH,4CH ; Les 2 lignes necessaires pour la
    INT 21H    ; fin du programme 
    
main ENDP 

;Converti le premier parametre (valeur entre 0 et 99) en 2 caracteres ASCII
; IN  : parametre 1 : la valeur a convertir en texte
;     : parametre 2 : vide, il sert juste pour le retour
; OUT : parametre 1 : la valeur ASCII de l'unite
;     : parametre 2 : la valeur ASCII de la dizaine

convertionValeurASCII PROC  NEAR 
    
    PUSH BP
    PUSH AX
    PUSH BX

    
    MOV BP, SP
    MOV AX, [BP+10]
    
    MOV BL, 10
    DIV BL
    
    ; AH Reste, AL Quotient 
    MOV BL, AH
    MOV BH, 0
    ADD BX, 48
    
    MOV [BP+10], BX
    
    MOV AH, 0
    ADD AX, 48
    
    MOV [BP+8], AX
    

    POP BX
    POP AX
    POP BP
   
   
    RET
   
convertionValeurASCII ENDP
   



    
CODE ENDS
END main



