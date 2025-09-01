% Kelompok     : K01 - G03 - GatauApaNamanya
% NIM/Nama - 1 : 13523021 - Muhammad Raihan Nazhim Oktana
% NIM/Nama - 2 : 13523005 - Muhammad Alfansya
% NIM/Nama - 3 : 13523031 - Rafen Max Alessandro
% NIM/Nama - 4 : 13523087 - Grace Evelyn Simon
% Instansi     : Sekolah Teknik Elektro dan Informatika (STEI) Institut Teknologi Bandung (ITB)
% Jurusan      : Teknik Informatika (IF)
% Nama File    : jalankan_unta.pl
% Topik        : Tugas Besar Logika Komputasional 2024 (IF1221-24)
% Tanggal      : Jumat, 20 Desember 2024
% Deskripsi    : Subprogram F06 - Jalankan Unta
% PJ F06       : 13523021 - Muhammad Raihan Nazhim Oktana

del(_, [], []).
del(Head, [Head | Tail], Tail).
del(Element, [Head | Tail], [Head | Result]) :-
    Element \= Head,
    del(Element, Tail, Result).

% BASIS - Kocok Dadu
kocokDadu([] , UpdateWarna , ResWarna , ResAngka) :-
    ResetWarna = ['merah', 'biru', 'hijau', 'kuning', 'abu-abu'],
    kocokDadu(ResetWarna , UpdateWarna , ResWarna , ResAngka).

% RULE - Kocok Dadu
kocokDadu(OldWarna , UpdateWarna , ResWarna , ResAngka) :-
    count(OldWarna , Count),
    random(0 , Count , IdxWarna),
    element(OldWarna , IdxWarna , ResWarna),
    del(ResWarna , OldWarna , UpdateWarna),
    random(1 , 7 , ResAngka).

% BASIS - Index
indexList(Element, [Element | _], 0).

% RULE - Index
indexList(Element , [_ | Tail] , Index) :-
    indexList(Element , Tail , Temp),
    Index is Temp + 1.

% BASIS - Element
element([Head | _] , 0 , Head).

% RULE - Element
element([_ | Tail] , Index , Element) :-
    Index > 0,
    Next is Index - 1,
    element(Tail , Next , Element).

% BASIS - Count
count([] , Count) :- Count is 0.
count([_] , Count) :- Count is 1.

% RULE - Count
count([_ | Tail] , Count) :- count(Tail , C1) , Count is 1 + C1.

% RULE - Pisah
pisah([], _, [], []).
pisah(List, 0, [], List).
pisah([Head | Tail], N, [Head | Front], Back) :-
    N > 0,
    N1 is N - 1,
    pisah(Tail, N1, Front, Back).

% BASIS - Gabung
gabung([] , List , List).
gabung(List , [] , List).

% RULE - Gabung
gabung([Head | Tail] , List , [Head | Result]) :- gabung(Tail , List , Result).

% BASIS - Process
process([] , _ , _).

% RULE - Process
process([Head | Tail] , OldPos , NewPos) :-
    retract(posisi(Head , OldPos)),
    assertz(posisi(Head , NewPos)),
    process(Tail , OldPos , NewPos).

% BASIS & RULE - Jalankan Unta
jalankan_Unta(Warna , Count) :-
    (
        (Warna == 'abu-abu') -> (
            (
                (Count mod 2 =:= 0) -> (
                    WarnaAsli = 'putih'
                ) ; (
                    WarnaAsli = 'hitam'
                )
            )
        ) ; (
            WarnaAsli = Warna
        )
    ),
    posisi(WarnaAsli , OldPos),
    petak(OldPos , ListUntaOld),
    (
        (Warna == 'abu-abu') -> (
            (
                (OldPos - 1 < Count) -> (
                    NewPos is 1 
                ) ; (
                    NewPos is (OldPos - Count)
                )
            )
        ) ; (
            (
                (15 < OldPos + Count) -> (
                    NewPos is 16, 
                    assertz(win)
                ) ; (
                    NewPos is (OldPos + Count)
                )
            )
        )
    ),
    (
        (OldPos == 0 ; OldPos == 16) -> (
            ListUntaMove = [WarnaAsli], 
            del(WarnaAsli , ListUntaOld , ListUntaNew), 
            ListUntaStay = ListUntaNew
        ) ; (
            (
                (OldPos == NewPos) -> (
                    ListUntaStay = ListUntaOld,
                    ListUntaMove = []
                ) ; (
                    indexList(WarnaAsli , ListUntaOld , Index), 
                    pisah(ListUntaOld , Index , ListUntaStay , ListUntaMove)
                )
            )
        )
    ),
    petak(NewPos , ListUntaTarget),
    gabung(ListUntaTarget , ListUntaMove , ListUntaTargetNew),
    retract(petak(OldPos , ListUntaOld)),
    assertz(petak(OldPos , ListUntaStay)),
    retract(petak(NewPos , ListUntaOldTemp)),
    assertz(petak(NewPos , ListUntaTargetNew)),
    process(ListUntaMove , OldPos , NewPos), nl,
    (
        (Warna == 'abu-abu') -> (
            format('Unta ~w bergerak mundur sebanyak ~d langkah...~n~n' , [WarnaAsli , Count])
        ) ; (
            format('Unta ~w bergerak maju sebanyak ~d langkah...~n~n' , [WarnaAsli , Count])
        )
    ),
    (
        (win) -> (
            endGame, !, fail
        ) ; (
            true
        )
    ).

kondisi(N) :-
    posisiJebakan(N, _, Nama),
    Nama \= ' ',
    petak(N, ListUnta),
    ListUnta \= [].

cariTrap([], _) :- fail.
cariTrap([Petak | _], Petak) :-
    kondisi(Petak), !.

cariTrap([_ | Tail], Result) :-
    cariTrap(Tail, Result).

cekTrap(0).
cekTrap(N) :-
    (
        (kenaTrap(N)) -> (
            true
        ) ; (
            true
        )
    ),
    N1 is N - 1,
    cekTrap(N1).

kenaTrap(N) :-
    posisiJebakan(N, Arah, Nama),
    Nama \= ' ',
    (
        (Arah = 'maju') -> (
            N1 is N + 1
        ) ; (
            N1 is N - 1
        )
    ),
    petak(N, ListUnta),
    ListUnta \= [],
    tambahPoin(Nama, 10),
    format("Trap milik ~w memberikan 10 poin tambahan!~n", [Nama]),
    retract(petak(N, _)),
    assertz(petak(N, [])),
    
    petak(N1, ListUntaStandBy),
    gabung(ListUntaStandBy, ListUnta, ListUntaBaru),
    retract(petak(N1, _)),
    assertz(petak(N1, ListUntaBaru)),
    
    retract(posisiJebakan(N, _, _)),
    assertz(posisiJebakan(N, ' ', ' ')),

    process(ListUnta, N , N1).

% MAIN - Jalankan Unta
aksi_jalankanUnta :-
    pemainSaatIni(Pemain),
    tambahPoin(Pemain, 10),
    format('~w mendapatkan 10 poin!', [Pemain]), nl, nl,
    
    write('Kondisi peta saat ini: '), nl, 
    displayMap, nl,

    pemainPertama(PemainPertama),
    dadu(OldWarna),
    (
        (Pemain == PemainPertama) -> (
                ResetWarna = ['merah', 'biru', 'hijau', 'kuning', 'abu-abu'],
                kocokDadu(ResetWarna , UpdateWarna , Warna , Angka)
            ) ; (
                kocokDadu(OldWarna , UpdateWarna , Warna , Angka)
            )
    ), nl,
    retract(dadu(_)),
    assertz(dadu(UpdateWarna)),
    format('Dadu dikocok...~nDadu Angka : ~d~nDadu Warna : ~w~n~n' , [Angka , Warna]),
    jalankan_Unta(Warna , Angka),
    
    write('Kondisi peta saat ini: '), nl, 
    displayMap, nl,

    (
        (cariTrap([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], HasilTrap)) -> (
            write('Ada unta mengenai Trap! '),
            cekTrap(15), nl, nl,
            write('Kondisi peta saat ini: '), nl, 
            displayMap
        ) ; (
            write('Tidak ada unta yang mengenai Trap.')
        )
    ),
    petak(16, ListUnta),
    hapusHitamPutih(ListUnta, ListUntaBersih),
    (
        (ListUntaBersih \= []) -> (
            assertz(win),
            endGame, !, fail
        ) ; (
            true
        )
    ), nl, !.

aksi_tukarUnta :-
    write('Kocok dadu...'), nl,
    dadu(OldWarna),
    retract(dadu(_)),
    assertz(dadu(['merah', 'kuning', 'hijau', 'biru', 'putih'])),
    dadu(WarnaLengkap),
    kocokDadu(WarnaLengkap, _, Warna1, _),
    kocokDadu(WarnaLengkap, _, Warna2, _),
    (
        (Warna1 = Warna2) -> (
            write('Dua warna yang sama terpilih, ulangi pengocokan!'), nl,
            aksi_tukarUnta
        ) ; (
            % Tampilkan warna unta
            write('Warna unta 1: '), write(Warna1), nl,
            write('Warna unta 2: '), write(Warna2), nl, nl,
            
            % Ambil posisi unta
            posisi(Warna1, Posisi1),
            posisi(Warna2, Posisi2),
            pasanganAngkaHuruf(Posisi1, HurufPosisi1),
            pasanganAngkaHuruf(Posisi2, HurufPosisi2),
            
            % Tampilkan posisi sebelum pertukaran
            write('Posisi sebelum unta '), write(Warna1), write(': '), write(HurufPosisi1), nl,
            write('Posisi sebelum unta '), write(Warna2), write(': '), write(HurufPosisi2), nl, nl,
            
            % Tukar posisi
            tukar_Unta(Warna1, Warna2),
            
            % Konfirmasi pertukaran
            write('Unta '), write(Warna1), write(' dan '), write(Warna2), write(' bertukar posisi...'), nl, nl,
            
            % Tampilkan posisi sesudah pertukaran
            posisi(Warna1, PosisiBaru1),
            posisi(Warna2, PosisiBaru2),
            pasanganAngkaHuruf(PosisiBaru1, HurufPosisiBaru1),
            pasanganAngkaHuruf(PosisiBaru2, HurufPosisiBaru2),
            write('Posisi sesudah unta '), write(Warna1), write(': '), write(HurufPosisiBaru1), nl,
            write('Posisi sesudah unta '), write(Warna2), write(': '), write(HurufPosisiBaru2), nl,
            !
        )
    ),
    retract(dadu(_)),
    assertz(dadu(OldWarna)).

% Tukar posisi dua unta di fakta posisi/2 dan perbarui fakta petak/2
tukar_Unta(Warna1, Warna2) :-
    posisi(Warna1, Posisi1),
    posisi(Warna2, Posisi2),
    
    % Ambil daftar unta dari petak masing-masing
    petak(Posisi1, ListUnta1),
    petak(Posisi2, ListUnta2),

    % Update daftar unta di petak masing-masing
    tukar_posisi_daftar_unta(ListUnta1, Warna1, Warna2, ListUnta1Baru),
    tukar_posisi_daftar_unta(ListUnta2, Warna2, Warna1, ListUnta2Baru),

    % Perbarui fakta petak/2
    retract(petak(Posisi1, ListUnta1)),
    assertz(petak(Posisi1, ListUnta1Baru)),
    retract(petak(Posisi2, ListUnta2)),
    assertz(petak(Posisi2, ListUnta2Baru)),

    % Tukar posisi di fakta posisi/2
    retract(posisi(Warna1, Posisi1)),
    assertz(posisi(Warna1, Posisi2)),
    retract(posisi(Warna2, Posisi2)),
    assertz(posisi(Warna2, Posisi1)).

% Tukar posisi dua warna dalam daftar unta
tukar_posisi_daftar_unta([], _, _, []).
tukar_posisi_daftar_unta([Head | Tail], Warna1, Warna2, [Warna2 | TailBaru]) :-
    Head == Warna1,
    tukar_posisi_daftar_unta(Tail, Warna1, Warna2, TailBaru).
tukar_posisi_daftar_unta([Head | Tail], Warna1, Warna2, [Warna1 | TailBaru]) :-
    Head == Warna2,
    tukar_posisi_daftar_unta(Tail, Warna1, Warna2, TailBaru).
tukar_posisi_daftar_unta([Head | Tail], Warna1, Warna2, [Head | TailBaru]) :-
    Head \= Warna1,
    Head \= Warna2,
    tukar_posisi_daftar_unta(Tail, Warna1, Warna2, TailBaru).