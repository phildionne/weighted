--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: collections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE collections (
    id integer NOT NULL,
    subject character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    data hstore,
    type character varying(255),
    slug character varying(255)
);


--
-- Name: collections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE collections_id_seq OWNED BY collections.id;


--
-- Name: collections_sources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE collections_sources (
    collection_id integer,
    source_id integer
);


--
-- Name: contents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contents (
    id integer NOT NULL,
    title character varying(255),
    body text,
    location character varying(255),
    source_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contents_id_seq OWNED BY contents.id;


--
-- Name: contents_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contents_users (
    content_id integer,
    user_id integer
);


--
-- Name: follows; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE follows (
    id integer NOT NULL,
    user_id integer,
    collection_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE follows_id_seq OWNED BY follows.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profiles (
    id integer NOT NULL,
    provider_avatar character varying(255),
    gravatar_email character varying(255),
    name character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profiles_id_seq OWNED BY profiles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sources (
    id integer NOT NULL,
    location character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sources_id_seq OWNED BY sources.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    provider character varying(255),
    uid character varying(255),
    slug character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY collections ALTER COLUMN id SET DEFAULT nextval('collections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contents ALTER COLUMN id SET DEFAULT nextval('contents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY follows ALTER COLUMN id SET DEFAULT nextval('follows_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profiles ALTER COLUMN id SET DEFAULT nextval('profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources ALTER COLUMN id SET DEFAULT nextval('sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: collections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- Name: contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (id);


--
-- Name: follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_collections_on_data; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_collections_on_data ON collections USING gist (data);


--
-- Name: index_collections_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_collections_on_slug ON collections USING btree (slug);


--
-- Name: index_follows_on_collection_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_follows_on_collection_id ON follows USING btree (collection_id);


--
-- Name: index_follows_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_follows_on_user_id ON follows USING btree (user_id);


--
-- Name: index_follows_on_user_id_and_collection_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_follows_on_user_id_and_collection_id ON follows USING btree (user_id, collection_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_slug ON users USING btree (slug);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130211014639');

INSERT INTO schema_migrations (version) VALUES ('20130211215941');

INSERT INTO schema_migrations (version) VALUES ('20130212014650');

INSERT INTO schema_migrations (version) VALUES ('20130212022413');

INSERT INTO schema_migrations (version) VALUES ('20130216172700');

INSERT INTO schema_migrations (version) VALUES ('20130216235118');

INSERT INTO schema_migrations (version) VALUES ('20130317043559');

INSERT INTO schema_migrations (version) VALUES ('20130323200747');

INSERT INTO schema_migrations (version) VALUES ('20130323202138');

INSERT INTO schema_migrations (version) VALUES ('20130604001645');

INSERT INTO schema_migrations (version) VALUES ('20130604001727');

INSERT INTO schema_migrations (version) VALUES ('20130604002323');

INSERT INTO schema_migrations (version) VALUES ('20130607224347');

INSERT INTO schema_migrations (version) VALUES ('20130612012514');

INSERT INTO schema_migrations (version) VALUES ('20130612230549');

INSERT INTO schema_migrations (version) VALUES ('20130613005529');

INSERT INTO schema_migrations (version) VALUES ('20130618020112');

INSERT INTO schema_migrations (version) VALUES ('20130618020638');