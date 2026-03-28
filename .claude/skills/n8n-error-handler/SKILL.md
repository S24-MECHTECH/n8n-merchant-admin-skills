# n8n Error Handler Skill

Fixe Error-Routing-Probleme in n8n Workflows. Erstellt neue Connections und korrigiert fehlerhaftes Error-Handling.

## Prerequisite

- Workflow ID muss bekannt sein
- `/analyze-n8n-workflow` wurde bereits ausgeführt

## Usage

```
/fix-n8n-error-routing <workflow-id>
```

## Problem Categories

### Category 1: Error Agents bekommen keine Daten

**Symptom:**
```
Fix Errors Router → AI Error Analyzer (POST-FIX = SINNLOS)
```

**Ursache:** Error Analyzer analysieren bereits behobene Fehler.

**Lösung:** Connection umkehren
```
Error Parser Schema → Error Router → AI Error Analyzer (PRE-FIX)
                                        ↓
                              Fix Nodes (Adult, Image, etc.)
```

### Category 2: Error-Routing funktioniert nicht

**Symptom:** Errors werden nicht korrekt geroutet.

**Lösung:**
1. Prüfe Switch-Cases in `Error Router`
2. Stelle sicher dass jeder Case einen Output hat
3. Füge Error-Output-Pin hinzu wenn nötig

### Category 3: Kreislauf-Connections

**Symptom:**
```
AI Error Analyzer → Fix Errors Router → AI Error Analyzer (LOOP!)
```

**Lösung:** Entferne Rückverbindung zum Router. Error Analyzer sollte direkt zu Fix-Nodes connecten.

## Fix Implementation

### Step 1: Workflow exportieren
```bash
curl -X GET "https://vmd188735.contaboserver.net/api/v1/workflows/{ID}" \
  -H "X-N8N-API-KEY: {API_KEY}" \
  -o workflow.json
```

### Step 2: Problem identifizieren
```bash
# Finde alle Error Analyzer Input-Connections
jq -r '.connections | to_entries[] |
  select(.value.main[0][] | select(.node | test("AI Error"))) |
  .key' workflow.json
```

### Step 3: Fix via n8n API

```bash
# Connection hinzufügen (POST)
curl -X POST "https://vmd188735.contaboserver.net/api/v1/workflows/{ID}/connections" \
  -H "X-N8N-API-KEY: {API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "sourceNode": "Error Parser Schema",
    "targetNode": "AI Error Analyzer Adult Flags",
    "sourceIndex": 0,
    "targetIndex": 0
  }'
```

### Step 4: Workflow aktivieren
```bash
curl -X POST "https://vmd188735.contaboserver.net/api/v1/workflows/{ID}/activate" \
  -H "X-N8N-API-KEY: {API_KEY}"
```

## Workflow für GMC Error-Fix

### Korrekter Datenfluss:

```
1. Chat Trigger / Schedule Trigger
       ↓
2. Get Merchant Products (S24 + DDC)
       ↓
3. MC_Parse_S24 / MC_Parse_DDC
       ↓
4. Error Parser Schema (identifiziert Fehlertyp)
       ↓
5. Error Router (switcht nach error type)
       ↓
6. AI Error Analyzer [TYPE] (PRÄ-FIX Analyse) ← KORREKT: VOR dem Fix!
       ↓
7. Fix Nodes (Fix Adult, Fix Image, etc.)
       ↓
8. Log Results to Sheets
       ↓
9. Send Response
```

### Falsch (aktuell):

```
Error Router → Fix Errors Router → AI Error Analyzer (POST-FIX = falsch!)
```

## GMC-spezifische Error Types

| Error Type | AI Error Analyzer | Fix Node |
|------------|-------------------|----------|
| adult_error | AI Error Analyzer Adult Flags | Fix Adult |
| image_error | AI Error Analyzer Images | Fix image (adult) |
| text_error | AI Error Analyzer Text | Fix text |
| merchant_quality_error | AI Error Analyzer Merchant | Fix merchant |
| multi_country_error | AI Error Analyzer Error_Multi_Country | Fix Multi_Country |
| multi_gtn_ean_error | AI Error Analyzer Error_Multi_GTN/EAN | Fix Multi_GTN/EAN |
| haendlerqualitaet_error | AI Error Analyzer_Händlerqualität | Fix Multi_Händler_Qualität |

## Validation Commands

Nach Fix ausführen:

```bash
# Prüfe ob Error Analyzer Inputs haben
jq '.connections["AI Error Analyzer Adult Flags"]' workflow.json

# Sollte Output von Error Parser Schema sein:
# {"main": [[{"node": "Error Parser Schema", ...}]]}

# Prüfe Kreislauf
jq -r '.connections | to_entries[] |
  select(.key | test("Error Analyzer")) |
  .value.main[0][] | .node' workflow.json | sort -u
```

## Related Skills

- `/n8n-workflow-analyzer` - Analysiere Probleme
- `/n8n-rag-optimizer` - Aktiviere RAG Contexts
