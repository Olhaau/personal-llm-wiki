# Benchmark-Setup: Effizienzanalyse statistischer Verfahren in R

## Überblick des Benchmarks

Das Benchmark wurde zur systematischen Evaluierung der Performance verschiedener R-Packages für die Datenverarbeitung in der amtlichen Statistik durchgeführt. Fokus lag auf den Anwendungsfällen "Fallzahl (Statistik und Jahr)" und "Logistische Regression (Einflussfaktoren auf positive Verlustvorträge)".

## Software-Umgebung und Package-Versionen

Die Benchmarks wurden auf den FDZ OnSite-Servern mit folgenden Software-Versionen durchgeführt:

| Package/Software | Version | Release-Datum | Nächste Version | Release-Datum nächste | Bemerkung |
|------------------|---------|---------------|----------------|----------------------|-----------|
| **R** | 4.5.0 | April 2025 | - | - | Basis-Umgebung |
| **data.table** | 1.17.8 | 6. Juli 2025 | - | - | Hochperformante Datenverarbeitung (aktuelle Version) |
| **Arrow** | 20.0.0.2 | Nov. 2024 | 21.0.0 | Dez. 2024 | Spaltenorientierte Datenformate |
| **Tidyverse** | - | - | - | - | Meta-Package für dplyr, tidyr, etc. |
| **DuckDB** | 1.3.2 | Nov. 2024 | 1.4.0 | Dez. 2024 | Analytische In-Memory-Datenbank |
| **Polars** | 1.0.1 | Aug. 2024 | 1.1.0+ | Sep. 2024+ | Rust-basierte DataFrame-Library |

### Versions-Auswahlstrategie

*Hinweis: Aus organisatorischen Gründen wurden nicht immer die neuesten Versionen verwendet*

Die Version-Auswahl reflektiert die Verfügbarkeit zum Zeitpunkt der Benchmark-Durchführung:

- **data.table 1.17.8**: Aktuelle Version zum Zeitpunkt der Tests (Juli 2025)
- **Arrow 20.0.0.2**: Stabile Version, nachfolgende 21.0.0 erschien kurz nach den Tests (Dez. 2024)
- **DuckDB 1.3.2**: Etablierte Version, 1.4.0 wurde später im Dezember 2024 veröffentlicht  
- **Polars 1.0.1**: Kurz nach dem 1.0-Meilenstein, weitere Updates folgten häufig ab September 2024

Diese Auswahl gewährleistet eine Balance zwischen Stabilität und aktuellen Features für reproduzierbare Benchmarks.

## Benchmark-Konfiguration

### Datengrundlage
- **Umfang**: Synthetische BTP-Daten (Business Tax Panel)
- **Größe**: Etwa 1 Million Einheiten, ca. 7 Millionen Zeilen
- **Anteil**: Entspricht etwa 10% des vollständigen BTP-Datensatzes
- **Datengenerierung**: R-Funktion zur Erstellung eines Dummy-BTP beliebiger Größe
- **Zweck**: Rein technische Performance-Tests (nicht für inhaltliche Auswertungen geeignet)

### Variablen und Datenmodellierung
- Genutzte Variablen wurden realitätsnah modelliert
- Restliche Variablen wurden zufällig generiert
- FDZ stellt verschiedene Datenstruktur-Files zur Verfügung, abgeleitet aus echten Mikrodaten

### Messmethodik
- **Measurement-Framework**: `bench`-Package für exakte Performance-Messungen
- **Wiederholungen**: 3-fache Ausführung jeder Messung
- **Bereinigung**: Zwischen den Messungen zur Vermeidung von Cache-Effekten
- **Parallelität**: Berücksichtigung der Multithreading-Fähigkeiten der verschiedenen Packages

### Anwendungsfälle

#### 1. Fallzahl-Analyse (Statistik und Jahr)
- Aggregation von Beobachtungseinheiten nach statistischen Kategorien und Jahren
- Performance-Vergleich verschiedener Grouping- und Summarizing-Operationen
- Bewertung der Memory-Effizienz bei großen Gruppierungen

#### 2. Logistische Regression
- Modellierung von Einflussfaktoren auf positive Verlustvorträge
- Vergleich der Data-Preparation-Performance
- Evaluierung der Integration mit statistischen Modellierungsframeworks

### Erweiterte Tests
- Zusätzliche kleinere Benchmarks mit weiteren Package-Varianten und Implementierungsansätzen
- Evaluierung verschiedener Datenformate (CSV, Parquet, Feather)
- Memory-Usage-Analysen
- Skalierbarkeits-Tests mit verschiedenen Datengrößen

## Reproduzierbarkeit

### Quellcode-Verfügbarkeit
- Vollständige Veröffentlichung auf OpenCode geplant
- Benchmark-Ergebnisse werden transparent dokumentiert
- Alle verwendeten R-Skripte und Konfigurationen werden bereitgestellt

### Ausführungsumgebung
- FDZ OnSite-Server mit definierten Hardware-Spezifikationen
- Kontrollierte Umgebung zur Minimierung externer Performance-Einflüsse
- Dokumentation der System-Konfiguration für Reproduzierbarkeit

## Package-spezifische Überlegungen

### data.table (1.17.8)
- Neueste Version mit verbesserter Memory-Allokation
- Optimierungen für große Datensätze
- Native Multithreading-Unterstützung

### Arrow (20.0.0.2)
- Spaltenorientierte Speicherung für analytische Workloads
- Efficient Memory-Mapping
- Integration mit anderen Arrow-Implementierungen (Python, C++)

### DuckDB (1.3.2)
- In-Memory OLAP-Datenbank
- SQL-Interface für komplexe Abfragen
- Optimiert für analytische Operationen

### Polars (1.0.1)
- Rust-basierte Performance
- Lazy Evaluation für Query-Optimierung
- Moderne DataFrame-API

## Bewertungskriterien

1. **Execution Time**: Absolute Ausführungszeiten für definierte Operationen
2. **Memory Efficiency**: Peak Memory Usage und Garbage Collection
3. **Scalability**: Performance-Verhalten bei verschiedenen Datengrößen
4. **Ease of Use**: API-Komplexität und Lernkurve
5. **Integration**: Kompatibilität mit bestehenden R-Workflows
6. **Robustheit**: Fehlerbehandlung und Edge-Case-Verhalten

Diese Benchmark-Konfiguration ermöglicht eine umfassende und faire Bewertung der verschiedenen R-Packages für typische Anwendungsfälle in der amtlichen Statistik.