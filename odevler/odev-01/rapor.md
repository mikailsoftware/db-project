# Ödev 1 Raporu

**Hafta:** 4 ve 5  
**Ad Soyad:** Mikail Furkan Toprak  
**Öğrenci No:** 202607131002  
**Program:** Yapay Zeka Operatörlüğü  
**Veritabanı:** `llm_ops`  
**PR bağlantısı:** Henüz açmadım.

# Ne yaptım

Hafta 4'te çağrıları farklı koşullara göre listeleyip sıraladım. Hafta 5'te çağrı sayılarını ve ortalamaları buldum. Boş değerlerin sonuçları nasıl değiştirdiğini de gördüm.

# Dikkatimi çeken sonuçlar

Parantezli ve parantezsiz sorguların ikisi de 3 satır verdi. Bu veride kod çağrılarının maliyeti zaten 0.01 dolardan fazla olduğu için sonuç değişmedi. `mini` aramasında 1 sonuç beklerken 3 sonuç geldi; `gemini-flash` ve `gemini-pro` adlarında da bu harfler geçiyormuş. Boş faturayı ortalamada sıfır sayınca sonuç 0.005258, boş değeri hesaba katmayınca 0.005736 dolar çıktı. Fatura bilgisini bilmediğimiz için onu sıfır kabul etmemek daha doğru geldi.

Türkçe sıralama denememde isimlerin yeri değişmedi. Maliyeti 0.01 doların altındaki ve 0.01 dolar veya üstündeki kayıtları sayınca toplam 11 kayıt çıktı. Faturası boş olan 11 numaralı çağrı iki koşula da girmedi; bu yüzden toplam kayıt sayısına ulaşamadım.

# Hata ve çözümü

PostgreSQL'i kurarken “Database Cluster Initialization Failed” hatası aldım. Kurulumdaki Locale ayarını Default yerine English (United States) seçince kurulum tamamlandı.

# Yapay zeka kullanımı

Copilot'tan özellikle Hafta 5, Soru 13'te `COALESCE` kullanınca ortalamanın neden değiştiği ve bu veri için hangi ortalamanın daha uygun olduğu hakkında yardım aldım. Ayrıca VS Code'daki Black Formatter ile Python dosyamı düzenli biçimlendirdim ve Pylance'ın kod önerilerinden yararlandım. Sorguları örnek veritabanında çalıştırıp sonuçları kontrol ettim.

# Bana sorun

`NULL` değerlerin neden normal eşitlik ya da büyüklük koşullarıyla bulunamadığını derste tekrar görmek isterim.