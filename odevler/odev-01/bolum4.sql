-- Hafta 5: Gruplama ve NULL
-- Yapay Zeka Operatörlüğü - llm_ops

-- Soru 1: Toplam çağrı sayısı
SELECT count(*) AS cagri_sayisi
FROM llm_calls;
-- 12 çağrı var.

-- Soru 2: 2 saniyeden yavaş çağrı sayısı
SELECT count(*) AS yavas_cagri_sayisi
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 çağrı 2 saniyeden yavaş.

-- Soru 3: Toplam maliyet ve token sayısı
SELECT sum(cost_usd) AS toplam_maliyet,
       sum(prompt_tokens + completion_tokens) AS toplam_token
FROM llm_calls;
-- Maliyet 0.0631 dolar, toplam token sayısı 14340.

-- Soru 4: Ortalama gecikme
SELECT round(avg(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls;
-- Ortalama gecikme 1848.3 ms.

-- Soru 5: En hızlı ve en yavaş çağrı
SELECT min(latency_ms) AS en_hizli_ms,
       max(latency_ms) AS en_yavas_ms
FROM llm_calls;
-- En hızlı çağrı 380 ms, en yavaş çağrı 4100 ms.

-- Soru 6: Her iş türündeki çağrı sayısı
SELECT task_type, count(*) AS cagri_sayisi
FROM llm_calls
GROUP BY task_type
ORDER BY task_type;
-- 5 satır döndü; her satır bir iş türünü gösteriyor.

-- Soru 7: Model başına çağrı sayısı ve toplam maliyet
SELECT model_name, count(*) AS cagri_sayisi,
       sum(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY model_name
ORDER BY toplam_maliyet DESC;
-- 7 satır döndü; claude-sonnet toplam maliyeti en yüksek model.

-- Soru 8: Kullanıcı ve iş türü başına çağrı sayısı
SELECT user_name, task_type, count(*) AS cagri_sayisi
FROM llm_calls
GROUP BY user_name, task_type
ORDER BY user_name, task_type;
-- 12 satır döndü; anonim çağrının kullanıcı adı boş görünüyor.

-- Soru 9: İkiden fazla çağrı alan modeller
SELECT model_name, count(*) AS cagri_sayisi
FROM llm_calls
GROUP BY model_name
HAVING count(*) > 2;
-- 1 satır döndü; sadece gpt-4o ikiden fazla çağrı aldı.

-- Soru 10: Önce 500 ms'den yavaş çağrıları seç, sonra en az 2 çağrısı olan modeller
SELECT model_name, count(*) AS cagri_sayisi,
       round(avg(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING count(*) >= 2;
-- 3 satır döndü; WHERE hızlı çağrıları, HAVING az çağrısı olan modelleri eledi.

-- Soru 11: llm_calls tablosundaki dolu değer sayıları
SELECT count(*) AS satir_sayisi,
       count(id) AS id_dolu,
       count(model_name) AS model_dolu,
       count(user_name) AS kullanici_dolu,
       count(task_type) AS is_turu_dolu,
       count(prompt_tokens) AS prompt_dolu,
       count(completion_tokens) AS completion_dolu,
       count(latency_ms) AS gecikme_dolu,
       count(cost_usd) AS maliyet_dolu,
       count(created_at) AS tarih_dolu
FROM llm_calls;
-- 12 satır var; kullanıcı adı ve maliyet sütunlarında birer eksik değer var.

-- Soru 12: NULL değerini eşittir ile arama denemesi
SELECT id, cost_usd
FROM llm_calls
WHERE cost_usd = NULL;
-- 0 satır döndü; NULL eşitlik ile bulunmuyor.

-- Soru 12: Faturası gelmeyen çağrı
SELECT id, model_name, cost_usd
FROM llm_calls
WHERE cost_usd IS NULL;
-- 1 satır döndü; 11 numaralı çağrının faturası eksik.

-- Soru 12: 0.01 dolardan az maliyetli çağrılar
SELECT count(*) AS cagri_sayisi
FROM llm_calls
WHERE cost_usd < 0.01;
-- 8 çağrı döndü.

-- Soru 12: 0.01 dolar veya daha fazla maliyetli çağrılar
SELECT count(*) AS cagri_sayisi
FROM llm_calls
WHERE cost_usd >= 0.01;
-- 3 çağrı döndü; bu iki sonuçta 11 numaralı faturası eksik çağrı yok.

-- Soru 13: Eksik maliyeti atlayarak ve sıfır sayarak ortalama
SELECT round(avg(cost_usd), 6) AS boslari_atla,
       round(avg(coalesce(cost_usd, 0)), 6) AS bosu_sifir_say
FROM llm_calls;
-- Sonuçlar 0.005736 ve 0.005258 dolar; fark 0.000478 dolar.
-- Fatura bilinmediği için sıfır saymak yerine ilk ortalama daha uygun.

-- Soru 14: Günlük çağrı sayısı ve toplam maliyet
SELECT created_at::date AS gun, count(*) AS cagri_sayisi,
       sum(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY created_at::date
ORDER BY gun;
-- 6 satır döndü; 16 Ekim en çok çağrı olan gün, eksik fatura toplamı düşürüyor.

-- Soru 15: Çağrıları gecikme aralığına göre say
SELECT CASE
         WHEN latency_ms < 1000 THEN 'Hizli'
         WHEN latency_ms < 2500 THEN 'Orta'
         ELSE 'Yavas'
       END AS gecikme_grubu,
       count(*) AS cagri_sayisi,
       round(avg(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls
GROUP BY gecikme_grubu
ORDER BY gecikme_grubu;
-- 3 satır döndü; her grupta 4 çağrı var.
