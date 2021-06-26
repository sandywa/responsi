opts = detectImportOptions('Realestatevaluationdataset.xlsx'); %Mengambil File Realestatevaluationdataset.xlsx
opts.SelectedVariableNames = (3:5); %Mengambil Kolom ke-3 sampai ke-5
data1 = readmatrix('Realestatevaluationdataset.xlsx',opts); %Kolom Pertama pada Data Rumah.xlsx sebagai Matrix dan disimpan pada Variabel Data 1

opts = detectImportOptions('Realestatevaluationdataset.xlsx');
opts.SelectedVariableNames = (8);
data2 = readmatrix('Realestatevaluationdataset.xlsx',opts);
info = [data1 data2]; %Menggabungkan data 1 dan data 2 menjadi 1 variabel dan disimpan pada variabel info
info=info(1:50,:);% Mengambil data ke 1-50 pada variabel info dan disimpan pada variabel info
k = [0,0,1,0]; %Mendeklarasikan Keuntungan di setiap atribute
bobot = [3,5,4,1]; %Mendeklarasikan Bobot

%tahapan pertama adalah perbaikan bobot
[m n]=size (info); %inisialisasi ukuran variabel info
bobot=bobot./sum(bobot); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua adalah melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, bobot(j)=-1*bobot(j);
    end;
end;
for i=1:m,
    S(i)=prod(info(i,:).^bobot);
end;

%tahapan ketiga adalah proses perangkingan
V= S/sum(S);
Vtranspose=V.'; % Tranpose matrix V dari horizontal menjadi vertikal 
opts = detectImportOptions('Realestatevaluationdataset.xlsx');
opts.SelectedVariableNames = (1);
recomend= readmatrix('Realestatevaluationdataset.xlsx',opts);
recomend=recomend(1:50,:);
recomend=[recomend Vtranspose];
recomend=sortrows(recomend,-2);% Melakukan sorting data berdasarkan kolom 2
recomend = recomend(1:5,1);%Menampilkan data ke-1 sampai ke 5 pada kolom pertama

%Menampilkan hasil
disp ('Rekomendasi Real Estate untuk Investasi Jangka Panjang Adalah : ') 
disp (recomend)
