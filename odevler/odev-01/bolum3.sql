-- Hafta 4: SELECT ve WHERE
-- Yapay Zeka Operatörlüğü - llm_ops

-- Soru 1: Bütün çağrıların id'si ve model adı
SELECT id, model_name
FROM llm_calls;
-- 12 satır döndü.

-- Soru 2: Model adı ve toplam token sayısı
SELECT model_name AS model,
       prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;
-- 12 satır döndü.

-- Soru 3: 2 saniyeyi aşan çağrılar
SELECT id, latency_ms
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 satır döndü.

-- Soru 4: Ece'nin yaptığı çağrılar
SELECT id, user_name, model_name
FROM llm_calls
WHERE user_name = 'Ece';
-- 3 satır döndü.

-- Soru 5: Chat dışındaki çağrılar
SELECT id, task_type
FROM llm_calls
WHERE task_type <> 'chat';
-- 9 satır döndü.

-- Soru 6: Claude modellerine yapılan ve 1 saniyeden yavaş çağrılar
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE model_name LIKE 'claude%'
  AND latency_ms > 1000;
-- 2 satır döndü.

-- Soru 7: Kod veya çeviri işi olan, maliyeti 0.01 doları aşan çağrılar
SELECT id, task_type, cost_usd
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate')
  AND cost_usd > 0.01;
-- 3 satır döndü.

-- Soru 7 parantezsiz deneme
SELECT id, task_type, cost_usd
FROM llm_calls
WHERE task_type = 'code'
   OR task_type = 'translate' AND cost_usd > 0.01;
-- 3 satır döndü; parantezli sorguyla fark olmadı.

-- Soru 8: Gecikmesi 500 ile 1500 ms arasındaki çağrılar
SELECT id, latency_ms
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
-- 3 satır döndü.

-- Soru 9: GPT-4o modellerine yapılan çağrılar
SELECT id, model_name
FROM llm_calls
WHERE model_name IN ('gpt-4o', 'gpt-4o-mini');
-- 4 satır döndü.

-- Soru 10: Model adında mini geçen çağrılar
SELECT id, model_name
FROM llm_calls
WHERE model_name ILIKE '%mini%';
-- 3 satır döndü; gemini adlarında da mini harfleri geçiyor.

-- Soru 11: Önce kullanıcıya, sonra maliyete göre sırala
SELECT id, user_name, cost_usd
FROM llm_calls
ORDER BY user_name, cost_usd DESC NULLS LAST;
-- 12 satır döndü.

-- Soru 12: En pahalı 3 çağrı
SELECT id, model_name, cost_usd
FROM llm_calls
WHERE cost_usd IS NOT NULL
ORDER BY cost_usd DESC
LIMIT 3;
-- 3 satır döndü.

-- Soru 13: Çağrıların iş türleri
SELECT DISTINCT task_type
FROM llm_calls
ORDER BY task_type;
-- 5 satır döndü.

-- Soru 14: Kullanıcı adlarını varsayılan sıralamayla listele
SELECT DISTINCT user_name
FROM llm_calls
ORDER BY user_name;
-- 6 satır döndü (boş kullanıcı adı da listede).

-- Soru 14: Kullanıcı adlarını Türkçe sıralamayla listele
SELECT DISTINCT user_name COLLATE "tr-TR-x-icu" AS user_name
FROM llm_calls
ORDER BY user_name;
-- 6 satır döndü; bu veri için isim sırası değişmedi.

-- Soru 15: 14 Ekim'den sonra, 1 saniyeden yavaş çağrılar
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at >= TIMESTAMPTZ '2026-10-15 00:00:00+03'
  AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- 5 satır döndü.
