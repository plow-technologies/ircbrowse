--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: channel; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE channel (
    network text NOT NULL,
    name text NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.channel OWNER TO ircbrowse;

--
-- Name: channel_id_seq; Type: SEQUENCE; Schema: public; Owner: ircbrowse
--

CREATE SEQUENCE channel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channel_id_seq OWNER TO ircbrowse;

--
-- Name: channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ircbrowse
--

ALTER SEQUENCE channel_id_seq OWNED BY channel.id;


--
-- Name: conversation_by_year; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE conversation_by_year (
    year integer NOT NULL,
    lines integer NOT NULL,
    channel integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.conversation_by_year OWNER TO ircbrowse;

--
-- Name: event; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE event (
    "timestamp" timestamp with time zone,
    type text,
    nick text,
    text text,
    network integer,
    channel integer,
    id bigint NOT NULL
);


ALTER TABLE public.event OWNER TO ircbrowse;

--
-- Name: event__id_seq1; Type: SEQUENCE; Schema: public; Owner: ircbrowse
--

CREATE SEQUENCE event__id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event__id_seq1 OWNER TO ircbrowse;

--
-- Name: event__id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: ircbrowse
--

ALTER SEQUENCE event__id_seq1 OWNED BY event.id;


--
-- Name: event_count; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE event_count (
    count integer DEFAULT 0 NOT NULL,
    channel integer
);


ALTER TABLE public.event_count OWNER TO ircbrowse;

--
-- Name: event_order_index; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE event_order_index (
    id integer NOT NULL,
    origin integer NOT NULL,
    idx integer NOT NULL
);


ALTER TABLE public.event_order_index OWNER TO ircbrowse;

--
-- Name: general_activity_by_year; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE general_activity_by_year (
    year integer NOT NULL,
    lines integer NOT NULL,
    channel integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.general_activity_by_year OWNER TO ircbrowse;

--
-- Name: network; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE network (
    name text NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.network OWNER TO ircbrowse;

--
-- Name: nick_to_nick; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE nick_to_nick (
    id integer NOT NULL,
    nick1 text NOT NULL,
    nick2 text NOT NULL,
    count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.nick_to_nick OWNER TO ircbrowse;

--
-- Name: nick_to_nick_id_seq; Type: SEQUENCE; Schema: public; Owner: ircbrowse
--

CREATE SEQUENCE nick_to_nick_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nick_to_nick_id_seq OWNER TO ircbrowse;

--
-- Name: nick_to_nick_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ircbrowse
--

ALTER SEQUENCE nick_to_nick_id_seq OWNED BY nick_to_nick.id;


--
-- Name: nick_to_nick_tmp; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE nick_to_nick_tmp (
    id integer NOT NULL,
    nick1 text NOT NULL,
    nick2 text NOT NULL,
    count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.nick_to_nick_tmp OWNER TO ircbrowse;

--
-- Name: nick_to_nick_tmp_id_seq; Type: SEQUENCE; Schema: public; Owner: ircbrowse
--

CREATE SEQUENCE nick_to_nick_tmp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nick_to_nick_tmp_id_seq OWNER TO ircbrowse;

--
-- Name: nick_to_nick_tmp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ircbrowse
--

ALTER SEQUENCE nick_to_nick_tmp_id_seq OWNED BY nick_to_nick_tmp.id;


--
-- Name: version; Type: TABLE; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE TABLE version (
    version integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.version OWNER TO ircbrowse;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ircbrowse
--

ALTER TABLE ONLY channel ALTER COLUMN id SET DEFAULT nextval('channel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ircbrowse
--

ALTER TABLE ONLY event ALTER COLUMN id SET DEFAULT nextval('event__id_seq1'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ircbrowse
--

ALTER TABLE ONLY nick_to_nick ALTER COLUMN id SET DEFAULT nextval('nick_to_nick_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ircbrowse
--

ALTER TABLE ONLY nick_to_nick_tmp ALTER COLUMN id SET DEFAULT nextval('nick_to_nick_tmp_id_seq'::regclass);


--
-- Name: channel_pkey; Type: CONSTRAINT; Schema: public; Owner: ircbrowse; Tablespace: 
--

ALTER TABLE ONLY channel
    ADD CONSTRAINT channel_pkey PRIMARY KEY (id);


--
-- Name: event_order_id_origin; Type: CONSTRAINT; Schema: public; Owner: ircbrowse; Tablespace: 
--

ALTER TABLE ONLY event_order_index
    ADD CONSTRAINT event_order_id_origin UNIQUE (id, origin);


--
-- Name: event_unique; Type: CONSTRAINT; Schema: public; Owner: ircbrowse; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_unique UNIQUE (network, channel, "timestamp", nick, type, text);


--
-- Name: event_unique_id; Type: CONSTRAINT; Schema: public; Owner: ircbrowse; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_unique_id UNIQUE (id);


--
-- Name: nick_to_nick_pkey; Type: CONSTRAINT; Schema: public; Owner: ircbrowse; Tablespace: 
--

ALTER TABLE ONLY nick_to_nick
    ADD CONSTRAINT nick_to_nick_pkey PRIMARY KEY (id);


--
-- Name: nick_to_nick_tmp_pkey; Type: CONSTRAINT; Schema: public; Owner: ircbrowse; Tablespace: 
--

ALTER TABLE ONLY nick_to_nick_tmp
    ADD CONSTRAINT nick_to_nick_tmp_pkey PRIMARY KEY (id);


--
-- Name: event_channel_idx; Type: INDEX; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE INDEX event_channel_idx ON event USING btree (channel);


--
-- Name: event_nick_idx; Type: INDEX; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE INDEX event_nick_idx ON event USING btree (nick);


--
-- Name: event_order_idx; Type: INDEX; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE INDEX event_order_idx ON event_order_index USING btree (id);


--
-- Name: event_order_idx_idx; Type: INDEX; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE INDEX event_order_idx_idx ON event_order_index USING btree (idx);


--
-- Name: event_order_origin_dx; Type: INDEX; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE INDEX event_order_origin_dx ON event_order_index USING btree (origin);


--
-- Name: event_timestamp_idx; Type: INDEX; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE INDEX event_timestamp_idx ON event USING btree ("timestamp");


--
-- Name: event_type_idx; Type: INDEX; Schema: public; Owner: ircbrowse; Tablespace: 
--

CREATE INDEX event_type_idx ON event USING btree (type);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

