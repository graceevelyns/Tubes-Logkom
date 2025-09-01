:- include('facts.pl').

cekJumlahPemain(Input, Input) :-
    integer(Input),
    Input >= 2, Input =< 4, !.
cekJumlahPemain(_, JumlahPemain) :-
    write('Mohon masukkan angka antara 2 - 4.'), nl,
    masukanJumlahPemain(JumlahPemain).

masukanJumlahPemain(JumlahPemain) :-
    write('Masukan jumlah pemain: '),
    read(Input),
    cekJumlahPemain(Input, JumlahPemain).

masukanNamaPemain(0, JumlahPemain, []).
masukanNamaPemain(N, JumlahPemain, [Head | Tail]) :-
    Temp is JumlahPemain - N + 1,
    format("Masukkan nama pemain ~w: ", [Temp]),
    read(Head),
    format("Nama Pemain yang dimasukkan: ~w~n", [Head]),
    N1 is N - 1,
    masukanNamaPemain(N1, JumlahPemain, Tail).

del(X, [X | Tail], Tail).
del(X, [Y | Tail], [Y | Tail1]) :-
    del(X, Tail, Tail1).

list_permutation([], []).
list_permutation(L, [Head | Tail]) :-
    del(Head, L, L1),
    list_permutation(L1, Tail).

all_permutations(L, Permutations) :-
    findall(P, list_permutation(L, P), Permutations).

factorial(0, 1).
factorial(A, X) :-
        A1 is A - 1,
        factorial(A1, Temp),
        X is A * Temp.

ambilIndeks(0, [Head | _], Head).
ambilIndeks(N, [_ | Tail], Element) :-
    N > 0,
    N1 is N - 1,
    ambilIndeks(N1, Tail, Element).

printUrutanDenganStrip([]).
printUrutanDenganStrip([Head | Tail]) :-
    format(' - ~w', [Head]),
    printUrutanDenganStrip(Tail).

printUrutan([]).
printUrutan([Head | Tail]) :-
    format('~w', [Head]),
    printUrutanDenganStrip(Tail).

setUpKartu(0, []).
setUpKartu(N, [Head | Tail]) :-
    format('Kartu ~w: merah, kuning, hijau, biru.', [Head]), nl,
    assertz(pemain(Head)),
    assertz(kartu(Head, ['merah', 'kuning', 'hijau', 'biru'])),
    N1 is N - 1,
    setUpKartu(N1, Tail).

setUpPoin(0, []).
setUpPoin(N, [Head | Tail]) :-
    format('Poin ~w: 30', [Head]), nl,
    assertz(poin(Head, 30)),
    N1 is N - 1,
    setUpPoin(N1, Tail).

setUpTrap(0, []).
setUpTrap(N, [Head | Tail]) :-
    format('Trap ~w: 1', [Head]), nl,
    assertz(jebakan(Head)),
    N1 is N - 1,
    setUpTrap(N1, Tail).

tambahList([], X, [X]).
tambahList([Head | Tail], A, [Head | Result]) :-
        tambahList(Tail, A, Result).

startGame :-
    playing,
    write('Permainan sedang berlangsung! Anda tidak dapat memulai permainan baru!'), nl, !.

startGame :-
    nl, write('~~~ Selamat Datang di Camel POP! ~~~'), nl, nl,
    \+ playing,
    assertz(playing),
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
    retractall(win),

    assertz(dadu(['merah', 'kuning', 'hijau', 'biru', 'abu-abu'])),
    assertz(investasi('merah', [])),
    assertz(investasi('kuning', [])),
    assertz(investasi('hijau', [])),
    assertz(investasi('biru', [])),
    assertz(posisi('biru', 0)),
    assertz(posisi('kuning', 0)),
    assertz(posisi('hijau', 0)),
    assertz(posisi('merah', 0)),
    assertz(posisi('putih', 16)),
    assertz(posisi('hitam', 16)),

    assertz(petak(0, ['merah', 'kuning', 'hijau', 'biru'])),
    assertz(petak(1, [])),
    assertz(petak(2, [])),
    assertz(petak(3, [])),
    assertz(petak(4, [])),
    assertz(petak(5, [])),
    assertz(petak(6, [])),
    assertz(petak(7, [])),
    assertz(petak(8, [])),
    assertz(petak(9, [])),
    assertz(petak(10, [])),
    assertz(petak(11, [])),
    assertz(petak(12, [])),
    assertz(petak(13, [])),
    assertz(petak(14, [])),
    assertz(petak(15, [])),
    assertz(petak(16, ['putih', 'hitam'])),

    assertz(posisiJebakan(0, ' ', ' ')),
    assertz(posisiJebakan(1, ' ', ' ')),
    assertz(posisiJebakan(2, ' ', ' ')),
    assertz(posisiJebakan(3, ' ', ' ')),
    assertz(posisiJebakan(4, ' ', ' ')),
    assertz(posisiJebakan(5, ' ', ' ')),
    assertz(posisiJebakan(6, ' ', ' ')),
    assertz(posisiJebakan(7, ' ', ' ')),
    assertz(posisiJebakan(8, ' ', ' ')),
    assertz(posisiJebakan(9, ' ', ' ')),
    assertz(posisiJebakan(10, ' ', ' ')),
    assertz(posisiJebakan(11, ' ', ' ')),
    assertz(posisiJebakan(12, ' ', ' ')),
    assertz(posisiJebakan(13, ' ', ' ')),
    assertz(posisiJebakan(14, ' ', ' ')),
    assertz(posisiJebakan(15, ' ', ' ')),
    assertz(posisiJebakan(16, ' ', ' ')),

    masukanJumlahPemain(JumlahPemain), nl,
    masukanNamaPemain(JumlahPemain, JumlahPemain, DaftarPemain), nl,
    all_permutations(DaftarPemain, DaftarAcak),
    factorial(JumlahPemain, BanyakPermutasi),
    random(0, BanyakPermutasi, Random),
    ambilIndeks(Random, DaftarAcak, DaftarAcakRandom),
    setPemainPertama(DaftarAcakRandom),
    write('Urutan pemain: '),
    printUrutan(DaftarAcakRandom), nl, nl,

    write('Setiap pemain mendapatkan 4 kartu, 30 poin, dan 1 trap.'), nl, nl,
    setUpKartu(JumlahPemain, DaftarAcakRandom), nl,
    setUpPoin(JumlahPemain, DaftarAcakRandom), nl,
    setUpTrap(JumlahPemain, DaftarAcakRandom), nl,
    assertz(urutanPemain(DaftarAcakRandom)),
    write('Silakan memulai permainan, pemain pertama! ^^'), nl,
    mulai_giliran, !.

pemainSaatIni(Pemain) :-
    urutanPemain([Pemain | _]).

pemainSelanjutnya :-
    urutanPemain([Pemain | SisaPemain]),
    tambahList(SisaPemain, Pemain, PemainSelanjutnya),
    retract(urutanPemain(_)),
    assertz(urutanPemain(PemainSelanjutnya)).

nextTurn :-
    pemainSelanjutnya,
    pemainSaatIni(PemainBerikutnya),
    format('Sekarang giliran pemain ~w.', [PemainBerikutnya]), nl,
    mulai_giliran, !.

mulai_giliran :-
    retractall(aksi(_)),
    assertz(giliran),
    write('Mau melakukan apa, nih? (investasi, jalankanUnta, pasangTrap, cekInfo, displayMap, tukarUnta)'), nl.

investasi :-
    ( giliran ->
        ( aksi(_) ->
            write('Anda sudah tidak bisa lagi melakukan aksi tersebut pada giliran ini!'), nl
        ;
            write('Melakukan investasi...'), nl,
            aksi_investasi,
            assertz(aksi(investasi))
        )
    ;
        write('Anda belum memulai permainan! Silakan lakukan perintah startGame terlebih dahulu!'), nl
    ).

jalankanUnta :-
    ( giliran ->
        ( aksi(_) ->
            write('Anda sudah tidak bisa lagi melakukan aksi tersebut pada giliran ini!'), nl
        ;
            write('Menjalankan unta...'), nl,
            aksi_jalankanUnta,
            assertz(aksi(jalankanUnta))
        )
    ;
        write('Anda belum memulai permainan! Silakan lakukan perintah startGame terlebih dahulu!'), nl
    ).

pasangTrap :-
    ( giliran ->
        ( aksi(_) ->
            write('Anda sudah tidak bisa lagi melakukan aksi tersebut pada giliran ini!'), nl
        ;
            write('Memasang trap...'), nl,
            aksi_pasangTrap,
            assertz(aksi(pasangTrap))
        )
    ;
        write('Anda belum memulai permainan! Silakan lakukan perintah startGame terlebih dahulu!'), nl
    ).

tukarUnta :-
    ( giliran ->
        ( aksi(_) ->
            write('Anda sudah tidak bisa lagi melakukan aksi tersebut pada giliran ini!'), nl
        ;
            write('Menukar unta...'), nl,
            aksi_tukarUnta,
            assertz(aksi(tukarUnta))
        )
    ;
        write('Anda belum memulai permainan! Silakan lakukan perintah startGame terlebih dahulu!'), nl
    ).

reverse1([], []).
reverse1([Head | Tail], X) :-
        reverse1(Tail, Temp),
        tambahList(Temp, Head, X).

hapusHitamPutih([], []).
hapusHitamPutih([Head | Tail], Result) :-
    ((Head = 'hitam'); (Head = 'putih')), !,
    hapusHitamPutih(Tail, Result).
hapusHitamPutih([Head | Tail], [Head | Result]) :-
    hapusHitamPutih(Tail, Result).

listPemenangKotor(-1, List, List).
listPemenangKotor(N, List, Result) :-
    petak(N, ListUnta),
    (
        (ListUnta \= []) -> (
            hapusHitamPutih(ListUnta, ListUntaBersih),
            reverse1(ListUntaBersih, ListUntaReverse),
            tambahList(List, ListUntaReverse, NextList)
        ) ; (
            NextList = List
        )
    ),
    ratakan(NextList, NextListFlatten),
    N1 is N - 1,
    listPemenangKotor(N1, NextListFlatten, Result).

ratakan([], []).
ratakan([[] | Tail], Result) :-
    ratakan(Tail, Result).
ratakan([[Head | SubTail] | Tail], Result) :-
    ratakan([Head | SubTail], FlatHead),
    ratakan(Tail, FlatTail),
    tambahList(FlatHead, FlatTail, Result).
ratakan([Head | Tail], [Head | FlatTail]) :-
    \+ Head = [],
    ratakan(Tail, FlatTail).

hapusKosong([], []).
hapusKosong([[] | Tail], Result) :-
    hapusKosong(Tail, Result).
hapusKosong([Head | Tail], [Head | Result]) :-
    Head \= [],
    hapusKosong(Tail, Result).

listPemenang(N, Result) :-
    listPemenangKotor(N, [], TempResult),
    hapusKosong(TempResult, Result).

setPemainPertama([Head | Tail]) :-
    assertz(pemainPertama(Head)).