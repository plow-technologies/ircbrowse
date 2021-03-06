import Data.Conduit.Shell
main =
  run (do cabal "build"
          strip "dist/build/ircbrowse/ircbrowse"
          tar "czf" "ircbrowse.tar.gz" "dist/build/ircbrowse/ircbrowse"
          scp "ircbrowse.tar.gz" "herz:"
          ssh "herz"
              "killall ircbrowse; cd ircbrowse/dist/build/ircbrowse; tar xf ~/ircbrowse.tar.gz")
