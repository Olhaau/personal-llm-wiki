---
title: "Statistische Geheimhaltung in den Bevoelkerungsstatistiken"
token: 1254
source_link: "https://www.destatis.de/DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Sterbefaelle-Lebenserwartung/Methoden/Erlaeuterungen/geheimhaltung-in-den-bevoelkerungsstatistiken.html"
topic: "fdz-microdata-access-security"
tags: [ingest, web, destatis, geheimhaltung, cell-key, bevoelkerung, fetched, full-input]
generated_at: "2026-05-11T00:00:00Z"
---

Statistische Geheimhaltung in den Bevölkerungsstatistiken - Statistisches Bundesamt

*Springe direkt zu:*

-   [Inhalt](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Sterbefaelle-Lebenserwartung/Methoden/Erlaeuterungen/geheimhaltung-in-den-bevoelkerungsstatistiken.html?nn=209016#content)
-   [Hauptmenü](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Sterbefaelle-Lebenserwartung/Methoden/Erlaeuterungen/geheimhaltung-in-den-bevoelkerungsstatistiken.html?nn=209016#navPrimary)
-   [Suche](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Sterbefaelle-Lebenserwartung/Methoden/Erlaeuterungen/geheimhaltung-in-den-bevoelkerungsstatistiken.html?nn=209016#search)

## Servicemenü

-   [Jobs](DE/Ueber-uns/Karriere/_inhalt.html "Karriere")
-   [Presse](DE/Presse/_inhalt.html)
-   [Daten übermitteln](DE/Service/Online-Melden/_inhalt_servicenavi.html "Daten übermitteln")
-   [](DE/Service/LeichteSprache/_inhalt.html "Leichte Sprache")
-   [](DE/Service/Gebaerdensprache/_inhalt.html "Gebärdensprache")
-   [English](EN/Themes/Society-Environment/Population/Deaths-Life-Expectancy/_node.html "Switch to english website")

[![Logo: Destatis Statistisches Bundesamt (Link zur Startseite)](/SiteGlobals/Frontend/Images/logo.svg?__blob=normal&v=11)](DE/Home/_inhalt.html "Zur Startseite")

## Sie sind hier:

1.  [Startseite](DE/Home/_inhalt.html "Startseite")
2.  [Themen](DE/Themen/_inhalt.html)
3.  [Gesellschaft und Umwelt](DE/Themen/_inhalt.html#themaHeadline_1425464_2)
4.  [Bevölkerung](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/_inhalt.html)
5.  [Sterbefälle und Lebenserwartung](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Sterbefaelle-Lebenserwartung/_inhalt.html)
6.  **Statistische Geheimhaltung in den Bevölkerungsstatistiken**

# Sterbefälle und Lebenserwartung Statistische Geheimhaltung in den Bevölkerungsstatistiken

## Hintergründe zur Anwendung der Cell-Key-Methode

### Ausgangssituation

Die Geheimhaltung in der amtlichen Statistik ist in § 16 Bundesstatistikgesetz (BStatG) geregelt. Danach sind Einzelangaben über persönliche und sachliche Verhältnisse, die für eine Bundesstatistik gemacht werden, geheim zu halten, soweit gesetzlich nichts anderes bestimmt ist. Für die Veröffentlichungen der Bevölkerungsstatistiken muss somit gewährleistet sein, dass sich den Betroffenen keine Einzelangaben zuordnen lassen. In der Vergangenheit wurden individuelle Lösungen gefunden, um diesen gesetzlichen Anspruch zu gewährleisten. In Zeiten immer flexibler werdender Datenangebote in Datenbanken und der wachsenden Bedeutung kleinräumiger Daten stoßen diese individuellen Regelungen jedoch an ihre Grenzen. Für einen übergreifenden Ansatz stehen verschiedene Verfahren zur Auswahl.

### Statistische Geheimhaltungsverfahren

Statistische Geheimhaltungsverfahren sollen sicherstellen, dass keine Rückschlüsse auf Einzelangaben möglich sind - beispielsweise durch Fallzahlen unter drei oder Randsummen, die identisch sind mit einzelnen Innenfeldern. Man kann sie nach informationsreduzierenden Verfahren (beispielsweise Zellsperrungen, Vergröberungen) oder datenverändernden Verfahren (wie Rundungen oder stochastischen Überlagerungen) unterteilen.

In der amtlichen Statistik wurde die Geheimhaltung der Daten durch Vergröberungen von Tabellen bisher häufig eingesetzt, falls notwendig in der Kombination mit Zellsperrverfahren. Eine vollständige und konsistente Geheimhaltung ist mit dieser Vorgehensweise allerdings in den meisten Bevölkerungsstatistiken kaum umsetzbar. Dies ginge mit hohem Koordinationsaufwand und fehlender Flexibilität in den Auswertungsmöglichkeiten (beispielsweise im Rahmen von Datenbanken und bei wissenschaftlichen Auswertungen in den Forschungsdatenzentren) sowie vergleichsweise großen Informationsverlusten einher. Einzig bei der Ehescheidungsstatistik wird seit dem Berichtsjahr 2018 ein Tabellenveröffentlichungsprogramm eingesetzt, das die bekannten Bedarfe mithilfe von Vergröberungen und - in letzter Instanz - Zellsperrungen abdecken kann. Für alle anderen Statistiken, bei denen Bedarf an der Einführung eines Geheimhaltungsverfahrens gesehen wird, wurden deshalb alternative Verfahren näher in Betracht gezogen.

Im Rahmen dieser Verfahren werden Auswertungstabellen geringfügig verändert. Diese kleinen Veränderungen sollen bewirken, dass aus den Veröffentlichungen keine eindeutigen Rückschlüsse auf Einzelfälle mehr gezogen werden können. Dies kann beispielsweise mithilfe von einfachen Rundungsverfahren (wie 5er-Rundung) oder komplexeren stochastischen Überlagerungen gewährleistet werden. Stochastische Überlagerungen bieten gegenüber einfachen Rundungsverfahren den großen Vorteil, dass ein höherer Schutz der Einzeldaten mit einem geringeren Informationsverlust des veröffentlichten Datenmaterials bei gleichzeitiger Vermeidung systematischer Verzerrungen kombiniert werden kann. Aus diesem Grund wurde im statistischen Verbund die Einführung der stochastischen Überlagerung nach der Cell-Key-Methode (kurz CKM) für die Statistiken der Sterbefälle, der Geburten, der Eheschließungen, der Wanderungen und der Einbürgerungen beschlossen.

## Cell-Key-Methode (CKM)

Bei Fallzahltabellen wird die Geheimhaltung im Rahmen der CKM dadurch gewährleistet, dass jedes Originalergebnis (Cell Frequency) mithilfe eines Zufallsschlüssels (Cell Key) mit einer bestimmten Wahrscheinlichkeit verändert wird. Die hierdurch entstehende Unsicherheit gewährleistet, dass durch potenzielle Datenangriffe keine sicheren Schlüsse im Hinblick auf Einzelangaben gezogen werden können. Zur Durchführung des Verfahrens wird im Originaldatenbestand jedem Fall eine Zufallszahl (ein sogenannter Record Key) zugewiesen, die für jeden Einzeldatensatz separat aus einer Gleichverteilung zwischen 0 und 1 gezogen wird. Bei jeder Aggregation der Daten werden nicht nur die Fälle selbst, sondern auch die zugehörigen Zufallszahlen dieser Fälle aufsummiert. Die Nachkommastellen dieser Summe ergeben dann erneut eine Zufallszahl - den Cell Key. Mithilfe dieser Cell Keys und einer sogenannten Überlagerungsmatrix werden dann konsistente geheimhaltende Tabellen erzeugt (siehe nachfolgendes Anwendungsbeispiel).

Die Überlagerungsmatrix legt für alle denkbaren Originalfallzahlen fest, welcher Prozentsatz der Ergebnisse wie stark verändert wird. Sie kann beispielsweise so konzipiert werden, dass große Fallzahlen selten, kleine (eher geheimhaltungsbedürftige) Fallzahlen jedoch häufiger verändert werden. Dabei ist gewährleistet, dass die Ergebnisse in den Tabellen unter Berücksichtigung der Geheimhaltung erwartungstreu sind, das heißt im Mittelwert den Originalergebnissen entsprechen. Tabellenfelder mit dem Originalwert "0" sollen grundsätzlich nicht verändert werden, um keine Unplausibilitäten zu erzeugen. Um die Abweichung von der Originalfallzahl so gering wie möglich zu halten, werden konsequenterweise auch Randsummen überlagert. Die Ergebnistabellen sind dann allerdings nicht mehr additiv. Würde die Additivität nachträglich wiederhergestellt, ginge dies zwangsläufig auf Kosten der Konsistenz und der Genauigkeit der Ergebnisse.

## Anwendungsbeispiele

Um Aufdeckungsrisiken zu minimieren, wird die tatsächlich genutzte Überlagerungsmatrix später nicht veröffentlicht. Die hier abgebildete Version in Form eines Überlagerungstableaus dient der Veranschaulichung der grundlegenden Prinzipien und Vorgehensweisen bei Anwendung der CKM.

![](/DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/_Bilder/geheimhaltung_in_den_bevoelkerungsstatistiken.png?__blob=normal&v=2)

Die graue Farbe signalisiert, welcher Anteil der Originalfallzahlen bei Nutzung dieser Überlagerungsmatrix nicht verändert wird. Hellblau steht für eine Veränderung um ±1, Blau für die in diesem Beispiel maximale Veränderung um ±2. Eine 1 in der Tabelle bleibt in 50 % der Fälle eine 1. Fallzahlen größer oder gleich 2 bleiben zu 70 % als Originalwert nach Durchführung des Verfahrens erhalten. Die 0 ist von der Überlagerung ausgeschlossen, sodass eine nicht vorhandene Beobachtung auch nicht künstlich erzeugt wird.

Die durch Aufsummierung der Record Keys generierte Zufallszahl entscheidet jeweils, ob und wie stark der Originalwert tatsächlich verändert wird. Dies geschieht, indem der Cell Key jeweils mit den kumulierten Übergangswahrscheinlichkeiten (siehe Abbildung oben) abgeglichen wird. Hierzu zwei Beispiele auf Grundlage der abgebildeten Überlagerungsmatrix:

**Beispiel 1:**

Tabellenmerkmal

Anzahl der Sterbefälle

Originalwert

1

Record Key = Cell Key

0,864

Veränderung

+1

Veröffentlichtes Ergebnis

2

**Beispiel 2:**

Tabellenmerkmal

Anzahl der Sterbefälle

Originalwert

932 272

Summe der Record Keys

467 212,652

Cell Key

0,652

Veränderung

±0

Veröffentlichtes Ergebnis

932 272

Bei der tatsächlichen Ausgestaltung der Überlagerungsmatrix gilt es, einen Kompromiss zu finden. Auf der einen Seite muss sichergestellt sein, dass die Daten ausreichend geschützt sind. Auf der anderen Seite sollen die Veränderungen so gering wie möglich sein, um das Nutzungspotenzial nicht einzuschränken.

## Genauigkeit der Ergebnisse

Um die Auswirkung der CKM auf die publizierten Daten im Vergleich zu den Originaldaten einschätzen zu können, lässt sich in Bezug auf die Genauigkeit der betroffenen Bevölkerungsstatistiken festhalten:

-   Der in den Tabellen üblicherweise zu erwartende mittlere Betrag der Abweichung zwischen überlagerten und originalen Fallzahlen liegt unter 0,5.
-   Mindestens 90 % der Fallzahlen in den Tabellen bleiben unverändert oder weichen um maximal 1 vom Originalwert ab.
-   Bei höchstens 5 % der Fallzahlen in den Tabellen liegt die Abweichung bei 3 oder mehr.
-   Bei höchstens 0,5 % der Fallzahlen in den Tabellen liegt die Abweichung bei 4 oder mehr.

Eine eigenständige Bearbeitung und Berechnung, zum Beispiel das Zusammenfassen von Daten nach Einzelalter zu Altersgruppen, führt ggf. zu größeren Abweichungen von den Originalergebnissen. Es wird daher empfohlen, die von den statistischen Ämtern des Bundes und der Länder berechneten Daten zu nutzen.

Die CKM wird für die betroffenen Bevölkerungsstatistiken generell ab dem Berichtsjahr 2025 eingesetzt. Falls Ergebnisse für zurückliegende Zeiträume mit der CKM geheim gehalten werden, wird eine abweichende Überlagerungsmatrix verwendet.

## Weiterführende Informationen

-   [FAQ zur Cell-Key-Methode im Statistikportal](https://www.statistikportal.de/de/cell-key-methode "Externer Link Schutz von Einzelangaben in der amtlichen Statistik")
-   Rothe, Patrick/Güttgemanns, Volker/Rohde, Johannes/Setzer, Stefanie: Die Cell-Key-Methode in den Forschungsdatenzentren der Statistischen Ämter des Bundes und der Länder - [Teil 1: Vorstellung des neuen Geheimhaltungsverfahrens](DE/Methoden/WISTA-Wirtschaft-und-Statistik/2024/03/cell-key-methode-teil1-032024.html?nn=209016) / [Teil 2: Auswirkungen des neuen Geheimhaltungsverfahrens](DE/Methoden/WISTA-Wirtschaft-und-Statistik/2024/03/cell-key-methode-teil2-032024.html?nn=209016). In: WISTA Wirtschaft und Statistik. Ausgabe 3/2024, Teil 1 Seite 31 ff., Teil 2 Seite 45 ff.
-   Rohde, Johannes/Seifert, Christiane/Gießing, Sarah: [Entscheidungskriterien für die Auswahl eines Geheimhaltungsverfahrens](DE/Methoden/WISTA-Wirtschaft-und-Statistik/2018/03/entscheidungskriterien-geheimhaltungsverfahren-032018.html?nn=209016). In: WISTA Wirtschaft und Statistik. Ausgabe 3/2018, Seite 90 ff.
-   Rothe, Patrick: [Statistische Geheimhaltung - Der Schutz vertraulicher Daten in der amtlichen Statistik](https://www.forschungsdatenzentrum.de/sites/default/files/arbeitspapier-50.pdf). In: Publikationen des Forschungsdatenzentrums. 2019.

## Weiterführende Themen

-   [Bevölkerungsstand](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Bevoelkerungsstand/_inhalt.html)
-   [Bevölkerungsvorausberechnung](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Bevoelkerungsvorausberechnung/_inhalt.html)
-   [Haushalte und Familien](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Haushalte-Familien/_inhalt.html)
-   [Migration und Integration](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Migration-Integration/_inhalt.html)
-   [Geburten](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Geburten/_inhalt.html)
-   [Eheschließungen, Ehescheidungen und Lebenspartnerschaften](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Eheschliessungen-Ehescheidungen-Lebenspartnerschaften/_inhalt.html)
-   [Wanderungen](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Wanderungen/_inhalt.html)
-   [Zensus 2022](DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Zensus2022/_inhalt.html)

© Statistisches Bundesamt (Destatis) | 2026
