# Ödev 1 - Bölüm 1

# Soru 1.1 izleme tablosu
# i | total | result
# 0 | 4     | []
# 1 | 4     | [7]
# 2 | 6     | [7]
# 3 | 6     | [7, 9]
# 4 | 6     | [7, 9, 5]
# 5 | 6     | [7, 9, 5, 1]
# 6 | 14    | [7, 9, 5, 1]

numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print("Soru 1.1")
print(total)
print(result)
# Tahminim doğru çıktı.

# Soru 1.2 sözde kod
# Sayı eşiği geçerse sayacı artır.
# Geçmezse sayacı sıfırla.
# En büyük sayacı sakla.

readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22
longest = 0
current = 0

for value in readings:
    if value > threshold:
        current = current + 1
        if current > longest:
            longest = current
    else:
        current = 0

print("Soru 1.2")
print(longest)
# En uzun seri 5.

# Soru 1.3
records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]

counts = {}

for record in records:
    course = record["course"]
    if course in counts:
        counts[course] = counts[course] + 1
    else:
        counts[course] = 1

print("Soru 1.3")
print(counts)
# Her dersin kaydını sayınca GROUP BY gibi gruplanmış oluyor.
