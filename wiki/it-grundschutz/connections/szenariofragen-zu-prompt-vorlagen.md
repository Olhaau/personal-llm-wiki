---
title: "Szenariofragen zu Prompt-Vorlagen"
token: "145"
topic: "it-grundschutz"
generated_at: "2026-05-15T13:54:46Z"
---

## Summary

BSI empfiehlt fuer Schutzbedarfsfeststellungen einen strukturierten Fragenansatz mit "Was waere wenn ...?"-Szenarien [[raw/bsi-lektion-4-4-schutzbedarf-prozesse-und-anwendungen.md]]. Continue beschreibt wiederverwendbare Prompt-Dateien fuer wiederkehrende Aufgaben, wodurch sich solche Fragenkataloge als standardisierte Prompt-Vorlagen operationalisieren lassen [[raw/continue-prompts-deep-dive.md]].

## Details

Die BSI-Fragen decken Rechtsfolgen, Betriebsauswirkungen, Image und Finanzen ab und sollen nachvollziehbar dokumentierte Entscheidungen erzeugen [[raw/bsi-lektion-4-4-schutzbedarf-prozesse-und-anwendungen.md]]. Continue-Prompts mit `invokable: true` sind genau fuer wiederholte, strukturierte Instruktionen gedacht und koennen in CLI-Workflows reproduzierbar gestartet werden [[raw/continue-prompts-deep-dive.md]].

Damit entsteht eine belastbare Cross-Topic-Verbindung: Risikofragen aus IT-Grundschutz koennen in prompt-engineering als standardisierte Ausfuehrungsvorlagen bereitgestellt werden, ohne den Bewertungsinhalt zu veraendern [[raw/bsi-lektion-4-4-schutzbedarf-prozesse-und-anwendungen.md]] [[raw/continue-prompts-deep-dive.md]].

## Connected Concepts

- [[wiki/it-grundschutz/concepts/schutzbedarf-fuer-prozesse-und-anwendungen.md]] - Enthaltene Szenariofragen liefern den fachlichen Fragenkatalog.
- [[wiki/prompt-engineering/concepts/continue-prompts.md]] - Prompt-Dateien bilden den technischen Mechanismus fuer wiederverwendbare Fragevorlagen.
- [[wiki/prompt-engineering/concepts/continue-cn-workflows.md]] - CLI-Workflows zeigen, wie Vorlagen wiederholt und konsistent ausgefuehrt werden.

## References

- [[raw/bsi-lektion-4-4-schutzbedarf-prozesse-und-anwendungen.md]]
- [[raw/continue-prompts-deep-dive.md]]
