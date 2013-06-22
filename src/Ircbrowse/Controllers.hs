{-# LANGUAGE OverloadedStrings #-}

module Ircbrowse.Controllers where

import           Ircbrowse.Data
import           Ircbrowse.Model.Events
import           Ircbrowse.Model.Stats
import           Ircbrowse.Model.Social
import           Ircbrowse.Model.Profile
import           Ircbrowse.Monads
import           Ircbrowse.Types
import           Ircbrowse.Tunes
import           Ircbrowse.View.Browse as V
import           Ircbrowse.View.NickCloud as V
import           Ircbrowse.View.Overview as V
import           Ircbrowse.View.Social as V
import           Ircbrowse.View.Profile as V

import           Data.ByteString (ByteString)
import           Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import           Safe
import           Snap.App
import           Snap.App.Cache
import           System.Locale
import           Text.Blaze.Pagination

--------------------------------------------------------------------------------
-- Controllers

overview :: Controller Config PState ()
overview = do
  range <- getRange
  channel <- getChannelMaybe
  viewCached (Overview channel range) $ do
    stats <- model $ getStats channel range
    return $ V.overview channel range stats

nickProfile :: Controller Config PState ()
nickProfile = do
  nick <- getText "nick"
  recent <- fmap (maybe True (=="true")) (getTextMaybe "recent")
  range <- getRange
  viewCached (Profile nick recent range) $ do
    hours <- model $ activeHours nick recent range
    return $ V.nickProfile nick recent hours

socialGraph :: Controller Config PState ()
socialGraph = do
  range <- getRange
  channel <- getChannelMaybe
  viewCached (Social channel range) $ do
    graph <- model $ getSocialGraph channel range
    return $ V.socialGraph graph

nickCloud :: Controller Config PState ()
nickCloud = do
  range <- getRange
  channel <- getChannelMaybe
  viewCached (NickCloud channel range) $ do
    nicks <- model $ getNickStats channel range
    return $ V.nickCloud nicks

browse :: Controller Config PState ()
browse = do
  evid <- getIntegerMaybe "id"
  timestamp <- getTimestamp
  channel <- getChannel
  q <- getSearchText "q"
  pn <- getPagination "events"
  let pn' = pn { pnResultsPerPage = Just [25,35,50,100] }
  out <- cacheIf (isNothing q) (Browse channel evid pn') $ do
    (pagination,logs) <- model $ getEvents channel evid pn' q
    uri <- getMyURI
    return $ Just $ V.browse uri channel timestamp logs pn' { pnPn = pagination } q
  maybe (return ()) outputText out

--------------------------------------------------------------------------------
-- Utilities

getRange :: Controller c s Range
getRange = do
  now <- io getCurrentTime
  let range = Range (addDays (-31) (utctDay now)) (utctDay now)
  return range

getChannel :: Controller c s Channel
getChannel = getChannelMaybe
             >>= maybe (error "expected a channel on this page!")
                       return

getChannelMaybe :: Controller c s (Maybe Channel)
getChannelMaybe = do
  chan <- getStringMaybe "channel"
  return $ chan >>= parseChan

getTimestamp :: Controller c s (Maybe UTCTime)
getTimestamp = do
  string <- getStringMaybe "timestamp"
  return $ string >>= parseTime defaultTimeLocale "%s"

getSearchText :: ByteString -> Controller c s (Maybe Text)
getSearchText key = do
  v <- getTextMaybe key
  case fmap (T.filter (not.isSpace)) v of
    Nothing -> return Nothing
    Just e | T.null e -> return Nothing
           | otherwise -> return v

-- | Get text (maybe).
getTextMaybe :: ByteString -> Controller c s (Maybe Text)
getTextMaybe name = do
  pid <- fmap (fmap T.decodeUtf8) (getParam name)
  return pid

-- | Get text (maybe).
getText :: ByteString -> Controller c s Text
getText name = do
  getTextMaybe name >>= maybe (error "expected param") return

-- | Get integer parmater.
getIntegerMaybe :: ByteString -> Controller c s (Maybe Integer)
getIntegerMaybe name = do
  pid <- fmap (>>= readMay) (getStringMaybe name)
  return pid
