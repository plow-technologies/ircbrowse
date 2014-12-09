module Ircbrowse.Types.Import where

-- | Pretty print a channel in a human-representation.
prettyChan :: Channel -> String
prettyChan Plowtech = "#plowtech"
prettyChan Haskell = "#haskell"
prettyChan Lisp = "#lisp"
prettyChan HaskellGame = "#haskell-game"
prettyChan Diagrams = "#diagrams"
prettyChan Tasty = "#tasty"
prettyChan HaskellDistributed = "#haskell-distributed"
prettyChan NumericalHaskell = "#numerical-haskell"
prettyChan FSharp = "##fsharp"
prettyChan Ghcjs = "#ghcjs"
prettyChan HaskellBeginners = "#haskell-beginners"
prettyChan HLedger = "#hledger"
prettyChan Typelevel = "#typelevel"
prettyChan Scalaz = "#scalaz"
prettyChan Shapeless = "#shapeless"
prettyChan Purescript = "#purescript"


-- | Show a channel.
showChan :: Channel -> String
showChan Plowtech = "plowtech"
showChan Haskell = "haskell"
showChan Lisp = "lisp"
showChan HaskellGame = "haskell-game"
showChan Diagrams = "diagrams"
showChan Tasty = "tasty"
showChan HaskellDistributed = "haskell-distributed"
showChan HaskellBeginners = "haskell-beginners"
showChan NumericalHaskell = "numerical-haskell"
showChan FSharp = "fsharp"
showChan Ghcjs = "ghcjs"
showChan HLedger = "hledger"
showChan Typelevel = "typelevel"
showChan Scalaz = "scalaz"
showChan Shapeless = "shapeless"
showChan Purescript = "purescript"


-- | Show a channel.
showChanInt :: Channel -> Int
showChanInt Plowtech = 1
showChanInt Haskell = 2
showChanInt Lisp = 3
showChanInt HaskellGame = 4
showChanInt Diagrams = 5
showChanInt Tasty = 6
showChanInt HaskellDistributed = 7
showChanInt NumericalHaskell = 8
showChanInt FSharp = 9
showChanInt Ghcjs = 10
showChanInt HaskellBeginners = 11
showChanInt HLedger = 12
showChanInt Typelevel = 13
showChanInt Scalaz = 14
showChanInt Shapeless = 15
showChanInt Purescript = 16


-- | Read a channel.
parseChan :: String -> Maybe Channel
parseChan "plowtech" = Just Plowtech
parseChan "haskell" =  Just Haskell
parseChan "lisp" =  Just Lisp
parseChan "diagrams" =  Just Diagrams
parseChan "haskell-game" = Just HaskellGame
parseChan "tasty" = Just Tasty
parseChan "haskell-beginners" = Just HaskellBeginners
parseChan "haskell-distributed" = Just HaskellDistributed
parseChan "numerical-haskell" = Just NumericalHaskell
parseChan "fsharp" = Just FSharp
parseChan "ghcjs" = Just Ghcjs
parseChan "hledger" = Just HLedger
parseChan "typelevel" = Just Typelevel
parseChan "scalaz" = Just Scalaz
parseChan "shapeless" = Just Shapeless
parseChan "purescript" = Just Purescript
parseChan _ = Nothing


idxNum :: Channel -> Int
idxNum Haskell = 1000
idxNum Lisp = 2000
idxNum HaskellGame = 3000
idxNum Diagrams = 4000
idxNum Tasty = 5000
idxNum HaskellDistributed = 6000
idxNum NumericalHaskell = 7000
idxNum FSharp = 8000
idxNum Ghcjs = 9000
idxNum HaskellBeginners = 10000
idxNum HLedger = 11000
idxNum Typelevel = 12000
idxNum Scalaz = 13000
idxNum Shapeless = 14000
idxNum Purescript = 15000
idxNum Plowtech = 16000

-- | Possible supported channels.
data Channel
  = Haskell
  | Lisp
  | HaskellGame
  | Diagrams
  | Tasty
  | HaskellDistributed
  | NumericalHaskell
  | FSharp
  | Ghcjs
  | HaskellBeginners
  | HLedger
  | Typelevel
  | Scalaz
  | Shapeless
  | Purescript
  | Plowtech
  deriving (Enum)
