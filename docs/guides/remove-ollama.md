# 1. Detener el servicio activo
sudo systemctl stop ollama

# 2. Deshabilitar el inicio automático
sudo systemctl disable ollama

# 3. Eliminar el archivo de configuración del servicio
sudo rm /etc/systemd/system/ollama.service

# 4. Eliminar el ejecutable (binario) de Ollama
sudo rm $(which ollama)

# 5. Borrar los modelos descargados y datos de la aplicación (OCUPA MUCHO ESPACIO)
sudo rm -rf /usr/share/ollama
sudo rm -rf ~/.ollama

# 6. Eliminar el usuario y grupo del sistema
sudo userdel ollama
sudo groupdel ollama

# 7. Recargar el demonio de systemd para aplicar cambios
sudo systemctl daemon-reload
