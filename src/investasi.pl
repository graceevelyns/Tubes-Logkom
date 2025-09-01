:- include('facts.pl').

/* Menghapus Kepemilikan Kartu Pemain */
hapus_kartu(Pemain, Warna) :-
    retract(Pemain, Warna).

tambah_kartu(Pemain, Warna) :-
    assertz(Pemain, Warna).

cekAdaDalamList(Head, [Head | _]).
cekAdaDalamList(Head, [_ | Tail]) :-
    cekAdaDalamList(Head, Tail).

delAnggota(Head, [Head | Tail], Tail).
delAnggota(Head, [X | Tail], [X | Tail1]) :-
    delAnggota(Head, Tail, Tail1).

tambahAnggota(Head, [], [Head]).
tambahAnggota(Head, [X | Tail], [X | Tail1]) :-
    tambahAnggota(Head, Tail, Tail1).

/* Menambahkan & Menghapus pemain ke daftar investasi unta */
investasi_pemain(Warna, Pemain) :-
    investasi(Warna, DaftarInvestasi),
    kartu(Pemain, ListKartu),           % Pastikan pemain masih memiliki kartu dengan Warna tersebut
    (
        cekAdaDalamList(Warna, ListKartu) -> (
            delAnggota(Warna, ListKartu, ListBaru),        % Hapus kartu dari pemain
            retract(kartu(Pemain, ListKartu)),             % Hapus fakta lama
            assertz(kartu(Pemain, ListBaru)),              % Tambahkan fakta baru
            tambahAnggota(Pemain, DaftarInvestasi, DaftarBaru),  % Tambahkan pemain di akhir daftar
            retract(investasi(Warna, DaftarInvestasi)),     % Hapus fakta lama
            assertz(investasi(Warna, DaftarBaru)),          % Tambahkan pemain
            write('Investasi berhasil! '),
            write(Pemain), write(' telah berinvestasi pada unta '), write(Warna), write('.'), nl,
            write(Pemain), write(' masuk ke daftar investasi unta '), write(Warna), write('.'), nl
        ) ; (
            format('Gagal! ~w sudah berinvestasi pada unta ~w sebelumnya.', [Pemain, Warna]), nl
        )
    ).

hapus_investasi(Warna, Pemain) :-
    investasi(Warna, DaftarInvestasi),
    member(Pemain, DaftarInvestasi),                % Pastikan pemain ada dalam daftar
    select(Pemain, DaftarInvestasi, DaftarBaru),    % Hapus pemain dari daftar
    retract(investasi(Warna, DaftarInvestasi)),     % Hapus fakta lama
    assertz(investasi(Warna, DaftarBaru)),          % Tambahkan fakta baru
    tambah_kartu(Pemain, Warna).

/* Papan investasi */
papan_investasi(Warna) :-
    nl, write('Papan investasi pada unta '), write(Warna), write(' saat ini:'), nl,
    write('+----------------------+'), nl,
    write('|    INVESTASI UNTA    |'), nl,
    write('+----------------------+'), nl,
    investasi(Warna, DaftarPemain),
    (
        DaftarPemain = [] -> 
        (
            write('Belum ada investasi'), nl
        ) ;
        (
            display_daftar(DaftarPemain)
        )
    ).

display_daftar([]).
display_daftar(List) :-
    display_daftar_indexed(List, 1).

display_daftar_indexed([], _).
display_daftar_indexed([H|T], Index) :-
    format('~w. ~w~n', [Index, H]),
    NextIndex is Index + 1,
    display_daftar_indexed(T, NextIndex).

aksi_investasi :-
    pemainSaatIni(Pemain),
    format('Giliran ~w~n', [Pemain]),
    write('Pilih warna unta untuk investasi (merah, kuning, hijau, biru): '),
    read(Warna),
    investasi_pemain(Warna, Pemain),
    papan_investasi(Warna).

papanInvestasi :-
    \+ playing, 
    write('Anda belum memulai permainan! Silakan lakukan perintah startGame terlebih dahulu!'), nl, !.

papanInvestasi :-
    playing,
    nl,
    papan_investasi('merah'), nl,
    papan_investasi('kuning'), nl,
    papan_investasi('biru'), nl,
    papan_investasi('hijau').