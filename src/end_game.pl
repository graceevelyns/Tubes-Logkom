:- include('facts.pl').

endGame :-
    win,
    write('Permainan telah berakhir!'), nl,
    write('Menghitung hasil investasi...'), nl,
    listPemenang(16, UrutanKemenangan),
    format('Urutan kemenangan unta: ~w~n', [UrutanKemenangan]),
    tambah_poin_investasi(UrutanKemenangan),
    cari_pemenang(Pemenang, PoinTertinggi),
    format('Selamat, ~w menang dengan ~d poin!~n', [Pemenang, PoinTertinggi]),
    bersihkan_data.

bersihkan_data :-
    retractall(playing),
    retractall(pemain(_)),
    retractall(dadu(_)),
    retractall(investasi(_, _)),
    retractall(jebakan(_)),
    retractall(kartu(_, _)),
    retractall(poin(_, _)),
    retractall(petak(_, _)),
    retractall(posisiJebakan(_, _, _)),
    retractall(posisi(_, _)),
    retractall(urutanPemain(_)),
    retractall(pemainPertama(_)),
    retractall(aksi(_)),
    retractall(giliran),
    retractall(win).
    
cari_pemenang(Pemenang, PoinTertinggi) :-
    findall((Nama, Poin), poin(Nama, Poin), DaftarPoin),
    max_poin(DaftarPoin, (Pemenang, PoinTertinggi)).

max_poin([Head | Tail], Max) :-
    max_poin_helper(Tail, Head, Max).

max_poin_helper([], Max, Max).
max_poin_helper([(Nama, Poin) | Tail], (CurrNama, CurrPoin), Max) :-
    (Poin > CurrPoin ->
        max_poin_helper(Tail, (Nama, Poin), Max)
    ;
        max_poin_helper(Tail, (CurrNama, CurrPoin), Max)
    ).