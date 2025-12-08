# Verbesserungsvorschläge für das Manuskript

## Status der Verbesserungen

- ✅ **Angewendet (siehe improvements-archive.md):** REF-01, REF-03, REF-04, REF-05, REF-06, REF-07, REF-09, REF-10, REF-11, REF-12, REF-13, REF-14, REF-15, REF-16, REF-17, REF-19, REF-20, REF-21, REF-22, REF-23, REF-24, REF-25, REF-26, REF-27, REF-28, REF-29, REF-30, REF-31, REF-32, REF-33, REF-34, REF-35, REF-36, REF-38, REF-39, REF-40, REF-41, REF-42
- ⏭️ **Übersprungen (auf Wunsch, siehe improvements-archive.md):** REF-02, REF-08, REF-18
- 📋 **Noch offen:** REF-37, REF-43 bis REF-61

---

## Noch offene Verbesserungsvorschläge

### [REF-02] sections/01-einleitung.qmd, Zeile 11 ⏭️ ÜBERSPRUNGEN
**Aktuell:** "Anhand der Analysebedarfe der Wissenschaft in den *Forschungsdatenzentrum des Statistischen Bundesamtes (hier kurz FDZ) und dem Forschungsdatenzentrum der Statistischen Ämter der Länder*"

**Vorschlag:** "Anhand der Analysebedarfe der Wissenschaft in den *Forschungsdatenzentren des Statistischen Bundesamtes (hier kurz FDZ) und der Statistischen Ämter der Länder*"

**Begründung:** 
- "Forschungsdatenzentrum" → Plural "Forschungsdatenzentren" (da zwei genannt werden)
- "Statistischen Bundesamtes" → "Statistischen Bundesamtes" (Eigenname)
- Parallelität der Struktur verbessert

---

### [REF-08] sections/02-anwendung.qmd, Zeile 26 ⏭️ ÜBERSPRUNGEN
**Aktuell:** "Bereits aktuell und insbesondere durch die anstehende Aktualisierung steht der Fachbereich sowie das FDZ vor der Herausforderung den hohe Bedarf an Speicherkapazität, Arbeitsspeicher und Prozessorleistung zu decken."

**Vorschlag:** "Bereits aktuell und insbesondere durch die anstehende Aktualisierung stehen der Fachbereich sowie das FDZ vor der Herausforderung, den hohen Bedarf an Speicherkapazität, Arbeitsspeicher und Prozessorleistung zu decken."

**Begründung:**
- "steht" → "stehen" (Plural, da zwei Subjekte)
- "den hohe" → "den hohen" (Akkusativ Deklination)
- Komma vor "den hohen Bedarf"

---

### [REF-18] sections/04-methoden.qmd, Zeile 5 ⏭️ ÜBERSPRUNGEN
**Aktuell:** "Wir bezeichnen im Folgenden ein Datenverarbeitungswerkzeug als **hochperformant**, wenn es Datenmengen verarbeiten kann, die den verfügbaren Arbeitsspeicher überschreiten, und dabei eine flexible und effiziente Nutzung der Ressourcen ermöglicht."

**Vorschlag:** Satz ist gut, könnte aber aufgeteilt werden für bessere Lesbarkeit:
"Wir bezeichnen im Folgenden ein Datenverarbeitungswerkzeug als **hochperformant**, wenn es zwei Kriterien erfüllt: Es kann Datenmengen verarbeiten, die den verfügbaren Arbeitsspeicher überschreiten, und ermöglicht dabei eine flexible und effiziente Nutzung der Ressourcen."

**Begründung:** Klarere Struktur durch explizite Nennung der zwei Kriterien.

---

### [REF-37] sections/05-benchmark.qmd, Zeile 76
**Aktuell:** "{polars}, {duckdb} und {arrow} lösen die betrachteten Auswertungen sogar"

**Vorschlag:** "Die Pakete polars, duckdb und arrow lösen die betrachteten Auswertungen sogar"

**Begründung:** Konsistentere Schreibweise ohne geschweifte Klammern im Fließtext.

---

### [REF-43] sections/05-benchmark.qmd, Zeile 245
**Aktuell:** "Somit kommen wir insgesamt zu dem Ergebnis, dass {arrow} kombiniert mit {parquet} für die Bewältigung unserer Aufgaben die beste Datenverarbeitungsmethode ist"

**Vorschlag:** "Somit kommen wir insgesamt zu dem Ergebnis, dass arrow kombiniert mit Parquet für die Bewältigung unserer Aufgaben die beste Datenverarbeitungsmethode ist"

**Begründung:** Geschweifte Klammern entfernen (oder konsistent beibehalten).

---

### [REF-44] sections/05-benchmark.qmd, Zeile 247
**Aktuell:** "Für die relevanteste Datenmenge von 8 Mio. Beobachtungen zeigte {arrow} die geringsten Laufzeiten unter 5 Sekunden"

**Vorschlag:** "Für die relevanteste Datenmenge von 8 Mio. Beobachtungen zeigte arrow die geringsten Laufzeiten unter 5 Sekunden"

**Begründung:** Geschweifte Klammern entfernen.

---

### [REF-45] sections/05-benchmark.qmd, Zeile 249
**Aktuell:** "auch die Nutzererfahrung gefiel uns mit {arrow} am besten und somit waren die einhergehenden Entwicklungaufwände gegenüber den Anderen Methoden am geringsten."

**Vorschlag:** "Auch die Nutzererfahrung gefiel uns mit arrow am besten, und somit waren die einhergehenden Entwicklungsaufwände gegenüber den anderen Methoden am geringsten."

**Begründung:**
- Satzanfang großschreiben
- "Entwicklungaufwände" → "Entwicklungsaufwände" (Fugen-s)
- "Anderen" → "anderen" (Kleinschreibung)

---

### [REF-46] sections/05-benchmark.qmd, Zeile 250
**Aktuell:** ",{arrow} verwendet die anschauliche {tidyverse} Syntax nativ."

**Vorschlag:** "arrow verwendet die anschauliche tidyverse-Syntax nativ."

**Begründung:**
- Komma am Satzanfang entfernen
- "{tidyverse} Syntax" → "tidyverse-Syntax" (mit Bindestrich)

---

### [REF-47] sections/05-benchmark.qmd, Zeile 253
**Aktuell:** "{arrow} spart ausreichend Arbeitsspeicher (mit Verbrauch unter 1 GB) (tba: Fußnote zu duckdb/polars)."

**Vorschlag:** "arrow spart ausreichend Arbeitsspeicher (mit einem Verbrauch unter 1 GB)."

**Begründung:**
- Geschweifte Klammern entfernen
- "(tba: ...)" ist Editorial-Kommentar → entfernen oder als echte Fußnote umsetzen
- "mit Verbrauch" → "mit einem Verbrauch"

---

### [REF-48] sections/05-benchmark.qmd, Zeile 253
**Aktuell:** "Der Arbeitsspeicherverbrauch von {arrow} ist in unserer Auswertung nahezu konstant abhängig von der Datenmenge, sodass {arrow} leicht auf noch größere Datenmengen skalieren kann"

**Vorschlag:** "Der Arbeitsspeicherverbrauch von arrow ist in unserer Auswertung nahezu konstant und unabhängig von der Datenmenge, sodass arrow leicht auf noch größere Datenmengen skalieren kann"

**Begründung:**
- Geschweifte Klammern entfernen
- "konstant abhängig" → "konstant und unabhängig" (logischer)

---

### [REF-49] sections/05-benchmark.qmd, Zeile 254
**Aktuell:** "Dadurch das {arrow} die Nutzung auch von mehreren {parquet} Dateien unterstützt spart gegenüber CSV mind. 50% der Festplatte"

**Vorschlag:** "Dadurch dass arrow die Nutzung auch von mehreren Parquet-Dateien unterstützt, spart es gegenüber CSV mind. 50 % der Festplatte"

**Begründung:**
- "Dadurch das" → "Dadurch dass" (Konjunktion)
- Geschweifte Klammern entfernen
- "{parquet} Dateien" → "Parquet-Dateien" (mit Bindestrich)
- Komma nach "unterstützt"
- Leerzeichen vor %

---

### [REF-50] sections/07-ausblick.qmd, Zeile 7
**Aktuell:** "Wir kommen zu dem Schluss, dass eine Datenhaltung im Parquet-Format für Datenverarbeitungen bzw. -auswertungen in der Statistikproduktion und im FDZ gewinnbringend eingesetzt werden kann."

**Vorschlag:** "Wir kommen zu dem Schluss, dass eine Datenhaltung im Parquet-Format für Datenverarbeitungen und -auswertungen in der Statistikproduktion und im FDZ gewinnbringend eingesetzt werden kann."

**Begründung:** "bzw." → "und" (beide Anwendungsfälle gelten, nicht alternativ).

---

### [REF-51] sections/07-ausblick.qmd, Zeile 17
**Aktuell:** "die Analysesoftwarevielfalt verschlanken, somit Beschaffungen einsparen (besserer Ausdruck?)"

**Vorschlag:** "die Analysesoftwarevielfalt verschlanken und somit Beschaffungskosten einsparen"

**Begründung:**
- Editorial-Kommentar "(besserer Ausdruck?)" entfernen
- "Beschaffungen einsparen" → "Beschaffungskosten einsparen" (präziser)
- Komma → "und"

---

### [REF-52] sections/07-ausblick.qmd, Zeile 18
**Aktuell:** "Schulungsangebot benötigt für *"hoch-performante Auswertungen in R"*"

**Vorschlag:** "Ein Schulungsangebot für *hochperformante Auswertungen in R* wird benötigt"

**Begründung:**
- Satz grammatikalisch vollständig machen
- "hoch-performante" → "hochperformante" (ein Wort)
- Anführungszeichen nicht nötig bei Kursivschrift

---

### [REF-53] sections/07-ausblick.qmd, Zeile 19
**Aktuell:** "eigener Beitrag zu Open Source entscheidend, um die Etablierung zu fördern."

**Vorschlag:** "Ein eigener Beitrag zu Open Source ist entscheidend, um die Etablierung zu fördern."

**Begründung:** Satz grammatikalisch vollständig machen (Verb "ist" fehlt).

---

### [REF-54] sections/07-ausblick.qmd, Zeile 24
**Aktuell:** "(Vorsichtig!? Annette, lieber weg oder rein?) Vereinfachung der Statistikproduktion, durch leicht nachvollziehbaren Code und Fokus auf Wissensaufbau in R"

**Vorschlag:** Entweder den Editorial-Kommentar entfernen und den Satz beibehalten, oder den ganzen Punkt entfernen.

**Begründung:** Editorial-Kommentare gehören nicht in den finalen Text.

---

### [REF-55] sections/07-ausblick.qmd, Zeile 42
**Aktuell:** "Verwendung von R bietet am FDZ Bund einen deutlichen **Wettbewerbsvorteil in der emp. Forschung**."

**Vorschlag:** "Die Verwendung von R bietet am FDZ Bund einen deutlichen **Wettbewerbsvorteil in der empirischen Forschung**."

**Begründung:**
- Artikel "Die" am Satzanfang
- "emp." → "empirischen" (nicht abkürzen)

---

### [REF-56] sections/07-ausblick.qmd, Zeile 42
**Aktuell:** "Lediglich R ist (am GWAP und via KDFV) am FDZ Bund in der Lage große Datenmengen innerhalb von Sekunden zu analysieren und Datenmengen überhalb des verfügbaren Arbeitspeicher, wie das BTP, ohne vorherige Variablenselektion auszuwerten."

**Vorschlag:** "Lediglich R ist (am GWAP und via KDFV) am FDZ Bund in der Lage, große Datenmengen innerhalb von Sekunden zu analysieren und Datenmengen oberhalb des verfügbaren Arbeitsspeichers, wie das BTP, ohne vorherige Variablenselektion auszuwerten."

**Begründung:**
- Komma nach "Lage"
- "überhalb" → "oberhalb"
- "Arbeitspeicher" → "Arbeitsspeichers" (Genitiv)

---

### [REF-57] sections/07-ausblick.qmd, Zeile 45
**Aktuell:** "Dazu ist R als frei verfügbare Open-Source Software leicht zu lernen und {arrow} bietet hoch-performante Analysen selbst für R-Basiskenntnisse."

**Vorschlag:** "Dazu ist R als frei verfügbare Open-Source-Software leicht zu lernen, und arrow bietet hochperformante Analysen selbst für R-Basiskenntnisse."

**Begründung:**
- "Open-Source Software" → "Open-Source-Software" (mit Bindestrichen)
- Geschweifte Klammern entfernen
- "hoch-performante" → "hochperformante"
- Komma vor "und"

---

### [REF-58] sections/07-ausblick.qmd, Zeile 46
**Aktuell:** "Für analoge über-RAM-Verarbeitungen bietet Stata aktuell keine Lösung."

**Vorschlag:** "Für analoge Verarbeitungen über den RAM hinaus bietet Stata aktuell keine Lösung."

**Begründung:** "über-RAM-Verarbeitungen" → ausformulieren für bessere Lesbarkeit.

---

### [REF-59] sections/07-ausblick.qmd, Zeile 46
**Aktuell:** "R hervorragende Möglichkeiten bietet Performanz und Anwenderfreundlichkeit zu übertreffen."

**Vorschlag:** "R bietet hervorragende Möglichkeiten, Performanz und Anwenderfreundlichkeit zu übertreffen."

**Begründung:**
- Wortstellung: "R bietet" statt "R ... bietet"
- Komma vor Infinitivgruppe

---

### [REF-60] sections/07-ausblick.qmd, Zeile 51
**Aktuell:** "Die Analyse großer Datensätze in der amtlichen Statstik und den Forschungsdatenzen können von einem signifikanten Performanz-Boost profitieren"

**Vorschlag:** "Die Analyse großer Datensätze in der amtlichen Statistik und den Forschungsdatenzentren kann von einem signifikanten Performanz-Boost profitieren"

**Begründung:**
- "Statstik" → "Statistik" (Tippfehler bereits korrigiert)
- "Forschungsdatenzen" → "Forschungsdatenzentren"
- "können" → "kann" (Subjekt ist Singular "Die Analyse")

---

### [REF-61] sections/07-ausblick.qmd, Zeile 53
**Aktuell:** "Der Übergang erfordert jedoch eine **koordinierte Anstrengung** von Infrastrukturbetreibern, amtlicher Statistik, Forschungsdatenzentren und Forschenden. Die systematische Wissensaufbau, Dokumentation und Verbreitung von Best Practices wird entscheidend für den Erfolg sein."

**Vorschlag:** "Der Übergang erfordert jedoch eine **koordinierte Anstrengung** von Infrastrukturbetreibern, amtlicher Statistik, Forschungsdatenzentren und Forschenden. Der systematische Wissensaufbau, die Dokumentation und Verbreitung von Best Practices werden entscheidend für den Erfolg sein."

**Begründung:**
- "Die systematische Wissensaufbau" → "Der systematische Wissensaufbau" (Maskulinum)
- "wird" → "werden" (drei Subjekte)
- Artikel "die" vor "Dokumentation" einfügen

---

## TBA-Liste (To Be Announced/Added)

Alle "tba"-Platzhalter im Dokument, die ergänzt oder entfernt werden müssen:

### [TBA-01] sections/02-anwendung.qmd, Zeile 5 (Kommentar)
**Position:** In HTML-Kommentar
**Text:** "tba (Wunsch Oli an FB):"
**Aktion:** Kommentar - kann bleiben oder erweitert werden

### [TBA-02] sections/03-infrastruktur.qmd, Zeile 58
**Position:** In R-Code, Tabelle tbl-stba-rserver
**Text:** "tba" (Kerntakt Vorher)
**Aktion:** Sollte durch tatsächliche Taktfrequenz ersetzt werden

### [TBA-03] sections/03-infrastruktur.qmd, Zeile 65
**Position:** In R-Code, Tabelle tbl-stba-rserver
**Text:** "je tba" (Kerntakt Nachher)
**Aktion:** Sollte durch tatsächliche Taktfrequenz ersetzt werden

### [TBA-04] sections/04-methoden.qmd, Zeile 104 (Kommentar)
**Position:** In HTML-Kommentar bei arrow
**Text:** "tba - s. Vortrag"
**Aktion:** Kommentar - kann bleiben oder gelöscht werden

### [TBA-05] sections/04-methoden.qmd, Zeile 107 (Kommentar)
**Position:** In HTML-Kommentar bei duckdb
**Text:** "tba - s. Vortrag"
**Aktion:** Kommentar - kann bleiben oder gelöscht werden

### [TBA-06] sections/04-methoden.qmd, Zeile 145-147 (Kommentar)
**Position:** In auskommentierter Versions-Tabelle
**Text:** "tba" bei readr, dplyr, vroom Versionen
**Aktion:** Ganze Tabelle ist auskommentiert - kann bleiben

### [TBA-07] sections/05-benchmark.qmd, Zeile 229
**Position:** Im Text als Platzhalter
**Text:** "[tba: PLOT Laufzeit in Datenmenge der Tools]"
**Aktion:** **WICHTIG** - Sollte durch tatsächliche Grafik ersetzt oder entfernt werden

### [TBA-08] sections/05-benchmark.qmd, Zeile 237
**Position:** Im Text als Platzhalter
**Text:** "[tba: Plot der Performanz unterschiede]"
**Aktion:** **WICHTIG** - Sollte durch tatsächliche Grafik ersetzt oder entfernt werden

### [TBA-09] sections/05-benchmark.qmd, Zeile 252
**Position:** Im Text in Klammern
**Text:** "(tba: Fußnote zu duckdb/polars)"
**Aktion:** **WICHTIG** - Sollte durch Fußnote ersetzt oder entfernt werden (siehe auch REF-47)

### [TBA-10] sections/05-benchmark.qmd, Zeile 291
**Position:** Im Text als Platzhalter
**Text:** "[tba: Plot RAM-Bedarf abhängig von der Datenmenge]"
**Aktion:** **WICHTIG** - Sollte durch tatsächliche Grafik ersetzt oder entfernt werden

### [TBA-11] sections/05-benchmark.qmd, Zeile 306 (Kommentar)
**Position:** In HTML-Kommentar
**Text:** "(tba: mit obigem zusammenführen)"
**Aktion:** Kommentar - kann bleiben oder bearbeitet werden

### Zusammenfassung TBA-Liste:
- **4 kritische TBAs** im publizierten Text (Zeile 229, 237, 252, 291) - sollten vor Veröffentlichung ersetzt werden
- **2 TBAs** in Tabellendaten (Kerntakt) - sollten ergänzt werden
- **5 TBAs** in Kommentaren - unkritisch

---

## Konsistenz-Überprüfungen

### [CONS-01] Schreibweise von Paket-Namen
Die Schreibweise von R-Paketen ist inkonsistent: manchmal mit geschweiften Klammern `{arrow}`, manchmal ohne. Empfehlung: Entweder durchgehend mit Klammern im Code-Kontext oder durchgehend ohne im Fließtext.

### [CONS-02] Bindestriche bei Komposita
Manche zusammengesetzten Wörter haben Bindestriche, andere nicht:
- "hoch-performant" vs "hochperformant"
- "OnSite-Server" vs "OnSite Server"
- "Parquet-Format" vs "parquet Dateien"

Empfehlung: Konsistente Schreibweise festlegen und durchziehen.

### [CONS-03] Prozentangaben
Manchmal mit Leerzeichen vor %, manchmal ohne. Deutsche Typografie empfiehlt Leerzeichen: "10 %" statt "10%".

### [CONS-04] Abkürzungen
- "ca." vs "etwa" → wissenschaftliche Texte bevorzugen "etwa"
- "bzw." vs "und" → prüfen ob wirklich "beziehungsweise" gemeint ist

---

## Stilistische Hinweise (optional)

### [STIL-01] Übermäßige Verwendung von "daher", "somit", "dadurch"
Diese Konnektoren erscheinen sehr häufig. Gelegentliche Variation würde den Lesefluss verbessern.

### [STIL-02] Lange Sätze
Einige Sätze sind sehr lang (>40 Wörter). Erwägen Sie Aufteilung für bessere Lesbarkeit, besonders in sections/01-einleitung.qmd und sections/05-benchmark.qmd.

### [STIL-03] Passivkonstruktionen
Viele Passivkonstruktionen ("wird ... durchgeführt", "wurde ... gemessen"). Aktiv wäre direkter: "wir führen ... durch", "wir messen".

---

## Offene Fragen für die Autoren

### [FRAGE-01] sections/05-benchmark.qmd, Zeile 3
Die Überschrift "RAM nicht aussagekräftig!!!" sollte entfernt oder in den Text integriert werden.

### [FRAGE-02] sections/03-infrastruktur.qmd, @tbl-stba-rserver
"tba" (to be announced) erscheint in der Tabelle bei "Kerntakt". Sollte ergänzt werden. (Siehe auch TBA-02, TBA-03)

### [FRAGE-03] sections/07-ausblick.qmd, Zeile 24
Editorial-Kommentar "(Vorsichtig!? Annette, lieber weg oder rein?)" muss entfernt werden. (Siehe auch REF-54)

### [FRAGE-04] sections/07-ausblick.qmd, Zeile 17
Editorial-Kommentar "(besserer Ausdruck?)" muss entfernt werden. (Siehe auch REF-51)

### [FRAGE-05] sections/05-benchmark.qmd, mehrere Stellen
Editorial-Kommentare mit "tba" müssen ergänzt oder entfernt werden. (Siehe TBA-Liste oben)

### [FRAGE-06] Allgemein
Soll die Schreibweise "FDZ-OnSite-Server" oder "FDZ OnSite-Server" verwendet werden? Aktuell inkonsistent.

---

## Zusammenfassung

**Anzahl behobener Tippfehler:** 17
**Anzahl angewendeter Verbesserungen:** 38 (aus 61) → siehe improvements-archive.md
**Noch offene Verbesserungen:** 20 (REF-37, REF-43-61) + 3 übersprungene (REF-02, REF-08, REF-18)
**TBA-Platzhalter:** 11 (davon 4 kritisch)
**Konsistenz-Fragen:** 4
**Stilistische Hinweise:** 3
**Offene Fragen:** 6

Die meisten kritischen Fehler wurden behoben. Die verbleibenden Vorschläge betreffen hauptsächlich Konsistenz (Paket-Namen in geschweiften Klammern) und stilistische Feinheiten.
