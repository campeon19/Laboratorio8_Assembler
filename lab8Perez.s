@ lab8Perez.s
@*******************************************
@ USO: sacar el promedio de 10 numeros
@*******************************************
@ AUTH: Christian Perez

@ DATOS
.data
.align 2

@ VARIABLES
arreglo: 		.word 0,0,0,0,0,0,0,0,0,0
resultado:		.word 0,0,0,0,0,0,0,0,0,0
N:				.word 10
recibido:		.word 0

@ MENSAJES
bienvenida:		.asciz "Bienvenido\n"
ingresar:		.asciz "Por favor ingrese un numero"
mensajeError	.asciz "Ingreso erroneo"
formato:		.asciz "%d\n"

@ CUERPO DEL PROGRAMA

.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!,{lr}
	
@ Bienvenida
	mov r7, #3
	mov r0, #0
	mov r2, #12
	ldr r1, =bienvenida
	swi 0
	
	mov r5, #0
	ldr r9, N
	ldr r9,[r9]
	ldr r6,=arreglo
	ldr r7,=resultado
	ldr r8,[r7], #36
	mov r10, #0

	
	capturaDatos:
		cmp r9, r5
		beq prepararDatos
		
		@ Imprime mensaje
		mov r7, #3
		mov r0, #0
		mov r2, #12
		ldr r1, =ingresar
		swi 0
		
		@ Ingreso de dato
		ldr r0 =formato
		ldr r1,=recibido
		bl scanf
		
		cmp r0,#0
		beq error
		
		ldr r4,=recibido
		ldr r4,[r4]
		add r9, r9, #1
		
		
		str r4, [r6], #4
		str r4, [r7], #-4
		
		b capturaDatos
	
	prepararDatos:
		ldr r6,= arreglo
		sub r6,r6,#4
		mov r5, #0
		
	
	imprimirDatos:
	
		@Imprime el arreglo con los datos
		
		ldr r1, [r6, #4]!
		ldr r0,=formato
		bl printf
		
		add r5, r5, #1
		cmp r9,r5
		bne imprimirDatos
		
	prepararResultados:
	
		ldr r6, =resultado
		mov r7, #0
		add r7,r6,#4
		mov r5, #0
		
	imprimirResultados:
		
		ldr r1, [r7], #-1
		ldr r0,=formato
		bl printf
		
		cmp r7,r6
		bge imprimirResultados
		
		b salida
	
	error:
	
		mov r7, #3
		mov r0, #0
		mov r2, #12
		ldr r1, =mensajeError
		swi 0
		
		b capturaDatos
	
	salida:
	
		mov r0, #0
		mov r3, #0
		
		ldmfd sp!,{lr}
		bx lr
	

