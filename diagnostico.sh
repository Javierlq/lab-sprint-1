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
echo -e "\n[SERVICIOS] Revisando $SERVICIO:" >> "$LOG_FILE"
if systemctl is-active --quiet "$SERVICIO"; then
    echo "ESTADO: OK - El servicio $SERVICIO está corriendo." >> "$LOG_FILE"
else
    echo "ALERTA CRÍTICA: El servicio $SERVICIO está caído." >> "$LOG_FILE"
fi

echo -e "\nDiagnóstico finalizado.\n" >> "$LOG_FILE"
