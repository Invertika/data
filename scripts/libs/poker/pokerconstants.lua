--- Class PokerConstants
-- Eine statische Klasse (kein Konstruktor!) mit
-- allen Konstanten für die Poker-Engine

PokerConstants = {}

-- Werte der Karten
PokerConstants.CARD_VALUES = {}
PokerConstants.CARD_VALUES[8] = "e Killermade"
PokerConstants.CARD_VALUES[7] = "es Mammut"
PokerConstants.CARD_VALUES[6] = "er Sandkriecher"
PokerConstants.CARD_VALUES[5] = "e Terranite"
PokerConstants.CARD_VALUES[4] = "er Geist"
PokerConstants.CARD_VALUES[3] = "er Zombie"
PokerConstants.CARD_VALUES[2] = "er Sandwurm"
PokerConstants.CARD_VALUES[1] = "e Eidechse"

-- Farben der Karten
PokerConstants.CARD_COLORS = {}
PokerConstants.CARD_COLORS[1] = "rot"
PokerConstants.CARD_COLORS[2] = "blau"
PokerConstants.CARD_COLORS[3] = "grün"
PokerConstants.CARD_COLORS[4] = "gelb"

-- Blatt Wertungen
PokerConstants.SPADE_HIGH_CARD = 1
PokerConstants.SPADE_ONE_PAIR = 2
PokerConstants.SPADE_TWO_PAIR = 3
PokerConstants.SPADE_THREE_OF_A_KIND = 4
PokerConstants.SPADE_STRAIGHT = 5
PokerConstants.SPADE_FLUSH = 6
PokerConstants.SPADE_FULL_HOUSE = 7
PokerConstants.SPADE_FOUR_OF_A_KIND = 8
PokerConstants.SPADE_STRAIGHT_FLUSH = 9
PokerConstants.SPADE_ROYAL_FLUSH = 10

-- Startkarten
PokerConstants.