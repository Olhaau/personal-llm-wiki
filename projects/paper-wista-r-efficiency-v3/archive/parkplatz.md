<!-- 

-   Performanz und Nutzererfahrung auf dem aktuellen Stand der Technik
-   leicht einzurichten auch in den abgeschotteten System der amtl. Statistik (tlw. langwierig und schwierig), d.h. wenig Abhängigkeiten und unabhängig von Internet bzw. Cloud betreibbar.
-   langfristig stabil und gut unterstützt
-   leicht nutzbar, gut dokumentiert, gutes Schulungsangebot

Die Analyse großer Datensätze wie des in der FDZ-Umgebung stellt besondere Anforderungen an die verwendeten Werkzeuge. Traditionelle Ansätze (CSV-Dateien, Base R) stoßen bei dieser Datengröße an ihre Grenzen. Moderne spaltenorientierte Technologien lösen dieses Problem indem sie erlauben, nur relevante Variablen bei Bedarf zu einzulesen.

 -->


<!--
BBK

Verfügbare Ressourcen
-   default: 4 CPU cores, 8 threads, 16 gb ram
-   10 Virtual Clients: 8 Cores / 16 threads, bis 128 GB RAM, faster network connection

-   data wrangling recommondations:
    -   stata {gtools} package
    -   r {data.table}, designed for large data \~100GB in RAM (really??)
    -   As you can see, {data.table} does a terrific job and is 90.1% faster than the optimised Stata solution using {gtools} which is already 76.2% faster than the base Stata solution.
-   Type Conversion important (4.2)
-   recommend: start small (5.1)
-->

-->
<!-- 
Wie in A beschrieben war es uns aus organisatorischen Gründen nicht möglich, die neuste Version aller Pakete zu verwenden. Die leichter nutzbaren Variationen {duckplyr} bzw. {tidytable} zu nutzen. Die Package wurden aber wenige Tage nach dem Experiment eingerichtet. Die Syntaxtranslation kann dabei die Performanz verschlechtern, sodass bei {duckdb} bzw. {data.table} zwischen Performanz und Code-Verständlichkeit abgewägt werden muss. {arrow} ist schon länger als {polars} im Statistischen Bundesamt verfügbar, sodass wir darin bereits mehr Erfahrungen einsetzen konnten.

### Einordnung

-   https://www.r-bloggers.com/2024/09/why-im-switching-to-polars/
-   https://www.r-bloggers.com/2024/10/comparing-data-table-reshape-to-duckdb-and-polars/

#### Generelle Auswahl

-   R Syntax ausreichend: Data.table oder Tidy -\> leicht zu lernen, anzuwenden. Wenig mental load auf die Umsetzung, Fokus auf die eigentliche Aufgabe.
-   Keine gesonderte Hardware/Software nötig, keine GPUs oder Spark
-   Abgrenzung zu Datenbanken

-\> Aufhänger für unsere Benchmark

Therefore, you need to decide for yourself which tool makes most sense for your research project dealing with large data. If you are a proficient R user, possibly familiar with {data.table}, you should definitely prefer R to Stata. Otherwise, there is no simple answer. You should carefully weigh the benefits and the learning curve of programming in a new language.


-   vollständinges Einladen in Arbeitsspeicher und verarbeitung von dort.
-   Für große Datensätze, wie das BTP, kann ein Teil dieser Tools nicht mehr genutzt werden. Die Effizienteren Varianten, haben Strategien implementert (selection, ...), aber benötigen mehr Erfahrung und regelmäßige und größere manuelle Anpassungen an den jeweiligen Anwendungsfall (Selection)

#### Weitere Auswahlkriteren neben Performanz

-   Differenzierte Auswahl der Technologie
-   zu optimieren ist die Gesamtzeit (Entwicklung und Rechenzeit)
-   Wenn erst Kenntnisse und Erfahrungen aufgebaut werden müssen, kann das gegen die effizienteste Methode sprechen.
-   Style (Tidy, Base, Python, SQL) zu vorhandenen Kenntnissen. Bei den untenstehenden Beschreibungen zu beachten.
-   Nicht alle abstufungen sind relevant (1 oder 4 sec, 10 oder 20 sec, 10 oder 20 min), andere Faktoren zu berücksichtigen.
-   im StBA mehr Erfahrungen mit DT, Tidyverse, als bspw. mit Polars

**Benötigte Erfahrungen / Fallstricke**

-   Selection kann an verschiedenen Stellen und auf verschiedene Weisen erfolgen. Bringt aber bzgl. Performanz nur etwas, wenn die Selection-Optionen direkt der Einlese Funktionen verwendet wird. Ansonsten erwarten einen vermeidbare Wartezeiten und im Schlimmsten Fall Abbrüche durch RAM Overflow. Selection ist dadurch immer Anwendungsfall spezfisch. Wenn sich die Auswertung ändert, muss der ganze Code neu ausgeführt werden und Daten neu geladen.
-   Typumwandlungen. Oft sehen wir, dass sich aus allen Paketen das beste zusammengesucht wird. Lässt sich in R auch leicht umsetzen, ohne dass der Nutzende es dann merkt, führt R Typumwanldungen zwischen Datenformaten im RAM um (die bzgl. Rechenzeit teuer sind). I.d.R muss man mit klassischen Methoden sich für eine Technologie entscheiden und diese durchziehen bis zu einem Punkt, wo die Datenmenge ausreichend reduziert ist
-   Tracking von Arbeitsspeicher, Systemressourcen nötig

**High-Performance R-Pakete und Dateiformate können sich darum im Hintergrund kümmern, ohne die User Experience zu beeinflussen.**

Hinweis: R-spezfische binäre Datenformate sind eine zsl. Möglichkeit. Daten nicht portabel, außerhalb R leicht nutzbar o.Ä. Können aber ebenfalls tricky sein (nicht alle Features aus dpylr vorhanden, variablentypen, tlw. tieferes Verständnis zu Parallelisierung o.Ä. nötig)

**Organisatorische Aspekte.**

-   Einrichtbarkeit in StBA tlw. träge...

#### Stellenwert der eigenen Benchmark

O.g. Technologien stellen oft eigene Benchmarks (Performanz-Vergleiche) bereit und präsentieren i.d.R. die Vorteile der eigenen Technologie. Im Vergleich findet jede Technologie einen Spezielfall, wo sie am besten ist, auf die sie optimiert ist. Die Benchmarks geben tlw. Indikationen, ob die Technologie für den Anwendungsfall geeignet ist. Eigene Tests notwendig, ob die Performance für eigenen Anwendungsfall genügt.

-\> folgende Benchmark entwickelt

EIGENE BENCHMARK NÖTIG: Schnellste Technologie/Methodik nicht eindeutig, abhängig von der Datenmenge. Daher für die zu verarbeitenden Daten und den Anwendungsfall-spezifisch. Kann variieren. Eigene Benchmark nötig oder ausgeglichene Methodik nehmen (unter wenigen Unterschiede egal) Externe Benchmarks kommen zu anderen Ergebnissen

https://prof-thiagooliveira.netlify.app/post/data-read-write-performance/

https://blog.hwr-berlin.de/codeandstats/aggregating-data-in-r-benchmarks/

https://iyarlin.github.io/2020/05/26/dtplyr_benchmarks/

### Klassische Methoden

Brauchen übermäßig viel RAM. Üblich ist CSV als Dateiformat und die hier beschriebenen klassichen Datenmethoden benötigen für die gleichen Daten ca. das 3-4-fache im Arbeitsspeicher (interne Kopien usw.). Designed für kleine bis moderate Datenmengen (relativ zum Arbeitspeicher und Rechenressourcen, insb. CPU/GPU).

#### Base-R / data.table

-   R eingebaute Auswertungsmethoden, funktioneren, aber weder sonderlich effizient, intuitiv
-   Grundlagen in Base-R können leicht in `data.table` adaptiert werden und dies ist unter den effizientesten Paketen, mit dem Daten durch das o.g. klassischen Vorgehen in R verarbeitet werden können.
-   benötigen dafür aber übermäßig viel RAM 3-4x Speicher ggü. den Eingangsdaten, sodass dies für große Datenmengen oft ungeeignet ist. Sodass dies für große Datenmengen nur eine Option ist, mit sehr viel Programmiergeschick

-\> Je weniger effizient die genutzte Technologie ist, umso genauer muss der/die Anwender/-in programmieren (bspw. RAM-Abbrüche manuellabfangen)

#### Tidyverse, readr, vroom

-   Ökosystem aus R-Packages (dplyr, readr)
-   Fokus auf User Experience (einfache an menschliche Sprache orientierte Syntax). readr klassisch, vroom schneller Variante hierbei. readr ist dtl. langsamer als data.table und vroom ist vergleichbar zu data.table (Fußnote: für charactervariablen besser, für num. variablen schlechter) lt. einer Benchmark vgl. https://cran.r-project.org/web/packages/vroom/vignettes/benchmarks.html
-   ebenso hoher RAM-Bedarf wie Base-R / data.table.

Exemplarische deskreptive Auswertung (Fallzahl pro Statistik und Jahr):

```{=latex}
\onecolumn
```

|  |  |  |
|--------------------------------|--------------------|--------------------|
| **Befehl** \| **Ergebnis** \| ==================================================================+=========================================+ `read_csv("pfad/zu/datensatz.csv") |>` \| Daten als R-Objekt verfügbar \| |  |  |
| `mutate(u,v,... = generate_statistik(verk, stat = "u"), ....) \|\>` \| Ergänze die Daten um Statistikvariablen \| |  |  |
| `group_by(jahr)` | groupiere nach Jahr |  |
| `count(u, ... g)` oder `summarize()` \| Zähle Statistik |  |  |

```{=latex}
\twocolumn
```

summarize(n = sum(g = str_detect(verk, "g")), k = str_detect(verk, "k"), ...) -\> Aggregiere auf eine beobachtung pro Gruppe und zähle dort alle Beobachtungen, die das Zeichen "g" bzw. "k" in `verk` haben (Fallzahl Gewerbesteuer bzwp Körperschaftssteuer) usw.

**Auswertungsbefehle in Tidyverse**

Syntax echtes Herausstellungsmerkmal, sodass zsl. Pakete die Syntax für alle hier genannten Auswertungsmethoden adaptieren. Bspw. lässt sich data.table mit dtplyr in der o.g. Syntax verwenden (jedoch mit Performanzverlusten, s. bspw. https://www.r-bloggers.com/2024/04/the-truth-about-tidy-wrappers-3/ )

Besser tidytables (noch nicht verfügbar im StBA):

-   https://markfairbanks.github.io/tidytable/articles/speed_comparisons.html
-   https://markfairbanks.github.io/tidytable/

### Hoch-Perfomante Methoden in R

genügsame Definition von high-perf = dazu fähig Daten außerhalb des RAMs und sehr RAM sparsam zu verabeiten -\> nutzen RAM sehr effizient, idealerweise schnell.

#### Generelle best pratices (ermöglicht o.g. Tools ähnliches)

Alle supporten die nachfolgenden Features. Exemplarische Best-Practices, um das nötige Programmiergeschick zu beschreiben.

Zwei sehr leicht anwendbare Best Practices

-   Chunking
-   Selection (in Einlesefunktion), später rauswerfen, erzeugt dennoch übermäßig Rechenzeit und RAM Problem. Beispiel s. opencode repo

#### Parquet

-   spaltenbasiert, leicht & schnell nutzbar für Auswertungen
-   komprimiert, wenig Festplattenspeicher
-   heranwachsender Standard Softwareübergreifend
-   Alternative diskutieren qs, rds ...

https://posit.co/blog/shiny-and-arrow/

https://posit.co/blog/speed-up-data-analytics-with-parquet-files/

**Parquet: Persistentes spaltenorientiertes Format.**

Parquet ist ein spaltenorientiertes Speicherformat, das optimal mit Arrow zusammenarbeitet:

-   **Kompression:** Typischerweise 5-10x kleinere Dateien als CSV
-   **Metadaten:** Enthält Schema-Informationen und Statistiken
-   **Partitionierung:** Ermöglicht selektives Lesen nach Partitionskeys
-   **Kompatibilität:** Von vielen Tools unterstützt (R, Python, Spark, DuckDB)

**Vergleich zu Alternativen.**

```{=latex}
\begin{table*}[t]
\caption{Vergleich verschiedener Datenformate für die BTP-Analyse}\label{tbl-format-comparison}
\centering
\small
\begin{tabular}{llllll}
\hline
\textbf{Format} & \textbf{Größe} & \textbf{Ladezeit} & \textbf{Kompression} & \textbf{Partitionierung} & \textbf{Kompatibilität} \\
\hline
CSV & 100\% & Sehr langsam & Keine & Nein & Universal \\
RDS (R) & 45\% & Mittel & Gzip & Nein & Nur R \\
Feather & 95\% & Sehr schnell & LZ4/ZSTD & Nein & Arrow-Ökosystem \\
Parquet & 15\% & Schnell & Snappy/GZIP & Möglich & Sehr hoch \\
Parquet (partitioniert) & 15\% & Sehr schnell (selektiv) & Snappy/GZIP & Ja & Sehr hoch \\
\hline
\end{tabular}
\end{table*}
```

**Empfehlung für FDZ.**

**Parquet ist das empfohlene Format für große Datensätze im FDZ** wegen:

1.  Drastischer Reduktion der Dateigröße (wichtig bei begrenztem Speicherplatz)
2.  Deutlich schnelleren Ladezeiten
3.  Möglichkeit der selektiven Filterung ohne vollständiges Laden
4.  Kompatibilität mit verschiedenen Analysewerkzeugen

#### Arrow

-   nutzt dplyr interface nativ, adaptiert die bekannte und einfache tidyverse-Syntax, nur effizienter

Aktuell in V. 22.0.0. Major Releases:

-   2025: 19-22, d.h. 4 Major Releases

-   2024: 15-18: 4

-   2023: 12-14: 3

-   spezfische Features noch nicht vorhanden. Daher nächster...

https://posit.co/blog/arrow-and-beyond/

**Apache Arrow: Spaltenorientiertes In-Memory-Format.**

Apache Arrow ist ein sprach- und plattformübergreifendes In-Memory-Format für spaltenorientierte Datenverarbeitung. Im Gegensatz zu zeilenorientierten Formaten werden Daten spaltenweise organisiert, was erhebliche Vorteile bietet:

-   **Effiziente Kompression:** Ähnliche Werte in einer Spalte lassen sich besser komprimieren
-   **Schnellere Aggregationen:** Nur benötigte Spalten müssen gelesen werden (Columnar Scanning)
-   **Zero-Copy:** Daten können ohne Kopieren zwischen Prozessen und Sprachen ausgetauscht werden
-   **SIMD-Optimierung:** Moderne CPU-Instruktionen können effizient genutzt werden

**Anwendung in R.**

Das `arrow`-Paket in R bietet vollständige Integration in R.

**Vorteile für FDZ-Analysen.**

-   **Out-of-Core Processing:** Datensätze müssen nicht vollständig in den RAM passen
-   **Lazy Evaluation:** Operationen werden optimiert, bevor sie ausgeführt werden
-   **Predicate Pushdown:** Filter werden direkt beim Lesen angewendet
-   **Partitionierung:** Datensätze können nach Kriterien (z.B. Jahr) partitioniert werden

**Limitationen.**

-   **Lernkurve:** Neue Syntax für Nutzer mit Base-R-Erfahrung
-   **Noch in Entwicklung:** Nicht alle R-Funktionen werden unterstützt
-   **Setup-Aufwand:** Daten müssen einmalig ins Parquet-Format konvertiert werden

#### DuckDB

Andere Technologie (in-mem Database), kann mit SQL Syntax genutzt werden, aber auch mit tidyverse

Vorteil von DuckDB/Polars: https://www.r-bloggers.com/2025/03/converting-arbitrarily-large-csvs-to-parquet-with-r/

Ergänzung: Tidypolars https://duckplyr.tidyverse.org/ war zur Berechnung der Benchmark im StBA nicht verfügbar, obwohl hohe Performanzgewinne denkbar, s. o.g. Quelle.

**DuckDB: Analytical Database System.**

DuckDB ist ein einbettbares analytisches Datenbanksystem, speziell für OLAP-Workloads (Online Analytical Processing) entwickelt:

-   **In-Process:** Läuft im gleichen Prozess wie R (keine separate Datenbank-Server-Installation nötig)
-   **Columnar Vectorized:** Spaltenorientierte Verarbeitung in SIMD-optimierten Batches
-   **SQL-Interface:** Bekannte SQL-Syntax für komplexe Abfragen
-   **Arrow-Integration:** Zero-Copy-Integration mit Arrow-Daten

**Warum DuckDB?**

DuckDB löst spezifische Probleme bei der Analyse großer Datensätze:

1.  **Komplexe Aggregationen:** Window Functions, CTEs, komplexe Joins
2.  **SQL-Komfort:** Mächtige Abfragesprache statt R-Code für Datentransformationen
3.  **Out-of-Core:** Kann größere Daten als RAM verarbeiten
4.  **Geschwindigkeit:** Hochoptimierte Query Engine

**Anwendungsbeispiel.**

``` r
library(duckdb)
library(arrow)

## Verbindung erstellen
con <- dbConnect(duckdb::duckdb())

## Arrow-Dataset registrieren (ohne Laden)
duckdb_register_arrow(con, "btp", arrow_dataset)

## Komplexe SQL-Abfrage
result <- dbGetQuery(con, "
  SELECT 
    year,
    sector,
    COUNT(*) as n_companies,
    MEDIAN(revenue) as median_revenue,
    PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY revenue) as p90_revenue,
    LAG(MEDIAN(revenue)) OVER (
      PARTITION BY sector 
      ORDER BY year
    ) as prev_year_median
  FROM btp
  WHERE year BETWEEN 2015 AND 2019
    AND revenue > 0
  GROUP BY year, sector
  ORDER BY year, sector
")

dbDisconnect(con, shutdown = TRUE)
```

**Vorteile.**

-   **Kein Setup:** Keine separate Datenbank-Installation erforderlich
-   **Hohe Performance:** Oft schneller als spezialisierte Data-Frame-Bibliotheken
-   **SQL-Funktionen:** Umfangreiche Funktionen (Window Functions, Array-Operationen)
-   **Ressourceneffizient:** Intelligentes Memory Management
-   **R-Integration:** Direktes Arbeiten mit Arrow-Datasets oder R-Data-Frames

**Limitationen.**

-   **SQL-Kenntnisse:** Erfordert SQL-Grundkenntnisse
-   **Debugging:** SQL-Fehler können schwerer zu debuggen sein als R-Code
-   **Noch jung:** Weniger etabliert als traditionelle Datenbanken (aber sehr aktiv entwickelt)

#### Polars

-   Neuer

-   Syntax an Python orientiert, `tidypolars` erlaubt nutzung

-   Syntax nicht so nativ zu den anderen Paketen, daher `tidypolars` genutzt, jedoch Performanceverluste zu erwarten (s. https://www.r-bloggers.com/2024/04/the-truth-about-tidy-wrappers-3/)

-->
