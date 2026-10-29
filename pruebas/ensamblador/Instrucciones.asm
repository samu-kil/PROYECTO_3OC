// Instrucciones.asm - todos los mnemonicos de las tablas de la seccion 7.2.
// A) Los 28 computos (con destino D).
D=0
D=1
D=-1
D=D
D=A
D=M
D=!D
D=!A
D=!M
D=-D
D=-A
D=-M
D=D+1
D=A+1
D=M+1
D=D-1
D=A-1
D=M-1
D=D+A
D=D+M
D=D-A
D=D-M
D=A-D
D=M-D
D=D&A
D=D&M
D=D|A
D=D|M
// B) Los 8 destinos (el vacio deja solo el computo).
M+1
M=M+1
D=M+1
MD=M+1
A=M+1
AM=M+1
AD=M+1
AMD=M+1
// C) Los 8 saltos (el vacio deja solo el computo).
D
D;JGT
D;JEQ
D;JGE
D;JLT
D;JNE
D;JLE
D;JMP
// D) Destino, computo y salto a la vez.
AMD=D|M;JLE
AD=!A;JNE
MD=-1;JLT
A=D&A;JGE
M=0;JEQ
D=D-M;JGT
