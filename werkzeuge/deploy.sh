#!/bin/bash
# Deploy des Weideplaners nach KAS -> https://app.graswachstum.ch/weideplaner/
#
# Ziel ist /www/htdocs/w01573d0/apps/weideplaner/public; die oeffentliche Adresse haengt
# ueber den Symlink app.graswachstum.ch/weideplaner -> ../apps/weideplaner/public daran
# (gleiches Muster wie herbar). Veroeffentlicht werden nur die Web-Dateien: HTML und
# Symbole. README, Docker- und nginx-Konfiguration der lokalen Testumgebung bleiben hier.
#
# Ablauf: Sicherung des Server-Ordners -> alte Sicherungen aufraeumen (neueste behalten,
# von den aelteren je Kalenderwoche eine) -> rsync -> Abgleich (Pruefsummen, ohne Aenderung).
#
# Aufruf: werkzeuge/deploy.sh [--trocken]
set -euo pipefail
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
ZIEL=ssh-w01573d0@w01573d0.kasserver.com
ORDNER=/www/htdocs/w01573d0/apps/weideplaner/public
SICHERUNGEN=/www/htdocs/w01573d0/apps/weideplaner-sicherungen
cd "$(dirname "$0")/.."

# Positivliste: nur diese Dateien gehoeren ins Web. --delete raeumt den Server-Ordner
# entsprechend auf; ausgeschlossene Dateien dort werden dabei nicht angetastet.
NUR=(--include='*.html' --include='*.png' --include='*.ico' --include='*.svg' --exclude='*')
# Rechte gehoeren in jeden Aufruf: sonst meldet der Abgleich fuer jede Datei einen
# Rechteunterschied (lokal 664, auf dem Server 644).
RECHTE=(--chmod=D755,F644)

if [ "${1:-}" = "--trocken" ]; then
  echo "Was sich aendern wuerde (nichts wird geschrieben):"
  rsync -an -c --itemize-changes --delete "${RECHTE[@]}" "${NUR[@]}" ./ "$ZIEL:$ORDNER/"
  exit 0
fi

STEMPEL=$(date +%Y%m%d-%H%M%S)
ssh "$ZIEL" "mkdir -p $SICHERUNGEN && cd $(dirname $ORDNER) && tar czf $SICHERUNGEN/weideplaner-$STEMPEL.tgz public && ls -la $SICHERUNGEN/weideplaner-$STEMPEL.tgz"

# Aufraeumen nach der Regel des Benutzers: neueste Sicherung behalten, von den aelteren
# je Kalenderwoche nur die juengste.
ssh "$ZIEL" "ls -1 $SICHERUNGEN/weideplaner-20[0-9][0-9][0-9][0-9][0-9][0-9]-*.tgz 2>/dev/null | sort -r" \
  | while read -r f; do
      tag=$(basename "$f" | sed -E 's/^weideplaner-([0-9]{8})-.*/\1/')
      echo "$f $(date -d "$tag" +%G-W%V)"
    done \
  | awk 'NR == 1 { next } { if (gesehen[$2]++) print $1 }' \
  | while read -r f; do echo "loeschen $(basename "$f")"; ssh "$ZIEL" "rm -- '$f'"; done

rsync -a --delete "${RECHTE[@]}" "${NUR[@]}" ./ "$ZIEL:$ORDNER/"
echo "Abgleich (leer = gleich):"
rsync -an -c --itemize-changes --delete "${RECHTE[@]}" "${NUR[@]}" ./ "$ZIEL:$ORDNER/" | grep -v '^\.d' || true
echo "Fertig: https://app.graswachstum.ch/weideplaner/"
