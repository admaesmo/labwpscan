# Laboratorio local de WPScan

Este laboratorio despliega WordPress y MySQL en Docker para practicar WPScan de forma controlada. El objetivo es aprender reconocimiento, enumeracion e interpretacion de hallazgos sin escanear sistemas externos.

## 1. Requisitos

- Docker.
- Docker Compose.
- WPScan instalado en la maquina anfitriona, Kali Linux o Docker.
- Navegador web.

Verificar Docker:

```bash
docker --version
docker compose version
```

## 2. Levantar el laboratorio

Desde esta carpeta:

```bash
docker compose up -d
```

Abrir WordPress:

```text
http://localhost:8080
```

Completar la instalacion inicial desde el navegador. Para la practica puedes usar:

```text
Titulo del sitio: Laboratorio WPScan
Usuario: admin
Contrasena: cursoseguridad
Correo: admin@example.local
```

No uses credenciales reales. Este laboratorio es solo academico.

## 3. Preparar contenido de prueba

Dentro del panel de WordPress puedes:

- Crear una entrada de prueba.
- Instalar un plugin comun desde el repositorio oficial.
- Instalar un tema adicional.
- Crear un usuario con rol de autor.

Esto permite que WPScan tenga mas elementos para detectar.

## 4. Ejecutar WPScan

Escaneo basico:

```bash
wpscan --url http://localhost:8080
```

Enumerar usuarios:

```bash
wpscan --url http://localhost:8080 --enumerate u
```

Enumerar plugins y temas:

```bash
wpscan --url http://localhost:8080 --enumerate ap,at
```

Buscar componentes vulnerables, si tienes token:

```bash
wpscan --url http://localhost:8080 --enumerate vp,vt --api-token TU_TOKEN
```

Prueba controlada de contrasenas:

```bash
wpscan --url http://localhost:8080 --usernames admin --passwords wordlists/passwords-lab.txt
```

## 5. Guardar evidencias

Puedes guardar salidas en la carpeta `evidencias/`:

```bash
wpscan --url http://localhost:8080 --enumerate u --output evidencias/usuarios.txt
wpscan --url http://localhost:8080 --enumerate ap,at --output evidencias/componentes.txt
```

Luego completa `evidencias/plantilla-hallazgos.md`.

## 6. Apagar el laboratorio

Apagar contenedores sin borrar datos:

```bash
docker compose down
```

Apagar y borrar datos del laboratorio:

```bash
docker compose down -v
```

## 7. Mensaje para la exposicion

Este laboratorio muestra como un escaner de caja negra observa un WordPress desde fuera. La idea no es "hackear por hackear", sino aprender a identificar informacion expuesta, interpretarla y proponer mitigaciones defensivas.
