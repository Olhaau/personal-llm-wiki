---
title: "Uebersicht ueber Active Directory Domain Services | Microsoft Learn"
token: "458"
source_link: "https://learn.microsoft.com/de-de/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview"
topic: "windows-server-ad-ds"
tags: [ingest, web, windows-server, active-directory, ad-ds, microsoft-learn, source/web, privacy/public, fetched]
generated_at: "2026-05-12T00:00:00Z"
---

# Uebersicht ueber Active Directory Domain Services | Microsoft Learn

Ein Verzeichnis ist eine hierarchische Struktur, in der Informationen zu Objekten in einem Netzwerk gespeichert werden. Ein Verzeichnisdienst, z. B. Active Directory Domain Services (AD DS), stellt die Methoden fuer die Speicherung von Verzeichnisdaten und die Verfuegbarmachung dieser Daten fuer Netzwerkbenutzerinnen, Netzwerkbenutzer und Administratorinnen sowie Administratoren bereit. Beispielsweise speichert AD DS Informationen zu Benutzerkonten, z. B. Namen, Kennwoerter und Telefonnummern. AD DS bietet auch eine Moeglichkeit fuer autorisierte Benutzer im selben Netzwerk, auf diese Informationen zuzugreifen.

AD DS speichert Informationen zu Objekten im Netzwerk und erleichtert Administratoren und Benutzern das Auffinden und Verwenden dieser Informationen. AD DS verwendet einen strukturierten Datenspeicher als Grundlage fuer eine logische, hierarchische Organisation von Verzeichnisinformationen.

Dieser Datenspeicher, auch bekannt als Verzeichnis, enthaelt Informationen zu AD DS-Objekten. Diese Objekte umfassen in der Regel freigegebene Ressourcen wie Server, Volumes, Drucker und die Netzwerkbenutzer- und Computerkonten. Weitere Informationen zum AD DS-Datenspeicher finden Sie unter [Verzeichnisdatenspeicher](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc736627%28v=ws.10%29).

Die Sicherheit ist ueber die Anmeldeauthentifizierung und Zugriffssteuerung fuer Objekte im Verzeichnis in AD DS integriert. Mit einem einzelnen Netzwerkbenutzernamen und Kennwort koennen Administratoren Verzeichnisdaten und Organisation im gesamten Netzwerk verwalten, und autorisierte Netzwerkbenutzer koennen ueberall im Netzwerk auf Ressourcen zugreifen. Durch die richtlinienbasierte Verwaltung wird selbst die Verwaltung der komplexesten Netzwerke erleichtert. Weitere Informationen zur AD DS-Sicherheit finden Sie unter [Bewaehrte Methoden zum Sichern von Active Directory](../../plan/security-best-practices/best-practices-for-securing-active-directory).

AD DS umfasst ausserdem Folgendes:

- Eine Reihe von Regeln, das **Schema**, das die Klassen von Objekten und Attributen definiert, die im Verzeichnis enthalten sind, die Einschraenkungen und Beschraenkungen fuer Instanzen dieser Objekte und das Format ihrer Namen. Weitere Informationen zum Schema finden Sie unter [Schema](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc756876%28v=ws.10%29).
- Ein **globaler Katalog**, der Informationen zu jedem Objekt im Verzeichnis enthaelt. Benutzer und Administratoren koennen den Katalog verwenden, um Verzeichnisinformationen unabhaengig von der Verzeichnisdomaene zu finden, die die Daten tatsaechlich enthaelt. Weitere Informationen zum globalen Katalog finden Sie im [globalen Katalog](/de-de/windows/win32/ad/global-catalog).
- Ein **Abfrage- und Indexmechanismus**, sodass Objekte und ihre Eigenschaften veroeffentlicht und von Netzwerkbenutzern bzw. Anwendungen gefunden werden koennen. Weitere Informationen zum Abfragen des Verzeichnisses finden Sie unter [Suchen in Active Directory Domain Services](/de-de/windows/win32/ad/searching-in-active-directory-domain-services).
- Ein **Replikationsdienst**, der Verzeichnisdaten ueber ein Netzwerk verteilt. Alle Domaenencontroller in einer Domaene nehmen an der Replikation teil und enthalten eine vollstaendige Kopie aller Verzeichnisinformationen fuer ihre Domaene. Jede Aenderung an den Verzeichnisdaten wird zu allen Domaenencontrollern in der Domaene repliziert. Weitere Informationen zur AD DS-Replikation finden Sie unter [Active Directory-Replikationskonzepte](../replication/active-directory-replication-concepts).

## Grundlegendes zu AD DS

Dieser Abschnitt enthaelt Links zu den wichtigsten AD DS-Konzepten:

- [Struktur und -Speichertechnologien in Active Directory](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc759186%28v=ws.10%29)
- [Domaenencontrollerrollen](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc786438%28v=ws.10%29)
- [Active Directory-Schema](/de-de/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771796%28v=ws.10%29)
- [Verwalten von Vertrauensstellungen](/de-de/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771568%28v=ws.10%29)
- [Active Directory-Replikationstechnologien](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc776877%28v=ws.10%29)
- [Active Directory-Such- und Veroeffentlichungstechnologien](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc775686%28v=ws.10%29)
- [DNS-Gruppenrichtlinieneinstellungen](/de-de/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197486%28v=ws.10%29)
- [Technische Referenz zum Active Directory-Schema](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc759402%28v=ws.10%29)

Eine detaillierte Liste der AD DS-Konzepte finden Sie unter [Grundlegendes zu Active Directory](/de-de/previous-versions/windows/it-pro/windows-server-2003/cc781408%28v=ws.10%29).
