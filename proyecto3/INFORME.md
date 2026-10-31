# informe ensamblador y desensamblador

## integrantes
Samuel Quintero Quintero

## aportes
Desarrollo del ensamblador, desensamblador y detector de errores. Pruebas, readme y informe

## introduccion y objetivos

Este trabajo implementa en java, dos herramientas para la plataforma Hack del curso originarios de nand2tetris, un ensamblador, que traduce programas en lenguaje ensamblador (asm) a codigo de máquina de 16 bits (hack), y un desensamblador, que realiza el proceso inverso.

Objetivos:

- Comprender el formato binario de las instrucciones Hack y la relación uno a uno con su forma simbólica.
- Implementar un ensamblador de dos pasadas con manejo de etiquetas, símbolos predefinidos y variables.
- Implementar un desensamblador que reconstruya un `.asm` legible y equivalente a partir de un `.hack`.
- Validar ambas herramientas con programas de prueba y contra el ensamblador oficial del curso.


### tabla de comp (a = 0)

| comp | cccccc | comp | cccccc |
|---|---|---|---|
| 0 | 101010 | D+1 | 011111 |
| 1 | 111111 | A+1 | 110111 |
| -1 | 111010 | D-1 | 001110 |
| D | 001100 | A-1 | 110010 |
| A | 110000 | D+A | 000010 |
| !D | 001101 | D-A | 010011 |
| !A | 110001 | A-D | 000111 |
| -D | 001111 | D&A | 000000 |
| -A | 110011 | D\|A | 010101 |

### tablas de dest y jump

| dest | ddd | jump | jjj |
|---|---|---|---|
| (nulo) | 000 | (nulo) | 000 |
| M | 001 | JGT | 001 |
| D | 010 | JEQ | 010 |
| MD | 011 | JGE | 011 |
| A | 100 | JLT | 100 |
| AM | 101 | JNE | 101 |
| AD | 110 | JLE | 110 |
| AMD | 111 | JMP | 111 |

## Diseño del ensamblador

### Estructura general

El ensamblador sigue un diseño modular

- **Parser:** lee el archivo línea por linea, descarta comentarios (//), espacios y líneas vacías, y clasifica cada línea como instrucción A, instrucción C o etiqueta (XXX). Para las instrucciones C separa los campos dest, comp y jump.
- **Code:** contiene las tablas de la sección 2 y devuelve los bits de cada campo.
- **SymbolTable:** tabla hash que asocia símbolos con direcciones. Se inicializa con los símbolos predefinidos.
- **Programa principal:** coordina las dos pasadas y escribe el archivo de salida.

### Algoritmo de dos pasadas

**Primera pasada.** Se recorre el programa llevando un contador de instrucciones ROM que parte de 0. Las líneas de instrucción (A o C) incrementan el contador. Cuando aparece una etiqueta (XXX), no genera código: se registra XXX en la tabla de símbolos con el valor actual del contador, es decir, la dirección de la siguiente instrucción.

**Segunda pasada.** Se recorre el programa de nuevo y se traduce cada instrucción:

1. Instrucción A con número: se convierte a binario de 15 bits y se antepone un 0.
2. Instrucción A con símbolo: si está en la tabla, se usa su dirección. Si no, es una variable nueva y se le asigna la siguiente dirección libre de RAM, empezando en 16.
3. Instrucción C: se concatenan 111, el bit a, los bits de comp, dest y jump.

### Decisiones de diseño y casos borde

- Una linea puede tener espacios y comentarios al final, por lo que se limpia antes de clasificarla.
- Una variable se distingue de una etiqueta porque la etiqueta aparece entre paréntesis y la variable solo se usa en `@nombre`.
- Los literales mayores que 32767 no caben en 15 bits y deben reportarse como error.
- El ensamblador debe rechazar mnemónicos inválidos (por ejemplo, un `comp` que no esté en la tabla) con un mensaje que indique la línea.




## Conclusiones

Se implementaron un ensamblador de dos pasadas y un desensamblador para Hack que se validaron contra el ensamblador oficial y mediante la prueba de ida y vuelta. El trabajo muestra que la traduccion entre ensamblador y código de máquina es directa gracias a la regularidad del formato de instruccion, y que la única dificultad real es la resolución de simbolos, que se resuelve con la tabla y las dos pasadas. Aprendi a desarrollar mediante el uso de comandos en bash la ejecucion de un codigo traductor de lenguaje maquina a lenguaje ensamblador, ademas de aprender a detectar errores presentes y el uso de tablas
