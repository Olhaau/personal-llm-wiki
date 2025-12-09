# Verbesserungsvorschläge für das Manuskript

## Status-Übersicht

- ✅ **Angewendet:** 66 Verbesserungen (siehe improvements-archive.md für Details)
- 📋 **Noch offen:** 1 Vorschlag (REF-50)
- ⚠️ **Kritisch:** 4 TBA-Platzhalter im Text, die vor Veröffentlichung ersetzt werden müssen

---

## Noch offene Verbesserungsvorschläge

### [REF-50] sections/07-ausblick.qmd, Zeile 7
**Aktuell:** "Wir kommen zu dem Schluss, dass eine Datenhaltung im Parquet-Format für Datenverarbeitungen bzw. -auswertungen in der Statistikproduktion und im FDZ gewinnbringend eingesetzt werden kann."

**Vorschlag:** "Wir kommen zu dem Schluss, dass eine Datenhaltung im Parquet-Format für Datenverarbeitungen und -auswertungen in der Statistikproduktion und im FDZ gewinnbringend eingesetzt werden kann."

**Begründung:** "bzw." → "und" (beide Anwendungsfälle gelten gleichzeitig, nicht alternativ).

---

## Kritische TBA-Platzhalter (vor Veröffentlichung zu ersetzen!)

### [TBA-07] sections/05-benchmark.qmd, Zeile 229 ⚠️
**Text:** "[tba: PLOT Laufzeit in Datenmenge der Tools]"

**Aktion:** **KRITISCH** - Muss durch tatsächliche Grafik ersetzt oder entfernt werden

---

### [TBA-08] sections/05-benchmark.qmd, Zeile 237 ⚠️
**Text:** "[tba: Plot der Performanz unterschiede]"

**Aktion:** **KRITISCH** - Muss durch tatsächliche Grafik ersetzt oder entfernt werden

---

### [TBA-09] sections/05-benchmark.qmd, Zeile 252 ⚠️
**Text:** "(tba: Fußnote zu duckdb/polars)"

**Aktion:** **KRITISCH** - Muss durch Fußnote ersetzt oder entfernt werden

---

### [TBA-10] sections/05-benchmark.qmd, Zeile 291 ⚠️
**Text:** "[tba: Plot RAM-Bedarf abhängig von der Datenmenge]"

**Aktion:** **KRITISCH** - Muss durch tatsächliche Grafik ersetzt oder entfernt werden

---

## Unkritische TBA-Platzhalter (optional)

### [TBA-02/03] sections/03-infrastruktur.qmd, Zeile 58, 65
**Text:** "tba" bei Kerntakt-Angaben in Tabelle

**Aktion:** Sollte durch tatsächliche Taktfrequenz ergänzt werden (unkritisch, da in Tabelle)

---

### [TBA-04/05] sections/04-methoden.qmd, Zeile 104, 107
**Text:** "tba - s. Vortrag" in HTML-Kommentaren

**Aktion:** In Kommentaren, nicht im publizierten Text - unkritisch

---

## Konsistenz-Empfehlungen

### [CONS-01] Schreibweise von R-Paketen ✅ **ERLEDIGT**
**Problem:** Inkonsistente Verwendung von geschweiften Klammern: `{arrow}` vs. `arrow`

**Umgesetzte Lösung:** 
- Im Fließtext: **ohne** geschweifte Klammern und **mit Großbuchstaben** (z.B. "Arrow", "Tidyverse", "Data.table")
- In Code-Blöcken und Tabellen: **mit** geschweiften Klammern (z.B. `{arrow}`)

**Betroffene Dateien:**
- sections/05-benchmark.qmd: 30+ Ersetzungen
- sections/06-ergebnis.qmd: 15+ Ersetzungen (in Kommentaren)
- sections/07-ausblick.qmd: 3 Ersetzungen
- sections/04-methoden.qmd: Fußnoten angepasst

---

### [CONS-02] Bindestriche bei Komposita
**Problem:** Inkonsistente Schreibweise zusammengesetzter Wörter

**Beispiele:**
- "hochperformant" (empfohlen) vs. "hoch-performant"
- "OnSite-Server" (empfohlen für Eigennamen)

**Empfehlung:** Einheitliche Schreibweise im gesamten Dokument

---

### [CONS-03] Zahlenformatierung ✅ **ERLEDIGT**
**Problem:** Inkonsistente Formatierung von Zahlen und Prozentangaben

**Umgesetzte Lösung:**
- **Prozentangaben:** Immer mit Leerzeichen → "10 %", "90 %", "25–33 %"
- **Dezimalzeichen:** Komma (war bereits korrekt) → "4,7 Sekunden", "1,2 Minuten"
- **Tausendertrennzeichen:** Leerzeichen → "800 000", "8 000 000", "3 000 Merkmale"

**Betroffene Stellen:**
- sections/02-anwendung.qmd: "90%" → "90 %", "3000" → "3 000", Prozentliste angepasst
- sections/05-benchmark.qmd: "800.000" → "800 000", "10% BTP" → "10 % BTP", "1%" → "1 %", "25-33%" → "25–33 %"

---

## Bereits behobene Verbesserungen (Dezember 2024)

### Formatierungs-Korrekturen:
- ✅ **[INDEX-01]** index.qmd: "Business-Tax-Panels" → "Business Tax Panels"
- ✅ **[FMT-01]** sections/07-ausblick.qmd: Korrigierte Einrückung verschachtelter Bullet-Listen
- ✅ **[FMT-02]** _quarto.yml: `preserve-tabs: true` für DOCX hinzugefügt
- ✅ **[TERM-01]** sections/02-anwendung.qmd: Erklärung "Arbeitsspeicher (sog. Random-Access-Memory, kurz RAM)" bei erster Erwähnung hinzugefügt

### Einheitliche R-Paketnamen (9. Dezember 2024):
- ✅ **[CONS-01]** Alle R-Paketnamen im Fließtext einheitlich ohne geschweifte Klammern und mit Großbuchstaben
- ✅ **[REF-37]** "{polars}, {duckdb} und {arrow}" → "Polars, Duckdb und Arrow"
- ✅ **[REF-44]** "{arrow} die geringsten" → "Arrow die geringsten"
- ✅ **[REF-46]** ",{arrow} verwendet die anschauliche {tidyverse} Syntax" → "Arrow verwendet die anschauliche Tidyverse-Syntax"
- ✅ **[REF-45]** "Entwicklungaufwände" → "Entwicklungsaufwände", "Anderen" → "anderen"
- ✅ **[REF-47]** "(tba: ...)" entfernt, "mit Verbrauch" → "mit einem Verbrauch"
- ✅ **[REF-48]** "konstant abhängig" → "konstant und unabhängig"
- ✅ **[REF-49]** Komma ergänzt, "50%" → "50 %", "Parquet-Dateien" mit Bindestrich

### Einheitliche Zahlenformatierung (9. Dezember 2024):
- ✅ **[CONS-03]** Prozentangaben mit Leerzeichen: "90%" → "90 %", "1%" → "1 %", "10%" → "10 %"
- ✅ **[NUM-01]** Tausendertrennzeichen: "800.000" → "800 000", "8 000 000", "3000" → "3 000"
- ✅ **[NUM-02]** Bereichsangaben: "25-33%" → "25–33 %" (mit Halbgeviertstrich)
- ✅ **[NUM-03]** Dezimalkommas bereits korrekt: "4,7", "5,1", "1,2", "2,3"

### Grammatik und Rechtschreibung (früher):
- ✅ REF-43, 45, 47-49, 51-61: Diverse grammatikalische Korrekturen
- ✅ Tippfehler: "überhalb" → "oberhalb", "emp." → "empirischen"
- ✅ Grammatik: Plural-Verb-Kongruenz, fehlende Kommas, Artikel korrigiert

**Hinweis:** Vollständige Liste aller 57 angewendeten Verbesserungen siehe improvements-archive.md

---

## Zusammenfassung

| Kategorie | Anzahl | Status |
|-----------|--------|--------|
| Offene Vorschläge | 1 | REF-50 (bzw. → und) |
| Kritische TBAs | 4 | ⚠️ Vor Publikation zu ersetzen! |
| Unkritische TBAs | 3 | Optional (in Kommentaren/Tabellen) |
| Konsistenz-Empfehlungen | 1 | CONS-02 offen (Bindestriche) |
| Bereits behoben | 66 | Inkl. RAM-Erklärung |

---

## Nächste Schritte

### Vor der Veröffentlichung (Priorität HOCH):
1. ⚠️ **4 kritische TBA-Platzhalter ersetzen** (TBA-07 bis TBA-10)
2. 📋 **1 offener Vorschlag prüfen** (REF-50: "bzw." → "und")

### Optional (Priorität NIEDRIG):
3. Konsistenz-Empfehlung umsetzen (CONS-02: Bindestriche bei Komposita)
4. Unkritische TBA-Platzhalter ergänzen (TBA-02 bis TBA-05)

---

**Letzte Aktualisierung:** 9. Dezember 2024
