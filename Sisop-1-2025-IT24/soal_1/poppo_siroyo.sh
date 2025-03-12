#a
wget https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download -O reading_data.csv

awk -F, '{
        if ($2 == "Chris Hemsworth") {
            count++
        } else {
            count=count
        }
    }
    END {
        print "Chris Hemsworth membaca", count, "buku.";
    }
' reading_data.csv

#b
awk -F, '{if ($8 == "Tablet") total += $6; count++} END {print "Rata-rata durasi membaca dengan Tablet adalah", total/count, "menit."}' reading_data.csv

#c


#d
awk -F, '$9 ~ /Asia/ && $5 > "2023-12-31" {genre[$4]++} 
END {
 max_count = 0;
 for (g in genre) {
 if (genre[g] > max_count) {
    max_count = genre[g];
    popular_genre = g;
    }
}
print "Genre paling populer di Asia setelah 2023 adalah", popular_genre, "dengan", max_count, "buku.";}' reading_data.csv
