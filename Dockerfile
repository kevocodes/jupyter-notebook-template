FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instalar herramientas básicas
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Crear usuario no root
RUN useradd -ms /bin/bash jupyter

# Crear directorio de trabajo
WORKDIR /home/jupyter

# Copiar requirements y crear carpetas antes de cambiar de usuario
COPY requirements.txt .
RUN mkdir /home/jupyter/notebooks /home/jupyter/data && chown -R jupyter:jupyter /home/jupyter

# Instalar JupyterLab y dependencias como root
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir jupyterlab && \
    pip install --no-cache-dir -r requirements.txt

# Cambiar a usuario no root
USER jupyter

EXPOSE 8888

# Comando para lanzar JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=''", "--notebook-dir=/home/jupyter/notebooks"]
