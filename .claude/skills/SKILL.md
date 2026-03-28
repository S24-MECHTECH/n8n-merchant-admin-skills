# n8n Merchant Admin Skill

Master-Skill für den n8n Google Merchant Center Admin Workflow.

## Workflow

```
Workflow ID: M3Nvfaji6B8WdpWI
Server: vmd188735.contaboserver.net
Status: Active
Nodes: 176
```

## Befehle

| Befehl | Beschreibung |
|--------|--------------|
| `/analyze-gmc-workflow` | Analysiert den GMC Workflow |
| `/fix-gmc-error-routing` | Flickst Error-Routing-Probleme |
| `/optimize-gmc-rag` | Aktiviert RAG Contexts |
| `/gmc-status` | Zeigt aktuellen Workflow-Status |

## Sub-Skills

- `n8n-workflow-analyzer/` - Analysiert Nodes und Connections
- `n8n-error-handler/` - Flickst Error-Routing
- `n8n-rag-optimizer/` - Aktiviert Supabase RAG
- `n8n-workflow-master/` - Koordiniert alles

## Problem

Error Agents bekommen keine Daten weil:
1. Error-Routing ist falsch herum (POST-FIX statt PRE-FIX)
2. 7 Supabase RAG Contexts sind nicht verbunden
3. Kreislauf-Connections existieren

## Fix ausführen

```bash
# 1. Analysieren
/analyze-gmc-workflow M3Nvfaji6B8WdpWI

# 2. Error-Routing fixen
/fix-gmc-error-routing M3Nvfaji6B8WdpWI

# 3. RAG aktivieren
/optimize-gmc-rag M3Nvfaji6B8WdpWI
```
