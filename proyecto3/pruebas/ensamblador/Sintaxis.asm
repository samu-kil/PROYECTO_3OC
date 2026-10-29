// Sintaxis.asm - cubre la sintaxis de la seccion 7: espacios, tabulaciones, comentarios,
// simbolos predefinidos, variables, etiquetas y referencias hacia adelante. Fin de linea CRLF.

	@SP
   @ 0   // espacios dentro de la instruccion
@32767
@LCL
@ARG
@THIS
@THAT
@R15
@SCREEN
@KBD
   // linea con solo un comentario
@var.1          // variable -> 16
@$tmp:x         // variable -> 17
@R16            // R16 NO es predefinido: variable -> 18
@r0             // minuscula: distinto de R0, variable -> 19
@_inicio        // referencia hacia adelante
  A  =  D  +  1  ;  JNE   // espacios por todas partes
	AMD=M-1;JLE
(_inicio)
(otra.etiqueta)      // dos etiquetas en la misma direccion
@var.1               // reutiliza la direccion 16
D=M
@AL_FINAL
D;JGT
@otra.etiqueta
0;JMP
(FIN$:)
@FIN$:
0;JMP
(AL_FINAL)          // etiqueta al final del archivo: vale n
