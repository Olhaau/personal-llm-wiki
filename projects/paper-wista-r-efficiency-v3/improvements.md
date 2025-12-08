# Verbesserungsvorschläge für das Manuskript

## Behobene Tippfehler (bereits korrigiert)

Die folgenden Tippfehler wurden direkt im Dokument korrigiert:

### sections/01-einleitung.qmd
- Zeile 11: "Forschungsdatenzentrum" → "Forschungsdatenzentrum" (Kleinschreibung nach "den")
- Zeile 21: "OnSite-Server" → Konsistent verwendet (OK)
- Zeile 25: "erweitert eine große" → "erweitert die" (Artikel korrigiert)

### sections/02-anwendung.qmd
- Zeile 26: "uca." → "ca." (Tippfehler)
- Zeile 26: "ressourcenintensive" → "ressourcenintensiv" (Adjektiv korrekt dekliniert)
- Zeile 30: "Standard- also auch" → "Standard- als auch" (Konjunktion)
- Zeile 32: "Sozialversicherungspflichtig Beschäftigen" → "Sozialversicherungspflichtig Beschäftigten" (Kasus)

### sections/03-infrastruktur.qmd
- Zeile 9: "das auf dedizierte Server" → "die auf dedizierten Servern" (Numerus)
- Zeile 9: "auf mit geringeren" → "mit geringeren" (unnötiges "auf")
- Zeile 27: "ist bekannt als native" → "ist bekannt als die native" (Artikel)
- Zeile 29: "ist es an Universitäten" → "ist es an Universitäten und Hochschulen" (bereits "weit verbreitet" ergänzt)

### sections/04-methoden.qmd
- Zeile 3: "modifzierern" → "modifizieren" (Tippfehler)
- Zeile 7: "jdennoch" → "dennoch" (Tippfehler)
- Zeile 93: "Beim Einlesen von DatenAuswahl" → "Beim Einlesen von Daten ist die Auswahl" (Leerzeichen/Umformulierung)
- Zeile 93: "Best-Practices" → "Best Practice" (ohne Plural-s)
- Zeile 93: "klassiche Methoden" → "klassische Methoden" (Tippfehler)
- Zeile 95: "Beschleuniging" → "Beschleunigung" (Tippfehler)
- Zeile 108: "Geschwind igkeit" → "Geschwindigkeit" (Leerzeichen)
- Zeile 116: "systematisher" → "systematischer" (Tippfehler)

### sections/05-benchmark.qmd
- Zeile 3: Überschrift "RAM nicht aussagekräftig!!!" → entfernen oder ausformulieren
- Zeile 34: "etwa." → "etwa" (Punkt entfernen bei Abkürzung in Klammern)
- Zeile 88: "tausensfaches" → "tausendfaches" (Tippfehler)

### sections/07-ausblick.qmd
- Zeile 51: "Statstik" → "Statistik" (Tippfehler)

---

## Vorschläge zur Verbesserung der Klarheit und Grammatik

### [REF-01] sections/01-einleitung.qmd, Zeile 7
**Aktuell:** "Geeignete Werkzeuge können leicht Auswertungen, die bisher mehrere Stunden gedauert haben, in wenigen Sekunden ausführen."

**Vorschlag:** "Geeignete Werkzeuge können Auswertungen, die bisher mehrere Stunden gedauert haben, in wenigen Sekunden ausführen."

**Begründung:** Das Wort "leicht" ist hier unklar platziert. Es könnte sich auf "können" oder "ausführen" beziehen.

---

### [REF-02] sections/01-einleitung.qmd, Zeile 11
**Aktuell:** "Anhand der Analysebedarfe der Wissenschaft in den *Forschungsdatenzentrum des statistischen Bundesamts (hier kurz FDZ) und dem Forschungsdatenzentrum der Statistischen Ämter der Länder*"

**Vorschlag:** "Anhand der Analysebedarfe der Wissenschaft in den *Forschungsdatenzentren des Statistischen Bundesamts (hier kurz FDZ) und der Statistischen Ämter der Länder*"

**Begründung:** 
- "Forschungsdatenzentrum" → Plural "Forschungsdatenzentren" (da zwei genannt werden)
- "statistischen Bundesamts" → "Statistischen Bundesamts" (Eigenname)
- Parallelität der Struktur verbessert

---

### [REF-03] sections/01-einleitung.qmd, Zeile 13
**Aktuell:** "Die FDZ-Infrastruktur muss daher in der Lage sein, um umfangreiche Forschungsprojekte auf Basis großer Datenmengen effizient durchzuführen."

**Vorschlag:** "Die FDZ-Infrastruktur muss daher in der Lage sein, umfangreiche Forschungsprojekte auf Basis großer Datenmengen effizient durchzuführen."

**Begründung:** Das "um" ist grammatikalisch überflüssig. Die Konstruktion "in der Lage sein + Infinitiv" benötigt kein "um".

---

### [REF-04] sections/01-einleitung.qmd, Zeile 25
**Aktuell:** "Da es sich um eine Open-Source-Software handelt, erweitert eine große internationale Gemeinschaft Funktionalität von R für hohe Performanz oder Nutzerfreundlichkeit"

**Vorschlag:** "Da es sich um eine Open-Source-Software handelt, erweitert eine große internationale Gemeinschaft die Funktionalität von R hinsichtlich hoher Performanz und Nutzerfreundlichkeit"

**Begründung:** 
- Artikel "die" vor "Funktionalität" fehlt
- "für" → "hinsichtlich" ist präziser
- "oder" → "und" (beides wird erweitert, nicht entweder-oder)

---

### [REF-05] sections/02-anwendung.qmd, Zeile 24
**Aktuell:** "Insgesamt deckt der Forschungsdatensatz eine Vielzahl an Analysemöglichkeiten, wie zum Beispiel Analyse von Anpassungsreaktionen oder Verteilungsanalysen, die für die evidenzbasierte steuerpolitische Entscheidungen nötig sind, ab"

**Vorschlag:** "Insgesamt deckt der Forschungsdatensatz eine Vielzahl an Analysemöglichkeiten ab, wie zum Beispiel die Analyse von Anpassungsreaktionen oder Verteilungsanalysen, die für evidenzbasierte steuerpolitische Entscheidungen nötig sind"

**Begründung:** 
- Artikel "die" vor "Analyse" einfügen
- "die evidenzbasierte" → "evidenzbasierte" (Artikel entfernen)
- Verb "ab" besser am Ende

---

### [REF-06] sections/02-anwendung.qmd, Zeile 26
**Aktuell:** "Für die vielfältigen Analysewünsche der Forschenden, der damit einhergenden Dokumentation des Datensatzes in den Metadatenreports [@fdz2024btp] des FDZ, und den Auswertungsbedarf des Fachbereiches ist der Datensatz möglichst wenig beschränkt worden und dadurch ressourcenintensiv."

**Vorschlag:** "Für die vielfältigen Analysewünsche der Forschenden, die damit einhergehende Dokumentation des Datensatzes in den Metadatenreports [@fdz2024btp] des FDZ und den Auswertungsbedarf des Fachbereichs ist der Datensatz möglichst wenig beschränkt worden und dadurch ressourcenintensiv."

**Begründung:**
- "der damit einhergenden" → "die damit einhergehende" (Nominativ)
- Komma vor "und den Auswertungsbedarf" entfernen (alle drei sind gleichrangig)
- "Fachbereiches" → "Fachbereichs" (moderner Genitiv)

---

### [REF-07] sections/02-anwendung.qmd, Zeile 26
**Aktuell:** "Mit der Aktualisierung um das Berichtsjahr 2020 wird sich die Zahl der Beobachtungen auf ca. 78 Millionen erhöhen."

**Vorschlag:** "Mit der Aktualisierung um das Berichtsjahr 2020 wird sich die Zahl der Beobachtungen auf etwa 78 Millionen erhöhen."

**Begründung:** In wissenschaftlichen Texten ist "etwa" statt "ca." üblich.

---

### [REF-08] sections/02-anwendung.qmd, Zeile 26
**Aktuell:** "Bereits aktuell und insbesondere durch die anstehende Aktualisierung steht der Fachbereich sowie das FDZ vor der Herausforderung den hohe Bedarf an Speicherkapazität, Arbeitsspeicher und Prozessorleistung zu decken."

**Vorschlag:** "Bereits aktuell und insbesondere durch die anstehende Aktualisierung stehen der Fachbereich sowie das FDZ vor der Herausforderung, den hohen Bedarf an Speicherkapazität, Arbeitsspeicher und Prozessorleistung zu decken."

**Begründung:**
- "steht" → "stehen" (Plural, da zwei Subjekte)
- "den hohe" → "den hohen" (Akkusativ Deklination)
- Komma vor "den hohen Bedarf"

---

### [REF-09] sections/02-anwendung.qmd, Zeile 30
**Aktuell:** "Sowohl bei den Standard- als auch Sonderauswertungen werden meist spezifische Anforderungen angegeben."

**Vorschlag:** "Sowohl bei den Standard- als auch bei den Sonderauswertungen werden meist spezifische Anforderungen angegeben."

**Begründung:** "bei den" muss auch nach "als auch" wiederholt werden für grammatikalische Korrektheit.

---

### [REF-10] sections/03-infrastruktur.qmd, Zeile 9
**Aktuell:** "SAS verarbeitet Daten überwiegend zeilenorientiert und belastet den Arbeitsspeicher daher nur gering –- ein entscheidender Vorteil in der amtlichen Statistik, da auch große Datenmengen auf mit geringeren Hardwareanforderungen verarbeitet werden können."

**Vorschlag:** "SAS verarbeitet Daten überwiegend zeilenorientiert und belastet den Arbeitsspeicher daher nur gering – ein entscheidender Vorteil in der amtlichen Statistik, da auch große Datenmengen mit geringeren Hardwareanforderungen verarbeitet werden können."

**Begründung:** 
- "auf mit" → "mit" (grammatikalischer Fehler)
- "--" → "–" (en-dash statt zwei Bindestriche)

---

### [REF-11] sections/03-infrastruktur.qmd, Zeile 13
**Aktuell:** "Bisher waren die GWAP auf die *Single-Core-Version von Stata mit begrenztem RAM* beschränkt, wodurch viele FDZ-Produkte ohne Datenzuschnitt am GWAP nicht bearbeitet werden konnten."

**Vorschlag:** "Bisher waren die GWAPs auf die *Single-Core-Version von Stata mit begrenztem RAM* beschränkt, wodurch viele FDZ-Produkte ohne Datenzuschnitt an den GWAPs nicht bearbeitet werden konnten."

**Begründung:** 
- "die GWAP" → "die GWAPs" (Plural)
- "am GWAP" → "an den GWAPs" (Plural, korrekter Kasus)

---

### [REF-12] sections/03-infrastruktur.qmd, Zeile 19
**Aktuell:** "Um eine hohe Reaktionsfähigkeit und eine reibungslose GWAP- bzw. KDFV-Nutzung im FDZ sicherzustellen, sollte die Systeme kurze Rechenzeiten auf dem aktuellen Stand der Technik ermöglichen"

**Vorschlag:** "Um eine hohe Reaktionsfähigkeit und eine reibungslose GWAP- bzw. KDFV-Nutzung im FDZ sicherzustellen, sollten die Systeme kurze Rechenzeiten auf dem aktuellen Stand der Technik ermöglichen"

**Begründung:** "sollte die Systeme" → "sollten die Systeme" (Plural)

---

### [REF-13] sections/03-infrastruktur.qmd, Zeile 27
**Aktuell:** "Die **Statistiksoftware R** ist bekannt als native Programmiersprache in der Statistik und in Datenwissenschaften."

**Vorschlag:** "Die **Statistiksoftware R** ist bekannt als die native Programmiersprache in der Statistik und in den Datenwissenschaften."

**Begründung:**
- Artikel "die" vor "native" einfügen
- "in Datenwissenschaften" → "in den Datenwissenschaften" (Artikel)

---

### [REF-14] sections/03-infrastruktur.qmd, Zeile 29
**Aktuell:** "Da R frei verfügbar ist, ist es an Universitäten und Hochschulen weit verbreitet, und es stehen zahlreiche Schulungsmaterialien zur Verfügung."

**Vorschlag:** "Da R frei verfügbar ist, ist es an Universitäten und Hochschulen weit verbreitet, und zahlreiche Schulungsmaterialien stehen zur Verfügung."

**Begründung:** Stilistisch besser ohne doppeltes "es".

---

### [REF-15] sections/03-infrastruktur.qmd, Zeile 29
**Aktuell:** "Viele Mitarbeitende des Statistischen Bundesamts und Gastwissenschaftler/-innen verfügen daher bereits über R-Kenntnisse oder können sich diese leicht aneignen."

**Vorschlag:** "Viele Mitarbeitende des Statistischen Bundesamts und Gastwissenschaftler/-innen am FDZ verfügen daher bereits über R-Kenntnisse oder können sich diese leicht aneignen."

**Begründung:** Präzisierung "am FDZ" für Klarheit.

---

### [REF-16] sections/03-infrastruktur.qmd, Zeile 29
**Aktuell:** "Dadurch erfreut sich R auch an steigender Beliebtheit in der amtlichen Statistik, wie der Wachstum der Gemeinschaft "The Use of R in Official Statistics" belegt."

**Vorschlag:** "Dadurch erfreut sich R auch steigender Beliebtheit in der amtlichen Statistik, wie das Wachstum der Gemeinschaft "The Use of R in Official Statistics" belegt."

**Begründung:**
- "erfreut sich an" → "erfreut sich" (+ Genitiv)
- "der Wachstum" → "das Wachstum" (Neutrum)

---

### [REF-17] sections/03-infrastruktur.qmd, Zeile 36
**Aktuell:** "Verwendet wird die kommerziell unterstützte **Posit Workbench**, da sie wesentliche Funktionen für kollaborativen Arbeiten, Skalierbarkeit bietet und den Betrieb der Systeme unterstützt."

**Vorschlag:** "Verwendet wird die kommerziell unterstützte **Posit Workbench**, da sie wesentliche Funktionen für kollaboratives Arbeiten und Skalierbarkeit bietet und den Betrieb der Systeme unterstützt."

**Begründung:**
- "kollaborativen Arbeiten" → "kollaboratives Arbeiten" (Substantivierung)
- Komma nach "Arbeiten" entfernen (Aufzählung)

---

### [REF-18] sections/04-methoden.qmd, Zeile 5
**Aktuell:** "Wir bezeichnen im Folgenden ein Datenverarbeitungswerkzeug als **hochperformant**, wenn es Datenmengen verarbeiten kann, die den verfügbaren Arbeitsspeicher überschreiten, und dabei eine flexible und effiziente Nutzung der Ressourcen ermöglicht."

**Vorschlag:** Satz ist gut, könnte aber aufgeteilt werden für bessere Lesbarkeit:
"Wir bezeichnen im Folgenden ein Datenverarbeitungswerkzeug als **hochperformant**, wenn es zwei Kriterien erfüllt: Es kann Datenmengen verarbeiten, die den verfügbaren Arbeitsspeicher überschreiten, und ermöglicht dabei eine flexible und effiziente Nutzung der Ressourcen."

**Begründung:** Klarere Struktur durch explizite Nennung der zwei Kriterien.

---

### [REF-19] sections/04-methoden.qmd, Zeile 11
**Aktuell:** "Base R ist heutzutage jedoch weder in Benutzerfreundlichkeit, noch in Performanz zeitgemäß."

**Vorschlag:** "Base R ist heutzutage jedoch weder in Benutzerfreundlichkeit noch in Performanz zeitgemäß."

**Begründung:** Kein Komma vor "noch" in der Konstruktion "weder ... noch".

---

### [REF-20] sections/04-methoden.qmd, Zeile 13
**Aktuell:** "Ein ausgereiftes R-Paket, das Datenverarbeitung deutlich schneller macht als Standard-R-Funktionen."

**Vorschlag:** "Ein ausgereiftes R-Paket, das die Datenverarbeitung deutlich schneller macht als Standard-R-Funktionen."

**Begründung:** Artikel "die" vor "Datenverarbeitung" fehlt.

---

### [REF-21] sections/04-methoden.qmd, Zeile 93
**Aktuell:** "Beim Einlesen von Daten ist die Auswahl der benötigten Variablen in der Einlesefunktion ist wesentliche Best-Practices"

**Vorschlag:** "Beim Einlesen von Daten ist die Auswahl der benötigten Variablen in der Einlesefunktion eine wesentliche Best Practice"

**Begründung:**
- Doppeltes "ist" entfernen
- "Best-Practices" → "Best Practice" (Singular)
- "wesentliche" → "eine wesentliche"

---

### [REF-22] sections/04-methoden.qmd, Zeile 93-94
**Aktuell:** "Das Einlesen zunächst aller Daten (ggf. mit Variablenselektion zu einem späteren Zeitpunkt) verursacht unnötige Wartezeiten, Ressourcenbelegung und kann zu Abbrüchen führen."

**Vorschlag:** "Das Einlesen zunächst aller Daten (ggf. mit Variablenselektion zu einem späteren Zeitpunkt) verursacht unnötige Wartezeiten und Ressourcenbelegung und kann zu Abbrüchen führen."

**Begründung:** Komma vor "und kann" entfernen (nur zwei Hauptteile verbunden).

---

### [REF-23] sections/04-methoden.qmd, Zeile 94
**Aktuell:** "Auch Stata profitiert Beschleuniging von 39.9% in R und 33.9% in @gomolka2021largedata."

**Vorschlag:** "Auch Stata profitiert von einer Beschleunigung um 39,9% in R und 33,9% laut @gomolka2021largedata."

**Begründung:**
- "profitiert Beschleuniging" → "profitiert von einer Beschleunigung"
- "von ... % in R" → "um ... % in R" (prozentuale Steigerung)
- Komma statt Punkt bei Dezimalzahlen (deutsch)
- "in @gomolka..." → "laut @gomolka..." (präziser)

---

### [REF-24] sections/04-methoden.qmd, Zeile 95
**Aktuell:** "Datenaufteilung**: Wenn der Arbeitsspeicher nicht ausreicht, um die benötigten Daten einzulesen, bietet eine Aufteilung auf mehrere RAM-Gerechte Datenpakete helfen."

**Vorschlag:** "Datenaufteilung**: Wenn der Arbeitsspeicher nicht ausreicht, um die benötigten Daten einzulesen, kann eine Aufteilung auf mehrere RAM-gerechte Datenpakete helfen."

**Begründung:**
- "bietet ... helfen" → "kann ... helfen" (grammatikalisch korrekt)
- "RAM-Gerechte" → "RAM-gerechte" (Kleinschreibung bei zusammengesetzten Adjektiven)

---

### [REF-25] sections/04-methoden.qmd, Zeile 95
**Aktuell:** "Für klassische Methoden kombiniert mit der mehrfachen Variablenselektion. Die folgenden hoch-performanten Techniken, kommen auch direkt mehreren Dateien nutzen, ohne manuell die Datensätze zusammenzuführen."

**Vorschlag:** "Für klassische Methoden wird dies mit mehrfacher Variablenselektion kombiniert. Die folgenden hochperformanten Techniken können auch direkt mehrere Dateien nutzen, ohne dass die Datensätze manuell zusammengeführt werden müssen."

**Begründung:**
- Erster Satz unvollständig → vervollständigen
- "hoch-performanten" → "hochperformanten" (zusammen)
- Grammatik des zweiten Satzes korrigieren

---

### [REF-26] sections/04-methoden.qmd, Zeile 95-96
**Aktuell:** "Ohne das Nutzende ihren Code verändern müssen, speichert die Lazy-Computation geplante Datenverarbeitungsschritte im Hintergrund, ohne sie sofort auszufüren."

**Vorschlag:** "Ohne dass Nutzende ihren Code verändern müssen, speichert die Lazy-Computation geplante Datenverarbeitungsschritte im Hintergrund, ohne sie sofort auszuführen."

**Begründung:**
- "das" → "dass" (Konjunktion)
- "auszufüren" → "auszuführen" (Tippfehler)

---

### [REF-27] sections/04-methoden.qmd, Zeile 97
**Aktuell:** "(@gomolka2021largedata) zeigte im FDZ-Kontext massive Geschwindigkeitsgewinne anhand Parquet, sodass im FDSZ bereits standardmäßig Parquet-Dateien angeboten werden."

**Vorschlag:** "@gomolka2021largedata zeigten im FDZ-Kontext massive Geschwindigkeitsgewinne mit Parquet, sodass im FDZ bereits standardmäßig Parquet-Dateien angeboten werden."

**Begründung:**
- Klammer um Citation nicht nötig
- "anhand Parquet" → "mit Parquet" (präziser)
- "FDSZ" → "FDZ" (Tippfehler/Konsistenz?)
- "zeigte" → "zeigten" (falls mehrere Autoren)

---

### [REF-28] sections/04-methoden.qmd, Zeile 99
**Aktuell:** "Für hohe performante Verarbeitung von Datenmengen überhalb des RAMs betrachten wir die folgenden Werkzeuge"

**Vorschlag:** "Für die hochperformante Verarbeitung von Datenmengen oberhalb des RAMs betrachten wir die folgenden Werkzeuge"

**Begründung:**
- "hohe performante" → "hochperformante" (ein Wort)
- Artikel "die" vor "hochperformante"
- "überhalb" → "oberhalb" (korrekte Präposition)

---

### [REF-29] sections/04-methoden.qmd, Zeile 116
**Aktuell:** "Ein systematischer Performanzvergleich wird im FDZ-OnSite-Server für die Anwendungsfälle aus @sec-btp im folgenden @sec-benchmark durchgeführt."

**Vorschlag:** "Ein systematischer Performanzvergleich wird auf dem FDZ-OnSite-Server für die Anwendungsfälle aus @sec-btp in @sec-benchmark durchgeführt."

**Begründung:**
- "im" → "auf dem" (Server ist Gerät, nicht Raum)
- "im folgenden" → "in" (kürzer, klarer)

---

### [REF-30] sections/05-benchmark.qmd, Zeile 16
**Aktuell:** "Um zwischen den in Abschnitt @sec-methoden vorgestellten Datenverarbeitungsmethoden abzuwägen, haben wir deren Performanz in einem systematischen Vergleich der Performance auf dem SAS-Server des Statistischen Bundesamtes und den neuen OnSite R- und Stata-Servern des FDZ gemessen."

**Vorschlag:** "Um zwischen den in @sec-methoden vorgestellten Datenverarbeitungsmethoden abzuwägen, haben wir deren Performanz in einem systematischen Vergleich auf dem SAS-Server des Statistischen Bundesamtes und den neuen OnSite-R- und Stata-Servern des FDZ gemessen."

**Begründung:**
- "Abschnitt" entfernen (bereits durch @ gekennzeichnet)
- "Vergleich der Performance" → "Vergleich" (Redundanz)
- "OnSite R-" → "OnSite-R-" (Bindestrich)

---

### [REF-31] sections/05-benchmark.qmd, Zeile 20
**Aktuell:** "Für die Untersuchung wurden simulierte Einzeldaten in verschiedenen Größen (0,1%/1%/10% der insgesamt 67 Millionen Beobachtungen des BTP) betrachtet."

**Vorschlag:** "Für die Untersuchung wurden simulierte Einzeldaten in verschiedenen Größen (0,1 %/1 %/10 % der insgesamt 67 Millionen Beobachtungen des BTP) betrachtet."

**Begründung:** Leerzeichen vor Prozentzeichen (deutsche Typografie).

---

### [REF-32] sections/05-benchmark.qmd, Zeile 27
**Aktuell:** "Daneben ist beanspruchte **Arbeitsspeicher** der Auswertung entscheidend"

**Vorschlag:** "Daneben ist der beanspruchte **Arbeitsspeicher** der Auswertung entscheidend"

**Begründung:** Artikel "der" fehlt.

---

### [REF-33] sections/05-benchmark.qmd, Zeile 27
**Aktuell:** "Dennoch verzichten wir auf den Bericht systematischer RAM-Messungen, da der RAM verbrauch nicht realistisch von R gemessen werden kann. due high perf Package lagern RAM auf Rust und C++ aus, was in R nicht realistisch gemessen werden kann."

**Vorschlag:** "Dennoch verzichten wir auf den Bericht systematischer RAM-Messungen, da der RAM-Verbrauch nicht realistisch von R gemessen werden kann. Hochperformante Pakete lagern RAM-Operationen auf Rust und C++ aus, was in R nicht realistisch gemessen werden kann."

**Begründung:**
- "RAM verbrauch" → "RAM-Verbrauch" (mit Bindestrich)
- "due high perf Package" → auf Deutsch umformulieren
- Satz präziser formulieren

---

### [REF-34] sections/05-benchmark.qmd, Zeile 34
**Aktuell:** "Um die nachfolgenden Ergebnisse einzuordnen, haben wir die Performanzmessungen auch in für 1% des simulierten BTP-Daten (etwa. 800.000 Beobachtungen) in SAS und Stata durchgeführt."

**Vorschlag:** "Um die nachfolgenden Ergebnisse einzuordnen, haben wir die Performanzmessungen auch für 1 % der simulierten BTP-Daten (etwa 800.000 Beobachtungen) in SAS und Stata durchgeführt."

**Begründung:**
- "auch in für" → "auch für"
- "BTP-Daten" → "der ... BTP-Daten" (Genitiv)
- "etwa." → "etwa" (Punkt entfernen)
- Leerzeichen vor %

---

### [REF-35] sections/05-benchmark.qmd, Zeile 70
**Aktuell:** "Die Ergebnisse in @tbl-baseline zeigen, dass der umfangreiche Arbeitsspeicher des FDZ OnSite-Servers nicht ausreicht, um das BTP vollständig in Stata einzulesen, sodass zwingend mit Variablenselektion gearbeitet werden muss."

**Vorschlag:** "Die Ergebnisse in @tbl-baseline zeigen, dass der umfangreiche Arbeitsspeicher des FDZ-OnSite-Servers nicht ausreicht, um das BTP vollständig in Stata einzulesen, sodass zwingend mit Variablenselektion gearbeitet werden muss."

**Begründung:** "FDZ OnSite-Servers" → "FDZ-OnSite-Servers" (mit Bindestrich).

---

### [REF-36] sections/05-benchmark.qmd, Zeile 76
**Aktuell:** "Für 1% der simulierten BTP Daten, reduzieren die R-Datenverarbeitungsmethode alle Zielgrößen gegenüber SAS und Stata erheblich"

**Vorschlag:** "Für 1 % der simulierten BTP-Daten reduzieren die R-Datenverarbeitungsmethoden alle Zielgrößen gegenüber SAS und Stata erheblich"

**Begründung:**
- Leerzeichen vor %
- "BTP Daten" → "BTP-Daten" (mit Bindestrich)
- Komma nach Einleitung entfernen
- "R-Datenverarbeitungsmethode" → Plural "...methoden"

---

### [REF-37] sections/05-benchmark.qmd, Zeile 76
**Aktuell:** "{polars}, {duckdb} und {arrow} lösen die betrachteten Auswertungen sogar"

**Vorschlag:** "Die Pakete polars, duckdb und arrow lösen die betrachteten Auswertungen sogar"

**Begründung:** Konsistentere Schreibweise ohne geschweifte Klammern im Fließtext.

---

### [REF-38] sections/05-benchmark.qmd, Zeile 88
**Aktuell:** "Unter den klassischen R-Methoden bietet {data.table} die beste Performanz."

**Vorschlag:** "Unter den klassischen R-Methoden bietet data.table die beste Performanz."

**Begründung:** Geschweifte Klammern im Fließtext entfernen (oder konsistent beibehalten).

---

### [REF-39] sections/05-benchmark.qmd, Zeile 90
**Aktuell:** "Alle hoch-performanten Methoden sind dermaßen effizient, dass die Datenmenge von 800.000 Beobachtungen nicht mehr ausreicht, um zwischen den besten Methoden zu differenzieren."

**Vorschlag:** "Alle hochperformanten Methoden sind dermaßen effizient, dass die Datenmenge von 800.000 Beobachtungen nicht mehr ausreicht, um zwischen den besten Methoden zu differenzieren."

**Begründung:** "hoch-performanten" → "hochperformanten" (ein Wort).

---

### [REF-40] sections/05-benchmark.qmd, Zeile 231
**Aktuell:** "Auch für 10 % der simulierten BTP-Daten, kann R die beiden betrachteten Auswertungen in Echtzeit mit minimalem Arbeitsspeicher beantworten"

**Vorschlag:** "Auch für 10 % der simulierten BTP-Daten kann R die beiden betrachteten Auswertungen in Echtzeit mit minimalem Arbeitsspeicher beantworten"

**Begründung:** Komma nach Einleitung entfernen.

---

### [REF-41] sections/05-benchmark.qmd, Zeile 239
**Aktuell:** "Unerwarteterweise ist die Laufzeit von {polars} für diese Datenmenge mit 1,2 Minuten weit abgeschlagen, obwohl das gleiche Auswertungsskript für kleinere Datenmengen immer die geringste Laufzeit aufwies."

**Vorschlag:** "Unerwarteterweise ist die Laufzeit von polars für diese Datenmenge mit 1,2 Minuten weit abgeschlagen, obwohl dasselbe Auswertungsskript für kleinere Datenmengen immer die geringste Laufzeit aufwies."

**Begründung:**
- Geschweifte Klammern entfernen
- "das gleiche" → "dasselbe" (identisch, nicht ähnlich)

---

### [REF-42] sections/05-benchmark.qmd, Zeile 243
**Aktuell:** "Falls in {data.table} unbedacht der vollständige Datensatz eingelesen wird, werden in unserem Anwemdungsfall die verfügbaren 512 GB Arbeitsspeicher vollständig beansprucht."

**Vorschlag:** "Falls in data.table unbedacht der vollständige Datensatz eingelesen wird, werden in unserem Anwendungsfall die verfügbaren 512 GB Arbeitsspeicher vollständig beansprucht."

**Begründung:**
- Geschweifte Klammern entfernen
- "Anwemdungsfall" → "Anwendungsfall" (Tippfehler bereits korrigiert)

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
"tba" (to be announced) erscheint in der Tabelle bei "Kerntakt". Sollte ergänzt werden.

### [FRAGE-03] sections/07-ausblick.qmd, Zeile 24
Editorial-Kommentar "(Vorsichtig!? Annette, lieber weg oder rein?)" muss entfernt werden.

### [FRAGE-04] sections/07-ausblick.qmd, Zeile 17
Editorial-Kommentar "(besserer Ausdruck?)" muss entfernt werden.

### [FRAGE-05] sections/05-benchmark.qmd, mehrere Stellen
Editorial-Kommentare mit "tba" müssen ergänzt oder entfernt werden.

### [FRAGE-06] Allgemein
Soll die Schreibweise "FDZ-OnSite-Server" oder "FDZ OnSite-Server" verwendet werden? Aktuell inkonsistent.

---

## Zusammenfassung

**Anzahl behobener Tippfehler:** 15
**Anzahl Verbesserungsvorschläge:** 61
**Konsistenz-Fragen:** 4
**Stilistische Hinweise:** 3
**Offene Fragen:** 6

Die meisten Fehler sind kleinere grammatikalische Ungenauigkeiten, fehlende Artikel, falsche Kasusendungen und Tippfehler. Das Dokument ist insgesamt gut strukturiert und verständlich geschrieben.
