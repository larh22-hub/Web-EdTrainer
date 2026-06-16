# Taller de proyectos reales · PDI · UNAD — presentación

Presentación HTML autónoma (17 diapositivas) lista para desplegar en **Dokploy**
como sitio estático servido por nginx. Incluye la slide 4 con el **dashboard del
formulario en tiempo real** (lee el CSV publicado de Google Sheets cada 20 s).

## Contenido del paquete

```
Dockerfile          imagen nginx:alpine que sirve el sitio
nginx.conf          config de nginx + cabeceras de seguridad (CSP)
site/               archivos de la presentación
  index.html          el deck (= index_unad_pdi_taller.html)
  deck.css            sistema visual
  deck-stage.js       componente web del deck (navegación, miniaturas, impresión)
  diagnostico-live.html  dashboard del formulario (se carga en un iframe en la slide 4)
  assets/             logos + QR
```

## Desplegar en Dokploy

1. En Dokploy: **Create → Application**.
2. **Source**: sube el ZIP (o conéctalo a un repositorio Git que lo contenga).
3. **Build Type**: `Dockerfile` (Dokploy detecta el `Dockerfile` de la raíz).
4. **Port**: `80`.
5. Asigna un dominio en la pestaña **Domains** (Dokploy gestiona el HTTPS con Let's Encrypt).
6. **Deploy**. La presentación queda en `https://tu-dominio/`.

## Comprobar en local (opcional)

```bash
docker build -t taller-unad .
docker run --rm -p 8080:80 taller-unad
# abre http://localhost:8080
```

## Regenerar el ZIP tras actualizar la presentación

Desde la raíz del repo:

```bash
deck-unad/deploy/build-zip.sh            # genera el ZIP en ~/Downloads
deck-unad/deploy/build-zip.sh ./dist     # o en la carpeta que indiques
```

El script toma los archivos actuales de `deck-unad/`, los empaqueta junto a este
`Dockerfile` + `nginx.conf` y produce `edtrainer-taller-unad-dokploy.zip`.

## Notas

- El dashboard en vivo (slide 4) hace `fetch` al CSV de Google Sheets, que **redirige a
  `*.googleusercontent.com`**. Ambos dominios ya están permitidos en la CSP de `nginx.conf`
  (`connect-src`). No quites esas entradas o la slide dejará de cargar datos.
- Controles del deck: ←/→ o barra espaciadora para navegar, `R` para reiniciar,
  columna de miniaturas a la izquierda, y Ctrl/Cmd+P para exportar a PDF.
