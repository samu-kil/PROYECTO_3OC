#!/usr/bin/env bash
# Compila ensamblador/ y desensamblador/ (si existe) en bin/.
# Se compila para Java 8 (--release 8): las clases corren en cualquier Java >= 8, aunque el
# "java" del PATH sea mas antiguo que el "javac" (error "class file version 69.0 ... up to 52.0").
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$DIR/bin"
FUENTES=("$DIR"/ensamblador/*.java)
if ls "$DIR"/desensamblador/*.java >/dev/null 2>&1; then
    FUENTES+=("$DIR"/desensamblador/*.java)
fi
if ! javac --release 8 -Xlint:-options -encoding UTF-8 -d "$DIR/bin" "${FUENTES[@]}" 2>/dev/null; then
    # javac 8 no conoce --release: se compila sin esa opcion(y se muestran los errores, si los hay)
    javac -encoding UTF-8 -d "$DIR/bin" "${FUENTES[@]}"
fi
