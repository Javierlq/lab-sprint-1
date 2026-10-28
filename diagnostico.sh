#!/bin/bash

#Variables de configuración
LOG_FILE="./diagnostico.log"
FECHA=$(date '+%Y-%m-%d %H:%M:%S')
SERVICIO="sshd"

# Inicio del log con Timestamp
echo "======================================" >> "$LOG_FILE"
echo "Reporte de Diagnóstico - $FECHA" >> "$LOG_FILE"
echo "======================================" >> "$LOG_FILE"

# 1. Diagnóstico de Disco
echo -e "\n[DISCO] Estado del almacenamiento en raíz:" >> "$LOG_FILE"
df -h / >> "$LOG_FILE"

# 2. Diagnóstico de Memoria
echo -e "\n[MEMORIA] Uso de RAM:" >> "$LOG_FILE"
free -m >> "$LOG_FILE"

# 3. Diagnóstico de Servicios (Mejora: Evaluación condicional)
echo -e "\n[SERVICIOS] Revisando servicios caídos en el sistema:" >> "$LOG_FILE"
if systemctl --failed --type=service | grep -q "0 loaded units listed"; then
    echo "ESTADO: OK - Todos los servicios están operando correctamente." >> "$LOG_FILE"
else
    echo "ALERTA CRÍTICA: Los siguientes servicios están con fallas" >> "$LOG_FILE"
	systemctl --failed --type=service --no-pager >> "$LOG_FILE"
fi

echo -e "\nDiagnóstico finalizado.\n" >> "$LOG_FILE"
