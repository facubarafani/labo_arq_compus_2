.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	
	mov w3, 0xF800    	// 0xF800 = ROJO	
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
loop2:
	mov x2,512         	// Tamaño en Y
loop1:
	mov x1,512         	// Tamaño en X
loop0:
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   		// Decrementar el contador X
	cbnz x1,loop0	   	// Si no terminó la fila, saltar
	sub x2,x2,1	   		// Decrementar el contador Y
	cbnz x2,loop1	  	// Si no es la última fila, saltar

	mov x10,x0			//set x10 en el principio

	bl laberinto
	
	mov w4,w3			//guardo el valor original de w3 en w4 (color del fondo)
	mov w3,0x0000
	add x10, x0, 512	//mitad de la pantalla horizontal
	add x10, x10, 2048	//bajar 2 px
	add x10, x10, 2048
	add x10, x10, 2048
	add x10, x10, 2048
	add x10, x10, 2048

control:
	bl circulo			//dibujo circulo

	// --- Delay loop ---
	movz x11, 0x10, lsl #16
delay1: 
	sub x11,x11,#1
	cbnz x11, delay1
	// ------------------

	bl inputRead		// Leo el GPIO17 y lo guardo en x21

	cbz X22, control	//cuando x22 es 0, no se presionó ningún pulsador

	cmp x22, 0x40000 	//izquierda
	bne abajo
	bl limpiar
	mov x11,x10
	sub x10,x10,20    	
	ldurh w9, [x10]
	cmp w9,#0x0000
	bne control
	mov x10,x11	
	b control
abajo:
	cmp x22, 0x20000	//abajo rojo
	bne derecha
	bl limpiar
	mov x11,x10
	add x10,x10,2560	//10 px abajo
	add x10,x10,2560
	add x10,x10,2560
	add x10,x10,2560
	cmp w9,#0x0000
	bne control
	mov x10,x11
	b control
derecha:
	cmp x22, 0x8000		//derecha negro
	bne arriba
	bl limpiar
	mov x11,x10
	add x10,x10,20
	cmp w9,#0x0000
	bne control
	mov x10,x11
	b control
arriba:
	cmp x22, 0x4000		//arriba blanco
	bne control
	bl limpiar
	mov x11,x10
	sub x10,x10,2560	//10px arriba
	sub x10,x10,2560
	sub x10,x10,2560
	sub x10,x10,2560
	ldurh w9, [x10]
	cmp w9,#0x0000
	bne control
	mov x10,x11
	b control
	
	// --- Infinite Loop ---	
InfLoop: 
	b InfLoop
	
