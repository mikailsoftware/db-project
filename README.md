# BLP 1005 Ödev Çalışmaları

Bu repo, Veritabanı Yönetim Sistemleri dersindeki ödevlerim için. Şu an içinde Ödev 1'in 1-4. bölümleri var.

**Öğrenci:** Mikail Furkan Toprak  
**Program:** Yapay Zeka Operatörlüğü  
**Ders:** BLP 1005, Güz 2026-2027

## Ödev 1

- `bolum1.py`: algoritma ve izleme soruları
- `bolum2.md`: veritabanı kavramları
- `bolum3.sql`: SELECT ve WHERE soruları
- `bolum4.sql`: gruplama ve NULL soruları
- `rapor.md`: ödev raporu

Bu çalışmada önce bir listedeki sayıları takip edip grupladım. Sonra veritabanı kavramlarını yazıp `llm_calls` tablosundan koşula uyan kayıtları seçtim ve sonuçları gruplara ayırdım.

## Kullanılan örnek veri

SQL sorularında dersin `llm_ops` örnek veritabanını kullandım. Dosya, [ders reposundaki örnek veriden](https://github.com/gizemturker/blp105-course/blob/main/data/llm_ops.sql) alınmıştır. Veriler kurgusaldır; `llm_calls` tablosunda 12 çağrı, `model_catalog` tablosunda 7 model bulunur. Bir çağrının maliyeti ve başka bir çağrının kullanıcı adı boştur.

## Tablolar

```text
model_catalog
  model_name (primary key), provider, price_per_1k_usd, context_window

llm_calls
  id (primary key), model_name, user_name, task_type,
  prompt_tokens, completion_tokens, latency_ms, cost_usd, created_at
```

## Çalıştırma

PostgreSQL kurulu bir bilgisayarda, repo klasöründe:

```bash
createdb llm_ops
psql -d llm_ops -f data/seed/llm_ops.sql
psql -d llm_ops -f odevler/odev-01/bolum3.sql
psql -d llm_ops -f odevler/odev-01/bolum4.sql
```

Python soruları için:

```bash
python odevler/odev-01/bolum1.py
```

Seed dosyası tabloları baştan oluşturur. Yeniden çalıştırılırsa mevcut örnek tablolar sıfırlanır.

## Bir sorgu örneği

```sql
SELECT id, latency_ms
FROM llm_calls
WHERE latency_ms > 2000;
```

Bu sorgu 2 saniyeden uzun süren 5 çağrıyı bulur. Gruplama sorularında da her iş türündeki çağrıları saydım; örneğin `chat` ve `summarize` türlerinde 3'er kayıt var.

## Yapay zeka kullanımı

Ödev 1'de Copilot'tan bazı SQL koşullarını ve açıklamaları anlamak için yardım aldım. Ayrıntısını `odevler/odev-01/rapor.md` dosyasına yazdım.

## Sonraki ödevler

Yeni ödev dosyalarını `odevler/odev-NN/` klasörüne ekleyeceğim. Dönem projesinin senaryosu belli olunca `SCENARIO.md` dosyasını dolduracağım.
