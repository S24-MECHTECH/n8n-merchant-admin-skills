# n8n Merchant Admin Skill

## Overview

Dieser Skill ist ein **Master-Koordinationsskill** für den n8n Google Merchant Center Admin Workflow (M3Nvfaji6B8WdpWI).

**Besonderheit**: Dies ist eine alternative Bauweise zum ersten Merchant Center Workflow - mit separaten Error-Analyzer Agents für verschiedene Fehlertypen.

## Workflow-Info

| Property | Wert |
|----------|------|
| Workflow ID | M3Nvfaji6B8WdpWI |
| Workflow Name | ***MECHTECH_MERCHANT_CENTER_ADMIN |
| Server | vmd188735.contaboserver.net |
| Port | 5678 (n8n) |

## Bekannte Probleme (zu beheben)

1. **Daten werden nicht richtig geroutet** - Routing unterbrochen
2. **Error-Agenten bekommen keine Daten** - RAG Contexts nicht verbunden!
3. **Agenten können nicht aktiv mithelfen** - Keine Datenverbindung

## Configuration

### Trigger (4 Stück)

| Trigger | Typ |
|---------|-----|
| Chat Trigger (RAG Query) | Chat |
| Schedule Trigger | Zeitbasiert |
| Email Trigger (IMAP) | Email |
| Manual Trigger | Manuell |

### Error Analyzer Agents (6 Stück!)

| Agent | Spezialisierung | Problem |
|-------|-----------------|---------|
| AI Error Analyzer Adult Flags | Adult-Flag Fehler | Keine Daten! |
| AI Error Analyzer Images | Bildfehler | Keine Daten! |
| AI Error Analyzer Text | Textfehler | Keine Daten! |
| AI Error Analyzer Merchant | Händlerqualität | Keine Daten! |
| AI Error Analyzer Error_Multi_Country | Länder-Fehler | Keine Daten! |
| AI Error Analyzer Error_Multi_GTN/EAN | GTIN/EAN Fehler | Keine Daten! |

### Weitere Agenten

| Agent | Funktion |
|-------|----------|
| Chat Agent (RAG) | RAG-basierte Queries |
| Process Instructions with Gemini | Anweisungen verarbeiten |
| Gemini Daily Decision | Tägliche Entscheidungen |
| Find Missing GTIN | Fehlende GTINs finden |
| Error_Ana_S24 | S24-Fehler |
| Error_Ana_DDC | DDC-Fehler |

### Supabase RAG Contexts (7 Stück!)

| Context | Status |
|---------|--------|
| Supabase RAG Context1 | ❌ Nicht verbunden |
| Supabase RAG Context2 | ❌ Nicht verbunden |
| Supabase RAG Context3 | ❌ Nicht verbunden |
| Supabase RAG Context4 | ❌ Nicht verbunden |
| Supabase RAG Context5 | ❌ Nicht verbunden |
| Supabase RAG Context6 | ❌ Nicht verbunden |
| Supabase RAG Context7 | ❌ Nicht verbunden |

### Router & Switches

| Node | Funktion |
|------|----------|
| Route Command | Befehls-Routing |
| Route by Priority | Prioritäts-Routing |
| Error Router | Fehler-Routing |
| Fix Errors Router | Fix-Routing |
| Route: GTIN Lookup Needed? | GTIN-Routing |

### Externe Tools

| Tool | Funktion |
|------|----------|
| MCP Client (6+) | Externe Verbindungen |
| Google Sheets | Logging |
| Gmail | Reports senden |
| Telegram | Daily Reports |
| WhatsApp | Expert Alerts |
| Supabase | Datenbank |

## Auto-Invoked Skills

Dieser Skill löst automatisch passende Skills aus:

### 1. feature-dev (Automatisch bei: Komplexe Aufgaben)
**Wann**: Neue Features, größere Änderungen

### 2. code-explorer (Automatisch bei: Code-Analyse)
**Wann**: Workflow-Struktur verstehen

### 3. code-reviewer (Automatisch bei: Qualitätsprüfung)
**Wann**: Nach Änderungen

### 4. superpowers (Automatisch bei: Multi-Agent)
**Wann**: Multiple Agenten koordinieren

### 5. playwright (Automatisch bei: Browser-Tests)
**Wann**: n8n UI Tests

### 6. firecrawl (Automatisch bei: Recherche)
**Wann**: Google-Merchant-Recherche

## Problem-Behebung (Hauptfunktionen)

### 1. Daten-Routing Fix
**Problem**: Daten werden nicht richtig geroutet

**Lösung**:
- Router-Nodes analysieren
- Datenfluss prüfen
- Fehlende Verbindungen herstellen
- Switch-Cases validieren

```bash
/merchant-admin-analyze-routing
/fixe datenfluss
/verbinde router
```

### 2. Error-Agenten Datenverbindung
**Problem**: 6 Error-Agenten bekommen keine Daten

**Lösung**:
- Supabase RAG Contexts mit Agenten verbinden
- Datenquellen identifizieren
- Input-Datenfluss herstellen
- Testen mit Beispieldaten

```bash
/verbinde error agenten
/pruefe rag verbindungen
/teste datenfluss agenten
```

### 3. Zentrale Datenquelle einrichten
**Problem**: Keine zentrale Datenquelle

**Lösung**:
- Master-Datenquelle etablieren
- Supabase als zentrale DB nutzen
- Daten bei Bedarf verteilen

```bash
/richte zentrale datenquelle ein
/verbinde supabase
```

### 4. RAG Contexts aktivieren
**Problem**: 7 RAG Contexts nicht verbunden

**Lösung**:
- Jeden RAG Context prüfen
- Mit passenden Agenten verbinden
- Embedding-Generierung aktivieren
- Testen

```bash
/aktiiviere rag contexts
/pruefe embeddings
```

## Hauptfunktionen

### Produkt-Optimierung
- Update Product Adult Flag
- Update Product Images
- Update Product Text
- Update Merchant Settings
- Update Country Feeds

### Multi-Country Support
- Multi-Country Loop
- Country-Feed Updates
- Länder-spezifische Fehler

### GTIN/EAN Support
- GTIN-Lookup
- EAN-Validierung
- Fehlende GTINs finden

### Learning & Adaptation
- Process Instructions with Gemini
- Update Optimization Patterns
- Apply to Similar Products

### Monitoring & Reporting
- Log Results to Sheets
- Send Daily Report (Telegram)
- Export Report to Gmail
- Send WhatsApp Expert Alert

## Verfügbare Befehle

| Befehl | Beschreibung |
|--------|--------------|
| `/merchant-admin-analyze` | Analysiere Workflow |
| `/merchant-admin-fix-routing` | Behebe Routing-Probleme |
| `/merchant-admin-fix-agents` | Verbinde Error-Agenten |
| `/merchant-admin-fix-rag` | Aktiviere RAG Contexts |
| `/merchant-admin-full-fix` | Alle Probleme beheben |

## Auto-Trigger Regeln

| Erkannter Kontext | Auto-Trigger |
|-------------------|--------------|
| "routing", "daten", "fluss" | feature-dev + code-explorer |
| "error agent", "keine daten" | superpowers + code-reviewer |
| "rag", "context", "nicht verbunden" | code-explorer + playwright |
| "supabase", "verbindung" | firecrawl + code-reviewer |

## Unterschied zum ersten Merchant Center Workflow

| Aspekt | Merchant Center (VtaFCvBxWmhMXjun) | Merchant Admin (M3Nvfaji6B8WdpWI) |
|--------|-----------------------------------|-----------------------------------|
| Error-Handling | 1 Agent (ERROR AGENT) | 6 separate Error Analyzer Agents |
| Architektur | Zentraler MERCHANT BRAIN | Verteilte Agenten |
| RAG | Vector Stores | Supabase RAG Contexts |
| Komplexität | Mittel | Hoch |

## Requirements

- n8n Zugriff (vmd188735.contaboserver.net)
- PostgreSQL Zugang
- Supabase Zugang
- Google Cloud (Sheets, Gmail, Firebase)
- Telegram/WhatsApp Credentials

## Usage Examples

- "Analysiere das Routing im Admin Workflow"
- "Verbinde die Error-Agenten mit Daten"
- "Aktiviere alle RAG Contexts"
- "Behebe alle Probleme"