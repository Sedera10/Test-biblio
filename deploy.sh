#!/usr/bin/env bash
set -euo pipefail

WAR_NAME="VelonKan.war"
SRC_WAR="./$WAR_NAME"
DEST_DIR="/home/sedera/Documents/S4/apache-tomcat-10.1.28/webapps"

echo "Deploying $WAR_NAME to $DEST_DIR..."
if cp -f "$SRC_WAR" "$DEST_DIR/$WAR_NAME"; then
  echo "✅ Deploy successful."
else
  echo "❌ Deploy failed."
fi
