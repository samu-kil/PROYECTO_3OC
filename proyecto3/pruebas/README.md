# Pruebas

## Como ejecutarlas

```bash
./compilar.sh

# Ensamblador: genera a los prog.hack y prog.asm
for f in pruebas/ensamblador/*.asm; do ./ensamblador.sh "$f"; done

# Desensamblador:  genera los progDisasm junto a los prog hack
for f in pruebas/desensamblador/*.hack; do ./desensamblador.sh "$f"; done

# Casos de error
for f in pruebas/errores/ens_*.asm;  do ./ensamblador.sh "$f";    echo "  -> código $?"; done
for f in pruebas/errores/des_*.hack; do ./desensamblador.sh "$f"; echo "  -> código $?"; done
```

**Ensamblador:** el resultado de Prog.asm es el Prog.hack de la carpeta. Al ejecutarse , el programa lo reescribe con el mismo contenido del archivo, así que git status no debe mostrar cambios en pruebas/ensamblador/.

**Desensamblador:** el resultado de Prog.hack es ProgDis_ejemplo.asm. Los nombres de las etiquetas pueden variar dependiendo del proceso, por eso la condición de correccion es que al ensamblar ProgDis.asm se obtiene de nuevo Prog.hack. Y los ProgDis.asm son ignorados por el gitignore

**Errores:** el texto del mensaje es libre; lo que se comprueba es el formato `ERROR *** Línea N: <mensaje>`, que `N` sea correcto (contando desde 1), el código de salida distinto de 0 (aqui 1) y que no se genere algun archivo de salida.

## Ensamblador: programas válidos definidos

| Archivo | Que prueba | Resultado esperado |
|---|---|---|
| Prueba1.asm | Programas prueba: programa sin simbolos (RAM[2] = RAM[0] + RAM[1]) | Prueba1.hack (8 instrucciones) |
| Prueba2.asm | Programas prueba: etiquetas y variables (R1 = 1 + 2 + … + R0) | Prueba2.hack (24 instrucciones) |
| Producto.asm | R2 = R0 × R1 por sumas repetidas: variable (`contador` → 16), etiqueta usada antes de declararse (FIN), comentarios, archivo sin salto de línea final | Producto.hack (20 instrucciones) |
| Instrucciones.asm | Los 28 computos, los 8 destinos, los 8 saltos y las combinaciones de los tres | Instrucciones.hack (50 instrucciones) |
| Sintaxis.asm | Fin de línea CRLF, tabulaciones, espacios dentro de la instrucción (A  =  D  +  1  ;  JNE), comentarios en línea propia y al final, símbolos predefinidos, @32767, símbolos con . $ : _, R16 y r0 (no son predefinidos: son variables), dos etiquetas en la misma dirección, etiqueta al final del archivo | Sintaxis.hack (25 instrucciones) |

## Desensamblador: programas válidos

| Archivo | Qué prueba | Resultado esperado |
|---|---|---|
| Prueba3.hack | Programas de prueba: R2 = max(R0, R1) (16 instrucciones) | Prueba3Dis_ejemplo.asm (3 etiquetas) |
| Prueba4.hack | Programas de prueba: pinta R0 palabras de la pantalla (19 instrucciones) | Prueba4Dis_ejemplo.asm (2 etiquetas) |
| Etiquetas.hack` | 14 instrucciones, fin de línea CRLF: dos saltos a la misma dirección usan una única etiqueta; destino v = n (etiqueta al final); destino en la primera instrucción;@1000 antes de un salto con v > n queda en decimal; un @5 que no precede a un salto queda en decimal; un salto precedido por una instrucción C no genera etiqueta; el archivo termina en una A | EtiquetasDis_ejemplo.asm (3 etiquetas) |
| Codigos.hack | Binario de Instrucciones.asm: los 28 códigos de computo, 8 destinos y 8 saltos (50 instrucciones) | CodigosDis_ejemplo.asm (0 etiquetas) |
| Teclado.hack | Programa con variables, SCREEN, KBD y A=M (33 instrucciones, sin salto de línea final) | TecladoDis_ejemplo.asm (4 etiquetas) |

## Errores del ensamblador

Los casos del 1 a 30 tienen la forma: linea 1 comentario, linea 2 en blanco, línea 3 D=M, linea 4 inválida, línea 5 D=M.

| Archivo | Categoria | Linea inválida | Linea esperada | Mensaje |
|---|---|---|---|---|
| `ens_01_A_sin_valor.asm` | Instrucción A | `@` | 4 | ERROR *** Línea 4: instrucción A sin valor |
| `ens_02_A_fuera_de_rango.asm` | Instrucción A | `@32768` | 4 | ERROR *** Línea 4: constante fuera de rango (0..32767): '@32768' |
| `ens_03_A_negativo.asm` | Instrucción A | `@-1` | 4 | ERROR *** Línea 4: símbolo inválido '@-1' |
| `ens_04_A_empieza_con_digito.asm` | Instrucción A | `@1abc` | 4 | ERROR *** Línea 4: constante inválida '@1abc' |
| `ens_05_A_caracter_invalido.asm` | Instrucción A | `@VAR#1` | 4 | ERROR *** Línea 4: símbolo inválido '@VAR#1' |
| `ens_06_A_parentesis.asm` | Instrucción A | `@LOOP)` | 4 | ERROR *** Línea 4: símbolo inválido '@LOOP)' |
| `ens_07_ETIQ_sin_cierre.asm` | Etiquetas | `(LOOP` | 4 | ERROR *** Línea 4: etiqueta sin cierre ')' |
| `ens_08_ETIQ_sin_apertura.asm` | Etiquetas | `LOOP)` | 4 | ERROR *** Línea 4: etiqueta sin apertura '(' |
| `ens_09_ETIQ_vacia.asm` | Etiquetas | `()` | 4 | ERROR *** Línea 4: etiqueta vacía '()' |
| `ens_10_ETIQ_nombre_invalido.asm` | Etiquetas | `(1LOOP)` | 4 | ERROR *** Línea 4: nombre de etiqueta inválido '1LOOP' |
| `ens_11_ETIQ_predefinido.asm` | Etiquetas | `(SCREEN)` | 4 | ERROR *** Línea 4: la etiqueta 'SCREEN' usa el nombre de un símbolo predefinido |
| `ens_12_ETIQ_predefinido_R0.asm` | Etiquetas | `(R0)` | 4 | ERROR *** Línea 4: la etiqueta 'R0' usa el nombre de un símbolo predefinido |
| `ens_13_DEST_desconocido.asm` | Destino | `X=D` | 4 | ERROR *** Línea 4: destino inválido 'X' |
| `ens_14_DEST_DM.asm` | Destino | `DM=D+1` | 4 | ERROR *** Línea 4: destino inválido 'DM' |
| `ens_15_DEST_ADM.asm` | Destino | `ADM=M` | 4 | ERROR *** Línea 4: destino inválido 'ADM' |
| `ens_16_DEST_MA.asm` | Destino | `MA=1` | 4 | ERROR *** Línea 4: destino inválido 'MA' |
| `ens_17_DEST_MM.asm` | Destino | `MM=0` | 4 | ERROR *** Línea 4: destino inválido 'MM' |
| `ens_18_DEST_vacio.asm` | Destino | `=D` | 4 | ERROR *** Línea 4: destino vacío antes de '=' |
| `ens_19_COMP_vacio_dest.asm` | Cómputo | `D=` | 4 | ERROR *** Linea 4: cómputo vacío |
| `ens_20_COMP_vacio_salto.asm` | Cómputo | `;JMP` | 4 | ERROR *** Linea 4: cómputo vacío |
| `ens_21_COMP_multiplicacion.asm` | Cómputo | `D=D*A` | 4 | ERROR *** Linea 4: cómputo inválido 'D*A' |
| `ens_22_COMP_DmasA_orden.asm` | Cómputo | `D=A+D` | 4 | ERROR *** Linea 4: cómputo inválido 'A+D' |
| `ens_23_COMP_MmasD.asm` | Cómputo | `M=M+D` | 4 | ERROR *** Linea 4: computo inválido 'M+D' |
| `ens_24_COMP_MmasM.asm` | Cómputo | `D=M+M` | 4 | ERROR *** Linea 4: computo inválido 'M+M' |
| `ens_25_SALTO_vacio.asm` | Salto | `D;` | 4 | ERROR *** Linea 4: salto vacío después de ';' |
| ens_26_SALTO_JXX.asm | Salto | D;JXX | 4 | ERROR *** Linea 4: salto invalido JXX |
| ens_27_SALTO_minusculas.asm | Salto | 0;jmp | 4 | ERROR *** Linea 4: salto invalido jmp |
| ens_28_ESTR_dos_iguales.asm | Estructura | D=M=A| 4 | ERROR *** Linea 4: mas de un = en la instruccion |
| ens_29_ESTR_dos_puntoycoma.asm | Estructura | D;JGT;JMP | 4 | ERROR *** Linea 4: mas de un ; en la instruccion |
| ens_30_ESTR_texto.asm | Estructura | `HOLA MUNDO` | 4 | ERROR *** Línea 4: cómputo inválido 'HOLAMUNDO' |
| ens_31_ETIQ_duplicada.asm | Etiquetas | etiqueta declarada dos veces: se reporta la 2.ª declaración | 4 | ERROR *** Linea 4: etiqueta 'LOOP' declarada mas de una vez |
| ens_32_PRIMER_ERROR.asm | Orden | dos errores y se reporta el primero | 3 | ERROR *** Linea 3: destino invalido X|
| ens_33_FIN_CRLF.asm | Fin de la linea | archivo con CRLF: la numeración de líneas no cambia | 4 | ERROR *** Linea 4: destino inválido DM|
| ens_34_ESPACIOS_Y_COMENTARIO.asm | Estructura | error en una lnea con espacios, tabulaciones y comentario | 4 | ERROR *** Linea 4: salto inválido JXX |

## Errores del desensamblador

Los casos del 1 a 10 tienen la forma: lineas 1 y 2 validas, **linea 3 inválida**, línea 4 valida.

| Archivo | Categoria | Línea invalida | Linea esperada | Mensaje |
|---|---|---|---|---|
| `des_01_LONG_15.hack` | Longitud | `000000000000000` | 3 | ERROR *** Linea 3: longitud inválida: 15 caracteres (se esperaban 16) |
| `des_02_LONG_17.hack` | Longitud | `00000000000000000` | 3 | ERROR *** Linea 3: longitud inválida: 17 caracteres (se esperaban 16) |
| `des_03_LONG_espacio_final.hack` | Longitud | `1111110000010000` + un espacio al final | 3 | ERROR *** Línea 3: longitud inválida: 17 caracteres |
| des_04_LONG_vacia_en_medio.hack | Longitud | (línea vacía) | 3 | ERROR *** Línea 3: longitud inválida: 0 caracteres |
| des_05_CAR_dos.hack | Caracteres | 0000000000000200 | 3 | ERROR *** Linea 3: caracter invalido 2 en la posición 14  |
| des_06_CAR_letra.hack | Caracteres | 000000000000000a | 3 | ERROR *** Linea 3: caracter invalido a en la posición 16  |
| des_07_BITS_10.hack | Bits 14–13 | 1010110000010000 | 3 | ERROR *** Linea 3: instrucción C con bits 14-13 distintos de 11 |
| des_08_BITS_01.hack | Bits 14–13 | 1011110000010000 | 3 | ERROR *** Linea 3: instrucción C con bits 14-13 distintos de 11 |
| des_09_COMP_a0.hack | Cómputo | 1110000001010000 | 3 | ERROR *** Linea 3: cómputo inválido (a c1..c6 = 0000001) |
| des_10_COMP_a1.hack | Cómputo | 1111111111010000 | 3 | ERROR *** Linea 3: cómputo inválido (a c1..c6 = 1111111) |
|des_11_PRIMER_ERROR.hack | Orden | dos errores (líneas 3 y 4): se reporta el primero | 3 | ERROR *** Linea 3: instruccion C con bits 14-13 distintos de 11 |
| des_12_FIN_CRLF.hack | Fin de línea | archivo con CRLF: la numeración no cambia | 3 | ERROR *** Linea 3: instruccion C con bits 14-13 distintos de 11 |

