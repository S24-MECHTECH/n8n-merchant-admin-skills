# n8n Workflow Analyzer Skill

Analysiert n8n Workflows via API, identifiziert Connections, Nodes, Routing-Probleme und Datenfluss-Blockaden.

## Usage

```
/analyze-n8n-workflow <workflow-id>
```

## Workflow Info

| Property | Wert |
|----------|------|
| Server | vmd188735.contaboserver.net |
| Port | 5678 |
| API Key | Aus settings.local.json |

## API Access

```bash
# Workflow abrufen
curl -X GET "https://vmd188735.contaboserver.net/api/v1/workflows/{WORKFLOW_ID}" \
  -H "X-N8N-API-KEY: {API_KEY}" \
  -H "Content-Type: application/json"
```

## Analysis Steps

### 1. Nodes extrahieren
```bash
jq '.nodes[] | {name, type, id}' workflow.json
```

### 2. Connections analysieren
```bash
jq '.connections | keys' workflow.json  # Alle Node-Namen
jq '.connections["NODE_NAME"]' workflow.json  # Outputs von Node
```

### 3. Input-Sources finden
Für jede Node:
```bash
jq -r '.connections | to_entries[] | select(.value.main[0][] | select(.node == "TARGET_NODE")) | .key' workflow.json
```

### 4. Routing-Logik prüfen
Switch/Router Nodes:
```bash
jq '.nodes[] | select(.type == "n8n-nodes-base.switch") | {name, parameters.rules}'
```

## Output Format

```
=== WORKFLOW ANALYSE ===

Workflow: {name} ({id})
Nodes: {count}
Status: {active|archived}

=== DATENFLUSS (erste 20 Connections) ===

NodeA → NodeB
NodeC → NodeD
...

=== PROBLEM-NODES ===

1. [NODE_NAME]
   - Problem: {beschreibung}
   - Erwartet: {was sein sollte}
   - Tatsächlich: {was ist}

=== ROUTING-ANALYSE ===

Switch Node: {name}
  - Cases: {anzahl}
  - Outputs: {liste}

=== AGENT-INPUTS ===

{agent_name}:
  - Input von: {source_node}
  - RAG Connected: {ja|nein}
```

## Error Detection Patterns

| Pattern | Problem |
|---------|---------|
| Agent mit 0 Inputs | Keine Datenquelle verbunden |
| Router ohne Outputs | Unreachable node |
| IF/Switch ohne Error Output | Fehler werden verschluckt |
| Supabase Node ohne Connection | RAG Context inaktiv |

## Related Skills

- `/n8n-error-handler` - Fix identifizierte Probleme
- `/n8n-rag-optimizer` - RAG Contexts aktivieren
