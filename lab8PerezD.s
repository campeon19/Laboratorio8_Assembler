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
prom:			.word 0

@ MENSAJES
bienvenida:		.asciz "Bienvenido\n"
ingresar:		.asciz "Por favor ingrese un numero:\n"
mensajeError:	.asciz "Ingreso erroneo\n"
datosS:			.asciz "Numeros en el array de datos:\n"
datosR:			.asciz "Numeros en el array de resultados:\n"
promed:			.asciz "Promedio:\n"
formato:		.asciz "%d\n"
enter:			.asciz "\n"

@ CUERPO DEL PROGRAMA

.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!,{lr}
	
@ Bienvenida
	mov r7, #4
	mov r0, #1
	mov r2, #12
	ldr r1, =bienvenida
	swi 0
	
	mov r5, #0
	ldr r9,= N
	ldr r9,[r9]
	ldr r6,=arreglo
	ldr r8,=resultado
	mov r10, #0

	
	capturaDatos:
		cmp r9, r5
		beq prepararDatos
		
		@ Imprime mensaje
		mov r7, #4
		mov r0, #1
		mov r2, #30
		ldr r1, =ingresar
		swi 0
		
		@ Ingreso de dato
		ldr r0,=formato
		ldr r1,=recibido
		bl scanf
		
		cmp r0,#0
		beq error
		
		ldr r4,=recibido
		ldr r4,[r4]
		add r5, r5, #1
		add r10, r10, r4
		
		str r4, [r6], #4
		str r4, [r8], #4
		
		b capturaDatos
	
	prepararDatos:
		ldr r6,= arreglo
		sub r6,r6,#4
		mov r5, #0
		
		ldr r0,=datosS
		bl puts
		
	
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
		add r7,r6,#36
		mov r5, #0
		
		ldr r0,=datosR
		bl puts
		
	imprimirResultados:
		
		ldr r1, [r7], #-4
		ldr r0,=formato
		bl printf
		
		cmp r7,r6
		bge imprimirResultados
		
		ldr r0, =promed
		bl puts
		mov r4, #0
	
	promedio:
		
	@ SE LLAMA A LA SUBRUTINA PROMEDIO
		
		subs r10, r10, #10
		
		add r4, r4, #1
		
		bhi promedio
		
		mov r1, r4
		
		ldr r0,=prom
		str r4,[r0]
		ldr r0,=formato
		mov r1, r4
		bl printf
		
		b salida
		
	
	error:
	
		mov r7, #4
		mov r0, #1
		mov r2, #17
		ldr r1, =mensajeError
		swi 0
		
		bl scanf
		
		b capturaDatos
	
	salida:
	
		mov r0, #0
		mov r3, #0
		
		ldmfd sp!,{lr}
		bx lr

