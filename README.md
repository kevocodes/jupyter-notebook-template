
---

# 🧪 Entorno Dockerizado para JupyterLab

Este repositorio contiene una configuración lista para correr **JupyterLab** dentro de un contenedor **Docker**, permitiendo un entorno aislado y reproducible para desarrollar con Python. El contenedor se crea a partir de una imagen personalizada basada en `python:3.12-slim`.

---

## 📁 Estructura del Proyecto

```
jupyterlab-docker/
├── .gitignore              # Archivo para excluir archivos innecesarios del control de versiones  
├── Dockerfile              # Archivo de definición para construir la imagen Docker
├── requirements.txt        # Dependencias de Python a instalar en el entorno
├── docker-compose.yml      # Archivo preconfigurado para orquestar el contenedor
└── notebooks/              # Carpeta donde se guardarán tus notebooks Jupyter
   └── data/               # Carpeta opcional para almacenar datasets, imágenes, etc.
```

---

## 🛠️ Requisitos Previos

Asegúrate de tener instalados los siguientes componentes antes de comenzar:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/?spm=a2ty_o01.29997173.0.0.30c8c921AKO4aP) (generalmente viene incluido con Docker Desktop)
  
---

## ▶️ Ejecución del entorno

Desde la raíz del proyecto, simplemente ejecuta este comando:

```bash
docker compose up -d --build
```

### 💡 Este comando:
- Construye la imagen (si es necesario o si hay cambios).
- Crea y lanza el contenedor automáticamente.
- Mantiene tus notebooks persistentes gracias al volumen definido.

> ⚠️ Nota: Al agregar una nueva dependencia en el archivo `requirements.txt` es necesario volver a ejecutar el comando de ejecución descrito anteriormente, de tal manera que el contenedor pueda utilizar al nueva dependencia. 
---

## 🖥️ Acceso a JupyterLab

Después de ejecutar el contenedor, deberías ver en la terminal un mensaje similar a:

```
[I 2025-05-08 03:14:03.312 ServerApp] Jupyter Server 2.15.0 is running at:
[I 2025-05-08 03:14:03.312 ServerApp] http://53e36d7deccb:8888/lab
[I 2025-05-08 03:14:03.312 ServerApp]     http://127.0.0.1:8888/lab
```

Puedes abrir ese enlace en tu navegador web o simplemente visitar:

👉 [http://localhost:8888/lab](http://localhost:8888/lab)

> ⚠️ Nota: No se genera token de seguridad debido al parámetro `--NotebookApp.token=''` en el `CMD`. Esto es conveniente para entornos locales, pero no recomendable para producción.

---

## 📦 Personalización del Entorno

Para añadir paquetes adicionales al entorno de trabajo:

1. Edita el archivo `requirements.txt` y agrega las librerías que necesites.
2. Reconstruye la imagen Docker y ejecuta el contenedor nuevamente:

```bash
docker compose up -d --build
```

Estas dependencias estarán disponibles cuando inicies JupyterLab.

---

## 🧹 Limpieza del Entorno

Si deseas eliminar el contenedor después de usarlo:

```bash
docker stop jupyterlab-container
docker rm jupyterlab-container
```

Y si también quieres borrar la imagen:

```bash
docker rmi jupyterlab-env
```

---

## 👤 Seguridad del Contenedor

- Se ha creado un usuario no-root (`jupyter`) dentro del contenedor para evitar ejecutar procesos como superusuario.
- El acceso está restringido al directorio `/home/jupyter` y sus subdirectorios.
- Los notebooks se ejecutan únicamente desde la carpeta montada como volumen (`notebooks`).

---

## ✅ Ventajas del Entorno

- **Reproducible**: Cualquier persona puede recrear el mismo entorno usando Docker.
- **Ligero**: Usa una imagen base ligera (`slim`) de Python.
- **Persistente**: Tus notebooks y datos se guardan fuera del contenedor gracias al volumen montado.
- **Seguro**: Se evita la ejecución como root dentro del contenedor.

---

## 📄 Licencia

MIT License – Consulta el archivo [LICENSE](./LICENSE) para más información.