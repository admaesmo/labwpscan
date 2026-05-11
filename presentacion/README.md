# Presentacion Reveal.js: WPScan

Esta carpeta contiene una presentacion en Reveal.js para explicar WPScan, sus conceptos teoricos y el laboratorio local.

## Abrir la presentacion

Opcion rapida:

```text
presentacion/index.html
```

Abrir ese archivo en el navegador.

Opcion con servidor local:

```bash
cd presentacion
python3 -m http.server 9000
```

Luego abrir:

```text
http://localhost:9000
```

## Contenido

- Contexto de WordPress y superficie de ataque.
- Que es WPScan.
- Uso etico.
- Reconocimiento, fingerprinting, enumeracion y gestion de vulnerabilidades.
- Diagrama del flujo de WPScan.
- Diagrama de arquitectura del laboratorio.
- Comandos de practica.
- Como convertir salidas tecnicas en hallazgos.
- Cierre y fuentes.

## Nota

La presentacion usa Reveal.js desde CDN, asi que necesita conexion a Internet cuando se abra. Si necesitas una version completamente offline, descarga Reveal.js y cambia las rutas del HTML a archivos locales.
