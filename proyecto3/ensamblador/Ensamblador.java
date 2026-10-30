package ensamblador;
 
import java.util.ArrayList;
import java.util.List;
 
public final class Ensamblador {
    private Ensamblador() {}
 
/** ensamblador de dos pasadas*/
    public static List<String> ensamblar(List<String> lineas) {
        TablaSimbolos tabla = new TablaSimbolos();
        List<Instruccion> programa = new ArrayList<>();
 // Pasada 1: registra las etiquetas y guarda las instrucciones ya estructuradas.

        for (int i = 0; i < lineas.size(); i++) {
            int nLinea = i + 1;
            String limpia = Analizador.limpiar(lineas.get(i));
            if (limpia.isEmpty()) {
                continue;
            }
            if (Analizador.esEtiqueta(limpia)) {
                String nombre = Analizador.nombreEtiqueta(limpia, nLinea);
                tabla.declararEtiqueta(nombre, programa.size(), nLinea);
            } else {
                programa.add(Analizador.analizar(limpia, nLinea));
            }
        }
 // Pasada 2: resuelve simbolos y codifica.
        List<String> salida = new ArrayList<>(programa.size());
        for (Instruccion ins : programa) {
            salida.add(codificar(ins, tabla));
        }
        return salida;
    }
 
    private static String codificar(Instruccion ins, TablaSimbolos tabla) {
        if (ins.esA) {
            int valor = (ins.simbolo != null) ? tabla.resolver(ins.simbolo) : ins.valor;
            return "0" + aBinario15(valor);
        }
        return "111" + Tablas.COMP.get(ins.comp) + Tablas.DEST.get(ins.dest) + Tablas.JUMP.get(ins.jump);
    }
 
    private static String aBinario15(int valor) {
        String b = Integer.toBinaryString(valor);
        StringBuilder sb = new StringBuilder(15);
        for (int i = b.length(); i < 15; i++) {
            sb.append('0');
        }
        return sb.append(b).toString();
    }
}
 
