package ensamblador;


public final class Instruccion {
    public final boolean esA;
    public final String simbolo;
    public final int valor;
    public final String dest;
    public final String comp;
    public final String jump;

    private Instruccion(boolean esA, String simbolo, int valor, String dest, String comp, String jump) {
        this.esA = esA;
        this.simbolo = simbolo;
        this.valor = valor;
        this.dest = dest;
        this.comp = comp;
        this.jump = jump;
    }

    public static Instruccion constante(int valor) {
        return new Instruccion(true, null, valor, null, null, null);
    }

    public static Instruccion simbolo(String nombre) {
        return new Instruccion(true, nombre, 0, null, null, null);
    }

    public static Instruccion c(String dest, String comp, String jump) {
        return new Instruccion(false, null, 0, dest, comp, jump);
    }
}
