---
title: "Cell-Key Methode Teil 2 (PDF)"
token: "5926"
source_link: "inbox/cell-key-methode-teil2-032024.pdf"
topic: "unclassified"
tags: ["source/file", "privacy/public", "ingest", "pdf", "cell-key"]
generated_at: "2026-05-19T07:09:11Z"
source: "file"
---

## Page 1

Statistisches Bundesamt | WISTA | 3 | 2024
45
DIE CELL-KEY-METHODE IN DEN 
FORSCHUNGSDATENZENTREN DER 
STATISTISCHEN ÄMTER DES BUNDES 
UND DER LÄNDER
Teil 2: Auswirkungen des neuen Geheimhaltungs-
verfahrens
Patrick Rothe, Volker Güttgemanns, Johannes Rohde,  
Stefanie Setzer
Patrick Rothe
hat Sozialwissenschaften an der 
Universität Mannheim studiert 
und ist seit 2011 im Bayerischen 
Landesamt für Statistik tätig. Seit 
2018 leitet er dort das Sachgebiet 
„Grundsatzfragen der amtlichen 
Statistik, Digitalisierung, For­
schungsdatenzentrum, Kompe­
tenzzentrum Analyse“. Inhaltlich 
beschäftigt er sich schwerpunkt-
mäßig unter anderem mit der 
statistischen Geheimhaltung.
Volker Güttgemanns
hat einen Master of Science in 
Wirtschaftswissenschaften und war 
von 2017 bis 2023 stellvertretende 
Leitung der Geschäftsstelle des For­
schungsdatenzentrums der Statisti­
schen Ämter der Länder.
Dr. Johannes Rohde
hat Wirtschaftswissenschaften an 
der Leibniz Universität Hannover 
studiert und dort 2015 seine Pro­
motion im Bereich Statistik abge­
schlossen. Bei IT.NRW leitet er den 
Service „Mathematisch-statistische 
Methoden und experimentelle 
Statistik“.
Stefanie Setzer
ist Diplom-Soziologin und Referen­
tin im Referat „Forschungsdatenzen­
trum, Methoden der Datenanalyse“ 
des Statistischen Bundesamtes. 
Schwerpunkt ihrer Arbeit ist die 
fachliche und methodische Weiter­
entwicklung des Arbeitsbereichs.
	 Schlüsselwörter: Geheimhaltung – stochastische Überlagerung – post-tabular – 
Verhältniszahlen – Zeitreihen
ZUSAMMENFASSUNG
Die Cell-Key-Methode ist ein hauptsächlich für die Geheimhaltung von Fallzahltabel­
len entwickeltes Geheimhaltungsverfahren. In den Forschungsdatenzentren der Sta­
tistischen Ämter des Bundes und der Länder werden häufig umfangreiche Analysen 
vorgenommen, auf deren Ergebnisdarstellung sich das neue Verfahren ebenfalls aus­
wirken kann. Der Artikel beschreibt die Auswirkungen, die das Verfahren auf die Ergeb­
nisqualität, Fallzahltabellen, Verhältniszahlen und Zeitreihen hat.
	 Keywords: confidentiality – stochastic perturbation – post-tabular – ratios – time 
series
ABSTRACT
The cell key method is a disclosure control method that was primarily developed to 
ensure the confidentiality of frequency tables. Extensive analyses are frequently car­
ried out in the Research Data Centres of the statistical offices of the Federation and 
the Länder, and the new method can affect the presentation of the results. This article 
describes the effects that the method has on the quality of results, frequency tables, 
ratios and time series.

## Page 2

Patrick Rothe, Volker Güttgemanns, Johannes Rohde, Stefanie Setzer
1
Einleitung
Die Statistischen Ämter des Bundes und der Länder 
führen für ausgewählte Statistiken ein neues Geheim­
haltungsverfahren ein: die Cell-Key-Methode (CKM) | 1. 
Um die Geheimhaltung der Ergebnisse über alle Ver­
öffentlichungen hinweg sicherzustellen, wenden die 
Forschungsdatenzentren der amtlichen Statistik dieses 
Verfahren entsprechend an. Der Artikel „Die Cell-Key-
Methode in den Forschungsdatenzentren der Statisti­
schen Ämter des Bundes und der Länder – Teil 1: Vorstel­
lung des neuen Geheimhaltungsverfahrens“ (Setzer und 
andere, 2024) beschreibt das Verfahren ausführlich.
Die Schutzwirkung der Cell-Key-Methode entsteht durch 
eine post-tabulare Überlagerung aller Fallzahlen. In der 
überlagerten Tabelle lässt sich hierdurch letztendlich 
nicht mehr erkennen, welche Werte überlagert wurden 
und welche weiterhin dem Originalwert entsprechen. 
Diese Vorgehensweise stellt einen großen Unterschied 
zur bisher überwiegend angewandten Zellsperrung dar, 
in der ausgewiesene Werte immer dem Originalwert ent­
sprechen, insbesondere kleine Fallzahlen aber gesperrt 
werden. Die Auswirkungen des neuen Verfahrens auf die 
Ergebnisqualität, Fallzahltabellen, Verhältniszahlen und 
Zeitreihen werden in diesem Beitrag vorgestellt. Dazu 
beschreibt Kapitel 2 detailliert die Auswirkungen auf 
Fallzahltabellen, Kapitel 3 befasst sich mit den Effekten, 
die die Cell-Key-Methode auf Verhältniszahlen haben 
kann. Auch auf Zeitreihen kann sich die Anwendung der 
Cell-Key-Methode auswirken, wie in Kapitel 4 dargestellt 
wird. Ein kurzes Fazit zur Nutzung des neuen Geheim­
haltungsverfahrens in den Forschungsdatenzentren 
beschließt den Artikel.
  1	 Die Cell-Key-Methode wurde vom australischen Statistikamt (Austra­
lien Bureau of Statistics) entwickelt (Fraser/Wooton, 2005).
2
Auswirkungen auf Fallzahltabellen
2.1	 Kurzüberblick
Bei Fallzahltabellen, die mit der Cell-Key-Methode über­
lagert wurden, sind zwei wesentliche Auswirkungen 
besonders hervorzuheben:
>	 Mit der Cell-Key-Methode geheim gehaltene Tabellen 
sind immer konsistent. Kommen logisch identische 
Tabellenfelder also in verschiedenen Tabellen vor 
(zum Beispiel in einer univariaten Fallzahltabelle und 
als Randwert einer Kreuztabelle), wird immer die glei­
che überlagerte Fallzahl ausgegeben. Dies gewähr­
leisten eine vorher festgelegte Übergangsmatrix und 
der Record Key, der den einzelnen Erhebungseinhei­
ten fest zugeordnet ist. 
>	 Mit der Cell-Key-Methode geheim gehaltene Tabellen 
sind nicht additiv. Da Tabelleninnen- und -randfelder 
unabhängig voneinander überlagert werden, addie­
ren sich die überlagerten Innenfelder nicht (oder nur 
zufällig) zu den überlagerten Randsummen. Eine Wie­
derherstellung der Additivität wäre zwar theoretisch 
möglich, würde aber die Konsistenz und Qualität der 
Ergebnisse beeinträchtigen und zudem die benötigte 
Rechenzeit erhöhen, sodass darauf verzichtet wird.
2.2	 Auswirkungen im Detail
Additivität und Konsistenz der geheim gehaltenen Tabel­
lenergebnisse stellen zwei wesentliche Anforderungen 
an statistische Verfahren zur Geheimhaltung von Tabel­
len dar. Gerade im Kontext der Verwendung der Cell-Key-
Methode sind diese beiden Eigenschaften von besonde­
rer Bedeutung.
Additivität einer Tabelle ist dann gegeben, wenn sich 
die Innenfelder der Tabelle zur ausgewiesenen Summe 
im entsprechenden Randfeld aufaddieren lassen – was 
bei einer unbearbeiteten Tabelle der Normalfall ist und 
in aller Regel von den Nutzenden auch so erwartet wird. 
Bestimmte Verfahren zur statistischen Geheimhaltung, 
die aus der Familie der datenverändernden Methoden 
stammen, führen im Ergebnis jedoch dazu, dass diese 
Statistisches Bundesamt | WISTA | 3 | 2024
46

## Page 3

Die Cell-Key-Methode in den Forschungsdatenzentren der Statistischen Ämter  
des Bundes und der Länder – Teil 2: Auswirkungen des neuen Geheimhaltungsverfahrens
Eigenschaft verletzt wird. Somit entspricht die Summe 
der aufaddierten Innenfelder nicht zwangsläufig der in 
der Tabelle ausgewiesenen Randsumme. Dieser geschil­
derte Effekt („Nicht-Additivität“) tritt auch bei der Cell-
Key-Methode auf und entsteht, indem jedes Feld einer 
Tabelle separat – das heißt unabhängig von allen ande­
ren Tabellenfeldern – dem datenverändernden Algo­
rithmus unterzogen wird. Innenfelder werden somit 
genauso wie die in der Tabelle enthaltenen Zwischen- 
oder Gesamtsummen behandelt. Dieses separate Vorge­
hen bewirkt in der Regel einen Verlust der Additivitäts­
eigenschaft. 
Auf den ersten Blick kann dieser Effekt für die Nutzenden 
irritierend erscheinen, letztlich führt dieses Vorgehen 
unter Gesichtspunkten der Datenqualität und Informa­
tionserhaltung jedoch zu einem besseren Ergebnis: Die 
separate Überlagerung jedes Tabellenfeldes verhindert, 
dass sich Abweichungen über eine Tabellenzeile oder 
-spalte hinweg aufaddieren und die nach Geheimhal­
tung ausgewiesene Randsumme gegenüber dem Origi­
nalwert stark abweicht. Eine Veränderung um die Höhe 
der Maximalabweichung multipliziert mit der Anzahl der 
beteiligten Tabellenfelder wäre dabei im Extremfall für 
Randsummen nicht ausgeschlossen. Die unabhängige 
Überlagerung aller Tabellenfelder führt jedoch auch bei 
Tabellenfeldern mit Zwischen- oder Gesamtsummen 
dazu, dass der veränderte Wert vom Originalwert nie­
mals weiter abweichen kann als es die vorher festge­
legte Maximalvorgabe zulässt. | 2
Dieser Vorteil hinsichtlich der Datenqualität wird jedoch 
durch die Diskrepanz zwischen den aufaddierten Sum­
men der einzelnen Tabellenfelder und den in der Tabelle 
ausgewiesenen Zwischen- und Gesamtsummen erkauft. 
Dieser Unterschied kann unter Umständen deutlich aus­
fallen. Daher sollten Nutzende darauf verzichten, selbst­
ständig Rechenoperationen mit den Angaben aus den 
per Cell-Key-Methode geheim gehaltenen Ergebnistabel­
len vorzunehmen, sondern direkt auf die in der Tabelle 
ausgewiesenen Summenfelder zurückgreifen.
Eine Nicht-Additivität fällt immer dann besonders auf, 
wenn nur sehr wenige Tabellenfelder zu einer Rand­
summe beitragen und diese durch einfaches Kopfrech­
nen sehr schnell ermittelt werden kann. Ein Beispiel 
hierfür ist die Aufgliederung des Merkmals „Geschlecht“ 
  2	 Weitere Betrachtungen zur Nicht-Additivität der Cell-Key-Methode 
finden sich in Höhne/Höninger (2018).
nach den drei Merkmalsausprägungen „weiblich“, 
„männlich“ und „divers“ in einer fiktiven Tabelle: Hier­
bei ist die Summation der Fallzahlen in den drei Innen­
feldern sehr einfach möglich, wobei es sehr wahrschein­
lich ist, dass die selbstständig berechnete Summe von 
der in der geheim gehaltenen Tabelle ausgewiesenen 
Gesamtsumme abweicht. In größeren Tabellen mit einer 
größeren Anzahl an beitragenden Spalten oder Zeilen 
fällt dieses Problem jedoch nicht direkt ins Auge. 
Konsistenz  hingegen bezeichnet die Eigenschaft eines 
spezifischen Tabellenfeldes, immer den identischen 
inhaltlichen Wert auszuweisen – unabhängig von der 
konkreten Tabelle, in der  diese Merkmalskombination 
ausgewiesen wird. Nicht alle Geheimhaltungsverfahren 
können dies gewährleisten, da hierfür zwingend gesi­
chert sein muss, dass ein- und dasselbe inhaltliche 
Tabellenfeld in allen Fällen durch die gewählte Methode 
identisch behandelt wird. Die Cell-Key-Methode ist auf­
grund ihrer Ausgestaltung in der Lage, diese Eigenschaft 
zu erfüllen. Gewährleistet wird dies durch die Aggrega­
tion der zu einem individuellen Tabellenfeld beitragen­
den Record Keys zum für das Verfahren namensgeben­
den Cell Key. Da dieser bei Vorhandensein derselben 
Kombination von Merkmalsträgern jeweils identisch 
ausfällt, ist auch die Datenveränderung stets identisch. 
Das gilt unabhängig davon, in welcher Tabelle und auf 
welchem Veröffentlichungsweg das entsprechende 
Tabellenfeld publiziert wird.
Neben einer höheren Nutzendenfreundlichkeit – die 
Ergebnisse hängen beispielsweise nicht vom Abrufzeit­
punkt ab – geht diese Eigenschaft auch mit einem gestei­
gerten Schutz der Daten und der für deren Überlagerung 
genutzten Parameter einher. Bei nicht konsistentem Ver­
halten könnte im Gegensatz hierzu bei einer größeren An­
zahl an Ergebnisabrufen – zumindest näherungsweise –
auf die dahinterliegende Originalangabe geschlossen 
werden, da sich die positiven und negativen Abweichun­
gen vom sich ergebenden Mittelwert bei einem erwar­
tungstreuen Verfahren im Mittel ausgleichen.
Statistisches Bundesamt | WISTA | 3 | 2024
47

## Page 4

Patrick Rothe, Volker Güttgemanns, Johannes Rohde, Stefanie Setzer
 Übersicht 1 basiert auf dem Beispiel des Artikels „Die 
Cell-Key-Methode in den Forschungsdatenzentren der 
Statistischen Ämter des Bundes und der Länder – Teil 1: 
Vorstellung des neuen Geheimhaltungsverfahrens“ (Set-
zer und andere, 2024) und zeigt die Veränderungen, die 
durch die Cell-Key-Methode bezüglich der Randsummen 
ausgelöst werden können. 
2.3 Weitere Qualitätskriterien
Ein Geheimhaltungsverfahren sollte stets so konzipiert 
sein, dass das Gleichgewicht zwischen dem Schutz der 
Angaben der Befragten und dem Erhalt des Informati-
onspotenzials einer Statistik sichergestellt ist. Höhne/
Höninger (2018) benennen dafür neben den bereits 
erläuterten Aspekten der Konsistenz und Additivität drei 
weitere grundsätzliche Ziele von Geheimhaltungsver-
fahren, wobei unterschiedliche Verfahren die einzelnen 
Ziele unterschiedlich priorisieren.  Übersicht 2 stellt 
diese Ziele vor und geht auf deren Erfüllung durch die 
Cell-Key-Methode und die aktuell in den Forschungs-
datenzentren überwiegend genutzte Zellsperrung ein.
Zur Frage der Akzeptanz der Ergebnisse (Punkt 3): Ins-
gesamt haben interne Testrechnungen der statistischen 
Ämter ergeben, dass der durch Anwendung der Cell-Key-
Methode verursachte Informationsverlust bei der Wahl 
geeigneter Parameter gering ist (Rohde und andere, 
2021). Dabei ist zu beachten, dass sich bei kleinen (Ori-
ginal-)Fallzahlen auch Überlagerungen mit einem abso-
lut gesehen geringen Wert stark auswirken können: Wird 
beispielsweise die Originalfallzahl 3 mit dem Wert + 6 
überlagert (+ 200 %), ist die relative Abweichung deut-
lich höher als bei der entsprechenden Überlagerung 
einer höheren Fallzahl (zum Beispiel + 0,6 % bei einer 
Originalfallzahl von 1 000). Die Generierung von Tabel-
len mit vielen kleinen Fallzahlen ist daher nach Möglich-
keit zu vermeiden, indem Auswertungen nicht auf einer 
unnötig tiefen regionalen oder fachlichen Gliederungs-
ebene vorgenommen werden. 
Einkommen
Übersicht 1
Auswirkungen der Cell-Key-Methode auf die Additivität einer Fallzahltabelle 
Originaltabelle
Überlagerte Tabelle
Alter
Alter
jung
alt
∑
jung
alt
∑
niedrig
0
3
3
Cell-Key-Methode
niedrig
0
4
4
mittel
4
5
9
mittel
4
6
8
hoch
2
1
3
hoch
0
0
3
∑
6
9
15
∑
6
10
15
Farblegende
Randsumme 
ist Summe der 
Einkommen
Innenfelder
ja
nein
Ausgangswert 
unverändert
 
 
ja
nein
Statistisches Bundesamt | WISTA | 3 | 2024
48

## Page 5

Die Cell-Key-Methode in den Forschungsdatenzentren der Statistischen Ämter  
des Bundes und der Länder – Teil 2: Auswirkungen des neuen Geheimhaltungsverfahrens
3
Verhältniszahlen
Verhältniszahlen sind mathematische Beziehungen zwi-
schen statistischen Größen, die einen sinnvollen Zusam-
menhang darstellen. Generell können drei Kategorien 
von Verhältniszahlen unterschieden werden (Bourier, 
2011):
1. Gliederungszahlen: Diese setzen eine Teilgröße 
in Beziehung zur Gesamtgröße und werden oft als 
Anteilswerte bezeichnet, wie bei Geschlechter-
quoten.
2. Beziehungszahlen: Hier werden unterschiedliche 
Größen miteinander in Beziehung gesetzt, die in 
einem sachlichen Zusammenhang stehen, wie das 
Bruttoinlandsprodukt je Einwohner/-in.
3. Messzahlen: Diese setzen inhaltlich ähnliche Größen 
in Beziehung, jedoch zu unterschiedlichen Zeitpunk-
ten, Zeiträumen oder Regionen, wie die Veränderung 
des Bruttoinlandsprodukts im Vergleich zum Vorjahr.
In der wissenschaftlichen Forschung ist die Berechnung 
von Verhältniszahlen eine gängige Methode. Dabei ist 
es wichtig, die geltenden Geheimhaltungsvorschriften 
und -regelungen zu beachten, insbesondere auch im 
Rahmen von Forschungsprojekten in den Forschungsda-
tenzentren. Eine grundlegende Anforderung besteht vor 
diesem Hintergrund darin, die Geheimhaltung gemäß 
den fachspezifischen Konzepten sicherzustellen, um ein 
konsistentes Vorgehen über verschiedene Analysen und 
Veröffentlichungen hinweg zu gewährleisten. Dies kann 
auch spezielle statistische Regelungen für den Umgang 
mit Verhältniszahlen erforderlich machen, die von den 
Forschungsdatenzentren wie von ihren Nutzenden zu 
berücksichtigen sind.
Für Nutzende der Forschungsdatenzentren ist es ent-
scheidend, die Methodik der Geheimhaltung und deren 
Auswirkungen zu verstehen, um die Qualität der berech-
neten Verhältniszahlen selbst einschätzen zu können. 
Der folgende Abschnitt erläutert die Auswirkungen der 
Cell-Key-Methode auf Verhältniszahlen sowie auf deren 
Aussagekraft.
Übersicht 2
Vergleich von Cell-Key-Methode und Zellsperrung bei Erreichen der Geheimhaltungsziele
Ziel
Cell-Key-Methode
Zellsperrung
1. Keine unplausiblen Werte
2. Schutz der Einzelangaben
3. Akzeptanz der Ergebnisse
4. Ergebnisse sind konsistent
5. Ergebnisse sind additiv
Durch die Ausgestaltung der Übergangsmatrix kann sicher-
gestellt werden, dass in Fallzahltabellen keine unplausiblen 
Ergebnisse generiert werden (Originalfallzahl 0 wird nicht 
verändert).
Bei der Berechnung von Kennzahlen kann es jedoch vor 
allem bei kleinen Fallzahlen zu Unplausibilitäten kommen, 
wenn beispielsweise Zähler und Nenner von Verhältniszahlen 
gegenläufig verändert werden oder sich bei Trendanalysen das 
Vorzeichen ändert. Diese ungewünschten Effekte lassen sich 
jedoch durch geeignete Maßnahmen vermeiden.
Fallzahlen werden nicht verändert, sondern bei zu geringer 
Besetzung gesperrt. Daher können keine unplausiblen 
Fallzahlen entstehen. Dies gilt auch für die Berechnung von 
Kennzahlen und Zeitreihen.
Bei der Ausgestaltung der Übergangsmatrix wird sichergestellt, 
dass die Veränderungen groß genug sind, um den Schutz der 
Einzelangaben sicherzustellen.
Fallzahlen unterhalb einer festgelegten Mindestfallzahl werden 
gesperrt, durch Gegensperrungen wird eine Rückrechnung 
verhindert. Der Schutz der Einzelangaben ist also bei korrekter 
Anwendung des Verfahrens sichergestellt.
Bei der Ausgestaltung der Übergangsmatrix wird berücksich-
tigt, dass die Veränderungen (unter Berücksichtigung von 
Punkt 2) klein genug sind, um bei einem Großteil der Nutzen-
den auf Akzeptanz zu stoßen.
Je nach Größe der betrachteten (Sub-)Population und der 
Detailtiefe der betrachteten Merkmale werden die Sperrungen 
von einigen Nutzenden als zu restriktiv betrachtet.
Logisch identische Tabellenfelder werden immer mit dem 
gleichen Wert überlagert.
Durch die unabhängige Überlagerung der einzelnen Fallzahlen 
sind geheim gehaltene Tabellen nicht additiv. | 1
Sperrmuster werden auch tabellenübergreifend umgesetzt, so-
dass Veränderungen bei korrekter Umsetzung des Zellsperrver-
fahrens konsistent sind. Bei häufig genutzten Statistiken und 
vielen Ergebnistabellen können übersehene Zusammenhänge 
zwischen Tabellenfeldern allerdings zu Fehlern führen.
Additivität bleibt in Tabellen bestehen, sofern keine Sperrun-
gen erfolgen.
 Ziel voll erreicht    
 Ziel teilweise erreicht    
 Ziel nicht erreicht
1 Die Additivität könnte durch einen Algorithmus wiederhergestellt werden, der die überlagerten Werte so verändert, dass sich die Tabelleninnenfelder wieder zu den Randfeldern addieren. 
Dieses Vorgehen hätte aber zwei entscheidende Nachteile: Zum einen erfordert die Herstellung der Additivität zusätzliche Rechenleistung und verlängert die für die Tabellenerstellung benötig-
te Laufzeit, zum anderen wären die Ergebnisse danach nicht mehr konsistent, was die Qualität der Daten entscheidend beeinträchtigen würde.
Statistisches Bundesamt | WISTA | 3 | 2024
49

## Page 6

Patrick Rothe, Volker Güttgemanns, Johannes Rohde, Stefanie Setzer
3.1 Auswirkungen auf Verhältniszahlen
Basis für die Geheimhaltung von Verhältniszahlen mit 
der Cell-Key-Methode ist die Veränderung der Zähler und 
Nenner entsprechend ihrer Cell Keys. Dadurch kann es 
vor allem bei kleinen Fallzahlen passieren, dass sich 
das errechnete Verhältnis deutlich vom Wert der nicht 
überlagerten Verhältniszahl unterscheidet. Diese Unge-
nauigkeiten verringern sich mit größeren Fallzahlen. Aus 
diesem Grund wird von einer Berechnung von Verhält-
niszahlen abgeraten, wenn diese auf nur wenigen Fällen 
beruhen.
3.2 Umgang mit Verhältniszahlen
Häufig werden Verhältniszahlen aus den überlagerten 
Fallzahlen von Zähler und Nenner berechnet, was hier 
als „A-posteriori-Verhältniszahl“ bezeichnet wird. | 3 Da -
her kann es bei datenverändernden Geheimhaltungs-
verfahren wie der Cell-Key-Methode zu unerwünschten 
Effekten kommen:
> Ungenauigkeit: Bei der Anwendung der Cell-Key-
Methode kann die Veränderungsrichtung der Fall-
zahlen zufällig stark gegenläufig sein, das heißt 
Zähler und Nenner werden um einen hohen positiven 
beziehungsweise negativen Wert (oder umgekehrt) 
verändert. Das kann insbesondere bei kleinen Fall-
zahlen zu erheblichen Abweichungen zwischen der 
ursprünglichen und der A-posteriori-Verhältniszahl 
führen. Dieser Effekt verringert sich jedoch mit stei-
genden Fallzahlen.
> Unplausibilität: Ein weiterer unerwünschter Effekt 
kann auftreten, wenn zum Beispiel der ursprünglich 
kleinere Zähler nach der Veränderung größer ist als 
der veränderte Nenner. In diesem Fall würden sich 
A-posteriori-Anteilswerte über 100 % ergeben.
> Veränderung der Aussage: Besonders bei der Analyse 
von Zeitreihen kann die Anwendung der Cell-Key-
Methode zu Trendverzerrungen oder sogar zu einer 
Trendumkehr führen (siehe Kapitel 4).
Während die Überlagerung von Fallzahlen eine feste 
Varianz aufweist, stellen Enderle und andere (2018) 
 3 Weiterführende Vorschläge für Techniken zur Anwendung stochasti-
scher Überlagerung bei Verhältniszahlen, die als Quotient aus zwei 
Wertsummen gebildet werden, finden sich in Gießing (2013).
 
fest, dass dies nicht auf Verhältniswerte zutrifft, die auf 
Basis zweier überlagerter Werte berechnet wurden. Für 
das Ausmaß der Abweichung des tatsächlichen Ver-
hältniswerts R := X/Y zum überlagerten Verhältniswert 
Rˆ := Xˆ/Yˆ spielen die Originalfallzahlen, aus denen das 
Verhältnis berechnet wird, eine große Rolle: je größer 
die Fallzahlen X und Y, desto geringer die Abweichung 
des Verhältniswerts. Zur Veranschaulichung der Prob-
lematik kleiner Fallzahlen nennen Enderle und andere 
(2018) folgendes Beispiel: Die relativ kleinen Original-
fallzahlen x = 4 und y = 4 werden zueinander ins Ver-
hältnis gesetzt. Für den tatsächlichen Verhältniswert gilt 
damit: R = 4/4, also 100 %. Bei einer Maximalabwei-
chung von D = 3 könnten die überlagerten Fallzahlen die 
Werte 𝑥𝑥𝑥𝑥ො= 𝑥𝑥𝑥𝑥+ 𝐷𝐷𝐷𝐷= 7 und 𝑦𝑦𝑦𝑦ො= 𝑦𝑦𝑦𝑦−𝐷𝐷𝐷𝐷= 1 annehmen. 
 
Der überlagerte Verhältniswert wäre dann Rˆ = 7/1, also 
700 %. 
3.3 Beurteilung der Qualität eines  
Anteilswertes
Die Qualität eines Anteilswertes muss von Wissenschaft-
lerinnen und Wissenschaftlern bewertet werden kön-
nen. Dafür sind Informationen über die Verteilung der 
zufälligen Abweichungen von der Originalgröße erfor-
derlich, wobei jedoch die Details dieser Abweichungen 
nicht offengelegt werden dürfen. Um die Qualität von 
Anteilswerten zu beurteilen kann die relative Standard-
abweichung als ein Maß für die Streuung um die Origi-
nalfallzahl verwendet werden. | 4
Die relative Standardabweichung für Anteilswerte oder 
für alle Verhältniszahlen, die als Quotienten aus verän-
derten Fallzahlen im Zähler und Nenner gebildet wer-
den, wird wie folgt berechnet:
Angenommen, qxy repräsentiert die Wahrscheinlich-
෪
keit, dass einem veränderten Anteilswert 𝑣𝑣𝑣𝑣 ∶= ቀ
𝑥𝑥𝑥𝑥ቁ der 
 
𝑦𝑦𝑦𝑦
Originalzähler 𝑥𝑥𝑥𝑥∈𝒟𝒟𝒟𝒟𝑥𝑥𝑥𝑥 und der Originalnenner 𝑦𝑦𝑦𝑦∈𝒟𝒟𝒟𝒟𝑦𝑦𝑦𝑦  
zugrunde liegen, und d(v)xy repräsentiert die Abwei-
chungen zwischen dem veränderten Anteilswert 𝑣𝑣𝑣𝑣𝑣  und 
den möglichen originalen Anteilswerten v, dann kann 
die (absolute) Standardabweichung für den veränderten 
Anteilswert 𝑣𝑣𝑣𝑣𝑣  wie folgt approximiert werden:
 4 Anstelle der absoluten Standardabweichung wird die relative Stan-
dardabweichung als Gütemaß herangezogen, da diese die zufällige 
Streuung um die Originalfallzahl ins Verhältnis zur Größe des Origi-
nalwertes setzt.
̃
Statistisches Bundesamt | WISTA | 3 | 2024
50

## Page 7

Die Cell-Key-Methode in den Forschungsdatenzentren der Statistischen Ämter  
des Bundes und der Länder – Teil 2: Auswirkungen des neuen Geheimhaltungsverfahrens
𝜎𝜎𝜎𝜎(𝑣𝑣𝑣𝑣෤) = ඩ෍𝑞𝑞𝑞𝑞𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥⋅𝑑𝑑𝑑𝑑(𝑣𝑣𝑣𝑣)𝑥𝑥𝑥𝑥𝑥𝑥𝑥𝑥
2
x∈𝒟𝒟𝒟𝒟x
y∈𝒟𝒟𝒟𝒟y 
 
Der entsprechende Relative Root Mean Square Error 
(RRMSE) oder die approximierte relative Standardab-
weichung (auch Variationskoeffizient genannt) für den 
veränderten Anteilswert 𝑣𝑣𝑣𝑣𝑣 ergibt sich dann gemäß
𝑘𝑘𝑘𝑘(𝑣𝑣𝑣𝑣𝑣) = 𝜎𝜎𝜎𝜎(𝑣𝑣𝑣𝑣𝑣)
𝑣𝑣𝑣𝑣𝑣 .
Für Mittelwerte oder Verhältniswerte, bei denen die 
Wertsumme im Zähler und/oder Nenner (gegebenen-
falls verändert) in die Berechnung einfließt, erfordert 
das beschriebene Verfahren einige Anpassungen. Eine 
alternative Vorgehensweise besteht darin, die relative 
Standardabweichung von v mithilfe der Übergangswahr-
scheinlichkeiten zu bestimmen.
Für die Hochschulstatistik wurden die Auswirkungen 
unterschiedlicher Parametrisierungen auf die Qualität 
von Verhältniszahlen untersucht. Das Ergebnis zeigt, 
dass die Wahl von Bleibewahrscheinlichkeiten und 
maximaler Abweichung von der Originalfallzahl nicht die 
entscheidenden Faktoren für die Qualität von Verhältnis-
zahlen darstellen. Vielmehr hängt die Qualität vor allem 
von der Größe der zugrunde liegenden Fallzahlen ab, die 
in die Berechnung einfließen. Demnach beeinträchtigen 
insbesondere kleine Fallzahlen die Qualität und Aus-
sagekraft der Verhältniszahlen. Erst ab einer bestimm-
ten Größe der Basiszahlen im Zähler und Nenner kann 
eine ausreichende statistische Aussagekraft gewährleis-
tet werden (Enderle/Vollmar, 2019).
3.4 Empfehlungen bei der Berechnung 
von Verhältniszahlen
Ohne Kenntnis der unveränderten Verhältniszahlen ist 
es für Nutzende nicht möglich, die Qualität einer Verhält-
niszahl zu beurteilen. Die Höhe der relativen Standard-
abweichung oder des RRMSE hängt in erster Linie von 
der Größe der einbezogenen Fallzahlen ab. Daher wird 
allgemein empfohlen, Verhältniszahlen nur auf Basis 
ausreichend hoher Fallzahlen im Zähler und Nenner zu 
berechnen, denn die Varianz geht in diesen Fällen ohne-
hin gegen Null. 
Sollte die Berechnung einzelner Verhältniszahlen auf 
Basis geringer Fallzahlen für eine Forschungsfrage uner-
lässlich sein, können Nutzende der Forschungsdaten-
zentren ihren betreuenden FDZ-Standort um Unterstüt-
zung bitten.
4
Zeitreihen
Zeitreihen sind wertvolle Instrumente, um zeitliche Ver-
läufe und Entwicklungen darzustellen. Hierbei werden 
Kennzahlen auf der Basis von Zeitpunkten oder Zeiträu-
men berechnet. Dies ermöglicht die Analyse von absolu-
ten oder relativen Veränderungen über die Zeit hinweg.
Wie bei der Berechnung von Verhältniszahlen sind 
auch bei der Betrachtung von Zeitreihen die geltenden 
Geheimhaltungsvorschriften und -regelungen der Fach-
statistik zu beachten. 
4.1 Auswirkungen auf Zeitreihen
Die Anwendung der Cell-Key-Methode kann negative 
Auswirkungen auf die Analyse von Zeitreihen haben. 
Das gilt sowohl beim Vergleich von zwei mittels Cell-Key-
Methode geheim gehaltenen Erhebungswellen als auch 
bei der Betrachtung von zwei Erhebungswellen mit unter-
schiedlicher Geheimhaltung, also beim Vergleich der 
Erhebungsjahre vor und nach Einführung der Cell-Key-
Methode. Besonders bei sehr geringen Unterschieden 
in den unveränderten Fallzahlen der beiden vergliche-
nen Beobachtungszeiträume kann es bei gegenläufiger 
Veränderung der betrachteten Werte vorkommen, dass 
Unterschiede zwischen den Erhebungswellen vergrößert 
oder verkleinert werden. Im Extremfall ist sogar eine 
Trendumkehr möglich. Sehr schwache Veränderungen 
im Zeitverlauf sind bei Anwendung der Cell-Key-Methode 
daher mit Vorsicht zu interpretieren.
4.2 Umgang mit Zeitreihen
Zeitreihen basieren auf Daten aus verschiedenen Zeit-
räumen und werden verwendet, um die zeitliche Entwick-
lung von Sachverhalten zu analysieren. Die einzelnen 
Datenpunkte zu den verschiedenen Berichtszeiträumen 
bilden die Basis für entsprechende Betrachtungen.
Statistisches Bundesamt | WISTA | 3 | 2024
51

## Page 8

Patrick Rothe, Volker Güttgemanns, Johannes Rohde, Stefanie Setzer
Die Bildung von Differenzen aus veränderten Daten­
punkten kann zu weniger sicheren Ergebnissen führen. 
Das gilt insbesondere dann, wenn eine Differenz anhand 
kleiner Fallzahlen berechnet wird. 
Bei der Berechnung von Differenzen sind bei der Geheim­
haltung mit der Cell-Key-Methode spezifische Herausfor­
derungen zu berücksichtigen:
I.	 Umgang mit Differenzen, wenn beide Daten­
punkte aus CKM-Datenbeständen stammen
Bei der Differenz zwischen zwei zufällig veränderten 
Datenpunkten können ähnliche Herausforderungen auf­
treten wie bei Saldierungen (siehe Abschnitt 4.3). Dies 
trifft insbesondere bei kleinen Fallzahlen zu und wenn 
die einzelnen Punkte starke, gegenläufige Veränderun­
gen aufweisen. In der Konsequenz kann die Anwendung 
der Cell-Key-Methode theoretisch Veränderungen in der 
Trendstärke und sogar eine Änderung des Trendvorzei­
chens verursachen.
Für diese Herausforderungen gibt es (statistikspezi­
fische) Lösungsansätze. Im Zensus 2022 wird eine 
Methode gewählt, die einen Vorzeichenwechsel vermei­
det. In der Bevölkerungsstatistik und der Hochschulsta­
tistik hingegen wird die Differenz aus den beiden überla­
gerten Datenpunkten gebildet. Aus methodischer Sicht 
führt dies zu einer Verdopplung der in den CKM-Parame­
tern vorgegebenen Varianz. Wenn X1 und X2 zwei verän­
derte Datenpunkte mit identischer, als CKM-Parameter 
festgelegter Varianz V sind, gilt für ihre Differenz: 
Var (X1 – X2) = Var (X1) + Var (X2) = 2V
Dies erhöht im Vergleich zu den einzelnen absoluten 
Fallzahlen das Risiko einer größeren Abweichung von 
der Originaldifferenz. Basieren die Zeitreihen (oder die 
einzelnen Datenpunkte) jedoch auf ausreichend großen 
Fallzahlen, wird der Effekt einer Verzerrung der Trend­
stärke vernachlässigbar.
Um das Risiko einer wesentlichen Veränderung der 
Trendstärke zu minimieren, empfehlen die Forschungs­
datenzentren, in wissenschaftlichen Veröffentlichungen 
Analysen auf Basis von Zeitreihen nur auf Basis einer 
ausreichend hohen Fallzahl durchzuführen. Wie hoch 
diese Fallzahlgrenze ist, hängt von der genutzten Statis­
tik ab sowie von den betrachteten Merkmalen. Der für 
die jeweilige Statistik fachlich zuständige FDZ-Standort 
kann hierzu beratend unterstützen.
II.	 Umgang mit Differenzen, wenn die Daten­
punkte aus unterschiedlich geheim gehaltenen 
Datenbeständen stammen
Ändert sich das Geheimhaltungsverfahren zwischen 
zwei Berichtszeitpunkten, beispielsweise durch den 
Wechsel von der Zellsperrung zur Cell-Key-Methode, 
führt dies zu einem methodischen Bruch in der Zeitreihe. 
Die Forschungsdatenzentren haben für diesen Fall gere­
gelt, dass an dem Punkt des Bruchs, also dort, wo der 
Wechsel des Geheimhaltungsverfahrens erfolgt, keine 
Differenzen berechnet werden dürfen. Dies hat zur Kon­
sequenz, dass die Zeitreihe am Bruchpunkt unterbro­
chen ist. Vergleiche zwischen den Berichtszeitpunkten 
der Umstellung sind daher nicht möglich. Einige Fach­
statistiken, wie der Zensus, haben jedoch entschieden, 
frühere Wellen ihrer Statistik nachträglich ebenfalls mit 
der Cell-Key-Methode geheim zu halten. Entsprechende 
Vergleiche anhand der beiden mit der Cell-Key-Methode 
geheim gehaltenen Datenbestände sind dann wieder 
möglich. Die Information, ob das für eine bestimmte 
Statistik durchgeführt wurde, findet sich in den entspre­
chenden von den Forschungsdatenzentren bereitgestell­
ten Metadatenreports.
4.3	 Umgang mit Saldierungen
Der Umgang mit Saldierungen ist in Bezug auf die 
grundlegende Problematik sehr ähnlich dem Umgang 
mit Zeitreihen. Wird ein Saldo, also die Differenz zweier 
veränderter Fallzahlen, berechnet (beispielsweise der 
Wanderungssaldo in der Bevölkerungsstatistik), so führt 
die Verknüpfung zweier stochastischer Größen zu einer 
höheren Unsicherheit des Ergebnisses. Dies geschieht, 
weil die Varianz der Differenz im Vergleich zur vorhan­
denen Varianz bei der Veränderung einzelner Fallzahlen 
verdoppelt wird (siehe Abschnitt 4.2). Dadurch kann die 
Aussagekraft des Saldos bei kleinen Fallzahlen verzerrt 
werden. Zudem besteht die theoretische Möglichkeit, 
dass bei Anwendung der Cell-Key-Methode das Vorzei­
chen des Saldos wechselt, wenn beide Originalfallzah­
len gegenläufig verändert werden und die Fallzahlen 
sowohl klein sind als auch nahe beieinanderliegen. Der 
relative Effekt solcher Verzerrungen aufgrund möglicher 
großer Abweichungen von der ursprünglichen Differenz 
nimmt jedoch ab, je größer die zugrunde liegenden Fall­
zahlen sind – ähnlich wie bei Verhältniszahlen und Zeit­
reihendifferenzen. 
Statistisches Bundesamt | WISTA | 3 | 2024
52

## Page 9

Die Cell-Key-Methode in den Forschungsdatenzentren der Statistischen Ämter  
des Bundes und der Länder – Teil 2: Auswirkungen des neuen Geheimhaltungsverfahrens
Die Forschungsdatenzentren empfehlen daher auch bei 
Saldierungen, entsprechende Auswertungen nur auf 
Basis ausreichend hoher Fallzahlen vorzunehmen. Bei 
vielen kleinen Fallzahlen sollte die Auswertung nach 
Möglichkeit auf einer höheren regionalen oder fachli­
chen Aggregationsebene (zum Beispiel Landkreise statt 
Gemeindeebene oder Wirtschaftszweig-4-Steller statt 
-5-Steller) erfolgen, ebenso sollten schwach besetzte 
Kategorien gruppiert werden.
5
Fazit
Im Vergleich mit den traditionellen Geheimhaltungsver­
fahren, allen voran der weit verbreiteten Zellsperrung, 
weist die Cell-Key-Methode mit Blick auf die Abwägung 
zwischen Informationsverlust und Aufdeckungsrisiko 
einige Vorteile auf. Allerdings hat dieser Beitrag aus­
führlich dargestellt, dass die Datennutzenden sowie die 
Forschungsdatenzentren auch neue Besonderheiten bei 
der Auswertung und Interpretation der mit der Cell-Key-
Methode geheim gehaltenen Ergebnisse berücksichti­
gen müssen.
Da die Cell-Key-Methode für die Geheimhaltung von Fall­
zahltabellen ausgelegt ist, kann es bei darüber hinaus­
gehenden Analysen auf Basis von Verhältniszahlen, Zeit­
reihen und Saldierungen zu Problemen kommen. Diese 
sind vermeidbar, sofern Auswertungen immer auf Basis 
ausreichend großer Fallzahlen vorgenommen werden. 
Sollten bei der Nutzung in den Forschungsdatenzentren 
Probleme oder Unsicherheiten entstehen, können Nut­
zende sich jederzeit an ihren betreuenden FDZ-Standort 
wenden. 
Statistisches Bundesamt | WISTA | 3 | 2024
53

## Page 10

Patrick Rothe, Volker Güttgemanns, Johannes Rohde, Stefanie Setzer
LITERATURVERZEICHNIS
Bourier, Günther. Beschreibende Statistik. Praxisorientierte Einführung – Mit Aufgaben 
und Lösungen. Wiesbaden 2011, Seite 19 ff. DOI: 10.1007/978-3-8349-6556-1
Enderle, Tobias/Giessing, Sarah/Tent, Reinhard. Designing Confidentiality on the Fly 
Methodology – Three Aspects. In: Domingo-Ferrer, Josep/Montes, Francisco (Heraus­
geber). Privacy in Statistical Databases. LNCS (Lecture Notes in Computer Science). 
2018. Ausgabe 11126, Seite 28 ff. DOI: 10.1007/978-3-319-99771-1_3
Enderle, Tobias/Vollmar, Meike. Geheimhaltung in der Hochschulstatistik. In: WISTA 
Wirtschaft und Statistik. Ausgabe 6/2019, Seite 87 ff.
Fraser, Bruce/Wooton, Janice. A proposed method for confidentialising tabular output 
to protect against differencing. Work session on statistical data confidentiality. Sup­
porting paper. Genf 2005. [Zugriff am 30. April 2024]. Verfügbar unter: unece.org
Giessing, Sarah. What shall we do with the ratios? Work session on statistical data 
confidentiality. Supporting paper. Ottawa 2013. [Zugriff am 7. Mai 2024]. Verfügbar 
unter: unece.org
Höhne, Jörg/Höninger, Julia. Die Cell-Key-Methode – ein Geheimhaltungsverfahren. In: 
Zeitschrift für amtliche Statistik Berlin Brandenburg. Ausgabe 3+4/2018, Seite 14 ff. 
[Zugriff am 30. April 2024]. Verfügbar unter: www.statistischebibliothek.de
Marley, Jennifer K./Leaver, Victoria L. A Method for Confidentialising User-Defined 
Tables: Statistical Properties and a Risk-Utility Analysis. In: Proceedings of 58th World 
Statistical Congress. 2011. [Zugriff am 30. April 2024]. Verfügbar unter:
2011.isiproceedings.org
Rohde, Johannes/Seifert, Christiane/Gießing, Sarah/Setzer, Stefanie (unter Mitar­
beit von Breitenfeld, Jörg/Brings, Stefan/Höhne, Jörg/Höninger, Julia/Rothe, Patrick/
Schedding-Kleis, Ulrike). Entscheidungskriterien für die Auswahl eines Geheimhal­
tungsverfahrens. Version 1.1 vom 23.04.2021. Internes Dokument des Statistischen 
Verbunds (Statistische Ämter des Bundes und der Länder).
Setzer, Stefanie/Rohde, Johannes/Güttgemanns, Volker/Rothe, Patrick. Die Cell-Key-
Methode in den Forschungsdatenzentren der Statistischen Ämter des Bundes und 
der Länder - Teil 1: Vorstellung des neuen Geheimhaltungsverfahrens. In: WISTA Wirt­
schaft und Statistik. Ausgabe 3/2024, Seite 31 ff.
Statistisches Bundesamt | WISTA | 3 | 2024
54

## Page 11

Herausgeber
Statistisches Bundesamt (Destatis), Wiesbaden
Schriftleitung
Dr. Daniel Vorgrimler
Redaktion: Ellen Römer
Ihr Kontakt zu uns
www.destatis.de/kontakt
Erscheinungsfolge
zweimonatlich, erschienen im Juni 2024
Ältere Ausgaben finden Sie unter www.destatis.de sowie in der Statistischen Bibliothek.
Artikelnummer: 1010200-24003-4, ISSN 1619-2907
© Statistisches Bundesamt (Destatis), 2024
Vervielfältigung und Verbreitung, auch auszugsweise, mit Quellenangabe gestattet.
