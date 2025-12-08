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


<!--
Zielgruppe: alle Datenanalytiker mit rudimentären R-Kenntnisse, aber breit, FDZ, amtl. Stat,

1.  **Methodische Effizienz:** Wie unterscheiden sich verschiedene statistische Verfahren hinsichtlich ihrer Rechenzeit und Speicheranforderungen bei gleichbleibender Ergebnisqualität?

2.  **Skalierbarkeit:** Welche Verfahren zeigen die beste Performance bei wachsenden Datenmengen, und wo liegen die kritischen Grenzen?

3.  **Praktische Anwendbarkeit:** Welche Infrastrukturanforderungen stellen moderne Auswertungsmethoden an Forschungsdatenzentren?

- durch die größeren Datenmengen, fühlt sich die Verarbeitung (wie in tidyverse) immer langsamer an. In den letzten Jahren haben sich mehrere Pakete entwickelt, die besser für große Datenmengen geeignet sind. https://www.r-bloggers.com/2024/04/the-truth-about-tidy-wrappers-3/
-->

<!-- #### Bedarfe der Wissenschaft und neue Analyseserver -->



<!-- #### BTP repräsentiert steigende Bedarfe an steigende Datenmenge  -->



<!-- 

Annette

- Öffentlichkeit erwartet sofortige Antworten auf immer komplexere Fragen
-   Schnelle Bereitstellung von am besten vollständigen, wenig Anonymisierten Datensätzen an Wissenschaft via FDZ, die zeitnah genutzt werden können. Erste Analysen seitens StBA und hohe Expertise erwartet (Exploration der Daten nötig)
- Komplexere Analysen
-   Bereitstellung von Zusatzdokumentation durch StBA. Metadatenreport.

- 

- Seit Januar 2025 besteht ein Remote Access System als neuer Zugangsweg für die Wissenschaft. Im Bereich der Steuerstatistiken wird derzeit geprüft, inwiefern auch Einzeldaten aus diesem Bereich über Remote Access genutzt werden können.
-->




<!-- #### R bietet eher zu viel, geeignete Auswahl nötig -->



<!-- Arrow bspw. hatte in 2024 und 2025 jeweils 4 Major Releases mit diversen neuen Funktionalitäten und Performanz-Verbesserung 

Als Desktopanwendung konzipiert ist R nicht für hoch-performante Auswertungen von Big Data bekannt. Wie unsere Untersuchung zeigen wird, beansprucht R nativ übermäßige Systemressourcen, um die Nutzerfreundlichkeit zu erhöhen. Dadurch dass R Open Source ist ändern dies jedoch diverse Entwicklerteams weltweit und stellen R Zusatzfunktionen in Form von R-Paketen zur Verfügung die in R hoch-performante Auswertung großer Datenmengen ermöglichen.


Ausbreitung von R - gleich die richtige Technologie auswählen und einsetzen. Aber welche ist die "richtige"? Was für Unterschiede (Vorteile / Nachteile) haben die Technologien. Dies will dieser Artikel im Falle des BTP untersuchen. Kontrollierte Benchmark und weitere (qualitative) Aspekte, wie Userexperience.
-->
<!--
ggf.: Technischen Erleichterungen der Nutzerverwaltung durch die FDZ, reduziert Betreuungsaufwände und damit Wartezeiten der Nutzenden in der KDFV oder an den GWAPs.
-->

<!--

### KI Anhang

#### Die Forschungsdatenzentren der amtlichen Statistik

Die Forschungsdatenzentren (FDZ) der amtlichen Statistik bestehen aus zwei organisatorisch voneinander getrennten Einrichtungen: dem **Forschungsdatenzentrum des Statistischen Bundesamts** und dem **Forschungsdatenzentrum der Statistischen Ämter der Länder**. Beide FDZ arbeiten eng zusammen und bieten ein abgestimmtes Daten- und Dienstleistungsangebot für die wissenschaftliche Nutzung von Mikrodaten der amtlichen Statistiken.

**Entstehung und Entwicklung.**

Die Gründung der FDZ geht auf ein Gutachten der „Kommission zur Verbesserung der informationellen Infrastruktur zwischen Wissenschaft und Statistik" (KVI) von 1999 zurück. Mit finanzieller Förderung des Bundesministeriums für Bildung und Forschung (BMBF) wurde im Herbst 2001 zunächst das FDZ des Statistischen Bundesamts gegründet. Das FDZ der Statistischen Ämter der Länder folgte im April 2002.

**Aufgaben und Ziele.**

Die FDZ verfolgen das Ziel, den Zugang zu Mikrodaten der amtlichen Statistik für die Wissenschaft nicht nur zu ermöglichen, sondern fortlaufend zu verbessern und an die sich ändernden Bedarfe anzupassen:

-   **Datenzugang:** Bereitstellung hochwertiger Mikrodaten für die wissenschaftliche Forschung
-   **Datenschutz:** Gewährleistung des Schutzes personenbezogener und unternehmensbezogener Daten nach § 16 BStatG
-   **Beratung:** Unterstützung der Forschenden bei der Datennutzung und methodischen Fragen
-   **Infrastruktur:** Bereitstellung einer sicheren und leistungsfähigen Auswertungsumgebung
-   **Regionalisierung:** Flächendeckende Standorte in ganz Deutschland für kurze Anfahrtswege

#### Technische Infrastruktur

**Software-Umgebung.**

Den Forschenden stehen verschiedene Software-Tools zur Verfügung:

-   **Statistische Software:** R, Python, Stata, SAS, SPSS
-   **Datenbanksysteme:** PostgreSQL, DuckDB
-   **Entwicklungsumgebungen:** RStudio Server, JupyterLab
-   **Versionskontrolle:** Git (lokal, ohne externe Verbindung)

#### Infrastrukturkonzept

**Fachlich zentralisierte Datenhaltung.**

In Deutschland wird der überwiegende Teil der amtlichen Statistikproduktion dezentral in den Statistischen Ämtern der Länder durchgeführt (über 90% aller amtlichen Statistiken). Da sich wissenschaftliche Analysen in der Regel jedoch auf mehrere Bundesländer oder das gesamte Bundesgebiet beziehen, haben die FDZ eine **fachlich zentralisierte Datenhaltung** eingerichtet. Diese ermöglicht es, die Daten des gesamten Bundesgebiets länderübergreifend an jedem Standort bereitzustellen.

**Regionalisierte Infrastruktur.**

Die FDZ verfolgen das Ziel, immer in der Nähe der Wissenschaft zu sein. Dies wird durch über ganz Deutschland verteilte Standorte erreicht. Standorte befinden sich u.a. in:

-   Berlin, Bonn, Wiesbaden (Bund)
-   Bad Ems, Bremen, Dresden, Düsseldorf, Erfurt, Frankfurt, Hamburg, Hannover, Kiel, München, Stuttgart u.v.m. (Länder)

#### Zugangsformen und Nutzungsmodelle

Die FDZ bieten verschiedene Zugangswege an, über die unterschiedlich anonymisierte Datenprodukte bereitgestellt werden:

**Off-Site-Zugang.**

-   **Public Use Files (PUF):** Stark anonymisierte Daten für freie Nutzung
-   **Scientific Use Files (SUF):** Faktisch anonymisierte Daten für wissenschaftliche Zwecke
-   **Remote Scientific Use Files (Remote-SUF):** Neuer Zugangsweg mit höherer Detailtiefe

**On-Site-Zugang.**

-   **Gastwissenschaftsarbeitsplatz (GWAP):** Zugang zu formal anonymisierten Daten vor Ort
    -   Vorteile: Höchste Datendetailtiefe, direkte Beratung
    -   Anforderungen: Terminvereinbarung, Zutrittskontrolle, Output-Kontrolle
-   **Kontrollierte Datenfernverarbeitung (KDFV):** Remote-Ausführung von Analyseskripten
    -   Vorteile: Keine Anreise, zeitlich flexibel
    -   Einschränkungen: Keine interaktive Arbeit, Ergebnisfreigabe erforderlich

#### Datenschutz und Sicherheit

**Mehrstufiges Sicherheitskonzept.**

Das FDZ-Bund implementiert ein umfassendes Sicherheitskonzept:

1.  **Physische Sicherheit:** Zutrittskontrolle, gesicherte Räumlichkeiten
2.  **Netzwerksicherheit:** Isolierte Netzwerke, Firewalls, Intrusion Detection
3.  **Zugriffsrechte:** Rollenbasierte Zugriffskontrolle, Authentifizierung
4.  **Output-Kontrolle:** Prüfung aller Ergebnisse vor Freigabe
5.  **Audit-Logging:** Protokollierung aller Zugriffe und Operationen

**Output-Kontrolle.**

Bevor Forschungsergebnisse das FDZ verlassen dürfen, durchlaufen sie eine mehrstufige Kontrolle:

-   **Automatische Prüfung:** Screening auf kritische Werte (z.B. Fallzahlen \< 5)
-   **Manuelle Prüfung:** Sichtung durch geschulte Mitarbeiter
-   **Dokumentation:** Nachvollziehbare Begründung der Freigabeentscheidung

#### Performanz-Optimierung in der FDZ-Umgebung

**Herausforderungen.**

Die Arbeit in der geschützten FDZ-Umgebung stellt besondere Anforderungen:

-   **Begrenzte Ressourcen:** Mehrere Nutzer teilen sich die verfügbare Hardware
-   **Keine Cloud-Dienste:** Externe Rechenressourcen können nicht genutzt werden
-   **Datengröße:** Große Datensätze müssen effizient verarbeitet werden
-   **Reproduzierbarkeit:** Analysen müssen dokumentiert und nachvollziehbar sein

**Optimierungsstrategien.**

Verschiedene Strategien helfen, die Performanz zu optimieren:

#### Akkreditierung und Qualitätssicherung

Die Forschungsdatenzentren der Statistischen Ämter des Bundes und der Länder sind durch den **Rat für Sozial- und WirtschaftsDaten (RatSWD) akkreditiert**. Der RatSWD akkreditiert seit 2008 Forschungsdatenzentren, die den Zugang zu qualitativ hochwertigen sensiblen Daten für die Wissenschaft ermöglichen und dabei die erforderlichen Kriterien erfüllen.

#### Best Practices für FDZ-Nutzende

Aus der Erfahrung mit den FDZ lassen sich folgende Empfehlungen für effizientes Arbeiten ableiten:

1.  **Datenreduktion:** Frühzeitige Filterung auf relevante Beobachtungen und Variablen
2.  **Inkrementelle Entwicklung:** Erst mit Stichproben arbeiten, dann auf Vollsatz skalieren
3.  **Effiziente Datenformate:** Nutzung moderner Formate (Arrow/Parquet) statt CSV
4.  **Dokumentation:** Sorgfältige Dokumentation des Analyseprozesses für Output-Kontrolle
5.  **Ressourcenplanung:** Bewusste Planung rechenintensiver Operationen bei geteilter Infrastruktur
6.  **Beratung nutzen:** Frühzeitige Kontaktaufnahme mit FDZ-Mitarbeitern bei methodischen Fragen

-->


<!--
1. Große Schritte in 2025, erweiterung des R-Server für die Statistikproduktion des StBA. Das NeSt hat auch modernisierung der FDZ Infrastruktur geführt. Technisches Fundament (S. @sec-infrastruktur)

   1. Um diesen Herausforderungen zu bewältigen, hat das *Statstische Bundesamt* in 2025 wesentliche Meilensteine in der Modernisierung der technischen Analyseinfrastruktur erreicht (dargestellt in @sec-infrastruktur). Anfang 2025 wurden die R-Server für Auswertungen und Datenverabeitungen in der Statistikproduktion modernisiert und stark erweitert. Seit November 2025 stehen auch dem FDZ neue R- und Stata-Analyseserver (sog. FDZ OnSite-Server) für wissenschaftliche Auswertungen zu Verfügung. 
   2. Um die technischen Mittel bereitzustellen, hat eine weitere Initiative des NeSt die Moderniserung IT-Infrastruktur des FDZ vorangetrieben. **Dadurch bietet das FDZ seit November 2025 neue Server mit großen Systemkapazitäten für R und Stata für wissenschaftliche Auswertungen an**. Erstmalig können die vollen Kapazitäten neben der KDFV auch an den GWAPs genutzt werden, um große Datensätze im Vollmaterial auszuwerten. Wir werden in den FDZ OnSite-Servern demonstrieren, dass viele Auswertungsbedarfe das BTP im Vollmaterial innerhalb von Sekunden beantwortet werden können. Da die Datenmenge des BTP den verfügbaren Arbeitsspeicher weiterhin übertrifft, sind geeigneten Programmiermethoden notwendig (untersucht in @sec-ergebnis).
   3. Neben den bisherigen Hauptwerkzeuge für Datenverarbeitung sind für die Statistikproduktion aktuell SAS und Stata in dem FDZ, findet R als Lingua Franca in der Statistik, Methodologie und Datenwissenschaft und somit auf natürlich weise Einzug in die amtliche Statistik.[^uros] 
   4. [^uros]: Wachstum der uRos s. https://r-project.ro/conference2025.html#Presentations
   5. Statistikerstellungsprozesses Werkzeuge abgeleitet werden, die Informationsbedarfe der Öffentlichkeit schnell anhand wachsender Datenmengen zu bedienen. 
   6. Die Bewertung muss sorgfältig durchgeführt werden, da sich die betrachteten R-Pakete schnell weiterentwicklung, meist mit mehreren großen Releases innerhalb eines Jahres, aber die organisatorischen Strukturen nicht erlauben, jede neue Version einzurichten. 
   7. wechselnde Nutzende (Forscher) unterschiedlicher Fachbereiche mit unterschiedlichen Analytischen und technischen Kenntnissen

Durch die Beantwortung können für den 
1. zeigen, dass die Methoden sogar das ganze BTP sehr effizient auswerten können, in Sek, obwohl es den verfügbaren Arbeitsspeicher übersteigt (s. @sec-ergebnis). Ableitung praktischer Implikationen.

[^nest-web]: https://www.bundesfinanzministerium.de/Web/DE/Themen/Steuern/Steuerliche_Themengebiete/NeSt/netzwerk-fuer-empirische-steuerforschung.html
[^btp-web]: https://www.forschungsdatenzentrum.de/de/steuern/btp
[^oss]: ...

<!--
1. Steigende Datenmengen, höhere Bedarfe der Öffentlichkeit an Aktualität und Detailliertheit -> Modernisierung der Datenverarbeitungsinfastruktur nötig um mithalten zu können
   1. In den vergangenen Jahren haben sich die Rahmenbedingungen für die Produktion amtlicher Statistiken erheblich verändert. Die Digitalisierung hat nicht nur zu einer Vervielfachung der verfügbaren Datenmengen geführt, sondern auch neue Möglichkeiten für die statistische Analyse eröffnet. Um diese Herausforderungen zu bewälten,  -> In den vergangenen Jahren haben sich die Rahmenbedingungen für die Produktion amtlicher Statistiken erheblich verändert. Die Digitalisierung hat nicht nur zu einer Vervielfachung der verfügbaren Datenmengen geführt, sondern auch neue Möglichkeiten für die statistische Analyse eröffnet. Gleichzeitig sind die Erwartungen der Öffentlichkeit an Aktualität und Detailliertheit der Statistiken gestiegen. Um diese Herausforderungen zu bewälten, evaluiert der vorliegende Artikel die Effizienz moderner Datenverabeitungsmethoden mit dem Ziel Handlungsempfehlungen für die Praxis abzuleiten.
-->

<!-- #### Steigende Anforderungen an StBA und FDZ -->



<!-- ### Statistiksoftware R

@sec-methoden
@sec-benchmark
@sec-ergebnis zeigt das Potenzial anhand des BTP


5. Vorteile von R Open Source, Vielfalt R-Packages, aktive weltweite Community, wachsende Verbreitung in OS, natürliche Wahl R. bieten Effizienz, hohe Nutzerfreundlichkeit (s @sec-methoden). Frage nach besten möglichkeiten, die Anforderungen XYZ bedient (s. @sec-benchmark)
   1. Wachsende Community auch in Official Statistics, s. uRos
   2. Zusatzfunktionalitäten werden durch die Community in sog. R-Paketen bereitgestellt
   3. Als Open Source Software mit einer weltweit aktiven Community, bietet R bietet Zugang zu sehr vielen Funktionen der Datenverarbeitung (in Form von sog. *R-Paketen*), die ein breites Spektrum an Nutzerfreundlichkeit und Performanz bieten. Die gleiche Datenvearbeitung kann abhängig von der Software-Nutzung, einige Stunden dauern oder in wenigen Sekunden fertigs ein. Nur die richtige Nutzung geeigneter R-Pakete ermöglicht es, Datenverarbeitungsbedarfe anhand großer Datenmengen in Sekunden nachvollziehbar auszuführen (beschrieben in @sec-methoden).   Dadurch stellt sich die Frage welche Programmiermethoden geeignet sind, die neuen Datenverarbeitungsbedarfe mit der spezifischen neuen Infrastruktur zu bedienen (diskutiert in @sec-benchmark). 



--> -->





 
