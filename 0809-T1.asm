TITLE 0809-T1
; CALCULATE (N1+N2)*(N3-N4)
CODESEG SEGMENT
    ASSUME CS:CODESEG, DS:DATASEG                    
    START:
        ; -------------------FOREWORD----------------------
        ; APPARENTLY DOS INTERRUPTS BEHAVE ACCORDING TO THE
        ; CONTENTS OF AH, TABLE CAN BE FOUND HERE
        ; https://spike.scu.edu.au/~barry/interrupts.html
        ; 21H IS THE DOS INTERRUPT (INT 21H)
        
        MOV DX, DATASEG ; LOAD ADDRESS OF DATA SEGMENT TO DS
        MOV DS, DX      ;
        MOV DX, 0000H   ;
        
        LEA DX, MESSAGE ; LOAD MESSAGE ADDRESS TO DX
        MOV AH, 09H     ; "WRITE STRING TO STDOUT" INTERRUPT
                        ; READS ADDRESS FROM DX.
        INT 21H         ;
        
 
        MOV AL, N1 ; USE AX REGISTER LOW BYTE FOR N1+N2
        ADD AL, N2 ;
        MOV AH, N3 ; AND AX REGISTER HIGH BYTE FOR N3-N4
        SUB AH, N4 ;
        
        
        MUL AH      ; BECAUSE OPERAND IS BYTE, STORES RESULT IN AX
        MOV BX, 0   ; ZERO OUT BX REGISTER
        MOV BH, 100 ; USE FOR DIVISION
        
        DIV BH     ; GET NUMBER'S HUNDREDS
        MOV DL, 48 ; ASCII NUMS START AT 48 
        ADD DL, AL ; STORE RESULT IN DL FOR PRINTING
        MOV BL, AH ; STORE REMAINDER IN BL TO DIVIDE AGAIN
                   ; PRINT INTERRUPT STORES OUTPUT CHAR IN AL
                   ; SO AL CANNOT BE USED TO STORE REMAINDER
        MOV AH, 2  ; "PRINT CHAR TO STDOUT" INTERRUPT
                   ; CHARACTER IS READ FROM DL
        INT 21H    ;
        MOV AH, 0  ; ZERO OUT AH TO AVOID CORRUPTING THE RESULT
        MOV BH, 10 ;
        MOV AL, BL ;
        
        DIV BH     ; REPEAT FOR NUMBER'S TENS
        MOV DL, 48 ;
        ADD DL, AL ;            
        MOV BL, AH ;            
        MOV AH, 2  ; PRINT INTERRUPT           
        INT 21H    ;            
        MOV AH, 0  ;
        
        MOV DL, 48 ;
        ADD DL, BL ; REMAINDER IS NUMBER'S ONES
        MOV AH, 2  ; PRINT INTERRUPT
        INT 21H    ;
        
        
        MOV AH, 4CH ; "EXIT PROGRAM" INTERRUPT
        INT 21H     ;
                   
    
CODESEG ENDS

DATASEG SEGMENT      

    N1 DB 3
    N2 DB 5
    N3 DB 11
    N4 DB 7
    MESSAGE DB "THE RESULT IS: $"       

DATASEG ENDS

    END START