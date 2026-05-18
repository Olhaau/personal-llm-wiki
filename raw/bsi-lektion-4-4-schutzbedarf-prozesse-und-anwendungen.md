---
title: "BSI  -  Lerneinheit 4.4: Schutzbedarfsfeststellung für Prozesse und Anwendungen"
token: "636"
source_link: "https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/Lektion_4_04_node.html"
topic: "unclassified"
tags: []
generated_at: "2026-05-18T17:20:19Z"
source: "web"
---
# Lerneinheit 4.4:

Schutzbedarfsfeststellung für Prozesse und Anwendungen

![Bild-Dokument für das Frontend](https://www.bsi.bund.de/SiteGlobals/Frontend/Images/kopfbereich.png?__blob=normal&v=11)

![Reihenfolge bei der Schutzbedarfsfeststellung - der nachfolgend beschriebene Schritt ist hervorgehoben.](https://www.bsi.bund.de/SharedDocs/Bilder/DE/BSI/Themen/grundschutzdeutsch/Webkurs2018/Abb_4_04_Schritt1.png?__blob=normal&v=1)

![Hinweis](https://www.bsi.bund.de/SharedDocs/Bilder/DE/BSI/Themen/grundschutzdeutsch/Webkurs2018/Icons/icon_hinweis.png?__blob=normal&v=1)

Um die Schäden einzuschätzen, die aus Verletzungen der Integrität, Vertraulichkeit oder Verfügbarkeit bei den Prozessen und Anwendungen entstehen können, sollten Sie **aus Sicht der Anwender** realistische Schadensszenarien entwickeln.

Dabei kann es Ihnen helfen, **„Was wäre wenn ...?“-Fragen** zu jedem Schadensszenario zu formulieren, z. B. was wäre, wenn geheime Geschäftsdaten aus der Anwendung „Finanzbuchhaltung“ bekannt würden?

- Gegen welche Gesetze oder Vorschriften wird verstoßen? Welche rechtlichen Konsequenzen oder Sanktionen können mit dem Vorfall verbunden sein?
- Gibt es Personen, deren informationelles Selbstbestimmungsrecht beeinträchtigt wird? Wenn ja, mit welchen Folgen?
- Wie stark werden Abläufe in der Firma behindert?
- Droht ein Image-Schaden und mit welchen Folgen wäre er verbunden?
- Kann dieser Vorfall finanzielle Auswirkungen haben und falls ja, in welcher Höhe?

Im Anhang des [BSI-Standards 200-2](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/SharedDocs/Downloads/DE/BSI/Grundschutz/BSI_Standards/standard_200_2.html "BSI-Standard 200-2") finden Sie zu jedem Schadensszenario beispielhafte Fragestellungen, die Sie für Ihre Schutzbedarfsfeststellung anpassen und eventuell ergänzen können.

Im nächsten Schritt beantworten Sie für alle Anwendungen, die Sie in der Strukturanalyse erfasst haben, die zu den Schadensszenarien entwickelten Fragen und schätzen so den Schutzbedarf der Anwendungen im Hinblick auf die drei Grundwerte Vertraulichkeit, Integrität und Verfügbarkeit ein.

Bei der Abschätzung des Schadens sollten Sie unbedingt die Verantwortlichen und die Benutzer der Anwendung einbeziehen. Diese wissen meist sehr genau, welche Schäden bei falschen Daten oder bei einem Ausfall einer Anwendung auftreten. Es ist trotzdem möglich, dass der Schutzbedarf innerhalb der Projektgruppe oder von befragten Mitarbeitern unterschiedlich eingeschätzt wird. Falls kein Konsens erzielt werden kann, muss das Management entscheiden.

![Hinweis](https://www.bsi.bund.de/SharedDocs/Bilder/DE/BSI/Themen/grundschutzdeutsch/Webkurs2018/Icons/icon_hinweis.png?__blob=normal&v=1)

Wichtig ist, dass Sie die Schutzbedarfsfeststellungen begründen und zwar so ausführlich, dass die getroffenen Entscheidungen auch von anderen Personen (z. B. der Leitung) und zu späteren Zeitpunkten nachvollzogen und gegebenenfalls auch korrigiert werden können. So können Geschäftsführung, Benutzer und Abteilungsleiter durchaus unterschiedlicher Auffassung darüber sein, wie wichtig eine Anwendung für die Geschäftsvorgänge ist.

![Logo RECPLAST](https://www.bsi.bund.de/SharedDocs/Bilder/DE/BSI/Themen/grundschutzdeutsch/Webkurs2018/Icons/icon_recplast.png?__blob=normal&v=1)

Nachfolgend als Beispiel die Schutzbedarfsfeststellung für einige Anwendungen der RECPLAST GmbH.

Schutzbedarfsfeststellung für Anwendungen

| Bezeichnung und Beschreibung | Schutzziel und Schutzbedarf | Begründung |
| --- | --- | --- |
| A001 Textverarbeitung, Präsentation, Tabellenkalkulation | Vertraulichkeit:  **normal** | Die Office-Anwendung selbst enthält keine Informationen |
| Integrität:  **normal** | Die Office-Anwendung selbst enthält keine Informationen |
| Verfügbarkeit:  **normal** | Die Anwendung ist lokal installiert; eine Neuinstallation ist schnell möglich. Die Lizenzen sind sicher verwahrt. Eine Ausfallzeit von 24 Stunden oder mehr ist akzeptabel. |
| A002 Lotus Notes | Vertraulichkeit:  **hoch** | Es werden Mails mit vertraulichem Inhalt bearbeitet; die Informationen über Geschäftskontakte und Treffen mit Partnern oder Kunden sind vertraulich. |
| Integrität:  **normal** | Fehlerhafte Daten können in der Regel leicht erkannt werden. |
| Verfügbarkeit:  **sehr hoch** | Mails, Kontaktdaten und Terminvereinbarungen sind wesentlich für die Geschäftsvorgänge. Ein Ausfall von mehr als 2 Stunden kann nicht hingenommen werden. |
| A010 Active Directory | Vertraulichkeit:  **normal** | Passwörter sind verschlüsselt gespeichert und damit praktisch nicht zugänglich |
| Integrität:  **hoch** | Alle Mitarbeiter identifizieren sich mit Passwörtern, daher ist der Schutzbedarf hoch. |
| Verfügbarkeit:  **sehr** **hoch** | Bei Ausfall des Authentisierungssystems können Mitarbeiter sich nicht identifizieren; eine Ausführung von IT-Verfahren ist dann nicht möglich. Ein Ausfall von mehr als 2 Stunden ist nicht tolerabel. |

## Vorherige/nächste Seite:

- [Lerneinheit 4.3: Vorgehen und Vererbung](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_03/Lektion_4_03_node.html "Weitere Informationen unter: \"Lerneinheit 4.3: Vorgehen und Vererbung\"")
- [Lerneinheit 4.5: Schutzbedarfsfeststellung für IT-Systeme](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/Lektion_4_05_node.html "Weitere Informationen unter: \"Lerneinheit 4.5: Schutzbedarfsfeststellung für IT-Systeme\"")

## Ähnliche Themen

- [4.1 Grundlegende Definitionen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_01/Lektion_4_01_node.html)
- [4.2 Schutzbedarfskategorien
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_02/Lektion_4_02_node.html)
- [4.3 Vorgehen und Vererbung
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_03/Lektion_4_03_node.html)
- [4.5 Schutzbedarfsfeststellung für IT-Systeme
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/Lektion_4_05_node.html)
- [4.6 Schutzbedarfsfeststellung für Räume
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_06/Lektion_4_06_node.html)
- [4.7 Schutzbedarfsfeststellung für Kommunikationsverbindungen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_07/Lektion_4_07_node.html)
- [Test zu Lektion 4: Fragen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_08/Lektion_4_08_node.html)
- [Test zu Lektion 4: Lösungen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_09/Lektion_4_09_node.html)

[Zurück zu Lektion 4: Schutzbedarfsfeststellung](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_node.html)

Kurz-URL:
:   <https://www.bsi.bund.de/dok/10990142>
