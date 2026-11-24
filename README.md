# Weideplanung – Rechner-Sammlung

Dieses Repo enthält interaktive HTML/JS-Rechner rund um Weideplanung und
-infrastruktur. Alle Tools sind eigenständige HTML-Dateien (kein Build-Schritt
nötig) – einfach im Browser öffnen.

## Dateien

| Datei | Beschreibung |
|---|---|
| `AGFF_Weideplaner_v1.html` | Nachbau des AGFF-Weideplaners (Excel-Original), Formellogik 1:1 übernommen. Stabile Basisversion ohne Erweiterungen. |
| `AGFF_Weideplaner_v2.html` | Wie v1, zusätzlich mit **Dürre-Stresstest-Modul**: Szenario-Umschaltung Normaljahr/Dürre, gekoppelte Reduktion von Graszuwachs & Weideanteil, automatischer Vergleich beider Szenarien (Flächenbedarf, Futterkosten, Einsparungen). |
| `Weideinfrastruktur_Rechner.html` | Investitionsrechner für Weideinfrastruktur (Rp./kg Milch je Massnahme). |
| `Futterkosten_Schaetzer.html` | Schätzt Rp./kg TS für Stall- und Weidefutter als Ausgangswerte für v2. |

Dateinamen sind bewusst ohne Versionsnummer, ausser bei den zwei parallel
aktiven AGFF-Weideplaner-Versionen (v1/v2). Generation und letztes
Änderungsdatum stehen stattdessen in der Fusszeile jeder Seite.

## Warum zwei AGFF-Versionen parallel?

v1 bleibt als schlanke, möglichst nah am Excel-Original gehaltene Referenz
bestehen. v2 ist die aktive Weiterentwicklung mit dem Dürre-Modul und
zukünftigen Erweiterungen. Bei Bedarf können weitere Module (z. B. eine
Verknüpfung mit dem Infrastruktur-Rechner) zuerst in v2 erprobt und später
– falls sinnvoll – auch in v1 zurückportiert werden.

## Live: https://app.graswachstum.ch/weideplaner/

Die Werkzeuge liegen auf dem KAS-Server (all-inkl) unter
`<Konto>/apps/weideplaner/public`; die öffentliche Adresse hängt über den
Symlink `app.graswachstum.ch/weideplaner` daran (gleiches Muster wie die übrigen Apps).

```bash
werkzeuge/deploy.sh --trocken   # zeigt nur, was sich ändern würde
werkzeuge/deploy.sh             # Sicherung, Aufräumen, rsync, Abgleich
```

Veröffentlicht werden nur HTML-Dateien und Symbole — README, `docker-compose.yml` und
`nginx.conf` der lokalen Testumgebung bleiben im Repo.

### Voraussetzung für den Deploy

Ein SSH-Zugang zum KAS-Server. Das SSH-Ziel (`ssh-<konto>@<server>`) steht nicht im
öffentlichen Repo, sondern in `werkzeuge/deploy-ziel.lokal` (eine Zeile, in `.gitignore`)
oder in der Umgebungsvariable `WEIDEPLANER_SSH_ZIEL`. Auf dem Heimserver nutzt `dev` den
vorhandenen KAS-Schlüssel aus `~/.ssh/config` (gleicher Weg wie die übrigen Deploys); auf dem
Laptop liegt der Schlüssel im GNOME-Schlüsselbund. Das Skript nutzt den Agenten der laufenden
Sitzung und setzt den Schlüsselbund-Pfad nur, wenn kein Agent gesetzt ist.

## Lokal testen (http://localhost:8089)

Auf dem Heimserver läuft das Repo als statische Seite in einem nginx-Container, nur lokal
(`127.0.0.1:8089`, nicht über Traefik). Das Repo-Verzeichnis ist direkt in den Container
gemountet — Änderungen sind ohne Neustart sofort sichtbar.

```bash
docker compose up -d     # danach: http://localhost:8089/
```

## Arbeiten mit diesem Repo

```bash
# Historie ansehen
git log --oneline --graph --all

# Neuen Feature-Branch für Weiterentwicklung anlegen
git checkout -b feature/mein-thema

# Änderungen committen
git add .
git commit -m "Kurze Beschreibung der Änderung"
```

### Zu einem eigenen Remote pushen (z. B. GitHub)

```bash
git remote add origin git@github.com:<user>/<repo>.git
git push -u origin main
git push --tags
```

## Tags

- `v1.0.0` – erste versionierte Fassung (AGFF v1 + Infrastruktur-Rechner v3)
- `v2.0.0` – AGFF v2 mit Dürre-Stresstest-Modul hinzugefügt


## Lizenz

Code: © 2026 AGFF – Arbeitsgemeinschaft zur Förderung des Futterbaues, lizenziert unter der EUPL-1.2 (Datei `LICENSE`; amtliche
Fassungen auch auf Deutsch, Französisch und Italienisch: https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12). Nicht unter
die Lizenz fallen die Inhalte (Merkblätter, Zeichnungen, Fotos, Tabellen); die Rechte liegen bei der jeweiligen Quelle, meist bei der
AGFF. Die Lizenz wird zentral gepflegt in `heimserver-werkzeuge/lizenz`.
