# Proyecto 3 Ensamblador y desensamblador en hack
se implemento un ensamblador (Prog.asm → Prog.hack) y un desensamblador (Prog.hack → ProgDis.asm, con etiquetas en los destinos de salto) para hack. Ambos detectan errores en sus entradas y informan la primera linea que es invalida.
## integrantes
-Samuel Quintero Quintero
## compilado y ejecucion
### platarofma
gran parte del proyecto se ejecuto en gitbash desde la carpeta de proyecto 3
### lenguaje
el trabajo se realizo en java, JDK 8 o superior (el código se compila con --release 8), las clases corren en cualquier java 8
java version: 1.8.0_511-b33
javac version: 25.0.5
## Estructura del código

```
proyecto3/
├── compilar.sh              
├── ensamblador.sh          
├── desensamblador.sh        
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
