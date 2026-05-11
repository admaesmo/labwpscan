#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker-compose.vulnerable.yml"
TARGET_URL="http://localhost:8081"

cd "$(dirname "$0")/.."

echo "[1/5] Levantando WordPress vulnerable en ${TARGET_URL}..."
docker compose -f "${COMPOSE_FILE}" up -d db_vuln wordpress_vuln

echo "[2/5] Esperando inicializacion de WordPress..."
for attempt in $(seq 1 30); do
  if docker compose -f "${COMPOSE_FILE}" exec -T wordpress_vuln test -f /var/www/html/wp-config.php; then
    break
  fi
  if [ "${attempt}" -eq 30 ]; then
    echo "No se encontro wp-config.php a tiempo. Revisa los logs con:"
    echo "docker compose -f ${COMPOSE_FILE} logs wordpress_vuln"
    exit 1
  fi
  sleep 3
done

echo "[3/5] Instalando WordPress desde WP-CLI si aun no esta instalado..."
if ! docker compose -f "${COMPOSE_FILE}" run --rm wpcli_vuln wp core is-installed --allow-root >/dev/null 2>&1; then
  docker compose -f "${COMPOSE_FILE}" run --rm wpcli_vuln wp core install \
    --url="${TARGET_URL}" \
    --title="Laboratorio WPScan Vulnerable" \
    --admin_user="admin" \
    --admin_password="cursoseguridad" \
    --admin_email="admin@example.local" \
    --skip-email \
    --allow-root
fi

echo "[4/5] Instalando componentes desactualizados para deteccion con WPScan..."
docker compose -f "${COMPOSE_FILE}" run --rm wpcli_vuln wp plugin install contact-form-7 --version=5.3.1 --activate --force --allow-root
docker compose -f "${COMPOSE_FILE}" run --rm wpcli_vuln wp plugin install woocommerce --version=3.4.5 --activate --force --allow-root
docker compose -f "${COMPOSE_FILE}" run --rm wpcli_vuln wp theme install twentynineteen --version=1.5 --activate --force --allow-root

echo "[5/5] Listo."
echo "Objetivo vulnerable: ${TARGET_URL}"
echo
echo "Comandos sugeridos:"
echo "wpscan --url ${TARGET_URL}"
echo "wpscan --url ${TARGET_URL} --enumerate ap,at,u --api-token TU_TOKEN"
echo
echo "Nota: este objetivo es intencionalmente inseguro. Usalo solo en local."
