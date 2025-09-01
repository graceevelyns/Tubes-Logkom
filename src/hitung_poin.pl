% tambahan poin berdasarkan urutan investasi dan urutan kemenangan
tambah_poin_investasi(UrutanKemenangan) :-
    proses_poin_investasi(UrutanKemenangan, 1).

% Proses poin investasi per warna unta
proses_poin_investasi([], _).
proses_poin_investasi([Warna | Tail], Rank) :-
    investasi(Warna, DaftarPemain),
    tambah_poin_per_warna(DaftarPemain, Rank),
    NextRank is Rank + 1,
    proses_poin_investasi(Tail, NextRank).

% Tambahkan poin untuk setiap pemain dalam daftar investasi berdasarkan urutan investasi
tambah_poin_per_warna([], _).
tambah_poin_per_warna([Pemain | Tail], Rank) :-
    % Hitung urutan investasi berdasarkan posisi pemain di daftar
    count(Tail, Remaining),
    Urutan is Remaining + 1, % Urutan investasi dihitung mundur
    poin_investasi(Urutan, Rank, TambahanPoin),
    tambahPoin(Pemain, TambahanPoin),
    tambah_poin_per_warna(Tail, Rank).

% Tambah poin untuk pemain
tambahPoin(Pemain, TambahanPoin) :-
    poin(Pemain, PoinLama),
    PoinBaru is PoinLama + TambahanPoin,
    retract(poin(Pemain, PoinLama)),
    assertz(poin(Pemain, PoinBaru)).