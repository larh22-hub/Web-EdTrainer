# Presentación estática "Taller de proyectos reales · PDI · UNAD"
# Imagen ligera de nginx que sirve el deck con cabeceras de seguridad.
FROM nginx:alpine

# Config propia (reemplaza la default)
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Archivos del sitio
COPY site/ /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://127.0.0.1/ >/dev/null 2>&1 || exit 1
