# agff-weideplaner – Regeln für Claude

Weideplaner der AGFF und weitere Rechner zur Weideplanung: eigenständige HTML-Dateien ohne Build-Schritt.
Live https://app.graswachstum.ch/weideplaner/ (all-inkl, seit 23.11.2026), eingebettet in graswachstum.ch/werkzeuge/weideplaner
(Grav-Seite mit iframe, Vorlage `werkzeug`; die Seite führt live, nicht in git). Alte Dateiadressen auf graswachstum.ch leiten per
`.htaccess` hierher um (agff-familie `ebe0b3b`).
Kein Grav-Projekt; die Regeln aus `~/git/CLAUDE.md` zu Datenschutz, Deploy, Pushes und Commits gelten trotzdem.
Das Repo ist **öffentlich** (`.push-erlaubt`: oeffentlich *): keine Zugangsdaten, Personen- oder Betriebsdaten.

- **Arbeitsordner ist dieser hier** (`~/git/agff-weideplaner` auf dem Heimserver, seit 23.11.2026). Die frühere Kopie auf dem
  Laptop nicht mehr parallel weiterentwickeln, sonst laufen die Stände auseinander.
- **Sprache:** Benutzertexte, Kommentare und Doku auf Deutsch (Schweizer Schreibweise, «ss»).
- **Fachliches:** Formellogik des Excel-Originals nicht verändern (v1 bleibt die Referenz); keine Zahlen oder Regeln erfinden,
  Unbelegtes als Annahme kennzeichnen. Generation und Änderungsdatum stehen in der Fusszeile jeder Seite.
- **Lokal:** `docker compose up -d` → http://localhost:8089/ (nginx, Repo schreibgeschützt eingehängt, ohne Neustart aktuell).
  Port nach `grav-gemeinsam/PROJEKTE.md`; Image per Digest festgenagelt; nie über Traefik freigeben.
- **Kein Daten-Backend:** alles läuft im Browser.
- **Deploy:** `werkzeuge/deploy.sh --trocken` (nur lesen) darf Claude jederzeit ausführen. Es gibt keine Dev-Umgebung:
  `werkzeuge/deploy.sh` ohne Option geht direkt auf live und nur nach ausdrücklichem Ja von Martin für genau diesen Deploy.
  Das Skript sichert den Server-Ordner vorher selbst (`apps/weideplaner-sicherungen`). Der SSH-Zugang läuft über den
  vorhandenen KAS-Schlüssel von `dev` (`~/.ssh/config`); keine neuen Schlüssel ohne Martins Ja.
- **Pushes:** bei einem Deploy nach dem Dauer-Auftrag (`heimserver-werkzeuge/gitpush.py`, Prüfung auf sensible Daten); sonst nur
  auf Auftrag.
- **Commits:** Autor Martin Zbinden; Attribution laut Sitzung.
