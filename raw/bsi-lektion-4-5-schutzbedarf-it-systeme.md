---
title: "BSI  -  Lerneinheit 4.5: Schutzbedarfsfeststellung für IT-Systeme"
token: "655"
source_link: "https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/Lektion_4_05_node.html"
topic: "unclassified"
tags: []
generated_at: "2026-05-18T17:20:20Z"
source: "web"
---
# Lerneinheit 4.5:

Schutzbedarfsfeststellung für IT-Systeme

![Bild-Dokument für das Frontend](https://www.bsi.bund.de/SiteGlobals/Frontend/Images/kopfbereich.png?__blob=normal&v=11)

![Reihenfolge bei der Schutzbedarfsfeststellung - der nachfolgend beschriebene Schritt ist hervorgehoben.](https://www.bsi.bund.de/SharedDocs/Bilder/DE/BSI/Themen/grundschutzdeutsch/Webkurs2018/Abb_4_05_Schritt2.png?__blob=normal&v=1)

IT-Systeme werden eingesetzt, um Anwendungen zu unterstützen. Der Schutzbedarf eines IT-Systems hängt damit im Wesentlichen von dem Schutzbedarf derjenigen Anwendungen ab, für deren Ausführung es benötigt wird. Der Schutzbedarf der Anwendung vererbt sich wie oben beschrieben auf den Schutzbedarf des IT-Systems.

Nachfolgend einige Hinweise zu speziellen Typen von IT-Systemen

- In **virtualisierten Infrastrukturen** werden in der Regel mehrere IT-Systeme auf einem Virtualisierungsserver betrieben. Der Schutzbedarf der einzelnen virtuellen IT-Systeme ergibt sich aus dem der Anwendungen, der des Virtualisierungsservers ergibt sich daraus zunächst nach dem Maximumprinzip. Wenn aber mehrere Schäden zu einem höheren Gesamtschaden führen können, kann sich der Schutzbedarf des Virtualisierungsservers durch Kumulation erhöhen. Für das Schutzziel Verfügbarkeit gilt: Wenn durch Konzepte der Virtualisierung Redundanzen geschaffen werden, kann wegen des Verteilungseffekts der Schutzbedarf des Virtualisierungsservers wieder gesenkt werden.
- Den Schutzbedarf von **ICS-Komponenten** sollten Sie gemeinsam mit den Anlagenverantwortlichen auf Grundlage des Anwendungszwecks festlegen. Dabei kann es sinnvoll sein, die Definition der Schutzbedarfskategorien an die besonderen Bedingungen einer Produktionsumgebung anzupassen.
- Für **sonstige Geräte** (z. B. aus dem Bereich Internet of Things) müssen Sie zunächst feststellen, für welche Geschäftsprozesse und Anwendungen sie eingesetzt werden. Zur Ermittlung des Schutzbedarfs eines Geräts betrachten Sie den möglichen Schaden für den jeweiligen Geschäftsprozess. Sie sollten nur Geräte erfassen, die einen nennenswerten Einfluss auf die Informationssicherheit haben, und sie möglichst zu Gruppen zusammenfassen.

Auch der Schutzbedarf für die IT-Systeme sollte für jeden der drei Grundwerte (Vertraulich­keit, Integrität und Verfügbarkeit) festgelegt und anschließend z. B. tabellarisch dokumentiert werden. Ein Beispiel:

Schutzbedarfsfeststellung für IT-Systeme

| Bezeichnung und Beschreibung | Schutzziel und Schutzbedarf | Begründung |
| --- | --- | --- |
| S007 Virtualisierungsserver | Vertraulichkeit:  **hoch** | *Maximumprinzip*:  Der Domain Controller beinhaltet das Active Directory und damit die Anmeldeinformationen aller Mitarbeiter. |
| Integrität:  **hoch** | *Maximumprinzip*:  Der Dateiserver verwaltet Dateien, deren Korrektheit für den Geschäftsbetrieb sichergestellt sein muss. |
| Verfügbarkeit:  **hoch** | *Kumulationseffekt*:  Sowohl der Domain Controller als auch der Dateiserver haben jeder (sehr) hohe Verfügbarkeitsanforderungen. Daraus ergibt sich für den Virtualisierungsserver ein sehr hoher Schutzbedarf.  Alle virtualisierten Systeme können aber innerhalb kurzer Zeit auf dem anderen Virtualisierungsserver zur Verfügung gestellt werden. Durch diesen *Verteilungseffekt* reduziert sich der Schutzbedarf auf ein nur noch hohes Niveau. |
| N001 Internet-Router | Vertraulichkeit:  **hoch** | Es werden auch vertrauliche Informationen über die Internet-Anbindung übertragen, wenn ein Kunde oder Geschäftspartner eine verschlüsselte Kommunikation nicht unterstützt. |
| Integrität:  **normal** | Fehlerhafte Daten können in der Regel leicht erkannt werden. |
| Verfügbarkeit:  **normal** | Ein Ausfall der Internet-Anbindung kann für 24 Stunden toleriert werden. |
| N002 Firewall | Vertraulichkeit:  **hoch** | Es werden auch vertrauliche Informationen über die Internet-Anbindung übertragen, wenn ein Kunde oder Geschäftspartner eine verschlüsselte Kommunikation nicht unterstützt. Außerdem werden die verschlüsselten Verbindungen zu den Vertriebsbüros über die Firewall abgewickelt. |
| Integrität:  **normal** | Fehlerhafte Daten können in der Regel leicht erkannt werden. |
| Verfügbarkeit:  **normal** | Ein Ausfall der Internet-Anbindung kann für 24 Stunden toleriert werden. |
| S200 Alarmanlagen | Vertraulichkeit:  **normal** | Die Alarmanlagen verarbeiten keine vertraulichen Informationen. |
| Integrität:  **sehr** **hoch** | Das korrekte Funktionieren der Alarmanlagen ist für die Sicherheit der Gebäude sehr wichtig. |
| Verfügbarkeit:  **sehr** **hoch** | Das korrekte Funktionieren der Alarmanlagen ist für die Sicherheit der Gebäude sehr wichtig. |

## Vorherige/nächste Seite:

- [Lerneinheit 4.4: Schutzbedarfsfeststellung für Prozesse und Anwendungen](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/Lektion_4_04_node.html "Weitere Informationen unter: \"Lerneinheit 4.4: Schutzbedarfsfeststellung für Prozesse und Anwendungen\"")
- [Lerneinheit 4.6: Schutzbedarfsfeststellung für Räume](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_06/Lektion_4_06_node.html "Weitere Informationen unter: \"Lerneinheit 4.6: Schutzbedarfsfeststellung für Räume\"")

## Ähnliche Themen

- [4.1 Grundlegende Definitionen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_01/Lektion_4_01_node.html)
- [4.2 Schutzbedarfskategorien
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_02/Lektion_4_02_node.html)
- [4.3 Vorgehen und Vererbung
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_03/Lektion_4_03_node.html)
- [4.4 Schutzbedarfsfeststellung für Prozesse und Anwendungen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_04/Lektion_4_04_node.html)
- [4.6 Schutzbedarfsfeststellung für Räume
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_06/Lektion_4_06_node.html)
- [4.7 Schutzbedarfsfeststellung für Kommunikationsverbindungen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_07/Lektion_4_07_node.html)
- [Test zu Lektion 4: Fragen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_08/Lektion_4_08_node.html)
- [Test zu Lektion 4: Lösungen
  ![](https://www.bsi.bund.de/_config/NaviChildOrSiblingsModuleDefaultIcon.png?__blob=value&v=3)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_09/Lektion_4_09_node.html)

[Zurück zu Lektion 4: Schutzbedarfsfeststellung](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_05/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/IT-Grundschutz/Zertifizierte-Informationssicherheit/IT-Grundschutzschulung/Online-Kurs-IT-Grundschutz/Lektion_4_Schutzbedarfsfeststellung/Lektion_4_node.html)

Kurz-URL:
:   <https://www.bsi.bund.de/dok/10990108>
