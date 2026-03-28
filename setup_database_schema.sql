-- ============================================================================
-- n8n MechAnt Center - Komplettes Database Schema Setup
-- Erstellt: 2026-03-20
-- ============================================================================

-- ============================================================================
-- TEIL 1: POSTGRESQL MEMORY TABELLEN (für Chat History)
-- ============================================================================

-- Prüfen und hinzufügen: created_at, updated_at
ALTER TABLE merchant_center_brain_memory
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

ALTER TABLE product_agent_memory
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

-- Fehlende Memory Tabellen erstellen falls nicht vorhanden
CREATE TABLE IF NOT EXISTS error_agent_memory (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    message JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS optimizer_agent_memory (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    message JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS learning_agent_memory (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    message JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS merchant_gemini_decisions (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    message JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- TEIL 2: SUPABASE VECTOR TABELLEN (für RAG/Embeddings)
-- ============================================================================

-- Aktiviere pgvector Erweiterung
CREATE EXTENSION IF NOT EXISTS vector;

-- ============================================================================
-- merchant_knowledge_base (Für Knowledge Base)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_knowledge_base (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)  -- 1024 Dimensionen für Gemini
);

-- Index für Vektorsuche
CREATE INDEX IF NOT EXISTS idx_merchant_knowledge_base_embedding
ON merchant_knowledge_base USING ivfflat (embedding vector_cosine_ops);

-- ============================================================================
-- merchant_learnings (Für Learn & Store)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_learnings (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

CREATE INDEX IF NOT EXISTS idx_merchant_learnings_embedding
ON merchant_learnings USING ivfflat (embedding vector_cosine_ops);

-- ============================================================================
-- merchant_products (Für Produktdaten)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_products (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

CREATE INDEX IF NOT EXISTS idx_merchant_products_embedding
ON merchant_products USING ivfflat (embedding vector_cosine_ops);

-- ============================================================================
-- merchant_knowledge (Für Wissensdaten)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_knowledge (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

CREATE INDEX IF NOT EXISTS idx_merchant_knowledge_embedding
ON merchant_knowledge USING ivfflat (embedding vector_cosine_ops);

-- ============================================================================
-- merchant_errors (Für Error Tracking)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_errors (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

CREATE INDEX IF NOT EXISTS idx_merchant_errors_embedding
ON merchant_errors USING ivfflat (embedding vector_cosine_ops);

-- ============================================================================
-- merchant_optimization_patterns (Für Optimierungen)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_optimization_patterns (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

CREATE INDEX IF NOT EXISTS idx_merchant_optimization_patterns_embedding
ON merchant_optimization_patterns USING ivfflat (embedding vector_cosine_ops);

-- ============================================================================
-- merchant_settings (Für Einstellungen)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_settings (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

-- ============================================================================
-- merchant_rules (Für Regeln)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_rules (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

-- ============================================================================
-- country_settings (Für Ländereinstellungen)
-- ============================================================================
CREATE TABLE IF NOT EXISTS country_settings (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

-- ============================================================================
-- merchant_gemini_decisions (Für Entscheidungen)
-- ============================================================================
CREATE TABLE IF NOT EXISTS merchant_gemini_decisions (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    quelle TEXT,
    quelle_url TEXT,
    kategorie TEXT,
    unterkategorie TEXT,
    titel TEXT,
    beschreibung TEXT,
    chunk_id TEXT,
    document_id TEXT,
    file_type TEXT,
    file_name TEXT,
    file_size INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    embedding_model TEXT DEFAULT 'gemini-embedding-001',
    workflow_name TEXT,
    tags TEXT[],
    metadata TEXT,
    author TEXT,
    language TEXT DEFAULT 'de',
    status TEXT DEFAULT 'active',
    priority INTEGER DEFAULT 0,
    embedding vector(1024)
);

-- ============================================================================
-- ÜBERSICHT DER ERSTELLTEN TABELLEN
-- ============================================================================
-- \echo '============================================'
-- \echo 'FINAL TABLE LIST:'
-- \echo '============================================'
-- SELECT table_name FROM information_schema.tables
-- WHERE table_schema = 'public'
-- AND table_name LIKE 'merchant_%' OR table_name LIKE '%_agent_%'
-- ORDER BY table_name;
