# n8n GMC Workflow Master Skill

Master-Koordinationsskill für den Google Merchant Center Workflow (M3Nvfaji6B8WdpWI).

## Workflow Info

| Property | Wert |
|----------|------|
| Workflow ID | M3Nvfaji6B8WdpWI |
| Name | ***MECHTECH_MERCHANT_CENTER_ADMIN |
| Server | vmd188735.contaboserver.net |
| Status | Active |

## Shops

| Shop | Merchant ID | Domain |
|------|------------|--------|
| S24 (SiliconeDolls24) | 5339977843 | sliconedolls24.com |
| DDC (DreamDoll) | 124485833 | dreamdoll.de |

## Bekannte Probleme

### Problem 1: Error Agents bekommen keine sinnvollen Daten

**Symptom:**
- 6 Error Analyzer Agents existieren
- Error-Routing ist falsch herum konfiguriert
- Agents analysieren POST-FIX statt PRE-FIX

**Datenfluss (FALSCH):**
```
Fix Errors Router → AI Error Analyzer (bereits behoben = sinnlos)
```

**Datenfluss (KORREKT):**
```
Error Parser Schema → Error Router → AI Error Analyzer (PRE-FIX)
                                        ↓
                              Analyze & Generate Fix
                                        ↓
                              Fix Nodes (Adult, Image, etc.)
```

### Problem 2: 7 Supabase RAG Contexts nicht verbunden

**Symptom:**
- Supabase RAG Context1-7 existieren
- Keine Connection zu Error Analyzer Agents
- Keine Embeddings für Knowledge Retrieval

### Problem 3: Kreislauf-Connections

**Symptom:**
```
AI Error Analyzer → Fix Errors Router → AI Error Analyzer (LOOP!)
```

## Verfügbare Befehle

| Befehl | Skill | Beschreibung |
|--------|-------|--------------|
| `/analyze-gmc-workflow` | n8n-workflow-analyzer | Vollständige Workflow-Analyse |
| `/fix-gmc-error-routing` | n8n-error-handler | Error-Routing korrigieren |
| `/optimize-gmc-rag` | n8n-rag-optimizer | RAG Contexts aktivieren |
| `/gmc-full-fix` | Alle | Alle Probleme beheben |
| `/test-gmc-errors` | - | Error-Agenten testen |

## Workflow-Analyse durchführen

```
/analyze-gmc-workflow M3Nvfaji6B8WdpWI
```

Analysiert:
- Alle 176 Nodes
- Alle Connections
- Error-Routing-Logik
- RAG-Context-Status
- Agent-Input-Sources

## Error-Typen im GMC

| Error Type | Error Analyzer | Fix Node | Supabase Table |
|------------|----------------|----------|---------------|
| adult_error | AI Error Analyzer Adult Flags | Fix Adult | merchant_errors |
| image_error | AI Error Analyzer Images | Fix image (adult) | merchant_errors |
| text_error | AI Error Analyzer Text | Fix text | merchant_errors |
| merchant_quality_error | AI Error Analyzer Merchant | Fix merchant | merchant_errors |
| multi_country_error | AI Error Analyzer Error_Multi_Country | Fix Multi_Country | merchant_errors |
| multi_gtn_ean_error | AI Error Analyzer Error_Multi_GTN/EAN | Fix Multi_GTN/EAN | merchant_errors |
| haendlerqualitaet_error | AI Error Analyzer_Händlerqualität | Fix Multi_Händler_Qualität | merchant_errors |

## Supabase Credentials

- **Service Key:** EXHihUhIMTMwIQ27
- **Project:** mechtech-merchantecenter

## Externe Tools

| Tool | Funktion |
|------|----------|
| Google Sheets | MERCHANT_OPTIMIERT Sheet |
| Gmail | Reports senden |
| Telegram | Daily Reports |
| WhatsApp | Expert Alerts |
| OpenClaw MCP | Externer Workflow |

## Auto-Trigger Regeln

| Erkannter Kontext | Skill |
|-------------------|-------|
| "routing", "datenfluss" | n8n-error-handler |
| "error agent", "keine daten" | n8n-error-handler |
| "rag", "context", "embedding" | n8n-rag-optimizer |
| "analyze", "workflow" | n8n-workflow-analyzer |

## Fix-Plan

### Phase 1: Analyse
- [x] Workflow M3Nvfaji6B8WdpWI herunterladen
- [x] 176 Nodes identifizieren
- [x] Connections analysieren
- [x] Problemstellen gefunden

### Phase 2: Error-Routing fixen
- [ ] Connection: `Fix Errors Router → AI Error Analyzer` ENTFERNEN
- [ ] Connection: `Error Parser Schema → AI Error Analyzer` ERSTELLEN
- [ ] Connection: `AI Error Analyzer → Fix Nodes` ERSTELLEN
- [ ] Kreislauf-Connections auflösen

### Phase 3: RAG aktivieren
- [ ] Supabase RAG Context1-7 prüfen
- [ ] Agenten mit passenden RAG Contexts verbinden
- [ ] Embeddings generieren
- [ ] Knowledge Retrieval testen

### Phase 4: Validierung
- [ ] Error-Agenten manuell testen
- [ ] Chat-Trigger testen
- [ ] Schedule-Trigger testen
- [ ] Response-Format prüfen
