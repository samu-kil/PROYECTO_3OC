# Proyecto 3 Ensamblador y desensamblador en hack
se implemento un ensamblador (Prog.asm → Prog.hack) y un desensamblador (Prog.hack → ProgDis.asm, con etiquetas en los destinos de salto) para hack. Ambos detectan errores en sus entradas y informan la primera linea que es invalida.
## integrantes
-Samuel Quintero Quintero
## compilado y ejecucion
### plataforma
gran parte del proyecto se ejecuto en gitbash desde la carpeta de proyecto 3
### lenguaje
el trabajo se realizo en java, JDK 8 o superior (el código se compila con --release 8), las clases corren en cualquier java 8
### java version: 1.8.0_511-b33
### version: 25.0.5

## Comandos en proyecto3

```bash
./compilar.sh
./ensamblador.sh pruebas/ensamblador/Prog.asm
./desensamblador.sh pruebas/desensamblador/Prog.hack
```

- compilar.sh compila los dos programas en la carpeta bin/ 
- ensamblador.sh recibe la ruta de un .asm y genera el .hack en la misma carpeta 
- desensamblador.sh recibe la ruta de un .hack y genera ProgDis.asm en la misma carpeta 

## Descripcion de los 2 ensambladores
**Ensamblador:** da dos pasadas. La primera valida cada linea en orden, registra las etiquetas con su dirección y guarda las instrucciones que analiza. La segunda resuelve los símbolos y codifica.
**Desensamblador:** decodifica y valida todas las lineas y después marca como destino toda direccion v ≤ n cargada por una instrucción A que precede a una C con salto, nombra los destinos L0, L1… por orden de dirección y escribe el programa con sus etiquetas. Al volver a ensamblar el resultado se obtiene el mismo .hack.

## Estructura del código

```
proyecto3/
├── compilar.sh              
├── ensamblador.sh          
├── desensamblador.sh
├── README.md      
├── ensamblador/             
│   ├── Main.java             
│   ├── Ensamblador.java     
│   ├── Analizador.java       
│   ├── TablaSimbolos.java    
│   ├── Tablas.java         
│   ├── Instruccion.java    
│   └── ErrorLinea.java     
├── desensamblador/         
│   ├── Main.java           
│   ├── Desensamblador.java  
│   ├── Decodificador.java    
│   ├── Tablas.java          
│   ├── Instruccion.java     
│   └── ErrorLinea.java      
├── pruebas/                  
│   ├── ensamblador/
│   ├── desensamblador/
│   ├── errores/
│   └── README.md        
```
