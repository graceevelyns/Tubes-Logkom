printLine :-
    write('+---------------------------'),
    write('+---------------------------'),
    write('+---------------------------'),
    write('+---------------------------'),
    write('+---------------------------+'), nl.

printExtraLineWithColumn(1) :-
    write('|'),
    printSpaces(27),
    write('|').

printExtraLineWithColumn(N) :-
    N > 1,
    write('|'),
    printSpaces(27),
    N1 is N - 1,
    printExtraLineWithColumn(N1).

printSeparatedLine :-
    write('+---------------------------+').

printSpaces(0).
printSpaces(N) :-
    N > 0,
    write(' '),
    Temp is N-1,
    printSpaces(Temp).

translateListPetak([], []).
translateListPetak([Head | Tail], [TranslateHead | Result]) :-
    translateWarna(Head, TranslateHead),
    translateListPetak(Tail, Result).

printUntaPetakDenganSpasi([]).
printUntaPetakDenganSpasi([Head | Tail]) :-
    format(' ~w', [Head]),
    printUntaPetakDenganSpasi(Tail).

printUntaPetakdiSF([]).
printUntaPetakdiSF([Head | Tail]) :-
    format('~w', [Head]),
    printUntaPetakDenganSpasi(Tail).

printUntaPetakDenganKoma([]).
printUntaPetakDenganKoma([Head | Tail]) :-
    format(', ~w', [Head]),
    printUntaPetakDenganKoma(Tail).

printUntaPetak([]).
printUntaPetak([Head | Tail]) :-
    format('~w', [Head]),
    printUntaPetakDenganKoma(Tail).

count([], 0).
count([_ | Tail], X) :-
        count(Tail, Temp),
        X is Temp + 1.

displayMap :- 
    \+ playing,
    write('Anda belum memulai permainan! Silakan lakukan perintah startGame terlebih dahulu!'), nl, !.

displayMap :-
    playing,
    printLine,
    printExtraLineWithColumn(5), nl,

    /* petak S-F */
    write('|'),
    printSpaces(12),
    write('S/F'),
    printSpaces(12),
    write('|'),

    /* petak A */
    printSpaces(13),
    write('A'),
    printSpaces(13),
    write('|'),

    /* petak B */
    printSpaces(13),
    write('B'),
    printSpaces(13),
    write('|'),

    /* petak C */
    printSpaces(13),
    write('C'),
    printSpaces(13),
    write('|'),

    /* petak D */
    printSpaces(13),
    write('D'),
    printSpaces(13),
    write('|'), nl,

    /* unta di petak S-F */
    write('|'),
    petak(0, ListUntaAwal),
    petak(16, ListUntaAkhir),
    gabung(ListUntaAwal, ListUntaAkhir, ListUnta0),
    count(ListUnta0, JumlahUnta0),
    (
        (JumlahUnta0 == 0) -> (
            Kosong0 is 12
        ) ; (
            Kosong0 is ceiling((27 - ((JumlahUnta0 * 2) + (JumlahUnta0 - 1) + 2)) / 2)
        )
    ),
    printSpaces(Kosong0),
    write('['),
    (
        (JumlahUnta0 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta0, ListUnta0HasilTranslate),
            printUntaPetakdiSF(ListUnta0HasilTranslate)
        )
    ),
    write(']'),
    (
        (JumlahUnta0 == 0) -> (
            printSpaces(27 - Kosong0 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong0 - ((JumlahUnta0 * 2) + (JumlahUnta0 - 1) + 2))
        )
    ),
    write('|'),

    /* unta di petak A */
    petak(1, ListUnta1),
    count(ListUnta1, JumlahUnta1),
    (
        (JumlahUnta1 == 0) -> (
            Kosong1 is 12
        ) ; (
            Kosong1 is ceiling((27 - ((JumlahUnta1 * 2) + ((JumlahUnta1 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong1),
    write('['),
    (
        (JumlahUnta1 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta1, ListUnta1HasilTranslate),
            printUntaPetak(ListUnta1HasilTranslate)
        )
    ),
    write(']'),
    (
        (JumlahUnta1 == 0) -> (
            printSpaces(27 - Kosong1 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong1 - ((JumlahUnta1 * 2) + ((JumlahUnta1 - 1) * 2) + 2))
        )
    ),
    write('|'),

    /* unta di petak B */
    petak(2, ListUnta2),
    count(ListUnta2, JumlahUnta2),
    (
        (JumlahUnta2 == 0) -> (
            Kosong2 is 12
        ) ; (
            Kosong2 is ceiling((27 - ((JumlahUnta2 * 2) + ((JumlahUnta2 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong2),
    write('['),
    (
        (JumlahUnta2 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta2, ListUnta2HasilTranslate),
            printUntaPetak(ListUnta2HasilTranslate)
        )
    ),
    write(']'),
    (
        (JumlahUnta2 == 0) -> (
            printSpaces(27 - Kosong2 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong2 - ((JumlahUnta2 * 2) + ((JumlahUnta2 - 1) * 2) + 2))
        )
    ),
    write('|'),

    /* unta di petak C */
    petak(3, ListUnta3),
    count(ListUnta3, JumlahUnta3),
    (
        (JumlahUnta3 == 0) -> (
            Kosong3 is 12
        ) ; (
            Kosong3 is ceiling((27 - ((JumlahUnta3 * 2) + ((JumlahUnta3 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong3),
    write('['),
    (
        (JumlahUnta3 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta3, ListUnta3HasilTranslate),
            printUntaPetak(ListUnta3HasilTranslate)      
        )
    ),
    write(']'),
    (
        (JumlahUnta3 == 0) -> (
            printSpaces(27 - Kosong3 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong3 - ((JumlahUnta3 * 2) + ((JumlahUnta3 - 1) * 2) + 2))
        )
    ),
    write('|'),

    /* unta di petak D */
    petak(4, ListUnta4),
    count(ListUnta4, JumlahUnta4),
    (
        (JumlahUnta4 == 0) -> (
            Kosong4 is 12
        ) ; (
            Kosong4 is floor((27 - ((JumlahUnta4 * 2) + ((JumlahUnta4 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong4),
    write('['),
    (
        (JumlahUnta4 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta4, ListUnta4HasilTranslate),
            printUntaPetak(ListUnta4HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta4 == 0) -> (
            printSpaces(27 - Kosong4 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong4 - ((JumlahUnta4 * 2) + ((JumlahUnta4 - 1) * 2) + 2))
        )
    ),
    write('|'), nl,

    /* jebakan di petak S-F */
    write('|'),
    posisiJebakan(0, Jebakan0, Nama0),
    (
        (Jebakan0 == ' ') -> (
            KosongJebakan0 is 12
        ) ; (
            KosongJebakan0 is 10
        )
    ),
    printSpaces(KosongJebakan0),
    write('('),
    (
        (Jebakan0 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan0 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan0),
    write('|'),

    /* jebakan di petak A */
    posisiJebakan(1, Jebakan1, Nama1),
    (
        (Jebakan1 == ' ') -> (
            KosongJebakan1 is 12
        ) ; (
            KosongJebakan1 is 10
        )
    ),
    printSpaces(KosongJebakan1),
    write('('),
    (
        (Jebakan1 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan1 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan1),
    write('|'),

    /* jebakan di petak B */
    posisiJebakan(2, Jebakan2, Nama2),
    (
        (Jebakan2 == ' ') -> (
            KosongJebakan2 is 12
        ) ; (
            KosongJebakan2 is 10
        )
    ),
    printSpaces(KosongJebakan2),
    write('('),
    (
        (Jebakan2 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan2 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan2),
    write('|'),

    /* jebakan di petak C */
    posisiJebakan(3, Jebakan3, Nama3),
    (
        (Jebakan3 == ' ') -> (
            KosongJebakan3 is 12
        ) ; (
            KosongJebakan3 is 10
        )
    ),
    printSpaces(KosongJebakan3),
    write('('),
    (
        (Jebakan3 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan3 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan3),
    write('|'),

    /* jebakan di petak D */
    posisiJebakan(4, Jebakan4, Nama4),
    (
        (Jebakan4 == ' ') -> (
            KosongJebakan4 is 12
        ) ; (
            KosongJebakan4 is 10
        )
    ),
    printSpaces(KosongJebakan4),
    write('('),
    (
        (Jebakan4 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan4 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan4),
    write('|'), nl,

    printExtraLineWithColumn(5), nl,

    printLine,

    printExtraLineWithColumn(1),
    printSpaces(83),
    printExtraLineWithColumn(1), nl,

    /* petak O */
    write('|'),
    printSpaces(13),
    write('O'),
    printSpaces(13),
    write('|'),

    printSpaces(83),

    /* petak E */
    write('|'),
    printSpaces(13),
    write('E'),
    printSpaces(13),
    write('|'), nl,

    /* unta di petak O */
    write('|'),
    petak(15, ListUnta15),
    count(ListUnta15, JumlahUnta15),
    (
        (JumlahUnta15 == 0) -> (
            Kosong15 is 12
        ) ; (
            Kosong15 is ceiling((27 - ((JumlahUnta15 * 2) + ((JumlahUnta15 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong15),
    write('['),
    (
        (JumlahUnta15 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta15, ListUnta15HasilTranslate),
            printUntaPetak(ListUnta15HasilTranslate)          
        )
    ),
    write(']'),
    (
        (JumlahUnta15 == 0) -> (
            printSpaces(27 - Kosong15 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong15 - ((JumlahUnta15 * 2) + ((JumlahUnta15 - 1) * 2) + 2))
        )
    ),
    write('|'),

    printSpaces(15),
    write('         ,,                               .-. '),
    printSpaces(22),

    /* unta di petak E */
    write('|'),
    petak(5, ListUnta5),
    count(ListUnta5, JumlahUnta5),
    (
        (JumlahUnta5 == 0) -> (
            Kosong5 is 12
        ) ; (
            Kosong5 is ceiling((27 - ((JumlahUnta5 * 2) + ((JumlahUnta5 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong5),
    write('['),
    (
        (JumlahUnta5 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta5, ListUnta5HasilTranslate),
            printUntaPetak(ListUnta5HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta5 == 0) -> (
            printSpaces(27 - Kosong5 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong5 - ((JumlahUnta5 * 2) + ((JumlahUnta5 - 1) * 2) + 2))
        )
    ),
    write('|'), nl,

    /* jebakan di petak O */
    write('|'),
    posisiJebakan(15, Jebakan15, Nama15),
    (
        (Jebakan15 == ' ') -> (
            KosongJebakan15 is 12
        ) ; (
            KosongJebakan15 is 10
        )
    ),
    printSpaces(KosongJebakan15),
    write('('),
    (
        (Jebakan15 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan15 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan15),
    write('|'),

    printSpaces(15),
    write('        || |                               ) )'),
    printSpaces(22),

    /* jebakan di petak E */
    write('|'),
    posisiJebakan(5, Jebakan5, Nama5),
    (
        (Jebakan5 == ' ') -> (
            KosongJebakan5 is 12
        ) ; (
            KosongJebakan5 is 10
        )
    ),
    printSpaces(KosongJebakan5),
    write('('),
    (
        (Jebakan5 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan5 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan5),
    write('|'), nl,
    
    printExtraLineWithColumn(1),
    printSpaces(15),
    write('        || |   ,                          \'-\' '),
    printSpaces(22),
    printExtraLineWithColumn(1), nl,

    printSeparatedLine,
    printSpaces(15),
    write('        || |  | |                             '),
    printSpaces(22),
    printSeparatedLine, nl,

    printExtraLineWithColumn(1),
    printSpaces(15),
    write('        || \'--\' |                             '),
    printSpaces(22),
    printExtraLineWithColumn(1), nl,

    /* petak N */
    write('|'),
    printSpaces(13),
    write('N'),
    printSpaces(13),
    write('|'),

    printSpaces(15),
    write('  ,,    || .----\'                             '),
    printSpaces(22),

    /* petak F */
    write('|'),
    printSpaces(13),
    write('F'),
    printSpaces(13),
    write('|'), nl,

    /* unta di petak N */
    write('|'),
    petak(14, ListUnta14),
    count(ListUnta14, JumlahUnta14),
    (
        (JumlahUnta14 == 0) -> (
            Kosong14 is 12
        ) ; (
            Kosong14 is ceiling((27 - ((JumlahUnta14 * 2) + ((JumlahUnta14 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong14),
    write('['),
    (
        (JumlahUnta14 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta14, ListUnta14HasilTranslate),
            printUntaPetak(ListUnta14HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta14 == 0) -> (
            printSpaces(27 - Kosong14 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong14 - ((JumlahUnta14 * 2) + ((JumlahUnta14 - 1) * 2) + 2))
        )
    ),
    write('|'),

    printSpaces(15),
    write(' || |   || |           Camel POP!               '),
    printSpaces(20),

    /* unta di petak F */
    write('|'),
    petak(6, ListUnta6),
    count(ListUnta6, JumlahUnta6),
    (
        (JumlahUnta6 == 0) -> (
            Kosong6 is 12
        ) ; (
            Kosong6 is ceiling((27 - ((JumlahUnta6 * 2) + ((JumlahUnta6 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong6),
    write('['),
    (
        (JumlahUnta6 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta6, ListUnta6HasilTranslate),
            printUntaPetak(ListUnta6HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta6 == 0) -> (
            printSpaces(27 - Kosong6 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong6 - ((JumlahUnta6 * 2) + ((JumlahUnta6 - 1) * 2) + 2))
        )
    ),
    write('|'), nl,

    /* jebakan di petak N */
    write('|'),
    posisiJebakan(14, Jebakan14, Nama14),
    (
        (Jebakan14 == ' ') -> (
            KosongJebakan14 is 12
        ) ; (
            KosongJebakan14 is 10
        )
    ),
    printSpaces(KosongJebakan14),
    write('('),
    (
        (Jebakan14 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan14 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan14),
    write('|'),

    printSpaces(15),
    write(' |  \'---\'| |                                  '),
    printSpaces(22),

    /* jebakan di petak F */
    write('|'),
    posisiJebakan(6, Jebakan6, Nama6),
    (
        (Jebakan6 == ' ') -> (
            KosongJebakan6 is 12
        ) ; (
            KosongJebakan6 is 10
        )
    ),
    printSpaces(KosongJebakan6),
    write('('),
    (
        (Jebakan6 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan6 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan6),
    write('|'), nl,

    printExtraLineWithColumn(1),
    printSpaces(15),
    write(' \'------.| |                                  _____'),
    printSpaces(17),
    printExtraLineWithColumn(1), nl,

    printSeparatedLine,
    printSpaces(15),
    write('        || |        (  _                     / /|\\ \\ '),
    printSpaces(15),
    printSeparatedLine, nl,

    printExtraLineWithColumn(1),
    printSpaces(15),
    write('        || |        ))("),                  | | | | |'),
    printSpaces(15),
    printExtraLineWithColumn(1), nl,

    /* petak M */
    write('|'),
    printSpaces(13),
    write('M'),
    printSpaces(13),
    write('|'),

    printSpaces(15),
    write('________||_|_______((__^_))__________________\\_\\|/_/__   '),
    printSpaces(11),

    /* petak G */
    write('|'),
    printSpaces(13),
    write('G'),
    printSpaces(13),
    write('|'), nl,

    /* unta di petak M */
    write('|'),
    petak(13, ListUnta13),
    count(ListUnta13, JumlahUnta13),
    (
        (JumlahUnta13 == 0) -> (
            Kosong13 is 12
        ) ; (
            Kosong13 is ceiling((27 - ((JumlahUnta13 * 2) + ((JumlahUnta13 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong13),
    write('['),
    (
        (JumlahUnta13 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta13, ListUnta13HasilTranslate),
            printUntaPetak(ListUnta13HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta13 == 0) -> (
            printSpaces(27 - Kosong13 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong13 - ((JumlahUnta13 * 2) + ((JumlahUnta13 - 1) * 2) + 2))
        )
    ),
    write('|'),

    printSpaces(83),

    /* unta di petak G */
    write('|'),
    petak(7, ListUnta7),
    count(ListUnta7, JumlahUnta7),
    (
        (JumlahUnta7 == 0) -> (
            Kosong7 is 12
        ) ; (
            Kosong7 is ceiling((27 - ((JumlahUnta7 * 2) + ((JumlahUnta7 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong7),
    write('['),
    (
        (JumlahUnta7 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta7, ListUnta7HasilTranslate),
            printUntaPetak(ListUnta7HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta7 == 0) -> (
            printSpaces(27 - Kosong7 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong7 - ((JumlahUnta7 * 2) + ((JumlahUnta7 - 1) * 2) + 2))
        )
    ),
    write('|'), nl,

    /* jebakan di petak M */
    write('|'),
    posisiJebakan(13, Jebakan13, Nama13),
    (
        (Jebakan13 == ' ') -> (
            KosongJebakan13 is 12
        ) ; (
            KosongJebakan13 is 10
        )
    ),
    printSpaces(KosongJebakan13),
    write('('),
    (
        (Jebakan13 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan13 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan13),
    write('|'),

    printSpaces(83),

    /* jebakan di petak G */
    write('|'),
    posisiJebakan(7, Jebakan7, Nama7),
    (
        (Jebakan7 == ' ') -> (
            KosongJebakan7 is 12
        ) ; (
            KosongJebakan7 is 10
        )
    ),
    printSpaces(KosongJebakan7),
    write('('),
    (
        (Jebakan7 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan7 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan7),
    write('|'), nl,

    printExtraLineWithColumn(1),
    printSpaces(83),
    printExtraLineWithColumn(1), nl,

    printLine,

    printExtraLineWithColumn(5), nl,

    /* petak L */
    write('|'),
    printSpaces(13),
    write('L'),
    printSpaces(13),
    write('|'),
   
    /* petak K */
    printSpaces(13),
    write('K'),
    printSpaces(13),
    write('|'),

    /* petak J */
    printSpaces(13),
    write('J'),
    printSpaces(13),
    write('|'),

    /* petak I */
    printSpaces(13),
    write('I'),
    printSpaces(13),
    write('|'),

    /* petak H */
    printSpaces(13),
    write('H'),
    printSpaces(13),
    write('|'), nl,

    /* unta di petak L */
    write('|'),
    petak(12, ListUnta12),
    count(ListUnta12, JumlahUnta12),
    (
        (JumlahUnta12 == 0) -> (
            Kosong12 is 12
        ) ; (
            Kosong12 is ceiling((27 - ((JumlahUnta12 * 2) + ((JumlahUnta12 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong12),
    write('['),
    (
        (JumlahUnta12 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta12, ListUnta12HasilTranslate),
            printUntaPetak(ListUnta12HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta12 == 0) -> (
            printSpaces(27 - Kosong12 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong12 - ((JumlahUnta12 * 2) + ((JumlahUnta12 - 1) * 2) + 2))
        )
    ),
    write('|'),

    /* unta di petak K */
    petak(11, ListUnta11),
    count(ListUnta11, JumlahUnta11),
    (
        (JumlahUnta11 == 0) -> (
            Kosong11 is 12
        ) ; (
            Kosong11 is ceiling((27 - ((JumlahUnta11 * 2) + ((JumlahUnta11 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong11),
    write('['),
    (
        (JumlahUnta11 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta11, ListUnta11HasilTranslate),
            printUntaPetak(ListUnta11HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta11 == 0) -> (
            printSpaces(27 - Kosong11 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong11 - ((JumlahUnta11 * 2) + ((JumlahUnta11 - 1) * 2) + 2))
        )
    ),
    write('|'),

    /* unta di petak J */
    petak(10, ListUnta10),
    count(ListUnta10, JumlahUnta10),
    (
        (JumlahUnta10 == 0) -> (
            Kosong10 is 12
        ) ; (
            Kosong10 is ceiling((27 - ((JumlahUnta10 * 2) + ((JumlahUnta10 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong10),
    write('['),
    (
        (JumlahUnta10 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta10, ListUnta10HasilTranslate),
            printUntaPetak(ListUnta10HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta10 == 0) -> (
            printSpaces(27 - Kosong10 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong10 - ((JumlahUnta10 * 2) + ((JumlahUnta10 - 1) * 2) + 2))
        )
    ),
    write('|'),

    /* unta di petak I */
    petak(9, ListUnta9),
    count(ListUnta9, JumlahUnta9),
    (
        (JumlahUnta9 == 0) -> (
            Kosong9 is 12
        ) ; (
            Kosong9 is ceiling((27 - ((JumlahUnta9 * 2) + ((JumlahUnta9 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong9),
    write('['),
    (
        (JumlahUnta9 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta9, ListUnta9HasilTranslate),
            printUntaPetak(ListUnta9HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta9 == 0) -> (
            printSpaces(27 - Kosong9 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong9 - ((JumlahUnta9 * 2) + ((JumlahUnta9 - 1) * 2) + 2))
        )
    ),
    write('|'),

    /* unta di petak H */
    petak(8, ListUnta8),
    count(ListUnta8, JumlahUnta8),
    (
        (JumlahUnta8 == 0) -> (
            Kosong8 is 12
        ) ; (
            Kosong8 is ceiling((27 - ((JumlahUnta8 * 2) + ((JumlahUnta8 - 1) * 2) + 2)) / 2)
        )
    ),
    printSpaces(Kosong8),
    write('['),
    (
        (JumlahUnta8 == 0) -> (
            printSpaces(1)
        ) ; (
            translateListPetak(ListUnta8, ListUnta8HasilTranslate),
            printUntaPetak(ListUnta8HasilTranslate)  
        )
    ),
    write(']'),
    (
        (JumlahUnta8 == 0) -> (
            printSpaces(27 - Kosong8 - (1 + 2))
        ) ; (                
            printSpaces(27 - Kosong8 - ((JumlahUnta8 * 2) + ((JumlahUnta8 - 1) * 2) + 2))
        )
    ),
    write('|'), nl,

    /* jebakan di petak L */
    write('|'),
    posisiJebakan(12, Jebakan12, Nama12),
    (
        (Jebakan12 == ' ') -> (
            KosongJebakan12 is 12
        ) ; (
            KosongJebakan12 is 10
        )
    ),
    printSpaces(KosongJebakan12),
    write('('),
    (
        (Jebakan12 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan12 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan12),
    write('|'),

    /* jebakan di petak K */
    posisiJebakan(11, Jebakan11, Nama11),
    (
        (Jebakan11 == ' ') -> (
            KosongJebakan11 is 12
        ) ; (
            KosongJebakan11 is 10
        )
    ),
    printSpaces(KosongJebakan11),
    write('('),
    (
        (Jebakan11 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan11 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan11),
    write('|'),

    /* jebakan di petak J */
    posisiJebakan(10, Jebakan10, Nama10),
    (
        (Jebakan10 == ' ') -> (
            KosongJebakan10 is 12
        ) ; (
            KosongJebakan10 is 10
        )
    ),
    printSpaces(KosongJebakan10),
    write('('),
    (
        (Jebakan10 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan10 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan10),
    write('|'),

    /* jebakan di petak I */
    posisiJebakan(9, Jebakan9, Nama9),
    (
        (Jebakan9 == ' ') -> (
            KosongJebakan9 is 12
        ) ; (
            KosongJebakan9 is 10
        )
    ),
    printSpaces(KosongJebakan9),
    write('('),
    (
        (Jebakan9 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan9 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan9),
    write('|'),

    /* jebakan di petak H */
    posisiJebakan(8, Jebakan8, Nama8),
    (
        (Jebakan8 == ' ') -> (
            KosongJebakan8 is 12
        ) ; (
            KosongJebakan8 is 10
        )
    ),
    printSpaces(KosongJebakan8),
    write('('),
    (
        (Jebakan8 == 'maju') -> (
            write('Trap>')
        ) ;
        (Jebakan8 == 'mundur') -> (
            write('<Trap')
        ) ; (
            write(' ')
        )
    ),
    write(')'),
    printSpaces(KosongJebakan8),
    write('|'), nl,

    printExtraLineWithColumn(5), nl,

    printLine, !.
