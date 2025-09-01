% Kelompok     : K01 - G03 - GatauApaNamanya
% NIM/Nama - 1 : 13523021 - Muhammad Raihan Nazhim Oktana
% NIM/Nama - 2 : 13523005 - Muhammad Alfansya
% NIM/Nama - 3 : 13523031 - Rafen Max Alessandro
% NIM/Nama - 4 : 13523087 - Grace Evelyn Simon
% Instansi     : Sekolah Teknik Elektro dan Informatika (STEI) Institut Teknologi Bandung (ITB)
% Jurusan      : Teknik Informatika (IF)
% Nama File    : pasang_trap.pl
% Topik        : Tugas Besar Logika Komputasional 2024 (IF1221-24)
% Tanggal      : Jumat, 20 Desember 2024
% Deskripsi    : Subprogram F07 - Pasang Trap
% PJ F07       : 13523021 - Muhammad Raihan Nazhim Oktana

% BASIS & RULE - Cek Kosong
cek_kosong(Petak) :- petak(Petak , []).

% BASIS & RULE - Pasang Trap
pasang_Trap(Petak , Type, Nama) :-
    retract(posisiJebakan(Petak , ' ' , ' ')),
    assertz(posisiJebakan(Petak , Type , Nama)).

aksi_pasangTrap :-
    pemainSaatIni(Nama),
    \+ jebakan(Nama),
    write('Anda tidak memiliki trap! Pastikan Anda memiliki trap untuk dipasang!'),
    nl, write('Kondisi peta saat ini: '), nl,
    displayMap, nl, !.

aksi_pasangTrap :-
    pemainSaatIni(Nama),
    jebakan(Nama),
    nl, write('Kondisi peta saat ini: '), nl,
    displayMap, nl,

    write('Masukkan kode petak : ') , read(Petak) , nl,
    write('Masukkan jenis trap (maju/mundur) : ') , read(Type) , nl,

    pasanganAngkaHuruf(Petak, Angka),
    (
        AngkaSebelum is Angka - 1,
        AngkaSetelah is Angka + 1,
        (cek_kosong(Angka) , posisiJebakan(AngkaSebelum , ' ', ' ') , posisiJebakan(AngkaSetelah , ' ', ' ')) -> (
            pasang_Trap(Angka , Type , Nama),    
            retract(jebakan(Nama)),
            format('Trap berhasil dipasang. Unta yang mendarat pada petak tersebut akan ~w 1 petak.', [Type]) , nl,
            format('~w akan mendapatkan 10 poin ketika ada unta yang mendarat di petak tersebut.', [Nama]) , nl , nl,
            format('Sisa trap ~w : 0.' , [Nama]) , nl
        ) ; ( 
            write('Trap gagal dipasang.') , nl,
            (
                (\+ cek_kosong(Angka)) -> (
                    write('Pastikan petak kosong (tidak ada unta).') , nl , nl
                ) ; (
                    write('Pastikan tidak ada 2 trap di petak yang bertetangga.') , nl , nl
                )
            )
        ),
        (
            (\+ jebakan(Nama)) -> (
                format('Sisa trap ~w : 0.' , [Nama]) , nl
            ) ; (
                format('Sisa trap ~w : 1.' , [Nama]) , nl
            )
        )
    ),
    nl, write('Kondisi peta saat ini: '), nl,
    displayMap, nl, !.