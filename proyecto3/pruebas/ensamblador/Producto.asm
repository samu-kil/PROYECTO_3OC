// Producto.asm - R2 = R0 * R1 por sumas repetidas (supone R0 >= 0 y R1 >= 0).
// Usa una variable (contador), una etiqueta usada antes de declararse (FIN) y comentarios.
    @R2
    M=0            // R2 = 0
    @contador
    M=0            // contador = 0
(BUCLE)
    @contador
    D=M
    @R1
    D=D-M          // D = contador - R1
    @FIN
    D;JGE          // si contador >= R1, terminar
    @R0
    D=M
    @R2
    M=D+M          // R2 = R2 + R0
    @contador
    M=M+1          // contador++
    @BUCLE
    0;JMP
(FIN)
    @FIN
    0;JMP