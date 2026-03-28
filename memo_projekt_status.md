# MEMO: n8n MechAnt Center Projekt

**Stand:** 2026-03-19
**Server:** vmd188735.contaboserver.net
**Workflow-ID:** VtaFCvBxWmhMXjun

---

## 🔧 FIXES & ÄNDERUNGEN (NEU)

### 2026-03-19 - Supabase Database Problem behoben

**Problem:** Keine Daten in Supabase/Postgres
- 18 Memory/Vector Nodes im Workflow
- 0 Input Connections - Agenten wussten nicht dass sie Tools nutzen sollen

**Lösung:**
1. ✅ Agenten mit Supabase Vector Store Tools verbunden:
   - MERCHANT BRAIN: 9 Tools (4 Supabase hinzugefügt)
   - ERROR AGENT: 1 Tool (merchant error)
   - OPTIMIZER AGENT: 1 Tool (merchant_optimation_patterns)
   - PRODUCT AGENT: 1 Tool (product_agent_memory)
   - LEARNING AGENT: 1 Tool (merchant_gemini_decisons)

2. ✅ Supabase Tabellen identifiziert (müssen in Supabase existieren):
   - merchant_knowledge_base
   - merchant_learnings
   - merchant_errors
   - merchant_optimization_patterns
   - merchant_products
   - merchant_gemini_decisions
   - product_agent_memory
   - uvm.

3. ✅ Workflow hochgeladen

---

## 🗄️ SUPABASE DATABASE

### Tabellen im Workflow:
| Tabelle | Node |
|---------|------|
| merchant_knowledge_base | Knowledge Base (Supabase Vector) |
| merchant_learnings | Learn & Store, merchant_learning |
| merchant_errors | merchant error |
| merchant_optimization_patterns | merchant_optimation_patterns |
| merchant_products | merchant_products |
| merchant_gemini_decisions | merchant_gemini_decisons |
| product_agent_memory | product_agent_memory |

### Credentials:
- Supabase_Contabo_ServiceKey (ID: EXHihUhIMTMwIQ27)

---

## 🗄️ POSTGRES DATABASE

### Tabellen im Workflow:
| Tabelle | Node |
|---------|------|
| merchant_center_brain_memory | Brain Memory, Error Agent Memory, Optimizer Agent Memory, Learning Agent Memory |
| merchant_gemini_decisions | Decision History |

### Credentials:
- Postgres_Contabo_main_root_5432 (ID: 6uCnuKtYgvqnzdxA)

---

## 📋 WORKFLOWS

### 1. Haupt-Workflow (dieses Projekt)
- **Name:** ***MECHTECH_MERCHANT_CENTER_WEBFLOW_MCP
- **ID:** VtaFCvBxWmhMXjun
- **URL:** https://vmd188735.contaboserver.net/workflow/VtaFCvBxWmhMXjun
- **Status:** Active

### 2. OpenClaw mcporter Workflow
- **ID:** IwqaP1X2zx3qkZb2
- **Name:** ***MECHTECH_OPENCLAW_mcporter
- **URL:** https://vmd188735.contaboserver.net/workflow/IwqaP1X2zx3qkZb2

---

## 🔗 KOMMUNIKATION

### OpenClaw -> Merchant Center
- **Webhook:** `/webhook/openclaw-command`
- **URL:** https://vmd188735.contaboserver.net/webhook/openclaw-command
- **Payload:** `{"input": "befehl", "sessionId": "..."}`

### Merchant Center -> OpenClaw (OFFEN)
- **Problem:** Kein ausgehender Webhook konfiguriert
- **Möglichkeiten:**
  1. HTTP Request an externe URL
  2. Firestore Collection pollen
  3. Supabase Realtime

---

## 🤖 AGENTS (5)

| Agent | Iterations | Tools verbunden |
|-------|------------|----------------|
| MERCHANT BRAIN (AI Agent) | 10 | 73 |
| ERROR AGENT | 3 | 18 |
| OPTIMIZER AGENT | 4 | 28 |
| PRODUCT AGENT | 3 | 8 |
| LEARNING AGENT | 3 | 17 |

---

## 🛠️ TOOLS

### Google Sheets
- **Tool:** MERCHANT_OPTIMIERT (googleSheetsTool)
- **Sheet-ID:** 1Ic9WaLxBEExJc0_JXXsdfZS1yWQeKAJHM1DC_z_iBAg
- **Funktion:** Loggt Optimierungen ins Google Sheet
- **Spalten:** Datum, Produkt-ID, Agent, Aktion, Details, Status, Optimierungsart, Link, File ID, Verarbeitet am
- **Credentials:** ✅ Zugewiesen

### OpenClaw Tools (5 - verbunden mit MERCHANT BRAIN)
- sendToOpenClaw Tool
- sendStatusToOpenClaw Tool
- sendHeartbeatToOpenClaw Tool
- requestOpenClawAssistance Tool
- executeOpenClawCommand Tool

### Weitere Tools
- getTimestamp Tool (repariert)
- 30+ Merchant Center Tools

---

## 📁 FIRESTORE

### Datenbank: mechtech-merchantecenter

### Collections (6)
| Collection | Node | Status |
|------------|------|--------|
| openclawmerchant | openclawmerchant | ✅ |
| openclawskill | openclawskill | ✅ |
| openclawskillcategorie | openclawskillcategorie | ✅ |
| openclawpendingskillfetch | openclawpendingskillfetch | ✅ |
| openclawskillexecution | openclawskillexecution | ✅ |
| (dynamisch) | Create or update a document | ✅ |

### Projekt-ID: mechtech-merchantecenter

---

## 🔧 FIXES & ÄNDERUNGEN

### Erledigt:
1. ✅ Chat Trigger -> Prepare Schedule Input verbunden
2. ✅ OpenClaw Command Webhook verbunden
3. ✅ MERCHANT BRAIN -> Google Sheets Tool (MERCHANT_OPTIMIERT)
4. ✅ MERCHANT BRAIN Iterations: 3 -> 10
5. ✅ getTimestamp Tool Code repariert (return statement)
6. ✅ Firestore Collection-Namen repariert ($fromAI Fehler)
7. ✅ OpenClaw Tools mit MERCHANT BRAIN verbunden
8. ✅ OpenClaw Response Webhook mit MERCHANT BRAIN verbunden
9. ✅ Firestore Nodes Collection-Namen korrigiert

### Offene Punkte:
- ⏳ OpenClaw Response Callback URL fehlt
- ⏳ Credentials für einige Firestore Nodes prüfen

---

## 📊 GOOGLE SHEET

**URL:** https://docs.google.com/spreadsheets/d/1Ic9WaLxBEExJc0_JXXsdfZS1yWQeKAJHM1DC_z_iBAg/edit

**Spalten:**
- 📅 Datum
- 🆔 File ID
- 📝 Produkt-ID
- 🏢 Agent
- 📄 Aktion
- 💰 Details
- 🔢 Status
- 📂 Optimierungsart
- 🔗 Link
- ⏰ Verarbeitet am
- 🎯 Confidence
- ⚠️ Review
- ✅ BUCHEN
- 🚀 SOFORT
- ✔️ Gebucht am
- 📝 Notizen

---

## 🔑 API KEYS

### n8n API (Contabo)
- Bearer Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
- X-N8N-API-KEY: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

### MCP Server
- Server: http://62.171.136.239:5678/mcp-server/http
- Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

---

## 📝 BEFEHLE

### Per Webhook:
```bash
curl -X POST https://vmd188735.contaboserver.net/webhook/openclaw-command \
  -H "Content-Type: application/json" \
  -d '{"input": "optimiere produkte", "sessionId": "test"}'
```

### Per Chat im n8n:
- "optimiere produkte"
- "pruefe fehler"
- "synchronisiere produkte"

---

## ⚠️ WICHTIGE NOTIZEN

1. **Response-Problem:** Der Workflow sendet keine Antwort an OpenClaw. Es fehlt ein ausgehender HTTP Request Node oder OpenClaw muss Firestore pollen.

2. **Schedule Trigger:** Läuft alle 5 Minuten (deaktiviert?)

3. **Token:** API-Keys sind temporär - müssen evtl. erneuert werden

---

## 📅 ZUR FORTSETZUNG

Nach Neustart:
1. Workflow im Editor öffnen
2. Credentials prüfen
3. Testen mit: `curl -X POST https://vmd188735.contaboserver.net/webhook/openclaw-command -H "Content-Type: application/json" -d '{"input": "status", "sessionId": "test"}'`

---

**Erstellt:** 2026-03-17
