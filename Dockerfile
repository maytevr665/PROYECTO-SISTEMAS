# Dockerfile para Render: despliegue robusto de tu app Flask
FROM python:3.10-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY PROYECTO SISTEMAS/ ./PROYECTO SISTEMAS/
COPY requirements.txt ./

# Instala dependencias del sistema (para paquetes científicos y de imágenes)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala las dependencias de Python
RUN pip install --upgrade pip setuptools wheel build && pip install -r requirements.txt

# Expone el puerto por defecto de Flask/Gunicorn
EXPOSE 8000

# Comando para arrancar la app
CMD ["gunicorn", "--chdir", "PROYECTO SISTEMAS", "app:app", "--bind", "0.0.0.0:8000"] 