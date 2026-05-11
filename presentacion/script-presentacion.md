# Script para la presentacion: WPScan

Duracion sugerida: 10 a 14 minutos.  
Objetivo: explicar que es WPScan, como funciona, y como se aplica en un laboratorio con dos escenarios: WordPress actualizado y WordPress vulnerable.

## Diapositiva 1: Titulo

Buenos dias. Mi presentacion trata sobre WPScan, una herramienta de analisis de seguridad enfocada en sitios WordPress.

La idea principal es entender tres cosas: en que contexto se usa, que conceptos de seguridad hay detras y como se aplica en un laboratorio local con dos escenarios: uno actualizado y otro vulnerable.

## Diapositiva 2: Pregunta guia

La pregunta que guia la exposicion es: como puede un auditor observar un sitio WordPress desde fuera y convertir esa informacion en acciones defensivas?

WPScan ayuda a recolectar informacion visible, como versiones, plugins, temas, usuarios o archivos expuestos. Pero la parte importante no es solo ejecutar la herramienta. El valor esta en interpretar los resultados, evaluar el riesgo y proponer mitigaciones.

## Diapositiva 3: Contexto

WordPress es muy usado porque permite crear sitios de forma rapida mediante plugins y temas. Esa ventaja tambien crea una superficie de ataque mas amplia.

Un sitio WordPress no depende solo del nucleo del CMS. Tambien incluye plugins, temas, usuarios, la API REST, XML-RPC, backups y logs. Si alguno de esos componentes queda mal configurado o desactualizado, puede convertirse en un punto de riesgo.

## Diapositiva 4: Que es WPScan

WPScan es un escaner de caja negra especializado en WordPress. Caja negra significa que analiza el sitio desde afuera, sin acceder al codigo fuente interno ni al servidor.

La herramienta realiza peticiones HTTP, busca pistas propias de WordPress y trata de identificar componentes como plugins, temas y usuarios. Luego puede relacionar esos componentes con vulnerabilidades conocidas, especialmente si se usa un token de API.

## Diapositiva 5: Uso etico

Antes de hablar de comandos, es importante aclarar el uso etico. WPScan debe usarse solo en sistemas propios, laboratorios o activos donde exista autorizacion explicita.

Aunque muchas pruebas sean de reconocimiento, siguen generando trafico y pueden revelar informacion sensible. Por eso se debe definir el alcance, evitar pruebas agresivas en produccion y no ejecutar fuerza bruta sin permiso especifico.

## Diapositiva 6: Teoria base

WPScan se apoya en cuatro conceptos principales.

El primero es reconocimiento: recopilar informacion visible del objetivo. El segundo es fingerprinting: inferir tecnologias o versiones a partir de pistas externas. El tercero es enumeracion: listar usuarios, plugins, temas o archivos detectables. Y el cuarto es gestion de vulnerabilidades: identificar riesgos, priorizarlos, corregirlos y verificar las correcciones.

## Diapositiva 7: Flujo de WPScan

Este diagrama resume el flujo general. Primero esta el objetivo, que en este caso es WordPress. WPScan le hace peticiones HTTP y aplica tecnicas de fingerprinting y enumeracion.

Despues, si se usa la API, compara los componentes detectados con una base de datos de vulnerabilidades. Finalmente, el resultado debe convertirse en un informe donde se explique el riesgo y la recomendacion. La herramienta entrega datos; el analista les da sentido.

## Diapositiva 8: Laboratorio local

Para practicar sin afectar sistemas reales, se construyo un laboratorio local. La arquitectura es simple: desde la maquina anfitriona se usa el navegador y WPScan; WordPress corre en Docker y se conecta a una base de datos MySQL.

El objetivo del laboratorio es practicar reconocimiento, enumeracion y deteccion de componentes vulnerables en un entorno controlado.

## Diapositiva 9: Dos escenarios

El laboratorio tiene dos escenarios. El primero es un WordPress actualizado en `http://localhost:8080`. Este escenario sirve para observar reconocimiento normal y comprobar que un sistema actualizado puede no arrojar vulnerabilidades criticas.

El segundo escenario es un WordPress vulnerable en `http://localhost:8081`. Este instala componentes desactualizados como WordPress 5.8, Contact Form 7 5.3.1, WooCommerce 3.4.5 y Twenty Nineteen 1.5. Su objetivo es mostrar como WPScan detecta componentes antiguos y, con token de API, vulnerabilidades conocidas.

## Diapositiva 10: Estructura creada

La carpeta del laboratorio incluye el Compose del WordPress actualizado, el Compose del WordPress vulnerable, el README, comandos de apoyo, la wordlist y el script que prepara el escenario vulnerable.

Esto permite que la practica sea reproducible: otra persona puede descargar el laboratorio, levantar los contenedores y ejecutar los mismos comandos.

## Diapositiva 11: Levantar escenarios

Para iniciar el escenario actualizado se entra a la carpeta y se ejecuta `docker compose up -d`. Luego se abre `http://localhost:8080`.

Para iniciar el escenario vulnerable se ejecuta el script `preparar-wordpress-vulnerable.sh`. Ese script levanta el contenedor vulnerable, instala WordPress y agrega componentes antiguos de forma intencional. El sitio queda en `http://localhost:8081`.

## Diapositiva 12: Comandos de practica

El primer comando es el escaneo basico contra el WordPress actualizado: `wpscan --url http://localhost:8080`.

Luego se pueden enumerar usuarios, plugins y temas. Para el vulnerable se usa `http://localhost:8081`, y el comando con `--api-token` permite consultar vulnerabilidades conocidas. Esa comparacion es el centro del laboratorio.

## Diapositiva 13: API token

El token de API permite que WPScan consulte la base de datos de vulnerabilidades conocidas. Esto es importante porque detectar un plugin no es suficiente; tambien hay que saber si su version esta asociada a una vulnerabilidad reportada.

El token debe protegerse. No se debe publicar en capturas, repositorios ni documentos compartidos.

## Diapositiva 14: Que debe arrojar

En el WordPress actualizado, lo normal es obtener hallazgos de reconocimiento: tecnologia detectada, tema activo, usuarios si son enumerables y pocos reportes criticos si todo esta actualizado.

En el WordPress vulnerable, se espera detectar componentes antiguos. Con API token, WPScan deberia reportar vulnerabilidades conocidas asociadas a esos componentes. Esto permite explicar la diferencia entre un hallazgo y una vulnerabilidad.

## Diapositiva 15: Prueba controlada

En el laboratorio tambien se puede hacer una prueba controlada de contrasenas con una lista pequena.

Esto permite demostrar el riesgo de usar credenciales debiles. Sin embargo, esta prueba solo debe hacerse en laboratorios o sistemas con autorizacion explicita, porque en un entorno real puede bloquear cuentas, activar alertas o afectar la disponibilidad.

## Diapositiva 16: De salida tecnica a informe

Una salida tecnica no es automaticamente un informe. Para que el resultado sea util, cada hallazgo debe tener evidencia, riesgo, impacto, recomendacion y prioridad.

Por ejemplo, si WPScan detecta usuarios, la evidencia es la salida del comando. El riesgo es que esa informacion pueda usarse en ataques de contrasena o phishing. La recomendacion seria aplicar MFA, limitar intentos de acceso y monitorear logs.

## Diapositiva 17: Ejemplo de interpretacion

En este ejemplo, el hallazgo es un usuario administrador enumerable. Por si solo puede parecer algo menor, pero combinado con contrasenas debiles se vuelve mas peligroso.

La mitigacion no es depender solo de ocultar el usuario. Lo importante es reforzar la autenticacion: contrasenas robustas, MFA, limite de intentos fallidos y monitoreo.

## Diapositiva 18: Defensa en profundidad

La defensa de WordPress debe ser por capas. No basta con una sola medida.

Se recomienda mantener actualizado el nucleo, los plugins y los temas; eliminar componentes innecesarios; proteger backups, logs y archivos sensibles; y revisar periodicamente el sitio con herramientas autorizadas como WPScan.

## Diapositiva 19: Limitaciones

WPScan es util, pero no reemplaza una auditoria completa. Puede tener falsos positivos o falsos negativos, y depende de lo que sea visible desde fuera.

Tampoco analiza toda la logica de negocio ni reemplaza una revision manual o una revision de codigo. Por eso debe verse como una herramienta dentro de un proceso de seguridad mas amplio.

## Diapositiva 20: Cierre

Como conclusion, WPScan permite entender como se ve un WordPress desde fuera. En el laboratorio se conectan reconocimiento, enumeracion, gestion de vulnerabilidades y mitigacion defensiva.

La comparacion entre el escenario actualizado y el vulnerable muestra que mantener actualizado WordPress, plugins y temas es una medida de seguridad fundamental.

## Diapositiva 21: Fuentes

Para la investigacion se usaron fuentes oficiales: el sitio de WPScan, la documentacion del escaner CLI, la documentacion de la API, el repositorio oficial en GitHub y la base de datos de vulnerabilidades de WPScan.

Estas fuentes respaldan tanto la parte tecnica como el uso responsable de la herramienta.

## Cierre corto por si falta tiempo

Si necesito cerrar rapidamente, diria:

WPScan es una herramienta de caja negra para analizar WordPress desde el exterior. En el laboratorio local se comparan dos escenarios: un WordPress actualizado y otro vulnerable. El primero muestra reconocimiento normal; el segundo permite observar componentes desactualizados y vulnerabilidades conocidas con API token. El objetivo es defensivo: interpretar hallazgos, priorizar riesgos y proponer mitigaciones.
