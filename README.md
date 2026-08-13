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
