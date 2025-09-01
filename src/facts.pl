/* status sedang bermain */
:- dynamic(playing/0).

/* status telah ditemukan pemenang */
:- dynamic(win/0).

/* status sedang dalam giliran seorang pemain */
:- dynamic(giliran/0).
:- dynamic(aksi/1).

/* pasangan angka dan huruf */
pasanganAngkaHuruf(0, 'S-F').
pasanganAngkaHuruf(1, 'A').
pasanganAngkaHuruf(2, 'B').
pasanganAngkaHuruf(3, 'C').
pasanganAngkaHuruf(4, 'D').
pasanganAngkaHuruf(5, 'E').
pasanganAngkaHuruf(6, 'F').
pasanganAngkaHuruf(7, 'G').
pasanganAngkaHuruf(8, 'H').
pasanganAngkaHuruf(9, 'I').
pasanganAngkaHuruf(10, 'J').
pasanganAngkaHuruf(11, 'K').
pasanganAngkaHuruf(12, 'L').
pasanganAngkaHuruf(13, 'M').
pasanganAngkaHuruf(14, 'N').
pasanganAngkaHuruf(15, 'O').

pasanganAngkaHuruf('S-F', 0).
pasanganAngkaHuruf('A', 1).
pasanganAngkaHuruf('B', 2).
pasanganAngkaHuruf('C', 3).
pasanganAngkaHuruf('D', 4).
pasanganAngkaHuruf('E', 5).
pasanganAngkaHuruf('F', 6).
pasanganAngkaHuruf('G', 7).
pasanganAngkaHuruf('H', 8).
pasanganAngkaHuruf('I', 9).
pasanganAngkaHuruf('J', 10).
pasanganAngkaHuruf('K', 11).
pasanganAngkaHuruf('L', 12).
pasanganAngkaHuruf('M', 13).
pasanganAngkaHuruf('N', 14).
pasanganAngkaHuruf('O', 15).
pasanganAngkaHuruf('s-f', 0).
pasanganAngkaHuruf('a', 1).
pasanganAngkaHuruf('b', 2).
pasanganAngkaHuruf('c', 3).
pasanganAngkaHuruf('d', 4).
pasanganAngkaHuruf('e', 5).
pasanganAngkaHuruf('f', 6).
pasanganAngkaHuruf('g', 7).
pasanganAngkaHuruf('h', 8).
pasanganAngkaHuruf('i', 9).
pasanganAngkaHuruf('j', 10).
pasanganAngkaHuruf('k', 11).
pasanganAngkaHuruf('l', 12).
pasanganAngkaHuruf('m', 13).
pasanganAngkaHuruf('n', 14).
pasanganAngkaHuruf('o', 15).

/* urutan pemain dalam suatu ronde */
/* urutanPemain(List) */
:- dynamic(urutanPemain/1).

/* pemain pertama dalam setiap giliran */
/* pemainPertama(Nama) */
:- dynamic(pemainPertama/1).

/* nama pemain */
/* pemain(Nama) */
:- dynamic(pemain/1).

/* warna dadu yang dapat dipilih */
/* dadu(Warna) */
:- dynamic(dadu/1).

/* kepemilikan pemain terhadap jebakan */
/* jebakan(Pemain) */
:- dynamic(jebakan/1).

/* kepemilikan pemain terhadap warna kartu */
/* kartu(Pemain, Warna) */
:- dynamic(kartu/2).

/* kepemilikan pemain terhadap jumlah poin */
/* poin(Pemain, Jumlah) */
:- dynamic(poin/2).

/* kepemilikian unta terhadap urutan investasi yang dimiliki */
/* investasi(Warna, List) */
:- dynamic(investasi/2).

/* aturan poin tambahan berdasarkan urutan investasi dan rank kemenangan */
poin_investasi(1, 1, 50). % Investasi pertama pada unta juara 1
poin_investasi(1, 2, 30). % Investasi pertama pada unta juara 2
poin_investasi(1, 3, 20). % Investasi pertama pada unta juara 3
poin_investasi(1, 4, 20). % Investasi pertama pada unta juara 4
poin_investasi(2, _, 10). % Investasi kedua mendapat 10 poin
poin_investasi(3, _, 5).  % Investasi ketiga mendapat 5 poin
poin_investasi(_, _, 0).  % Investasi keempat tidak mendapat poin

/* posisi unta dan warnanya */
/* posisi(Warna, Angka) */
:- dynamic(posisi/2).

/* posisi jebakan ,arah, dan pemiliknya */
/* posisiJebakan(Angka, Arah, Pemain) */
:- dynamic(posisiJebakan/3).

/* pasangan warna dan singkatan warna */
translateWarna('merah', 'UM').
translateWarna('kuning', 'UK').
translateWarna('hijau', 'UH').
translateWarna('biru', 'UB').
translateWarna('putih', 'UP').
translateWarna('hitam', 'UI').

/* kondisi petak dan unta di petak tersebut */
/* petak(Angka, List) */
:- dynamic(petak/2).