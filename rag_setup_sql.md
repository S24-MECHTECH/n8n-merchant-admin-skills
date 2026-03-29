# RAG Setup für n8n GMC Workflow

## Schritt 1: Supabase Tables erstellen

Führe folgendes SQL im **Supabase Dashboard → SQL Editor** aus:

```sql
-- Enable vector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Error Tables für RAG erstellen
CREATE TABLE merchant_errors_adult (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_type TEXT DEFAULT 'adult_error',
  title TEXT,
  description TEXT,
  solution TEXT,
  example_product_id TEXT,
  embedding vector(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE merchant_errors_images (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_type TEXT DEFAULT 'image_error',
  title TEXT,
  description TEXT,
  solution TEXT,
  example_product_id TEXT,
  embedding vector(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE merchant_errors_text (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_type TEXT DEFAULT 'text_error',
  title TEXT,
  description TEXT,
  solution TEXT,
  example_product_id TEXT,
  embedding vector(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE merchant_errors_merchant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_type TEXT DEFAULT 'merchant_quality_error',
  title TEXT,
  description TEXT,
  solution TEXT,
  example_product_id TEXT,
  embedding vector(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE merchant_errors_country (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_type TEXT DEFAULT 'multi_country_error',
  title TEXT,
  description TEXT,
  solution TEXT,
  example_product_id TEXT,
  embedding vector(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE merchant_errors_gtin (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_type TEXT DEFAULT 'multi_gtn_ean_error',
  title TEXT,
  description TEXT,
  solution TEXT,
  example_product_id TEXT,
  embedding vector(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE merchant_errors_haendler (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_type TEXT DEFAULT 'haendlerqualitaet_error',
  title TEXT,
  description TEXT,
  solution TEXT,
  example_product_id TEXT,
  embedding vector(1536),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

## Schritt 2: Sample Embeddings einfügen

```sql
-- Adult Errors
INSERT INTO merchant_errors_adult (title, description, solution, embedding)
VALUES (
  'Incorrect Adult Flag',
  'Product incorrectly marked as adult content',
  'Review product categorization and remove adult flag if inappropriate. Check product images and descriptions.',
  '[0.0]'  -- Replace with actual embedding from Gemini
);

-- Weitere Beispiele...
```

## Schritt 3: n8n Workflow - RAG Nodes erstellen

Im n8n Editor nach dem SQL Setup:

1. **Supabase Vector Store Nodes erstellen** (einen pro Error-Typ):
   - Name: `Supabase RAG Adult`
   - Type: `@n8n/n8n-nodes-langchain.vectorStoreSupabase`
   - Table: `merchant_errors_adult`

2. **Embeddings Nodes erstellen**:
   - Name: `Embeddings Adult`
   - Type: `@n8n/n8n-nodes-langchain.embeddingsGoogleGemini`

3. **Error Analyzer Agents mit Tools verbinden**:
   - AI Error Analyzer Adult Flags → Tools → Supabase RAG Adult

## Error Types → Tables Mapping

| Error Type | Table |
|------------|-------|
| adult_error | merchant_errors_adult |
| image_error | merchant_errors_images |
| text_error | merchant_errors_text |
| merchant_quality_error | merchant_errors_merchant |
| multi_country_error | merchant_errors_country |
| multi_gtn_ean_error | merchant_errors_gtin |
| haendlerqualitaet_error | merchant_errors_haendler |

## Verification

Nach Setup, prüfe mit:
```sql
SELECT * FROM merchant_errors_adult LIMIT 5;
```
