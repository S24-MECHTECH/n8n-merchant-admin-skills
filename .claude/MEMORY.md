# MEMORY: n8n Merchant Center Admin

## Workflow Analyse (2026-03-28)

### Workflow ID: M3Nvfaji6B8WdpWI
- **Name:** ***MECHTECH_MERCHANT_CENTER_ADMIN
- **Server:** vmd188735.contaboserver.net
- **Nodes:** 176
- **Status:** Active

### Kritische Probleme gefunden

#### Problem 1: Error-Routing falsch herum
**Aktuell (FALSCH):**
```
Fix Errors Router → AI Error Analyzer Adult Flags
                  → AI Error Analyzer Images
                  → AI Error Analyzer Text
                  → AI Error Analyzer Merchant
                  → AI Error Analyzer Error_Multi_Country
                  → AI Error Analyzer Error_Multi_GTN/EAN
                  → AI Error Analyzer_Händlerqualität
```
**Bedeutung:** Agents analysieren bereits behobene Fehler = SINNLOS

**Korrekt (PRE-FIX):**
```
Error Parser Schema → Error Router → AI Error Analyzer (PRE-FIX)
                                        ↓
                              Generate Fix
                                        ↓
                              Fix Nodes
```

#### Problem 2: Kreislauf
```
AI Error Analyzer → Fix Errors Router → AI Error Analyzer (LOOP!)
```

#### Problem 3: 7 Supabase RAG Contexts nicht verbunden
- Supabase RAG Context1-7 existieren
- Keine Connection zu Error Analyzer Agents
- Keine Embeddings aktiv

### Error-Typen
| Type | Agent | Fix Node |
|------|-------|----------|
| adult_error | AI Error Analyzer Adult Flags | Fix Adult |
| image_error | AI Error Analyzer Images | Fix image (adult) |
| text_error | AI Error Analyzer Text | Fix text |
| merchant_quality_error | AI Error Analyzer Merchant | Fix merchant |
| multi_country_error | AI Error Analyzer Error_Multi_Country | Fix Multi_Country |
| multi_gtn_ean_error | AI Error Analyzer Error_Multi_GTN/EAN | Fix Multi_GTN/EAN |
| haendlerqualitaet_error | AI Error Analyzer_Händlerqualität | Fix Multi_Händler_Qualität |

### Shops
- S24: SiliconeDolls24 (MerchantId: 5339977843)
- DDC: DreamDoll (MerchantId: 124485833)

## Skills erstellt

1. `.claude/skills/n8n-workflow-analyzer/SKILL.md`
2. `.claude/skills/n8n-error-handler/SKILL.md`
3. `.claude/skills/n8n-rag-optimizer/SKILL.md`
4. `.claude/skills/n8n-workflow-master/SKILL.md`

## Nächste Schritte

1. [ ] Fix Error-Routing Connections via n8n API
2. [ ] RAG Contexts mit Agents verbinden
3. [ ] Auf GitHub sichern
