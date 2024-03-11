.model small
.stack 64
.data
    MensajeInicio db 13,10,'Bienvenido a CalcuTEC, por favor, ingrese su operacion:', 13,10, '$'
    Operacion db ?
    num dw ?
    num2 dw ? 
    a dw 1000
    b db 100
    c db 10
    st11 db 13,10,"Result = ",'$'
    llamada1 db 13,10, '1. Suma ', 13,10 , '$'
    llamada2 db 13,10, '2. Resta', 13,10 ,  '$'
    llamada3 db 13,10 , '3. Multiplicacion', 13,10 , '$'
    llamada4 db 13,10 , '4. Division', 13,10 , '$'
    mensaje_error db 13,10,'Opcion no valida. Por favor, seleccione una opcion del 1 al 4.', 13,10, '$'
    ingreso1 db 13,10 , 'Ingrese el primer numero: $', 13,10 , '$'
    ingreso2 db 13,10 , 'Ingrese el segundo numero: $', 13,10 , '$'
    mensaje_salida db 13,10 , 'Gracias por usar CalcuTEC $' , 13,10 , '$'
    mensaje_condicion db 13,10 , 'Desea seguir operando: digite un 5 para si y un 6 para no. $' , 13,10 , '$'

.code 
inicio:
    mov ax, @data
    mov ds, ax

    ; Imprimir mensaje de inicio
    mov ah, 9
    lea dx, MensajeInicio
    int 21h

    ; Mostrar opciones
    mov ah, 9
    lea dx, llamada1
    int 21h

    mov ah, 9
    lea dx, llamada2
    int 21h

    mov ah, 9
    lea dx, llamada3
    int 21h

    mov ah, 9
    lea dx, llamada4
    int 21h

    ; Leer selección del usuario
    mov ah, 1
    int 21h
    sub al, 30h ; Convertir a número
    mov Operacion, al

    ; Dependiendo de la operación seleccionada, realizar el cálculo correspondiente
    cmp Operacion, 1
    je suma
    cmp Operacion, 2
    je resta
    cmp Operacion, 3
    je multiplicacion
    cmp Operacion, 4
    je division
    
    ; Si la opción ingresada no es válida, mostrar un mensaje y brincar al inicio 
    mov ah, 9
    lea dx, mensaje_error
    int 21h
    jmp inicio

fin_programa:
    mov ah, 9
    lea dx, mensaje_salida
    int 21h

    mov ah, 4ch
    int 21h

condicion: 
    mov ah, 9
    lea dx, mensaje_condicion
    int 21h

    mov ah, 1
    int 21h
    sub al, 30h ; Convertir a número
    mov Operacion, al

    cmp Operacion, 5
    je inicio
    cmp Operacion, 6
    je fin_programa

suma:
    
    jmp condicion

multiplicacion:
    mov ah, 9
    lea dx, ingreso1
    int 21h
    ; Código para la multiplicación
    ; Leer los números
    ; Multiplicar y mostrar el resultado
    jmp condicion

division:
    mov ah, 9
    lea dx, ingreso1
    int 21h
    ; Código para la división
    ; Leer los números
    ; Dividir y mostrar el resultado
    jmp condicion

resta:
    mov AH,9H
    mov DX,offset ingreso1
    INT 21H

    mov AH,1
    INT 21H  
    SUB AL,30H
    mov ah,0                    ; Clear upper half of AX
    MUL a                       ; 1st digit
    mov num,AX

    mov AH,1
    INT 21H  
    SUB AL,30H
    mov ah,0                    ; Clear upper half of AX
    MUL b                       ; 2nd digit
    add num,AX

    mov AH,1
    INT 21H  
    SUB AL,30H
    mov ah,0                    ; Clear upper half of AX
    MUL c                       ; 3rd digit
    ADD num,AX

    mov AH,1
    INT 21H                      ; 4th digit
    SUB AL,30H
    mov ah,0                    ; Clear upper half of AX
    ADD num,AX

    mov AH,9H
    mov DX,offset ingreso2
    INT 21H

    mov AH,1
    INT 21H  
    SUB AL,30H
    mov ah,0                    ; Clear upper half of AX
    MUL a                       ; 1st digit
    mov num2,AX

    mov AH,1
    INT 21H  
    SUB AL,30H
    mov ah,0                    ; Clear upper half of AX
    MUL b                       ; 2nd digit
    ADD num2,AX

    mov AH,1
    INT 21H  
    SUB AL,30H
    mov ah,0                    ; Clear upper half of AX
    MUL c                       ; 3rd digit
    ADD num2,AX

    mov AH,1
    INT 21H                      ; 4th digit
    SUB AL,30H 
    mov ah,0                    ; Clear upper half of AX
    ADD num2,AX

    call addfunc 

    exit:
    
    mov AH,4CH
    INT 21H 

    addfunc proc near
    mov ah, 9
    lea dx, st11
    int 21h
    mov AX, num
    sub AX, num2
    
    ; Verificar si el resultado es negativo y ajustar para la impresión
    jns positive_number
    push AX           ; Guarda el resultado negativo
    mov dl, '-'       ; Preparar el signo negativo para imprimir
    mov ah, 02h
    int 21h           ; Imprime el signo negativo
    pop AX            ; Recupera el resultado negativo
    neg AX            ; Convierte el resultado a positivo para la conversión

    positive_number:
    ; Convertir AX en una cadena ASCII en orden inverso
    xor CX, CX        ; Inicializar el contador de dígitos
    or AX, AX         ; Verificar si AX es 0
    jz print_zero     ; Si es cero, imprimir 0 y terminar

    convert_loop:
    xor DX, DX        ; Preparar DX para la división
    mov BX, 10        ; Establecer el divisor para la conversión de dígitos
    div BX            ; Dividir AX por 10, resultado en AX, resto en DX
    push DX           ; Guardar el dígito en la pila
    inc CX            ; Incrementar el contador de dígitos
    test AX, AX       ; Verificar si queda algo por convertir
    jnz convert_loop  ; Repetir si es necesario

    print_digits:
    pop DX            ; Recuperar un dígito de la pila
    add DL, '0'       ; Convertir el dígito a ASCII
    mov AH, 02h
    int 21h           ; Imprimir el dígito
    loop print_digits ; Continuar hasta imprimir todos los dígitos
    jmp condicion

    ret

    print_zero:
    mov DL, '0'
    mov AH, 02h
    int 21h
    jmp condicion

    ret
    
    addfunc endp

end inicio