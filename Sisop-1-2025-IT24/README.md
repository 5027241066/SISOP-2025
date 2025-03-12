# Soal 1
Membuat file poppo_siroyo.sh
```
touch poppo_siroyo.sh
```
Menginstall file reading_data.csv
```
wget "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O reading_data.csv
```
### a.
Menggunakan awk untuk mencari “Chris Hemsworth” dan menghitung buku yang dibacanya
```
awk -F, '{
        if ($2 == "Chris Hemsworth") {
            count++
        } else {
            count=count
        }
    }
    END {print "Chris Hemsworth membaca", count, "buku.";}' reading_data.csv
```
Mencari "Chris Hemsworth" di column 2 kemudian menghitung berapa kali nama tersebut muncul untuk mengetahui berapa buku yang telah dibaca.
Setelah berhasil dijalankan kemudian code tersebut dimasukkan ke poppo_siroyo.sh
```
nano poppo_siroyo.sh
```

### b.
Menghitung rata-rata pembaca buku yang menggunakan media tablet
Diketahui Device terdapat pada column H/8 dan Reading Duration pada column F/6
```
awk -F, '{if ($8 == "Tablet") total += $6; count++} END {print "Rata-rata durasi membaca dengan Tablet adalah", total/count, "menit."}' reading_data.csv
```
