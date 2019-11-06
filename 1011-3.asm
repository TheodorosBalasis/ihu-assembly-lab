TITLE 1011-3
; (N+1)^2/2N
; N IS A SINGLE DIGIT NUMBER, THUS THE RESULT IS AT MOST 2 DIGITS WIDE
CODESEG SEGMENT
    ASSUME CS:CODESEG, DS:DATASEG
    START:
        MOV DX, DATASEG ; INITIALIZE DS TO POINT TO DATASEG
        MOV DS, DX      ;
        
        MOV AL, N ; PERFORM EXERCISE COMPUTATION
        ADD AL, 1 ;
        MUL AL    ;
        MOV BL, N ;
        ADD BL, N ;
        DIV BL    ;
        
        MOV BL, AL ; CACHE RESULTS IN BX
        MOV BH, AH ;
        
        LEA DX, MESSAGE_QUOTIENT ; PRINT THE QUOTIENT MESSAGE TO STDOUT
        MOV AH, 9                ;
        INT 21H                  ;
        
        MOV AL, BL ; INITIALIZE AX FOR PRINTING THE QUOTIENT
        MOV AH, 0  ; 
        MOV DL, 10 ; USE DL AS DIVISOR
        DIV DL     ; GET NUMBER'S TENS
        MOV DL, 48 ; INITIALIZE DL FOR PRINTING NUMERIC CHARACTERS
        ADD DL, AL ;
        MOV DH, AH ; CACHE REMAINDER IN DH
        MOV AH, 2  ; PRINT TO STDOUT
        INT 21H    ;
        
        MOV DL, 48 ; PRINT NUMBER'S UNITS TO STDOUT
        ADD DL, DH ;
        INT 21H    ;
        
        MOV DL, 10 ; PRINT A NEWLINE AND CARRIAGE RETURN
        INT 21H    ;
        MOV DL, 13 ;
        INT 21H    ;
        
        LEA DX, MESSAGE_REMAINDER ; PRINT REMAINDER MESSAGE TO STDOUT
        MOV AH, 9                 ;
        INT 21H                   ;
        
        MOV AL, BH ; INITIALIZE AX FOR PRINTING THE REMAINDER
        MOV AH, 0  ;
        MOV DL, 10 ; USE DL AS DIVISOR
        DIV DL     ; GET NUMBER'S TENS
        MOV DL, 48 ; INITIALIZE DL FOR PRINTING NUMERIC CHARACTERS
        ADD DL, AL ;
        MOV DH, AH ; CACHE REMAINDER IN DH
        MOV AH, 2  ; PRINT TO STDOUT
        INT 21H    ;
        
        MOV DL, 48 ; PRINT NUMBER'S UNITS TO STDOUT
        ADD DL, DH ;
        INT 21H    ;
        
        MOV AH, 4CH ; EXIT PROGRAM
        INT 21H     ;
    
CODESEG ENDS

DATASEG SEGMENT
    
    N DB 9
    MESSAGE_QUOTIENT DB "THE QUOTIENT IS: $"
    MESSAGE_REMAINDER DB "THE REMAINDER IS: $"    
    
DATASEG ENDS
    END START