-- =====================================================================
-- llm_ops — Yapay Zeka Operatörlüğü programı için örnek veritabanı
-- BLP 105 / BLP 1005 Veritabanı Yönetim Sistemleri
--
-- Kurulum:  psql -d llm_ops -f llm_ops.sql
-- Bu dosya her çalıştırıldığında tabloları sıfırlar ve baştan doldurur.
-- Model adları gerçektir, fiyat ve gecikme değerleri kurgusaldır:
-- gerçek fiyat listesi olarak kullanmayın.
-- =====================================================================

DROP TABLE IF EXISTS llm_calls;
DROP TABLE IF EXISTS model_catalog;

-- Model kataloğu. Birincil anahtar model adının kendisi (natural key).
-- Hafta 7'de bu tercihin artılarını ve eksilerini tartışacağız.
CREATE TABLE model_catalog (
  model_name        text PRIMARY KEY,
  provider          text,
  price_per_1k_usd  numeric(8,5),
  context_window    integer
);

CREATE TABLE llm_calls (
  id                integer PRIMARY KEY,
  model_name        text,
  user_name         text,
  task_type         text,
  prompt_tokens     integer,
  completion_tokens integer,
  latency_ms        integer,
  cost_usd          numeric(8,4),
  created_at        timestamptz
);

-- Dikkat: katalogda 'gemini-pro' YOK, ama 10 numaralı çağrı onu kullanmış.
-- Katalogdaki 'mistral-large' ise hiç çağrılmamış.
-- Hafta 6'da INNER JOIN ile LEFT JOIN farkını bu iki satır gösterecek.
INSERT INTO model_catalog (model_name, provider, price_per_1k_usd, context_window) VALUES
  ('gpt-4o',        'OpenAI',    0.01000, 128000),
  ('gpt-4o-mini',   'OpenAI',    0.00060, 128000),
  ('claude-sonnet', 'Anthropic', 0.00900, 200000),
  ('claude-haiku',  'Anthropic', 0.00080, 200000),
  ('llama-3-8b',    'Meta',      0.00020,   8192),
  ('gemini-flash',  'Google',    0.00035, 100000),
  ('mistral-large', 'Mistral',   0.00600,  32000);  -- hiç çağrılmadı

-- Dikkat: 11 numaralı çağrının maliyeti boş (fatura gelmedi),
-- 12 numaralı çağrının kullanıcısı boş (anonim test betiği).
-- Bu boşluklar Hafta 5'teki NULL konusunun örnekleridir.
INSERT INTO llm_calls (id, model_name, user_name, task_type, prompt_tokens, completion_tokens, latency_ms, cost_usd, created_at) VALUES
  (1,  'gpt-4o',        'Ece',   'summarize',  820,  210, 2600, 0.0065, '2026-10-08 09:12+03'),
  (2,  'claude-sonnet', 'Oğuz',  'code',      1500,  640, 3200, 0.0141, '2026-10-12 14:05+03'),
  (3,  'llama-3-8b',    'Ece',   'classify',   300,   12,  380, 0.0002, '2026-10-13 10:30+03'),
  (4,  'gpt-4o',        'Mert',  'translate',  950,  900, 2750, 0.0114, '2026-10-14 11:47+03'),
  (5,  'claude-haiku',  'Selin', 'summarize', 1200,  180,  900, 0.0010, '2026-10-14 16:20+03'),
  (6,  'gemini-flash',  'Oğuz',  'chat',       400,  350, 1100, 0.0003, '2026-10-15 08:55+03'),
  (7,  'claude-sonnet', 'Ece',   'code',      2100, 1200, 4100, 0.0243, '2026-10-15 13:10+03'),
  (8,  'llama-3-8b',    'Selin', 'chat',       250,  300, 2300, 0.0002, '2026-10-16 09:40+03'),
  (9,  'gpt-4o-mini',   'Mert',  'classify',   500,    8,  450, 0.0001, '2026-10-16 10:15+03'),
  (10, 'gemini-pro',    'Deniz', 'translate',  700,  650, 1900, 0.0042, '2026-10-16 12:00+03'),
  (11, 'gpt-4o',        'Deniz', 'summarize',  600,  150, 1800, NULL,   '2026-10-16 13:30+03'),
  (12, 'claude-haiku',  NULL,    'chat',       300,  120,  700, 0.0008, '2026-10-16 14:10+03');
