# n8n RAG Optimizer Skill

Aktiviert und verbindet Supabase RAG Contexts mit n8n Agents für Knowledge-Retrieval.

## Usage

```
/optimize-n8n-rag <workflow-id>
```

## Problem

Im Workflow M3Nvfaji6B8WdpWI sind 7 Supabase RAG Contexts vorhanden aber NICHT mit den Error Analyzer Agents verbunden.

```
Supabase RAG Context1-7: ❌ Nicht verbunden
AI Error Analyzer Agents: 6 Stück
```

## Supabase Tables für GMC

| Table | Purpose | Used By |
|-------|---------|---------|
| merchant_knowledge_base | Allgemeine Merchant Center Regeln | Merchant Brain |
| merchant_errors | Historische Fehler und Lösungen | Error Agents |
| merchant_optimization_patterns | Optimierungsmuster | Optimizer Agent |
| merchant_products | Produktdaten | Product Agent |
| merchant_gemini_decisions | Gemini-Entscheidungen | Learning Agent |

## RAG Connection Steps

### Step 1: Supabase RAG Context Node identifizieren

Im Workflow:
```
Supabase RAG Context (Type: @n8n/n8n-nodes-langchain.vectorStoreSupabase)
```

Node-Parameter:
- `credentials`: Supabase_Contabo_ServiceKey
- `tableName`: merchant_errors
- `queryTable`: true

### Step 2: Agent mit RAG verbinden

Jeder Error Analyzer Agent braucht:
1. Einen eigenen RAG Context (für seinen Fehlertyp)
2. Den passenden Table-Eintrag in Supabase

| Agent | Supabase Table | Embeddings |
|-------|---------------|------------|
| AI Error Analyzer Adult Flags | merchant_errors (filtered: adult) | merchant-adult-embeddings |
| AI Error Analyzer Images | merchant_errors (filtered: image) | merchant-image-embeddings |
| AI Error Analyzer Text | merchant_errors (filtered: text) | merchant-text-embeddings |

### Step 3: Embeddings generieren

```bash
# Bestehende Embeddings in Supabase prüfen
curl -X POST "https://{SUPABASE_URL}/rest/v1/rpc/match_merchant_errors" \
  -H "apikey: {SUPABASE_KEY}" \
  -H "Authorization: Bearer {SUPABASE_KEY}" \
  -d '{"query_embedding": [0.1, ...], "match_threshold": 0.5}'
```

## Embedding Strategy für GMC

### Fehler-Kategorien embedden

Für jede Error-Kategorie in Supabase:

```sql
-- Beispiel: Adult Flag Errors
INSERT INTO merchant_errors (error_type, description, solution, embedding)
VALUES (
  'adult_error',
  'Product marked as adult content incorrectly',
  'Review adult flag settings and product categorization',
  '[embedding_vector]'
);
```

### Similarity Search

```sql
SELECT * FROM merchant_errors
ORDER BY embedding <=> '[query_embedding]'
LIMIT 5;
```

## Supabase RAG Node Konfiguration

```
Node: Supabase RAG Context
Type: @n8n/n8n-nodes-langchain.vectorStoreSupabase

Parameters:
{
  "credentials": "Supabase_Contabo_ServiceKey",
  "tableName": "merchant_errors",
  "queryTable": true,
  "options": {
    "filter": "error_type = 'adult_error'",
    "matchCount": 5,
    "similarityThreshold": 0.7
  }
}
```

## Validation

### Prüfe RAG Connections

```bash
# Agent-Connections prüfen
jq '.connections["AI Error Analyzer Adult Flags"]' workflow.json

# Sollte einen Input von Supabase RAG Context haben
```

### Test RAG Query

Im n8n Workflow:
1. Manually trigger Chat
2. Frage: "Wie fix ich Adult Flag Fehler?"
3. Prüfe ob RAG Context antwortet

## Auto-Fix Commands

```
/activate-all-rag-contexts   - Alle 7 RAG Contexts mit Agents verbinden
/check-rag-embeddings        - Embedding-Status prüfen
/embed-merchant-errors       - Neue Errors in Supabase embedden
```

## Related Skills

- `/n8n-workflow-analyzer` - RAG-Probleme finden
- `/n8n-error-handler` - Error-Routing fixen
