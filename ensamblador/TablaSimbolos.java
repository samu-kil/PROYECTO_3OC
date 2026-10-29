package ensamblador;

import java.util.HashMap;
import java.util.Map;


public final class TablaSimbolos {
    private final Map<String, Integer> tabla = new HashMap<>(Tablas.PREDEFINIDOS);
    private int siguienteVariable = 16;

    public void declararEtiqueta(String nombre, int direccion, int nLinea) {
        if (Tablas.PREDEFINIDOS.containsKey(nombre)) {
            throw new ErrorLinea(nLinea, "la etiqueta '" + nombre + "' usa el nombre de un símbolo predefinido");
        }
        if (tabla.containsKey(nombre)) {
            throw new ErrorLinea(nLinea, "etiqueta '" + nombre + "' declarada más de una vez");
        }
        tabla.put(nombre, direccion);
    }

    public int resolver(String nombre) {
        Integer dir = tabla.get(nombre);
        if (dir == null) {
            dir = siguienteVariable++;
            tabla.put(nombre, dir);
        }
        return dir;
    }
}
