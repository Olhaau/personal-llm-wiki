# FDZ Business-Tax-Panel - Metadaten und Nutzungshinweise

> Forschungsdatenzentren der Statistischen Ämter des Bundes und der Länder: Umfassende Dokumentation des Business-Tax-Panels (BTP) für die empirische Steuerforschung.

## Auf einen Blick

| Eigenschaft | Wert |
|-------------|------|
| **Datenquelle** | FDZ der Statistischen Ämter des Bundes und der Länder |
| **Zeitraum** | 2013-2019 (jährliche Erweiterung) |
| **Beobachtungen** | >66 Millionen Einheiten |
| **Variablen** | >2.700 Merkmale |
| **DOI (GWAP)** | 10.21242/73511.2019.00.05.2.1.0 |
| **DOI (KDFV)** | 10.21242/73511.2019.00.05.1.1.0 |
| **URL** | https://www.forschungsdatenzentrum.de/de/steuern/btp |

---

## 1. Datengrundlagen

Das Business-Tax-Panel führt **7 amtliche Statistiken** im Quer- und Längsschnitt zusammen:

| Statistik | EVAS-Nr. | Inhalt |
|-----------|----------|--------|
| Gewerbesteuerstatistik | 73511 | Gewerbeerträge, Steuermessbeträge, Zerlegung |
| Körperschaftsteuerstatistik | 73211 | Körperschaftsteuererklärungen, Einkommensermittlung |
| Umsatzsteuerstatistik (Voranmeldungen) | 73311 | Steuerbare Umsätze, Vorsteuer, monatlich/quartalsweise |
| Statistik über Personengesellschaften | 73121 | Gesonderte/einheitliche Gewinnfeststellung |
| Umsatzsteuerstatistik (Veranlagungen) | 73321 | Jahres-Umsatzsteuererklärungen |
| Einnahmenüberschussrechnung | 73111 | Anlage EÜR aus Lohn-/Einkommensteuerstatistik |
| Unternehmensregister | 52111 | Umsatz, Beschäftigte, Rechtsform, WZ-Klassifikation |

### Verknüpfungsprinzip

Die Zusammenführung erfolgt primär über **Steuernummern**:
1. Aktuelle Steuernummer (Qualitätsstufe 1)
2. Aktuelle und alte Steuernummern (Qualitätsstufe 2)
3. Handelsregistereintragung, manuelle Prüfung, Cluster-Steuernummern (Qualitätsstufe 3)

---

## 2. Fallzahlen und Struktur

### Beobachtungen pro Jahr

| Jahr | Einheiten gesamt | Gewerbesteuer | Körperschaftsteuer | USt-Voranm. | Pers.Ges. | USt-Veranl. | URS | EÜR |
|------|------------------|---------------|-------------------|-------------|-----------|-------------|-----|-----|
| 2013 | 8.689.793 | 3.633.451 | 1.210.838 | 3.243.538 | 1.205.110 | 6.435.280 | 3.474.431 | 3.703.982 |
| 2014 | 8.759.322 | 3.714.176 | 1.236.129 | 3.240.221 | 1.220.521 | 6.446.620 | 3.550.775 | 3.720.318 |
| 2015 | 9.051.437 | 3.819.938 | 1.264.717 | 3.255.537 | 1.234.537 | 6.535.948 | 3.634.643 | 4.230.871 |
| 2016 | 9.260.593 | 3.887.556 | 1.293.431 | 3.266.429 | 1.247.699 | 6.550.960 | 3.674.354 | 4.581.982 |
| 2017 | 9.989.806 | 3.981.853 | 1.316.520 | 3.266.806 | 1.220.067 | 6.664.535 | 3.708.949 | 5.685.661 |
| 2018 | 10.491.366 | 4.050.674 | 1.350.837 | 3.279.136 | 1.284.121 | 6.831.036 | 3.736.550 | 6.310.028 |
| 2019 | 10.750.726 | 4.099.690 | 1.388.679 | 3.288.306 | 1.294.898 | 6.972.252 | 3.723.169 | 6.501.292 |

### Wellenstruktur (Panelbalance)

- **28,4%** der Einheiten (4.730.266) sind in **allen 7 Jahren** beobachtet
- **8,7%** nur im Jahr 2019 (Neuzugänge)
- Ca. **33%** pro Jahr sind nur in einer Statistik erfasst (nicht verknüpft)

### Regionale Verteilung (2019)

Die größten Anteile entfallen auf:
- Bayern: 2.211.476 (20,6%)
- Nordrhein-Westfalen: 1.982.633 (18,4%)
- Baden-Württemberg: 1.538.109 (14,3%)
- Niedersachsen: 959.406 (8,9%)
- Hessen: 843.048 (7,8%)

---

## 3. Variablenstruktur

### Namenskonvention

Variablennamen folgen dem Schema: `[Statistik]_[Typ][Sachbereich][Kennzahl]`

| Präfix | Statistik |
|--------|-----------|
| `g_` | Gewerbesteuer |
| `k_` | Körperschaftsteuer |
| `u_` | Umsatzsteuer-Voranmeldung |
| `p_` | Personengesellschaften |
| `v_` | Umsatzsteuer-Veranlagung |
| `e_` | Einnahmenüberschussrechnung |
| `urs_` | Unternehmensregister |

**Beispiel**: `e_c51106`
- `e` - Einnahmenüberschussrechnung
- `c` - Kennzahl (nicht plausibilisiert)
- `51` - Sachbereich "Anlage SE - Sonderbetriebseinnahmen"
- `106` - Kennzahl "Private Kfz-Nutzung"

### Panel-spezifische Variablen

| Variable | Format | Beschreibung |
|----------|--------|--------------|
| `id` | Num | Zeitkonsistenter, zufälliger Identifikator |
| `jahr` | Num(4) | Berichtsjahr (JJJJ) |
| `verk` | Char(7) | Verknüpfungsvariable (z.B. "gkupvre" = alle, "g_u____" = nur GewSt+USt-VA) |
| `verk_qual` | Num(1) | Verknüpfungsqualität (1=beste, 3=manuell/Cluster) |
| `ags` | Char(62) | Amtliche Gemeindeschlüssel aller Statistiken |

### Unternehmensregister-Merkmale

| Variable | Beschreibung |
|----------|--------------|
| `urs_we_umsatz` | Umsatz in 1.000 EUR |
| `urs_we_umsatz_quelle` | Quelle (1=Erhebung, 4=Finanzverwaltung, etc.) |
| `urs_we_tp_stichtag` | Tätige Personen (geschätzt) zum 31.12. |
| `urs_we_svb_stichtag` | Sozialversicherungspflichtig Beschäftigte |
| `urs_rt_gruppen_kennz` | Unternehmensgruppen-Status (ausländisch kontrolliert: 3 oder 6) |

---

## 4. Nutzungshinweise für Forscher

### Typische Verknüpfungskombinationen

| Anforderung | Statistiken benötigt | Fallzahl 2013-2019 |
|-------------|---------------------|-------------------|
| Gewerbe- & Körperschaftsteuer | g + k | 8.435.399 |
| Gewerbesteuer & USt-Veranlagung | g + v | 22.091.952 |
| Körperschaftsteuer & USt-Veranlagung | k + v | 21.747.863 |
| Alle Ertragssteuern + USt | g + k + u | 6.332.178 |
| Personengesellschaften & USt | p + v | 4.455.929 |
| Vollständige Verknüpfung (6+ Statistiken) | gkupvre | 1.933.709 |

### Beachten bei der Fallauswahl

**Nicht alle Einheiten in allen Statistiken:**
- **Rechtsform**: Kapitalgesellschaften bilanzieren (keine EÜR erlaubt)
- **Erfassungsgrenzen**: USt-Voranmeldung ab 17.500 EUR Umsatz (2007-2019)
- **Organschaften**: Werden als ein Steuerpflichtiger veranlagt

### Befüllungsgrad prüfen

Aus den Datensatzbeschreibungen entnehmen:
- `0` = nicht belegt
- `1` = weniger als 1% belegt
- `5` = weniger als 5% belegt
- leer = mehr als 5% belegt

### Methodische Änderungen über die Zeit

**Gewerbesteuer - Sachbereichsumbenennungen:**
- 2014: Sachbereich 75/76 → 65
- 2019: Sachbereich 22 → 20

**Körperschaftsteuer:**
- Buchstaben k/c/t ändern sich; nur "k"-Variablen sind plausibilisiert

---

## 5. Datenzugang

### Zugangswege

| Zugangsweg | Beschreibung | Kosten |
|------------|--------------|--------|
| **KDFV** (Kontrollierte Datenfernverarbeitung) | Erster GWAP kostenlos | Keine (1. GWAP) |
| **GWAP** (Gastwissenschaftlerarbeitsplatz) | On-Site, ggf. Stichprobe erforderlich | Kostenpflichtig |

### Wichtige Einschränkungen

- **Bayern**: Amtlicher Gemeindeschlüssel am GWAP nur pseudonymisiert
- **Steuernummer**: Nur für Anspielung öffentlich zugänglicher Informationen nutzbar (durch FDZ-Personal)
- **Speicherplatz**: Am GWAP kann Stichprobennutzung erforderlich sein

### Geheimhaltung

- Alle Ergebnisse unterliegen der Geheimhaltungsprüfung (§16 BStatG)
- Primäre und sekundäre Geheimhaltung wird angewendet
- Tipp: Variablenausprägungen zusammenfassen für größere Fallzahlen

---

## 6. Performance-Optimierung

Aufgrund der Datenmenge (>66 Mio. Beobachtungen, >2.700 Variablen):

1. **Statistiken eingrenzen**: Nur benötigte Statistiken auswählen
2. **Variablen eingrenzen**: Nur benötigte Kennzahlen laden
3. **Jahre eingrenzen**: Nur relevante Berichtsjahre nutzen
4. **Regionen eingrenzen**: Falls nicht bundesweit benötigt

**Empfehlung**: Vor der Analyse die Datensatzbeschreibungen prüfen und Befüllungsgrad der relevanten Variablen evaluieren.

---

## 7. Rechtsgrundlagen

- Bundesstatistikgesetz (BStatG)
- Gesetz über Steuerstatistiken (StStatG)
- Gewerbesteuergesetz (GewStG)
- Körperschaftsteuergesetz (KStG)
- Umsatzsteuergesetz (UStG)
- Einkommensteuergesetz (EStG)
- Abgabenordnung (AO)
- Statistikregistergesetz (StatRegG)
- Verwaltungsdatenverwendungsgesetz (VwDVG)

---

## 8. Literatur und Ressourcen

### Methodische Grundlagen

- **Kristiansen, Annette (2023)**: Business-Tax-Panel – Zusammenführung von Unternehmenssteuerstatistiken. WISTA Wirtschaft und Statistik, Ausgabe 3/2023, S. 47 ff.
- **Buchner et al. (2023)**: Combined Business Tax Statistics 2016 of the Federal Statistical Office of Germany – A Micro Data Set for Scientific Use. Jahrbücher für Nationalökonomie und Statistik, Jg. 243, Ausgabe 1/2023, S. 109 ff.

### FDZ-Dokumentation

- **Metadatenreport Teil I**: Allgemeine und methodische Informationen zum Business-Tax-Panel, Version 1, Mai 2024
- **Metadatenreport Teil II**: Produktspezifische Informationen zum Business-Tax-Panel 2013-2019, Version 1, Mai 2024
- **Nutzungskonzept**: Business-Tax-Panel 2013-2019, Version 2

### Weiterführende Links

- FDZ-Portal: https://www.forschungsdatenzentrum.de/de/steuern/btp
- Gewerbesteuer: https://www.forschungsdatenzentrum.de/de/steuern/gewerbesteuer
- Körperschaftsteuer: https://www.forschungsdatenzentrum.de/de/steuern/koeperschaftsteuer
- Umsatzsteuer: https://www.forschungsdatenzentrum.de/de/steuern/umsatzsteuer
- GKUPV-Querschnitte: https://www.forschungsdatenzentrum.de/de/steuern/gkupv
- Qualitätsberichte: https://www.destatis.de/DE/Methoden/Qualitaet/Qualitaetsberichte/Steuern/einfuehrung.html
- Geheimhaltungsregeln: https://www.forschungsdatenzentrum.de/sites/default/files/fdz_broschuere_regelungen.pdf
- WZ-Klassifikation: https://www.klassifikationsserver.de/klassService/index.jsp?variant=wz2008

---

## 9. Kontakt

**Statistisches Bundesamt - Forschungsdatenzentrum**  
Gustav-Stresemann-Ring 11, 65189 Wiesbaden  
Tel.: 0611 75-2420 | Fax: 0611 75-3915  
E-Mail: forschungsdatenzentrum@destatis.de

**FDZ der Statistischen Ämter der Länder - Geschäftsstelle**  
Tel.: 0211 9449-2873 | Fax: 0211 9449-8087  
E-Mail: forschungsdatenzentrum@it.nrw.de

---

## Zitierempfehlung

```
Forschungsdatenzentren der Statistischen Ämter des Bundes und der Länder (2024): 
Business-Tax-Panel 2013-2019. DOI: 10.21242/73511.2019.00.05.1.1.0 (KDFV) / 
10.21242/73511.2019.00.05.2.1.0 (GWAP).
```

---

**Quelldokumente:**
- [btp_mdr-stat.pdf](../../raw/pdf/btp_mdr-stat.pdf) - Metadatenreport Teil I (27 Seiten)
- [btp_2013-2019_on-site_mdr-prod.pdf](../../raw/pdf/btp_2013-2019_on-site_mdr-prod.pdf) - Metadatenreport Teil II (44 Seiten)
- [btp_2013-2019_nk_v2.pdf](../../raw/pdf/btp_2013-2019_nk_v2.pdf) - Nutzungskonzept (3 Seiten)

**Stand:** November 2024 | **Dokumentversion:** 1.0
