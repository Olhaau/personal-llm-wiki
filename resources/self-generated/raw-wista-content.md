

# wista-reffizienz

vorläufiges Inhaltsverzeichnis

## Einführung

### Problemstellung, Anlass, 

### FDZ


1.	Einführung
2.	Hintergründe und Ziel
3.	FDZ-Infrastruktur und deren Weiterentwicklung
4.	Anwendungsbeispiele
    a.	Business-Tax-Panel
    b.	DRG
5.	Ausblick



## Entwurf

## Bereitstellung  moderner Analysetools in R zur effizienten Auswertung von Forschungsdaten
Oliver Hauke, Annette Kristiansen, Veronika Chakraverty


### Zusammenfassung 
DE: Die technische Infrastruktur des Forschungsdatenzentrums des Statistischen Bundesamts wird derzeit ausgebaut, damit moderne Tools in größeren Kapazitäten für die effiziente Analyse von Forschungsdaten bereitstehen. Die Dokumentation des Systems wird Forschenden aufzeigen, wie sie mit Analysetools in R - insbesondere Apache Arrow, Parquet, Duckdb - das volle Potenzial der neuen Infrastruktur ausschöpfen können. Konkrete Anwendungsfälle im Rahmen des Netzwerks empirischer Steuerforschung verdeutlichen die Herausforderungen und geeignete Lösungen bei der Auswertung umfangreicher steuerstatistischer Daten.
ENG: 

### Autoreninformation 

Oliver Hauke ist Referent im Bereich "IT Kompetenzzentrum Auswertung und Analyse" und betreut Arbeiten für das Netzwerk empirische Steuerforschung. 

Annette Kristiansen ist Referentin in den Fachbereichen "Unternehmenssteuern" und "Umsatzsteuer" tätig und betreut Arbeiten für das Netzwerk empirische Steuerforschung. Sie beschäftigt sich insbesondere mit der Zusammenführung von Steuerstatistiken. 

Dr. Veronika Chakraverty ist Wissenschaftliche Mitarbeiterin und betreut Forschungsdaten aus dem Bereich Gesundheit im Forschungsdatenzentrum des Statistischen Bundesamtes.

### Schlüsselwörter 
Effiziente Analyse, Forschungsdaten, 

### Inhaltsverzeichnis 

1	Einführung	2
2	Anwendungsbeispiel: Business-Tax-Panel	2
3	FDZ-Infrastruktur und deren Weiterentwicklung	3
4	Effiziente Methoden zur Auswertung	3
5	Ausblick	3


 
### 1	Einführung

#### Problemstellung - warum brauchen wir die Effizienz?
#### Mehrwert für Fachbereich und FDZ-Nutzende
#### NeSt 

-> Impuls aus der Wissenschaft, dann Fachbereich - Fachbereich/Verbund im Grunde Hauptnutzende da Tools und Daten zur Verfügung stehen
Technische Möglichkeit entwickelt sich weiter usw..

Der Sachverständigenrat zur Begutachtung der gesamtwirtschaftlichen Entwicklung (2023) hat in seinem Gutachten 2023/24 auf eine technisch veraltete Infrastruktur und auf die fehlende Nutzerfreundlichkeit hingewiesen. Seitdem hat sich die die Infrastruktur in dem Forschungsdatenzentrum des Bundes verbessert. Seit Januar 2025 besteht ein Remote Access System als neuer Zugangsweg für die Wissenschaft. Im Bereich der Steuerstatistiken wird derzeit geprüft, inwiefern auch Einzeldaten aus diesem Bereich über Remote Access genutzt werden können. Als Übergang und Erleichterung für bestehende Forschungsprojekte wird in diesem
Kapitel 2  

### 2	Anwendungsbeispiel: Business-Tax-Panel

*Das Business-Tax-Panel kombiniert die Angaben aus verschiedenen Ertrags- sowie Umsatzsteuerstatistiken im Quer-  und Längsschnitt. Verfügbar sind Informationen aus den folgenden Statistiken : Gewerbesteuer, Körperschaftsteuer, Umsatzsteuer-Voranmeldung und -Veranlagung, Statistik über die Personengesellschaften und Gemeinschaften, Einnahmenüberschussrechnung und einige Merkmale aus dem Statistischen Unternehmensregister. Alle verwendeten Steuerarte sind ab dem Berichtsjahr 2013 jährlich verfügbar, dies bildet den Beginn des Beobachtungszeitraums. Aufgrund der Festsetzungsfrist von vier Jahren bei den Veranlagungsstatistiken endet der Beobachtungszeitraum aktuell mit dem Berichtsjahr 2020.*    

*Bei den verwendeten Statistiken handelt es sich um Vollerhebungen, teilweise mit Erfassungsgrenze. Insgesamt liegen 77,8 Mio. Beobachtungen vor, die auf 16,7  Mio. Einheiten zurückzuführen sind. Der Merkmalsumfang variiert je nach Statistik zwischen 120 und 1.300 Merkmalen was insgesamt zu einem Merkmalsumfang von über 2.700 Merkmalen führt. Hierdurch sind Analyse von Anpassungsreaktionen sowie Verteilungsanalysen für verschiedene Beobachtungszeiträume möglich. Insgesamt deckt der Forschungsdatensatz eine Vielzahl an Analysemöglichkeiten, die für die evidenzbasierte steuerpolitische Entscheidungen nötig sind, ab.*

*Für die vielfältigen Analysewünsche der Forschenden, den Auswertungsbedarf des Fachbereiches bspw. für Sonderauswertungen und der Erstellung des Metadatenreports des Forschungsdatenzentrums ist der Forschungsdatensatz konzipiert. Für die Abdeckung aller Anforderungen ist der Datensatz möglichst wenig beschränkt worden und dadurch ressourcenintensive. Der damit einhergehende hohe Bedarf an Speicherkapazität, Arbeitsspeicher und Prozessorleistung stellt sowohl im Fachbereich als auch im Forschungsdatenzentrum eine Herausforderung dar.*

==Wodurch ...==

### 3	FDZ-Infrastruktur und deren Weiterentwicklung

- Beschreibung der Kapazitäten und Potenziale 
- Technische Details des OnSite Server 
- Infrastruktur und die Weiterentwicklung
- Zugriffswege

- Die technische Infrastruktur des Forschungsdatenzentrums des Statistischen Bundesamts wird derzeit ausgebaut, damit moderne Tools in größeren Kapazitäten für die effiziente Analyse von Forschungsdaten bereitstehen. 

### 4	Effiziente Methoden zur Auswertung

Die Dokumentation des Systems wird Forschenden aufzeigen, wie sie mit Analysetools in R - insbesondere Apache Arrow, Parquet, Duckdb - das volle Potenzial der neuen Infrastruktur ausschöpfen können... 

- Nutzung der neuen Kapazitäten
- Software die eine effiziente Umsetzung ermöglicht

### Anwendungsfälle

Konkrete Anwendungsfälle im Rahmen des Netzwerks empirischer Steuerforschung verdeutlichen die Herausforderungen und geeignete Lösungen bei der Auswertung umfangreicher steuerstatistischer Daten....

#### 4.1 Erstellung von Metadatenreport

#### 4.2 Datenaufbereitung im Fachbereich

#### 4.3 Forschungsprojekte

- Aufbereitungen
  - Umkodierung in WZ
  - 
- Analysen
  - Häufigkeits
  - Verteilungsanalysen, insb. Lorenz-Kurve 
    - in wenigen Sekunden, ein paar Zeilen Code, wenig RAM
  - Schätzmodelle, insb. Regression, insb. logistische Regression

### 5	Ausblick

*Perspektivisch soll das BTP jährlich aktualisiert werden und um Angaben aus der Lohn- und Einkommensteuererklärung der Einzelunternehmer und Beteiligten erweitert werden.  Dadurch erhöht sich die Zahl der Beobachtungen regelmäßig und auch der Merkmalskranz wird erweitert. Die effiziente Datenhaltung und Auswertung für den Fachbereich, dem Forschungsdatenzentrum und die FDZ-Nutzenden stellt ein geeignetes Vorgehen dar um diesen ressourcenintensiven und wachsenden Datensatz möglichst ressourcenschonend auszuwerten.*

*Für die FDZ-Nutzenden wird angestrebt in Zukunft eine Mustersyntax bereitzustellen. Die erstmalige Erstellung einer Mustersyntax soll in enger Kooperation mit der Wissenschaft erfolgen. Dafür wird auf die Strukturen des NeSt zurückgegriffen um die Mustersyntax an dem Bedarf der empirischen Steuerforschung zu entwickeln.*   
 
### Literaturverzeichnis

1. GIT-Link für Code
2. https://arrow.apache.org/docs/r/index.html
3. https://blog.djnavarro.net/posts/2022-05-25_arrays-and-tables-in-arrow/
4. https://duckdb.org/docs/stable/clients/r.html
5. https://arrow.apache.org/cookbook/r/index.html
6. Brenzel, Hanna/Zwick, Markus (2022): Eine informationelle Infrastruktur in Deutschland ist erwachsen - Das Forschungsdatenzentrum des Statistischen Bundesamtes. Wirtschaft und Statistik, Ausgabe 6/2022, S. 54-64. Online verfügbar unter: https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/2022/06/informationelle-infrastruktur-deutschland-062022.pdf?__blob=publicationFile&v=4 [zuletzt abgerufen am 02.07.2025].
7. Kristiansen, Annette (2023): Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken, Wirtschaft und Statistik, Ausgabe 3/2023, S. 47-60. Online verfügbar unter:  https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/2023/04/business-tax-panel-042023.pdf?__blob=publicationFile&v=3 [zuletzt abgerufen am 02.07.2025].
8. Kristiansen, Annette/Wittmaack, Moritz/Fauser, Hannes/Haghighi, Nahid/Hauke, Oliver (2025a): Amtliche Steuerstatistikdaten für die Forschung: Stand und Ausblick des Datenangebots. Steuern und Wirtschaft 102 (Sonderheft 2025), S. 10-20. Online verfügbar unter: https://steuerrecht.uni-koeln.de/sites/steuerrecht/StuW/Jahrgaenge/StuW_2025_-_Sonderheft_NeSt.pdf [zuletzt abgerufen am 02.07.2025].
9. Kristiansen, Annette/Klotz-Latus, Aline/Oschmann, Kirsten/Wittmaack, Moritz/ Egloff, Jasmin (2025b): Neue Daten und Zusammenführungsmöglichkeiten: Änderungen am Steuerstatistikgesetz durch das Jahressteuergesetz 2024, Steuern und Wirtschaft 102 (Sonderheft 2025), S. 21-25. Online verfügbar unter: https://steuerrecht.uni-koeln.de/sites/steuerrecht/StuW/Jahrgaenge/StuW_2025_-_Sonderheft_NeSt.pdf [zuletzt abgerufen am 02.07.2025].
10. Sachverständigenrat zur Begutachtung der gesamtwirtschaftlichen Entwicklung (2023): Wachstumsschwäche überwinden - In die Zukunft investieren. Jahresgutachten 2023/24. S. 389-415.
11. Wissenschaftlicher Beirat beim Bundesministerium der Finanzen (2020): Notwendigkeit, Potential und Ansatzpunkte einer Verbesserung der Dateninfrastruktur für die Steuerpolitik. Gutachten 5/2020. Online verfügbar unter: https://www.bundesfinanzministerium.de/Content/DE/Downloads/Ministerium/Wissenschaftlicher-Beirat/Gutachten/2020-10-30-gutachten-dateninfrastruktur-steuerpolitik.html [zuletzt abgerufen am 02.07.2025].

______________________________________

Oliver Hauke
IT-Kompetenzzentrum Auswertung und Analyse
Statistisches Bundesamt (Destatis)


