---
title: "DUVA Auswertungsassistent Anwenderhandbuch (PDF)"
token: "45662"
source_link: "inbox/duva-auswertungsassistent-anwenderhandbuch.pdf"
topic: "unclassified"
tags: ["source/file", "privacy/public", "ingest", "pdf", "duva"]
generated_at: "2026-05-19T07:09:11Z"
source: "file"
---

## Page 1

DUVA-Auswertungsassistent 
Anwendungshandbuch 
 
 
 
 
 
 
 
 
 
KOSIS-Gemeinschaft DUVA 
https://www.duva.de

## Page 2

Auswertungsassistent - Anwendungshandbuch 
II 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
DUVA-Auswertungsassistent - Anwendungshandbuch 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
für DUVA-Auswertungsassistent Version 4.16.2 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
Veröffentlicht 2022 
Copyright © 2006 - 2022 KOSIS-Gemeinschaft DUVA

## Page 3

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
III 
Auswertungsassistent 
Anwendungshandbuch 
Inhalt 
1. Vorwort ..........................................................................................................................................1 
2. Programmaufruf .............................................................................................................................3 
3. Aufbau der Seiten des DUVA-Auswertungsassistenten ....................................................................4 
4. Dateiauswahl ..................................................................................................................................6 
5. Auswahl des Präsentationstyps .......................................................................................................8 
6. Merkmalsauswahl ......................................................................................................................... 10 
6.1 Allgemeines zum Seitenaufbau ................................................................................................ 10 
6.2 Auswahl und Anordnung von Schlüsselmerkmalen .................................................................. 13 
6.3 Auswahl von abgeleiteten Merkmalen (Gruppierungen) .......................................................... 14 
6.4 Erstellung interner Referenztabellen ....................................................................................... 15 
6.5 Auswahl von Wertemerkmalen ............................................................................................... 17 
6.6 Berechnung von neuen Wertemerkmalen ............................................................................... 18 
7. Filtermöglichkeiten ....................................................................................................................... 20 
7.1 Statische Filter......................................................................................................................... 20 
7.1.1 Setzen von Filtern durch Markierung von Merkmalsausprägungen ................................... 20 
7.1.2 Präsentationsausgabe....................................................................................................... 22 
7.1.3 Definieren von Filtern mit Hilfe des Filtereditors ............................................................... 23 
7.1.4 Berücksichtigung von leeren Merkmalen und Leerzeichen ................................................ 27 
7.2 Dynamische Filter .................................................................................................................... 28 
7.2.1 Hierarchische Filter ........................................................................................................... 29 
7.3 Gleichzeitige Nutzung von Merkmalen zur statischen und dynamischen Filterung ................... 29 
7.4 Ausblenden von Spalten, Zeilen und Seitenmerkmal ............................................................... 30 
7.5 Filter auf Minimal- oder Maximalwert setzen .......................................................................... 30 
8. Seitenmerkmale ............................................................................................................................ 33 
9. Konfigurationsmöglichkeiten......................................................................................................... 35 
9.1 Optionen ................................................................................................................................. 35 
9.1.1 Editieren von Ausgabetexten ............................................................................................ 36 
9.1.2 Verwendung von HTML-Code in Ausgabetexten ............................................................... 41 
9.1.3 Zusatzinformationen ........................................................................................................ 42 
9.2 Editieren von Merkmals- und Ausprägungsbezeichnungen ...................................................... 45 
9.3 Speichern und Wiederaufrufen von Optionseinstellungen ....................................................... 46 
10. Präsentationstypen ..................................................................................................................... 48 
10.1 Kreuztabelle .......................................................................................................................... 49

## Page 4

Auswertungsassistent - Anwendungshandbuch 
IV 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
10.1.1 Besonderheiten bei der Merkmalsauswahl und –positionierung ..................................... 49 
10.1.2 Konfigurationsmöglichkeiten für den Präsentationstyp Kreuztabelle ............................... 54 
10.1.3 Merkmalsspezifische Gesamtsummen- und Zwischensummenanzeige ........................... 63 
10.2 Interaktive Tabelle................................................................................................................. 65 
10.2.1 Detailauswahl ................................................................................................................. 66 
10.2.2 Konfigurationsmöglichkeiten für den Präsentationstyp Interaktive Tabelle ..................... 68 
10.2.3 Auswertungen ................................................................................................................ 74 
10.3 Liste ...................................................................................................................................... 77 
10.3.1 Besonderheiten des Präsentationstyps Liste ................................................................... 77 
10.3.2 Konfigurationsmöglichkeiten für den Präsentationstyp Liste ........................................... 78 
10.4 CSV-Export ............................................................................................................................ 80 
10.5 Grafiken ................................................................................................................................ 84 
10.5.1 Standarddiagramme (Balken, Säulen, Linien, Flächen) .................................................... 84 
10.5.2 Tortendiagramm ............................................................................................................. 87 
10.5.3 Pyramidengrafik ............................................................................................................. 89 
10.5.4 Spinnennetzdiagramm .................................................................................................... 92 
10.5.5 Punktdiagramm .............................................................................................................. 95 
10.5.6 Konfigurationsmöglichkeiten der verschiedenen Grafiken .............................................. 99 
10.5.7 Möglichkeiten des Grafik-Exports ................................................................................. 109 
10.6 Thematische Karte .............................................................................................................. 111 
11. Verketten und Verschneiden von Dateien ................................................................................. 114 
11.1 Verketten von Dateien mit identischem Satzaufbau ............................................................ 114 
11.2 Verschneiden von Dateien ................................................................................................... 116 
11.3 Erweitertes Verketten von Dateien mit nicht-identischen Satzaufbauten............................. 118 
12. Speichern und Veröffentlichen von Auswertungen .................................................................... 120 
12.1 Allgemeine Einstellungen zur Speicherung und Veröffentlichung von Auswertungen ........... 120 
12.2 Erstellen eines Links für gespeicherte Auswertungen........................................................... 124 
13. Parametrisierung ...................................................................................................................... 126 
13.1 Was sind Parameter? .......................................................................................................... 126 
13.2 Die Erzeugung parametrisierter Auswertungen ................................................................... 127 
13.3 Die Kombination von Parametern ........................................................................................ 129 
13.4 Besonderheiten bei der Parametrisierung ........................................................................... 132 
 
 
 
Impressum

## Page 5

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
V 
 
 
Konzeption des Moduls: 
DUVA-Lenkungsgruppe 
Entwicklung: 
Ralf Bremecke 
 
 
 
 
 
 
Geschäftsstelle der KOSIS-Gemeinschaft DUVA 
c/o Amt für Bürgerservice und Informationsmanagement Freiburg 
Postfach 
79095 Freiburg 
 
Hausanschrift: 
Berliner Allee 1 
79114 Freiburg 
Tel: 0761 / 201-5764 
Internet: https://www.duva.de 
Mail: 
duva@stadt.freiburg.de

## Page 6

Auswertungsassistent - Anwendungshandbuch 
VI 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Ansprechpartner 
DUVA wird als Gemeinschaftsprojekt des KOSIS-Verbundes entwickelt.  
Dabei bestimmt die DUVA-Lenkungsgruppe unter Federführung der Stadt Freiburg im Breisgau den 
inhaltlichen und organisatorischen Aufbau. 
 
Vorsitzender der DUVA-Lenkungsgruppe: 
Claude Gils 
c/o Amt für Bürgerservice und Informationsmanagement Freiburg 
Postfach 
79106 Freiburg 
Tel.: 0761 / 201 -5759 
Mail: claude.gils@duva.de 
 
Autoren des Handbuches: 
Andreas Martin, Thomas Thauer, Holger Schreck, Ralf Then, Nicolas Haidt, Sven Großhans 
 
Bei Fragen oder Problemen wenden Sie sich bitte an die DUVA-Helpline oder an das DUVA-Forum 
(erreichbar über https://www.duva.de). 
DUVA-Helpline: 
Mail: support@duva.de

## Page 7

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
1 
1. Vorwort 
Der DUVA-Auswertungsassistent dient der Auswertung und Präsentation von Informationen, die im 
DUVA-Nachweissystem beschrieben und in einer DUVA-Sachdatenbank gespeichert vorliegen. Mit 
dem DUVA-Auswertungsassistenten können die Anwenderinnen und Anwender selbständig 
Auswertungen in Form von Tabellen, Listen, Grafiken und thematischen Karten erstellen. Da der 
Metadatenansatz konsequent bei allen DUVA-Modulen umgesetzt wurde, sind keine Datenbank- oder 
Programmierkenntnisse erforderlich. Durch den direkten Zugriff auf die Meta- und Sachdatenbanken 
des DUVA-Systems stehen den Anwenderinnen und Anwendern immer aktuelle und verlässliche 
Informationen zur Verfügung, ohne dass es eines gesonderten Aufbereitungsprozesses bedarf. 
Als Besonderheit bietet der DUVA-Auswertungsassistent die Möglichkeit, vordefinierte Auswertungen 
mit aktuellen Daten aufzurufen. Dabei wird eine getroffene Merkmalsauswahl einschließlich aller 
Auswertungsparameter in der Datenbank gespeichert. Erfolgt deren Aufruf, wird die festgelegte 
Tabelle, Grafik oder Karte vom Auswertungsassistenten anhand der gespeicherten Parameter aus dem 
aktuellen Datenbestand des DUVA-Systems jeweils neu generiert und ausgegeben. Der Aufruf solch 
vordefinierter Auswertungen kann entweder als URL oder über das DUVA-Informationsportal erfolgen. 
Durch die gespeicherten Auswertungsparameter kann ein Informationsangebot geschaffen werden, 
ohne dass fertige Grafiken oder Tabellen auf Vorrat produziert und ständig aktualisiert werden 
müssen. 
Der Auswertungsassistent ist als ISAPI-Anwendung programmiert. Er ist unter den Webservern 
Internet Information Server (IIS) und Apache einsatzfähig. Es genügt ein aktueller Internet-Browser mit 
Javascript-Unterstützung. 
Das Layout der Anwendung und der erzeugten Tabellen und Grafiken kann, soweit entsprechende CSS-
Kenntnisse vorhanden sind, über CSS-Klassen an individuelle Vorgaben angepasst werden. Diese und 
weitere Systemkonfigurationen sind den Systemadministratorinnen und -administratoren vorbehalten 
und 
werden 
im 
Installationshandbuch 
beschrieben. 
Die 
Benutzeradministration 
des 
Auswertungsassistenten erfolgt zentral über die Benutzer- und Rechteverwaltung des DUVA-Systems.  
Neben Tabellen und Grafiken haben sich thematische Karten als Mittel zur Informationsdarstellung 
etabliert. DUVA verfügt über eine eigenständige webbasierte Anwendung zur Kartenerstellung, die in 
den Auswertungsassistenten integriert ist. Zu dem DUVA-Kartentool existieren eigene Beschreibungen 
und Bedienungsanleitungen. Daher wird die Kartenproduktion in dieser Auflage des Handbuchs nur 
einleitend beschrieben und anhand einfacher Beispiele erläutert (vgl. Kapitel 10.6 Thematische Karte). 
Für einen weitergehenden Einstieg in diese Materie wird die Lektüre der Handbücher zum Kartentool 
empfohlen.  
 
 
Abbildung 
1: 
Unter 
der 
URL 
https://duvademo.de/asw/asw.dll/login 
können Sie den DUVA-Auswertungsassistenten 
aufrufen, 
um 
die 
Beispiele 
aus 
dem 
vorliegenden Handbuch nachzuvollziehen.

## Page 8

Auswertungsassistent - Anwendungshandbuch 
2 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Hinweis:  
Um die Beschreibungen und Beispiele dieses Handbuches besser nachvollziehen zu können, bieten wir 
Ihnen auf dem DUVA-Server einen Zugang zum DUVA-Auswertungsassistenten, der auf eine Demo-
Datenbank zugreift und Ihnen die Auswertung von Testdaten ermöglicht. Unter der URL 
https://duvademo.de/asw/asw.dll/login können Sie den Assistenten aufrufen. Die Anmeldung erfolgt 
mit der Benutzerkennung duva und dem Passwort Duva-123. 
Bei der Realisierung des DUVA-Auswertungsassistenten wurde viel Wert auf eine intuitive 
Bedienbarkeit und Übersichtlichkeit gelegt. In der Dateiauswahl kann zur Suche auf alle aus dem 
DUVA-Nachweissystem bekannten Metamerkmale zugegriffen werden oder es wird eine vordefinierte 
Auswertung aufgerufen. Die Auswahl der darzustellenden Merkmale erfolgt auf einer Auswahlseite, 
die an den jeweiligen Präsentationstyp angepasst ist, und neben den erweiterten Möglichkeiten zur 
Erstellung von Standarddiagrammen können auch Torten-, Punkt- und Spinnennetzdiagramme sowie 
Pyramidengrafiken metadatenbasiert erstellt werden. 
Editorische Hinweise: 
Die meisten in diesem Anwenderhandbuch enthaltenen Screenshots aus dem DUVA-
Auswertungsassistenten entstammen einem Computer, der mit Windows 7 und Mozilla Firefox (Version 
67) als Internet-Browser ausgestattet ist. Es gibt Abweichungen in der Darstellung durch andere 
Browser. Diese stellen jedoch keine Einschränkungen in der Funktionalität dar. 
Bei den Screenshots wird für eine verbesserte Übersichtlichkeit oftmals lediglich der für den aktuellen 
Textabschnitt relevante Bereich wiedergegeben. Zudem wurden in den Abbildungen orangefarbene 
Ziffern eingefügt. Diese Ziffern weisen auf Textpassagen des Handbuchs hin, die durch eingeklammerte 
Ziffern gekennzeichnet sind. 
Da der DUVA-Auswertungsassistent über eine Vielzahl von Möglichkeiten zur Anpassung der 
Ausgabefenster an individuelle Wünsche verfügt, kann sich das Aussehen ausgegebener Fenster unter 
Umständen deutlich von den in diesem Handbuch eingefügten Screenshots unterscheiden. Zusätzlich 
ist zu berücksichtigen, dass je nach Konfiguration und vergebenen Rechten einzelne der hier 
beschriebenen Funktionalitäten eventuell nicht zugänglich sind. 
Im Rahmen dieses Anwenderhandbuchs wird der DUVA-Auswertungsassistent aus Sicht der 
Nutzerinnen und Nutzer beschrieben. Eine Anleitung zur Installation des Moduls, zu seiner 
Konfiguration und zu den Grundlagen der hier beschriebenen Verfahren und Möglichkeiten findet sich 
im Installationshandbuch des DUVA-Auswertungsassistenten.

## Page 9

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
3 
2. Programmaufruf 
Der DUVA-Auswertungsassistent (im Folgenden auch DUVA-ASW oder ASW) ist eine Web-Anwendung, 
die im Internet-Browser gestartet wird. Für den Aufruf und die Bedienung des Assistenten wird ein 
möglichst aktueller Internet-Browser mit Javascript-Unterstützung benötigt. Die Installation weiterer 
Software entfällt. Nach dem Aufruf der gültigen URL, die Sie von Ihrer Systemadministration mitgeteilt 
bekommen, startet der DUVA-Auswertungsassistent mit der Anmeldeseite zur Benutzeridentifikation 
und zur Auswahl der Arbeitsumgebung (Abb. 2). 
 
 
Abbildung 2: Die Anmeldemaske des DUVA Auswertungsassistenten 
Für die Anmeldung werden ein gültiger Benutzername und ein Passwort benötigt (1). Diese Angaben 
werden Ihnen ebenfalls von Ihrer örtlichen Systemadministration mitgeteilt. Unter der Auswahl 
„Nachweissystem“ (2) kann eine der freigegebenen Metadatenbanken ausgewählt werden. In der 
Demo-Version existiert allerdings nur die Auswahl zwischen „DEMO“ und „DEMODB“. Ob diese 
Auswahl angezeigt wird, kann von den Systemadministratorinnen und -administratoren eingestellt 
werden. Ist die Auswahl des Nachweissystems (oder besser die Auswahl der Datenbank, in der die 
jeweilige Metainformation gespeichert ist) ausgeblendet, kann der Nutzer lediglich auf die 
vorgegebene Datenbank zugreifen. 
Nach der Eingabe der Anmeldedaten (Benutzername und Passwort) und ggf. der Auswahl der 
gewünschten Metadatenbank wird der DUVA-ASW durch einen Klick auf die Schaltfläche „Anmelden“ 
gestartet (3). 
Hinweis: Sollte es zu mehreren erfolglosen Anmeldungsversuchen in einer kurzen Zeitspanne kommen, 
wird aus Sicherheitsgründen eine entsprechende Sicherheitsabfrage eingeblendet. Damit soll 
sichergestellt werden, dass sich keine Bots anmelden. Es wird hierbei eine Frage eingeblendet, die 
beantwortet werden muss. 
 
 
1 
2 
3

## Page 10

Auswertungsassistent - Anwendungshandbuch 
4 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
3. Aufbau der Seiten des DUVA-Auswertungsassistenten 
Alle Seiten des Auswertungsassistenten verfügen über einen Kopfbereich und einen Fußbereich. 
Dazwischen befindet sich der zentrale Seitenbereich, in dem eine Auswahl getroffen werden kann 
(Abb. 3).  Auf der Seite „Dateiauswahl“ können die Dateien ausgewählt werden, die ausgewertet und 
deren Inhalte für eine Präsentation genutzt werden sollen. Auf den Folgeseiten kann der 
Präsentationstyp (z.B. Tabelle, Grafik oder Karte) festgelegt und die auszuwertenden Merkmale 
ausgewählt werden.  
 
Abbildung 3: Grundsätzlicher Seitenaufbau des DUVA-Auswertungsassistenten 
Der Kopfbereich der Auswahlseiten enthält das DUVA-Logo (1) und den Namen der Anwendung 
(„Auswertungsassistent“) (2). Beide Elemente können bei der Installation und Einrichtung des 
Assistenten durch andere geeignete Bilder und Texte ausgetauscht werden. Damit ist eine Anpassung 
der Anwendung an das jeweilige Corporate Design (CD) der informationsanbietenden Institution 
möglich. Neben dem DUVA-Logo und dem Namen der Anwendung befinden sich im Kopfbereich 
folgende Elemente: 
• 
Die Brotkrümel-Zeile (3) zeigt an, auf welcher Ebene man sich gerade befindet. Bei jedem 
Wechsel auf eine Folgeseite erhält diese Positionsanzeige einen weiteren Eintrag 
(Brotkrumen). Durch das Anklicken eines der Einträge, der in der Kette vor der aktuellen Seite 
steht, kann man zu dieser Seite der Anwendung zurückspringen. 
• 
Auf allen Seiten des Auswertungsassistenten besteht die Möglichkeit, nach dem Anklicken der 
Schaltfläche „Konto“ (4) das aktuelle Passwort zu ändern oder die Anwendung zu beenden. 
Passwörter müssen der vorgegebenen Passwortrichtlinie entsprechen. Wenden Sie sich ggfs. 
an Ihren Administrator. 
• 
Nur wenn bei der Installation und Einrichtung des Systems Sprachdateien angelegt wurden, 
dann verfügen alle Seiten des Auswertungsassistenten über eine Sprachauswahl. In diesem 
Fall können Sie über die Schaltfläche „Deutsch“ unter den verfügbaren Sprachen auswählen. 
Der Kopfbereich hebt sich durch die weiße Hintergrundfarbe farblich von dem zentralen in hellgrau 
hinterlegten Auswahlbereich der Seite ab. Über die kleine, mit einem „X“ gekennzeichnete Schaltfläche 
1 
2 
3 
4 
5 
6 
Kopfbereich 
Auswahlbereich 
Fußbereich

## Page 11

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
5 
(5) an seinem unteren Rand kann der gesamte Kopfbereich ausgeblendet werden. Dadurch wird mehr 
Platz für die Auswahlseiten auf dem Bildschirm gewonnen und somit eine verbesserte Übersicht. Nach 
dem Ausblenden des Seitenkopfes bleibt eine Schaltfläche mit „…“ am oberen Bildschirmrand sichtbar. 
Durch Anklicken dieser Schaltfläche wird der Seitenkopf wieder eingeblendet. 
Im Fußbereich der Seite stehen weitere Schaltflächen zur Navigation durch die Anwendung und zum 
Aufruf weiterer Funktionen zur Verfügung (6). In diesem dunkel unterlegten Bereich erscheinen je nach 
Seite kontextabhängige Schaltflächen: z.B. zum Wechseln auf die nächste Seite („Weiter“), zum Starten 
der Auswertung und Erstellen der Präsentation („Starten“), zum Aufruf der Einstellungen („Optionen“) 
oder zum Ändern des Präsentationstyps („Typ ändern“).  
Hinweis: Der DUVA-Auswertungsassistent arbeitet im Rahmen der Darstellungsmöglichkeiten von 
Browserfenstern. Um von der aktuellen Seite des Auswertungsassistenten zur jeweils vorangegangenen 
Seite zu gelangen, könnte deshalb die Schaltfläche „Zurück“ des Browserfensters angeklickt werden. 
Dieses Vorgehen führt jedoch zu dem Verlust der getätigten Einstellungen, wie etwa veränderte 
Optionen. Um ohne Verlust von Änderungen zu einer vorausgegangenen Seite zurückzukehren, können 
Sie auf den entsprechenden Eintrag in der Brotkrümel-Zeile oder auf die Schaltfläche im linken 
Fußbereich klicken. Die Schaltfläche im Fußbereich trägt jeweils die Bezeichnung der 
vorausgegangenen Auswahlseite (z.B. < Präsentationstyp). In beiden Fällen gehen eine bereits 
vorgenommene Auswahl und Einstellungen verloren.

## Page 12

Auswertungsassistent - Anwendungshandbuch 
6 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
4. Dateiauswahl 
Über die Reiter „Dateien“ und „Auswertungen“ (1) kann zwischen der Dateiauswahl und der Auswahl 
einer gespeicherten Auswertungsspezifikation gewechselt werden (Abb. 4). Das Speichern von 
Auswertungen und deren Wiederaufruf wird in Kapitel 12. Speichern und Veröffentlichen von 
Auswertungen beschrieben. 
 
 
Abbildung 4: Die Dateiauswahl 
Unter dem Reiter „Dateien“ werden die im DUVA-Nachweissystem hinterlegten Dateibeschreibungen 
angeboten, auf die der jeweils angemeldete Benutzer zugreifen darf. Die Dateiauswahl erfolgt durch 
Anklicken einer oder mehrerer Dateien in der tabellarischen Übersicht der vorhandenen 
Dateibeschreibungen (vgl. Kapitel 11). Zusätzlich zu den Namen der auswählbaren Dateien werden 
weitere 
Dateibeschreibungsobjekte 
angezeigt: 
Sachgebiet, 
Kurzbeschreibung, 
Erhebung, 
Merkmalsträger, Raumbezug und Zeitbezug. Die Darstellung der einzelnen Spalten mit den 
Beschreibungstexten kann über die Schaltfläche „Spalten ein-/ausblenden“ gesteuert werden (2). Die 
Spaltenbreite lässt sich durch das Anklicken und Ziehen der Feldbegrenzer im Tabellenkopf optimal 
einstellen (3). Die Inhalte der Spalten können mithilfe des Sortiermarkers (4) alphabetisch auf- oder 
abwärts sortiert werden. Hierfür genügt es, hinter der Objektbezeichnung (z.B. Name, Sachgebiet, 
Kurzbeschreibung, Erhebung, …) im Kopf der Auswahltabelle zu klicken (4). 
Hinweis: Einstellungsmöglichkeiten wie etwa Spaltenbreite und Sortierung bleiben nur zur Laufzeit der 
aktuellen Abfrage bestehen und müssen bei Bedarf bei jedem Aufruf der Auswahlseite neu eingestellt 
werden. 
Das Auffinden und die Auswahl der gewünschten Dateien können durch das Setzen von Filtern über 
sämtliche Beschreibungsobjekte erleichtert werden. Dazu befinden sich über der Auswahltabelle 
Pulldown-Menüs zu den einzelnen Beschreibungsobjekten, in denen die jeweils vorhandenen 
Beschreibungen angezeigt werden (5). In den Pulldown-Menüs können mehrere Filtereinträge 
ausgewählt werden. Die Auswahl erfolgt durch das Setzen eines Hakens, der ausgewählte Filtereintrag 
wird dann gelb hinterlegt. Somit können Sie die gewünschten Objekte auswählen und die Anzeige der 
verfügbaren Dateien reduzieren. Durch die Kombination von Filtern über verschiedene 
2 
3 
4 
1 
5 
6 
7 
8 
9 
10 
11

## Page 13

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
7 
Metadatenobjekte kann die Anzeige der verfügbaren Dateien weiter eingeschränkt werden. Die 
jeweiligen Filter werden durch logisches UND miteinander verknüpft. So kann z.B. durch die Auswahl 
eines Merkmalträgers (z.B. „Einwohner/innen“) und eines Zeitbezuges („31.12.2014 - 31.12.2014“) die 
Anzeige der auswählbaren Dateien auf die Dateien reduziert werden, die beide Auswahlkriterien 
erfüllen.  
Eine bereits getätigte Dateiauswahl bleibt erhalten, wenn die Filter- oder Suchkriterien geändert 
werden, auch wenn sie den aktuellen Kriterien nicht mehr entspricht. Diese Funktion erhält Relevanz 
beim Verschneiden von Dateien unterschiedlicher Sachgebiete (vgl. Kapitel 11). 
Die Suche nach geeigneten Dateien kann zudem durch eine freie Textsuche vereinfacht werden. Nach 
der Eingabe eines Suchbegriffs in das dafür vorgesehene Textfeld ((6) „Suchbegriff eingeben“) und 
einem abschließenden Mausklick auf die durch eine Lupe gekennzeichnete Schaltfläche (7) oder der 
Betätigung der ENTER-Taste, werden nur noch die Dateien angezeigt, bei denen der eingegebene 
Begriff in einem der zur Auswahl angebotenen Metadatenobjekte verwendet wurde. Die Textsuche 
lässt sich mit den über die Pulldown-Menüs gesetzten Filtern kombinieren. 
Durch das Betätigen der mit einem geschwungenen Pfeil (8) gekennzeichneten Schaltfläche am Ende 
der Zeile mit den Filter- und Suchmöglichkeiten werden die Such- und Filtervorgaben mit einem Klick 
zurückgesetzt und alle zur Verfügung stehenden Dateien wieder angezeigt. 
Durch einen Mausklick auf eine Dateibeschreibung kann die gewünschte Datei ausgewählt werden. 
Soll mehr als nur eine Datei ausgewählt werden, lassen sich nach dem Anklicken der ersten Datei 
weitere bei gehaltener Umschalt-Taste (Auswahl mehrerer direkt untereinander stehender Dateien – 
wie oftmals bei Zeitreihen) oder bei gedrückter STRG-Taste (Auswahl weiterer Dateien, die an 
beliebiger Position in der Auswahlliste erscheinen) selektieren. Bei der Auswahl von mehr als einer 
Datei ist jedoch zu beachten, dass maximal zwei Dateien mit unterschiedlicher Satzstruktur kombiniert 
werden können. Weiter müssen diese ausgewählten Dateien über mindestens ein identisches 
Merkmal verfügen. Mehr als zwei Dateien können nur dann kombiniert werden, wenn alle 
ausgewählten Dateien denselben Satzaufbau besitzen, wie dies z.B. bei Zeitreihen oft der Fall ist. Das 
Vorgehen zum Verschneiden von zwei Dateien mit unterschiedlichem Satzaufbau sowie zum Verketten 
von mehreren identisch aufgebauten Dateien wird in Kapitel 11 erläutert. 
Die ausgewählten Dateien werden mit ihren Namen im Fußbereich der Auswahltabelle aufgelistet (9). 
Innerhalb dieser Auflistung besteht nun die Möglichkeit die Reihenfolge zu ändern. Durch einen Klick 
auf die „X“- Schaltfläche (10) am Ende der jeweiligen Anzeigezeile kann eine Auswahl wieder 
rückgängig gemacht werden. Durch das Anklicken einer nicht ausgewählten Datei wird die gesamte 
Dateiauswahl aufgehoben. 
Hinweis: Wählen Sie den Reiter „Auswertungen“, so wird im unteren Bereich zusätzlich eine 
Schaltfläche namens „Informationsportal“ eingeblendet. Mithilfe dieser Funktion können 
Auswertungen mittels Dialog-Auswahl im DUVA-Informationsportal veröffentlicht werden. Näheres 
hierzu finden Sie in Kapitel 12.2 Erstellen eines Links für gespeicherte Auswertungen. 
Durch einen Klick auf die Schaltfläche „Weiter“ (11) wird die Dateiauswahl bestätigt und die Folgeseite 
zur Auswahl des Präsentationstyps aufgerufen.

## Page 14

Auswertungsassistent - Anwendungshandbuch 
8 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
5. Auswahl des Präsentationstyps 
Nach der Auswahl einer oder mehrerer Dateien, die einer Auswertung zugeführt werden sollen, folgt 
die Auswahl des Präsentationstyps (Abb. 5). Zur Auswahl stehen die textorientierten Präsentationen 
„Kreuztabelle“ (Standardtabelle), „Interaktive Tabelle“, „Liste“ (Auflistung von Einzelfällen) und „CSV-
Export“ (Export der zur ausgewählten Datei gehörenden Sachdatentabelle) sowie die grafischen 
Präsentationen „Säulen, Balken, Linien, Flächen“ (Standardgrafiken), „Tortendiagramm“, „Pyramide“, 
„Punktdiagramm“, „Spinnennetzdiagramm“ und „Karte“. 
 
 
Abbildung 5: Die Auswahl des gewünschten Präsentationstyps 
Die Seite zur Auswahl des Präsentationstyps (Abb. 6) ist ebenfalls in drei Bereiche unterteilt: Im 
Kopfbereich werden die Brotkrümel-Zeile (1) sowie die Schaltflächen für die Kontoverwaltung und ggf. 
Sprachauswahl angezeigt (2). Im zentralen Auswahlbereich werden die selektierten Dateien angezeigt 
(3) und die möglichen Präsentationstypen in Form großer Schaltflächen zur Auswahl angeboten (4). 
Durch einen Mausklick auf die Schaltfläche „Dateiauswahl“ im Fußbereich der Auswahl kann der 
Anwender zu der Seite der Dateiauswahl zurückkehren (5).  
 
Abbildung 6: Seite zur Auswahl des Präsentationstyps 
Den gewünschten Präsentationstyp kann man durch einen Mausklick auf das entsprechende Symbol 
auswählen. Mit dem Klick auf die gewünschte Schaltfläche wird die Seite zur Auswahl und Anordnung 
der Merkmale für den angewählten Präsentationstyp aufgerufen. Die mit der Dateiauswahl möglichen 
Präsentationen werden durch die farblich dunkle Unterlegung der Schaltflächen angezeigt. Für die hier 
1 
3 
4 
5 
6 
2

## Page 15

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
9 
beispielhaft ausgewählte Datei kann keine Karte erstellt werden, da die Datei kein räumliches Merkmal 
enthält, zu dem im Nachweissystem eine Geometrie angegeben wurde. Die Schaltfläche zum Start der 
Kartenerstellung ist daher inaktiv und wird heller ausgegraut dargestellt (6). 
Hinweis: Welcher Präsentationstyp möglich ist, kann auch über die Benutzerrechte gesteuert werden. 
Eine ausgegraute Schaltfläche kann auch bedeuten, dass die Anwenderin oder der Anwender nicht die 
Rechte besitzt, diesen Präsentationstyp zu erstellen. So kann z.B. verhindert werden, dass sich 
Anwenderinnen und Anwender Dateiinhalte als Liste oder CSV-Export ausgeben. 
In Kapitel 10 werden die verschiedenen Präsentationstypen ausführlich dargestellt. In den 
nachfolgenden Kapiteln werden jedoch zunächst die Auswahl und Anordnung von Merkmalen, die 
Berechnung neuer Wertemerkmale, die Definition von Filtern und die Grundlagen zur Gestaltung einer 
Präsentationsausgabe grundsätzlich beschrieben, da diese für alle Präsentationstypen gelten. 
Ein Klick auf den Eintrag „Dateiauswahl“ in der Brotkrümel-Zeile (1) führt ebenfalls zurück auf die Seite 
„Dateiauswahl“. 
Hinweis: Um von der aktuellen Seite zur Auswahl des Präsentationstyps wieder zur Dateiauswahl 
zurück zu gelangen, sollte nicht die „Zurück“-Schaltfläche des Browserfensters angeklickt werden, da 
bei diesem Vorgehen bereits getätigte Einstellungsänderungen verloren gehen. Um die Einstellungen 
beizubehalten, kann auf den Eintrag „Dateiauswahl“ in der Brotkrümel-Zeile oder auf die Schaltfläche 
„< Dateiauswahl“ im linken Fußbereich geklickt werden.

## Page 16

Auswertungsassistent - Anwendungshandbuch 
10 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
6. Merkmalsauswahl 
6.1 Allgemeines zum Seitenaufbau 
Für jeden Präsentationstyp gibt es eine an die jeweilige Darstellung angepasste Seite zur Auswahl und 
Anordnung der Merkmale. Der Grundaufbau ist dabei stets gleich. Durch die Bereitstellung 
unterschiedlicher, an die Präsentationstypen angepasster Auswahlseiten behalten die Anwenderinnen 
und Anwender auch bei komplexen Auswertungen die Übersicht über die ausgewählten Merkmale, 
gesetzten Filter und Berechnungen. So werden bei dem Präsentationstyp „Kreuztabelle“ Merkmale in 
der „Kopf“- oder „Vorspalte“ angeordnet. Bei einem Standarddiagramm werden die Merkmale 
dagegen den Grafikachsen zugeordnet und bei der Karte als „Räumliches“ oder „Kategoriales“ 
Merkmal festgelegt. 
 
Abbildung 7: Der Seitenaufbau einer Merkmalsauswahl (z. B. für eine Kreuztabelle) 
Trotz der dem jeweiligen Präsentationstyp geschuldeten Unterschiede in der Auswahl und Anordnung 
der Merkmale besitzen die Auswahlbereiche einen einheitlichen dreigeteilten Grundaufbau: 
Im linken Auswahlbereich werden die in der Dateiauswahl enthaltenen Merkmale angezeigt und zur 
Auswahl angeboten (1). Die Anzeige erfolgt in einer sogenannten Akkordeondarstellung, wobei die 
Schlüsselmerkmale im oberen Akkordeonfach und die Wertemerkmale in dem in der Grundeinstellung 
nach unten geschlossenen Fach angeordnet sind (2). Durch einen Mausklick auf die Titelzeile des nach 
unten zugeklappten Faches der „Wertemerkmale“ wird das obere Fach mit den Schlüsselmerkmalen 
geschlossen und die Wertemerkmale zur Auswahl angezeigt. Dies funktioniert auch umgekehrt, falls 
die Auswahl der Schlüsselmerkmale wieder angezeigt werden soll. Bei dem Präsentationstyp Karte 
werden räumliche Merkmale, zu denen Geometrien vorliegen, in einem separaten Fach „Räumliche 
Merkmale“ den Schlüsselmerkmalen vorangestellt. 
Im zentralen Auswahlbereich werden die Merkmale den Tabellen-, Grafik- oder Kartenbereichen sowie 
den verschiedenen Filterbereichen zugeordnet (4). Die präsentationsspezifische Auswahl und 
Anordnung der Merkmale für die verschiedenen Präsentationstypen werden im Folgenden 
beschrieben (vgl. auch Kapitel 10). 
Der rechte Auswahlbereich (5) dient der Anzeige der Ausprägungen oder Werte des jeweils durch 
Mausklick aktivierten Merkmals und der Auswahl der Filterausprägungen. Die Vorgehensweise zur 
1 
2 
3 
4 
5 
6 
7

## Page 17

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
11 
Festlegung der unterschiedlichen Filter (statischer Filter, dynamischer Filter) wird im Kapitel 7 erläu-
tert. 
Nach einem Mausklick auf die sich im Fußbereich befindende Schaltfläche „Optionen“ (3) öffnen sich 
im linken Bereich der Auswahlseite präsentationstypspezifischen Einstellungsmöglichkeiten (vgl. 
Kapitel

## Page 18

Auswertungsassistent - Anwendungshandbuch 
12 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
9. Konfigurationsmöglichkeiten). 
Zusätzlich lässt sich mittels der Schaltfläche Typ ändern der Präsentationstyp ändern. Dies ist möglich, 
selbst wenn schon Merkmale ausgewählt und angeordnet wurden. (Bitte beachten Sie, dass je nach 
Merkmals-Konstellation und Präsentationstyp nicht jede Änderung möglich ist) 
Ebenfalls hier zu finden ist die Schaltfläche Zurücksetzen. Hierbei ist zu beachten, dass Zurücksetzen 
nicht bedeutet, dass die Optionen und vorgenommene Auswahl auf den Anfangszustand zurückgesetzt 
werden, sondern auf den Stand, der zuletzt in der Sitzung gespeichert wurde. 
Zuletzt wird noch die Möglichkeit geboten, die zusammengestellte Auswertung mittels der 
Schaltfläche Speichern zu sichern – und z.B. via Link oder DUVA-Informationsportal zu teilen (vgl. 
Kapitel 12.2 Erstellen eines Links für gespeicherte Auswertungen). 
Hinweis: Lange Merkmals- und Ausprägungsbezeichnungen werden innerhalb der Anzeige- und 
Auswahlbereiche in mehrere Zeilen umgebrochen. Um die Übersichtlichkeit des Auswahlbereiches zu 
optimieren, lassen sich die Breiten der einzelnen Anzeigebereiche manuell anpassen. Klicken Sie dazu 
auf die Doppelstriche zwischen den Bereichen (6) und verschieben Sie die Rahmen bei gehaltener 
Maustaste in die gewünschte Richtung. 
 
Über dem dreigeteilten Auswahlbereich befindet sich, wie bereits in Kapitel 5 (Abb. 6 (1)) erwähnt, die 
Brotkrümel-Zeile (Hier Dateiauswahl > Präsentationstyp > Kreuztabelle), darunter der Name des 
ausgewählten Datensatzes. Vor dem Namen der Datei stehen zwei übereinander geschwungene Pfeile 
(Abb. 7 (7)). Mit ihnen lässt sich die ausgewählte Datei durch eine „kompatible Datei“ austauschen. 
Mit einem Klick auf das Symbol mit den beiden Pfeilen öffnet sich ein Dialogfenster (Abb. 8). Sind zu 
der ausgewählten Datei ein oder mehrere kompatible Dateien vorhanden, kann hier eine 
entsprechende Auswahl getroffen werden und die Datei ausgetauscht werden. Bereits gesetzte 
ausgewählte Merkmale (Vorspalten-, Wert-, etc.) bleiben ausgewählt. Auch gesetzte und bearbeitete 
Filter werden für die neue Datei übernommen. Kompatible Dateien sind solche, welche die exakt 
gleichen Merkmale aufweisen. Datenreihen aus mehreren Jahren sind ein Beispiel dafür. 
 
Abbildung 8: Datei ersetzen 
Ist keine kompatible Datei vorhanden, wird eine entsprechende Meldung angezeigt (Abb. 9). Die Datei 
kann dann nur über das allgemeine Dateiauswahlmenü aus Kapitel 4 ausgetauscht werden. Über die 
Brotkrümelzeile erreicht man dieses über einen Klick. Hierbei ist zu beachten, dass es sich faktisch um 
eine Neuerstellung der Auswertung handelt – d.h. alle bereits definierten Auswertungsdetails gehen 
verloren und müssen neu konfiguriert werden.

## Page 19

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
13 
 
Abbildung 9: Keine kompatible Datei vorhanden 
 
6.2 Auswahl und Anordnung von Schlüsselmerkmalen 
 
 
Abbildung 10: Die Merkmalsauswahl bei einer Kreuztabelle 
 
Merkmale können aus dem linken Auswahlbereich (Abb. 10 (1)) dem jeweiligen Präsentationsbereich 
zugeordnet werden. Dabei wird das gewünschte Merkmal angeklickt und bei gehaltener Maustaste an 
die gewünschte Position (z.B. in das Feld „Kopfmerkmal“ (2)) gezogen und dort durch das Loslassen 
der Maustaste abgelegt. Wo ein Merkmal angeordnet werden kann, wird beim Überfahren der 
Zielbereiche durch die Veränderung des jeweiligen Rahmens angezeigt. Kann ein Merkmal einem 
Bereich zugeordnet werden, wird der feingestrichelte Zielbereich bei Überfahren mit dem gehaltenen 
Merkmal in eine stärkere Strichlinie geändert (3). 
Durch Betätigen der „Übernahme“-Schaltfläche (7), dargestellt als Pfeil-Symbol, in der Titelzeile des 
Akkordeonfaches „Schlüsselmerkmale“ (1) können dabei auch alle Schlüsselmerkmale mit einem 
Mausklick in die Auswahl übernommen werden. Zusätzlich hierzu steht im Präsentationstyp 
„Kreuztabelle“ noch die Funktion zur Verfügung, die Anordnung der Merkmale umzustellen. 
Soll die Anordnung der Merkmale gewechselt werden, kann dies mittels der ganz rechts befindlichen 
Schaltfläche (8) per Mausklick bewerkstelligt werden.  
Ein zugeordnetes Merkmal wird nicht von der Auswahlliste im linken Seitenbereich entfernt, sodass 
eine erneute Zuordnung möglich wäre – sofern es für die Erstellung der Präsentation sinnvoll ist. So 
1 
2 
3 
4 
5 
6 
2 
7 
8

## Page 20

Auswertungsassistent - Anwendungshandbuch 
14 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
kann z.B. ein Schlüsselmerkmal bei dem Präsentationstyp „Kreuztabelle“ als „Kopfmerkmal“ und als 
„dynamischer Filter“ (vgl. Kapitel 7.2 Dynamische Filter) ausgewählt werden (4). 
Einem Zielbereich bereits zugeordnete Merkmale lassen sich innerhalb des Zielbereichs verschieben, 
indem sie angeklickt und bei gehaltener Maustaste an die gewünschte Position vor, hinter oder 
zwischen die bereits im Zielbereich vorhandenen Merkmale positioniert werden. Grundsätzlich 
können jeweils mehrere Schlüsselmerkmale in den unterschiedlichen Darstellungs- und 
Filterbereichen der Präsentation angeordnet werden (3). Beim Präsentationstyp Kreuztabelle werden 
die Positionierungsmöglichkeiten der „Vorspaltenmerkmale“ und der „Kopfmerkmale“ bei Überfahren 
mit dem zu platzierenden Merkmal durch orangefarbene Randmarkierungen (5) bei den vorhandenen 
Merkmalen angezeigt (vgl. Kapitel 10.1.1). 
Ein im Zielbereich zugeordnetes Merkmal kann allerdings nicht von einem Zielbereich in einen anderen 
oder in die Auswahlliste zurück verschoben werden (z.B. vom „Seitenmerkmal“ einer Kreuztabelle zum 
„dynamischen Filter“ oder vom „Kategorialen Merkmal“ einer Pyramide zum „Trennenden Merkmal“). 
Lediglich zwischen den Feldern „Kopf“- und „Vorspaltenmerkmale“ können Merkmale ausgetauscht 
werden. Ein ausgewähltes und angeordnetes Merkmal erhält daher bei der Auswahl am Zeilenende 
eine durch ein „X“ gekennzeichnete Schaltfläche zum Entfernen des Merkmals (6). Soll ein 
ausgewähltes Merkmal an anderer Stelle platziert werden, muss das Merkmal zunächst durch einen 
Mausklick auf die Schaltfläche „Merkmal entfernen“ aus der Auswahl gelöscht und durch die erneute 
Zuordnung an anderer Stelle wieder eingefügt werden. 
Hinweis: In den Feldern für Merkmalsbeschreibungen können verschiedene Hinweissymbole vor oder 
hinter dem Beschreibungstext erscheinen. Diese sind zugleich Schaltflächen, die eine Aktion auslösen. 
So werden Merkmale, denen im zugrundeliegenden Nachweissystem Zusatzinformationen zugeordnet 
wurden, durch ein vorangestelltes Info-Symbol (Buchstabe „i“) gekennzeichnet (7). Enthält die 
Zusatzinfo einen Link, wird dieser in einem eigenständigen Fenster geöffnet, textuelle Informationen 
werden in einem modalen Popup-Fenster angezeigt. Die Zusatzinformationen können auch in der 
Präsentationsausgabe als Fußnote oder Verweis dargestellt werden (vgl. Kapitel 9.2). 
Die übrigen Symbole werden in den nachfolgenden Kapiteln bei den entsprechenden Funktionen 
erläutert. 
 
6.3 Auswahl von abgeleiteten Merkmalen (Gruppierungen) 
Merkmale, deren Verschlüsselungen im zugrundeliegenden Nachweissystem als Quellmerkmale einer 
Referenztabelle verwendet werden, können auch im Auswertungsassistenten zur Ableitung neuer 
Merkmale genutzt werden. Dabei werden die Ausprägungen des Quellmerkmals anhand der 
Referenztabelle zu Ausprägungsgruppen zusammengefasst. Dadurch können in der zu erstellenden 
Präsentation komfortabel Gruppierungen vorgenommen werden. Enthält eine zur Auswertung 
ausgewählte Datei z.B. das Merkmal „Alter“ mit der Verschlüsselung nach Altersjahren und wurde 
dieses Merkmal mit seiner Verschlüsselung im Nachweissystem über Referenztabellen zu 
Altersgruppen zusammengefasst, können die auf dieser Verschlüsselung basierenden Altersgruppen 
als zusätzliche Merkmale in die Merkmalsauswahl des Auswertungsassistenten übernommen und bei 
der Erstellung der Präsentation verwendet werden (Abb. 11).

## Page 21

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
15 
 
Abbildung 11: Gruppierungen sind über Referenztabellen möglich 
Merkmale, für die Referenztabellen vorliegen, werden durch eine Schaltfläche mit einem 
Kettensymbol am Ende der Merkmalszeile gekennzeichnet (Abb. 11(1)). Dieses Symbol dient zugleich 
als Schaltfläche. Durch das Anklicken wird der Dialog „Gruppierung definieren“ gestartet (2). In diesem 
Fenster wird der Name des Quellmerkmals nochmals angezeigt (3). In der Auswahlliste „Sachgebiet“ 
können die entsprechenden Sachgebiete ausgewählt werden (4). Unter „Verfügbare Referenztabellen“ 
(5) können dann die dem ausgewählten Sachgebiet zugehörigen Referenztabellen ausgewählt werden. 
Die Auswahl wird in die Zeile „Bezeichnung des neuen Merkmals“ übernommen und kann dort für die 
Anzeige in der Präsentation editiert werden (6).  
Durch Anklicken und Ziehen des Fensterrahmens bei gehaltener linker Maustaste lässt sich die Anzeige 
beliebig vergrößern. Dies ist besonders bei langen Merkmalsbeschreibungen zur vollständigen Anzeige 
hilfreich. Die Auswahl wird durch einen Mausklick auf die Schaltfläche „Übernehmen“ abgeschlossen 
(7). Liegen für ein Merkmal mehrere Referenztabellen vor, kann der Vorgang „Gruppierung definieren“ 
mehrfach wiederholt werden. Die auf diese Weise hinzugefügten Merkmale stehen nun für die 
Darstellung in der Präsentation oder zur Nutzung als Filter zur Verfügung (8). Sie werden durch ein 
vorangestelltes Kettensymbol gekennzeichnet. Am Ende des hinzugefügten Merkmalsfeldes werden 
zwei weitere Schaltflächen angezeigt, über die das referenzierte Merkmal wieder aus der Auswahl 
entfernt (Symbol Abfalleimer) oder die Bezeichnung der eingefügten Gruppierung bearbeitet (Symbol 
Schreibstift) werden kann (9). 
 
6.4 Erstellung interner Referenztabellen 
Neben den fest im Nachweissystem hinterlegten Referenztabellen (vgl. Kapitel 6.3), lassen sich im ASW 
auch neue interne Referenztabellen temporär erstellen. 
Um für ein Merkmal eine Referenztabelle zu erstellen, muss zuerst das gewünschte Schlüsselmerkmal 
ausgewählt werden (1). Dadurch wird das Kettensymbol im Kopfbereich des Auswahlbereiches 
„Schlüsselmerkmale“ aktiv (2). Durch Klicken auf das Kettensymbol öffnet sich das Dialogfenster zu 
Erstellung der Referenztabelle (Abb. 13). Die Erstellung interner Referenztabellen ist nur bei 
Schlüsselmerkmalen möglich, bei denen eine Schlüsseltabelle im Nachweissystem hinterlegt ist. Bei 
1 
2 
3 
5 
6 
7 
8 
9 
4

## Page 22

Auswertungsassistent - Anwendungshandbuch 
16 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Schlüsselmerkmalen, welche mit identifizierenden Schlüsseln verknüpft sind, können keine internen 
Referenztabellen erstellt werden.  
 
Abbildung 12: Öffnen des Dialogfensters „Interner Referenztabelle“ 
Im linken Teil des Dialogfensters wird das ausgewählte Schlüsselmerkmal sowie dessen 
Merkmalsausprägungen angezeigt (4). Im rechten Teil gibt es ein Eingabefeld zur Benennung der 
Referenztabelle (5) sowie eine Schaltfläche um neue Referenzklassen hinzuzufügen (6). 
 
Abbildung 13: Erstellung interner Referenztabellen 
In welcher Reihenfolge die Bearbeitung erfolgt, ist freigestellt. Die benötigten Referenzklassen können 
eine nach der anderen erzeugt, beschriftet und befüllt werden oder auch alle zunächst nur erstellt und 
benannt werden und anschließend abwechselnd befüllt werden. Zum Befüllen der Referenzklassen 
können die Merkmalsausprägungen mit der Maus in die entsprechende Klasse (gelb) gezogen werden 
(7). Sie können aber auch mittels Doppelklick der aktuell ausgewählten Referenzklasse (blau) 
zugeordnet werden. Die Referenzklasse muss zuvor per Mausklick selektiert werden, sodass sie 
farblich blau gekennzeichnet ist. Auf gleiche Weise können die Merkmale auch zwischen den 
Referenzklassen umher geschoben werden. Um eine Zuordnung aufzulösen, muss auf die 
1 
2 
3 
4 
5 
6 
7 
8 
9 
10 
11

## Page 23

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
17 
entsprechende Ausprägung doppelt geklickt werden, ohne dass eine Referenzklasse ausgewählt ist. 
Das einfache Verschieben einer Ausprägung von rechts aus einer Referenzklasse heraus in die linke 
Seite ist aus technischen Gründen nicht möglich. 
Mit einem Klick auf den vorangestellten Pfeil jeder Referenzklasse wird diese ausgeklappt, sodass die 
ausgewählten Merkmalsausprägungen der jeweiligen Klasse angezeigt werden (8). Mit der 
Schaltfläche „X“ am Ende der Referenzklasse kann diese wieder gelöscht werden (9). Wird eine 
Referenzklasse, die bereits Merkmale enthält, gelöscht, werden diese der aktiven Klasse (blau) 
zugeordnet, sofern eine Klasse ausgewählt wurde. Anderenfalls werden die Merkmale wieder auf die 
linke Seite des Dialogfensters verschoben. Mit dem Befehl „Übernehmen“ wird die Referenztabelle 
erstellt (10). Vor der Übernahme sollte sorgsam geprüft werden, ob alle Angaben korrekt sind, da eine 
einmal definierte Referenztabelle nicht mehr bearbeitet werden kann. Mit „Abbrechen“ wird das 
Dialogfenster „Referenztabelle erstellen“ ohne Übernahme geschlossen (11). 
Hinter dem Schlüsselmerkmal, in diesem Falle „Haushaltstyp (HHSTAT)“, zu dem die Referenztabelle 
hinterlegt wurde, erscheint nun im Auswahlbereich „Schlüsselmerkmal“ das Kettensymbol, um eine 
Gruppierung zu erzeugen (Abb. 14 (12)). Wird eine neue Gruppierung definiert (siehe dazu 6.3), steht 
die neue interne Referenztabelle hierbei zur Verfügung. Die neu erstellte Referenztabelle ist unter 
„Verfügbare Referenztabellen“ zu finden (13). 
 
Abbildung 14: Erstellte Referenztabelle im Dialogfenster „Gruppierung definieren“ 
 
6.5 Auswahl von Wertemerkmalen 
Enthält die für die Auswertung ausgewählte Datei lediglich ein Wertemerkmal, wird dieses 
automatisch dem Wertebereich der gewählten Präsentation zugeordnet. Ist mehr als ein 
Wertemerkmal in der Datei vorhanden, muss mindestens eines ausgewählt und zugeordnet werden, 
bevor die Erstellung der Präsentation gestartet werden kann. Die Zuordnung erfolgt – wie bei den 
Schlüsselmerkmalen – durch Anklicken in der Auswahlliste (Abb. 15 (1)) und Ziehen bei gehaltener 
Maustaste in den durch die Bezeichnung „Wertemerkmale“ gekennzeichneten Zielbereich (2) der 
Präsentation. 
12 
13

## Page 24

Auswertungsassistent - Anwendungshandbuch 
18 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Oftmals können mehrere Wertemerkmale in die zu erstellende Präsentationsausgabe gewählt werden 
(vgl. Kapitel 10). Durch Betätigen der „Übernahme“-Schaltfläche (Pfeil-Symbol) in der Titelzeile des 
Akkordeonfaches „Wertemerkmale“ (1) können dabei auch alle Wertemerkmale mit einem Mausklick 
in die Auswahl übernommen werden. Mit Hilfe von Strg- und Umschalt-Taste können beliebig viele 
Merkmale zur Übernahme ausgewählt werden. Um Operationen auf einzelnen Merkmalen, wie etwa 
das Anzeigen und Bearbeiten von Filtern, zu ermöglichen, wird dabei farblich zwischen selektierten 
und fokussierten Merkmalen unterschieden. Das fokussierte Wertemerkmal wird etwas heller 
dargestellt als die anderen selektierten Wertemerkmale. Es kann immer nur ein fokussiertes Merkmal 
geben und zwar das zuletzt selektierte. Zur Übernahme der ausgewählten Merkmale kann wiederum 
das „Pfeil-Symbol“ (3) betätigt werden. 
Wurden zwei oder mehr „Wertemerkmale“ ausgewählt, kann durch Betätigen der „Doppel-Pfeil-
Schaltfläche“ (4) die Anordung der Wertemerkmale innerhalb des Feldes zwischen „untereinander“ 
und „nebeneinander“ geändert werden. Diese Funktion steht nur bei den Präsentationstypen 
„Kreuztabelle“ und „Interaktive Tabelle“ zur Verfügung. Bei den anderen Präsentationstypen wird 
diese Funktion nicht angezeigt. 
 
Abbildung 15: Die Auswahl von Wertemerkmalen 
 
6.6 Berechnung von neuen Wertemerkmalen 
Zusätzliche Wertemerkmale können der Präsentation durch Berechnung hinzugefügt werden (Abb. 
16). Der dazu erforderliche Dialog „Berechnetes Merkmal definieren“ (2) kann durch einen Mausklick 
auf die entsprechende Schaltfläche (Summen-Symbol) in der Titelzeile des Akkordeon-Faches 
„Wertemerkmale“ geöffnet werden (1). In diesem Dialog werden im linken Auswahlbereich alle 
Wertemerkmale der ausgewählten Datei aufgeführt (3). Dabei wird jedem Wertemerkmal ein 
Merkmalskürzel (z.B. „#2“ vorangestellt (4)). Dieses Kürzel dient bei der Erstellung der 
Berechnungsformel als Platzhalter. Im rechten Bereich des Dialogfensters wird die Definition des zu 
berechnenden Wertemerkmals vorgenommen.  
1 
2 
3 
4

## Page 25

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
19 
 
 
Abbildung 16: Die Berechnung von neuen Wertemerkmalen 
In dem ausgewählten Beispiel soll die durchschnittliche Haushaltsgröße berechnet werden. Dazu wird 
in der oberen Eingabezeile zunächst eine treffende Bezeichnung für das berechnete Merkmal 
eingegeben (z.B. „Durchschnittliche Haushaltsgröße“ (5)). Im nächsten Schritt wird die Formel zur 
Berechnung des Indikators im Feld „Berechnungsformel“ eingetragen (6). Die dafür erforderlichen 
Variablen können aus der Auswahlliste der Wertemerkmale durch Anklicken und Ziehen bei gehaltener 
Maustaste in den Formeleditor übertragen werden. Alternativ können die Variablen durch Doppelklick 
an der aktuellen Cursorposition eingeführt werden. Nach dem Platzieren des Wertemerkmals werden 
die Merkmalsbezeichnungen durch die entsprechenden Merkmalskürzel ersetzt. Die Variablen können 
aber auch über die Tastatur durch die direkte Eingabe der Merkmalskürzel in den Formeleditor 
eingetragen werden. Rechenzeichen (z.B. * für die Multiplikation) sowie konstante Werte werden 
ebenfalls über die Tastatur eingegeben. Die Formel für die Berechnung der durchschnittlichen 
Haushaltsgröße lautet in diesem Beispiel: #12/#11. Beim Überfahren der Formel im Formeleditor mit 
dem Mauszeiger wird die Formel mit Klartextangaben der eingefügten Wertemerkmale (=„Anzahl der 
Personen (Wohnberechtigte) im Haushalt“ / „Anzahl Haushalte“) als Tooltip angezeigt (7).Durch einen 
Klick auf die Schaltfläche „Übernehmen“ (8) wird der Dialog geschlossen und das berechnete Merkmal 
in die Liste der Wertemerkmale aufgenommen. Dem berechneten Merkmal wird das Summensymbol 
vorangestellt. Am Ende der hinzugefügten Merkmalszeilen werden zwei weitere Schaltflächen 
angezeigt, über die das berechnete Merkmal wieder bearbeitet (Symbol Stift) oder aus der Auswahl 
entfernt (Symbol Abfalleimer) werden kann (9). Ein Anklicken des Bearbeitungssymbols ruft das 
Dialogfenster zur Bearbeitung berechneter Merkmale wieder auf und ermöglicht ein Editieren der 
Merkmalsbezeichnung und der Berechnungsformel. 
 
 
1 
2 
3 
4 
5 
6 
7 
8 
9

## Page 26

Auswertungsassistent - Anwendungshandbuch 
20 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
7. Filtermöglichkeiten 
Im DUVA-Auswertungsassistenten besteht die Möglichkeit, Filter über die in der ausgewählten Datei 
enthaltenen „Schlüssel“- und „Wertemerkmale“ bzw. deren Ausprägungen und Werte zu setzen. In 
den zu erstellenden Präsentationen werden nach dem Setzen eines Filters nur noch die Fälle 
ausgewertet, für die die gesetzten Filterkriterien zutreffen. Der Auswertungsassistent unterscheidet 
grundsätzlich zwei Arten von Filtern: „statische Filter“ (Kapitel 7.1) und „dynamische Filter“ (Kapitel 
7.2). Unter dem „statischen Filter“ können die Merkmale und deren Ausprägungen bzw. Werte 
bestimmt werden, die in eine Auswertung einfließen oder davon ausgeschlossen werden sollen. Beim 
„dynamischen Filter“ werden die Merkmale ausgewählt, über die die Anwenderinnen und Anwender 
in den Präsentationsausgaben am Bildschirm (außer bei der Karte und der CSV-Ausgabe) selbständig 
Filter setzen und somit die Sicht auf die auszuwertenden Daten weiter einschränken können. Dies ist 
insbesondere bei vorgefertigten Auswertungen sinnvoll, die über einen Link von einem größeren 
Anwenderkreis aufgerufen und selbständig für den jeweiligen Bedarf in der Auswertungssicht weiter 
eingeschränkt werden sollen (vgl. Kapitel 12). 
7.1 Statische Filter 
Zu jedem Merkmal einer ausgewählten Datei lassen sich Filter definieren, sofern das betreffende 
Merkmal in einen der Auswahlbereiche der Präsentation gezogen und dort platziert wurde (Abb. 17). 
Um auch Ausprägungen bzw. Werte von Merkmalen filtern zu können, die nicht für eine Darstellung 
in einem der sichtbaren Präsentationsbereiche vorgesehen sind, verfügen alle Präsentationstypen 
über den Zielbereich „statischer Filter“ (1). Grundsätzlich können die Ausprägungen mehrerer Merk-
male in die Filterdefinition einfließen. 
Filter können durch Anklicken von Merkmalsausprägungen im rechten Bereich der Merkmalsauswahl 
gesetzt werden. Komplexere Filterbedingungen können in einem Filtereditor definiert werden. 
7.1.1 Setzen von Filtern durch Markierung von Merkmalsausprägungen 
Soll ein Filter gesetzt werden, wird das Merkmal in dem Zielbereich der zu erstellenden Präsentation 
zunächst durch Anklicken aktiviert (blau hinterlegt) (Abb. 17). Dabei spielt es keine Rolle, in welchem 
Zielbereich das Merkmal abgelegt wurde. Merkmale, deren Ausprägungen in der Präsentation nicht 
berücksichtigt werden sollen, müssen in dem Zielbereich „statischer Filter“ (1) eingefügt werden. 
Die Ausprägungen bzw. Werte des durch Mausklick aktivierten Merkmals werden in dem rechten, mit 
„Filter für aktives Merkmal“ überschriebenen Bereich der Merkmalsauswahlseite dargestellt (2). Hier 
lassen sich jeweils die Ausprägungen per Mausklick markieren, die bei der Präsentationserstellung 
berücksichtigt werden sollen. Wurden noch keine Filterkriterien definiert, sind alle Ausprägungen des 
aktiven Merkmals für die Auswertung ausgewählt. Erkennbar ist dies an der hellblauen Unterlegung 
der Ausprägungstexte sowie an den vorangestellten Haken (3). 
Ein Mausklick auf eine Ausprägung führt dazu, dass diese für die Präsentation ausgewählt wird. 
Während bei allen übrigen Ausprägungstexten Haken und Hintergrundfarbe entfernt werden, bleiben 
die Markierungen bei der ausgewählten Ausprägung erhalten. Sollen zu einer bereits getroffenen 
Auswahl zusätzliche Ausprägungen als Filterkriterien hinzugefügt werden, so kann dies bei gedrückter 
Strg-Taste umgesetzt werden. Umgekehrt können bei gedrückter Strg-Taste auch einzelne Ausprägun-
gen aus einer zuvor getroffenen Auswahl wieder entfernt werden. Mit der Umschalt-Taste ist ein 
blockweises Auswählen ganzer Ausprägungs- oder Wertebereiche möglich. 
Durch einen Klick auf die Schaltfläche „Filter umkehren“ (4) in der Titelzeile des Auswahlbereiches zur 
Filterdefinition werden alle zuvor ausgewählten Ausprägungen des aktiven Merkmals wieder 
zurückgelegt und stattdessen die zuvor ausgeschlossenen Merkmalsausprägungen als Filterkriterien 
berücksichtigt. Dies ist insbesondere bei Merkmalen mit vielen Ausprägungen (z.B. bei räumlichen

## Page 27

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
21 
Merkmalen wie den Baublöcken), von denen jedoch nur wenige von der Auswertung ausgeschlossen 
werden sollen, hilfreich. In diesen Fällen, werden die auszuschließenden Ausprägungen zunächst als 
Filterkriterium ausgewählt. Durch die Umkehr des Filters werden die ausgewählten Ausprägungen 
wieder aus den Filterkriterien entfernt, während die bisher unberücksichtigten Ausprägungen nun 
Eingang in die Auswertung finden.  
 
 
Abbildung 17: Ein Merkmal muss einem Zielbereich zugeordnet sein, bevor die Merkmalsausprägungen gefiltert werden 
können. Soll ein Filter für ein Merkmal definiert werden, dessen Ausprägungen nicht in der Präsentation dargestellt werden 
sollen, muss das Merkmal dem Zielbereich „Statischer Filter“ zugeordnet werden. Dieser Bereich ist hier bereits mit dem 
Merkmal „Haushaltstyp (HHSTAT)“ belegt. Das Ergebnis dieser Auswahl ist in Abbildung 18 dargestellt. 
Werden verschiedene Ausprägungen eines Merkmals als Filterkriterien ausgewählt, werden diese mit 
einem logischen ODER verknüpft. Werden hingegen die Filterkriterien mehrerer Merkmale bzw. deren 
Ausprägungen gewählt, werden diese mit einem logischen UND verknüpft. 
Um die Anzahl der Haushalte ohne Kinder und die Anzahl der Personen in Haushalten ohne Kinder für 
einen bestimmten Teil der Stadt darzustellen, müssen in dem gezeigten Beispiel (Abb. 17) zwei Filter 
gesetzt werden: Dazu wurden die Merkmale „Kleinräumige Gliederung 3-stellig (Gemeindeteil)“ und 
„Haushaltstyp (HHSTAT)“ ausgewählt und den Zielbereichen zugeordnet. Dabei sollen die 
ausgewählten Gemeindeteile in der Vorspalte aufgeführt werden. Die ausgewählten Haushaltstypen 
sollen dagegen nicht in der Tabelle differenziert dargestellt werden. Aus diesem Grunde wurde das 
Merkmal „Haushaltstyp (HHSTAT)“ im Zielbereich „Statischer Filter“ abgelegt. Zunächst wurden aus 
der Ausprägungsliste des Merkmals „Kleinräumige Gliederung 3-stellig (Gemeindeteil)“ die relevanten 
Gemeindeteile ausgewählt. Danach wurde das Merkmal „Haushaltstyp (HHSTAT)“ durch einen 
Mausklick aktiviert. Dadurch wurde das Merkmalsfeld blau unterlegt und die Ausprägungsliste im 
rechten Auswahlbereich angezeigt. In dem gezeigten Beispiel wurden bereits alle Haushaltstypen ohne 
Kinder zur Auswahl markiert. 
1 
2 
3 
4 
5 
6

## Page 28

Auswertungsassistent - Anwendungshandbuch 
22 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Wurden für ein Merkmal Ausprägungen als Filterkriterien ausgewählt, wird dieses Merkmal durch ein 
der Merkmalsbezeichnung vorangestelltes Filtersymbol gekennzeichnet (5). Diese Kennzeichnung 
bleibt auch dann erhalten, wenn ein anderes Merkmal aktiviert wird. Dadurch ist immer sichtbar, für 
welche Merkmale bereits Filter definiert wurden. 
Soll die getroffene Filterauswahl für ein Merkmal aufgehoben werden, so wird durch das Anklicken der 
Schaltfläche „Filter zurücksetzen“ (6) im oberen Rahmen des Auswahlbereiches zur Filterdefinition die 
zuvor getroffene Auswahl für das aktuell ausgewählte Merkmal zurückgesetzt. 
Einmal gesetzte Filterkriterien bleiben für ein Merkmal auch dann erhalten, wenn das Merkmal wieder 
aus dem Zielbereich der Präsentation entfernt und in den Auswahlbereich zurückgelegt wird. Die 
Filterkriterien werden in diesem Fall zwar unwirksam und bleiben bei einer Auswertung 
unberücksichtigt, bei einer erneuten Auswahl und Zuordnung des Merkmals – auch in einen anderen 
Zielbereich der Präsentation – werden sie jedoch wieder aktiviert. 
 
 7.1.2 Präsentationsausgabe 
In der Präsentationsausgabe (Abb. 18) werden die gesetzten Filterkriterien in der generierten Merk-
malsauflistung der Präsentation aufgeführt, so dass diese zur Interpretation der Auswertung wichtige 
Information nicht verloren geht. Dabei werden die gesetzten Filter nach den in der Präsentation 
dargestellten Merkmalen in einer Klartextangabe (1) benannt („wobei (Filterkriterium)“). Dies gilt auch 
für die Anzeige komplexer Filter, die über mehrere Schlüsselmerkmale gesetzt wurden sowie für Filter 
über Merkmale, die nicht als sichtbare Merkmale in die Präsentation aufgenommen wurden. Allein aus 
dieser Auflistung kann somit die Selektion aller Merkmale und aller gesetzten Filter rekonstruiert 
werden.  
 
 
Abbildung 18: Diese Tabelle ist das Ergebnis der in Abbildung 17 dargestellten Auswahl 
Hinweis: Die Einzelwerte eines Wertebereichs können nicht als Filterkriterien verwendet werden, da die 
Definition von Filtern für Wertemerkmale nur noch regelbasiert erfolgt und somit auch nur noch bei 
statischen Filtern möglich ist. Lediglich in der Auswertung selbst werden bei dynamischen Filtern die 
entsprechenden Werte angezeigt. Allerdings ist hier – insbesondere bei Aggregatdateien – Vorsicht 
1

## Page 29

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
23 
geboten. Um in der Präsentation jede beliebige Ausprägungskombination auswerten und darstellen zu 
können, ist es erforderlich, dass die Werte von Zähl- und Summenfeldern entsprechend ihrem 
Vorkommen auf die Ausprägungskombinationen innerhalb des mehrdimensionalen Datenkörpers 
verteilt werden. Dadurch lassen die Werte keine Rückschlüsse auf die tatsächlichen Fallzahlen für die 
innerhalb der Präsentation ausgewählten Merkmalskombinationen zu. Ein Filtern über Wertebereiche 
sollte daher nur bei genauer Kenntnis der Satzstruktur durchgeführt werden und empfiehlt sich nur bei 
Basisdateien (Einzeldatensätze) oder Makrodateien (Aggregatdaten) mit lediglich einem 
Schlüsselmerkmal. 
 
7.1.3 Definieren von Filtern mit Hilfe des Filtereditors 
Komplexere Filterbedingungen können in einem Dialogfenster „Filterbedingungen definieren“ erstellt 
werden. Dieser Filtereditor wird für das zuvor aktivierte Merkmal durch einen Mausklick auf die mit 
einem Stift-Symbol gekennzeichnete Schaltfläche „Filter bearbeiten“ in der Titelzeile des Auswahl-
bereiches aufgerufen (Abb. 1 (1)). Die in diesem Dialog vorgenommene Filterdefinition bezieht sich 
ausschließlich auf das aktuelle Merkmal, das im Kopfbereich des Fensters angezeigt wird (2). Durch 
einen weiteren Klick auf die Schaltfläche „neue Bedingung“ innerhalb des Dialoges (3) kann die (erste) 
gewünschte Bedingung eingegeben werden.  
 
 
Abbildung 19: Durch einen Klick auf die Schaltfläche „Filter bearbeiten“ öffnet sich der Filtereditor zur manuellen Definition 
komplexer Filterbedingungen 
Die Eingabezeile für eine Filterbedingung (Abb. 20) besteht aus den drei Eingabeelementen 
„Operator“, „Vergleichswert" und die Auswahlmöglichkeit der Verknüpfungslogik zu weiteren 
Filterbedingungen („logisches UND“/ „logisches ODER“): Im Pulldown-Menü Operator (2) wird 
festgelegt, ob der Ausprägungsschlüssel oder der Wert des aktiven Wertemerkmals gleich (=), ungleich 
1 
3 
2

## Page 30

Auswertungsassistent - Anwendungshandbuch 
24 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
(≠), kleiner (<), größer (>), kleiner gleich (≤) oder größer gleich (≥) ist, als der Vergleichswert. In dem 
Eingabefeld „Vergleichswert“ (3) wird der gewünschte Ausprägungsschlüssel oder Wert eingegeben, 
mit dem der Merkmalswert verglichen werden soll. 
Durch wiederholte Klicks auf die Schaltfläche „neue Bedingung“ (1) werden zusätzliche Eingabezeilen 
für weitere Filterbedingungen erstellt und zur Bearbeitung angezeigt. Die einzelnen Filterbedingungen 
sind dabei durch ein logisches UND miteinander verknüpft. Diese Verknüpfungslogik kann durch das 
Pulldown-Menü (4) in ein logisches ODER geändert werden. 
Eine Eingabezeile – und damit eine Teilbedingung – kann durch einen Klick auf die durch ein Minus 
gekennzeichnete Schaltfläche (5) am Ende der Zeile wieder gelöscht werden. 
Die Definition der Filterbedingung wird erst durch die Betätigung der Übernehmen-Schaltfläche (6) im 
Fußbereich des Filterdialoges übernommen und aktiviert. Ein Klick auf diese Schaltfläche beendet den 
Dialog und schließt das Fenster. Ein Klick auf die Schaltfläche „Abbrechen“ (7) oder „X“ (8) schließt den 
Filtereditor ebenfalls ohne die vorgenommenen Einträge zu aktivieren.  
 
  
 
 
1 
2 
3 
4 
5 
6 
7 
8 
Abbildung 20: Durch einen Klick auf die Schaltfläche „Filter bearbeiten“ öffnet sich 
der Filtereditor zur manuellen Definition komplexer Filterbedingungen

## Page 31

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
25 
Beispiel 
Um die Anzahl EU-Ausländerinnen und EU-Ausländer nach Stadtbezirken darstellen zu können, sollen 
in dem gezeigten Beispiel (Abb. 21) die Filterbedingungen im Filterdialog definiert werden: Dazu wurde 
das Merkmal „Erste Staatsangehörigkeit“ in den Zielbereich „Statischer Filter“ ausgewählt und durch 
einen Mausklick aktiviert. Um nicht die 27 einzelnen Staatsangehörigkeiten der EU (ohne Deutschland) 
im rechten Auswahlbereich in der Ausprägungsliste anklicken zu müssen, wird der Filtereditor durch 
die Betätigung der Schaltfläche (Stift-Symbol) am Ende der Titelzeile des Auswahlbereiches geöffnet. 
Da bei der Filterdefinition die Ausprägungswerte und nicht die Ausprägungstexte als Vergleichswerte 
eingegeben werden, lohnt sich die Prüfung, welche Staatenschlüssel direkt aufeinander folgen und 
somit als eine Bedingung eingegeben werden kann. So besitzen die Staaten 124 Belgien, 125 Bulgarien, 
126 Dänemark, 127 Estland, 128 Finnland, 129 Frankreich, 130 Kroatien und 131 Slowenien direkt 
aufeinander folgende Staatenschlüssel (Untergrenze = 124 bis Obergrenze = 131), ebenso die Staaten 
151 Österreich, 152 Polen, 153 Portugal, 154 Rumänien und 155 Slowakei (151 bis 155). Durch die 
Bedingung „Merkmalswert ≥ Untergrenze UND Merkmalswert ≤ Obergrenze“ kann eine Gruppe von 
Ausprägungen mit aufeinander folgenden Schlüsseln definiert werden. Dazu werden zwei Zeilen im 
Filtereditor benötigt, die nacheinander durch Klicks auf die Schaltfläche „neue Bedingung“ angelegt 
werden. In der ersten Zeile wird der Operator ≥ (größer gleich) ausgewählt und als Vergleichswert der 
Ausprägungsschlüssel 124 als erster Staatenschlüssel der Schlüsselfolge eingegeben. In der zweiten 
Zeile wird der Operator ≤ (kleiner gleich) gewählt und Schlüssel 131 als letzter Wert der Schlüsselfolge 
als Vergleichswert eingetragen. Die beiden Teilbedingungen werden dabei durch ein logisches UND 
miteinander verknüpft. Die Abgrenzung zu weiteren Bedingungen erfolgt dagegen jeweils durch ein 
logisches ODER. Daher wird am Ende der zweiten Zeile im Pulldown-Menü der Eintrag ODER 
ausgewählt, bevor weitere Zeilen ergänzt und der Filter auf die noch fehlenden Staaten ausgedehnt 
werden kann. Die gesamte Filterbedingung zur Einschränkung der Auswertung auf die gewünschte 
Personengruppe der EU-Ausländerinnen und EU-Ausländer kann der Abbildung 21 entnommen 
werden. Die Präsentationsausgabe zeigt Abbildung 22. 
 
Abbildung 21: Filterbedingungen; hier für Staatsangehörigkeiten.

## Page 32

Auswertungsassistent - Anwendungshandbuch 
26 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
Abbildung 22: Ergebnis der Filterung aus Abbildung 21 
Nach einem Mausklick auf die Schaltfläche „Übernehmen“ im Fußbereich des Filtereditors wird der 
Dialog geschlossen und die Filterbedingungen übernommen (Abb. 20 (6)). Die durch die Filterbedin-
gungen selektierten Ausprägungen werden nun in der Ausprägungsliste im rechten Auswahlbereich 
hellblau unterlegt und durch einen vorangestellten Haken gekennzeichnet (Abb. 23 (1)). So können die 
gesetzten Filterbedingungen nochmals anhand der Markierungen überprüft werden. Dies gilt jedoch 
nur bei Schlüsselmerkmalen.  
Nach der Erstellung und Übernahme einer Filterbedingung aus dem Filtereditor können die Ausprä-
gungen im Auswahlbereich zur Filterdefinition nicht mehr durch das Anklicken einzelner Ausprägungen 
oder Werte verändert werden. Die Umkehrung der Filterbedingungen ist hier nicht mehr möglich. 
Durch einen symbolischen Stift gekennzeichnete Schaltfläche für „Filter bearbeiten“ wird blau 
hervorgehoben (2). Durch Betätigung dieser Schaltfläche kann der Filtereditor wieder aufgerufen und 
die Filtereinträge können bearbeitet werden. Erst nach Aufhebung des regelbasierten Filters stehen 
die Ausprägungen des aktiven Merkmals wieder zur herkömmlichen Auswahl zur Verfügung.  
 
Abbildung 23: Filterauswahl für ein aktives (farbig hinterlegtes) Merkmal 
1 
2

## Page 33

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
27 
Die über den Filtereditor definierten Filterkriterien bleiben für ein Merkmal auch dann erhalten, wenn 
das Merkmal wieder aus dem Zielbereich der Präsentation entfernt und in den Auswahlbereich zurück-
gelegt wird. Die Filterkriterien werden in diesem Fall zwar unwirksam und bleiben bei einer Auswer-
tung unberücksichtigt, bei einer erneuten Auswahl und Zuordnung des Merkmals – auch in einen 
anderen Zielbereich der Präsentation – werden sie jedoch wieder aktiviert. 
In der Präsentationsausgabe (Abb. 22) werden die über den Filtereditor gesetzten Filterbedingungen 
ebenfalls in der generierten Merkmalsauflistung der Präsentation aufgeführt. Allerdings werden die 
selektierten Ausprägungen nicht einzeln in einer Klartextangabe benannt, sondern die Bedingung als 
logischer Ausdruck hinter den in der Präsentation verwendeten Merkmalen angezeigt („wobei (Erste 
Staatsangehörigkeit >= ‚124‘ und Erste Staatsangehörigkeit <= ‚131‘ oder Erste Staatsangehörigkeit >= 
‚151‘ und Erste Staatsangehörigkeit <= ‚155‘ oder …)“). 
 
Hinweis: Werden für ein Merkmal Filterbedingungen mit dem Operator „=“ definiert, können diese nur 
durch eine logische ODER-Verknüpfung sinnvoll miteinander verknüpft werden. 
Hinweise auf die Verknüpfungslogik: 
1. Operator = in Kombination mit UND-Verknüpfung: da ein Merkmalswert nicht gleichzeitig identisch 
mit dem ersten und zweiten Vergleichswert sein kann, werden keine Werte gefunden.  
2. Durch die UND-Verknüpfung von Filterbedingungen mit den Operatoren >= und <= können 
Ausprägungsbereiche/Wertebereiche definiert werden. 
7.1.4 Berücksichtigung von leeren Merkmalen und Leerzeichen 
Das Filtern wird durch das Auftreten von leeren Merkmalen, NULL-Werten und Werten mit 
Leerzeichen verkompliziert. Bei allen Merkmalstypen werden NULL-Werte in den Filterlisten durch das 
Symbol für die leere Menge „Ø“ angezeigt (Abb. 24). Dadurch wird es möglich explizit nach NULL-
Werten bzw. Leerstrings zu suchen. 
 
 
Abbildung 24: NULL-Wert in der Filterliste 
 
 
1

## Page 34

Auswertungsassistent - Anwendungshandbuch 
28 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
7.2 Dynamische Filter 
 
 
Abbildung 25: Die Merkmale „Haushaltstyp (HHSTAT)_neu“ und „Zahl der Kinder im Haushalt“ wurden dem Zielbereich 
„Dynamischer Filter“ zugeordnet. Dadurch werden der Bildschirmausgabe der Kreuztabelle Auswahllisten vorangestellt, die 
es den Betrachterinnen und Betrachtern ermöglicht, die Sicht auf die Haushaltszahlen weiter einzuschränken. 
Schlüsselmerkmale, die in den Zielbereich „dynamische Filter“ (Abb. 25) ausgewählt wurden, werden 
oberhalb der zu erstellenden Präsentation als Auswahllisten hinzugefügt. Dies ermöglicht ein 
nachträgliches Filtern auf der Ausgabeseite der erstellten Präsentation und bietet den Anwenderinnen 
und Anwendern, die ihre Präsentationen nicht selbst erstellen sondern auf vorgefertigte 
Auswertungen 
zugreifen, 
zusätzliche 
Auswertungsmöglichkeiten. 
Mit 
Ausnahme 
der 
Präsentationstypen „CSV-Export“ und „Karte“ steht diese zusätzliche Ausgabemöglichkeit bei allen 
Präsentationen zur Verfügung. 
 
Abbildung 26: Durch die Zuordnung von Merkmalen im Zielbereich „Dynamischer Filter“ werden der Bildschirmausgabe 
Auswahllisten hinzugefügt. Durch die Auswahl von relevanten Ausprägungen können die Betrachterinnen und Betrachter 
eigene Filter definieren und selbständig die Sicht auf die auszuwertenden Daten einschränken. In diesem Beispiel wurden die 
Haushalte von Alleinerziehenden mit mindestens zwei Kindern ausgewählt.  
3 
1 
2 
1

## Page 35

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
29 
Die Anzeige erfolgt in der Kopfzeile der Bildschirmausgabe (Abb. 26). Diese kann bei Bedarf mit der 
Maus vergrößert oder verkleinert werden. Ist die Liste zu lang für die Anzeige, erscheint rechts ein 
Scrollbalken. Wie bei der Auswahl von statischen Filtern können auch hier mit den Windows-üblichen 
Kombinationen <Strg>-Mausklick und <Umschalt>-Mausklick mehrere Einzelwerte oder Blöcke als 
Filtermerkmal selektiert werden (1). Hat man eine Auswahl getroffen, wird diese nach dem Anklicken 
der Schaltfläche „aktualisieren“ (2) umgesetzt und man erhält im zentralen Seitenbereich das neue 
Ergebnis. Gleichzeitig wird die Überschriftenzeile um die Angaben zu den Filterkriterien ergänzt (3). 
Hinweis: Für einen dynamischen Filter lässt sich eine Vorauswahl treffen, welche beim ersten Aufruf 
der Auswertung wirkt. So kann in dem oben gewählten Beispiel die Präsentation zunächst auf 
Haushalte mit Kindern beschränkt werden, indem für das Merkmal „Zahl der Kinder im Haushalt“ die 
Ausprägung „keine Kinder“ durch eine Vorbelegung ausgeschlossen wird (Anklicken der Ausprägung 
„keine Kinder“ in der Auswahlliste und Betätigen der Schaltfläche zum Umkehren des Filters). Die 
nachfolgend erstellte Präsentation berücksichtigt dann nur die im dynamischen Filter ausgewählten 
Ausprägungen. Die Ausprägung „keine Kinder“ bleibt jedoch zur Auswahl im Pulldown-Menü erhalten. 
Die Anwenderinnen und Anwender haben somit die Möglichkeit über den dynamischen Filter die 
vorgegebene Selektion aufzuheben und neue Sichten auf die Datei zu erstellen. 
 
7.2.1 Hierarchische Filter  
Bei der Anzeige dynamischer Filter in der Ausgabe können hierarchisch voneinander abhängige 
Merkmale miteinander verknüpft werden, wenn es eine interne Referenztabelle gibt, die die 
Verschlüsselungen der beiden Merkmale als Quell- bzw. Zielverschlüsselung besitzt. Dazu müssen sie 
bei der Auswahl direkt untereinander angeordnet werden. Das in der Hierarchie übergeordnete 
Merkmal oben, das andere darunter. Dabei können auch mehr als zwei Merkmale verkettet werden, 
wenn für das untergeordnete Merkmal wiederum ein weiteres untergeordnetes Merkmal existiert. 
 
 
Abbildung 27: Hierarchische Filter 
 
 
7.3 Gleichzeitige Nutzung von Merkmalen zur statischen und dynamischen Filterung 
Ein Merkmal, das lediglich zum dynamischen Filtern verwendet werden soll, kann auch gleichzeitig in 
beide Filterbereiche platziert werden. Bei Auswahl eines beliebigen Merkmalsobjektes außerhalb des 
Bereiches „Dynamischer Filter“ wird im rechten Fensterbereich der statische Filter angezeigt. Bei 
Auswahl eines Merkmalsobjektes innerhalb des Bereichs „Dynamischen Filter“ werden nur noch die 
Ausprägungen zur Auswahl angezeigt, die durch einen eventuell definierten statischen Filter

## Page 36

Auswertungsassistent - Anwendungshandbuch 
30 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
zugelassen wurden. Ist kein solcher vorhanden, so sind dies natürlich alle. Aus diesem kann dann eine 
Vorauswahl getroffen werden, die für den initialen Aufruf der Auswertung gilt, aber im Kontext der 
Auswertung dynamisch geändert werden kann. Für Merkmale, die zum dynamischen Filtern 
verwendet werden, werden im Kopf der Auswertung keine Angaben zum eventuell vorhandenen 
statischen Filter angegeben. Dort werden nur die dynamischen Kriterien angezeigt. 
7.4 Ausblenden von Spalten, Zeilen und Seitenmerkmal 
Hin und wieder ist es wünschenswert, „uninteressante“ Spalten oder Zeilen in einer Tabelle nicht 
anzuzeigen, ihre numerischen Werte aber in den Summen zu berücksichtigen. Hierfür müssen zunächst 
die „Optionen“ am unteren Ende des Auswertungsassistenten aufgerufen werden. Dann das 
gewünschte Merkmal anklicken, sodass es blau hinterlegt ist (1). Alle Ausprägungen eines 
Schlüsselmerkmals, die nicht über „Statischen“, bzw. „Dynamischen Filter“ ausgefiltert werden, 
können anschließend im Filterbereich per Doppelklick als „nicht sichtbar“ markiert werden (2). Das 
vorangestellte Häkchen wird dann durch ein durchkreuztes Augensymbol ersetzt (3). 
 
Abbildung 28: Ausblenden von Spalten, Zeilen und Seitenmerkmal 
7.5 Filter auf Minimal- oder Maximalwert setzen 
Bei gespeicherten Auswertungen, die z.B. Daten aus mehreren Jahren beinhalten, sollen oft nur die 
Daten des letzten Jahrgangs berücksichtigt werden. Um die Auswertung nicht jedes Mal bearbeiten zu 
müssen, wenn Daten für ein weiteres Jahr hinzugefügt werden, wurde die Möglichkeit geschaffen, das 
Filterkriterium variabel zu gestalten. 
 
Über zwei neue Schaltflächen kann festgelegt werden, ob der aktuelle Minimalwert 
oder der 
aktuelle Maximalwert 
für das jeweilige Merkmal verwendet werden soll. 
 
 
Abbildung 29: Setzen eines Minimal- oder Maximalwerts 
 
 
1 
2 
3

## Page 37

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
31 
Wird eine der Schaltflächen angeklickt, wird die Filterauswahl entsprechend angepasst und die 
manuelle Auswahl deaktiviert. 
 
 
Abbildung 30: Gesetzter Maximalwert 
 
Bei Ausführung der Auswertung wird dann mittels der Datenbankfunktion Min() bzw. Max() der 
aktuelle Filterwert festgelegt. Das Ergebnis sieht wie in Abb. 31 dargestellt aus: 
 
 
Abbildung 31: Kreuztabelle mit festgesetztem Maximalwert als statischem Filtermerkmal 
 
Die Funktionalität kann aber auch verwendet werden, um lediglich den Initialwert eines dynamischen 
Filters festzulegen.

## Page 38

Auswertungsassistent - Anwendungshandbuch 
32 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 32: Setzen eines Initialwerts für einen dynamischen Filter 
 
Die Auswertung startet dann wie folgt: 
 
 
Abbildung 33: Kreuztabelle mit festgesetztem Initialwert für einen dynamischen Filter 
 
Hinweis: In erster Linie wurde die Funktionalität eingeführt, um die in den Beispielen dargestellten Fall 
einer Zeitreihe zu unterstützen. Sie könnte aber auch in anderen Fällen nützlich sein, auch wenn sie bei 
den meisten Merkmalen nicht sinnvoll einzusetzen ist.  
 
Um die Funktionalität aber nicht nur auf bestimmte Merkmale einzuschränken, steht sie für alle nativen 
Merkmale einer Datei zur Verfügung. Das gilt mit einer Ausnahme auch für Gruppierungen. Bei 
Gruppierungen auf der Basis interner Referenztabellen, die lediglich zum Filtern eingesetzt werden, ist 
ihre Anwendung aus technischen Gründen nicht möglich, da sie direkt auf die Sachdaten wirkt. Bei 
solchen Merkmalen bleiben die Schaltflächen daher inaktiv.

## Page 39

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
33 
8. Seitenmerkmale 
Um für jede Ausprägung eines Schlüsselmerkmals eine eigene Präsentation zu erzeugen, können Sie 
das Schlüsselmerkmal dem Zielbereich „Seitenmerkmale“ (Abb. 34 (1)) zuordnen. So kann z.B. durch 
die Zuordnung des Merkmals „Haushaltstyp (HHSTAT)“ für jeden Haushaltstyp eine eigenständige 
Tabelle erstellt werden (Abb. 35). Die übrigen Merkmale, deren Ausprägungen und Werte in die 
Auswertung einfließen und dargestellt werden sollen, werden den entsprechenden Zielbereichen der 
Präsentation zugeordnet (Vorspalte: Gemeindeteil (Abb. 34 (2), Kopf: Staatsangehörigkeit im Haushalt 
(3), Wertemerkmale: Anzahl Haushalte (4)). 
 
Über das Seitenmerkmal kann zusätzlich, wie bei jedem anderen einem Zielbereich zugeordneten 
Schlüsselmerkmal auch, ein Filter gesetzt werden (5). So wurden in dem in Abbildung 22 dargestellten 
Beispiel nur die relevanten Haushaltstypen ausgewählt (deutscher Haushalt, binationaler Haushalt und 
ausländischer Haushalt).  
 
Abbildung 34: Für jede (ausgewählte) Ausprägung des zugeordneten Seitenmerkmals wird eine eigenständige Präsentation 
erstellt  
Nach einem Klick auf die „Starten“-Schaltfläche wird für jede Ausprägung des zugeordneten 
Seitenmerkmals eine eigenständige Präsentation erstellt. In der Bildschirmausgabe können die 
einzelnen Präsentationsausgaben über Reiter ausgewählt und angezeigt werden (Abb. 35 (1)). 
Alternativ kann statt der Tabs auch ein „Schieberegler“ angezeigt werden mit dem zwischen den 
unterschiedlichen Auswertungstabellen gewechselt werden kann (vgl. Kapitel 10.1.2 Seitenmerkmal). 
 
Abbildung 35: Diese Präsentation wird unter einem eigenen Reiter ausgegeben. 
1 
2 
3 
4 
5 
1

## Page 40

Auswertungsassistent - Anwendungshandbuch 
34 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Hinweis: Dem Zielbereich „Seitenmerkmal“ kann nur ein Schlüsselmerkmal zugeordnet werden.       
Unter „Optionen“ kann festgelegt werden, welche Seite standardmäßig angezeigt werden soll und ob 
eine zusätzliche Seite mit den Gesamtsummen aller Einzelseiten erzeugt werden soll.

## Page 41

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
35 
9. Konfigurationsmöglichkeiten 
9.1 Optionen 
Nach einem Klick auf die Schaltfläche „Optionen“ (1) im Fußbereich der Auswahlseite (Abb. 36) wird 
die Auswahlliste der Merkmale aus dem linken Bereich der Anzeige durch eine vom Präsentationstyp 
abhängige Optionen-Seite ersetzt (Abb. 37). Die hier gebotenen Konfigurationsmöglichkeiten sind 
ebenfalls in thematisch gegliederten Akkordeonfächern unterteilt (1). Die Inhalte der einzelnen Fächer 
lassen sich durch einen Klick auf die jeweilige Titelzeile öffnen und sind weitestgehend selbsterklärend. 
Innerhalb der einzelnen Fächer können je nach Inhalt weitere Selektionsmöglichkeiten aufgeklappt 
werden, z.B. kann im Fach „Darstellung von Schlüsseltabellen“ die Überschrift „Alle Merkmale“ 
angewählt werden, wodurch man weitere Sortier- und Selektionsmöglichkeiten zur Auswahl erhält (2).  
 
 
Abbildung 36: Ein Mausklick auf die Schaltfläche „Optionen“ im Fußbereich der Auswahlseite … 
 
 
 
 
Die verfügbaren Optionseinstellungen sind stark vom jeweiligen Präsentationstyp abhängig. Daher 
werden die Einstellmöglichkeiten bei der Beschreibung des jeweiligen Typs ausführlich beschrieben 
(vgl. Kapitel 10).  
Da jedoch bei allen Präsentationstypen Textbausteine in der Ausgabe auf der Optionenseite geändert 
werden können, werden die Möglichkeiten des Editierens im nachfolgenden Kapitel vorgezogen (vgl. 
Kapitel 9.2 und 9.3). 
2 
3 
1 
Abbildung 37: … führt dazu, dass auf die Optionenseite gewechselt wird. 
1

## Page 42

Auswertungsassistent - Anwendungshandbuch 
36 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Die vorgenommenen Optionseinstellungen bleiben im Rahmen der aktuellen Sitzung lediglich bis zur 
Auswahl einer neuen Datei erhalten. Die geänderten Einstellungen können jedoch in einer 
Konfigurationsdatei gespeichert und wieder aufgerufen werden (vgl. Kapitel 9.3). 
Durch einen Klick auf die mit dem jeweiligen Präsentationstyp beschriftete Schaltfläche (z.B. mit 
„Kreuztabelle“ beim Typ Kreuztabellen (Abb. 37 (1))) im Fußbereich der Optionenseite wird das 
Optionen-Fenster wieder geschlossen und in das entsprechende Fenster zur Merkmalsauswahl 
zurückgekehrt. 
9.1.1 Editieren von Ausgabetexten 
Durch 
den 
Aufruf 
des 
Optionen-Dialogs 
lassen 
sich 
nicht 
nur 
die 
überwiegend 
präsentationsabhängigen Konfigurationen (z.B. Darstellung von Summen in einer Kreuztabelle oder die 
Farbenfolge in einer Standardgrafik) einstellen, sondern bei Kreuztabellen, Listen und Grafiken die 
Ausgabetexte der Überschrift, der Unterüberschrift und Fußzeilen editieren (Abb. 38). Bei dem 
Ausgabetyp CSV-Export werden keine Überschriften und Fußnoten generiert und ausgegeben. Zudem 
können Merkmals- und Ausprägungsbezeichnungen bei allen Präsentationstypen bearbeitet werden. 
Um in den Präsentationstypen Kreuztabellen, Listen und Grafiken die Überschriften, 
Unterüberschriften und Fußzeilen ändern zu können, muss in den Konfigurationseinstellungen das 
Akkordeonfach „Textersetzungen“ aufgeklappt werden (1). Hier werden Textelemente der Ausgabe 
zum Überarbeiten angeboten. Dabei sind die einzelnen Textfelder mit den vom System generierten 
Inhalten vorbelegt und können nach dem Anwählen des Feldes einfach überschrieben werden (2). 
 
 
1 
2 
Abbildung 38: Unter der Option „Textersetzungen“ lassen sich die Ausgabetexte editieren. In diesem Beispiel ist der 
Textbaustein Raumbezüge geöffnet und kann überschrieben werden.

## Page 43

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
37 
Die einzelnen Textfelder entsprechen Metadatenobjekten, die bei der Generierung der Präsentation 
zu den Überschriftenzeilen zusammengesetzt werden. Eine Überschrift setzt sich dabei aus folgenden 
Textbausteinen zusammen (Abb. 39):  
 
 
Abbildung 39: Ausgabe mit entsprechenden Textersetzungen 
Tabelle aus Datei (= Seitentitel (1): In der Standardeinstellung ist dieses Textfeld leer, bzw. ein ● )  
Haushalte, Personen und Kinder nach KLG, Haushaltstypen, Haushaltsgröße, Kinderzahl, Merkmale 
der Bezugsperson 31.12.2001 (= Datei (2)) ● Freiburg, Statistische Bezirke (= Raumbezüge (3)) ● 
31.12.2011 – 31.12.2011 (= Zeitbezüge (4)) ● Einwohnermelderegister (= Erhebung (5)) Anzahl 
Haushalte nach Kleinräumige Gliederung 3-stellig (Gemeindeteil), Zahl der Personen im Haushalt (= 
Merkmale (6): Der Text wird aus den ausgewählten Wertemerkmalen (Anzahl „Wertemerkmal 1“, 
„Wertemerkmal 2“ … „Wertemerkmal n“) und den ausgewählten Schlüsselmerkmalen (nach 
„Schlüsselmerkmal 1“, „Schlüsselmerkmal 2“ … „Schlüsselmerkmal n“) zusammengesetzt) wobei 
(Haushaltstyp (HHSTAT) = Ehepaar, kein Kind, keine weitere Person oder Ehepaar kein Kind, 
mindestens eine weitere Person oder Ehepaar mindestens ein Kind keine weitere Person oder 
Ehepaar, mindestens ein Kind, mindestens eine weitere Person (=Filter (7), statischer und 
dynamische Filter werden immer mit „wobei“ eingeleitet, anschließend werden die Filterkriterien 
aufgelistet) 
Die Bausteine der Überschrift finden sich als Textfelder in den Optionseinstellungen wieder (siehe auch 
nachfolgende Aufstellung). Die Angaben in den Klammern (z.B. (<#TITLE>)) entsprechen Tags, also 
Anweisungen z.B. in einer gespeicherten Auswertungsvorschrift (vgl. Kapitel 12). Die Textfelder sind 
mit den vom System generierten Texten belegt oder leer. Die Inhalte der einzelnen Textfelder werden 
bereits beim Überfahren mit dem Mauszeiger als Tooltip angezeigt. Ein Editieren des Inhalts ist jedoch 
erst nach dem Auswählen per Mausklick möglich. Zusätzlich zu den Bausteinen der Überschrift können 
weitere Texte als „Freier Text“ und „Fußzeilen“ eingegeben werden. 
Textbausteine der Präsentationstypen Kreuztabelle und Liste 
Freier Text (<#FREE>) 
 
Textbaustein, der in der Ausgabepräsentation zusätzlich zu den 
übrigen Textmodulen eingefügt werden kann. Voraussetzung ist 
jedoch, dass der Textbaustein <#FREE> in dem Template der Präsen-
tationsausgabe berücksichtigt wurde. 
 
Hinweis: Erscheint ein hier eingetragener Text nicht in der erzeugten 
Tabelle oder Liste, wurde das Textelement nicht in dem zugrunde-
liegenden Template verwendet. Bei Bedarf ist dies mit den Adminis-
tratorinnen und Administratoren des Systems abzustimmen. 
2 
3 
4 
5 
6 
1 
7

## Page 44

Auswertungsassistent - Anwendungshandbuch 
38 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Seitentitel (<#TITLE>) 
 
Wird in das Eingabefeld kein Text eingegeben, beginnt die Über-
schrift der Präsentationsausgabe mit dem Text „Tabelle aus Datei:“. 
Durch die Eingabe eines Alternativtextes wird der vorgegebene Text 
durch diesen überschrieben. 
Dateien (<#FILES>) 
 
Die eigentliche Überschrift einer Tabelle oder Liste setzt sich aus den 
Elementen „Dateien“, „Raumbezüge“, „Zeitbezüge“ und „Erhebun-
gen“ zusammen. Insbesondere der Textbaustein „Dateien“, der die 
Quelldateien benennt, ist oftmals als Tabellen- oder Listenüber-
schrift nur bedingt geeignet und kann hier überschrieben werden. 
Raumbezüge (<#REGIONS>) 
 
Zweiter Baustein in dem vom Programm generierten Präsentations-
titel, der die Raumbezüge der zugrundeliegenden Dateien widergibt. 
Da die Auswertungsdateien jedoch häufig über mehrere räumliche 
Merkmale verfügen (z.B. Baublöcke, Statistische Bezirke, Stadtteile 
usw.), die nicht alle in der Präsentation verwendet werden, 
empfiehlt es sich oftmals, den im Titel vorgegebenen Raumbezug 
durch eine Bezeichnung zu ersetzen, die sich auf die ausgewählten 
Merkmale bezieht. 
Zeitbezüge (<#PERIODS>) 
 
Der Zeitbezug einer Datei wird immer als Zeitraum mit einem 
Anfangs- und einem Enddatum beschrieben. Dies gilt auch bei Daten, 
die sich auf einen Stichtag beziehen (z.B. Einwohnerbestand zum 
31.12.2016). Besonders in diesen Fällen empfiehlt sich ebenfalls ein 
Überschreiben des vom Auswertungsassistenten generierten Text-
bausteins. 
Erhebungen (<#SOURCES>) 
 
Der letzte Baustein des generierten Titels gibt die Datenerhe-
bung(en) (Quellen) der ausgewerteten Datei(en) wider. Dieses Text-
element kann ebenfalls mit einem möglicherweise geeigneterem 
Text überschrieben werden. 
Merkmale (<#ATTRIBUTES>) 
 
Die Textbausteine Merkmale und Filter sind die Textbausteine des 
Untertitels. Das Element „Merkmale“ setzt sich aus den ausge-
wählten Wertemerkmalen („Wertemerkmal 1“, „Wertemerkmal 2“ 
… „Wertemerkmal n“) und den ausgewählten Schlüsselmerkmalen 
(nach 
„Schlüsselmerkmal 
1“, 
„Schlüsselmerkmal 
2“ 
… 
„Schlüsselmerkmal n“) zusammen. Dieser generierte Text ist oftmals 
zu lang und bedarf der Überarbeitung. 
Filter (<#FILTERS>) 
 
Der Filtertext wird durch das Wort „wobei“ eingeleitet. Nachfolgend 
werden die Filterbedingungen aufgeführt. Da der Auswertungs-
assistent insbesondere bei komplexeren Filter, die sich auf mehrere 
Merkmale und deren Ausprägungen beziehen, oftmals sehr lange 
Beschreibungstexte generiert, empfiehlt sich hier ebenfalls ein 
Überarbeiten und Kürzen des Textes (siehe auch Abb. 40 und 41). 
Fußzeilen (<#FOOTNOTES>) 
 
Zusätzlich zu den Fußnoten, die aus den Zusatzinformationen zu den 
einzelnen ausgewählten Metadatenobjekten generiert werden (vgl. 
Kapitel 9.3), kann hier ein weiterer Text unterhalb der Präsentations-
ausgabe (Tabelle oder Liste) eingefügt werden (z.B. ein Hinweis auf 
ein Copyright). 
 
Hinweis: Die in eine Tabelle oder Liste ausgewählten Merkmale 
können über Zusatzinformationen verfügen. Diese können als 
Fußnoten oder Verweise bei der Präsentationsausgabe mit 
ausgegeben 
werden. 
Diese 
Ausgabe 
wird 
durch 
die 
Optionseinstellungen im Fach „Zusatzinformationen“ gesteuert.

## Page 45

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
39 
Diese 
Zusatzinformationen 
können 
jedoch 
nur 
ein- 
oder 
ausgeblendet und nicht editiert werden. 
 
Hinweis: Auch in den im NWS hinterlegten Zusatzinformationen sind 
HTML-Code-Ergänzungen möglich. 
 
Textbausteine der Präsentationstypen Standardgrafik (Säulen, Balken, Linien, Flächen), 
Tortendiagramm, Pyramide, Punktdiagramm, Spinnennetzdiagramm 
Diagrammtitel 
 
Der 
Diagrammtitel 
setzt 
sich 
aus 
den 
ausgewählten 
Wertemerkmalen („Wertemerkmal 1“, „Wertemerkmal 2“ … 
„Wertemerkmal n“) und den ausgewählten Schlüsselmerkmalen 
(nach „Schlüsselmerkmal 1“, „Schlüsselmerkmal 2“ … „Schlüssel-
merkmal n“) zusammen. 
Durch die Eingabe eines Alternativtextes wird der vorgegebene Text 
durch diesen überschrieben. 
 
Diagrammuntertitel 
 
Wurden bei der Auswahl der Merkmale Filter gesetzt, werden die 
Filterkriterien als Diagrammuntertitel aufgeführt. Der Filtertext wird 
durch das Wort „wobei“ eingeleitet. Nachfolgend werden die 
Filterbedingungen 
aufgeführt. 
Da 
der 
Auswertungsassistent 
insbesondere bei komplexeren Filter, die sich auf mehrere Merkmale 
und 
deren 
Ausprägungen 
beziehen, 
oftmals 
sehr 
lange 
Beschreibungstexte generiert, empfiehlt sich hier ebenfalls ein 
Überarbeiten und Kürzen des Textes (siehe auch Abb. 40 und 41). 
 
Diagrammfußnoten 
 
Zusätzlich zu den Fußnoten, die aus den Zusatzinformationen zu den 
einzelnen ausgewählten Metadatenobjekten generiert werden (vgl. 
Kapitel 9.3), kann hier ein weiterer Text unterhalb der Präsentations-
ausgabe (Tabelle oder Liste) eingefügt werden. Da bei den grafischen 
Präsentationen auf Übernahme der Textelemente „Raumbezüge“, 
„Zeitbezüge“ und „Erhebungen“ verzichtet wird, ergibt sich häufig 
der Bedarf, weitergehende Informationen zum Zeit- und Raumbezug 
der ausgewerteten Daten im Titel oder als zusätzliche Fußnote 
anzugeben. 
 
Hinweis: Zusätzlich kann bei den grafischen Präsentationen ein 
Copyright-Text eingefügt werden. Dieser zusätzliche Textbaustein 
wird allerdings nicht im Akkordeonfach „Textersetzungen“ 
vorgenommen, sondern befindet sich bei den Optionseinstellungen 
„Diagrammoptionen“ und wird daher im Kapitel 10.5.6 behandelt. 
 
Hinweis: Auch in den im NWS hinterlegten Zusatzinformationen sind 
HTML-Code-Ergänzungen möglich. 
Freier Text (<#FREE>) 
Seitentitel (<#TITLE>) 
Dateien (<#FILES>) 
Raumbezüge (<#REGIONS>) 
Zeitbezüge (<#PERIODS>) 
Erhebungen (<#SOURCES>) 
Merkmale (<#ATTRIBUTES>) 
Filter (<#FILTERS>) 
Fußzeilen (<#FOOTNOTES>) 
Die Textbausteine werden auch bei den grafischen Präsentationen 
aufgeführt. Da diese Textelemente jedoch nicht für bei der Erstellung 
der Grafiken berücksichtigt werden, sind Einträge und Änderungen 
in diesen Textfeldern hier wirkungslos. Allerdings werden hier 
vorgenommene 
Änderungen 
bei 
einem 
Wechsel 
zum 
Präsentationstyp Kreuztabelle beibehalten.

## Page 46

Auswertungsassistent - Anwendungshandbuch 
40 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Hinweis: Insbesondere die oftmals unübersichtliche Aufzählung der ausgewählten Merkmale und die 
gesetzten Filter führen zu nicht mehr lesbaren „Überschriftenungetümen“ (Abb. 40). Diese lassen sich 
durch die manuelle Überarbeitung und die Eingabe von treffenden Texten verhindern (Abb. 41). Bitte 
beachten Sie auch, dass die Textänderungen nach dem Aufruf neuer Dateien oder dem Beenden der 
Arbeitssitzung nur dann erhalten bleiben, wenn die Optionseinstellungen in einer Konfigurationsdatei 
(vgl. Kapitel 9.3) gesichert oder die Vorgaben zur Erstellung der aktuellen Präsentation insgesamt 
gespeichert werden (vgl. Kapitel 12).Um die Ausgabe eines Textbausteins komplett zu unterdrücken, 
kann man in das entsprechende Feld ein * -Zeichen einfügen. In diesem Fall wird kein Text ausgegeben.  
 
Abbildung 40: Vorher - durch die Definition eines Filters über zwei Merkmale und die Auswahl vieler Ausprägungen als 
Filterkriterien wird die aus den Beschreibungen der Metadatenobjekten zusammengesetzte Überschrift schnell 
unübersichtlich. 
 
Abbildung 41: Nachher – nach dem Bearbeiten der Textbausteine wird die Überschrift „handlicher“.

## Page 47

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
41 
9.1.2 Verwendung von HTML-Code in Ausgabetexten 
Um Cross-Site-Scripting zu verhindern werden Benutzereingaben vom ASW dahingehend bearbeitet, 
dass insbesondere darin enthaltene HTML-Tags invalidiert werden, sodass keine benutzergenerierten 
Skriptbefehle ausgeführt werden. Um aber in den Ersatztexten im Optionenbereich Textersetzungen 
das Einfügen von Links zu ermöglichen, wurde die von den Merkmalsbezeichnern und Ausprägungen 
bekannte Syntax zum Einfügen von Zeilenumbrüchen übernommen und erweitert. 
Wie bei den Merkmalsbezeichnern und Ausprägungen werden die Zeichenfolgen #br für feste und #cbr 
für bedingte Umbrüche durch das HTML-Tag <br> bzw. die HTML-Entität &shy; ersetzt. 
Zum Einfügen von Links dient die Zeichenfolge #link[...], welche die Syntax um eine Reihe von 
Parametern erweitert. Diese müssen innerhalb der eckigen Klammern angegeben werden. Damit 
können sowohl textuelle als auch grafische Links erzeugt werden.  
Hinweis: Die Verwendung von HTML-Code-Ergänzungen ist auch in den Zusatzinformationen 
anwendbar, die im NWS hinterlegt werden. 
 
Die folgende Tabelle zeigt die dafür benötigten Parameter. 
 
Name 
Bedeutung 
Beispiel 
URL 
Adresse der anzuzeigenden Ressource 
https://www.duva.de 
Text 
Bei textuellen Links obligatorisch: der Text der als Link 
angezeigt wird. 
Bei grafischen Links fakultativ: der Text der ggf. angezeigt 
wird, wenn die Grafik nicht geladen werden kann. Wird auch 
als Tooltip beim Überfahren der Grafik mit der Maus 
angezeigt. 
Dies ist ein Link! 
Style 
Hierüber können beliebige CSS-Eigenschaften eingestellt 
werden. 
padding:1em 
font-size:large 
Die folgenden Parameter gelten nur für grafische Links 
Image 
Obligatorisch. Der Name der Grafikdatei die angezeigt 
werden soll. Die Datei muss im Unterverzeichnis für 
Grafikdateien liegen. Hier ist daher nur der Dateiname 
und ggf. ein relativer Pfad anzugeben 
DUVA.png 
Links/DUVA.png 
Width 
Skaliert die Grafik horizontal (oder in beide Richtungen, 
wenn Height nicht angegeben wird). Angaben in Pixel. 
100 
Height 
Skaliert die Grafik vertikal (oder in beide Richtungen, 
wenn Width nicht angegeben wird). Angaben in Pixel. 
64 
 
Für einen textuellen Link müssen also mindestens die Parameter URL und Text angegeben werden. Die 
Parameter werden in der Form Name=Wert angegeben und durch Kommata getrennt: 
 
#link[URL=https://www.duva.de,Text=DUVA-Homepage] 
 
Für einen grafischen Link reichen die Parameter URL und Image: 
 
#link[URL=https://www.duva.de,Image=DUVA-Logo.svg] 
 
Für das Beispiel in Abb. XX wurden ein textueller und ein grafischer Link wie folgt definiert: 
 
#link[URL=https://www.duva.de,Text=DUVA-
Homepage,Style=fontsize:large] 
 
bzw.:

## Page 48

Auswertungsassistent - Anwendungshandbuch 
42 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
#link[URL=https://www.duva.de,Image=DUVA-
Logo.svg,Text=DUVAHomepage,Width=90] 
 
 
Abbildung 42: Text-Ersetzungen mit HTML-Code 
 
Die Ausgabe dazu sieht dann folgendermaßen aus: 
 
 
 
Abbildung 43: Auswertung inkl. Text-Ersetzungen mit HTML-Code 
 
9.1.3 Zusatzinformationen 
Bei Merkmalen können zusätzliche textliche Angaben als Zusatzinformationen gespeichert sein (Abb. 
44 u. 45). Das Vorhandensein dieser Zusatzinformationen wird durch ein vorangestelltes „i“ (Abb. 44 
(1)) im Merkmalsfeld angezeigt. Diese Information ist für die Interpretation der Ausgabe oftmals 
wichtig und soll daher als Fußnote mit ausgegeben werden. Durch einen Klick auf die Schaltfläche 
„Optionen“ 
im 
Fußbereich 
der 
Auswahlseite 
und 
den 
Aufruf 
des 
Akkordeonfaches 
„Zusatzinformationen“ (Abb. 44 (2)) kann die Anzeige dieser Zusatzinformationen konfiguriert werden. 
In der Grundeinstellung ist „gar nicht anzeigen“ ausgewählt. Durch einen Klick auf die Option „als 
Fußnoten anzeigen“ oder „als Verweise anzeigen“ (nur bei Kreuztabellen und Listen) werden die 
Zusatzinformationen bei der Ausgabe der gewählten Präsentation mit ausgegeben. Diese Option fehlt 
bei den Präsentationstypen Karte und CSV-Export.

## Page 49

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
43 
 
 
 
 
 
 
 
 
Bislang waren Zusatzinformationen lediglich bei nativen Merkmalen verfügbar, da sie nur im 
Nachweissystem eingepflegt werden konnten. Um im ASW auch bei berechneten Merkmalen z.B. die 
Berechnungsformel als Zusatzinformation verfügbar zu machen, ist es seit Version 4.XX möglich, bei 
allen an der Auswertung beteiligten Merkmalen eine Zusatzinformation einzugeben bzw. eine bereits 
vorhandene zu bearbeiten. 
 
1 
2 
Abbildung 45: Die Fußnoten werden nach der Aktivierung der Option „als Fußnote“ anzeigen 
unterhalb der Präsentationsausgabe angezeigt. 
1 
Abbildung 44: Hinter den „Zusatzinformationen“ verbergen sich oftmals wichtige 
Informationen, die für die Interpretation der Auswertungen wichtig sind. Sie sollen daher als 
Fußnoten in der Ausgabe erscheinen.

## Page 50

Auswertungsassistent - Anwendungshandbuch 
44 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 46: Zusatzinformationen zu nativen Merkmalen und berechneten Merkmalen 
 
Unter Optionen wird jetzt im Auswahlbereich bei allen Merkmalsobjekten das Symbol für eine 
Zusatzinformation angezeigt. Klickt man darauf, erscheint ein Eingabedialog in dem ein neuer Text 
eingegeben bzw. ein vorhandener bearbeitet werden kann: 
 
 
Abbildung 47: Eingabedialog für Zusatzinformationen I 
 
Bzw.: 
 
 
Abbildung 48: Eingabedialog für Zusatzinformationen II 
 
Soll ein Link ausgegeben werden, ist die aus dem NWS bekannte Syntax zu verwenden («...»). 
 
Wie bereits erwähnt, gilt dies für alle Merkmalsobjekte, also auch für nicht-native Merkmale wie 
berechnete Merkmale, Gruppierungsmerkmale und ähnlichen. Wurde für ein solches Merkmal ein 
neuer Text eingegeben, ist dieser anschließend auch auf der Bearbeitungsseite abrufbar wie bei 
nativen Merkmalen:

## Page 51

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
45 
 
Abbildung 49: Merkmalsauswahl mit einsehbaren Zusatzinformationen 
 
In der Auswertung werden diese Zusatzinformationen genauso ausgegeben, wie die von nativen 
Merkmalen: 
 
 
Abbildung 50: Kreuztabelle mit Zusatzinformationen eines berechneten Merkmals 
9.2 Editieren von Merkmals- und Ausprägungsbezeichnungen 
Befindet man sich auf der Seite „Optionen“, werden nicht nur die präsentationstypspezifischen 
Konfigurationsmöglichkeiten zur Auswahl angeboten, die u.a. den Umgang mit Zusatzinformationen 
regeln oder ein Ändern der Überschriften- und Unterüberschriftentexte sowie der Fußzeilen 
ermöglichen, sondern es lassen sich alle Texte zur Beschreibung von zuvor ausgewählten Merkmalen 
und deren Ausprägungen editieren (Abb. 51). Dazu wird – nach der Auswahl des Merkmals im 
Zielbereich der Präsentation – die entsprechende Bezeichnung durch einen Mausklick markiert und

## Page 52

Auswertungsassistent - Anwendungshandbuch 
46 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
einfach an der jeweiligen Position überschrieben. Diese Änderungen sind nur zur jeweiligen Laufzeit 
gültig. Ausprägungen können jedoch nur bei Schlüsseltabellen editiert werden. Bei Merkmalen des 
Typs „Identifizierender Schlüssel“ ist dies nicht möglich. Sie können jedoch mit den 
Auswertungsanweisungen gespeichert werden und finden beim Wiederaufruf der Auswertung 
Berücksichtigung (vgl. Kapitel 12). 
 
 
 
 
 
 
 
 
Durch Klicken auf die Schaltfläche „Zurücksetzen“ in der Fußzeile werden alle Einstellungen und Texte 
wieder auf ihren jeweiligen Standardwert gesetzt, solange Sie noch nicht die „Starten“-Schaltfläche 
betätigt haben. Möchte man nach Betätigen der Schaltfläche zurück zum Ausgangspunkt, müssen alle 
erfolgten Änderungen erneut editiert werden. 
 
 
9.3 Speichern und Wiederaufrufen von Optionseinstellungen 
Hinweis: Diese Funktionalität steht nur Benutzer*innen zur Verfügung, die die Berechtigung „Optionen 
bearbeiten“ besitzen. Andernfalls wird diese Option nicht angezeigt. 
Bei allen Präsentationstypen können die vorgenommenen Optionseinstellungen in der 
Metadatenbank gespeichert und wieder aufgerufen werden. Nach einem Mausklick auf die 
Schaltfläche „Optionen“ im Fußbereich der Auswahlseite (Abb. 31 (1)) wird die Auswahlliste der 
Merkmale aus dem linken Bereich der Anzeige durch einen vom Präsentationstyp abhängigen 
Optionen-Dialog ersetzt (Abb. 32). Die verschiedenen Konfigurationsmöglichkeiten sind in thematisch 
gegliederten Akkordeonfächern unterteilt. Alle Präsentationstypen verfügen dabei an oberster Stelle 
über das Fach „Konfiguration“. Hier können die in den darunterliegenden Fächern vorgenommenen 
Optionseinstellungen gespeichert und wieder aufgerufen werden. Dazu verfügt das Fach über ein 
Pulldown-Menü („aus Datenbank laden“) (Abb. 32 (2)) zum Aufruf einer gespeicherten Konfiguration 
und ein weiteres Auswahlmenü („in Datenbank speichern“) (Abb. 32 (3)) zum Sichern der aktuellen 
Optionseinstellungen. 
Nachdem die gewünschten Einstellungen, die auch für weitere Auswertungen benötigt werden, 
vorgenommen wurden, wird durch einen Klick auf die Titelzeile „Konfiguration“ das Akkordeonfach 
geöffnet. Durch einen weiteren Klick auf das Diskettensymbol („Konfiguration speichern“) öffnet sich 
ein Speicher-Dialog („Optionenkonfiguration speichern“). Dieser Dialog enthält ein Eingabefeld für den 
Namen, unter dem die Konfiguration in der Metadatenbank gespeichert werden soll. Nach Eingabe des 
gewünschten Namens und dem Betätigen der „Speichern“-Schaltfläche stehen die vorgenommenen 
Einstellungen auch für spätere Auswertungen zur Verfügung.  
Abbildung 51: In diesem Beispiel wurde der Ausprägungstext „mit Migrationshintergrund“ 
eingegeben. Der ursprüngliche Text „Migrant“ wird weiterhin beim Überfahren des Textfeldes 
mit dem Mauszeiger angezeigt.

## Page 53

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
47 
Hinweis: Benutzer*innen mit Administrationsrechten können auch die Standardoptionen ändern. Dazu 
ist 
als 
Name 
„Default“ 
(ohne 
Gliederungsebene) 
einzugeben. 
Benutzer*innen 
ohne 
Administrationsrechte bekommen bei dem Versuch eine Fehlermeldung angezeigt. 
Die aktuellen Änderungen der Konfiguration können aber auch in eine vorhandene 
Optionenkonfiguration zurückgeschrieben werden. Dazu wird in dem unteren Pulldown-Menü („in 
Datenbank speichern“) durch einen Klick am Ende des Eingabefeldes eine Auswahlliste der 
vorhandenen Konfigurationen geöffnet und die gewünschte Datei ausgewählt. 
Hinweis: Während der Vergabe eines Namens, unter der die Optionseinstellung abgespeichert werden 
soll, erscheinen nach der Eingabe der ersten Buchstaben ggf. die Namen bereits vorhandener 
Konfigurationsdateien, die mit derselben Zeichenkette beginnen, in einer Auswahlliste. Durch die 
Auswahl eines in der Liste vorhandenen Namens kann eine vorhandene Datei mit den aktuell 
vorgenommenen Einstellungen überschrieben werden. Um keine benötigten Einstellungen zu 
überschreiben, sollten man hier mit Bedacht vorgehen. 
Hinweis: Nicht alle Konfigurationen passen für alle Präsentationen.

## Page 54

Auswertungsassistent - Anwendungshandbuch 
48 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
10. Präsentationstypen 
Der DUVA-Auswertungsassistent unterstützt die metadatengestützte Generierung von verschiedenen 
Präsentationstypen: Dabei kann zwischen textorientierten Präsentationstypen wie Kreuztabelle 
(Standardtabelle), Interaktive Tabelle (mit erweiterten Filter- und Sortiermöglichkeiten), Liste 
(Auflistung von Einzelfällen) und CSV-Export (Export der zur ausgewählten Datei gehörenden 
Sachdatentabelle) sowie grafischen Präsentationen wie Standardgrafik (Balken, Säulen, Linien, 
Flächen), Tortendiagramm, Pyramide und Karte gewählt werden. Die Auswahl der unterschiedlichen 
Präsentationstypen erfolgt auf der Auswahlseite „Präsentationstyp“ (vgl. Kapitel 5). Nach der Auswahl 
des gewünschten Präsentationstyps wird die entsprechende Merkmalsauswahl gestartet. Hier werden 
die Merkmale ausgewählt und Zielbereichen der Präsentation (z.B. Vorspalte und Tabellenkopf der 
Kreuztabelle oder Datenachse und Rubrikenachse bei der Standardgrafik) zugeordnet. Die Zielbereiche 
der unterschiedlichen Präsentationstypen sind in Anlehnung an die Struktur der Ausgabe angeordnet. 
Dies ist keine Vorschau, vermittelt aber einen Eindruck auf die zu erstellende Präsentation. 
Hinweis: Werden Zahlen in der Datenbank-Tabelle mit mehr Nachkommastellen gespeichert, als in der 
Darstellung des ASW verwendet werden, dann rundet der ASW. (Die Zahl der Nachkommastellen ist 
über Optionen für jedes Wertemerkmal einstellbar, vgl. Abschnitt 10.1.2, 10.2.2, 10.3.2 oder 10.5.6) 
Als Rundungsverfahren wird das sog. Kaufmännische Runden im Gegensatz zum Symmetrischen 
Runden (vgl. https://de.wikipedia.org/wiki/Rundung) angewendet. 
Ein Beispiel zur Verdeutlichung: 
Datenbank-Tabelle mit 2 NK 
Gerundete Darstellung im ASW mit 1 NK 
3,47 
3,5 
3,44 
3,4 
 
Hinweis: Auch nach der Auswahl von Schlüssel- und Wertemerkmalen sowie dem Definieren von Filtern 
kann der ausgewählte Präsentationstyp gewechselt werden. Klicken Sie dazu im Fußbereich der 
Merkmalsauswahlseite auf die Schaltfläche „Typ ändern“ (Abb. 40 (11)) und kehren Sie so zur Auswahl 
des Präsentationstyps zurück, um eine andere Darstellungsform zu wählen. Das besondere bei dieser 
Vorgehensweise Im Gegensatz zum Aufrufen über die Brotkrümelzeile ist, dass die bereits 
ausgewählten Schlüssel- und Wertemerkmale, gesetzte Filter, Berechnungsdefinitionen usw. bleiben 
erhalten und werden – sofern möglich – dem neu ausgewählten Präsentationstyp sinnvoll zugeordnet. 
Dies ermöglicht Ihnen ein Umschalten und Ausprobieren zwischen den unterschiedlichen 
Darstellungsmöglichkeiten, ohne jedes Mal die Auswahl von vorn beginnen zu müssen. 
Im Folgenden werden die unterschiedlichen Ausgabemöglichkeiten vorgestellt.

## Page 55

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
49 
10.1 Kreuztabelle 
10.1.1 Besonderheiten bei der Merkmalsauswahl und -positionierung 
Die wohl häufigste Ausgabeform ist die Tabelle. Nach einem Klick auf die Schaltfläche „Kreuztabelle“ 
auf der Seite „Präsentationstyp“ (vgl. Kapitel 5) wird die Seite zur Auswahl der Merkmale geladen und 
zur Festlegung der Tabellenoptionen (vgl. Kapitel 6 - 9). 
Im linken Auswahlbereich dieser dreigeteilten Seite werden die in den ausgewählten Dateien 
enthaltenen Merkmale angezeigt und zur Auswahl angeboten (Abb. 52 (1)). Durch einen Mausklick auf 
die Titelzeile des jeweiligen Faches lässt sich zwischen der Anzeige der Schlüsselmerkmale (1) und der 
Wertemerkmale (2) umschalten. 
 
 
Abbildung 52: Merkmalsauswahl für eine Kreuztabelle 
Im zentralen Auswahlbereich werden die Zielbereiche Vorspalten- (3), Kopf- (4) und Wertemerkmale 
(5) dargestellt. Darüber sind die Filterbereiche „statischer Filter“ (6) und „dynamischer Filter“ (7) sowie 
der Zielbereich für die Seitenmerkmale (8) angeordnet. 
Der rechte Auswahlbereich dient der Anzeige der Ausprägungen des jeweils durch Mausklick 
aktivierten Merkmals (9) und der Auswahl der Filterausprägungen (vgl. Kapitel 7). 
Aus dem linken Auswahlbereich können Schlüsselmerkmale in den jeweiligen Zielbereich der 
Kreuztabelle gezogen werden, in dem das Merkmal dargestellt werden soll. Dazu wird das gewünschte 
Merkmal angeklickt und bei gehaltener Maustaste an die gewünschte Position (z.B. in den Bereich für 
den Tabellenkopf) gezogen und dort durch Loslassen der Maustaste abgelegt. Wo ein Merkmal 
angeordnet werden kann, wird beim Überfahren der Zielbereiche durch die Veränderung des 
jeweiligen Rahmens angezeigt. Kann ein Merkmal (z.B. das Schlüsselmerkmal „Geschlecht“) einem 
Bereich zugeordnet werden, wird der feingestrichelte Zielbereich bei Überfahren mit dem gehaltenen 
Merkmal in eine stärkere Strichlinie geändert (10). 
1 
2 
3 
4 
5 
6 
7 
8 
9 
10 
11 
12

## Page 56

Auswertungsassistent - Anwendungshandbuch 
50 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Nach dem Ablegen eines Schlüsselmerkmals im gewünschten Zielbereich werden die 
Beschreibungstexte der ersten und der letzten Ausprägung des Merkmals im Tabellenkopf oder der 
Vorspalte angezeigt. Das ist keine „echte“ Vorschau, erlaubt aber zusammen mit der Anzeige 
sämtlicher Ausprägungen im rechten Filterbereich eine Vorstellung von dem zu erwartenden Umfang 
der Kreuztabelle (4). 
Grundsätzlich können jeweils mehrere Schlüsselmerkmale in der Vorspalte oder dem Tabellenkopf 
angeordnet werden, wobei die Position innerhalb der Hierarchie des Tabellenkopfes oder der 
Vorspalte davon abhängt, wie das Merkmal zu den bereits vorhandenen Merkmalen positioniert wird 
(Abb. 53 und 54 resp. 55 und 56). 
Soll z.B. ein zweites Merkmal für den Tabellenkopf ausgewählt werden, kann dieses entweder rechts, 
links, ober- oder unterhalb vom ersten Merkmal platziert werden. Die Positionierungsmöglichkeiten 
im Tabellenkopf werden beim Überfahren mit dem vom Mauszeiger gehaltenen zweiten Merkmal 
durch orangefarbene Randmarkierungen bei dem bereits im Zielbereich vorhandenen Merkmal 
angezeigt (Abb. 53 (1)). Dabei entscheidet die Positionierung, ob ein Tabellenkopf hierarchisch oder 
gereiht aufgebaut wird. Ein „Andocken“ des zweiten Merkmals ober- oder unterhalb des ersten führt 
dazu, dass der Kopf der Tabelle hierarchisch gegliedert wird (2), wobei das untenliegende Merkmal mit 
seinen Ausprägungen die Ausprägungen des darüber liegenden Merkmals weiter differenziert (Abb. 
54 (3)). 
 
 
 
1 
Abbildung 53: Anordnung von Schlüsselmerkmalen untereinander 
2

## Page 57

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
51 
 
 
 
Abbildung 54: Das Schlüsselmerkmal „Geschlecht der Bezugsperson“ wird als zweites Merkmal in den Zielbereich des 
Tabellenkopfes gezogen.  
Durch die Positionierung eines zweiten Merkmals rechts oder links vom ersten (Abb. 55 (1)) werden 
die Ausprägungen der Merkmale nicht hierarchisch gestaffelt, sondern hintereinander im Tabellenkopf 
angeordnet (2), wobei die Ausprägungen des rechten Merkmals hinter denen des linken Merkmals 
angefügt werden (Abb. 54 (3)). 
 
 
 
Abbildung 55: Anordnung von Schlüsselmerkmalen hintereinander 
3 
1 
2

## Page 58

Auswertungsassistent - Anwendungshandbuch 
52 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
 
Abbildung 56: Das Schlüsselmerkmal „Geschlecht der Bezugsperson“ soll vor dem ersten Merkmal „Haushaltstyp…“ 
positioniert werden.  
 
Weitere Merkmale lassen sich dem Tabellenkopf nur noch entsprechend der Anordnung des zweiten 
Merkmals hinzufügen, wobei weitere Merkmale auch zwischen bereits vorhandenen positioniert 
werden können. 
Bereits ausgewählte und positionierte Merkmale lassen sich innerhalb des Tabellenkopfes und der 
Vorspalte sowie zwischen Kopf- und Vorspaltenbereich verschieben, indem sie angeklickt und bei 
gehaltener Maustaste an die gewünschte Position im Verhältnis zu bereits im Zielbereich vorhandenen 
Merkmalen positioniert werden. 
Enthält die für die Auswertung ausgewählte Datei lediglich ein Wertemerkmal (z.B. ein Zählfeld), wird 
dieses automatisch in den Wertebereich der Kreuztabelle übernommen. Ist mehr als ein 
Wertemerkmal in der Datei vorhanden, muss mindestens eines ausgewählt und zugeordnet werden, 
bevor die Erstellung der Kreuztabelle gestartet werden kann. Die Zuordnung erfolgt – wie bei den 
Schlüsselmerkmalen – durch Anklicken in der Auswahlliste und Ziehen bei gehaltener Maustaste in den 
durch die Bezeichnung „Wertemerkmale“ gekennzeichneten Zielbereich der Präsentation. 
Auch hier können mehrere Wertemerkmale ausgewählt und im Zielbereich positioniert werden. Ist 
bereits ein Wertemerkmal in den Wertebereich einer Kreuztabelle ausgewählt, kann ein weiteres 
Merkmal an diesem angeheftet werden. Die möglichen „Andock“-Positionen werden beim Überfahren 
mit einem zweiten Merkmal ebenfalls durch orangefarbene Randmarkierungen am ersten Merkmal 
angezeigt (Abb. 57 (1)). Ein Anheften ober- oder unterhalb des zuerst ausgewählten Merkmals führt 
dabei zu einer Anordnung der Werte untereinander und der Übernahme der Beschreibungstexte in 
der Vorspalte. Die Zuordnung des zweiten Merkmals rechts oder links vom ersten Merkmal bewirkt, 
dass die Werte nebeneinander in verschiedenen Spalten dargestellt und die dazugehörigen 
Beschreibungen in den Tabellenkopf übernommen werden (Abb. 58 (3)). 
3

## Page 59

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
53 
 
 
 
Abbildung 57: Anordnung von Wertemerkmalen hintereinander 
 
 
Abbildung 58: Das Wertemerkmal „Anzahl der Personen…“ wird als zweites Merkmal dem Zielbereich „Wertemerkmale“ 
hinzugefügt.  
 
 
1 
2 
3

## Page 60

Auswertungsassistent - Anwendungshandbuch 
54 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Nach dem Positionieren des zweiten Wertemerkmals lassen sich weitere Wertemerkmale nur noch 
entsprechend der Anordnung des zweiten Merkmals hinzufügen. Wurde das zweite Wertemerkmal 
z.B. hinter dem ersten angeordnet, lassen sich alle weiteren Merkmale nur noch vor, zwischen oder 
hinter den bereits ausgewählten Merkmalen positionieren. 
 
Hinweis: Durch das Betätigen der „Übernahme“-Schaltfläche (Pfeil-Symbol) in der Titelzeile des 
Akkordeonfaches „Wertemerkmale“ (Abb. 52 (12)) werden alle Wertemerkmale mit einem Mausklick 
in die Auswahl übernommen und dort nebeneinander positioniert. Somit werden die Tabellenspalten – 
entsprechend der Anzahl der zugeordneten Wertemerkmale – weiter unterteilt und die Tabelle erhält 
eventuell eine für eine übersichtliche Darstellung zu hohe Anzahl an Tabellenspalten. Dann empfiehlt 
es sich, die Wertefelder nicht neben- sondern untereinander anzuordnen. Dies geschieht durch die 
Betätigung des „Doppelpfeil“, er befindet sich direkt neben der „Übernahme“-Schaltfläche, dem 
einfachen Pfeil-Symbol. Die Anordnung der „Wertmerkmale“ in der Tabelle wird so von horizontal auf 
vertikal bzw. von vertikal auf horizontal getauscht. 
 
10.1.2 Konfigurationsmöglichkeiten für den Präsentationstyp Kreuztabelle 
Durch einen Klick auf die Schaltfläche „Optionen“ im Fußbereich der Auswahlseite können folgende 
präsentationsabhängige Einstellungen vorgenommen werden (vgl. Kapitel 9): 
 
Konfiguration 
Speicherung von Konfigurationen 
Die in den Optionen vorgenommenen Einstellungen bleiben 
erhalten bis zur Auswahl einer anderen Datei. Sie lassen sich 
jedoch speichern und wieder aus der Datenbank laden. 
 
 
 
Tabelleneigenschaften 
Seitenbreite 
(1) Mit der Seitenbreite lässt sich die Breite der Tabelle 
innerhalb des Ausgabefensters festlegen. Die Festlegung der 
Größe kann über Prozent, rem und Pixel festgelegt werden. 
Spaltensummen anzeigen/ 
Zeilensummen anzeigen 
 
Mit dieser Option können (2) Spalten- und Zeilensummen (3) 
angezeigt werden. Enthält die zu erstellende Tabelle mehr als 
eine Tabellenspalte und/oder -zeile, werden die Randsummen 
1 
2 
3 
4 
5 
6 
7

## Page 61

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
55 
 
automatisch berechnet und in separaten Summenspalten 
und/oder Summenzeilen ausgegeben. In der Grundeinstellung 
wird die Spaltensumme unten und die Zeilensumme rechts 
ausgegeben. Durch das Versetzen des entsprechenden 
Punktes wird die Gesamtsumme oben und die Zeilensumme 
links ausgegeben.  Soll die Ausgabe dieser Randsummen 
unterdrückt werden, sind hier die Haken zu entfernen. 
Bei Gruppierungen, die nur eine einzelne Zeile bzw. Spalte 
umfassen, wird die Ausgabe redundanter Summen (seit 
Version 4.13) automatisch unterdrückt. 
Hinweis: In Dateien können aus datenorganisatorischen 
Gründen oder zur Vereinfachung geplanter Auswertungen 
bereits Anteilswerte enthalten sein. Auch diese Prozentwerte 
werden summiert, was zu unsinnigen Ergebnissen führt. Hier 
sollte auf die Anzeige von Spalten- bzw. Zeilensummen 
verzichtet werden. Im Gegensatz dazu werden bei berechneten 
Merkmalen nicht die Randsummen berechnet, sondern die 
Berechnungsformel auch auf die Summen der einzelnen 
Variablen angewendet (vgl. Kapitel 6.6). 
Anonymisierung kleiner Werte 
Im Rahmen der Geheimhaltung wurde die Möglichkeit 
geschaffen, in Kreuztabellen kleinere Werte bis zu einem 
vorgegebenen Schwellwert nicht auszugeben. Stattdessen 
wird ein ebenfalls vorzugebender Ausgabetext angezeigt. Die 
benötigten Angaben können unter (4) eingegeben werden. 
Dabei ist zu beachten, dass bei der Ausgabe von Summen die 
einzelnen, eigentlich anonymisierten Werte innerhalb von 
Spalten bzw. Zeilen ggf. zurückgerechnet werden können. 
Für eine reine HTML-Ausgabe können auch HTML-Entitäten 
wie z.B. &bullet; als Ausgabetext verwendet werden. Bei 
Spreadsheet- oder CSV-Exporten werden diese aber nicht 
interpretiert. 
Sortierschalter anzeigen 
 
Durch die Aktivierung der Option „Sortierschalter anzeigen“ (5) 
werden in der Tabellenausgabe zusätzlich Sortierschalter zum 
aufsteigenden und absteigenden Sortieren der Vorspalte 
sowie der Werte zur Verfügung gestellt. Die Sortierung der 
Vorspalte erfolgt lexikalisch, auch bei numerischen Angaben 
(1, 10, 11, … 19, 2, 20 usw.). Tabellenwerte dagegen werden 
entsprechend ihres numerischen Wertes sortiert. 
Tabelle umbrechen nach … 
Spalten 
 
In der Grundeinstellung wird die Tabelle nach 10 Spalten 
umgebrochen (6). Durch das Überschreiben des Wertes „10“ 
im Eingabefeld mit einem anderen Wert wird die Tabelle nach 
der eingegebenen Anzahl der Spalten umgebrochen und in 
untereinander angeordneten Teiltabellen angezeigt. Dies ist 
bei umfangreichen Tabellen mit einer großen Anzahl an 
Spalten hilfreich, um horizontales Scrollen zu vermeiden. 
Breite der Vorspalte in Prozent: … 
 
Die Breite der Vorspalte (7) ist konfigurierbar. Die 
Standardbreite wird automatisch festgelegt, kann aber 
individuell festgelegt werden.  
Bei automatischer Vorspaltenbreite erfolgt die Festlegung der 
Breite aufgrund ihres Inhalts.

## Page 62

Auswertungsassistent - Anwendungshandbuch 
56 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Darstellung Schlüsselmerkmale 
Die Darstellung von Schlüsseltabellen kann sowohl generell für 
alle ausgewählten Schlüsselmerkmale als auch für die einzelnen 
Wertemerkmale eingestellt werden (7). 
Gesamtsumme anzeigen 
 (8) Durch das Setzen eines Hakens wird die Gesamtsumme des 
einzelnen Merkmals oder aller Merkmale angezeigt. Diese 
Funktion ist erst ab mehr als einem Merkmal pro Merkmalsfeld 
relevant. Öffnet man ein einzelnes Merkmal, kann hier die 
Gesamtsumme für das jeweilige Merkmal beschriftet werden. 
Genaueres dazu ist im folgenden Kapitel 10.1.3 nachzulesen. 
Zwischensumme anzeigen 
(9) 
Durch 
das 
Setzen 
eines 
Hakens 
werden 
die 
Zwischensummen der Merkmale innerhalb der Tabelle 
angezeigt. Diese Funktion ist bei nur einem Merkmal pro 
Merkmalsfeld irrelevant. Sie wird erst bei mehr als einem 
Merkmal in mindestens einem Merkmalsfeld wirksam (bspw. 
zwei Kopfmerkmale). Öffnet man ein einzelnes Merkmal, kann 
hier die Zwischensumme für das jeweilige Merkmal beschriftet 
werden. Genaueres dazu ist im folgenden Kapitel 10.1.3 
nachzulesen.  
Sortierreihenfolge: 
In Originalreihenfolge/ nach 
Schlüsseln sortiert/ nach 
Ausprägungen sortiert/ 
benutzerdefiniert 
 
Die Ausprägungen der Schlüsselmerkmale können in der 
Tabellenausgabe 
sortiert 
werden 
(10). 
Neben 
der 
Originalreihenfolge, die sich an der Beschreibung der 
Schlüsseltabelle im DUVA-Nachweissystem orientiert, kann die 
Ausgabe entweder nach den in der Schlüsseltabelle vergebenen 
Schlüsseln oder nach den Ausprägungstexten sortiert werden.  
Die Sortierung erfolgt lexikalisch, d.h. „numerische“ Angaben 
werden wie Texte behandelt (Sortierreihenfolge 1, 10, 11, … 19, 
2, 20 usw.). 
Mit der Sortierreihenfolge „benutzerdefiniert“ kann der 
Benutzer die Reihenfolge der Merkmale in der Ausgabetabelle 
selbst festlegen. Nachdem der Punkt bei „benutzerdefiniert“ 
gesetzt wurde, kann ein Merkmal in der mittleren 
Auswahlfläche (Merkmaltabelle) ausgewählt werden. Das nun 
aktive/blau hinterlegte Merkmal erscheint mit seinen 
Ausprägungen 
in 
der 
Spalte 
ganz 
rechts 
im 
Auswertungsassistent. 
Jetzt 
die 
Schaltfläche 
für 
den 
7 
11 
12 
13 
14 
15 
8 
9 
10

## Page 63

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
57 
Bearbeitungsmodus (Stift-Symbol) oben rechts aktivieren. Nun 
kann die Reihenfolge der Ausprägungen des Merkmals per Drag 
& Drop beliebig geändert werden. 
 
Mit dem danebenliegenden Pfeil-Symbol kann die gesamte 
Veränderung der Reihenfolge wieder rückgängig gemacht 
werden. 
Ausprägungen ausblenden 
Ist bei der Sortierreihenfolge „benutzerdefiniert“ ausgewählt, 
besteht 
auch 
die 
Möglichkeit 
einzelne 
Ausprägungen 
auszublenden. Gehen Sie hierbei zunächst so vor, wie für die 
benutzerdefinierte Sortierung beschrieben. Wenn Sie im 
Bearbeitungsmodus sind, können Sie mittels Doppelklicks auf 
den 
vorangestellten 
Haken 
die 
jeweilige 
Ausprägung 
ausblenden. 
 
Sortierung aufsteigen/absteigen 
(11) Die Funktion legt fest, ob mit der niedrigsten oder der 
höchsten Ausprägung/Schlüssel in der Tabelle der Ausgabe 
begonnen werden soll. 
Umfang der Darstellung: 
nur Ausprägungen/ nur 
Schlüssel/ beides zusammen/ 
beides in separaten Spalten 
 
In der Standardeinstellung werden die Ausprägungstexte ohne 
die dazugehörenden Schlüssel ausgegeben (12). Darüber hinaus 
kann festgelegt werden, ob in der Tabelle nur Schlüssel oder 
beides – Schlüssel und Ausprägungstexte – angezeigt werden 
sollen. Sollen Texte und Schlüssel angezeigt werden, ist 
festzulegen, ob beides in einer oder in getrennten Spalten 
auszugeben ist. 
Ausprägungen gruppieren 
(13) 
Durch 
das 
Setzen 
eines 
Hakens 
erhält 
jedes 
Zwischensummenfeld und das Kopffeld eines gruppierbaren 
Merkmals in der Ausgabetabelle ein Plus- bzw. Minuszeichen im 
oberen rechten Eck. Durch Klicken auf das Pluszeichen wird das 
Merkmal eingeklappt, bei Klicken auf das Minuszeichen wird 
das Merkmal ausgeklappt. Dieser Vorgang kann je nach Größe 
der Tabelle einige Momente in Anspruch nehmen. Diese 
Funktion ist so auch bei Microsoft Excel zu finden. 
Initial geschlossen 
(14) Diese Funktion ergibt nur in Kombination mit „Ausprägung 
gruppieren“ (13) Sinn. Wird der Haken bei „initial geschlossen“ 
gesetzt sind in der Tabelle der Auswertung alle Gruppen zu 
Beginn geschlossen. Sie können dann durch Klicken auf das 
Pluszeichen ausgeklappt werden. Dies kann vor allem bei 
großen und in voller Größe unübersichtlichen Tabellen sehr 
hilfreich sein.

## Page 64

Auswertungsassistent - Anwendungshandbuch 
58 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
alle Ausprägungen anzeigen 
(nicht für Einzelmerkmale) 
 
Ist diese Option durch das Setzen eines Hakens in dem 
Kontrollkästchen aktiviert (15), werden auch die Ausprägungen 
in der Tabelle angezeigt, für die keine Werte existieren. Durch 
Filter von der Auswertung ausgeschlossene Ausprägungen 
werden allerdings nicht angezeigt sondern bleiben unterdrückt. 
 
 
 
Darstellung Wertmerkmale 
Die Darstellung von numerischen Werten kann ebenfalls 
generell für alle ausgewählten Wertemerkmale oder für die 
einzelnen ausgewählten numerischen Wertemerkmale (16) 
eingestellt werden.  
 
Hier kann auch das Tausendertrennzeichen (21) aktiviert 
werden. Dessen spezifisches Aussehen lässt sich in Allgemeine 
Optionen 
festlegen; 
standardmäßig, 
gemäß 
Servereinstellungen, ist es der Punkt.  
Fehlender Wert 
In das Eingabefeld „fehlender Wert“ (17) kann eine beliebige, 
maximal 20-stellige Zeichenkette eingetragen werden, mit der 
fehlende Datensätze in Kreuztabellen gekennzeichnet werden. 
Als Standard ist hier „-“ vorgegeben. 
Maßeinheit 
Hier kann eine Maßeinheit (18), welche in der Auswertung 
angezeigt wird, hinterlegt werden.  
Darzustellende Werte: 
absolute Werte/ 
Spaltenprozente/ 
Zeilenprozente 
 
Die standardmäßig aktivierten Absolutwerte können durch die 
Ausgabe von Zeilen- und/ oder Spaltenprozente ergänzt oder 
ausgetauscht werden (19). 
Gibt es lediglich ein Wertemerkmal, kann eine Anordnung 
zwischen untereinander und nebeneinander gewählt werden. 
Anderenfalls folgen sie der Anordnung der Wertmerkmale,  um 
zu verhindern, dass leere Felder in der Tabelle entstehen. 
 
Tausendertrennzeichen 
 
In der Grundeinstellung werden große Absolutwerte nicht 
durch einen Tausenderpunkt gegliedert (21). Dies kann in 
Darstellung Wertmerkmale aktiviert oder deaktiviert werden. 
Das Trennzeichen erhöht die Lesbarkeit der Ausgabetabelle. Ist 
das Tausendertrennzeichen nicht erwünscht, kann es dort 
unterdrückt werden. Dies kann erforderlich sein, wenn ein 
Export der Ausgabe als CSV-Datei geplant ist. Weiter kann das 
Tausendertrennzeichen 
in 
den 
Allgemeinen 
Optionen 
bearbeitet werden (im weiteren Verlauf der Tabelle (36)). 
 
Nachkommastellen 
In 
der 
Grundeinstellung 
„automatisch“ 
werden 
die 
Nachkommastellen der Absolutwerte entsprechend angepasst. 
16 
21 
17 
18 
22 
19 
20

## Page 65

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
59 
In den meisten Fällen bedeutet dies keine Nachkommastellen. 
Prozentwerte 
erhalten 
in 
der 
Grundeinstellung 
eine 
Nachkommastelle (22). Sollen die Tabellenwerte davon 
abweichende Nachkommastellen aufweisen, können sie hier in 
die dafür vorgesehenen Eingabefelder getrennt für Absolut- 
und Prozentwerte eingegeben werden (0 – 9 und automatisch) 
Hinweis: Unter Prozentwerten werden lediglich die vom DUVA-
Auswertungsassistenten 
errechneten 
Zeilen- 
und 
Spaltenprozente verstanden (siehe oben). Das bedeutet, dass in 
der 
Datei 
enthaltene 
Anteilswerte 
sowie 
berechnete 
Wertemerkmale (vgl. Kapitel 6.6) hier wie Absolutwerte 
behandelt werden. Während es sich bei berechneten Werten 
(insb. bei Anteilswerten) empfiehlt, die Zahl der gewünschten 
Nachkommastellen vorzugeben, kann bei Werten, die bereits in 
der Datei enthalten sind auch die Einstellung „automatisch“ 
gewählt 
werden. 
In 
diesem 
Fall 
kann 
Anzahl 
der 
Nachkommastellen zwischen den Werten variieren. 
 
 
Filterbereich 
Die Konfigurationsmöglichkeit „Filter“ erscheint nur wenn 
mindestens ein „Dynamischer Filter“ gesetzt wurde  
 
Filterbereich: Maximale Höhe 
Die maximale Höhe des Filterbereiches (23) kann für jede 
Anwendung separat eingestellt werden. Es kann dabei gewählt 
werden, ob die Höhe absolut in Pixel oder relativ zur 
Gesamthöhe des Ausgabebereiches in Prozent erfolgen soll. 
Die relative Angabe ist auf maximal 80 % beschränkt.  
Filterbereich: anfangs ausblenden 
Darüber hinaus kann festgelegt werden, ob die gewählten Filter 
in der Ausgabe zunächst zugeklappt sein sollen. Hierzu muss 
der Haken gesetzt werden. Sie können dann in der Ausgabe 
wiederum ausgeklappt werden.  
Verknüpfen: 
Sollte mehr als ein „Dynamischer Filter“ ausgewählt worden 
sein, so wird die Option „Verknüpfen“ angezeigt. Hierzu muss 
der Haken in der Checkbox gesetzt werden. Die Checkbox wird 
jedoch nur angezeigt, wenn eine interne Referenztabelle 
vorliegt, über die eine hierarchische Verknüpfung möglich ist. 
 
23 
24 
25

## Page 66

Auswertungsassistent - Anwendungshandbuch 
60 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Seitenmerkmal 
 
Die Konfigurationsmöglichkeit „Seitenmerkmal“ erscheint nur, 
wenn ein Schlüsselmerkmal als Seitenmerkmal gesetzt wurde. 
Durch ein Seitenmerkmal wird nicht nur eine Tabelle 
ausgegeben, 
vielmehr 
werden 
je 
nach 
Anzahl 
der 
Ausprägungen 
des 
Seitenmerkmals 
mehrere 
Tabellen 
bereitgestellt. Es wird aber immer nur eine Tabelle angezeigt. 
Das Wechseln der Tabellen erfolgt über die hier beschriebenen 
Möglichkeiten der Seitenwahl  
 
 
Seitenwahl mittels Tabs/ 
Schieberegler oberhalb/unterhalb 
(26) Seitenwahl mittels Tabs ist als Standardeinstellung 
gegeben. In der Ausgabe kann dann durch Mausklick auf den 
jeweiligen Tab die gewünschte Tabelle nach Ausprägungen des 
Seitenmerkmals angezeigt werden.  
Durch 
Versetzen 
des 
Punktes 
zu 
Schieberegler 
oberhalb/unterhalb erscheint in der Ausgabe ein blauer 
Schieberegler. Mit ihm kann zwischen den unterschiedlichen 
Tabellen gewechselt werden. 
 
Animationsintervall 
(27) Durch die Eingabe eines Animationsintervalls wechselt die 
Ausgabe automatisch die Tabelle nach Ablauf der eingegeben 
Zeit (in Sekunden). 
Tab mit Gesamtwerten anzeigen 
Das Seitenmerkmal erscheint unter den Optionen nur, wenn 
ein Schlüsselmerkmal in das Auswahlfeld Seitenmerkmal 
gezogen wurde. Zu den Einzelwerten können in einem Tab 
auch noch die Gesamtwerte angezeigt werden; dazu muss Tab 
mit Gesamtwerten anzeigen angeklickt sein. (28) 
Standardseite 
In den Optionen kann dann festgelegt werden, welche Seite 
der in Tabs angeordneten Ergebnisseiten zuerst angezeigt 
wird. Standardmäßig ist Letzte Seite eingestellt. (29) 
 
 
Zusatzinformationen 
Zusatzinformationen: 
als Fußnoten anzeigen/ 
als Verweise anzeigen/ 
gar nicht anzeigen 
Bei den Merkmalen gespeicherte Zusatzinformationen 
können bei der Ausgabe der Kreuztabelle mit ausgegeben 
werden (vgl. Kapitel 9.2). In der Grundeinstellung ist „gar 
nicht anzeigen“ ausgewählt (30). Durch einen Klick auf die 
Option „als Fußnoten anzeigen“ oder „als Verweise 
anzeigen“ 
(nur 
bei 
Kreuztabellen) 
werden 
die 
Zusatzinformationen bei der Ausgabe der gewählten 
Präsentation mit ausgegeben. 
dynamische Fußnoten auswerten 
Unter 
Umständen 
sind 
Wertemerkmalen 
weitere 
Informationen zugeordnet, diese können durch ein 
Aktivieren der Schaltfläche „dynamische Fußnoten 
26 
27 
28 
29 
30 
31

## Page 67

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
61 
auswerten“ mit ausgegeben werden (31). Eine Anzeige im 
Tabellenblatt erfolgt aber nur, wenn Fußnoten generell 
angezeigt werden (30). 
 
Export 
Excel-Exportdatei erzeugen 
 
  
 
Durch die Aktivierung der Option „Excel-Exportdatei 
erzeugen“ (32), wird eine binäre Datei erzeugt, die von 
einer Tabellenkalkulation – z.B. Microsoft Excel (XLS, XLSX) 
oder OpenOffice (ODS) – direkt eingelesen werden kann. 
Unter der Bildschirmausgabe der Kreuztabelle wird ein 
entsprechendes Symbol zum Herunterladen der Datei 
platziert. Werden durch die Auswahl eines Seitenmerkmals 
mehr als eine Tabellenseite produziert, so wird eine Datei 
mit mehreren Worksheets erzeugt. Wird der Haken „Eine 
Datei pro Seite“ gesetzt, so wird für jede Ausgabeseite eine 
eigene Exportdatei erzeugt (vgl. Kapitel 8).  
CSV-Datei erzeugen 
 
 
Durch die Aktivierung der Option „CSV-Datei erzeugen“ 
(33) wird direkt eine CSV-Datei der aktuellen tabellarischen 
Auswertung unter Berücksichtigung der Merkmalsauswahl 
und 
Filter 
erstellt. 
Diese 
wird 
unterhalb 
der 
Bildschirmausgabe zum Download angeboten. CSV-
Dateien (Comma-separated Values) sind Textdateien, die 
dem Austausch von Daten auf verschiedenen Systemen 
bzw. unter verschiedenen Programmen dienen. Werden 
durch die Auswahl eines Seitenmerkmals mehr als eine 
Tabellenseite produziert, wird für jede Ausgabeseite eine 
eigene Exportdatei erzeugt (vgl. Kapitel 8). 
Hinweis: Bitte verwechseln Sie nicht die CSV-Datei-Ausgabe 
der Kreuztabelle mit dem Präsentationstyp CSV-Export. 
Während hier zusätzlich zur Kreuztabelle eine CSV-Ausgabe 
in der Struktur der Ausgabe bereitgestellt wird, erzeugt der 
CSV-Export eine (partielle) Ausgabe der Datengrundlage. 
Ferner 
wird 
im 
CSV-Export 
die 
Möglichkeit 
der 
Parametereinstellung gegeben (vgl. Kapitel 10.3). 
Anzeige der Links 
(34) Es kann gewählt werden, wo der Downloadlink 
erscheinen soll. Als Standardeinstellung ist „unterhalb der 
Ausgabe“ gegeben. Der Downloadlink erscheint unter der 
Tabelle 
32 
33 
34

## Page 68

Auswertungsassistent - Anwendungshandbuch 
62 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Versetzt man den Punkt nach „oberhalb der Ausgabe“ 
erscheint der Downloadlink oberhalb der Tabelle, was bei 
längeren Tabellen von Vorteil sein kann. 
 
 
 
Textersetzungen 
 
Hinweis: Diese Funktionalität steht nur Benutzer*innen zur 
Verfügung, 
die 
die 
Berechtigung 
„Auswertungskopf 
bearbeiten“ besitzen. Andernfalls wird diese Option nicht 
angezeigt. 
 
Die Möglichkeiten der Textersetzungen sind für die 
Präsentationsformen Kreuztabelle, Standard (Säulen, Balken, 
Linien, Flächen), gleich. Im Detail werden diese im Kapitel 9.2 
beschrieben. 
 
Allgemeine Optionen 
Dezimaltrennzeichen 
Tausendertrennzeichen 
Die Form des Dezimaltrennzeichens (Komma, Punkt oder 
eigene Eingabe) (35) und des Tausendertrennzeichens 
(Punkt, geschütztes Leerzeichen, Komma, Hochkomma oder 
eigene Eingabe) (36) können hier festgelegt werden.  
Standardmäßig sind Komma für Dezimaltrennzeichen und 
Punkt für das Tausendertrennzeichen serverseitig eingestellt.  
Externe Referenztabellen 
Hier kann ein Haken bei „Externe Referenztabellen“(37) 
gesetzt werden. Die Externen Referenztabellen „können 
verschiedene Nullwerte enthalten“. Diese Option ist 
standardmäßig ausgeschaltet.  
 
 
 
35 
36 
37

## Page 69

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
63 
10.1.3 Merkmalsspezifische Gesamtsummen- und Zwischensummenanzeige 
Unter dem Auswahlfeld „Darstellung Schlüsselmerkmale“ sind, wie in Kapitel 10.1.2 (7) beschrieben, 
Funktionen für „Alle Merkmale“ zu finden, aber auch die ausgewählten Schlüsselmerkmale aufgelistet. 
Es besteht die Möglichkeit Darstellungsbefehle zu geben, die für alle Merkmale gelten, oder aber auch 
spezifische Befehle für einzelne Merkmale. 
 
Mit einem Klick auf „Alle Merkmale“ oder einem darunter angezeigten „Kopf“- bzw. 
„Vorspaltenmerkmal“ sind die beiden Funktionen „Gesamtsumme anzeigen“ und „Zwischensumme 
anzeigen“ zu finden. (Achtung: „Gesamtsumme“ nicht mit der „Gesamtsumme“ (Spalten/Zeilen) 
verwechseln. Vgl. dazu Kapitel 10.1.2 (2) und (3)). Diese Funktionen haben nur bei mehr als zwei 
„Vorspalten“ oder „Kopfmerkmalen“ Relevanz. Die beiden Merkmale müssen außerdem verschachtelt 
sein (Abb. 59). Das bedeutet: Die „Vorspaltenmerkmale“ müssen nebeneinander geordnet sein (Abb. 
47(1)). Die „Kopfmerkmale“ müssen untereinander geordnet sein (2). 
 
Abbildung. 59: Verschachtelung von „Kopf-„und „Vorspaltenmerkmal“ als Voraussetzung für das Anzeigen der 
merkmalsspezifischen „Gesamt“- und „Zwischensummen“ 
Setzt man nun bei „Alle Merkmale“ den Haken bei „Gesamtsumme anzeigen“ wird in der Ausgabe die 
Tabelle rechts und unten durch folgende Gesamtsummen ergänzt (Abb. 60 (1)). Die „Gesamtsumme“ 
rechts bezieht sich auf die „Kopfmerkmale“. Hier „Geschlecht der Bezugsperson“ (2) und 
„Staatsangehörigkeiten im Haushalt“ (3). Die Angabe „Gesamt“ (4) hat nichts mit der hier 
beschriebenen Funktion zu tun (Vgl. dazu Kapitel 10.1.2 „Tabelleneigenschaften“ (Zeilensumme)) 
1 
2

## Page 70

Auswertungsassistent - Anwendungshandbuch 
64 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 60: Ausgabetabelle mit „Gesamtsummen anzeigen“ 
Die Tabellenergänzung „Gesamt“ am unteren Ende erfasst die „Vorspaltenmerkmale“. Hier 
„Kleinräum. Gliederung 3-stellig“ und „Alter der Bezugsperson“. Auch hier erscheint eine weitere Zeile 
mit der Beschriftung „Gesamt“. Hierbei handelt es sich um die „Spaltensumme“, aus den 
„Tabelleneigenschaften“ (Vgl. Kapitel10.1.2). 
Auf eine Abbildung wurde aufgrund der Größe der Ausgabetabelle an dieser Stelle verzichtet. 
Setzt man nun für „Alle Merkmale“ den Haken bei „Zwischensumme anzeigen“, so wird dadurch die 
Summe (Abb. 61 (1)) für das jeweils untergeordnete Merkmal („Alter der Bezugsperson“ (2) und 
„Staatsangehörigkeit“ (3)) innerhalb einer Merkmalsausprägung des übergeordneten Merkmals 
(„Kleinräum. Gliederung 3-stellig“ (4) und „Geschlecht“ (5)) angezeigt. Die Anordnung welches 
Merkmal über- und untergeordnet ist, ist der Abb. 59 zu entnehmen. Bei der Spalte mit der 
Beschriftung „Gesamt“ (6) handelt es sich um die „Zeilensumme“ (Vgl. Kapitel 10.1.2 (2) und (3)). 
 
 
Abbildung 61: Ausgabetabelle mit „Zwischensummen anzeigen“ 
 
 
1 
2 
3 
4 
1 
1 
1 
2 
3 
4 
5 
6

## Page 71

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
65 
Im Auswahlfeld „Darstellung Schlüsselmerkmale“ werden unterhalb von „Alle Merkmale“ die 
ausgewählten „Schlüsselmerkmale“ angezeigt (Abb. 62 (1)). Hier kann die Ausgabe der „Gesamt“- und 
„Zwischensummen“ individuell für jedes Merkmal bestimmt werden (2). Diese Funktion weist gerade 
dann einen Nutzen auf, wenn viele „Vorspalten“- oder „Kopfmerkmale“ ausgewählt wurden, die 
„Gesamt“- oder „Zwischensumme“ jedoch nicht bei allen Merkmalen angezeigt werden sollen. Zur 
besseren Übersicht und um ein Verwechseln mit den „Gesamt“- und „Zwischensummen“ anderer 
Merkmale, aber auch den Zeilen- und Spaltensummern aus den Tabelleneigenschaften zu verhindern, 
können hier die Beschriftung der Summen für jedes Merkmal angepasst werden (3). 
 
Abbildung 62: Individuelle Umbenennung der verschiedenen „Summen“-Spalten 
(Weitere Befehle unter „Darstellung Schlüsselmerkmale“ wie etwa „Sortierung“ und „Beschriftung“ 
vgl. Kapitel 10.2.1 (10) bis (15)) 
10.2 Interaktive Tabelle 
Eine wichtige Neuerung des ASW (ab Version 4.13) stellt die alternative Anzeige von Kreuztabellen dar, 
die auf der Typauswahlseite als Interaktive Tabelle bezeichnet wird. 
1 
2 
3

## Page 72

Auswertungsassistent - Anwendungshandbuch 
66 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 63: Auswahl Präsentationstyp mit neuer Option „Interaktive Tabelle“ 
 
10.2.1 Detailauswahl 
Die Detailauswahl für diesen Auswertungstyp entspricht in der Darstellung der des Typs Kreuztabelle 
und wurde in der Funktionalität angepasst. Der Hauptunterschied besteht darin, dass textuelle 
Merkmale in Kopfzeile und Vorspalte nur hierarchisch angeordnet werden können, also in der 
Vorspalte nebeneinander und in der Kopfzeile untereinander, da die Interaktive Tabelle die nicht-
hierarchische Anordnung - die im Grunde eine Verkettung mehrerer Einzeltabellen mit identischer 
Vorspalte bzw. Kopfzeile darstellt – nicht anbietet. 
Interaktionen wie Sortierung und Filterung werden bei diesem Auswertungstyp anwenderseitig, d.h. 
lediglich im Browser, durchgeführt. Da prinzipiell nur aggregierte Daten an den Client gesendet 
werden, ist es nicht sinnvoll nach Wertemerkmalen zu filtern. Aus diesem Grund ist das Platzieren von 
Wertemerkmalen im Bereich „Dynamischer Filter“ hier nicht möglich. 
Das gleichzeitige Platzieren von Schlüsselmerkmalen im Bereich „Dynamischer Filter“ und im Bereich 
„Vorspaltenmerkmale“ bzw. „Kopfmerkmale“ ist zwar noch möglich, aber nicht mehr notwendig, da 
alle Kopf- und Vorspaltenmerkmale implizit zum interaktiven Filtern genutzt werden können.

## Page 73

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
67 
 
Abbildung 64: Merkmalsauswahl für eine Interaktive Tabelle 
Die in Abb.64 gezeigte Detailauswahl führt zur in Abb. 65 dargestellten Auswertung: 
 
Abbildung 65: Beispielhafte Auswertung einer Interaktiven Tabelle

## Page 74

Auswertungsassistent - Anwendungshandbuch 
68 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Zur besseren Veranschaulichung wurden die einzelnen Ausgabebereiche farblich gekennzeichnet. Der 
blau umrahmte Teil stellt die eigentliche Kreuztabelle dar mit Kopfzeile (Spaltenkopf), Vorspalte 
(Zeilenkopf) und Datenbereich. Der rot umrahmte Bereich ist das sogenannte Field-Panel, in dem die 
an der Auswertung beteiligten Merkmale angezeigt werden. Analog zur Tabelle selbst unterteilt sich 
auch das Field-Panel wiederum in drei Bereiche, den Spaltenbereich rechts-, den Zeilenbereich links 
unten und den Datenbereich links oben. Im grün umrahmten Bereich, dem Filter-Panel, werden die 
Merkmale aufgeführt, die nur als dynamische Filter selektiert wurden. 
Schlüsselmerkmale können beliebig per Drag‘n‘Drop entweder innerhalb des Field-Panels (mit 
Ausnahme des Datenbereiches) oder zwischen dem Field-Panel und dem Filter-Panel verschoben 
werden. Wertemerkmale stehen immer im Datenbereich. 
 
10.2.2 Konfigurationsmöglichkeiten für den Präsentationstyp Interaktive Tabelle 
Die Konfigurationsmöglichkeiten unterscheiden sich für diesen Auswertungstyp auch in der 
Darstellung etwas stärker von der des Typs Kreuztabelle – insbesondere was die verfügbaren Optionen 
betrifft. 
10.2.2.1 Tabelleneigenschaften 
Bei den Tabelleneigenschaften gibt es im Vergleich zum Präsentationstyp „Kreuztabelle“ eine Reihe an 
Änderungen.  
Zum einen entfallen die von der „Kreuztabelle“ bekannten Optionen „Sortierschalter anzeigen“, 
„Tabelle umbrechen“ und „Breite der Vorspalte“. Hinzu kommt dagegen der Bereich „Tabellenkopf“ 
(Abb. 66 (1)). 
 
Abbildung 66: Tabelleneigenschaften einer Interaktiven Tabelle 
 
1 
2 
3 
4 
5

## Page 75

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
69 
Da die Wertemerkmale im Field-Panel nur angezeigt werden, um ihre Reihenfolge ändern zu können, 
was in der Praxis eher selten vorkommen dürfte, wird dieser Bereich prinzipiell zunächst ausgeblendet. 
Das kann aber durch Aktivieren der Option „Wertemerkmale anzeigen“ (2) geändert werden. Die 
Bereiche für Kopf- und Vorspaltenmerkmale (3 und 4) werden standardmäßig angezeigt, jedoch nur, 
wenn mindestens ein entsprechendes Merkmal vorhanden ist.  
Die Funktion der entfernten Sortierschalter übernimmt das Kontextmenü der Interaktiven Tabelle, das 
mit einem Rechtsklick in einem der Spalten- oder Zeilenköpfe aufgerufen werden kann (Abb. 67). Es 
enthält Einträge für alle Ebenen, um diese nach der gewählten Spalte oder Zeile zu sortieren. Das 
Kontextmenü ist immer verfügbar, sein Inhalt richtet sich jedoch nach der Position des Mauszeigers, 
an der der Rechtsklick erfolgt. 
 
Abbildung 67: Auswertung einer Interaktiven Tabelle mit aktiviertem Kontextmenü 
Weitere Optionen zur Tabellengestaltung sind hier nicht verfügbar. Um dennoch etwas Einfluss auf die 
Darstellung nehmen zu können, wurde die Option „Zeilenköpfe in Baumform anzeigen“ (5) verfügbar 
gemacht. Ist diese Option gewählt und mehrere Vorspaltenmerkmale selektiert, wird die gesamte 
Vorspalte als Baumstruktur dargestellt. 
Nachfolgend werden die unterschiedlichen Darstellungen in den Abb. 68 und 69 illustriert – Abb. 68 
zeigt hierbei die Vorspalte in Standarddarstellung, Abb. 69 zeigt die Vorspalte in der Baumstruktur.

## Page 76

Auswertungsassistent - Anwendungshandbuch 
70 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 68: Auswertung mit Standardvorspalte

## Page 77

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
71 
 
Oberhalb jeder untergeordneten Gruppierung wird eine Zeile für die Ausprägung des übergeordneten 
Merkmals angezeigt. Der Datenteil dieser Zeile enthält immer die jeweilige Zwischensumme. Diese 
Option setzt also die Optionen zur Anzeige von Zwischensummen für die Vorspalte außer Kraft. 
Außerdem wird die Zeile immer oberhalb angezeigt unabhängig von der Option zur Positionierung von 
Summenzeilen. 
10.2.2.2 Darstellung Schlüsselmerkmale 
Die Optionen für die Darstellung von Schlüsselmerkmalen wurden etwas reduziert, da z.B. die Anzeige 
von Gesamtsummen für Ausprägungen untergeordneter Merkmale hier nicht möglich ist. Die Anzeige 
von Zwischensummen kann merkmalsweise konfiguriert werden, die Option ist somit bei jedem 
Merkmal verfügbar. 
Die Anzeige von Schlüssel und Ausprägung in separaten Spalten ist jedoch nicht verfügbar. Da die 
Gruppierung von Zeilen und Spalten technisch bedingt nicht verhindert werden kann, fehlt die 
zugehörige Option. Hier kann lediglich der Initialzustand (auf- oder zugeklappt) festgelegt werden. 
Abbildung 69: Auswertung mit Vorspalte in Baumstruktur

## Page 78

Auswertungsassistent - Anwendungshandbuch 
72 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 70: Optionsreiter „Darstellung Schlüsselmerkmale“ 
Neu hinzugekommen ist die Option Ausprägungen nicht umbrechen, über die man den standardmäßig 
automatisch durchgeführten Umbruch in den Spalten- bzw. Zeilenköpfen für das jeweilige Merkmal 
deaktivieren kann. Dies kann beim Erzeugen einer ansprechenden Tabellendarstellung hilfreich sein. 
10.2.2.3 Darstellung Wertemerkmale 
In diesem Bereich wurden neue Optionen hinzugefügt (vgl. Abb. 71). Bei den bisherigen Kreuztabellen 
gab es als darzustellende Werte (Statistikfunktionen) neben den Absolutwerten nur die auf die 
jeweilige Spalten- oder Zeilengesamtsumme bezogenen Prozentwerte. Diese sind nun mit dem Zusatz 
(Gesamt) (Abb. 71 (1)) versehen, da es jetzt zusätzlich Spalten- und Zeilenprozentwerte gibt, die sich 
zum einen auf die Summe der jeweiligen Gruppierung beziehen und mit dem Zusatz (Gruppe) (Abb. 71 
(2)) 
gekennzeichnet 
sind 
und 
zum 
anderen 
Gesamtprozentwerte, 
die 
sich 
auf 
die 
Tabellengesamtsumme beziehen.

## Page 79

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
73 
 
Abbildung 71: Optionsreiter „Darstellung Wertemerkmale“ 
Sind mehrere Wertemerkmale oder darzustellende Werte selektiert, werden deren Bezeichner je nach 
Tabellenlayout in den Spalten- bzw. Zeilenköpfen angezeigt. Analog zu den Ausprägungen der 
Schlüsselmerkmale gibt es hier die Option Bezeichner nicht umbrechen, mittels der der automatische 
Umbruch deaktiviert werden kann. 
10.2.2.4 Filtern 
Der Bereich Filtern entfällt, da für die Filterung der Ausgabe nur noch die Elemente und Funktionen im 
Darstellungsmodus der Interaktiven Tabelle genutzt werden. 
10.2.2.5 Zusatzinformationen 
In diesem Bereich entfällt die Option dynamische Fußnoten auswerten, da es derzeit nicht möglich ist 
diese in der Interaktiven Tabelle anzuzeigen. 
 
Abbildung 72: Optionsreiter „Zusatzinformationen“ 
10.2.2.6 Export 
Für den Export wird ebenfalls die Funktionalität der Interaktiven Tabelle genutzt. Diese stellt allerdings 
nur ein einziges Dateiformat zur Verfügung, und zwar XLSX. Alle Optionen für andere Exportformate 
entfallen daher. Wird der XLSX-Export aktiviert, wird im Field-Panel der Interaktiven Tabelle ein 
entsprechendes Symbol als grafischer Link angezeigt, um den Export zu starten 
. Außerdem 
erscheint im Kontextmenü ein entsprechender Eintrag. 
1 
2

## Page 80

Auswertungsassistent - Anwendungshandbuch 
74 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 73: Optionsreiter „Export“ 
Ist die Option eine Datei pro Seite aktiviert und es wurde ein Seitenmerkmal festgelegt, kann bzw. 
muss jede Tabelle in eine separate Datei exportiert werden. Ist die Option nicht aktiviert, werden alle 
Tabellen als einzelne Worksheets in eine gemeinsame Datei exportiert. Dabei ist es egal, von welcher 
Tabelle aus der Export gestartet wird. Zur Gestaltung des Excel-Sheets wird dieselbe Template-Datei 
verwendet, wie für die Kreuztabelle. Zur Validierung der enthaltenen Tags wird intern allerdings die 
Formatangabe xls verwendet, da auch hier keine Grafiken exportiert werden. Das bedeutet, dass z.B. 
Tags mit dem Parameter „-xls“ oder „*xlsx“ nicht ausgewertet werden, da sie für das Exportformat XLS 
nicht gültig sind. Aus technischen Gründen wird hier bei Selektion eines Seitenmerkmals dessen 
aktuelle Ausprägung automatisch oberhalb der Tabelle in den Export eingefügt, da die Tabs lediglich 
mit „Tabelle1“ ... „TabelleN“ beschriftet werden.  
10.2.2.7 Weitere Konfigurationsmöglichkeiten 
In den Bereichen Konfiguration, Seitenmerkmal, Textersetzungen und Allgemeine Optionen wurde 
nichts verändert. 
10.2.3 Auswertungen 
10.2.3.1 Darstellung 
Abbildung 74 zeigt eine Auswertung mit einem Seitenmerkmal und mehreren darzustellenden 
Werten des Merkmals „Anzahl Haushalte“. Die einzelnen Ausgabebereiche sind hier noch einmal 
farblich gekennzeichnet. 
 
Abbildung 74: Auswertung mit einem Seitenmerkmal und mehreren darzustellenden Werten 
Die einzelnen Bereiche des Field-Panels sind farblich hinterlegt, Der Datenbereich rot, der 
Spaltenbereich grün und der Zeilenbereich blau. Die Kopfbereiche der Tabelle sind in entsprechender

## Page 81

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
75 
Farbe umrahmt, Spaltenköpfe grün und Zeilenköpfe blau. Der rot umrahmte Bereich enthält die 
Kopffelder für die einzelnen Wertemerkmale (Datenköpfe) und zählt in diesem Beispiel mit zu den 
Zeilenköpfen, steht aber außerhalb der hier verwendeten Baumstruktur, da er ja keine Gruppierung 
darstellt. Die Position der Datenköpfe wird entweder durch die Anordnung der Wertemerkmale 
festgelegt, falls mehrere ausgewählt wurden, oder kann in den Optionen festgelegt werden, falls es 
nur eines mit mehreren darzustellenden Werten gibt. Die Datenköpfe können daher bei einer anderen 
Anordnung ebenso gut zu den Spaltenköpfen zählen. 
10.2.3.2 Funktionalität 
Der Filterbereich wird hier nicht automatisch angezeigt, da kein Merkmal nur zum Filtern ausgewählt 
wurde. Er kann aber jeder Zeit falls notwendig über einen Eintrag im Kontextmenü ein- oder 
ausgeblendet werden. Das Kontextmenü enthält wie bereits angemerkt je nach Kontext 
unterschiedliche Einträge. Bei einem Klick in das Field-Panel erscheint es in der Minimalversion: 
 
Abbildung 75: Kontextmenü in Minimalversion 
Der Eintrag zum Exportieren wird allerdings auch nur angezeigt, wenn der Export in den Optionen 
aktiviert wurde. Bei Klick auf eine der oberen Ebene einer Spalten- oder Zeilenhierarchie im grün oder 
blau umrahmten Bereich enthält es Einträge, um alle Gruppen dieser Ebene gleichzeitig auf- oder 
zusammenzuklappen: 
 
Abbildung 76: Kontextmenü mit Optionen zum Auf- und Zusammenklappen 
Bei Klick in einen Spalten- oder Zeilenkopf auf der untersten Ebene erscheinen Einträge, um die Tabelle 
nach der jeweiligen Spalte oder Zeile zu sortieren. Die Tabelle kann beim Präsentationstyp Interaktive 
Tabelle also nicht nur nach Spalten, sondern auch nach Zeilen sortiert werden, wobei außerdem auch 
noch die Gruppierungsebene gewählt werden kann, auf der sortiert werden soll: 
 
Abbildung 77: Kontextmenü mit zusätzlichen Optionen zur Sortierung

## Page 82

Auswertungsassistent - Anwendungshandbuch 
76 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Diese Sortierung entspricht bei den Spalten in etwa den Sortierschaltern der herkömmlichen 
Kreuztabelle. Wurde die Tabelle nach einer Spalte oder Zeile sortiert, ist dies durch zwei gegenläufige 
senkrechte Pfeile im jeweiligen Spalten- bzw. Zeilenkopf gekennzeichnet (Abb. 78). 
 
Abbildung 78: Spaltenkopf mit aktivierter Sortierung 
Wie oben bereits erwähnt können Schlüsselmerkmale beliebig zwischen Spalten- und Zeilenbereich 
des Field-Panels und dem Filter-Panel verschoben werden. Es können also auch Merkmale quasi aus 
der Auswertung herausgenommen werden, indem sie in das Filter-Panel verschoben werden, ohne 
dass ein Filter definiert wird. 
Die im Field- bzw. Filter-Panel aufgeführten Schlüsselmerkmale sind mit einem senkrechten Pfeil und 
einem Filtersymbol versehen. 
 
Abbildung 79: Schlüsselmerkmal mit aktivierter Sortierung 
Der senkrechte Pfeil zeigt die aktuelle Sortierrichtung für das jeweilige Merkmal an, wobei diese für 
Merkmale im Filter-Panel uninteressant ist. Spitze nach oben bedeutet eine aufsteigende und Spitze 
nach unten eine absteigende Sortierung. Um die Richtung zu ändern, genügt ein Mausklick irgendwo 
innerhalb des Merkmalsobjektes. 
Um Filterkriterien für ein Merkmal zu definieren, muss man auf das Filtersymbol klicken, woraufhin ein 
entsprechender Auswahldialog angezeigt wird:

## Page 83

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
77 
Abbildung 80: Auswahldialog zur Filterung von Merkmalen 
10.3 Liste 
10.3.1 Besonderheiten des Präsentationstyps Liste 
Neben Kreuztabellen können Sie mit dem DUVA-Auswertungsassistenten Daten in einer einfach 
strukturierten Liste ausgeben lassen. Die Ausgabe einer Liste ist immer dann sinnvoll, wenn es nicht 
primär um statistische Auswertungen geht, sondern vielmehr um die Anzeige von qualitativen 
Einzeldaten, z.B. zu Kindertagesstätten (Betriebszeiten, Betreuungsplätze usw.), zu Einträgen in einer 
Straßendatei (Zuordnungen zur kleinräumigen Gliederung) oder zum Bestand einer Bibliothek (alle 
Aufsätze zu einem Stichwort oder Neuerwerbungen des laufenden Monats). 
Die Auswahl der Merkmale, die in einer Liste dargestellt werden sollen, erfolgt auf der Auswahlseite 
(Abb. 81), die nach der Dateiauswahl durch einen Klick auf die Schaltfläche „Liste“ in der 
Präsentationsauswahl gestartet wird (vgl. Kapitel 5). Diese Auswahlseite verfügt lediglich über einen 
zentralen Zielbereich („auszugebende Merkmale“), in den die Merkmale gezogen und angeordnet 
werden können (1). Die Reihenfolge, in der die ausgewählten Merkmale in der Ausgabeliste 
ausgegeben werden, entspricht der Reihenfolge, in der die Merkmale im Zielbereich angeordnet 
wurden. Weitere Merkmale können den vorhandenen Merkmalen zwar nur am Ende der Liste 
hinzugefügt werden, sie lassen sich nach der Ablage im Zielbereich jedoch wieder durch einen 
Mausklick aufnehmen und bei gehaltener Maustaste an die gewünschte Position verschieben. 
Hinweis: Neben Schlüsselmerkmalen können der Liste Wertemerkmale hinzugefügt werden. Diese 
werden jedoch nicht – wie in der Kreuztabelle – im Wertebereich einer Tabelle aggregiert, sondern die 
in der Ausgangsdatei in Kombination mit den übrigen ausgewählten Merkmalen enthaltenen Werte 
werden in einer eigenen Zeile aufgelistet. Listen sind daher für statistische Auswertungen nicht 
sonderlich geeignet. Vielmehr werden Daten aus Dateien mit individuellen Angaben z.B. zu Städten im 
Städtevergleich, Infrastruktureinrichtungen, Straßenverzeichnissen, Aufsätze in einer Fachbibliothek 
usw. aufgelistet. 
 
 
Abbildung 81: Der Präsentationstyp „Liste“ eignet sich für die Darstellung von qualitativen Einzelangaben. Das Beispiel zeigt 
eine Auswertung aus einer Erfassungsdatei mit einer Schulstatistik 
1 
2 
3 
4

## Page 84

Auswertungsassistent - Anwendungshandbuch 
78 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Über ausgewählte Merkmale können Filter gesetzt werden. Soll ein Filter für ein Merkmal definiert 
werden, das nicht in der Liste erscheinen soll, muss das Merkmal zuvor dem Zielbereich „statischer 
Filter“ zugeordnet werden (2), bevor die Ausprägungen als Filterkriterien ausgewählt werden können 
(vgl. Kapitel 7.1). 
Listenausgaben können nach ihrer Erstellung durch die Verwendung dynamischer Filter auf die 
gewünschte Sicht eingeschränkt werden. Dazu müssen die Merkmale, deren Ausprägungen zur 
Definition der Filter verwendet werden sollen, in dem Zielbereich „dynamischer Filter“ (3) hinzugefügt 
werden (vgl. Kapitel 7.2).  
 
Listen können ebenfalls für die Aufteilung auf mehrere Seiten definiert werden. Dazu wird das 
Merkmal, für dessen Ausprägungen jeweils eine eigene Liste erzeugt werden soll, dem Zielbereich 
„Seitenmerkmal“ (4) zugeordnet (vgl. Kapitel 8). 
 
 Abbildung 82: Durch die Kombination von ausgewählten Merkmalen lässt sich beispielsweise eine Liste von 
Kindertageseinrichtungen erstellen 
10.3.2 Konfigurationsmöglichkeiten für den Präsentationstyp Liste 
Durch einen Klick auf die Schaltfläche „Optionen“ im Fußbereich der Auswahlseite öffnet sich der 
Optionen-Dialog im linken Auswahlbereich und ersetzt die Merkmalsauswahlliste (vgl. Kapitel 9). Dort 
können Konfigurationsmöglichkeiten vorgenommen werden in ähnlicher Weise wie bei der 
Kreuztabelle (vgl. Kapitel 10.1.2). Die Wahlmöglichkeiten unterscheiden sich dabei nur geringfügig. So 
können zum Beispiel Schlüsseltabellen bei der Liste nicht nach Schlüsseln oder Ausprägungen sortiert 
werden wie bei der Kreuztabelle. 
 
 
Konfiguration 
wie bei Kreuztabelle (vgl. Kapitel 10.1.2) 
 
Listenoptionen 
Seitenbreite 
(1) Mit der Seitenbreite lässt sich die Breite der Tabelle innerhalb 
des Ausgabefensters festlegen. Die Festlegung der Größe kann über 
Prozent, rem und Pixel festgelegt werden 
1 
2 
3

## Page 85

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
79 
Alle Felder füllen 
Bei der Ausgabe von Listen werden aufeinanderfolgende 
Wiederholungen eines Wertes innerhalb einer Spalte nicht 
angezeigt. Stattdessen wird ein Punkt als Auslassungszeichen 
ausgegeben. Wird ein Haken bei der Option „Alle Felder füllen“ (2) 
gesetzt, werden in der Ausgabe alle Listenfelder mit den ermittelten 
Werten gefüllt. 
Sortierschalter anzeigen 
Die Ausgabe von Datensätzen erfolgt in der Listenansicht prinzipiell 
für alle Merkmale nach den jeweiligen Schlüsseln aufsteigend 
sortiert. Analog zur Kreuztabelle gibt es die Option Sortierschalter 
anzeigen (3), mit deren Hilfe sich die Sortierrichtung für eine Spalte 
umkehren lässt. 
Im Unterschied zur Kreuztabelle werden in der Liste aus dem oben 
genannten Grund aber nur die Schaltflächen für aufsteigend und 
absteigend angezeigt. Man kann damit für eine beliebige Spalte die 
Sortierreihenfolge innerhalb der übergeordneten Gruppierungen 
wechseln. 
 
 
 
Darstellung Schlüsselmerkmale 
Die Darstellung von Schlüsselmerkmalen kann sowohl generell 
für alle Schlüsselmerkmale als auch für die einzelnen Merkmale 
eingestellt 
werden 
(3). 
Die 
Konfigurationsmöglichkeiten 
beschränken sich hier auf den Umfang der Darstellung eines 
ausgewählten Schlüsseltabellenmerkmals.  
Umfang der Darstellung: 
nur Ausprägungen/ 
nur Schlüssel/ 
beides zusammen/ 
beides in separaten Spalten 
In der Standardeinstellung werden die Ausprägungstexte ohne 
die dazugehörenden Schlüssel ausgegeben (4). Darüber hinaus 
kann für alle ausgewählten Merkmale oder für Einzelmerkmale 
festgelegt werden, ob in der Liste nur Schlüssel oder beides – 
Schlüssel und Ausprägungstexte – angezeigt werden sollen. 
Sollen Texte und Schlüssel angezeigt werden, ist festzulegen, ob 
beides in einer oder in getrennten Spalten auszugeben ist. 
 
 
 
Darstellung Wertemerkmale 
 
Die Darstellung von numerischen Werten kann generell für alle 
ausgewählten 
Wertemerkmale 
oder 
für 
die 
einzelnen 
ausgewählten numerischen Wertemerkmale (5) eingestellt 
werden.  
 
Hier kann auch das Tausendertrennzeichen (6) aktiviert werden. 
Dessen spezifisches Aussehen lässt sich in Allgemeine Optionen 
festlegen; standardmäßig, gemäß Servereinstellungen, ist es der 
Punkt. 
 
Nachkommastellen (7): In der Grundeinstellung (=Automatisch) 
erhalten Absolutwerte keine Nachkommastelle. Sollen die 
Tabellenwerte Nachkommastellen aufweisen, können sie hier 
zwischen 0-9 und Automatisch festgelegt werden. 
 
6 
7 
5 
3 
4

## Page 86

Auswertungsassistent - Anwendungshandbuch 
80 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Zusatzinformationen 
wie bei Kreuztabelle (vgl. Kapitel 10.1.2) 
 
 
 
Export 
wie bei Kreuztabelle (vgl. Kapitel 10.1.2) 
 
 
 
Textersetzungen 
vgl. Kapitel 9.2 
 
 
 
Allgemeine Optionen 
wie bei Kreuztabelle (vgl. Kapitel 10.1.2) 
 
10.4 CSV-Export 
CSV-Dateien (Comma-separated values) sind reine Textdateien, die dem Austausch von Daten auf 
verschiedenen Systemen bzw. unter verschiedenen Programmen dienen. Sie folgen im inhaltlichen 
Aufbau einem etablierten Standard, der von sehr vielen Programmen erkannt und unterstützt wird. 
Ein Datenaustausch ist mit diesem Format nicht nur zwischen verschiedenen Programmen eines 
Betriebssystems möglich, sondern kann auch systemübergreifend - z.B. von Apple iWork nach Linux 
LibreOffice - erfolgen. 
Das Auswahlfenster zum Festlegen der im CSV-Export auszugebenden Merkmale und der 
Ausgabeoptionen (Abb. 83) wird nach der Dateiauswahl durch einen Mausklick auf die Schaltfläche 
„CSV-Export“ in der Präsentationsauswahl (vgl. Kapitel 5) geöffnet. Das Auswahlfenster verfügt über 
einen zentralen Zielbereich „Auszugebende Merkmale“ (1). Da bei einem Daten-Export oftmals die 
Mehrheit der Merkmale – wenn nicht alle – ausgegeben werden, ist der Zielbereich bereits mit allen 
in der ausgewählten Datei vorhandenen Schlüssel- und Wertemerkmalen vorbelegt. Durch einen 
Mausklick auf die „Schließen“-Schaltflächen am Ende der Merkmalsfelder (2) können die Merkmale, 
die nicht exportiert werden sollen, aus dem Zielbereich entfernt und somit vom Export ausgeschlossen 
werden. 
Die Reihenfolge, in der die Merkmale in der Ausgabeliste angeordnet sind, entspricht zunächst der 
Reihenfolge der Merkmale in der Auswahlliste (3). Sie lassen sich jedoch im Zielbereich (1) durch einen 
Mausklick aufnehmen und bei gehaltener Maustaste an die gewünschte Position verschieben. 
Nach der Auswahl der Merkmale, die nicht ausgegeben werden sollen, beschränkt sich der CSV-Export 
auf die im Zielbereich verbliebenen Merkmale. Dabei wird keine Datenaggregation durchgeführt. Das 
heißt, dass alle Datensätze der ausgewählten Datei ausgegeben werden, auch wenn die 
Ausprägungskombinationen der exportierten Merkmale mehrfach vorkommen sollten. 
Über ausgewählte Merkmale können jedoch Filter gesetzt werden. Soll ein Filter für ein Merkmal 
definiert werden, das nicht in der Liste erscheinen soll, muss das Merkmal zuvor dem Zielbereich 
„statischer Filter“ zugeordnet werden (4), bevor die Ausprägungen als Filterkriterien im rechten 
Auswahlbereich (5) selektiert werden können (vgl. Kapitel 7).

## Page 87

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
81 
 
Abbildung 83: In der Merkmalsauswahl für den CSV-Export sind alle Schlüssel- und Wertemerkmale der gewählten Datei 
bereits dem Zielbereich „Auszugebende Merkmale“ zugeordnet. 
Durch einen Klick auf die Schaltfläche „Optionen“ im Fußbereich der Auswahlseite können folgende 
präsentationsabhängige Einstellungen (vgl. Kapitel 9) vorgenommen werden: 
 
 
Konfiguration 
wie bei Kreuztabelle (vgl. Kapitel 10.1.2) 
Ausgabeformatierung 
Kopfzeile 
In 
der 
Grundeinstellung 
erfolgt 
eine 
Ausgabe 
der 
ausgewählten Merkmale in eine CSV-Datei ohne Kopfzeile (1). 
Folgende Optionen stehen zur Verfügung: 
1. Keine – es werden lediglich Sachdaten exportiert 
2. mit Merkmalsnamen – die Datenspalten werden mit den 
Merkmalsbezeichnungen überschrieben 
3. mit Merkmalsaliasen – die Datenspalten werden mit den 
Feldnamen der Sachdatenbank überschrieben 
Feldtrennzeichen 
In der Grundeinstellung werden die Felder der CSV-Ausgabe 
durch Semikola voneinander getrennt (2). Folgende Optionen 
können ausgewählt werden: 
1. Semikolon (empfohlen) 
2. Komma 
1 
2 
3 
4 
5 
1 
2 
3 
4 
5

## Page 88

Auswertungsassistent - Anwendungshandbuch 
82 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
3. Leerzeichen 
4. Tabulator 
5. eigene Eingabe … - hier kann ein eigenes Trennzeichen 
definiert werden 
Zeichenkettenbegrenzer 
In der Grundeinstellung werden alphanumerische Feldinhalte 
(Ausprägungstexte oder Schlüsselfelder) durch doppelte 
Anführungszeichen umschlossen (3). Folgende Auswahl ist 
verfügbar: 
1. doppelte Anführungszeichen (empfohlen) 
2. einfache Anführungszeichen 
3. keiner 
4. eigene Eingabe … - hier kann ein eigener 
Zeichenkettenbegrenzer definiert werden 
CR-Ersetzung 
 
Bitte beachten Sie auch den 
Hinweis am Ende dieser Übersicht 
Diese Option regelt, wie mit einem Carriage Return (CR, 
Wagenrücklauf) umgegangen werden soll (4). Folgende 
Auswahlmöglichkeiten stehen zur Verfügung: 
1. beibehalten (in Windows-Umgebung empfohlen) 
2. entfernen 
3. Leerzeichen 
4. eigene Eingabe … - hier kann ein eigenes Steuerzeichen 
definiert werden 
LF-Ersetzung 
 
Bitte beachten Sie auch den 
Hinweis am Ende dieser Übersicht 
Diese Option regelt, wie mit einem Line Feed (LF, 
Zeilenvorschub) umgegangen werden soll (5). Es stehen 
folgende Auswahlmöglichkeiten zur Verfügung: 
1. beibehalten (in Windows-Umgebung empfohlen) 
2. entfernen 
3. Leerzeichen 
4. eigene Eingabe … - hier kann ein eigenes Steuerzeichen 
definiert werden 
Hinweis: In Textdateien (somit auch in CSV-Dateien), können je nach Betriebssystem unterschiedliche 
Steuerzeichen für den Zeilenumbruch gelten. Die drei bedeutenden Betriebssystemfamilien nutzen 
jeweils unterschiedliche Steuerzeichen für den Zeilenumbruch, daher kann eine Konvertierung 
notwendig sein. Da dies nicht immer einheitlich gehandhabt wird, muss man im Zweifelsfall mit 
verschiedenen Einstellungen experimentieren. 
Folgende Zuordnungen gelten dabei üblicherweise: 
CR  
Apple/OS-X- Umgebungen 
LF  
UNIX/Linux-Umgebungen 
CR + LF 
Windows-Umgebung 
 
 
Darstellung Schlüsselmerkmale 
Die Darstellung von Schlüsselmerkmalen kann sowohl 
generell für alle Schlüsselmerkmale als auch für die 
einzelnen 
Merkmale 
eingestellt 
werden 
(6). 
Die 
Konfigurationsmöglichkeiten beschränken sich hier auf 
den Umfang der Darstellung eines ausgewählten 
Schlüsseltabellenmerkmals.

## Page 89

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
83 
 
Umfang der Darstellung: 
nur Ausprägungen/ 
nur Schlüssel/ 
beides zusammen/ 
beides in separaten Spalten 
In der Standardeinstellung werden die Ausprägungstexte 
ohne die dazugehörenden Schlüssel ausgegeben (7). 
Darüber hinaus kann für alle ausgewählten Merkmale oder 
für Einzelmerkmale festgelegt werden, ob in der Liste nur 
Schlüssel oder beides – Schlüssel und Ausprägungstexte – 
angezeigt werden sollen. Sollen Texte und Schlüssel 
angezeigt werden, ist festzulegen, ob beides in einer oder 
in getrennten Spalten auszugeben ist. 
 
 
 
Darstellung Wertemerkmale 
 
Die Darstellung von numerischen Werten kann generell für 
alle Wertemerkmale oder für die einzelnen ausgewählten 
Wertemerkmale (8) eingestellt werden.  
 
Hier kann auch das Tausendertrennzeichen (9) aktiviert 
werden. Dessen spezifisches Aussehen lässt sich in 
Allgemeine Optionen festlegen; standardmäßig, gemäß 
Servereinstellungen, ist es der Punkt.  
 
Nachkommastellen 
(10): 
In 
der 
Grundeinstellung 
(=Automatisch) 
erhalten 
Absolutwerte 
keine 
Nachkommastelle. 
Sollen 
die 
Tabellenwerte 
davon 
abweichende Nachkommastellen aufweisen, können sie 
hier zwischen 0-9 und Automatisch festgelegt werden. 
 
 
Allgemeine Optionen 
wie bei Kreuztabelle (vgl. Kapitel 10.1.2) 
 
Nach dem Aufruf des CSV-Exports durch einen Klick auf die Schaltfläche „Starten“ im Fußbereich der 
Auswahlseite wird ein browser-spezifischer Dialog zum Öffnen oder Speichern der Exportdatei 
angezeigt (Abb. 84). Der vorgegebene Dateiname (1) setzt sich aus dem Namen der Quelltabelle der 
ausgewählten Daten in der Sachdatenbank und der Endung „.csv“ zusammen. 
6 
7 
8 
9 
10

## Page 90

Auswertungsassistent - Anwendungshandbuch 
84 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
 
 
Einen Andruck einer im Texteditor geöffneten Export-Datei zeigt Abbildung 85. Bei diesem Beispiel 
wurde 
eine 
Kopfzeile 
mit 
Merkmalsnamen 
ausgegeben 
(vgl. 
Optionseinstellungen: 
Ausgabeformatierung Kopfzeile). 
 
Abbildung 85: Ausschnitt aus einer im Texteditor geöffneten CSV-Exportdatei 
10.5 Grafiken 
Neben der Tabellenausgabe unterstützt der Auswertungsassistent auch die metadatengestützte 
Generierung von Grafiken. Dabei kann zwischen den Standardgrafiken Balken, Säulen, Linien und 
Flächen sowie Tortendiagrammen, Pyramidengrafiken, Punkt- bzw. Blasendiagrammen, Spinnennetz- 
bzw. Polardiagrammen und thematischen Karten gewählt werden. Die Auswahl für die grafischen 
Präsentationstypen erfolgt – wie für die Tabellen auch – auf der Auswahlseite „Präsentationstyp“ (vgl. 
Kapitel 5). Nach einem Mausklick auf die gewünschte Präsentation wird die entsprechende 
Merkmalsauswahl gestartet. Im Zielbereich wird der Darstellungstyp im Bild dargestellt. Dies ist keine 
Vorschau, vermittelt aber einen Eindruck auf die zu erstellende Grafik. 
 
10.5.1 Standarddiagramme (Balken, Säulen, Linien, Flächen) 
Nach der Dateiauswahl und dem Aufruf der Merkmalsauswahl für eine Standardgrafik (Abb. 86) 
erscheint im Zielbereich eine Abbildung einer Säulengrafik (5). Darunter befinden sich die 
Abbildung 84: Der Dialog zum Öffnen oder Speichern ist vom jeweiligen 
Internet-Browser abhängig und wird daher hier nicht näher erläutert. 
1

## Page 91

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
85 
Darstellungen weiterer Grafiktypen (4), die per Mausklick aktiviert werden können; neben der 
Säulengrafik stehen Balken-, Linien- und Flächengrafiken zur Auswahl.   
 
Abbildung 86: Merkmalsauswahl für eine Standardgrafik. In der symbolischen Darstellung der Standardgrafiken können Sie 
den gewünschten Grafiktyp selektieren. Das Ergebnis dieser Auswahl wird in Abbildung 58 dargestellt. 
Hier wurden aus der Datei „Haushalte, Personen und Kinder nach KGL …“ ein Schlüsselmerkmal (1), 
nämlich Staatsangehörigkeiten im Haushalt (2), und zwei Wertemerkmale (3), hier Anzahl der 
Haushalte und Anzahl der Personen im Haushalt ausgewählt. Als Präsentationsform wurde durch einen 
Mausklick auf die Symbolgrafik (4) das Balkendiagramm ausgewählt, das im Feld darüber (5) 
symbolisch dargestellt wird. Zudem wurde in diesem Fall auch noch das Schlüsselmerkmal Geschlecht 
der Bezugsperson (6) als Statischer Filter eingesetzt und die Auswahl männlich (7) getroffen.  
Die Anzahl der Wertmerkmale und die der kategorialen Merkmale bedingt sich gegenseitig. Wird 
lediglich ein einzelnes Wertemerkmal ausgewählt, können bei Standarddiagrammen auch zwei 
kategoriale Merkmale ausgewählt werden. Andersherum, wenn zwei kategoriale Merkmale 
ausgewählt werden, kann nur noch ein einziges Wertemerkmal gewählt werden. 
Die Reihenfolge von Wertemerkmalen und Schlüsselmerkmalen im Feld „Kategoriale Merkmale“ (Abb. 
87) ergibt zwei sehr verschiedene Grafiken (siehe Abbildung 88 und 89).  
Ausgehend von den höchsten Werten für ein Wertemerkmal wird automatisch die Größenordnung für 
die einzelnen Bereiche zwischen den Rasterlinien festgelegt.  
 
Abbildung 87: Im Feld Kategoriale Merkmale lässt sich die Reihenfolge zwischen Wertemerkmalen und Schlüsselmerkmalen 
durch das Ziehen mit der Maus verändern und führt zu zwei verschiedenen Darstellungen der Balkengrafiken.   
2 
3 
6 
7 
1 
4 
5

## Page 92

Auswertungsassistent - Anwendungshandbuch 
86 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 88: Balkengrafik mit zwei Wertemerkmalen (Anzahl der Personen, Anzahl Haushalte) und einem Schlüsselmerkmal 
(Staatsangehörigkeiten im Haushalt: deutsch, gemischt, ausländisch). Wertemerkmale hier als erstes kategoriales Merkmal, 
Schlüsselmerkmal als zweites kategoriales Merkmal. 
 
 
Abbildung 89: Balkengrafik mit zwei Wertemerkmalen (Anzahl der Personen, Anzahl Haushalte) und einem Schlüsselmerkmal 
(Staatsangehörigkeiten im Haushalt: deutsch, gemischt, ausländisch). Schlüsselmerkmal als erstes kategoriales Merkmal, 
Wertemerkmale als zweites kategoriales Merkmal.

## Page 93

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
87 
Abbildung 88 zeigt, dass die Merkmalsausprägungen deutscher Haushalt, gemischter Haushalt und 
ausländischer Haushalt je einen Balken darstellen und die Wertemerkmale die beiden Balkengruppen 
Anzahl der Personen und Anzahl Haushalte ergeben.  
Abbildung 89 zeigt, dass die Merkmalsausprägungen (deutscher Haushalt, gemischter Haushalt und 
ausländischer Haushalt) drei Balkengruppen ergeben, wobei je zwei Säulen die Anzahl der Personen 
und Anzahl Haushalte wiedergeben.  
Statischer Filter / Dynamischer Filter 
Im Beispiel wurde das Schlüsselmerkmal Geschlecht der Bezugsperson mit der Maus ins Zielfeld 
Statischer Filter gezogen. Klickt man das Schlüsselmerkmal dann im Zielfeld mit der Maus an, wird das 
Merkmal aktiviert und lässt sich nun filtern. Ein dynamischer Filter erlaubt das beliebige Umschalten 
in der Grafik (vergleiche auch Kapitel 7.2).  
Ausdruck der Grafik 
Nach einem Mausklick auf die Schaltfläche „Starten“ wird die Grafik erstellt und als HTML-Seite 
ausgegeben. Die Grafik kann nach der Betätigung der Schaltfläche „Diagramm-Menü“ ausgedruckt 
oder in den Grafikformaten PNG, JPEG, PDF oder SVG exportiert werden (vgl. Kapitel 10.5.7). Die 
Druckqualität (und ohne Menüleiste) erhöht sich, wenn die Grafik zunächst exportiert wird und dann 
ausgedruckt wird. 
Optionen 
Siehe Kapitel 10.5.6 
 
10.5.2 Tortendiagramm 
Die Auswahl der Merkmale, die in einem Tortendiagramm dargestellt werden sollen, erfolgt durch das 
Anklicken eines Schlüssel- oder eines Wertemerkmals in der Auswahlliste (Abb. 90 (1)) und Ziehen bei 
gehaltener Maustaste in den jeweiligen Zielbereich der Grafik (2), (3).  
 
Abbildung 90: Merkmalsauswahl für ein Tortendiagramm. Das Ergebnis dieser Auswahl wird in Abbildung 92 dargestellt. 
1 
2 
3 
4 
5 
6 
7

## Page 94

Auswertungsassistent - Anwendungshandbuch 
88 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Enthält die zur Auswertung gewählte Datei nur ein Wertemerkmal, so wird dieses bereits bei dem 
Aufruf der Auswahlseite automatisch dem Zielbereich „Wertemerkmale“ (3) zugeordnet. Enthält die 
Datei nur ein Schlüsselmerkmal, wird dieses automatisch dem Zielbereich „kategoriales Merkmal“ 
zugeordnet (2). 
Über die ausgewählten Schlüsselmerkmale können Filter gesetzt werden (vgl. Kapitel 7). Merkmale, 
die zwar gefiltert, jedoch nicht im Tortendiagramm dargestellt werden sollen, müssen vor der 
Filterdefinition dem Zielbereich „statischer Filter“ (4) zugeordnet werden (vgl. Kapitel 7.1). 
Neues Schlüsselmerkmal selbst erstellen 
In diesem Beispiel wurde über Gruppierung erstellen beim Schlüsselmerkmal Kleinräumige Gliederung 
4-stellig ein neues Schlüsselmerkmal definiert. Der Klick auf das Kettensymbol lässt einen modalen 
Dialog aufpoppen. 
 
 
Aus der Drop-Down-Liste (Abb. 91 (2)) sind bereits verfügbare Definitionen abrufbar. Der Name für das 
neue Schlüsselmerkmal kann hier (3) festgelegt werden, oder aus der Drop-Down-Liste (2) 
übernommen werden. Nach Klick auf Übernehmen (4) erscheint das neue Schlüsselmerkmal in der 
Auswahlliste der Schlüsselmerkmale (Abb. 90 (7)) und kann von dort aus auf einen Zielbereich gezogen 
werden. 
Tortendiagramme können nach ihrer Erstellung durch die Verwendung dynamischer Filter auf die 
gewünschte Sicht eingeschränkt werden. Dazu müssen die Merkmale, deren Ausprägungen zur 
Definition der Filter verwendet werden sollen, in dem Zielbereich „dynamischer Filter“ (Abb. 90 (5)) 
hinzugefügt werden (vgl. Kapitel 7.2). 
Soll für jede Ausprägung eines Merkmals ein eigenes Tortendiagramm erzeugt werden, muss das 
Schlüsselmerkmal dem Zielbereich „Seitenmerkmale“ (Abb. 90 (6)) zugeordnet werden (vgl. Kapitel 8). 
Nach einem Mausklick auf die Schaltfläche „Starten“ wird das Tortendiagramm erstellt und als HTML-
Seite ausgegeben (Abb. 92). Die Grafik kann nach der Betätigung der Schaltfläche „Diagramm-Menü“ 
(1) ausgedruckt oder in den Grafikformaten PNG, JPEG, PDF oder SVG exportiert werden (vgl. Kapitel 
10.5.7). 
Abbildung 91: Eigenes Schlüsselmerkmal erstellen 
1 
1 
2 
3 
4

## Page 95

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
89 
 
 
Abbildung 92: Tortengrafik 
 
10.5.3 Pyramidengrafik 
Pyramiden sind eine Sonderform der grafischen Darstellung. Üblicherweise wird in einer 
Pyramidengrafik die Altersstruktur einer Bevölkerung dargestellt (Bevölkerungs- oder Alterspyramide). 
Die Bezeichnung geht dabei auf die Form zurück, die die Grafik annimmt, wenn in ihr die 
demographischen Daten eines vorindustriellen Staates dargestellt werden. Da hier die jüngsten 
Jahrgänge, die die Basis der Grafik bilden, die meisten Vertreter stellen und die Zahl der Angehörigen 
eines Jahrgangs mit zunehmendem Alter abnimmt, entsteht das Bild einer Pyramide. Diese 
Bezeichnung hat sich gehalten, auch wenn sich in den meisten Industriestaaten die Altersstruktur 
aufgrund der verringerten Sterblichkeit, der gestiegenen Lebenserwartung und der gesunkenen 
Geburtenrate schon längst von der ursprünglichen Pyramide weg entwickelt hat und eher an einen 
Nadelbaum oder an eine Zwiebel erinnert. 
Die Pyramidengrafik verfügt über folgende Zielbereiche für die Merkmalsauswahl (Abb. 93): 
• 
Wertemerkmal: Das darzustellende Wertemerkmal wird an der X-Achse abgetragen (1). In 
einer klassischen Bevölkerungspyramide, in der die Anzahl der Menschen je Altersjahr 
angezeigt wird, wird an dieser Stelle die Anzahl der Personen abgetragen. 
• 
Kategoriale Merkmale: In einer klassischen Bevölkerungspyramide wird der Y-Achse das 
Schlüsselmerkmal „Altersjahre“ oder „Altersgruppe“ zugeordnet (2). Dabei bildet die erste 
Ausprägung des Merkmals (der jüngste Jahrgang oder die jüngste Altersgruppe) die Basis der 
Grafik. 
• 
Trennendes Merkmal: Durch die Anordnung der Y-Achse in der Mitte der X-Achse werden in 
der Regel links die Anteile der Männer und rechts die Anteile der Frauen dargestellt. Das 
trennende Merkmal (3) ist daher standardmäßig das Merkmal „Geschlecht“.

## Page 96

Auswertungsassistent - Anwendungshandbuch 
90 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
Abbildung 93: Die Zielbereiche des Präsentationstyps Pyramidengrafik sind um die schematische Darstellung einer Pyramide 
angeordnet. Dies ist keine Vorschau, aber eine sinnvolle Orientierungshilfe bei der Anordnung der Merkmale. 
Die Zielbereiche der Pyramidengrafik sind um die schematische Darstellung einer Pyramide 
angeordnet (4). Diese Abbildung dient lediglich der Orientierung bei der Zuordnung der Merkmale zu 
den Zielbereichen und ist keine Vorschau. Da die Ausprägungen des kategorialen Merkmals an der 
Ordinatenachse (Y-Achse) abgetragen werden, befindet sich der entsprechende Zielbereich neben der 
Pyramidendarstellung (2) – wobei auch zwei kategoriale Merkmale ausgewählt werden können. Das 
Wertemerkmal wird entsprechend der Anordnung an den Abszissenachsen (X-Achsen) unterhalb der 
Grafik in dem gleichnamigen Zielbereich abgelegt (1). Der Zielbereich für das trennende Merkmal 
befindet sich oberhalb der Pyramidendarstellung (3). Nach der Zuordnung des trennenden Merkmals 
sind die beiden Ausprägungen, die links und rechts der Mittelachse dargestellt werden sollen, 
auszuwählen. Dazu erscheinen nach der Zuordnung des trennenden Merkmals im Zielbereich zwei 
Auswahlmenüs (Pulldown-Menüs) unterhalb des Merkmalfeldes (5). In dem rechten Auswahlmenü 
muss die Ausprägung der rechten, in dem linken die Ausprägung der linken Pyramidenseite festgelegt 
werden. 
 
Hinweis: In einer Pyramidengrafik lassen sich auch andere Sachverhalte als der Altersaufbau einer 
Bevölkerung anzeigen. Sie ist prädestiniert für den direkten Vergleich zwischen zwei Ausprägungen 
eines Beobachtungsobjektes und immer dann geeignet, wenn die zu vergleichende Eigenschaft durch 
viele Ausprägungen gekennzeichnet ist. So können beliebige mehrdimensionale Eigenschaften 
zwischen zwei Zeitbezügen, zwischen zwei räumlichen Einheiten, zwischen zwei Bevölkerungsgruppen, 
zwischen zwei Haushaltstypen usw. verglichen werden (Abb. 94 und 95). 
 
1 
2 
4 
5 
6 
7 
8 
9 
3

## Page 97

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
91 
Über das ausgewählte Schlüsselmerkmal kann ein Filter gesetzt werden (vgl. Kapitel 7). Merkmale, die 
nicht in der Pyramidengrafik dargestellt werden sollen, müssen vor der Filterdefinition dem Zielbereich 
„statischer Filter“ (6) zugeordnet werden (siehe Kapitel 7.1). 
Pyramidengrafiken können nach ihrer Erstellung durch die Verwendung dynamischer Filter auf die 
gewünschte Sicht eingeschränkt werden. Dazu müssen die Merkmale, deren Ausprägungen zur 
Definition der Filter verwendet werden sollen, in dem Zielbereich „dynamischer Filter“ (7) hinzugefügt 
werden (siehe Kapitel 7.2). 
Soll für jede Ausprägung eines Merkmals eine eigene Pyramide erzeugt werden, muss das 
Schlüsselmerkmal dem Zielbereich „Seitenmerkmale“ (8) zugeordnet werden (vgl. Kapitel 8). 
Nach einem Mausklick auf die Schaltfläche „Starten“ (9) wird die Pyramidengrafik (Abb. 94) erstellt 
und als HTML-Seite ausgegeben. Die Grafik kann nach der Betätigung der Schaltfläche „Diagramm-
Menü“ (1) ausgedruckt oder in den Grafikformaten PNG, JPEG, PDF oder SVG exportiert werden (vgl. 
Kapitel 10.5.7). 
Im rechten unteren Eck (siehe dazu Abb. 94 (2)) kann die Grafik innerhalb der HTML-Seite vergrößert 
oder verkleinert werden. 
 
 
 
Abbildung 94: Die Pyramidengrafik wird klassischerweise für die Darstellung der Altersstruktur einer Bevölkerung verwendet. 
 
1 
2

## Page 98

Auswertungsassistent - Anwendungshandbuch 
92 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
Verschiedene Optionen sind möglich, hier werden nur einige beschrieben. 
 
Abbildung: 96: Optionen - Diagrammoptionen - Datenachse 
Im Falle, dass jeweils nur ein kategoriales und ein Wertemerkmal ausgewählt sind, kann mithilfe 
einer zusätzlichen Datenreihe der jeweilige Überschuss für jede Kategorie dargestellt werden (Abb. 
96 (1)). Zur Kenntlichmachung des Überschusses wird der jeweilige Balkenabschnitt in der für eine 
zweite oder dritte Datenreihe festgelegten Farbe dargestellt. 
Zur besseren Lesbarkeit können die Balken mit einem Rahmen versehen werden (2). 
Die Farbzuordnung der Datenreihe (3) kann den eigenen Wünschen angepasst werden. Sie ist unter 
„Optionen“, „Diagrammoptionen“ und dort bei der Auswahl „Daten“ vorzufinden (siehe dazu Kapitel 
10.5.6). 
 
10.5.4 Spinnennetzdiagramm 
Das Spinnennetzdiagramm bietet drei Varianten der grafischen Darstellung: Linien, Flächen und 
Säulen. Ausgewählt wird eine Variante über die kleinen Symbolgrafiken. Die jeweils ausgewählte 
Darstellungsform wird dann oberhalb dieser drei Symbolgrafiken in vergrößerter Form angezeigt. 
Abbildung 95: Die Pyramidengrafik kann auch für die Darstellung anderer Sachverhalte 
verwendet oder modifiziert werden. 
1 
2 
3

## Page 99

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
93 
Die Auswahl der Merkmale, die in einem Spinnennetzdiagramm dargestellt werden sollen, erfolgt 
durch das Anklicken eines Schlüssel- oder eines Wertemerkmals in der Auswahlliste und Ziehen bei 
gehaltener Maustaste in den jeweiligen Zielbereich der Grafik. In der Regel werden Schlüsselmerkmale 
in das Feld Achsen abgelegt und Wertemerkmale in das Feld Profile (siehe Abbildung 98). Es gibt aber 
auch Ausnahmen, in denen eine umgekehrte Belegung Sinn macht. 
Mittels der (unter Umständen gefilterten) Schlüsselmerkmale lassen sich Ankerpunkte für ein 
Spinnennetz festlegen, die durch Rasterlinien verbunden werden. Ausgehend von den höchsten 
Werten für ein Wertemerkmal wird automatisch die Größenordnung für die einzelnen Bereiche 
zwischen den Rasterlinien festgelegt.  
Die Rasterlinien können durch die Einstellung in den Optionen polygonal oder kreisrund (Polar- oder 
Radardiagramm) dargestellt werden; standardmäßig ist die polygonale Darstellung ausgewählt wie im 
Symbolbild. Die kreisrunde Darstellung eignet sich besonders für die Darstellung in Säulenform, wobei 
man passender von Kuchenstückform sprechen könnte. 
        
 
Abbildung 97: Spinnennetz: Säulendiagramm – hier sind kreisrunde Rasterlinien grafisch passender als polygonale. 
 
Die klassische Form des Spinnennetzdiagramms ist die Linien- oder Flächendarstellung. Generell 
müssen für ein Netzdiagramm mindestens drei Kategorien existieren, also beim Schlüsselmerkmal 
Schulform zum Beispiel: Hauptschule, Realschule, Gymnasium, damit ein Netz aufgespannt werden 
kann. Die Anzahl der Kategorien wird im Grunde nur begrenzt durch die Notwendigkeit der 
Übersichtlichkeit. 
Werden mehrere Wertemerkmale zugleich dargestellt, werden sie in verschiedenen Farben angezeigt. 
In der Abbildung 97 rechts oben Schüler Insgesamt (blau) und darunter Schüler weiblich (dunkelgrau). 
Die Farbzuordnung lässt sich unter Optionen – Diagrammoptionen verändern (siehe dazu das Kapitel 
10.5.5).

## Page 100

Auswertungsassistent - Anwendungshandbuch 
94 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 98: Schlüsselmerkmal Schulform (gefiltert) und zwei Wertemerkmale 
 
Abbildung 99:  Grafische Darstellung der Auswahl aus Abbildung 98 
Zwischen den Ankerpunkten (Abb. 99 (1)) werden Rasterlinien (2) aufgespannt.  
4 
2 
1 
3

## Page 101

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
95 
Fährt man mit der Maus über die einzelnen Ankerpunkte, die Schulform-Kategorien, werden in diesem 
Beispiel die Zahlen für die Schüler Insgesamt und darunter Schüler weiblich als Popup (3) dargestellt. 
Die Legende am Fuß der Grafik zeigt zudem noch einmal die Farbzuordnung an.  
Durch einen Klick auf das Drei Balken Icon (4) öffnet sich ein Menü, das die Auswahl lässt zwischen 
dem direkten Druck der Grafik oder der Speicherung in verschiedenen Formaten: JPEG, PNG, SVG oder 
PDF. Die Druckqualität (und ohne Menüleiste) erhöht sich jedoch, wenn die Grafik zunächst exportiert 
wird und dann ausgedruckt wird. 
10.5.5 Punktdiagramm 
Einfache Punktdiagramme zeichnen innerhalb eines Koordinatensystems metrische Merkmale als 
Punkte. Auf der horizontalen Achse wird die unabhängige Variable eingetragen, auf der Y-Achse die 
davon abhängige Variable. Ein Beispiel hierfür ist die Anzahl von Kraftfahrzeugen in 100.000er-
Schritten auf der X-Achse, der CO2-Ausstoß auf der Y-Achse. Verbindet man diese Punkte miteinander, 
ergibt sich ein Liniendiagramm mit einer Ursprungsgeraden. 
Komplexe Punktdiagramme ermöglichen die Veranschaulichung weiterer Abhängigkeiten. In der 
Abbildung 100 unten wird beispielsweise die Anzahl der Haushalte mit Kindern (1) und deren 
Durchschnittsalter (2) in Korrelation gesetzt, und zwar je nach Sozialquartier (3). Letzteres wird durch 
verschiedene Punktfarben voneinander abgesetzt. In einer erweiterten Fassung dieses 
Punktdiagramms wird ein vierter Wert hinzugefügt: der Anteil von Personen mit Migrationshintergrund 
unter 27 Jahren (in diesen Sozialquartieren), dargestellt durch die Punktgröße. Das Ergebnis erinnert 
an Blasen, deshalb wird diese Darstellung auch „Blasendiagramm“ genannt. Doch zuerst die 
Einstellungen für das Punktdiagramm mit drei Variablen. Das Jahr wurde über den Filter auf das Jahr 
2015 beschränkt (4). Das Ergebnis dieser Einstellungen wird in Abbildung 101 dargestellt. 
 
Abbildung 100: Punktdiagramm mit Auswahl dreier Variablen: Durchschnittsalter, Anzahl Haushalte und Jahr 
 
1 
2 
3 
4

## Page 102

Auswertungsassistent - Anwendungshandbuch 
96 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Abbildung 101: Auswertung der Daten 
 
Zusätzlich wird nun eine vierte Variable, der Anteil der Haushalte mit 3 und mehr Kindern, hinzugefügt; 
sie wird über die Punktgröße dargestellt (Abb. 102 (5)). 
 
Abbildung 102: Wertemerkmal Anteil der Haushalt mit 3 oder mehr Kindern im Feld Punktgröße 
 
Das Resultat ist in Abbildung 103 dargestellt: 
5

## Page 103

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
97 
 
Abbildung 103: Anteil der Haushalte mit 3 und mehr Kindern je Sozialquartier durch Punktgröße erkennbar 
 
Interpretation der Grafik 
Dargestellte Merkmale: 
▪ 
auf der y- Achse wird das Durchschnittsalter dargestellt 
▪ 
auf der x- Achse der Anteil der Haushalte mit Kindern veranschaulicht 
▪ 
an der Punktgröße erkennt man den Anteil der Haushalte mit 3 oder mehr Kindern in Prozent 
▪ 
die verschiedenen Farben kennzeichnen die Stadtbezirke der Stadt Oberhausen  
 
Eine nicht unbedingt überraschende Erkenntnis: je größer der Anteil der Haushalte mit Kindern, desto 
geringer das Durchschnittsalter. 
 
Die Stadtbezirke lassen sich in verschiedene Typen einteilen:  
▪ Typ 1 geringes Kinderaufkommen: Schlad, Königshardt, Walsumer Mark, Alsfeld,  
 
 
Schmachtendorf 
▪ Typ 2 mäßiges Kinderaufkommen: Innenstadt, Marienviertel Ost, Brückentorviertel 
▪ Typ 3 hohes Kinderaufkommen:  Bero- Zentrum/City West  
 
Der Kinderanteil im Bereich der Innenstadt (Typ 2 und Typ 3) ist wesentlich höher als bei Typ 1.  
Bei Typ 2 gibt es zum einen viele Haushalte mit Kindern, wie beispielsweise Marienviertel Ost, 
Brückentorviertel oder die Innenstadt und zum anderen haben die Haushalte zugleich 3 oder mehr 
Kinder, was sich an der Punktgröße erkennen lässt. Das Durchschnittsalter ist gering. 
Auffälligkeiten: 
Schlad 
Bero-
Zentrum/ 
City West 
Innenstadt  
Alsfeld
Walsumer 
Mark 
Königshardt 
Marienviertel Ost 
Brückentor-
viertel 
Schmachtendorf

## Page 104

Auswertungsassistent - Anwendungshandbuch 
98 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
• 
Der Stadtbezirk Bero- Zentrum/City West sticht im Vergleich zu Typ 2 hervor: geringes 
Durchschnittsalter, großer Anteil der Haushalte mit Kindern und zudem hoher Anteil der Haushalte 
mit 3 und mehr Kindern. 
• 
Schlad (liegt im Gebiet um die Innenstadt) mit einem niedrigen Anteil an Haushalten mit Kindern, 
einem sehr geringen Anteil an Haushalten mit 3 oder mehr Kindern und einem hohen 
Durchschnittsalter. 
• 
Schmachtendorf (liegt außerhalb des Stadtzentrums) hat beinahe dieselbe Punktgröße wie Schlad, 
jedoch einen größeren Anteil an Haushalten mit Kindern. 
• 
Bei Typ 1 (außerhalb des Stadtzentrums, ausgenommen Schlad) ist weder der Anteil der Haushalte 
mit Kindern(x-Achse) noch der Anteil der Haushalte mit 3 oder mehr Kindern (Punktgröße) stark 
vertreten.  
• 
Königshardt weist mit über 48 das höchste Durchschnittsalter auf, das Kindesaufkommen ist 
gering.  
• 
Vergleicht man Typ 1 (Walsumer Mark, Alsfeld, usw.) mit Typ 2 (Innenstadt usw.) so fällt auf, dass 
der Anteil der Hauhallte mit Kindern ungefähr gleich ist, jedoch der Anteil der Haushalte mit 3 oder 
mehr Kindern stark abfällt.  
• 
Beim Anteil der Haushalte mit 3 oder mehr Kindern haben Alsfeld mit einem Prozentwert von 9,09 
und der Walsumer Markt mit einem Wert von 8,33 Prozent dabei weniger als die Hälfte gegenüber 
der Innenstadt, die einen Prozentwert von 20,31 aufweist.  
 
Beim Überfahren der Punkte mit der Maus werden die genauen Zahlenangaben angezeigt.  
Hinweis: Selbst wenn Sie ein Merkmal in den Zielbereich „Punktbeschriftung“ aufgenommen haben, 
können die Punkte in der Auswertung – beispielsweise aus Gründen der Übersichtlichkeit – nachträglich 
jederzeit ausgeblendet werden. Dazu muss im Auswertungsassistenten in der unteren Leiste der 
Menüpunkt Optionen gewählt werden. Es wird die Optionenauswahlseite geöffnet, die ein Menü mit 
verschiedenen Konfigurationsmöglichkeiten enthält. Dort muss der Punkt Diagrammoptionen 
ausgewählt werden. Daraufhin den Reiter Daten auswählen. Dort ist ein Häkchen gesetzt bei 
„Datenbeschriftung anzeigen“. Entfernen Sie das Häkchen, dann startet die Auswertung erneut und die 
Zahlenbeschriftung ist nicht mehr sichtbar.

## Page 105

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
99 
10.5.6 Konfigurationsmöglichkeiten der verschiedenen Grafiken 
Im Folgenden werden die Konfigurationseinstellungen der Grafikausgabe (Diagrammoptionen) 
beschrieben. Die Einstellungsmöglichkeiten der Zusatzinformationen und die Textersetzungen können 
Sie dem Kapitel 9.2 entnehmen. Die Konfiguration der Darstellung von Schlüsseltabellen wird in Kapitel 
10.1.2 ausführlich behandelt. 
 
Abbildung 104: Diagrammoptionen mit drei Reitern: Allgemein, Daten und Achsen bei Säulen/Balken als Darstellungsform. 
Die Inhalte der Reiter (Allgemein, Daten und Achsen) sind bei Säulen und Balken identisch. Bei Linien 
und Flächen unterscheiden sie sich etwas. Bei Diagrammoptionen wie Torte, Pyramide, Punkt- und 
Spinnennetzdiagramm sind sie ebenfalls leicht verschieden.  
Im Folgenden werden zuerst die einzelnen Wahlmöglichkeiten bei den Diagrammoptionen für die 
Grafikformen Säulen bzw. Balken der Standardgrafik aufgeführt und erläutert. Diese sind für fast alle 
anderen Darstellungsformen leicht eingeschränkt respektive angepasst und können daher beispielhaft 
auch für die anderen stehen. 
 
Diagrammoptionen 
Durch einen Klick auf die Schaltfläche „Optionen“ im 
Fußbereich der Merkmalsauswahlseite können für die Typen 
Standardgrafik 
(Balken, 
Säulen, 
Linien, 
Flächen), 
Tortendiagramm, Pyramidengrafik und Spinnennetzdiagramm 
unter den Reitern Allgemein, Daten und Achsen nachfolgende 
Einstellungen vorgenommen werden. 
 
Die Reiter Allgemein und Achsen sind bei allen Standardgrafiken 
fast identisch. 
Der Reiter Daten hat – je nach gewählter Präsentationsform – 
verschiedene Einstellungsmöglichkeiten.

## Page 106

Auswertungsassistent - Anwendungshandbuch 
100 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
Diagrammoptionen – Allgemein 
Größe 
 
Die zu erstellende Grafik kann für die Ausgabe auf die 
Papierformate Din A5, Din A4 und Din A3 angepasst werden. 
Unter Berücksichtigung eines Randes von jeweils 5 mm ergibt 
das für die verschiedenen Papierformate folgende Maße: 
 
Auflösung 
niedrig 
(96 dpi) 
mittel 
(150 dpi) 
hoch 
(300 dpi) 
Din A5 
756 x 522 
1.181 x 815 
2.362 x 1.630 
Din A4 
1.084 x 756 
1.695 x 1.181 
3.390 x 2.362 
Din A3 
1.550 x 1.084 
2.421 x 1.695 
4.843 x 3.390 
 
Für die Bildschirmdarstellung werden die Werte halbiert und 
1:1 in Pixel als Maximalwerte übernommen. Darüber hinaus 
besteht die Möglichkeit, die Grafik mittels der Maus beliebig zu 
verkleinern, wobei die jeweils aktuellen Pixelmaße angezeigt 
werden. 
Insgesamt bedeutet das, dass z.B. eine Grafik, die am Bildschirm 
das Format 591 x 848 Pixel hat, beim Ausdruck mit 150 dpi 
(mittlere Auflösung) ein Din-A4-Blatt im Querformat vollständig 
(vom Rand abgesehen) ausfüllt. 
Die in der Standardeinstellung vorgegebene Größe DIN A5 
eignet sich – im Zusammenhang mit einer Ausgabe im 
Querformat und in einer hohen Auflösung – in den meisten 
Fällen gut für eine Ausgabe am Bildschirm. 
Auflösung 
 
 
Die Grafik kann in verschiedenen Auflösungen ausgegeben 
werden. Die Standardeinstellung hoch entspricht einer 
Auflösung von 300 dpi. Neben der hohen Auflösung stehen 
noch die Auflösungen mittel (= 150 dpi) und niedrig (= 96 dpi) 
zur Auswahl. 
Ausrichtung 
 
 
In der Grundeinstellung werden Grafiken im Querformat 
ausgegeben. Die Grafiken können jedoch auch im Hochformat 
erstellt werden. 
Automatische Größenanpassung 
an das Ausgabe-Fenster 
 
Die Aktivierung dieser Option führt dazu, dass die Größe der 
Grafik am Bildschirm in Abhängigkeit von der Größe des 
Browser-Fensters bestimmt wird. Wird das Fenster in der 
Größe verändert, z.B. horizontal gestaucht und vertikal 
gestreckt, so wird auch die Grafik entsprechend angepasst, wie 
im Beispiel unten zu sehen ist. 
 
Darstellung in Vollbildmodus:

## Page 107

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
101 
 
 
Darstellung mit verändertem Seitenverhältnis: 
 
 
Schriftart 
 
Hier ist die zu verwendende Schriftart einzutragen, wenn nicht 
die Standardschriftart verwendet werden soll. Der Name muss 
so 
eingetragen 
werden 
wie 
er 
in 
der 
Windows-
Systemsteuerung unter Darstellung und Anpassung -> 
Schriftarten erscheint (z.B. Sans, Console Standard, Segoe 
Script oder Lucida). Voraussetzung für die Verwendung der 
angegebenen Schriftart ist, dass sie auf dem Client, auf dem die 
Auswertung ausgeführt wird, auch installiert ist. 
Schriftgröße 
 
 
Die Basisschriftgröße als Ausgangsschriftgröße für die in der 
Grafik verwendeten Schriftgrößen ist auf 12 Punkt eingestellt. 
Durch das Ändern des Wertes werden die Schriftgrößen in der 
Ausgabe entsprechend skaliert. 
Titel 
 
Die vom Auswertungsassistenten generierten Titelzeilen (vgl. 
Kapitel 9.2) werden in der Standardeinstellung in der Grafik 
angezeigt. 
Durch 
einen 
Mausklick 
in 
das 
aktivierte 
Kontrollkästchen „Titel“ kann die Ausgabe der Titelzeilen 
unterdrückt werden. 
Legende 
 
Bei der Auswahl von zwei kategorialen Merkmalen wird die 
Grafik in der Standardeinstellung mit einer Farblegende für die 
Ausprägungen des nachgeordneten Merkmals ausgegeben. Die 
Ausgabe dieser Legende kann durch einen Mausklick auf das 
aktivierte Kontrollkästchen „Legende“ unterdrückt werden.

## Page 108

Auswertungsassistent - Anwendungshandbuch 
102 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Copyright 
 
In der Standardeinstellung wird ein Eintrag in dem Eingabefeld 
als zusätzliche Fußnotenzeile unterhalb der Grafik ausgegeben. 
Hier kann ein beliebiger Text eingetragen werden, der nach 
dem Speichern der benutzerdefinierten Einstellungen jederzeit 
wieder aufgerufen werden kann. Durch einen Mausklick auf das 
vorangestellte Kontrollkästchen 
„Copyright“ wird 
diese 
deaktiviert und die Ausgabe der zusätzlichen Fußzeile 
unterdrückt. 
Rasterlinien 
 
 
 
 
 
 
Die in der Grundeinstellung an der Werteachse ausgegebenen 
Rasterlinien können entweder ausgeblendet oder für beide 
Achsen angelegt werden. 
 
 
Beim Spinnennetzdiagramm besteht hier die Auswahl zwischen 
polygonalen Rasterlinien (Standard) oder kreisrunden. Letztere 
Option ist vor allem empfehlenswert, wenn das Netzdiagramm 
als Säulendiagramm angezeigt werden soll. 
 
Hinweis: Die Einstellung „Rasterlinien für beide Achsen“ ist bei 
der Auswahl von zwei kategorialen Merkmalen und einer 
unabhängigen Anordnung der Säulen oder Balken eventuell 
sinnvoll, da die Rasterlinien an der Ordinatenachse eine 
optische Abgrenzung zwischen den Säulen- oder Balkengruppen 
bilden und somit die Ausprägungen des übergeordneten 
Merkmals übersichtlicher abgegrenzt werden. 
 
Diagrammoptionen – Daten 
Anordnung der Datenreihen 
 
 
 
Diese Einstellungsmöglichkeit erscheint erst, wenn zwei 
mindestens zwei Datenreihen zur Darstellung in der Grafik 
ausgewählt wurden. Dabei werden die Ausprägungen des 
oberen Merkmals im Zielbereich durch die Merkmale des 
unteren Merkmals differenziert. In der Grundeinstellung 
werden die Ausprägungen des zweiten Merkmals als einzelne 
Säulen oder Balken (je nach Ausrichtung der Grafik) 
nebeneinander und nach den Merkmalsausprägungen der 
ersten 
Kategorie 
gruppiert 
dargestellt 
(Anordnung 
= 
unabhängig (1)). Die Auswahl „gestapelt“ oder „normiert 
1

## Page 109

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
103 
 
gestapelt“ führt dazu, dass die einzelnen unabhängigen Säulen 
übereinandergestellt 
bzw. 
die 
einzelnen 
Balken 
aneinandergereiht werden (2). Bei „normiert gestapelt“ 
werden die einzelnen Säulen oder Balken so gestapelt, dass sie 
jeweils 100 Prozent entsprechen. Die Säulen oder Balken sind 
farblich nach den Anteilswerten des zweiten kategorialen 
Merkmals innerhalb der jeweiligen Ausprägung des ersten 
Schlüsselmerkmals unterteilt. 
Farbzuordnungen bei Datenreihen 
 
Wurden zwei kategoriale Merkmale zur Darstellung in der 
Standardgrafik ausgewählt, werden die Ausprägungen des 
zweiten Merkmals unterschiedlich eingefärbt. Die in den 
Optionseinstellungen angebotenen Farben werden dabei in der 
Reihenfolge in die Grafik übernommen, wie sie in der Palette 
angeordnet sind. Die einzelnen Farben können verändert und 
an eigene Bedürfnisse angepasst werden. Der Dialog zum 
Ändern der Farben kann durch einen Doppelklick auf die 
jeweilige Farbe aufgerufen werden. Die Reihenfolge der Farben 
kann durch Anklicken und Ziehen bei gehaltener Maustaste an 
die gewünschte Position verändert werden. Mit dem grau 
hinterlegten „Plus“ (1) lassen weitere Farben generieren und 
hinzufügen (siehe folgenden Punkt „Farbe hinzufügen“). Mit 
einem Doppelklick auf eine der Farben gelangt man ebenfalls in 
das folgende Fenster „Farbe hinzufügen“. Dann wird jedoch 
keine neue Farbe hinzugefügt, stattdessen wird eine 
bestehende Farbe geändert. 
Hinweis: Wurde in einer Standardgrafik nur ein kategoriales 
Merkmal ausgewählt, werden die Säulen, Balken, Linien oder 
Flächen in der ersten Farbe der angezeigten Farbpalette 
dargestellt. 
Farbe hinzufügen 
 
In dem geöffneten Fenster kann eine beliebige Farbe generiert 
werden. Die grobe Farbrichtung kann entweder an dem bunten 
Farbenstrahl in der Mitte oder an dem farbigen quadratischen 
Raster rechts eingestellt werden. Zur Feineinstellung dann den 
Kreis im Farbfeld links an die gewünschte Stelle ziehen. Mit dem 
Befehl „Übernehmen“ wird die generierte Farbe der 
Farbauswahl hinzugefügt. Mit „Abbrechen“ wird das Fenster 
geschlossen, ohne dass eine neue Farbe erstellt bzw. geändert 
wird. 
Wurde das Fenster über Doppelklick auf eine bestehende Farbe 
geöffnet, kann durch „Entfernen“ die Farbe aus der 
Farbauswahl gelöscht werden. 
Farbzuordnungen bei 
Datenreihen 
 
Bei Tortendiagrammen werden alle Segmente der Torte in 
unterschiedlichen Farben dargestellt. Die Reihenfolge dieser 
Farben (im Uhrzeigersinn) entspricht ebenfalls der Reihenfolge 
der Farben der Palette. 
 
Wenn in der Pyramidengrafik die standardmäßige Einstellung 
„selbe Farbe für links und rechts“ ausgestellt ist, wird die linke 
Pyramidenseite in der ersten Palettenfarbe, die rechte in der 
zweiten Farbe eingefärbt. 
Breite von Säulen/Balken 
Breite von Gruppen 
Unter der Option „Breite von Säulen/Balken“ wird angegeben, 
wie breit eine Säule bzw. ein Balken im Verhältnis zum 
2 
1

## Page 110

Auswertungsassistent - Anwendungshandbuch 
104 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
Ausprägungsabschnitt des führenden Merkmals ausgegeben 
werden soll. Bei der Auswahl eines kategorialen Merkmals 
nehmen die Säulen oder Balken in der Grundeinstellung 75 
Prozent des Abschnittes der Ordinatenachse ein, der für die 
Darstellung einer Ausprägung reserviert ist. Bei der Auswahl 
von zwei kategorialen Merkmalen werden die Merkmale des 
führenden Merkmals in Einzelsäulen oder -balken nach den 
Ausprägungen des zweiten Merkmals unterteilt. Dabei werden 
die Einzelsäulen oder -balken nach den Ausprägungen des 
führenden Merkmals gruppiert. In der Standardeinstellung 
nehmen diese Gruppen insgesamt 75 Prozent des Abschnittes 
der Ordinatenachse ein, der für die Darstellung einer 
Ausprägung des führenden Merkmals reserviert ist. 
 
Beim Punktdiagramm kann die Punktgröße zwischen einem 
Mindestwert und einem Maximalwert in Prozent oder Pixeln 
festgelegt werden. 
 
Hinweis: Eine Erhöhung der Prozentangaben führt dazu, dass 
die Säulen oder Balken breiter werden. Eine Verringerung der 
Prozentangaben lässt die Säulen oder Balken schmaler werden. 
Datenbeschriftung 
 
 
 
Die in der Grundeinstellung eingeblendete Datenbeschriftung 
zeigt die der Grafik zugrundeliegenden Werte an. Diese können 
– abhängig vom Grafiktyp – unterschiedlich positioniert werden 
(1): 
 
Säulengrafik: 
1. keine 
2. außen = (Standardeinstellung) oberhalb des jeweiligen 
Datenpunktes und somit über den Säulen bzw. oberhalb 
der jeweiligen Säulenabschnitte 
3. innen = unterhalb des jeweiligen Datenpunktes und somit 
innerhalb der Säulen bzw. der Säulenabschnitte (am 
oberen Rand der Säule bzw. des Säulenabschnittes) 
4. mittig = vertikal zentriert innerhalb der Säulen 
 
Balkengrafik: 
1. keine  
2. außen = (Standardeinstellung) rechts vom jeweiligen 
Datenpunkt und somit rechts außerhalb der einzelnen 
Balken 
3. innen = links vom Datenpunkt und somit innerhalb der 
Balken 
4. mittig = innerhalb der Balken horizontal zentriert 
 
Linien- und Flächengrafik: 
1. keine 
2. mittig = (Standardeinstellung) zentriert oberhalb des 
jeweiligen Datenpunktes 
3. rechts = rechts oberhalb des jeweiligen Datenpunktes 
4. links = links oberhalb des jeweiligen Datenpunktes 
1

## Page 111

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
105 
 
noch: 
Datenbeschriftung 
 
Torte: 
 
1. keine 
2. außen = (Standardeinstellung) außerhalb der Kreis-
segmente 
3. innen = innerhalb der Kreissegmente 
 
 
Pyramide: 
 
1. keine 
2. außen = (Standardeinstellung) links (linke Pyramidenhälfte) 
bzw. rechts (rechte Hälfte) der Datenpunkte und somit 
außerhalb der Balken 
3. innen = rechts (linke Pyramidenhälfte) bzw. links (rechte 
Hälfte) der Datenpunkte und somit innerhalb der Balken 
4. mittig = jeweils horizontal zentriert innerhalb der Balken 
 
Punktdiagramm: 
 
Hier 
kann 
lediglich 
ausgewählt 
werden, 
ob 
die 
Punktbeschriftungen in der Grafik angezeigt werden sollen oder 
nicht. Im Tooltip werden sie unabhängig davon immer 
angezeigt. Außerdem kann festgelegt werden, ob die Schrift 
freigestellt wird, das heißt, ob sie einen weißen Hintergrund 
erhält oder nicht. 
 
 
 
Durch die Aktivierung der Einstellung „keine“ kann die Ausgabe 
der Datenbeschriftung in allen Grafiktypen ausgeschaltet 
werden. 
 
 
In der Grundeinstellung wird die Datenbeschriftung in 
horizontaler 
Ausrichtung 
ausgegeben 
(2). 
Die 
Datenbeschriftung wird dabei freigestellt. Alternativ kann eine 
vertikale Ausgabe der Datenbeschriftung ausgewählt werden. 
Dabei ist jedoch keine Freistellung der Beschriftung möglich. 
 
 
Über die Eingabe eines positiven oder negativen Wertes im 
Eingabefeld „Abstand“ kann der Abstand zwischen dem 
jeweiligen 
Datenpunkt 
und 
seiner 
Datenbeschriftung 
eingestellt werden. 
 
 
In der Grundeinstellung werden große Absolutwerte durch 
einen Tausenderpunkt gegliedert. Dies erhöht die Lesbarkeit 
der Werte. Ist das Tausendertrennzeichen nicht erwünscht, 
kann es hier unterdrückt werden. 
 
2

## Page 112

Auswertungsassistent - Anwendungshandbuch 
106 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
In der Standardeinstellung werden bei der Datenbeschriftung 
Nachkommastellen automatisch ausgegeben. Das bedeutet, 
dass bei Absolutwerten automatisch die im Nachweissystem 
hinterlegte Zahl der Nachkommastellen und bei berechneten 
Wertemerkmalen fünf Nachkommastellen angezeigt werden. 
Die Zahl der gewünschten Nachkommastellen kann hier 
eingestellt werden (0 – 9). 
 
Beim Überfahren der Bildschirmausgabe der Grafik werden 
Details 
(Tooltips) 
zu 
den 
einzelnen 
Ausprägungen 
(Ausprägungstexte und Werte) an der jeweiligen Mausposition 
angezeigt. Diese Anzeige kann hier unterdrückt werden. 
 
Diagrammoptionen – Achsen 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
Datenachse 
 
 
In der Grundeinstellung wird die Datenachse mit der zu 
erstellenden Grafik ausgegeben. Die Ausgabe kann durch das 
Aktivieren der Option „ausblenden“ unterdrückt werden 
(betrifft die Beschriftung und die Linie). 
 
In der Grundeinstellung wird die Maßeinheit, die bei der 
Beschreibung des Wertemerkmals im DUVA-Nachweissystem 
angegeben wurde, bei der Grafikausgabe mit angezeigt. Durch 
die Deaktivierung dieser Option lässt sich die Ausgabe der 
Maßeinheit unterdrücken. 
 
Die in die Eingabefelder eingetragenen Werte definieren den 
sichtbaren Bereich der Datenachse. So führt die Eingabe eines 
Zahlenwertes als Minimum bei einer Säulengrafik dazu, dass 
die Y-Achse (=Datenachse) bei dem eingegebenen Wert von der 
X-Achse geschnitten wird und beim Maximum endet. 
 
In der Standardeinstellung werden bei der Achsenbeschriftung 
Nachkommastellen automatisch ausgegeben. Das bedeutet, 
dass bei Absolutwerten  automatisch die im Nachweissystem 
hinterlegte Zahl der Nachkommastellen und bei berechneten 
Wertemerkmalen fünf Nachkommastellen angezeigt werden. 
Die Zahl der gewünschten Nachkommastellen kann hier 
eingestellt werden (0 – 9).

## Page 113

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
107 
 
In der Grundeinstellung werden große Absolutwerte durch 
einen Tausenderpunkt gegliedert. Dies erhöht die Lesbarkeit 
der Werte. Ist das Tausendertrennzeichen nicht erwünscht, 
kann es hier unterdrückt werden. 
 
In das Eingabefeld „Textrotation“ kann ein Winkel eingegeben 
werden, um den die in der Grundeinstellung horizontal 
ausgerichteten Werte der Achsenbeschriftungen aus der 
Horizontalen gedreht werden sollen. Die Eingabe des Wertes 45 
bedeutet, dass die Achsenbeschriftungen um 45 Grad nach links 
gekippt werden. 
Zweite Datenachse 
 
 
Werden bei einem Standarddiagramm zu einem kategorialen 
Merkmal mehrere Wertemerkmale ausgewählt, kann jetzt in 
den Optionen per Kontrollkästchen eine zweite Werteachse 
aktiviert werden, die auf der rechten Diagrammseite, bzw. 
oberhalb des Diagramms bei Balkendiagrammen, angezeigt 
wird. 
 
Beim Aktivieren der zweiten Werteachse wird ein Bereich mit 
weiteren zugehörigen Optionen sichtbar, die analog zur ersten 
Werteachse die zusätzliche Achse konfigurieren. Im unteren 
Teil des Bereiches werden alle Wertemerkmale bis auf das erste 
mit einem vorangestellten Kontrollkästchen aufgeführt, die 
anzeigt, ob das Merkmal der zweiten Achse zugeordnet wurde 
(selektiert) oder nicht (deselektiert). 
Durch Deselektieren eines solchen Kontrollkästchens kann die 
Zuordnung aufgehoben werden, wodurch das zugehörige 
Merkmal automatisch der ersten Werteachse zugeordnet ist. 
Kategorienachse 
 
 
In der Grundeinstellung wird die Kategorienachse mit der zu 
erstellenden Grafik ausgegeben. Die Ausgabe kann durch das 
Aktivieren der Option „ausblenden“ unterdrückt werden 
(betrifft die Beschriftung und die Linie). 
 
Die Aktivierung der Option „Kategorien umkehren“ bewirkt, 
dass die Ausprägungen in umgekehrter Reihenfolge angezeigt 
werden. 
 
In das Eingabefeld „Textrotation“ kann ein Winkel eingetragen 
werden, um den die Werte der Achsenbeschriftungen aus der 
Horizontalen gedreht werden sollen. Die Eingabe des Wertes 45 
bedeutet, dass die Achsenbeschriftungen um 45 Grad nach links 
gekippt werden.

## Page 114

Auswertungsassistent - Anwendungshandbuch 
108 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Die Diagrammoptionen unterscheiden sich in den verschiedenen Präsentationsformen nicht 
wesentlich. Der Hauptunterschied besteht in der Möglichkeit der Anordnung und der Sortierung von 
Datenreihen. Die Optionen sind bei mehrfacher Auswahl von Wertemerkmalen in der Darstellung als 
Säulen bzw. Balken am vielfältigsten. Bei der Tortengrafik ist der Reiter Achsen leer, da es bei einer 
Tortengrafik keine Achsen gibt.  
Eine Besonderheit bei der Erstellung von Liniendiagrammen bedarf einer Erläuterung. Fehlen bei 
einem Liniendiagramm in einer Datenreihe einzelne Werte, werden standardmäßig die Linien 
unterbrochen, wie Abb. 105 zeigt: 
 
 
Abbildung 105: Liniendiagramm mit unterbrochenen Linien aufgrund fehlender Werte 
 
Um solch eine teils unbrauchbare Ausgabe zu vermeiden, wurde unter Optionen im Bereich 
Diagrammoptionen auf dem Tab Daten die Option Nullwerte überspringen (vgl. Abb. 106) hinzugefügt, 
deren Aktivierung bewirkt, dass die Linien für die betroffenen Datenreihen unter Auslassung der 
fehlenden Datenpunkte fortgeführt bzw. verbunden werden. 
 
 
 
Abbildung 106: Diagrammoption bei Liniendiagrammen: Option Nullwerte überspringen 
 
Die folgende Grafik zeigt das Ergebnis:

## Page 115

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
109 
 
 
Abbildung 107: Liniendiagramm mit durchgehenden Linien bei fehlenden Werten 
10.5.7 Möglichkeiten des Grafik-Exports 
Hinweis: Der Export von Diagrammen erfolgte bisher standardmäßig unter Nutzung des öffentlichen 
Export-Servers der Firma Highsoft, von der die zur Erzeugung der Diagramme verwendete JavaScript-
Bibliothek Highcharts stammt. Die Nutzung dieses externen Servers ist mit zwei Einschränkungen 
verbunden. Zum einen werden die zur Erzeugung eines Diagramms benötigten Daten kurzfristig auf 
diesem Server gespeichert und zum anderen können aufgrund von Highsofts Zugriffsrichtlinien nur 10 
Diagramme pro Minute erzeugt werden, um allen Anforderungen einen fairen Zugriff zu ermöglichen. 
Der erste Punkt ist kritisch, wenn es sich um nicht öffentliche Daten handelt, der zweite macht es 
unmöglich, bei Nutzung eines Seitenmerkmals mit mehr als 10 Ausprägungen alle Seiten zu exportieren. 
 
Die Nutzung des Client-seitigen Exports per JavaScript-Bibliotheken war bisher nur möglich, wenn der 
Export-Server nicht erreichbar war und der Benutzer das Recht dazu besaß. Als Konsequenz daraus 
wurde der Diagrammexport jetzt dahingehend umgestellt, dass standardmäßig der Client-seitige 
Export per JavaScript-Bibliotheken genutzt wird. 
Sollte das damit erzielte Ergebnis nicht zufriedenstellend sein, kann über eine auswertungsspezifische 
Option (siehe Abbildung) die Nutzung des Export-Servers für eine einzelne Auswertung aktiviert werden. 
Diese Option wird nur angezeigt, wenn in der ASW-Konfiguration ein Export-Server angegeben wurde, 
und ist standardmäßig deaktiviert. 
 
 
Abbildung 108: Diagrammoptionen Allgemein: Exportserver verwenden

## Page 116

Auswertungsassistent - Anwendungshandbuch 
110 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Wurde ein eigener Export-Server eingerichtet, sollte dieser natürlich auch unkompliziert verwendet 
werden können. Dazu ist es sinnvoll, diese Option in den Standardoptionen zu aktivieren, um sie nicht 
bei jeder einzelnen Auswertung erst aktivieren zu müssen. 
Die Benutzergruppeneinstellung Lokalen Export erlauben ist damit obsolet geworden und wird vom 
ASW nicht mehr berücksichtigt. 
 
Die vom Auswertungsassistenten erzeugten Standardgrafiken, Tortendiagramme, Pyramidengrafiken, 
Punktdiagramme und Spinnennetzdiagramme können direkt ausgedruckt oder in einem Grafikformat 
exportiert und somit in anderen Anwendungen eingelesen und verwendet werden (Abb. 109). Der 
Druck bzw. der Grafikexport werden durch die Betätigung der Schaltfläche „Diagramm-Menü“ (1) 
gestartet. Als Ausgabeformate stehen PNG, JPEG, PDF und SVG zur Verfügung (2). Die Druckqualität 
erhöht sich, wenn die Grafik zunächst exportiert wird und dann ausgedruckt wird. 
 
 
Abbildung 109: Der Dialog zum Öffnen oder Speichern des Grafikexports ist vom jeweiligen Internet-Browser abhängig und 
wird daher hier nicht näher erläutert. 
Hinweis: PNG (Portable Network Graphics) ist das im Internet inzwischen meistverwendete verlustfreie 
Format für Rastergrafiken. PNG-Dateien können Transparenzinformationen enthalten und das PNG-
Format unterliegt keiner Patentbeschränkung.  
JPEG ist der Oberbegriff für eine Sammlung von Komprimierungs- und Kodierungsmethoden, von denen 
jedoch nur die verlustbehaftete Kompression weithin verbreitet und als JPEG- oder JPG-Grafik bekannt 
ist. Da das Format eher für natürliche Rasterbilder entwickelt wurde, eignet es sich nur bedingt für 
Grafiken, die einen hohen Linien- oder Kanten-Anteil beinhalten. 
PDF (Portable Document Format) ist ein plattformunabhängiges Dateiformat und hat als 
Austauschformat für Dokumente nahezu beliebiger Art einen sehr hohen Verbreitungsgrad.  
SVG (Scalable Vector Graphics) basiert auf XML und ist eine vom World Wide Web Consortium (W3C) 
empfohlene Spezifikation zur Beschreibung zweidimensionaler Vektorgrafiken. SVG-Grafiken können 
von den gebräuchlichsten Browsern ohne nachträgliche Installation von Erweiterungen dargestellt und 
– aufgrund ihres XML-basierten Datenformates – von vielen anderen Anwendungen verwendet werden. 
2 
1

## Page 117

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
111 
10.6 Thematische Karte 
Neben Tabellen und Grafiken sind thematische Karten eine etablierte Möglichkeit der räumlichen 
Informationsdarstellung. DUVA verfügt mit dem DUVA-Kartentool über eine eigenständige 
webbasierte Anwendung zur Kartenerstellung, die in den DUVA-Auswertungsassistenten integriert 
wurde. 
Hinweis: Zu dem DUVA-Kartentool existieren eigene Beschreibungen und Bedienungsanleitungen. 
Daher wird die Kartenproduktion in dieser Auflage des Handbuchs zunächst nur bis zur Übergabe der 
erforderlichen Steuerinformation an das Kartentool anhand eines Beispiels erläutert.  
Eine Kartenproduktion ist nur mit Dateien möglich, die über mindestens ein räumliches Merkmal 
verfügen. Als räumliche Merkmale werden die Schlüsselmerkmale erkannt, denen im DUVA-
Nachweissystem Geometrien (Shape-Files) zugeordnet wurden. Verfügt eine ausgewählte Datei nicht 
über räumliche Merkmale, wird der Präsentationstyp „Karte“ in der Präsentationsauswahl nicht zur 
Auswahl angeboten (vgl. Kapitel 5). Bei dem Vorhandensein von räumlichen Merkmalen wird die 
Schaltfläche „Karte“ dagegen aktiv und kann per Mausklick angewählt werden (Abb. 94 (1)).  
 
Abbildung 94: Der Präsentationstyp Karte kann nur dann ausgewählt werden, wenn die ausgewählte Datei auch räumliche 
Merkmale beinhaltet. 
Nach der Auswahl des Präsentationstyps Karte wird die Merkmalsauswahl gestartet (Abb. 95). Dieses 
Auswahlseite ist ebenfalls dreigeteilt und verfügt über eine Merkmalsauswahlliste (links (1)), die 
Zielbereichen, die um eine symbolische Kartendarstellung angeordnet sind (Mitte (2)) sowie den 
Bereich zur Anzeige der Ausprägungen des jeweils aktiven Merkmals und der Auswahl der 
Filterkriterien (rechts (3)). 
1

## Page 118

Auswertungsassistent - Anwendungshandbuch 
112 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
Abbildung 95: Der Präsentationstyp Karte kann nur dann ausgewählt werden, wenn die ausgewählte Datei auch räumliche 
Merkmale beinhaltet.  
Neben den Schlüssel- und Wertemerkmalen verfügt die Merkmalsauswahl für die Erstellung einer 
thematischen Karte über ein drittes Auswahlfach für „räumliche Merkmale“ (4). Um eine Karte 
erstellen zu können, muss von den räumlichen Merkmalen eines (!) ausgewählt und dem Zielbereich 
„Räumliches Merkmal“ (5) zugeordnet werden. 
Die Auswahl der übrigen Merkmale, die in die Kartenerstellung einfließen sollen, erfolgt durch das 
Anklicken der gewünschten Schlüssel- und Wertemerkmale in der Auswahlliste (1) und durch Ziehen 
bei gehaltener Maustaste in den jeweiligen Zielbereich der Karte: Dabei können Schlüsselmerkmale 
nur dem Zielbereich „kategoriale Merkmale“ (6) und Wertemerkmale nur dem Zielbereich 
„Wertemerkmale“ (7) zugeordnet werden. Dies gilt auch für vom DUVA-Auswertungsassistenten 
berechnete neue Wertemerkmale (vgl. Kapitel 6.6). 
Über die ausgewählten Schlüsselmerkmale können Filter gesetzt werden. Merkmale, die nicht in der 
Karte dargestellt werden sollen, müssen vor der Filterdefinition dem Zielbereich „statischer Filter“ (8) 
zugeordnet werden (vgl. Kapitel 7.1). 
In dem hier gewählten Beispiel aus der Haushaltestatistik wurde das räumliche Merkmal „Kleinräumige 
Gliederung 3-stellig (Gemeindeteil)“ ausgewählt (5). Als Wertemerkmal wurde aus den in der Datei 
vorhandenen Werten „Anzahl der Kinder im Haushalt“ und „Anzahl Haushalte“ die „durchschnittliche 
Kinderzahl im Haushalt“ berechnet (7). Durch das Setzen eines Filters wird die Sicht auf 
Familienhaushalte mit Kindern (3 u. 8) eingeschränkt. Unter den Optionseinstellungen wurde die 
Anzahl der Nachkommastellen für das ausgewählte Wertemerkmal auf eine Stelle reduziert. Nach 
einem Mausklick auf die Schaltfläche „Starten“ (9) wird das Kartentool gestartet, in dem die eigentliche 
Auswahl und Definition der Kartenebenen erfolgt (Abb. 96 (1) u. 97). 
1 
2 
3 
4 
5 
6 
7 
8 
9

## Page 119

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
113 
 
Abbildung 96: In dem DUVA-Kartentool werden die Kartenebenen bestimmt.  
 
Abbildung 97: Diese Auswahl führt in der Folge zur Erstellung einer Karte, die die räumliche Verteilung durchschnittliche 
Anzahl der Kinder in Familienhaushalten nach Statistischen Bezirken zeigt. 
 
 
1

## Page 120

Auswertungsassistent - Anwendungshandbuch 
114 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
11. Verketten und Verschneiden von Dateien 
 
Für den häufig vorkommenden Fall, dass Informationen aus verschiedenen Datenquellen 
zusammengeführt werden sollen, bietet der DUVA-Auswertungsassistent die Möglichkeit, Dateien zu 
verketten oder zu verschneiden. Verketten bedeutet, Dateien mit identischem Satzaufbau (gleicher 
Struktur) miteinander zu verbinden (vgl. Kapitel 11.1). Damit können beispielsweise über mehrere 
Jahre laufende Zeitreihen aus Einzeldateien, die jeweils nur ein Jahr umfassen, gebildet werden. Beim 
Verschneiden können dagegen nur zwei Dateien miteinander verknüpft werden, die keine 
gemeinsame Struktur aufweisen, aber über mindestens ein gemeinsames Merkmal verfügen (vgl. 
Kapitel 11.2). Damit kann beispielsweise erreicht werden, dass Inhalte unterschiedlichster Art (z.B. 
Haushaltsdaten und Kraftfahrzeugdaten) z.B. über ein räumliches Merkmal zueinander in Beziehung 
gesetzt werden können. Seit Version 4.13 steht zusätzlich unter der Bezeichnung „Erweitertes 
Verketten“ die Option zur Verfügung, eine Verkettung von Dateien mit nicht-identischen 
Satzaufbauten zu erlauben (vgl. Kapitel 11.3). 
 
Möchte man mehr als nur eine Datei auswerten, kann man nach dem Anklicken der ersten Datei in der 
Dateiauswahl weitere bei gehaltener Umschalt-Taste (Auswahl mehrerer direkt untereinander 
stehender Dateien – wie oftmals bei Zeitreihen) oder bei gedrückter Strg-Taste (Auswahl weiterer 
Dateien, die an beliebiger Position in der Auswahlliste erscheinen) auswählen (vgl. Kapitel 4). Die 
selektierten Dateien werden mit ihren Namen im Fußbereich der Dateiauswahl sowie oberhalb der 
Präsentationsauswahl und der Merkmalsauswahl aufgelistet. 
 
11.1 Verketten von Dateien mit identischem Satzaufbau 
 
Per Mehrfachauswahl mit gedrückter STRG-Taste oder per Blockauswahl mit Hilfe der Umschalt-Taste 
können die gewünschten Dateien ausgewählt werden. Die Zahl der ausgewählten Dateien ist nicht 
begrenzt. Per Mausklick auf die „Weiter“- Schaltfläche wird die Auswahl bestätigt und die 
gewünschten Dateien werden zur weiteren Bearbeitung zusammengeführt. Die ausgewählten Dateien 
werden mit ihren Namen im Fußbereich der Dateiauswahl (Abb. 98 (1)) sowie oberhalb der 
Präsentationsauswahl und der Merkmalsauswahl (Abb. 99 (1)) aufgelistet. 
Hinweis: Dateien, die miteinander verkettet werden können, müssen über einen identischen 
Satzaufbau verfügen. Besitzen sie dann noch nahezu inhaltsgleiche Beschreibungstexte, die sich 
lediglich durch eine hinten angefügte Zeitangabe unterscheiden, werden diese Dateien in der 
Dateiauswahl - bei einer Sortierung nach dem Namen - direkt untereinander angezeigt (vgl. Kapitel 4). 
Nach der Auswahl von mehreren strukturgleichen Dateien (Abb. 98) verläuft die Definition der 
gewünschten Präsentation wie in den Kapiteln 5 bis 10 beschrieben, d.h. es kann so weitergearbeitet 
werden, als sei nur eine Datei ausgewählt worden: Nach der Auswahl des Präsentationstyps folgt die 
Merkmalsauswahl (Abb. 99) und ggf. die Definition der Filter und Konfigurationseinstellungen. Einziger 
Unterschied: Vom System werden Zeit- und Raumbezüge zusätzlich als gesonderte Schlüsselmerkmale 
ausgewiesen (Abb. 99 (2)). Diese vom DUVA-Auswertungsassistenten ergänzten Merkmale erscheinen 
in der Merkmalsauswahl an letzter Stelle und können als Kopf- oder als Vorspaltenmerkmale 
ausgewählt und bei der Definition von Filtern berücksichtigt werden.

## Page 121

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
115 
 
 
Abbildung 98: Die Auswahl von Dateien mit identischem Satzaufbau zum Verketten.  
 
 
 
 
 
Abbildung 99: Die vom DUVA-Auswertungsassistenten hinzugefügten Merkmale „Zeitbezug“ 
und „Raumbezug“ können wie die übrigen Schlüsselmerkmale verwendet werden. 
1 
2

## Page 122

Auswertungsassistent - Anwendungshandbuch 
116 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Analog zur bereits beschriebenen Vorgehensweise ist mit verketteten Dateien die Erstellung von 
sämtlichen Präsentationstypen möglich. In gleicher Weise wie bereits beschrieben können dabei 
Berechnungen durchgeführt und Filter gesetzt werden. Die zur Verkettung ausgewählten Dateien 
werden in der automatisch generierten Präsentationsüberschrift aufgelistet (Abb. 100). 
 
 
 
 
 
11.2 Verschneiden von Dateien 
Sollen Dateien, die nicht über einen identischen Satzaufbau verfügen, miteinander verschnitten 
werden, so erfolgt die Auswahl der gewünschten Dateien in gleicher Weise wie bei der Auswahl von 
zur Verkettung vorgesehenen Dateien. Allerdings können nur jeweils zwei Dateien, die zudem 
mindestens ein gemeinsames Merkmal aufweisen müssen, miteinander kombiniert ausgewertet 
werden. Die beiden ausgewählten Dateien werden mit ihren Beschreibungstexten auf den 
nachfolgenden Auswahlseiten ebenfalls angezeigt (Abb. 101 (1)). 
Sind Dateiauswahl und die Auswahl der gewünschten Präsentation abgeschlossen, werden in der 
Merkmalsauswahl die Schlüssel- und Wertemerkmale der ausgewählten Dateien unter verschiedenen 
Reitern angezeigt: Die Schlüsselmerkmale werden auf die Reiter „Gemeinsame“, „Datei 1“ und „Datei 
2“ (2) verteilt, die Wertemerkmale auf „Datei 1“, „Datei 2“ und „Berechnete“. 
Bei der Auswahl der Merkmale ist zu beachten, dass nur gemeinsame Schlüsselmerkmale in der 
Präsentation als Tabellenvorspalte oder Tabellenkopf sowie als kategoriales Merkmal in einer Grafik 
oder Karte angezeigt werden können. Die übrigen Schlüsselmerkmale aus „Datei 1“ oder „Datei 2“ 
können lediglich für die Erstellung von Filtern verwendet werden (vgl. Kapitel 7). 
Bei den Wertemerkmalen spielt die Herkunft keine Rolle. Es können sowohl Wertemerkmale aus 
„Datei 1“, als auch aus „Datei 2“ dem Zielbereich „Wertemerkmale“ der gewünschten Präsentation 
zugeordnet werden. Dateiübergreifende Berechnungen neuer Merkmale sind ebenfalls möglich (vgl. 
Kapitel 6.6). 
Mit den vorhandenen Merkmalen können Kreuztabellen, Interaktive Tabellen, Standardgrafiken, 
Tortendiagramme, Pyramidengrafiken und thematische Karten mit allen im System vorhandenen 
Abbildung 100: Die verketteten Dateien werden in der Überschrift der Präsentation aufgelistet.

## Page 123

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
117 
Funktionalitäten erstellt werden (Listen und CSV-Exporte sind hier ausgeschlossen). Bei der 
Ergebnisausgabe werden wiederum alle vorhandenen Angaben zur Datenherkunft und zu den Inhalten 
der Ausgabe automatisch angezeigt. Allein aus dieser Auflistung kann somit die Datenherkunft sowie 
die Selektion aller Merkmale und aller gesetzten Filter rekonstruiert werden. 
In dem hier gewählten Beispiel wird eine Datei aus der Haushaltestatistik mit einer Datei aus der 
Kraftfahrzeugstatistik verschnitten. Das gemeinsame Schlüsselmerkmal ist das räumliche Merkmal 
„Kleinräumige Gliederung … (Gemeindeteil)“, welches auch als Vorspaltenmerkmal ausgewählt wurde 
(3). Das Schlüsselmerkmal „Fahrzeugart“ aus „Datei 2“ wurde zudem als Filtermerkmal dem Teilbereich 
„Statischer Filter“ (4) zugeordnet und die Ausprägung „Personenkraftwagen“ als Filterkriterium 
bestimmt (5). Die Wertemerkmale wurden aus „Datei 1“ (=Anzahl Haushalte) sowie aus „Datei 2“ (= 
Anzahl Kraftfahrzeuge) dem Zielbereich Wertemerkmale (6) hinzugefügt. Zusätzlich wurde die 
durchschnittliche Anzahl an PKW pro Haushalt berechnet („Anzahl Kraftfahrzeuge“ aus „Datei 2“ 
dividiert durch die „Anzahl Haushalte“ aus „Datei 1“). Nach einem Mausklick auf die Schaltfläche 
„Starten“ (7) wird die Erstellung der Auswertung (hier Kreuztabelle) gestartet.  
 
 
 
Abbildung 101: Das Ergebnis dieser Verschneidung von zwei Dateien mit unterschiedlichem Satzaufbau ist in Abbildung 84 
dargestellt.  
 
1 
2 
3 
4 
5 
6 
7

## Page 124

Auswertungsassistent - Anwendungshandbuch 
118 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
 
 
 
11.3 Erweitertes Verketten von Dateien mit nicht-identischen Satzaufbauten 
Im alltäglichen Gebrauch des ASW hat sich gezeigt, dass eine Verkettung von Dateien auch sinnvoll 
sein kann, wenn die Satzaufbauten nicht identisch sind – z.B. weil sich diese im Laufe der Jahre leicht 
geändert haben. Aus diesem Grund wurde der ASW dahingehend weiterentwickelt, dass er auch solche 
„erweiterten Verkettungen“ erlaubt. 
Bedingung für eine solche Verkettung ist ähnlich wie beim Verschneiden von Dateien das 
Vorhandensein mindestens eines gemeinsamen Schlüsselmerkmals, das sich dadurch auszeichnet, 
dass es in allen Dateien denselben Alias und eine kompatible Verschlüsselung besitzt. Da es sich um 
Schlüsselmerkmale handelt, ist es ausreichend, wenn die Verschlüsselungen dieselbe Länge haben, es 
wird nicht zwischen Merkmalen vom Typ „Schlüsseltabelle“ oder „Identifizierender Schlüssel“ 
unterschieden. In einem solchen Fall wird davon ausgegangen, dass das entsprechende Merkmal in 
beiden Dateien dieselbe Bedeutung hat. Außerdem müssen alle Merkmale, die denselben Alias haben, 
auch vom selben Typ (kategorial/numerisch) sein und dieselbe Verschlüsselungslänge besitzen, da sie 
als gemeinsame Merkmale betrachtet werden. 
Anhand der Bedingungen wird bereits deutlich, dass eine solche Verkettung nur dann wirklich 
funktionieren kann, wenn die Merkmale „sprechende“ Aliase besitzen. Die früher verwendeten 
numerischen Aliase, die auf der Position des Merkmals im Satzaufbau beruhten, lassen keine 
Rückschlüsse auf die Bedeutung des Merkmals zu. 
Da die erste Bedingung auch bei Verschneidungen von Dateien als Grundlage dient, ist nicht immer 
klar, welche der beiden Verknüpfungsformen angewendet werden soll. Bisher galt, dass bei 
identischen Satzaufbauten eine Verkettung erfolgte und anderenfalls die Verschneidungsfähigkeit 
geprüft wurde. Dies wird auch weiterhin so gehandhabt mit dem Unterschied, dass auf der 
Dateiauswahlseite jetzt eine Checkbox angezeigt wird, mittels derer man die Nutzung der erweiterten 
Verkettung aktivieren kann (vgl. Abb. 103). 
Abbildung 102: Das Verschneiden von Dateien ermöglicht das Zusammenführen und Auswerten 
von Daten aus unterschiedlichen Sachgebieten.

## Page 125

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
119 
 
Abbildung 103: Dateiauswahlseite mit Checkbox, mittels derer man die Nutzung der erweiterten Verkettung aktivieren 
kann. 
Wird die Option aktiviert, wird zunächst geprüft, ob eine erweiterte Verkettung möglich ist. Sollte 
sogar eine normale Verkettung möglich sein, wird diese verwendet. Ist keine Verkettung möglich, wird 
wie bisher die Verschneidbarkeit geprüft. 
Bei der erweiterten Verkettung von Dateien, werden die Satzaufbauten aller Dateien ‚normalisiert‘. 
Das bedeutet, dass ein Merkmal, das nicht in allen Dateien vorhanden ist, den entsprechenden 
Satzaufbauten als virtuelles Merkmal hinzugefügt wird. So kann prinzipiell jedes Merkmal, das in einer 
Datei vorkommt, auch in einer Auswertung verwendet werden. Bei Datensätzen aus Sachdateien, die 
das Merkmal nicht enthalten, wird als Wert entweder NULL für numerische oder die leere Zeichenkette 
für kategoriale Merkmale verwendet.  
Nicht-gemeinsame Merkmale können prinzipiell auch zum Filtern oder als Quelle für Gruppierungen 
verwendet werden. Dabei ist jedoch mit Bedacht vorzugehen, damit das gewünschte Ergebnis erzielt 
wird.

## Page 126

Auswertungsassistent - Anwendungshandbuch 
120 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
12. Speichern und Veröffentlichen von Auswertungen 
Als Besonderheit bietet der DUVA-Auswertungsassistent vordefinierte Auswertungen an. Dabei wird 
zunächst 
die 
Definition 
einer 
getroffenen 
Merkmalsauswahl 
einschließlich 
aller 
Konfigurationseinstellungen in der Datenbank gespeichert. Erfolgt deren Aufruf, wird die festgelegte 
Tabelle, Grafik oder Karte vom Auswertungsassistenten anhand der gespeicherten Parameter aus dem 
aktuellen Datenbestand des DUVA-Systems jeweils neu generiert und ausgegeben. Der Aufruf solch 
vordefinierter Auswertungen kann entweder als URL oder über das DUVA-Informationsportal erfolgen. 
Durch die in der Datenbank gespeicherten Auswertungen kann ein Informationsangebot geschaffen 
werden, ohne dass fertige Grafiken oder Tabellen auf Vorrat produziert und ständig aktualisiert 
werden müssen. 
12.1 Allgemeine Einstellungen zur Speicherung und Veröffentlichung von 
Auswertungen 
Nach der Auswahl einer oder mehrerer Dateien sowie der Festlegung des Präsentationstyps, der 
darzustellenden 
Merkmale, 
der 
Filter 
und 
Ausgabeoptionen 
(Abb. 
104) 
können 
die 
Konfigurationseinstellungen zur Erstellung der Auswertung in einer Steuerdatei je nach vorhandenen 
Rechten lokal oder auf dem Server gespeichert werden. Dazu wird die Schaltfläche „Speichern“ 
unterhalb der Merkmalsauswahl durch Mausklick betätigt (1).  
 
Abbildung 104: Das Speichern der Parameter zur Erstellung der gewünschten Präsentation wird durch einen Klick auf die 
Schaltfläche „Speichern“ unterhalb der Merkmalsauswahl eingeleitet. 
Durch Klicken der Schaltfläche „Speichern“ wird die Seite zum Speichern einer Auswertung aufgerufen 
(Abb. 105).  
1

## Page 127

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
121 
 
Abbildung 105: Zum Speichern der Auswertungsparameter sind ein Verzeichnis auszuwählen und ein Dateiname zu vergeben. 
Hier werden alle gespeicherten Auswertungen angezeigt (1). Darunter kann die zu speichernde 
Auswertung mit Gliederung, Name und Kommentar beschriftet werden (2). Die Länge des Namens ist 
auf maximal 255 Stellen begrenzt und zwischen Groß- und Kleinschreibung wird nicht unterschieden.  
Rechts davon sind unterschiedliche „Optionen“ (3) zu finden, welche durch das Setzen eines Hakens 
aktiv werden. Mit „vorhandene Auswertung überschreiben“ wird der Inhalt einer ausgewählten, 
bereits bestehenden Datei ersetzt. Setzt man den Haken bei „Auswertung immer im 
Bearbeitungsmodus öffnen“, so startet die Auswertung beim nächsten Öffnen direkt mit der Maske 
zum Bearbeiten wie sie beispielsweise in Abb. 85 zu sehen ist. Wird der Haken nicht gesetzt, so startet 
die Anwendung beim nächsten Öffnen direkt mit der Ausgabe der Tabelle bzw. der Grafik. 
 
Mit der Option „Anmeldung erforderlich“ kann ein anonymes Aufrufen der Auswertung verhindert 
werden. Wird der Haken entsprechend gesetzt, so wird diese Information in den Metadaten der 
Auswertung festgehalten. Das Anmelden als Voraussetzung wird in der Auswertungsübersicht durch 
einen Haken in der Spalte „Login“ angezeigt. Bei einem Aufruf der Auswertung, der nicht innerhalb 
einer bereits bestehenden ASW-Session erfolgt, wird zunächst die Anmeldeseite des ASW dargestellt, 
so dass sich der Benutzer erst authentifizieren muss. Auf der Anmeldeseite wird standardmäßig der 
Benutzername vorgegeben, dem die Auswertung zugeordnet ist. Es kann aber jeder Benutzername 
verwendet werden, sofern der Benutzer einer der Benutzergruppe angehört, die der Auswertung 
zugeordnet sind. Wird ein Benutzername verwendet, bei dem das nicht der Fall ist, erfolgt eine 
entsprechende Meldung (Abb. 106).  
 
 
 
1 
2 
5 
4 
3 
Abbildung 106: Fehlermeldung, dass Zugriff auf Auswertung verweigert wurde 
6

## Page 128

Auswertungsassistent - Anwendungshandbuch 
122 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
Eine Neuerung in Version 4.13 ist eine ausdifferenzierte Zuordnung von Benutzergruppen (4). In dieser 
Liste ist es möglich, mehrere Benutzergruppen zuzuordnen und darüber hinaus auch die 
„Auszeichnung“ einer der gewählten Gruppen als primäre Benutzergruppe zu vermerken. Da nur 
Benutzergruppen zulässig sind, denen der Benutzer selbst angehört, ist eine manuelle Eingabe nicht 
möglich. Das Eingabefeld dient lediglich zur Anzeige der gewählten Gruppen und enthält beim 
Speichern einer neu erstellten Auswertung nur die primäre Benutzergruppe. 
Geändert werden kann die Auswahl durch Klicken der Schaltfläche, wodurch ein Auswahldialog 
geöffnet wird, in dem alle verfügbaren Gruppen aufgelistet werden (Abb. 107). 
 
Abbildung 107: Dialog zur Auswahl der verfügbaren Benutzergruppen 
Die bereits ausgewählten sind durch ein vorangestelltes Häkchen gekennzeichnet. Die Gruppen 
können per Drag‘n‘Drop verschoben werden. Die oberste ausgewählte Gruppe gilt als primäre 
Benutzergruppe. Nach Klicken der Schaltfläche „Übernehmen“ werden die ausgewählten 
Benutzergruppen im Eingabefeld aufgeführt. 
Ob die Auswahl von Benutzergruppen möglich ist oder nicht, hängt von verschiedenen Faktoren ab. 
Zunächst einmal muss der angemeldete Benutzer mehreren Benutzergruppen angehören. Ob diesen 
Benutzergruppen Profile zugeordnet sind, ist dabei zunächst unerheblich. Ist diese Bedingung erfüllt, 
kann der Benutzer auf jeden Fall Gruppen auswählen, wenn er eine neue Auswertung erstellt oder 
eine eigene früher erstellte bearbeitet. Bearbeitet er eine Auswertung eines anderen Benutzers, hängt 
es davon ab, ob er die Berechtigung hat, deren Besitz zu übernehmen. Hat er sie nicht, kann er die 
Auswertung nur mit ihrer bestehenden Benutzer- bzw. Gruppenzuordnung abspeichern und die 
Benutzergruppenauswahl 
wird 
nicht 
angezeigt. 
Hat 
er 
die 
Berechtigung, 
wird 
die 
Benutzergruppenauswahl zwar nicht sofort angezeigt, kann aber durch Aktivieren der Checkbox 
„Besitz übernehmen“ (Abb. 105, (3), letzte Option) sichtbar gemacht werden. 
Das Speichern erfolgt nach einem Mausklick auf die Schaltfläche „Speichern“ (5). Nicht nur das 
Speichern einer bearbeiteten Auswertung ist möglich, sie kann über die Schaltfläche „Parametrisieren“ 
(6) auch weitergehend modifiziert werden. (vgl. Kapitel 13)

## Page 129

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
123 
Gespeicherte Auswertungen können parallel zur Dateiauswahl (Abb. 108) wieder aufgerufen werden, 
die nach dem Start des DUVA-Auswertungsassistenten als erste Auswahlseite angezeigt wird. Hier 
kann über die Reiter „Dateien“ und „Auswertungen“ (1) zwischen der Dateiauswahl und der Auswahl 
einer gespeicherten Auswertung gewechselt werden. Die Suche und Auswahl einer Auswertung 
verläuft analog zur Dateiauswahl (Vgl. Kapitel 4). Über die Suchfunktion (2) kann ein Auffinden der 
Datei vereinfacht werden. Ein Klick auf die Schaltfläche „Starten“ (3) führt zur erneuten Ausführung 
der Auswertung und Erstellung der Präsentation. 
 
Abbildung 108: Gespeicherte Auswertungsparameter können zur erneuten Erstellung einer Präsentation oder zur 
Bearbeitung wieder aufgerufen werden. 
Eine einmal abgespeicherte Auswertung kann aber auch über den entsprechenden Link in eine 
Internet-Präsentation eingebunden werden. Auf diese Weise können Standardauswertungen über das 
World Wide Web angeboten und weltweit von jeder Nutzerin und jedem Nutzer gestartet werden, 
auch 
ohne 
Kenntnisse 
von 
der 
Struktur 
der 
Daten 
oder 
der 
Funktionsweise 
des 
Auswertungsassistenten zu haben.  
Hinweis: In neueren Versionen des Informationsportals können Einträge mittlerweile mit neu 
eingeführten Lizenzobjekten verknüpft werden. ASW-Versionen kleiner als 4.16 können bei Nutzung 
eines solchen Informationsportals keine Einträge vornehmen, da es hierbei zu Datenbankfehlern 
kommt. Um die Lizenzobjekte auch bei Einträgen aus dem Auswertungsassistenten heraus nutzen zu 
können, wurde der entsprechende Dialog im Auswertungsassistenten um eine zusätzliche Auswahlliste 
erweitert. Wird dort eine Lizenz ausgewählt, wird deren Identifikator im Eintrag vermerkt. 
Lizenzobjekte werden im Informationsportal verwaltet. Nähere Informationen dazu sind dem 
zugehörigen Handbuch zu entnehmen. 
 
Abbildung 109: Dialog zur Auswahl einer Lizenz 
1 
2 
3

## Page 130

Auswertungsassistent - Anwendungshandbuch 
124 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
12.2 Erstellen eines Links für gespeicherte Auswertungen 
Um die URL zum Aufruf einer gespeicherten Auswertung zu erhalten, musste diese in früheren 
Versionen manuell aus der URL des ASW und den benötigten Parametern zusammengestellt werden. 
Um leichter an vollständige und korrekte URLs zu gelangen, findet sich nun auf den Seiten zum 
Auswählen bzw. Speichern einer Auswertung eine weitere Schaltfläche mit der Standardbeschriftung 
Link kopieren, die aktiv wird, sobald eine Auswertung ausgewählt wurde. 
Hinweis: Diese Funktionalität verwendet die Asynchronous Clipboard API, um auf die Zwischenablage 
zuzugreifen. Diese funktioniert jedoch nur in einem „sicheren“ Kontext, was bedeutet, dass die 
Anwendung entweder über https aufgerufen wird oder rein lokal arbeitet und als Server localhost 
verwendet wird. Ist beides nicht der Fall, wird die Schaltfläche nicht angezeigt. 
 
 
 
Abbildung 110: Link kopieren und Eintragung ins Informationsportal 
Klickt man auf die Schaltfläche, wird die URL in die Zwischenablage gespeichert, was mit einer 
entsprechenden Meldung quittiert wird. Aus der Zwischenablage kann sie dann mit den üblichen 
Methoden (Strg-V, Kontextmenü) abgerufen werden. Sollte ein Kopieren in die Zwischenablage nicht 
möglich sein, wird eine entsprechende Fehlermeldung ausgegeben. 
Die erzeugte URL hat prinzipiell den folgenden Aufbau: 
https://.../asw.dll?aw=Auswertungsidentifikator&@Auswertungsparamete
r1=Wert1&@... 
Um bei parametrisierten Auswertungen unnötige Nachbearbeitungen der URL zu vermeiden, sollten 
in der Auswertung korrekte Standardwerte für die Auswertungsparameter angegeben werden. Sollen 
andere Werte als die Standardwerte verwendet werden, kommt man um eine manuelle Anpassung 
der URL natürlich nicht herum. 
Ist das aktuell verwendete Nachweissystem nicht die Registrierungsdatenbank, wird dem 
Auswertungsidentifikator sicherheitshalber der korrekte NWS-Alias vorangestellt: 
https://.../asw.dll?NWS=DUVA_MDB&aw=Auswertungsidentifikator

## Page 131

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
125 
Um Probleme mit speziellen Zeichen zu vermeiden, wird der Parameterteil URL-kodiert 
(Prozentkodierung). Der Schrägstrich, z.B.  als Separator im Auswertungsidentifikator, wird als %2F 
dargestellt. 
Zusätzlich zu dieser neuen Funktionalität wird die Schaltfläche zum Erzeugen von Einträgen in das 
Informationsportal, die bisher nur auf der Speicherseite verfügbar war, jetzt auch auf der Auswahlseite 
angezeigt.

## Page 132

Auswertungsassistent - Anwendungshandbuch 
126 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
13. Parametrisierung 
13.1 Was sind Parameter? 
Parameter ähneln den Variablen in einer mathematischen Gleichung. Sie ermöglichen eine variable 
Abfrage an eine Datenbank. So können mit einer Abfrage verschiedene Tabellen erzeugt werden. 
Parametrisierte URLs werden in Form eines PathInfo mit /params/ eingeleitet, es folgt der (im ASW 
festgelegte) Parameter aw= , dem der Name einer festen Auswertung zugewiesen wird. 
Die Parameter zu den Merkmalen werden mit dem kaufmännischen UND sowie dem @-Zeichen (&@) 
angegeben; es können mehrere Parameter angegeben werden. Im Beispiel wird wer= verwendet.  
https://musterstadt.de/asw/asw.dll/params/aw=Herkunft_Param&@wer=SCHUELER_INSGESAMT 
Der Link gibt dem Webserver die folgende Anweisung: Nimm die Auswertung Herkunft_Param und 
setze in dieser Auswertung überall das Merkmal Schüler Insgesamt an die Stellen, wo wer steht. Der 
Name wer muss händisch in die feste Auswertung eingetragen werden. Dieser Vorgang wird 
„Parametrisierung“ genannt. 
Dem Parameter wer wird im Beispiel das Wertemerkmal SCHUELER_INSGESAMT zugewiesen. Im 
Satzaufbau 
gibt 
es 
weitere 
Wertmerkmale 
bzw. 
Datenbank-Aliase: 
DAR_SCHUELER_W, 
AUSLAENDER_INSGESAMT und DAR_AUSLAENDER_W. So können verschiedene Auswertungen 
aufgerufen werden: 
https://musterstadt.de/asw/asw.dll/params/aw=Herkunft_Param&@wer=SCHUELER_INSGESAMT 
https://musterstadt.de/asw/asw.dll/params/aw=Herkunft_Param&@wer=DAR_SCHUELER_W 
https://musterstadt.de/asw/asw.dll/params/aw=Herkunft_Param&@wer=AUSLAENDER_INSGESAMT 
https://musterstadt.de/asw/asw.dll/params/aw=Herkunft_Param&@wer=DAR_AUSLAENDER_W 
 
Der Parametername aw ist festgelegt, andere Parameternamen wie zum Beispiel das oben genutzte 
wer sind dagegen beliebig wählbar, sofern sie bestimmten Namenskonventionen folgen (keine 
Leerzeichen, keine Sonderzeichen).  
Mittels solcher Parameter können sogenannte dynamische Webseiten erzeugt werden. Statt für jeden 
Parameter eine statische Webseite zu erzeugen und diese fest abzuspeichern, müssen nur die Werte 
der Parameter geändert werden, damit eine andere Webseite generiert wird. In diesem Fall entstehen 
durch Änderung des Wertes für wer vier verschiedene Auswertungen. 
 
 
   
    
 
Abbildung 111: Parameterwerte für wer: SCHUELER_INSGESAMT, DAR_SCHUELER_W, AUSLAENDER_INSGESAMT und 
DAR_AUSLAENDER_W

## Page 133

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
127 
Im Beispiel mit den Schülern wurden Wertemerkmale als Parameter festgelegt, oder: parametrisiert. 
Dies kann auch mit Schlüsselmerkmalen erfolgen. In den folgenden Abschnitten werden beide Fälle 
behandelt. 
 
Werte für die Parameter 
Die Werte für die Parameter selbst sind im ASW sichtbar (sofern dies konfiguriert wurde), wenn die 
Maus über die Schlüssel- bzw. Wertemerkmale bewegt wird. Im Tooltip werden in Großbuchstaben 
die Bezeichnungen angegeben.  
 
 
Abbildung 112: Parameterwert in Großbuchstaben: SCHULFORM 
 
Aufruf von parametrisierten Auswertungen im ASW 
 
Ruft man eine parametrisierte Auswertung aus der Dateiauswahl des ASW heraus auf, kann man 
individuelle Werte für den Aufruf mitgeben. Dazu wird zunächst ein Dialog angezeigt, in dem die 
verfügbaren Parameter tabellarisch aufgeführt werden (Abbildung. 111). In den Eingabefeldern 
werden - soweit vorhanden - die jeweiligen Standardwerte als „Platzhalter“ angezeigt die verwendet 
werden, wenn kein anderer Wert eingegeben wird. 
  
Abbildung 113: Dialogfenster, in dem die verfügbaren Parameter tabellarisch aufgeführt werden 
13.2 Die Erzeugung parametrisierter Auswertungen 
Damit Parameter verwendet werden können, müssen im ASW Auswertungen gespeichert und 
anschließend parametrisiert werden. Die Speicherung der Auswertungsdatei selbst wurde bereits in 
Kapitel 12 besprochen.  
 
Die Parametrisierung erfolgt in zwei Schritten. Zuerst wird eine Auswertung erstellt wie sonst auch. 
Diese kann – muss jedoch nicht – über die Schaltfläche „Speichern“ abgespeichert werden. Die 
Parametrisierung kann nun über die Schaltfläche „Parametrisieren“ (Abb. 105(5)) gestartet werden. 
Der Klick auf die Schaltfläche ruft die Parametrisierungsseite auf, die ein mehrzeiliges Texteingabefeld

## Page 134

Auswertungsassistent - Anwendungshandbuch 
128 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
umfasst. Darin wird eine textuelle Darstellung der Auswertungsspezifikation in der Struktur einer INI-
Datei angezeigt. 
 
Abbildung 114: Parametrisierungsseite 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
[Parameters] 
 
[Header] 
Comment=Kommentar erscheint als Comment in der Auswertungsdatei 
(gekürzt) 
[File1] 
Name=Herkunftsdaten 
 
[Attribute1] 
Name=Schulform 
FileIndex=0 
Alias=SCHULFORM 
Position=L 
(gekürzt) 
 
[Attribute2] 
Name=Schüler Insgesamt 
FileIndex=0 
Alias=SCHUELER_INSGESAMT 
Position=B 
(gekürzt) 
Abbildung 115: Schlüssel- und Wertemerkmale in der Auswertungsdatei

## Page 135

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
129 
In der hier etwas gekürzten Textdatei ist zur Verdeutlichung das Wertemerkmal Schüler Insgesamt blau 
und das Schlüsselmerkmal Schulform gelb hervorgehoben. Im folgenden Beispiel werden sowohl Name 
wie Alias modifiziert. Es ist aber ausreichend, entweder den Namen oder den Alias zu modifizieren. 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
Im obigen Beispiel wurde: 
Schulform sowie der Alias SCHULFORM durch @wo ersetzt.  
Schüler Insgesamt sowie der Alias SCHUELER_INSGESAMT durch @wer ersetzt. 
 
Vorhandene Auswertung überschreiben 
Nachdem die Veränderung im Text vorgenommen wurde, muss die Auswertung erneut gespeichert 
werden. Soll eine bereits vorhandene Auswertung dabei überschrieben werden, muss das Häkchen 
gesetzt werden bei „vorhandene Auswertung überschreiben“. Wurde die Auswertung vorher bereits 
gespeichert, ist dies notwendig. Der Name der Auswertung muss hier (erneut) eingegeben werden.  
Gliederung 
Wurde die Parametrisierung in einem tieferen Gliederungsebene abgespeichert, muss dies in der URL 
angegeben werden. In diesem Fall wurde die Auswertung Herkunft_Param in der Gliederungsebene 
„Handbuch“ abgespeichert, daher lautet der Link zur Auswertungsdatei: 
 
https://musterstadt.de/asw/asw.dll/params/aw=Handbuch/Schulform_Param&@wo=SCHULNAME&
@wer=SCHUELER_INSGESAMT 
 
 
13.3 Die Kombination von Parametern 
 
Sowohl Schlüssel- wie Wertemerkmale lassen sich parametrisieren. Dabei entstehen verschiedene 
Kombinationsmöglichkeiten, je nachdem wie viele Merkmale parametrisiert wurden. Manche Dateien 
enthalten nur ein Wertemerkmal, andere haben vielleicht drei raumbezogene Unterscheidungen. Im 
folgenden Beispiel sind es zwei Schlüsselmerkmale und drei Wertemerkmale, die untereinander 
kombiniert werden können. 
 
Betrachtet man die Datei und die hier getroffene Auswahl, wird ersichtlich, dass man bei den 
Schlüsselmerkmalen statt der Kleinräumigen Gliederung auch den Statistischen Bezirk als 
Vorspaltenmerkmal hätte auswählen können. Als Kopfmerkmal wurde hier der Haushaltstyp HHSTAT 
[Parameters] 
wo 
wer  
(gekürzt) 
[Attribute1] 
Name=@wo  
FileIndex=0 
Alias=@wo 
Position=L 
(gekürzt) 
[Attribute2] 
Name=@wer 
FileIndex=0 
Alias=@wer 
Position=B 
(gekürzt) 
[Parameters] 
 
(gekürzt) 
[Attribute1] 
Name=Schulform  
FileIndex=0 
Alias=SCHULFORM 
Position=L 
(gekürzt) 
[Attribute2] 
Name=Schüler Insgesamt  
FileIndex=0 
Alias=SCHUELER_INSGESAMT 
Position=B 
(gekürzt) 
Abbildung 117: Parametrisierte Version 
Abbildung 116: Ursprüngliche Auswertungsdatei

## Page 136

Auswertungsassistent - Anwendungshandbuch 
130 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
gewählt, aber es wäre auch der Haushaltstyp BfLR möglich. Bei den Wertemerkmalen stehen hier drei 
verschiedene zur Auswahl: Anzahl Haushalte, Anzahl der Personen und Anzahl der Kinder.  
 
 
Abbildung 118: Auswahl Kleinräumige Gliederung, HHSTAT und Anzahl Haushalte 
Die in der Abbildung gezeigte Auswahl zeigt eine von zwölf möglichen Kombinationen. Mittels 
Parametrisierung der Merkmale muss nicht für jede dieser Kombinationen eine eigene Datei 
abgespeichert werden.  
 
Je zwei Optionen bei den beiden Schlüsselmerkmalen und drei Optionen bei den Wertemerkmalen 
ergeben insgesamt zwölf Kombinationsmöglichkeiten:  
 
AAA: Kleinräumige Gliederung, HHSTAT, Anzahl Haushalte 
 
AAB: Kleinräumige Gliederung, HHSTAT, Anzahl der Personen 
 
AAC: Kleinräumige Gliederung, HHSTAT, Anzahl der Kinder 
 
ABA: Kleinräumige Gliederung, BfLR, Anzahl Haushalte 
 
ABB: Kleinräumige Gliederung, BfLR, Anzahl der Personen 
 
ABC: Kleinräumige Gliederung, BfLR, Anzahl der Kinder 
 
BAA: Statistischer Bezirk, HHSTAT, Anzahl Haushalte 
 
BAB: Statistischer Bezirk, HHSTAT, Anzahl der Personen 
 
BAC: Statistischer Bezirk, HHSTAT, Anzahl der Kinder 
 
BBA: Statistischer Bezirk, BfLR, Anzahl Haushalte 
 
BBB: Statistischer Bezirk, BfLR, Anzahl der Personen 
 
BBC: Statistischer Bezirk, BfLR, Anzahl der Kinder 
 
Statt zwölf Dateien abzuspeichern, speichert man nur eine Datei und parametrisiert diese.  
 
Gekürzte Darstellung:  
[Attribute1] 
Alias=@sm_raum 
 
[Attribute2] 
Alias=@sm_haushalt 
 
[Attribute3] 
Alias=@wm_anzahl

## Page 137

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
131 
Als mögliche Links ergäben sich damit unter anderem:  
 
AAA:  
https://musterstadt.de/asw/asw.dll/params/aw=Handbuch/HH_Param&@sm_raum=KLEINRAEUMIGE
_G&@sm_haushalt=HAUSHALTSTYP_HH&@wm_anzahl=ANZAHL_HAUSHALT 
 
ABA:   
https://musterstadt.de/asw/asw.dll/params/aw=Handbuch/HH_Param&@sm_raum=KLEINRAEUMIGE
_G&@sm_haushalt=HAUSHALTSTYP_BF&@wm_anzahl=ANZAHL_HAUSHALT 
 
 
Abbildung 119: Auswertung bei der Kombination AAA 
 
 
Abbildung 120: Auswertung bei der Kombination ABA

## Page 138

Auswertungsassistent - Anwendungshandbuch 
132 
 
© KOSIS-Gemeinschaftsprojekt DUVA 
13.4 Besonderheiten bei der Parametrisierung 
 
Filter 
Für Schlüsselmerkmale können in der Auswertungsdatei auch Filter für die ursprünglich gespeicherte 
Version der Auswertungsdatei vorhanden sein. Diese müssen jedoch zuvor definiert worden sein.  
 
Unter Umständen muss der Filter bei der Parametrisierung herausgenommen werden, um bei Wahl 
eines anderen Parameters keine unerwünschte Einschränkung zu erreichen. Der Filter, der bei der 
ursprünglichen Auswahl des Statistischen Bezirks (STATBEZ) in der Auswertungsspezifikation enthalten 
ist, würde bei der Parameter-Änderung zu KLEINRAEUMIGE_G zu einer Reduktion der Ergebnisse 
führen. Durch Löschung des Filters kann diese Reduktion verhindert werden. 
 
[Filter1] 
Attribute=Statistischer Bezirk 
DisplayName= 
FileIndex=0 
Alias=STATBEZ 
Rules=0 
Constraints=33 
Constraint1=1111 
(…) 
Constraint32=1202 
Constraint33=1203 
Diese Constraint-Angaben herauslöschen, damit keine ungewollte Filterung entsteht.  
Constraints gibt an, wie viele Filteroptionen es gibt. Constraint1 bis Constraint33 sind dann die einzeln 
anwählbaren Filter. So könnte man hier den statistischen Bezirk 1111 anwählen, indem als Filter 
gesetzt wird Constrain1=1111 und alle anderen gelöscht werden.  
 
Kommentare 
Das Kommentarzeichen welches an den Zeilenanfang gesetzt werden muss ist das Semikolon 
(Strichpunkt) „ ; “ 
Mehrere Wertemerkmale / Reihenfolge  
Es ist möglich, mehrere Wertemerkmale zu parametrisieren. Dazu muss man bereits in der 
Auswertungsspezifikation mehrere Wertemerkmale auswählen. Wählt man vier Wertemerkmale aus, 
müssen jedoch auch bei der parametrisierten Ausgabe vier Wertemerkmale angezeigt werden.  
Die Reihenfolge, in der die Wertemerkmale angezeigt werden, erfolgt in der Reihenfolge, wie sie 
ursprünglich in der Auswertungsspezifikation festgelegt wurde. Wurden mehrere Wertemerkmale 
ausgewählt und parametrisiert, erfolgt die Reihenfolge der Wertemerkmale gemäß der 
Parameterreihenfolge in der Auswertungsdatei. Die Reihenfolge des Auftretens des Parameters in der 
URL ist belanglos. Ob @wer1 zuerst in der URL erscheint oder @wer2, ist irrelevant. Man kann aber 
den Parametern die möglichen Ausprägungen in beliebiger Reihenfolge zuweisen. 
 
&@wer1=AUSLAENDER_INSG&@wer2=DAR_AUSLAENDER_W 
führt zur Reihenfolge:  
 
AUSLAENDER_INSGESAMT

## Page 139

Auswertungsassistent - Anwendungshandbuch 
© KOSIS-Gemeinschaftsprojekt DUVA 
 
133 
 
DAR_AUSLAENDER_W 
 
&@wer2=AUSLAENDER_INSG&@wer1=DAR_AUSLAENDER_W 
führt jedoch zur Reihenfolge:  
 
DAR_AUSLAENDER_W 
 
AUSLAENDER_INSGESAMT 
Es spielt also keine Rolle, wo in der URL der Parameter steht, sondern wo er in der Auswertungsdatei 
steht. Dort wurden sie nach der numerischen Reihenfolge vergeben:  
[Attribute2] 
Alias=@wer1 
 
[Attribute3] 
Alias=@wer2 
 
Wurden in der Parametrisierung zwei Wertemerkmale parametrisiert, müssen auch beide angegeben 
werden. Es ist also nicht möglich, Nullwerte für Parameter zu vergeben. Man kann aber auch die Anzahl 
der Merkmale parametrisieren und dann nur die angegebene Anzahl der Parameter übergeben. 
Hinweis: Man kann neben Schlüssel- und Wertemerkmalen, wie hier im angeführten Beispiel, jedoch 
grundsätzlich alles parametrisieren. Allerdings sollte man nur wissen, wann ein Parametrisieren 
sinnvoll erscheint.
