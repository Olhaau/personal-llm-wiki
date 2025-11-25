# BTP Synthetic Data Generator: Data Sources and Methodology

## Overview

The `generate_btp_synth()` function creates synthetic panel data that mimics the structure and statistical characteristics of the German Business-Tax-Panel (BTP) 2013-2019. This document describes how publicly available information on structure and distributions are used in the generation process.

## Data Sources

### 1. Variable Structure (`btp_variables_format.csv`)

**Location**: `data/btp_variables_format.csv`

**Source**: Derived from publicly available BTP documentation and data structure descriptions

**Content**:
- **prefix**: Tax statistic identifier (g, k, u, p, v, e)
- **variable**: Variable name following BTP naming conventions
- **format**: Data type (Char for categorical/character, Num for numeric)

**Variables by Statistic**:
- `g` (Gewerbesteuer / Trade Tax): 328 variables
- `k` (Körperschaftsteuer / Corporate Tax): 1,088 variables  
- `u` (Umsatzsteuer-Voranmeldung / VAT Advance): 75 variables
- `p` (Personengesellschaften / Partnerships): 1,078 variables
- `v` (Umsatzsteuer-Veranlagung / VAT Annual): 120 variables
- `e` (Einnahmenüberschussrechnung / Income Surplus Calculation): 349 variables

**Total**: 3,038 variables

**Usage in Function**:
- Determines which variables to generate for each tax statistic
- Specifies the data type for each variable (character vs. numeric)
- No actual data values are taken from real BTP data

###2. Variable Metadata (`btp_variables_metadata.csv`)

**Location**: `data/btp_variables_metadata.csv`

**Source**: Official BTP variable documentation

**Content**:
- **prefix**: Tax statistic identifier
- **variable**: Variable name
- **n_vars**: Total number of variables in that statistic
- **description**: Human-readable description in German

**Usage in Function**:
- Documentation and reference only
- NOT used in the actual data generation process
- Helps users understand what each variable represents

### 3. Observation Distribution by Year (`btp_obs_distribution.csv`)

**Location**: `data/btp_obs_distribution.csv`

**Source**: Published BTP statistics on coverage rates across tax statistics

**Content**:
Year-specific probabilities for each statistic (2013-2019):
- `stat`: Tax statistic identifier (g, k, u, p, v, e)
- `p2013` to `p2019`: Probability that an observation has data for this statistic in each year

**Example Values** (approximate):
- Gewerbesteuer (g): ~42% per year
- Körperschaftsteuer (k): ~14% per year
- Umsatzsteuer-Voranmeldung (u): ~34% per year
- Personengesellschaften (p): ~13% per year
- Umsatzsteuer-Veranlagung (v): ~71% per year
- Einnahmenüberschussrechnung (e): ~51% per year

**Usage in Function**:
- `generate_linkage_variables()` uses these probabilities to create realistic `verk` patterns
- Determines which statistics are available for each observation-year combination
- Creates the characteristic unbalanced panel structure of the real BTP

## Synthetic Data Generation Methodology

### Panel Structure

#### 1. Balanced vs. Unbalanced Panels

**Unbalanced (default)**:
- 28.4% of units appear in all 7 years (2013-2019)
- Remaining units have varying participation
- Probability distribution:
  - 1 year: 15%
  - 2-6 years: 12% each
  - 7 years: 15%

**Source**: Published statistics on BTP panel balance

**Balanced**:
- All units appear in all years
- Total rows = obs × number of years

#### 2. Geographic Distribution

**Amtlicher Gemeindeschlüssel (AGS)** - German Municipality Codes

Format: `SS-DDD-MMM` (State-District-Municipality)

**State Distribution** (16 German states):
```
State  Probability  Name
01     3.6%         Schleswig-Holstein
02     2.3%         Hamburg
03     1.5%         Niedersachsen
04     18.4%        Nordrhein-Westfalen
05     20.6%        Bayern
06     2.1%         Baden-Württemberg
07     14.3%        Hessen
08     8.9%         Rheinland-Pfalz
09     7.8%         Saarland
10     2.9%         Berlin
11     2.5%         Brandenburg
12     3.2%         Mecklenburg-Vorpommern
13     1.6%         Sachsen
14     5.1%         Sachsen-Anhalt
15     2.5%         Thüringen
16     2.7%         Bremen
```

**Source**: Approximation of German business distribution across states

**District and Municipality**: Randomly generated (001-999) for synthetic purposes

### Enterprise Register Variables

**urs_we_umsatz** (Turnover in 1,000 EUR):
- Distribution: Log-normal(mean=5, sd=2)
- Non-negative values only
- Source: Approximates typical SME turnover distribution

**urs_we_umsatz_quelle** (Turnover Data Source):
- 1 (Survey): 40%
- 4 (Tax Administration): 50%
- 5 (Estimation): 10%
- Source: Typical mix of data sources in official statistics

**urs_we_tp_stichtag** (Active Persons on Dec 31):
- Distribution: Poisson(λ=15)
- Minimum value: 1
- Source: Typical small business employment

**urs_we_svb_stichtag** (Employees Subject to Social Insurance):
- Distribution: Binomial(size=urs_we_tp_stichtag, prob=0.75)
- Source: Typical ratio of employees to total active persons

**urs_rt_gruppen_kennz** (Enterprise Group Status):
- 0 (No Group): 85%
- 1 (Domestic Controlled): 10%
- 3 (Foreign Controlled): 3%
- 6 (EU Foreign Controlled): 2%
- Source: Typical distribution in German business statistics

**urs_rechtsform** (Legal Form):
- 101 (Sole Proprietorship): 70%
- 201 (Partnership): 15%
- 301 (Corporation): 10%
- 401 (Other Legal Persons): 5%
- Source: German business register statistics

### Linkage Variables

**verk** (Linkage Variable):
- 7-character string indicating which statistics are linked
- Format: `gkupvre` (all statistics) or `g_u__r_` (only g, u, and r)
- Position 1: g (Gewerbesteuer)
- Position 2: k (Körperschaftsteuer)
- Position 3: u (Umsatzsteuer-Voranmeldung)
- Position 4: p (Personengesellschaften)
- Position 5: v (Umsatzsteuer-Veranlagung)
- Position 6: r (Enterprise Register - always present)
- Position 7: e (Einnahmenüberschussrechnung)

**Generation**: Uses year-specific probabilities from `btp_obs_distribution.csv`

**verk_qual** (Linkage Quality):
- 1 (Current Tax Number): 70%
- 2 (Current + Old Tax Number): 20%
- 3 (Business Register/Manual/Cluster): 10%
- Source: Typical distribution of linkage quality in administrative data linkage

### Tax Statistic Variables

For each tax statistic (g, k, u, p, v, e), variables are generated only for observations where that statistic appears in the `verk` string.

#### Character Variables

Random selection from statistic-specific values:
- **Gewerbesteuer (g)**: "0", "1", "2", "A", "B", "E"
- **Körperschaftsteuer (k)**: "0", "1", "2", "AG", "GmbH", "eG"
- **Umsatzsteuer (u,v)**: "0", "1", "2", "3"
- **Personengesellschaften (p)**: "0", "1", "2", "3", "20", "21"
- **Einnahmenüberschussrechnung (e)**: "0", "1", "2", "A", "B"

**Source**: Typical categorical response patterns for administrative tax data

#### Numeric Variables

Distributions vary by statistic to reflect different economic magnitudes:

- **Gewerbesteuer (g)**: Normal(mean=50,000, sd=100,000)
- **Körperschaftsteuer (k)**: Normal(mean=60,000, sd=120,000)
- **Umsatzsteuer-Voranmeldung (u)**: Log-normal(meanlog=11, sdlog=1.5), non-negative
- **Personengesellschaften (p)**: Normal(mean=40,000, sd=80,000)
- **Umsatzsteuer-Veranlagung (v)**: Log-normal(meanlog=12, sdlog=1.5), non-negative
- **Einnahmenüberschussrechnung (e)**: Log-normal(meanlog=11, sdlog=1.5), non-negative

**Source**: Approximations of typical value ranges in German tax statistics

## Important Notes

### What is Based on Real BTP Structure

The following elements are based on publicly documented BTP characteristics:

1. **Data Integration Structure**
   - Six tax statistics (EVAS 73511, 73211, 73311, 73121, 73321, 73111)
   - Enterprise register integration (EVAS 52111)
   - Source: FDZ official BTP page

2. **Scale and Scope**
   - Time period: 2013-2019 (matching published BTP availability)
   - Approximate variable count reflecting "over 2,700 variables"
   - Panel structure reflecting millions of linked observations
   - Source: FDZ BTP documentation

3. **Variable Naming Conventions**
   - Prefix system (g, k, u, p, v, e) for statistics
   - Structured variable names following tax form logic
   - Source: Published metadata and working papers

4. **Statistical Properties**
   - Census-based (Vollerhebung) character
   - Secondary data from tax administration
   - Panel structure with varying coverage across statistics
   - Source: Official FDZ descriptions

### What is Synthetic

1. **All numeric values**: Randomly generated from parametric distributions
2. **All categorical values**: Randomly sampled from typical categories
3. **Unit identifiers**: Sequential numbering (1, 2, 3, ...)
4. **Temporal patterns**: No real economic trends or cycles
5. **Cross-variable relationships**: No real economic relationships preserved

### Reproducibility

All synthetic data generation uses R's random number generation. Setting a seed ensures reproducibility:

```r
df <- generate_btp_synth(obs = 100, seed = 42)
```

## References

### Primary Data Source

**Research Data Centres (FDZ) of the Federal Statistical Office and Statistical Offices of the Länder**
- Website: https://www.forschungsdatenzentrum.de/en
- German: https://www.forschungsdatenzentrum.de/de
- Contact: forschungsdatenzentrum@destatis.de

### BTP-Specific Documentation

**Business-Tax-Panel (BTP) - Official FDZ Page**
- German: https://www.forschungsdatenzentrum.de/de/steuern/btp
- EVAS-Nr. 73511
- DOI (On-Site): 10.21242/73511.2019.00.05.1.1.0
- DOI (Off-Site): 10.21242/73511.2019.00.05.2.1.0

**BTP Data Holder**:
- **Forschungsdatenzentrum des Statistischen Bundesamtes**
- Phone: +49 611 75-2420
- Email: forschungsdatenzentrum@destatis.de
- Website: https://www.forschungsdatenzentrum.de/de/steuern/btp

**BTP Composition**: The Business-Tax-Panel integrates the following datasets:
- EVAS 73511: Gewerbesteuerstatistik (Trade Tax Statistics)
- EVAS 73211: Körperschaftsteuerstatistik (Corporate Tax Statistics)
- EVAS 73311: Umsatzsteuerstatistik - Voranmeldungen (VAT Advance Returns)
- EVAS 73121: Personengesellschaften und Gemeinschaften (Partnerships Statistics)
- EVAS 73321: Umsatzsteuerstatistik - Veranlagungen (VAT Annual Returns)
- EVAS 73111: Einnahmenüberschussrechnung (Income Surplus Calculation)
- EVAS 52111: Unternehmensregister (Enterprise Register) - selected variables

**BTP Characteristics** (as published by FDZ):
- Time period: 2013-2019 (with annual updates)
- Total units: Over 66 million observations across all years
- Variables: Over 2,700 variables from various tax forms and indicators
- Coverage: Census-based (Vollerhebung) secondary data from tax administration

**Data Access**: 
- BTP microdata access through FDZ requires formal application
- Available access modes:
  - Gastwissenschaftsarbeitsplatz (GWAP) - On-site safe center: https://www.forschungsdatenzentrum.de/de/online-gwap-buchungssystem
  - Kontrollierte Datenfernverarbeitung (KDFV) - Controlled remote data execution
- Terms of use: https://www.forschungsdatenzentrum.de/de/bedingungen
- Access options: https://www.forschungsdatenzentrum.de/de/zugang
- Application process: https://www.forschungsdatenzentrum.de/de/antrag
- User charges: https://www.forschungsdatenzentrum.de/de/entgelte

### Public Information Sources Used

The following publicly available information was used to create this synthetic data generator:

1. **Variable Structure and Nomenclature**
   - BTP structure description from FDZ website: https://www.forschungsdatenzentrum.de/de/steuern/btp
   - Official EVAS numbers for component statistics (73511, 73211, 73311, 73121, 73321, 73111, 52111)
   - Published metadata reports available through FDZ DOI system
   - Variable naming conventions from published methodological papers

2. **Panel Composition Statistics**
   - BTP composition: 6 tax statistics + enterprise register as documented by FDZ
   - Panel size: "Over 66 million units" (2013-2019) as published on FDZ BTP page
   - Variable count: "Over 2,700 variables" as stated in official FDZ documentation
   - Coverage as census-based (Vollerhebung) secondary statistics

3. **Component Statistics Information**
   - Gewerbesteuer: https://www.forschungsdatenzentrum.de/de/steuern/gewerbesteuer
   - Körperschaftsteuer: https://www.forschungsdatenzentrum.de/de/steuern/koerperschaftsteuer  
   - Umsatzsteuer: https://www.forschungsdatenzentrum.de/de/steuern/umsatzsteuer
   - Umsatzsteuerpanel: https://www.forschungsdatenzentrum.de/de/steuern/ustp

4. **Geographic Distribution**
   - Official German municipality code (AGS) system from Destatis
   - State-level business statistics from official publications
   - Published regional economic statistics

5. **Enterprise Register Information**
   - Unternehmensregister (URS) structure from Destatis
   - Published statistics on enterprise demographics
   - Legal form distributions from official business statistics

### Academic Publications and Methodological Reports

**FDZ Publications**:
- Methodological reports and quality reports for BTP available through FDZ DOI system
- Working papers and documentation available at: https://www.forschungsdatenzentrum.de/de/veroeffentlichungen
- Metadata reports accessible through DOI links on BTP page

**Legal Basis**:
- Gesetz über Steuerstatistiken (StStatG) vom 11. Oktober 1995
- Full text: https://www.gesetze-im-internet.de/ststatg_1995/

**Note**: Specific methodological reports, working papers, and detailed documentation are available through the FDZ and can be requested from the Research Data Centre.

### Related Statistical Products

- **Unternehmensregister (URS)**: Enterprise register maintained by Destatis
  - https://www.destatis.de/DE/Themen/Branchen-Unternehmen/Unternehmen/Unternehmensregister/_inhalt.html

- **Official Tax Statistics**: Federal Statistical Office
  - https://www.destatis.de/DE/Themen/Staat/Steuern/_inhalt.html

### Legal Framework

Data access and usage governed by:
- Federal Statistics Law (Bundesstatistikgesetz - BStatG)
- Tax Secrecy Act (Abgabenordnung - AO §30)
- EU General Data Protection Regulation (GDPR)

Full legal framework available at: https://www.forschungsdatenzentrum.de/en/terms-use

## Legal and Ethical Considerations

### Compliance with Data Protection

This synthetic data generator:
- **Does NOT** contain any real taxpayer data
- **Does NOT** reproduce actual tax return values from the BTP
- **Does NOT** violate statistical confidentiality regulations
- **Does NOT** require FDZ data access approval for use
- **Does NOT** fall under Federal Statistics Law (BStatG) restrictions

### Intended Use

This generator **IS intended** for:
- Testing and benchmarking data processing methods
- Developing analytical workflows before FDZ data access
- Teaching and training with realistic data structures
- Methodological development and algorithm testing
- Performance comparisons of statistical software

This generator **IS NOT intended** for:
- Actual economic analysis or inference
- Policy decisions or recommendations
- Publication of substantive empirical results
- Replacement of actual BTP data access through FDZ

### Relationship to Official BTP

**This synthetic data generator**:
- Mimics only the **structure** of BTP data (variable names, formats, panel characteristics)
- Uses only **publicly available information** about BTP composition and structure
- Generates all values using **random number generation** with no real data input
- Is **completely independent** of the actual BTP microdata held by FDZ

**To work with actual BTP data**, researchers must:
1. Apply for data access through FDZ: https://www.forschungsdatenzentrum.de/en/request
2. Meet scientific independence and data protection requirements
3. Sign data use agreements
4. Pay applicable user charges: https://www.forschungsdatenzentrum.de/en/user-charge
5. Work within approved access modes (safe center, remote access, scientific use files)

### Citation

If using this synthetic data generator in research or publications, please cite:

**For the generator itself**:
```
Synthetic BTP Data Generator v2.0 (2025). 
Based on publicly available structure information from the 
Research Data Centres of the Federal Statistical Office and 
Statistical Offices of the Länder. 
Source: https://www.forschungsdatenzentrum.de/de/steuern/btp
```

**For the actual BTP** (when referencing the real data structure):

On-Site data (GWAP):
```
Forschungsdatenzentrum der Statistischen Ämter des Bundes und der Länder (2022):
Business-Tax-Panel, 2013-2019, On-Site, 
DOI: 10.21242/73511.2019.00.05.1.1.0
```

Off-Site data (KDFV):
```
Forschungsdatenzentrum der Statistischen Ämter des Bundes und der Länder (2022):
Business-Tax-Panel, 2013-2019, Off-Site, 
DOI: 10.21242/73511.2019.00.05.2.1.0
```

Check current citation requirements at: https://www.forschungsdatenzentrum.de/de/zitation-doi

### Disclaimer

All generated values are purely synthetic and any resemblance to actual taxpayer data is coincidental. Users are responsible for ensuring proper disclosure when presenting results based on synthetic data to avoid confusion with actual BTP research results.

## Version Information

- **Generator**: generate_btp_synth.R
- **Version**: 2.0
- **Last Updated**: November 2025
- **Data Structure**: BTP 2013-2019
