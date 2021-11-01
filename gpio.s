//--------DEFINICIÓN DE FUNCIONES-----------//
    .global inputRead    
	//DESCRIPCION: Lee el boton en el GPIO17. 
//------FIN DEFINICION DE FUNCIONES-------//

inputRead: 	
	ldr w22, [x20, GPIO_GPLEV0] 	// Leo el registro GPIO Pin Level 0 y lo guardo en X22
	mov x23,#0x60000
	add x23,x23,#0x0C000
	and X22,X22,X23					// Limpio el bit 18, 17, 15, 14

    br x30 		//Vuelvo a la instruccion link

circulo:
	mov x23,x10		//guardamos el valor de x10 (posicion inicial de dibujo)
	add x23,x23,4	//2 px a la derecha

	sturh w3,[x23,0]	
	sturh w3,[x23,2]
	sturh w3,[x23,4]

	add x23,x23,1022

	sturh w3,[x23,0]	
	sturh w3,[x23,2]
	sturh w3,[x23,4]
	sturh w3,[x23,6]
	sturh w3,[x23,8]

	add x23,x23,1022

	sturh w3,[x23,0]	
	sturh w3,[x23,2]
	sturh w3,[x23,4]
	sturh w3,[x23,6]
	sturh w3,[x23,8]
	sturh w3,[x23,10]
	sturh w3,[x23,12]

	add x23,x23,1024

	sturh w3,[x23,0]	
	sturh w3,[x23,2]
	sturh w3,[x23,4]
	sturh w3,[x23,6]
	sturh w3,[x23,8]
	sturh w3,[x23,10]
	sturh w3,[x23,12]

	add x23,x23,1024

	sturh w3,[x23,0]	
	sturh w3,[x23,2]
	sturh w3,[x23,4]
	sturh w3,[x23,6]
	sturh w3,[x23,8]
	sturh w3,[x23,10]
	sturh w3,[x23,12]

	add x23,x23,1026

	sturh w3,[x23,0]	
	sturh w3,[x23,2]
	sturh w3,[x23,4]
	sturh w3,[x23,6]
	sturh w3,[x23,8]

	add x23,x23, 1026

	sturh w3,[x23,0]	
	sturh w3,[x23,2]
	sturh w3,[x23,4]

	br x30

limpiar:
	mov x23,x10 //x10 contiene la posicion del circulo a borrar
	mov x25,7 // contador y

loopl2:
	mov x24,7 // contador x
loopl1:
	sturh w4,[x23,0] //w4 contiene del color de fondo
	add x23,x23,2
	sub x24,x24,1		//1 0
	cbnz x24, loopl1 
	sub x23,x23,14
	add x23,x23,1024
	sub x25,x25,1
	cbnz x25, loopl2

	br x30

cuadrado:
	mov x23,x10
	mov x25,10 // contador y
	mov w5,0

loopc2:
	mov x24,10 // contador x
loopc1:
	sturh w5,[x23,0] //w4 contiene del color de fondo
	add x23,x23,2
	sub x24,x24,1		//1 0
	cbnz x24, loopc1 
	sub x23,x23,20
	add x23,x23,1024
	sub x25,x25,1
	cbnz x25, loopc2

	br x30

laberinto:
	mov x29,x30

	bl cuadrado

	add x10,x10,20

	bl cuadrado

	add x10,x10,2560
	add x10,x10,2560
	add x10,x10,2560
	add x10,x10,2560

	bl cuadrado

	mov x30,x29

	br x30
