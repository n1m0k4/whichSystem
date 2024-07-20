# Detectar Sistema Operativo por TTL

Este script de Bash detecta el sistema operativo probable de una máquina remota basado en el valor TTL (Time To Live) obtenido a través de un comando `ping`. Su funcionamiento está basado en el script de [S4vitar](https://github.com/s4vitar), pero a diferencia de su script que está hecho con `Python`, este está hecho con `Bash` y añade la funcionalidad de saber cuando la máquina está apagada o fuera de alcance.

Este script está pensado para facilitar el reconocimiento de un sistema operativo al hacer una máquina de OSCP, eJPT, eWPTX...etc, ya que normalmente no te suelen informar sobre el sistema operativo que tiene la/s máquina/s.

## Descripción

El script realiza un `ping` a una IP o nombre de host y analiza el valor del TTL en la respuesta para estimar el sistema operativo del destino. Basado en el TTL, el script hace las siguientes suposiciones:

- **TTL = 0**: La máquina está apagada.
- **TTL > 0 y ≤ 64**: La máquina probablemente es Linux.
- **TTL > 64**: La máquina probablemente es Windows.

## Requisitos

- Un sistema basado en Unix con Bash.
- El comando `ping` debe estar disponible en tu sistema.

## Instalación

No es necesario instalar nada adicional. Solo necesitas tener Bash y `ping` instalados, que suelen estar disponibles por defecto en la mayoría de los sistemas Unix.

## Uso

1. **Descargar el script**:
    ```bash
    wget https://github.com/n1m0k4/whichSystem/raw/main/whichSystem.sh
    ```

2. **(Opcional) Añadir el script a `/usr/local/bin`**:
    Para ejecutar el script desde cualquier ubicación, puedes copiarlo a `/usr/local/bin`:
    ```bash
    sudo cp whichSystem.sh /usr/local/bin/whichSystem
    ```
    Esto te permitirá ejecutar el script simplemente escribiendo `whichSystem` desde cualquier directorio.

3. **Dale permisos de ejecución**:

    ```bash
    sudo chmod +x /usr/local/bin/whichSystem
    ```

4. **Ejecuta el script proporcionando una IP o nombre de host**:

    ```bash
    whichSystem <IP o hostname>
    ```

   Reemplaza `<IP o hostname>` con la dirección IP o el nombre de host que deseas analizar.

## Ejemplos

Para analizar la dirección IP `192.168.1.1`:

```bash
whichSystem 192.168.1.1
```

Para analizar el nombre de host `example.com`:

```bash
whichSystem example.com
```

## Salidas Posibles

- "[!] `<IP>`: Está apagada o se está reiniciando [!]" si el TTL es 0 o si el `ping` falla.
- "[*] `<IP>`: Linux (TTL=`<TTL>`)" si el TTL es mayor que 0 pero menor o igual a 64.
- "[*] `<IP>`: Windows (TTL=`<TTL>`)" si el TTL es mayor a 64.
- "[!] Verifica que la IP sea correcta [!]" si la IP introducida no es correcta.

## Notas

- La estimación del sistema operativo basada en el TTL no es 100% precisa, ya que el TTL puede ser configurado y modificado.
- Este script es una herramienta simple para obtener una estimación y no debe usarse como una solución definitiva para identificar sistemas operativos.

## Contribuciones

¡Las contribuciones son bienvenidas! Si tienes sugerencias o mejoras para el script, por favor abre un *issue* o envía un *pull request*.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE.txt) para más detalles.
