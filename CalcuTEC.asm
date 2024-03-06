.model small
.stack 64
.data
    MensajeInicio db 13,10,'Bienvenido a CalcuTEC, por favor, ingrese su operacion:', 13,10, '$'
    Operacion db ?
    llamada1 db 13,10, '1. Suma ', 13,10 , '$'
    llamada2 db 13,10, '2. Resta', 13,10 ,  '$'
    llamada3 db 13,10 , '3. Multiplicacion', 13,10 , '$'
    llamada4 db 13,10 , '4. Division', 13,10 , '$'
    mensaje_error db 13,10,'Opcion no valida. Por favor, seleccione una opcion del 1 al 4.', 13,10, '$'
    ingreso1 db 13,10 , 'Ingrese el primer numero: $', 13,10 , '$'
    ingreso2 db 13,10 , 'Ingrese el segundo numero: $', 13,10 , '$'
    mensaje_salida db 13,10 , 'Gracias por usar CalcuTEC $' , 13,10 , '$'

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

suma:
    mov ah, 9
    lea dx, ingreso1
    int 21h
    ; Código para la suma
    ; Leer los números
    ; Sumar y mostrar el resultado
    jmp fin_programa

resta:
    mov ah, 9
    lea dx, ingreso1
    int 21h
    ; Código para la resta
    ; Leer los números
    ; Restar y mostrar el resultado
    jmp fin_programa

multiplicacion:
    mov ah, 9
    lea dx, ingreso1
    int 21h
    ; Código para la multiplicación
    ; Leer los números
    ; Multiplicar y mostrar el resultado
    jmp fin_programa

division:
    mov ah, 9
    lea dx, ingreso1
    int 21h
    ; Código para la división
    ; Leer los números
    ; Dividir y mostrar el resultado
    jmp fin_programa

fin_programa:
    mov ah, 9
    lea dx, mensaje_salida
    int 21h

    mov ah, 4ch
    int 21h
end inicio