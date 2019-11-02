TITLE 0809-T1
; CALCULATE (N1+N2)*(N3-N4)
; RESULT MAY BE UP TO 3 DIGITS WIDE
CODESEG SEGMENT
    ASSUME CS:CODESEG, DS:DATASEG                    
    START:      
        MOV DX, DATASEG ; 
        MOV DS, DX      ; LOAD ADDRESS OF DATA SEGMENT TO DS
        MOV DX, 0       ;
        
        LEA DX, MESSAGE ; LOAD MESSAGE ADDRESS TO DX
        MOV AH, 09H     ; PRINT MESSAGE STRING TO STDOUT
        INT 21H         ;
        
 
        MOV AL, N1 ; USE AX REGISTER LOW BYTE FOR N1+N2
        ADD AL, N2 ;
        MOV AH, N3 ; AND AX REGISTER HIGH BYTE FOR N3-N4
        SUB AH, N4 ;
        
        
        MUL AH ; AX = AL * AH
               ; BECAUSE OPERAND IS BYTE, STORES RESULT IN AX           
        
        MOV BH, 100 ; USE BH AS DIVISOR                                                                        
        
        DIV BH     ; GET NUMBER'S HUNDREDS. AH = AX % BH, AL = AX / BH 
        MOV DL, 48 ; INITIALIZE DL FOR PRINTING NUMERIC CHARACTERS
        ADD DL, AL ; STORE RESULT IN DL FOR PRINTING        
        MOV BL, AH ; STORE REMAINDER IN BL TO DIVIDE AGAIN
        MOV AH, 2  ; PRINT DL TO STDOUT
        INT 21H    ;
        
        MOV AH, 0  ; ZERO OUT AH FOR NEXT DIVISION
        MOV BH, 10 ;
        MOV AL, BL ; GET PREVIOUS REMAINDER FROM BL
        
        DIV BH     ; GET NUMBER'S TENS
        MOV DL, 48 ; INITIALIZE DL FOR PRINTING NUMERIC CHARACTERS
        ADD DL, AL ; STORE RESULT IN DL FOR PRINTING            
        MOV BL, AH ; STORE REMAINDER IN BL           
        MOV AH, 2  ; PRINT DL TO STDOUT          
        INT 21H    ;            
        
        MOV DL, 48 ; INITIALIZE DL FOR PRINTING NUMERIC CHARACTERS
        ADD DL, BL ; REMAINDER IS NUMBER'S ONES
        MOV AH, 2  ; PRINT DL TO STDOUT
        INT 21H    ;
        
        
        MOV AH, 4CH ; EXIT PROGRAM
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