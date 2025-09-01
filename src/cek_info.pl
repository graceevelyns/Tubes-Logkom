cekInfo :-
    \+ playing, 
    write('Anda belum memulai permainan! Silakan lakukan perintah startGame terlebih dahulu!'), nl, !.

cekInfo :-
    playing, 
    write('Masukkan nama pemain: '),
    read(Pemain),
    (
        (pemain(Pemain)) -> (
            format("Nama pemain: ~w", [Pemain]), nl,
            
            poin(Pemain, PoinPemain),
            format("Poin: ~w", [PoinPemain]), nl,

            kartu(Pemain, KartuPemain),
            format("Kartu: ~w", [KartuPemain]), nl,

            (
                ( jebakan(Pemain) ) -> (
                    write('Jebakan: 1')
                ) ; (
                    write('Jebakan: 0')
                )
            )
        ) ; (
            format('Tidak terdapat pemain dengan nama ~w!', [Pemain])
        )
    ), nl, !.