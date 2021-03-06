PGDMP     &    ;                 z            the_arendelle2.0    13.2    13.2    ^           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            _           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            `           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            a           1262    17139    the_arendelle2.0    DATABASE     ]   CREATE DATABASE "the_arendelle2.0" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
 "   DROP DATABASE "the_arendelle2.0";
                postgres    false                       1255    17628    check_admin()    FUNCTION     ?  CREATE FUNCTION public.check_admin() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		if (new.institution is null and not exists(select * from user_role u where (u.name like '%Адм%' or u.name like '%адм%' or u.name like '%Adm%' or u.name like '%adm%') and u.id = new.user_role)) then 
			raise exception 'Только у администратора может не быть института %', new.id USING HINT = 'Отсутствует институт';
		end if;
		return new;
	END;
	$$;
 $   DROP FUNCTION public.check_admin();
       public          postgres    false                       1255    25353    check_task()    FUNCTION     ?  CREATE FUNCTION public.check_task() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		if ((select count(*) from task where platform = new.platform) = (select task_count from platform where id = new.platform)) then 
			raise exception 'Слишком большое количество заданий %', new.id USING HINT = 'Проверьте количество заданий';
		end if;
		return new;
	END;
	$$;
 #   DROP FUNCTION public.check_task();
       public          postgres    false                       1255    17609    datetime_create()    FUNCTION     ?   CREATE FUNCTION public.datetime_create() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		new.datetime_created = now();
		return new;
	END;
	$$;
 (   DROP FUNCTION public.datetime_create();
       public          postgres    false                       1255    17603    datetime_create_championship()    FUNCTION     ?   CREATE FUNCTION public.datetime_create_championship() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		new.datetime_created = now();
		return new;
	END;
	$$;
 5   DROP FUNCTION public.datetime_create_championship();
       public          postgres    false                       1255    17605    datetime_create_institution()    FUNCTION     ?   CREATE FUNCTION public.datetime_create_institution() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		new.datetime_created = now();
		return new;
	END;
	$$;
 4   DROP FUNCTION public.datetime_create_institution();
       public          postgres    false                       1255    25355    delete_institution()    FUNCTION     ?   CREATE FUNCTION public.delete_institution() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		update users set institution = null where institution = old.id;
		return old;
	END;
	$$;
 +   DROP FUNCTION public.delete_institution();
       public          postgres    false                       1255    25389     random_between(integer, integer)    FUNCTION     ?   CREATE FUNCTION public.random_between(low integer, high integer) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $$
BEGIN
   RETURN floor(random()* (high-low + 1) + low);
END;
$$;
 @   DROP FUNCTION public.random_between(low integer, high integer);
       public          postgres    false                       1255    25349    update_institution()    FUNCTION     6  CREATE FUNCTION public.update_institution() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		if (exists(select 1 from institution i where i.created_by is null and i.id = new.institution)) then 
			update institution set created_by = new.id where id = new.institution;
		end if;
		return new;
	END;
	$$;
 +   DROP FUNCTION public.update_institution();
       public          postgres    false            
           1255    17599    update_sity_query_count()    FUNCTION     &  CREATE FUNCTION public.update_sity_query_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		if (TG_OP = 'INSERT') then 
			update sity set queries_count = (select queries_count from sity s where s.id = new.sity) + 1
			where sity.id = new.sity;
			return new;
		end if;

		if (TG_OP = 'UPDATE' and new.sity != old.sity) then
			update sity set queries_count = (select queries_count from sity s where s.id = old.sity) - 1
			where sity.id = old.sity;
			update sity set queries_count = (select queries_count from sity s where s.id = new.sity) + 1
			where sity.id = new.sity;
			return new;
		end if;

		if (TG_OP = 'DELETE') then 
			update sity set queries_count = (select queries_count from sity s where s.id = old.sity) - 1
			where sity.id = old.sity;
			return old;
		end if;
	END;
	$$;
 0   DROP FUNCTION public.update_sity_query_count();
       public          postgres    false                       1255    25387    when_action()    FUNCTION     ?   CREATE FUNCTION public.when_action() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		new."when" = now();
		return new;
	END;
	$$;
 $   DROP FUNCTION public.when_action();
       public          postgres    false            ?            1259    17161    institution    TABLE     &  CREATE TABLE public.institution (
    id bigint NOT NULL,
    name character varying(200) NOT NULL,
    datetime_created timestamp with time zone NOT NULL,
    sity bigint NOT NULL,
    institution_status bigint NOT NULL,
    institution_type bigint NOT NULL,
    created_by bigint NOT NULL
);
    DROP TABLE public.institution;
       public         heap    postgres    false            ?            1259    25430    admin_add_college    VIEW     a  CREATE VIEW public.admin_add_college AS
 SELECT institution.id,
    institution.name,
    institution.datetime_created,
    institution.sity,
    institution.institution_status,
    institution.institution_type,
    institution.created_by
   FROM public.institution
  WHERE ((institution.institution_status = 1) AND (institution.institution_type = 2));
 $   DROP VIEW public.admin_add_college;
       public          postgres    false    205    205    205    205    205    205    205            ?            1259    25434    admin_add_institution    VIEW     e  CREATE VIEW public.admin_add_institution AS
 SELECT institution.id,
    institution.name,
    institution.datetime_created,
    institution.sity,
    institution.institution_status,
    institution.institution_type,
    institution.created_by
   FROM public.institution
  WHERE ((institution.institution_status = 1) AND (institution.institution_type = 3));
 (   DROP VIEW public.admin_add_institution;
       public          postgres    false    205    205    205    205    205    205    205            ?            1259    25477    admin_add_school    VIEW     `  CREATE VIEW public.admin_add_school AS
 SELECT institution.id,
    institution.name,
    institution.datetime_created,
    institution.sity,
    institution.institution_status,
    institution.institution_type,
    institution.created_by
   FROM public.institution
  WHERE ((institution.institution_status = 1) AND (institution.institution_type = 1));
 #   DROP VIEW public.admin_add_school;
       public          postgres    false    205    205    205    205    205    205    205            ?            1259    17297    championship    TABLE     ?  CREATE TABLE public.championship (
    id bigint NOT NULL,
    name character varying NOT NULL,
    stage character varying NOT NULL,
    max_team_count integer,
    max_institution_team_count integer,
    created_by bigint NOT NULL,
    championship_status bigint NOT NULL,
    datetime_start timestamp with time zone NOT NULL,
    datetime_end timestamp with time zone NOT NULL,
    datetime_created timestamp with time zone NOT NULL
);
     DROP TABLE public.championship;
       public         heap    postgres    false            ?            1259    17295    championship_id_seq    SEQUENCE     |   CREATE SEQUENCE public.championship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.championship_id_seq;
       public          postgres    false    234            b           0    0    championship_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.championship_id_seq OWNED BY public.championship.id;
          public          postgres    false    233            ?            1259    17319    championship_institution    TABLE     t   CREATE TABLE public.championship_institution (
    championship bigint NOT NULL,
    institution bigint NOT NULL
);
 ,   DROP TABLE public.championship_institution;
       public         heap    postgres    false            ?            1259    17223    task    TABLE     Y  CREATE TABLE public.task (
    id bigint NOT NULL,
    time_for_answer integer,
    platform bigint NOT NULL,
    task_type bigint NOT NULL,
    task_status bigint NOT NULL,
    task_content bigint NOT NULL,
    find_by bigint,
    created_by bigint NOT NULL,
    time_found timestamp with time zone,
    time_solved timestamp with time zone
);
    DROP TABLE public.task;
       public         heap    postgres    false            ?            1259    25360    team_championship_platform    TABLE     ?   CREATE TABLE public.team_championship_platform (
    team bigint NOT NULL,
    championship bigint NOT NULL,
    platform bigint NOT NULL
);
 .   DROP TABLE public.team_championship_platform;
       public         heap    postgres    false            ?            1259    25399    championship_result    VIEW     ^  CREATE VIEW public.championship_result AS
 SELECT tcp.championship,
    tcp.team,
    count(*) AS solved_tasks_count
   FROM (public.team_championship_platform tcp
     JOIN ( SELECT task.id,
            task.time_for_answer,
            task.platform,
            task.task_type,
            task.task_status,
            task.task_content,
            task.find_by,
            task.created_by,
            task.time_found,
            task.time_solved
           FROM public.task
          WHERE (task.time_solved IS NOT NULL)) x ON ((x.platform = tcp.platform)))
  GROUP BY tcp.championship, tcp.team;
 &   DROP VIEW public.championship_result;
       public          postgres    false    219    244    244    244    219    219    219    219    219    219    219    219    219            ?            1259    17273    team    TABLE     ?   CREATE TABLE public.team (
    id bigint NOT NULL,
    name character varying(200) NOT NULL,
    created_by bigint NOT NULL,
    team_status bigint NOT NULL,
    institution bigint NOT NULL,
    datetime_created timestamp with time zone
);
    DROP TABLE public.team;
       public         heap    postgres    false            ?            1259    17281    team_status    TABLE     f   CREATE TABLE public.team_status (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
    DROP TABLE public.team_status;
       public         heap    postgres    false            ?            1259    25448    championship_result_extensive    VIEW     ?  CREATE VIEW public.championship_result_extensive AS
 SELECT c.name AS championship,
    t.name AS team_name,
    ts.name AS team_status,
    i.name AS team_institution,
    cr.solved_tasks_count
   FROM ((((public.championship_result cr
     JOIN public.team t ON ((t.id = cr.team)))
     JOIN public.team_status ts ON ((ts.id = t.team_status)))
     JOIN public.institution i ON ((i.id = t.institution)))
     JOIN public.championship c ON ((c.id = cr.championship)));
 0   DROP VIEW public.championship_result_extensive;
       public          postgres    false    205    205    229    229    229    229    231    231    234    245    245    245    234            c           0    0 #   TABLE championship_result_extensive    ACL     I   GRANT SELECT ON TABLE public.championship_result_extensive TO view_only;
          public          postgres    false    253            ?            1259    17308    championship_status    TABLE     n   CREATE TABLE public.championship_status (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
 '   DROP TABLE public.championship_status;
       public         heap    postgres    false            ?            1259    17306    championship_status_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.championship_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.championship_status_id_seq;
       public          postgres    false    236            d           0    0    championship_status_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.championship_status_id_seq OWNED BY public.championship_status.id;
          public          postgres    false    235            ?            1259    25413    content_solves    VIEW     ?  CREATE VIEW public.content_solves AS
 SELECT DISTINCT t.task_content,
    ( SELECT count(*) AS count
           FROM public.task tt
          WHERE ((tt.time_solved IS NOT NULL) AND (tt.task_content = t.task_content))) AS count_solved,
    ( SELECT count(*) AS count
           FROM public.task tt
          WHERE (tt.task_content = t.task_content)) AS count_tried
   FROM public.task t;
 !   DROP VIEW public.content_solves;
       public          postgres    false    219    219            ?            1259    17159    institution_id_seq    SEQUENCE     {   CREATE SEQUENCE public.institution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.institution_id_seq;
       public          postgres    false    205            e           0    0    institution_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.institution_id_seq OWNED BY public.institution.id;
          public          postgres    false    204            ?            1259    17177    institution_status    TABLE     m   CREATE TABLE public.institution_status (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
 &   DROP TABLE public.institution_status;
       public         heap    postgres    false            ?            1259    17175    institution_status_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.institution_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.institution_status_id_seq;
       public          postgres    false    209            f           0    0    institution_status_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.institution_status_id_seq OWNED BY public.institution_status.id;
          public          postgres    false    208            ?            1259    17185    institution_type    TABLE     k   CREATE TABLE public.institution_type (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
 $   DROP TABLE public.institution_type;
       public         heap    postgres    false            ?            1259    17183    institution_type_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.institution_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.institution_type_id_seq;
       public          postgres    false    211            g           0    0    institution_type_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.institution_type_id_seq OWNED BY public.institution_type.id;
          public          postgres    false    210            ?            1259    17212    map    TABLE     j   CREATE TABLE public.map (
    id bigint NOT NULL,
    graph bytea NOT NULL,
    picture bytea NOT NULL
);
    DROP TABLE public.map;
       public         heap    postgres    false            ?            1259    17210 
   map_id_seq    SEQUENCE     s   CREATE SEQUENCE public.map_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.map_id_seq;
       public          postgres    false    217            h           0    0 
   map_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.map_id_seq OWNED BY public.map.id;
          public          postgres    false    216            ?            1259    25417    most_solved_content    VIEW     ?  CREATE VIEW public.most_solved_content AS
 SELECT x.content,
    x.cnt AS count_solved
   FROM ( SELECT task.task_content AS content,
            count(*) AS cnt
           FROM public.task
          WHERE (task.time_solved IS NOT NULL)
          GROUP BY task.task_content) x
  WHERE (x.cnt = ( SELECT max(xx.cnt) AS max
           FROM ( SELECT count(*) AS cnt
                   FROM public.task
                  WHERE (task.time_solved IS NOT NULL)
                  GROUP BY task.task_content) xx));
 &   DROP VIEW public.most_solved_content;
       public          postgres    false    219    219            ?            1259    25421    most_unsolved_content    VIEW     ?  CREATE VIEW public.most_unsolved_content AS
 SELECT x.content,
    x.cnt AS count_tried
   FROM ( SELECT task.task_content AS content,
            count(*) AS cnt
           FROM public.task
          WHERE (task.time_solved IS NULL)
          GROUP BY task.task_content) x
  WHERE (x.cnt = ( SELECT max(xx.cnt) AS max
           FROM ( SELECT count(*) AS cnt
                   FROM public.task
                  WHERE (task.time_solved IS NOT NULL)
                  GROUP BY task.task_content) xx));
 (   DROP VIEW public.most_unsolved_content;
       public          postgres    false    219    219            ?            1259    17326    notification    TABLE     ?  CREATE TABLE public.notification (
    id bigint NOT NULL,
    message character varying(256),
    notification_type bigint NOT NULL,
    notification_status bigint NOT NULL,
    "from" bigint NOT NULL,
    "to" bigint NOT NULL,
    institution_register bigint,
    team_register bigint,
    datetime_created timestamp with time zone NOT NULL,
    championship bigint,
    team bigint
);
     DROP TABLE public.notification;
       public         heap    postgres    false            ?            1259    17324    notification_id_seq    SEQUENCE     |   CREATE SEQUENCE public.notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.notification_id_seq;
       public          postgres    false    239            i           0    0    notification_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;
          public          postgres    false    238            ?            1259    17345    notification_status    TABLE     n   CREATE TABLE public.notification_status (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
 '   DROP TABLE public.notification_status;
       public         heap    postgres    false            ?            1259    17343    notification_status_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.notification_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.notification_status_id_seq;
       public          postgres    false    243            j           0    0    notification_status_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.notification_status_id_seq OWNED BY public.notification_status.id;
          public          postgres    false    242            ?            1259    17337    notification_type    TABLE     l   CREATE TABLE public.notification_type (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
 %   DROP TABLE public.notification_type;
       public         heap    postgres    false            ?            1259    17335    notification_type_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.notification_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.notification_type_id_seq;
       public          postgres    false    241            k           0    0    notification_type_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.notification_type_id_seq OWNED BY public.notification_type.id;
          public          postgres    false    240            ?            1259    17193    platform    TABLE     =  CREATE TABLE public.platform (
    id bigint NOT NULL,
    color character varying(30) NOT NULL,
    task_count integer NOT NULL,
    additional_task_count integer NOT NULL,
    map bigint NOT NULL,
    created_by bigint NOT NULL,
    platform_status bigint NOT NULL,
    datetime_created timestamp with time zone
);
    DROP TABLE public.platform;
       public         heap    postgres    false            ?            1259    17191    platform_id_seq    SEQUENCE     x   CREATE SEQUENCE public.platform_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.platform_id_seq;
       public          postgres    false    213            l           0    0    platform_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.platform_id_seq OWNED BY public.platform.id;
          public          postgres    false    212            ?            1259    17201    platform_status    TABLE     j   CREATE TABLE public.platform_status (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
 #   DROP TABLE public.platform_status;
       public         heap    postgres    false            ?            1259    17199    platform_status_id_seq    SEQUENCE        CREATE SEQUENCE public.platform_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.platform_status_id_seq;
       public          postgres    false    215            m           0    0    platform_status_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.platform_status_id_seq OWNED BY public.platform_status.id;
          public          postgres    false    214            ?            1259    17169    sity    TABLE     _   CREATE TABLE public.sity (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
    DROP TABLE public.sity;
       public         heap    postgres    false            ?            1259    17167    sity_id_seq    SEQUENCE     t   CREATE SEQUENCE public.sity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.sity_id_seq;
       public          postgres    false    207            n           0    0    sity_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.sity_id_seq OWNED BY public.sity.id;
          public          postgres    false    206            ?            1259    17253    task_content    TABLE     ?   CREATE TABLE public.task_content (
    id bigint NOT NULL,
    content bytea NOT NULL,
    answer character varying(500) NOT NULL,
    type_of_response bigint NOT NULL,
    created_by bigint NOT NULL,
    datetime_created timestamp with time zone
);
     DROP TABLE public.task_content;
       public         heap    postgres    false            ?            1259    17251    task_content_id_seq    SEQUENCE     |   CREATE SEQUENCE public.task_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.task_content_id_seq;
       public          postgres    false    225            o           0    0    task_content_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.task_content_id_seq OWNED BY public.task_content.id;
          public          postgres    false    224            ?            1259    17221    task_id_seq    SEQUENCE     t   CREATE SEQUENCE public.task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.task_id_seq;
       public          postgres    false    219            p           0    0    task_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.task_id_seq OWNED BY public.task.id;
          public          postgres    false    218            ?            1259    17242    task_status    TABLE     a   CREATE TABLE public.task_status (
    id bigint NOT NULL,
    name character varying NOT NULL
);
    DROP TABLE public.task_status;
       public         heap    postgres    false            ?            1259    17240    task_status_id_seq    SEQUENCE     {   CREATE SEQUENCE public.task_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.task_status_id_seq;
       public          postgres    false    223            q           0    0    task_status_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.task_status_id_seq OWNED BY public.task_status.id;
          public          postgres    false    222            ?            1259    17231 	   task_type    TABLE     _   CREATE TABLE public.task_type (
    id bigint NOT NULL,
    name character varying NOT NULL
);
    DROP TABLE public.task_type;
       public         heap    postgres    false            ?            1259    17229    task_type_id_seq    SEQUENCE     y   CREATE SEQUENCE public.task_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.task_type_id_seq;
       public          postgres    false    221            r           0    0    task_type_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.task_type_id_seq OWNED BY public.task_type.id;
          public          postgres    false    220            ?            1259    17271    team_id_seq    SEQUENCE     t   CREATE SEQUENCE public.team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.team_id_seq;
       public          postgres    false    229            s           0    0    team_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;
          public          postgres    false    228            ?            1259    17279    team_status_id_seq    SEQUENCE     {   CREATE SEQUENCE public.team_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.team_status_id_seq;
       public          postgres    false    231            t           0    0    team_status_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.team_status_id_seq OWNED BY public.team_status.id;
          public          postgres    false    230            ?            1259    17289    team_task_user    TABLE     ?   CREATE TABLE public.team_task_user (
    team bigint NOT NULL,
    task bigint NOT NULL,
    "user" bigint NOT NULL,
    "when" timestamp with time zone NOT NULL
);
 "   DROP TABLE public.team_task_user;
       public         heap    postgres    false            ?            1259    17265    type_of_response    TABLE     k   CREATE TABLE public.type_of_response (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
 $   DROP TABLE public.type_of_response;
       public         heap    postgres    false            ?            1259    17263    type_of_response_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.type_of_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.type_of_response_id_seq;
       public          postgres    false    227            u           0    0    type_of_response_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.type_of_response_id_seq OWNED BY public.type_of_response.id;
          public          postgres    false    226            ?            1259    17142    users    TABLE     ?  CREATE TABLE public.users (
    user_role bigint NOT NULL,
    surname character varying(80) NOT NULL,
    password character varying(32) NOT NULL,
    nickname character varying(50) NOT NULL,
    name character varying(80) NOT NULL,
    institution bigint,
    id bigint NOT NULL,
    datetime_created timestamp with time zone NOT NULL,
    color character varying(30) NOT NULL,
    avatar bytea,
    team bigint
);
    DROP TABLE public.users;
       public         heap    postgres    false            ?            1259    17140    user_id_seq    SEQUENCE     t   CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public          postgres    false    201            v           0    0    user_id_seq    SEQUENCE OWNED BY     <   ALTER SEQUENCE public.user_id_seq OWNED BY public.users.id;
          public          postgres    false    200            ?            1259    25404    user_solved_tasks_count    VIEW     ?  CREATE VIEW public.user_solved_tasks_count AS
 SELECT u.id AS user_id,
        CASE
            WHEN (xx.solved_tasks_count IS NULL) THEN (0)::bigint
            ELSE xx.solved_tasks_count
        END AS solved_tasks_count
   FROM (public.users u
     LEFT JOIN ( SELECT ttu2."user",
            count(ttu2.task) AS solved_tasks_count
           FROM (public.team_task_user ttu2
             JOIN ( SELECT ttu.team,
                    ttu.task,
                    max(ttu."when") AS m
                   FROM public.team_task_user ttu
                  GROUP BY ttu.team, ttu.task) x ON (((x.team = ttu2.team) AND (x.task = ttu2.task) AND (x.m = ttu2."when"))))
          GROUP BY ttu2."user") xx ON ((xx."user" = u.id)));
 *   DROP VIEW public.user_solved_tasks_count;
       public          postgres    false    232    232    232    232    201            ?            1259    25443    user_result_extensive    VIEW     s  CREATE VIEW public.user_result_extensive AS
 SELECT u.nickname,
    i.name AS institution,
    t.name AS team,
    us.solved_tasks_count
   FROM (((public.user_solved_tasks_count us
     JOIN public.users u ON ((us.user_id = u.id)))
     JOIN public.institution i ON ((i.id = u.institution)))
     LEFT JOIN public.team t ON ((t.id = u.team)))
  WHERE (u.user_role = 1);
 (   DROP VIEW public.user_result_extensive;
       public          postgres    false    229    201    201    201    201    201    205    205    229    246    246            w           0    0    TABLE user_result_extensive    ACL     A   GRANT SELECT ON TABLE public.user_result_extensive TO view_only;
          public          postgres    false    252            ?            1259    17153 	   user_role    TABLE     d   CREATE TABLE public.user_role (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);
    DROP TABLE public.user_role;
       public         heap    postgres    false            ?            1259    17151    user_role_id_seq    SEQUENCE     y   CREATE SEQUENCE public.user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_role_id_seq;
       public          postgres    false    203            x           0    0    user_role_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.user_role_id_seq OWNED BY public.user_role.id;
          public          postgres    false    202                       2604    17300    championship id    DEFAULT     r   ALTER TABLE ONLY public.championship ALTER COLUMN id SET DEFAULT nextval('public.championship_id_seq'::regclass);
 >   ALTER TABLE public.championship ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234                       2604    17311    championship_status id    DEFAULT     ?   ALTER TABLE ONLY public.championship_status ALTER COLUMN id SET DEFAULT nextval('public.championship_status_id_seq'::regclass);
 E   ALTER TABLE public.championship_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    236    236            ?           2604    17164    institution id    DEFAULT     p   ALTER TABLE ONLY public.institution ALTER COLUMN id SET DEFAULT nextval('public.institution_id_seq'::regclass);
 =   ALTER TABLE public.institution ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            ?           2604    17180    institution_status id    DEFAULT     ~   ALTER TABLE ONLY public.institution_status ALTER COLUMN id SET DEFAULT nextval('public.institution_status_id_seq'::regclass);
 D   ALTER TABLE public.institution_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            ?           2604    17188    institution_type id    DEFAULT     z   ALTER TABLE ONLY public.institution_type ALTER COLUMN id SET DEFAULT nextval('public.institution_type_id_seq'::regclass);
 B   ALTER TABLE public.institution_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            ?           2604    17215    map id    DEFAULT     `   ALTER TABLE ONLY public.map ALTER COLUMN id SET DEFAULT nextval('public.map_id_seq'::regclass);
 5   ALTER TABLE public.map ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217                       2604    17329    notification id    DEFAULT     r   ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);
 >   ALTER TABLE public.notification ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239                       2604    17348    notification_status id    DEFAULT     ?   ALTER TABLE ONLY public.notification_status ALTER COLUMN id SET DEFAULT nextval('public.notification_status_id_seq'::regclass);
 E   ALTER TABLE public.notification_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    243    242    243                       2604    17340    notification_type id    DEFAULT     |   ALTER TABLE ONLY public.notification_type ALTER COLUMN id SET DEFAULT nextval('public.notification_type_id_seq'::regclass);
 C   ALTER TABLE public.notification_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    241    241            ?           2604    17196    platform id    DEFAULT     j   ALTER TABLE ONLY public.platform ALTER COLUMN id SET DEFAULT nextval('public.platform_id_seq'::regclass);
 :   ALTER TABLE public.platform ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            ?           2604    17204    platform_status id    DEFAULT     x   ALTER TABLE ONLY public.platform_status ALTER COLUMN id SET DEFAULT nextval('public.platform_status_id_seq'::regclass);
 A   ALTER TABLE public.platform_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            ?           2604    17172    sity id    DEFAULT     b   ALTER TABLE ONLY public.sity ALTER COLUMN id SET DEFAULT nextval('public.sity_id_seq'::regclass);
 6   ALTER TABLE public.sity ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            ?           2604    17226    task id    DEFAULT     b   ALTER TABLE ONLY public.task ALTER COLUMN id SET DEFAULT nextval('public.task_id_seq'::regclass);
 6   ALTER TABLE public.task ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219                       2604    17256    task_content id    DEFAULT     r   ALTER TABLE ONLY public.task_content ALTER COLUMN id SET DEFAULT nextval('public.task_content_id_seq'::regclass);
 >   ALTER TABLE public.task_content ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225                       2604    17245    task_status id    DEFAULT     p   ALTER TABLE ONLY public.task_status ALTER COLUMN id SET DEFAULT nextval('public.task_status_id_seq'::regclass);
 =   ALTER TABLE public.task_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223                        2604    17234    task_type id    DEFAULT     l   ALTER TABLE ONLY public.task_type ALTER COLUMN id SET DEFAULT nextval('public.task_type_id_seq'::regclass);
 ;   ALTER TABLE public.task_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221                       2604    17276    team id    DEFAULT     b   ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);
 6   ALTER TABLE public.team ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    229    229            
           2604    17284    team_status id    DEFAULT     p   ALTER TABLE ONLY public.team_status ALTER COLUMN id SET DEFAULT nextval('public.team_status_id_seq'::regclass);
 =   ALTER TABLE public.team_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231                       2604    17268    type_of_response id    DEFAULT     z   ALTER TABLE ONLY public.type_of_response ALTER COLUMN id SET DEFAULT nextval('public.type_of_response_id_seq'::regclass);
 B   ALTER TABLE public.type_of_response ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            ?           2604    17156    user_role id    DEFAULT     l   ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq'::regclass);
 ;   ALTER TABLE public.user_role ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            ?           2604    17145    users id    DEFAULT     c   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            Q          0    17297    championship 
   TABLE DATA           ?   COPY public.championship (id, name, stage, max_team_count, max_institution_team_count, created_by, championship_status, datetime_start, datetime_end, datetime_created) FROM stdin;
    public          postgres    false    234   ?q      T          0    17319    championship_institution 
   TABLE DATA           M   COPY public.championship_institution (championship, institution) FROM stdin;
    public          postgres    false    237   3s      S          0    17308    championship_status 
   TABLE DATA           7   COPY public.championship_status (id, name) FROM stdin;
    public          postgres    false    236   ?s      4          0    17161    institution 
   TABLE DATA           y   COPY public.institution (id, name, datetime_created, sity, institution_status, institution_type, created_by) FROM stdin;
    public          postgres    false    205   ?s      8          0    17177    institution_status 
   TABLE DATA           6   COPY public.institution_status (id, name) FROM stdin;
    public          postgres    false    209   ?u      :          0    17185    institution_type 
   TABLE DATA           4   COPY public.institution_type (id, name) FROM stdin;
    public          postgres    false    211   ?u      @          0    17212    map 
   TABLE DATA           1   COPY public.map (id, graph, picture) FROM stdin;
    public          postgres    false    217   ?v      V          0    17326    notification 
   TABLE DATA           ?   COPY public.notification (id, message, notification_type, notification_status, "from", "to", institution_register, team_register, datetime_created, championship, team) FROM stdin;
    public          postgres    false    239   ?v      Z          0    17345    notification_status 
   TABLE DATA           7   COPY public.notification_status (id, name) FROM stdin;
    public          postgres    false    243   ?w      X          0    17337    notification_type 
   TABLE DATA           5   COPY public.notification_type (id, name) FROM stdin;
    public          postgres    false    241   ?w      <          0    17193    platform 
   TABLE DATA           ?   COPY public.platform (id, color, task_count, additional_task_count, map, created_by, platform_status, datetime_created) FROM stdin;
    public          postgres    false    213   ?x      >          0    17201    platform_status 
   TABLE DATA           3   COPY public.platform_status (id, name) FROM stdin;
    public          postgres    false    215   By      6          0    17169    sity 
   TABLE DATA           (   COPY public.sity (id, name) FROM stdin;
    public          postgres    false    207   ?y      B          0    17223    task 
   TABLE DATA           ?   COPY public.task (id, time_for_answer, platform, task_type, task_status, task_content, find_by, created_by, time_found, time_solved) FROM stdin;
    public          postgres    false    219   ??      H          0    17253    task_content 
   TABLE DATA           k   COPY public.task_content (id, content, answer, type_of_response, created_by, datetime_created) FROM stdin;
    public          postgres    false    225   ?      F          0    17242    task_status 
   TABLE DATA           /   COPY public.task_status (id, name) FROM stdin;
    public          postgres    false    223   D?      D          0    17231 	   task_type 
   TABLE DATA           -   COPY public.task_type (id, name) FROM stdin;
    public          postgres    false    221   ??      L          0    17273    team 
   TABLE DATA           `   COPY public.team (id, name, created_by, team_status, institution, datetime_created) FROM stdin;
    public          postgres    false    229   ܝ      [          0    25360    team_championship_platform 
   TABLE DATA           R   COPY public.team_championship_platform (team, championship, platform) FROM stdin;
    public          postgres    false    244   ?      N          0    17281    team_status 
   TABLE DATA           /   COPY public.team_status (id, name) FROM stdin;
    public          postgres    false    231   `?      O          0    17289    team_task_user 
   TABLE DATA           D   COPY public.team_task_user (team, task, "user", "when") FROM stdin;
    public          postgres    false    232   ??      J          0    17265    type_of_response 
   TABLE DATA           4   COPY public.type_of_response (id, name) FROM stdin;
    public          postgres    false    227   ??      2          0    17153 	   user_role 
   TABLE DATA           -   COPY public.user_role (id, name) FROM stdin;
    public          postgres    false    203   ??      0          0    17142    users 
   TABLE DATA           ?   COPY public.users (user_role, surname, password, nickname, name, institution, id, datetime_created, color, avatar, team) FROM stdin;
    public          postgres    false    201   B?      y           0    0    championship_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.championship_id_seq', 27, true);
          public          postgres    false    233            z           0    0    championship_status_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.championship_status_id_seq', 3, true);
          public          postgres    false    235            {           0    0    institution_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.institution_id_seq', 24, true);
          public          postgres    false    204            |           0    0    institution_status_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.institution_status_id_seq', 2, true);
          public          postgres    false    208            }           0    0    institution_type_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.institution_type_id_seq', 5, true);
          public          postgres    false    210            ~           0    0 
   map_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.map_id_seq', 1, true);
          public          postgres    false    216                       0    0    notification_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.notification_id_seq', 21, true);
          public          postgres    false    238            ?           0    0    notification_status_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.notification_status_id_seq', 2, true);
          public          postgres    false    242            ?           0    0    notification_type_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.notification_type_id_seq', 4, true);
          public          postgres    false    240            ?           0    0    platform_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.platform_id_seq', 18, true);
          public          postgres    false    212            ?           0    0    platform_status_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.platform_status_id_seq', 3, true);
          public          postgres    false    214            ?           0    0    sity_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.sity_id_seq', 1116, true);
          public          postgres    false    206            ?           0    0    task_content_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.task_content_id_seq', 108, true);
          public          postgres    false    224            ?           0    0    task_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.task_id_seq', 75, true);
          public          postgres    false    218            ?           0    0    task_status_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.task_status_id_seq', 3, true);
          public          postgres    false    222            ?           0    0    task_type_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.task_type_id_seq', 2, true);
          public          postgres    false    220            ?           0    0    team_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.team_id_seq', 25, true);
          public          postgres    false    228            ?           0    0    team_status_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.team_status_id_seq', 4, true);
          public          postgres    false    230            ?           0    0    type_of_response_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.type_of_response_id_seq', 3, true);
          public          postgres    false    226            ?           0    0    user_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.user_id_seq', 64, true);
          public          postgres    false    200            ?           0    0    user_role_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_role_id_seq', 3, true);
          public          postgres    false    202            ?           2606    17564    platform additional_ task_cnt    CHECK CONSTRAINT     v   ALTER TABLE public.platform
    ADD CONSTRAINT "additional_ task_cnt" CHECK ((additional_task_count >= 0)) NOT VALID;
 D   ALTER TABLE public.platform DROP CONSTRAINT "additional_ task_cnt";
       public          postgres    false    213    213                       2606    25342    task_content answer_exists    CHECK CONSTRAINT     q   ALTER TABLE public.task_content
    ADD CONSTRAINT answer_exists CHECK (((answer)::text <> ''::text)) NOT VALID;
 ?   ALTER TABLE public.task_content DROP CONSTRAINT answer_exists;
       public          postgres    false    225    225            c           2606    17323 6   championship_institution championship_institution_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.championship_institution
    ADD CONSTRAINT championship_institution_pkey PRIMARY KEY (championship, institution);
 `   ALTER TABLE ONLY public.championship_institution DROP CONSTRAINT championship_institution_pkey;
       public            postgres    false    237    237            [           2606    17541 )   championship championship_name_stage_uniq 
   CONSTRAINT     k   ALTER TABLE ONLY public.championship
    ADD CONSTRAINT championship_name_stage_uniq UNIQUE (name, stage);
 S   ALTER TABLE ONLY public.championship DROP CONSTRAINT championship_name_stage_uniq;
       public            postgres    false    234    234            ]           2606    17305    championship championship_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.championship
    ADD CONSTRAINT championship_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.championship DROP CONSTRAINT championship_pkey;
       public            postgres    false    234            _           2606    17313 ,   championship_status championship_status_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.championship_status
    ADD CONSTRAINT championship_status_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.championship_status DROP CONSTRAINT championship_status_pkey;
       public            postgres    false    236            ?           2606    17598    users color_exists    CHECK CONSTRAINT     h   ALTER TABLE public.users
    ADD CONSTRAINT color_exists CHECK (((color)::text <> ''::text)) NOT VALID;
 7   ALTER TABLE public.users DROP CONSTRAINT color_exists;
       public          postgres    false    201    201            ?           2606    25339    platform color_exists    CHECK CONSTRAINT     k   ALTER TABLE public.platform
    ADD CONSTRAINT color_exists CHECK (((color)::text <> ''::text)) NOT VALID;
 :   ALTER TABLE public.platform DROP CONSTRAINT color_exists;
       public          postgres    false    213    213                       2606    25352    users color_uniq 
   CONSTRAINT     L   ALTER TABLE ONLY public.users
    ADD CONSTRAINT color_uniq UNIQUE (color);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT color_uniq;
       public            postgres    false    201            I           2606    17577    task_content content_uniq 
   CONSTRAINT     W   ALTER TABLE ONLY public.task_content
    ADD CONSTRAINT content_uniq UNIQUE (content);
 C   ALTER TABLE ONLY public.task_content DROP CONSTRAINT content_uniq;
       public            postgres    false    225                       2606    33523    notification exx    CHECK CONSTRAINT     m  ALTER TABLE public.notification
    ADD CONSTRAINT exx CHECK ((((message IS NOT NULL) AND (institution_register IS NULL) AND (team_register IS NULL) AND (team IS NULL) AND (championship IS NULL)) OR ((institution_register IS NOT NULL) AND (message IS NULL) AND (team_register IS NULL) AND (team IS NULL) AND (championship IS NULL)) OR ((team_register IS NOT NULL) AND (institution_register IS NULL) AND (message IS NULL) AND (team IS NULL) AND (championship IS NULL)) OR ((team IS NOT NULL) AND (championship IS NOT NULL) AND (message IS NULL) AND (team_register IS NULL) AND (institution_register IS NULL)))) NOT VALID;
 5   ALTER TABLE public.notification DROP CONSTRAINT exx;
       public          postgres    false    239    239    239    239    239    239    239    239    239    239            %           2606    17547 !   institution institution_name_uniq 
   CONSTRAINT     \   ALTER TABLE ONLY public.institution
    ADD CONSTRAINT institution_name_uniq UNIQUE (name);
 K   ALTER TABLE ONLY public.institution DROP CONSTRAINT institution_name_uniq;
       public            postgres    false    205            '           2606    17166    institution institution_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.institution
    ADD CONSTRAINT institution_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.institution DROP CONSTRAINT institution_pkey;
       public            postgres    false    205            -           2606    17549 /   institution_status institution_status_name_uniq 
   CONSTRAINT     j   ALTER TABLE ONLY public.institution_status
    ADD CONSTRAINT institution_status_name_uniq UNIQUE (name);
 Y   ALTER TABLE ONLY public.institution_status DROP CONSTRAINT institution_status_name_uniq;
       public            postgres    false    209            /           2606    17182 *   institution_status institution_status_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.institution_status
    ADD CONSTRAINT institution_status_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.institution_status DROP CONSTRAINT institution_status_pkey;
       public            postgres    false    209            1           2606    17551 +   institution_type institution_type_name_uniq 
   CONSTRAINT     f   ALTER TABLE ONLY public.institution_type
    ADD CONSTRAINT institution_type_name_uniq UNIQUE (name);
 U   ALTER TABLE ONLY public.institution_type DROP CONSTRAINT institution_type_name_uniq;
       public            postgres    false    211            3           2606    17190 &   institution_type institution_type_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.institution_type
    ADD CONSTRAINT institution_type_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.institution_type DROP CONSTRAINT institution_type_pkey;
       public            postgres    false    211            =           2606    17220    map map_pkey 
   CONSTRAINT     J   ALTER TABLE ONLY public.map
    ADD CONSTRAINT map_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.map DROP CONSTRAINT map_pkey;
       public            postgres    false    217                       2606    17543 '   championship max_institution_team_count    CHECK CONSTRAINT     ?   ALTER TABLE public.championship
    ADD CONSTRAINT max_institution_team_count CHECK ((max_institution_team_count > 0)) NOT VALID;
 L   ALTER TABLE public.championship DROP CONSTRAINT max_institution_team_count;
       public          postgres    false    234    234                       2606    17542    championship max_teams    CHECK CONSTRAINT     e   ALTER TABLE public.championship
    ADD CONSTRAINT max_teams CHECK ((max_team_count > 0)) NOT VALID;
 ;   ALTER TABLE public.championship DROP CONSTRAINT max_teams;
       public          postgres    false    234    234                       2606    25336    notification message_exists    CHECK CONSTRAINT     ?   ALTER TABLE public.notification
    ADD CONSTRAINT message_exists CHECK ((((message)::text <> ''::text) OR (message IS NULL))) NOT VALID;
 @   ALTER TABLE public.notification DROP CONSTRAINT message_exists;
       public          postgres    false    239    239            ?           2606    17595    users name_exists    CHECK CONSTRAINT     f   ALTER TABLE public.users
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 6   ALTER TABLE public.users DROP CONSTRAINT name_exists;
       public          postgres    false    201    201            ?           2606    25331    institution name_exists    CHECK CONSTRAINT     l   ALTER TABLE public.institution
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 <   ALTER TABLE public.institution DROP CONSTRAINT name_exists;
       public          postgres    false    205    205                       2606    25332    championship name_exists    CHECK CONSTRAINT     m   ALTER TABLE public.championship
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 =   ALTER TABLE public.championship DROP CONSTRAINT name_exists;
       public          postgres    false    234    234                       2606    25333    championship_status name_exists    CHECK CONSTRAINT     t   ALTER TABLE public.championship_status
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 D   ALTER TABLE public.championship_status DROP CONSTRAINT name_exists;
       public          postgres    false    236    236            ?           2606    25334    institution_status name_exists    CHECK CONSTRAINT     s   ALTER TABLE public.institution_status
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 C   ALTER TABLE public.institution_status DROP CONSTRAINT name_exists;
       public          postgres    false    209    209            ?           2606    25335    institution_type name_exists    CHECK CONSTRAINT     q   ALTER TABLE public.institution_type
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 A   ALTER TABLE public.institution_type DROP CONSTRAINT name_exists;
       public          postgres    false    211    211                       2606    25337    notification_status name_exists    CHECK CONSTRAINT     t   ALTER TABLE public.notification_status
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 D   ALTER TABLE public.notification_status DROP CONSTRAINT name_exists;
       public          postgres    false    243    243                       2606    25338    notification_type name_exists    CHECK CONSTRAINT     r   ALTER TABLE public.notification_type
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 B   ALTER TABLE public.notification_type DROP CONSTRAINT name_exists;
       public          postgres    false    241    241            ?           2606    25340    platform_status name_exists    CHECK CONSTRAINT     p   ALTER TABLE public.platform_status
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 @   ALTER TABLE public.platform_status DROP CONSTRAINT name_exists;
       public          postgres    false    215    215            ?           2606    25341    sity name_exists    CHECK CONSTRAINT     e   ALTER TABLE public.sity
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 5   ALTER TABLE public.sity DROP CONSTRAINT name_exists;
       public          postgres    false    207    207                       2606    25343    task_status name_exists    CHECK CONSTRAINT     l   ALTER TABLE public.task_status
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 <   ALTER TABLE public.task_status DROP CONSTRAINT name_exists;
       public          postgres    false    223    223                       2606    25344    task_type name_exists    CHECK CONSTRAINT     j   ALTER TABLE public.task_type
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 :   ALTER TABLE public.task_type DROP CONSTRAINT name_exists;
       public          postgres    false    221    221            	           2606    25345    team name_exists    CHECK CONSTRAINT     e   ALTER TABLE public.team
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 5   ALTER TABLE public.team DROP CONSTRAINT name_exists;
       public          postgres    false    229    229                       2606    25346    team_status name_exists    CHECK CONSTRAINT     l   ALTER TABLE public.team_status
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 <   ALTER TABLE public.team_status DROP CONSTRAINT name_exists;
       public          postgres    false    231    231                       2606    25347    type_of_response name_exists    CHECK CONSTRAINT     q   ALTER TABLE public.type_of_response
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 A   ALTER TABLE public.type_of_response DROP CONSTRAINT name_exists;
       public          postgres    false    227    227            ?           2606    25348    user_role name_exists    CHECK CONSTRAINT     j   ALTER TABLE public.user_role
    ADD CONSTRAINT name_exists CHECK (((name)::text <> ''::text)) NOT VALID;
 :   ALTER TABLE public.user_role DROP CONSTRAINT name_exists;
       public          postgres    false    203    203            a           2606    17545    championship_status name_uniq 
   CONSTRAINT     X   ALTER TABLE ONLY public.championship_status
    ADD CONSTRAINT name_uniq UNIQUE (name);
 G   ALTER TABLE ONLY public.championship_status DROP CONSTRAINT name_uniq;
       public            postgres    false    236            ?           2606    17596    users nickname_exists    CHECK CONSTRAINT     n   ALTER TABLE public.users
    ADD CONSTRAINT nickname_exists CHECK (((nickname)::text <> ''::text)) NOT VALID;
 :   ALTER TABLE public.users DROP CONSTRAINT nickname_exists;
       public          postgres    false    201    201            e           2606    17334    notification notification_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_pkey;
       public            postgres    false    239            k           2606    17558 1   notification_status notification_status_name_uniq 
   CONSTRAINT     l   ALTER TABLE ONLY public.notification_status
    ADD CONSTRAINT notification_status_name_uniq UNIQUE (name);
 [   ALTER TABLE ONLY public.notification_status DROP CONSTRAINT notification_status_name_uniq;
       public            postgres    false    243            m           2606    17350 ,   notification_status notification_status_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.notification_status
    ADD CONSTRAINT notification_status_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.notification_status DROP CONSTRAINT notification_status_pkey;
       public            postgres    false    243            g           2606    17560 -   notification_type notification_type_name_uniq 
   CONSTRAINT     h   ALTER TABLE ONLY public.notification_type
    ADD CONSTRAINT notification_type_name_uniq UNIQUE (name);
 W   ALTER TABLE ONLY public.notification_type DROP CONSTRAINT notification_type_name_uniq;
       public            postgres    false    241            i           2606    17342 (   notification_type notification_type_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.notification_type
    ADD CONSTRAINT notification_type_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.notification_type DROP CONSTRAINT notification_type_pkey;
       public            postgres    false    241            ?           2606    17597    users password_exists    CHECK CONSTRAINT     n   ALTER TABLE public.users
    ADD CONSTRAINT password_exists CHECK (((password)::text <> ''::text)) NOT VALID;
 :   ALTER TABLE public.users DROP CONSTRAINT password_exists;
       public          postgres    false    201    201            5           2606    17562    platform platform_color_uniq 
   CONSTRAINT     X   ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_color_uniq UNIQUE (color);
 F   ALTER TABLE ONLY public.platform DROP CONSTRAINT platform_color_uniq;
       public            postgres    false    213            7           2606    17198    platform platform_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.platform DROP CONSTRAINT platform_pkey;
       public            postgres    false    213            9           2606    17619 )   platform_status platform_status_name_uniq 
   CONSTRAINT     d   ALTER TABLE ONLY public.platform_status
    ADD CONSTRAINT platform_status_name_uniq UNIQUE (name);
 S   ALTER TABLE ONLY public.platform_status DROP CONSTRAINT platform_status_name_uniq;
       public            postgres    false    215            ;           2606    17209 $   platform_status platform_status_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.platform_status
    ADD CONSTRAINT platform_status_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.platform_status DROP CONSTRAINT platform_status_pkey;
       public            postgres    false    215            )           2606    17574    sity sity_name_uniq 
   CONSTRAINT     N   ALTER TABLE ONLY public.sity
    ADD CONSTRAINT sity_name_uniq UNIQUE (name);
 =   ALTER TABLE ONLY public.sity DROP CONSTRAINT sity_name_uniq;
       public            postgres    false    207            +           2606    17174    sity sity_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.sity
    ADD CONSTRAINT sity_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.sity DROP CONSTRAINT sity_pkey;
       public            postgres    false    207                       2606    25472    championship start_end    CHECK CONSTRAINT     p   ALTER TABLE public.championship
    ADD CONSTRAINT start_end CHECK ((datetime_start < datetime_end)) NOT VALID;
 ;   ALTER TABLE public.championship DROP CONSTRAINT start_end;
       public          postgres    false    234    234    234    234            ?           2606    17594    users surname_exists    CHECK CONSTRAINT     l   ALTER TABLE public.users
    ADD CONSTRAINT surname_exists CHECK (((surname)::text <> ''::text)) NOT VALID;
 9   ALTER TABLE public.users DROP CONSTRAINT surname_exists;
       public          postgres    false    201    201            ?           2606    17563    platform task_cnt    CHECK CONSTRAINT     \   ALTER TABLE public.platform
    ADD CONSTRAINT task_cnt CHECK ((task_count > 0)) NOT VALID;
 6   ALTER TABLE public.platform DROP CONSTRAINT task_cnt;
       public          postgres    false    213    213            K           2606    17261    task_content task_content_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.task_content
    ADD CONSTRAINT task_content_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.task_content DROP CONSTRAINT task_content_pkey;
       public            postgres    false    225            ?           2606    17228    task task_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.task DROP CONSTRAINT task_pkey;
       public            postgres    false    219            E           2606    17579 !   task_status task_status_name_uniq 
   CONSTRAINT     \   ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_name_uniq UNIQUE (name);
 K   ALTER TABLE ONLY public.task_status DROP CONSTRAINT task_status_name_uniq;
       public            postgres    false    223            G           2606    17250    task_status task_status_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.task_status DROP CONSTRAINT task_status_pkey;
       public            postgres    false    223            A           2606    17581    task_type task_type_name_uniq 
   CONSTRAINT     X   ALTER TABLE ONLY public.task_type
    ADD CONSTRAINT task_type_name_uniq UNIQUE (name);
 G   ALTER TABLE ONLY public.task_type DROP CONSTRAINT task_type_name_uniq;
       public            postgres    false    221            C           2606    17239    task_type task_type_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.task_type
    ADD CONSTRAINT task_type_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.task_type DROP CONSTRAINT task_type_pkey;
       public            postgres    false    221            o           2606    25460 :   team_championship_platform team_championship_platform_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public.team_championship_platform
    ADD CONSTRAINT team_championship_platform_pkey PRIMARY KEY (team, championship, platform);
 d   ALTER TABLE ONLY public.team_championship_platform DROP CONSTRAINT team_championship_platform_pkey;
       public            postgres    false    244    244    244            Q           2606    17583    team team_name_uniq 
   CONSTRAINT     N   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_name_uniq UNIQUE (name);
 =   ALTER TABLE ONLY public.team DROP CONSTRAINT team_name_uniq;
       public            postgres    false    229            S           2606    17278    team team_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.team DROP CONSTRAINT team_pkey;
       public            postgres    false    229            U           2606    17585 !   team_status team_status_name_uniq 
   CONSTRAINT     \   ALTER TABLE ONLY public.team_status
    ADD CONSTRAINT team_status_name_uniq UNIQUE (name);
 K   ALTER TABLE ONLY public.team_status DROP CONSTRAINT team_status_name_uniq;
       public            postgres    false    231            W           2606    17286    team_status team_status_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.team_status
    ADD CONSTRAINT team_status_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.team_status DROP CONSTRAINT team_status_pkey;
       public            postgres    false    231            Y           2606    25384 "   team_task_user team_task_user_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.team_task_user
    ADD CONSTRAINT team_task_user_pkey PRIMARY KEY (team, task, "user", "when");
 L   ALTER TABLE ONLY public.team_task_user DROP CONSTRAINT team_task_user_pkey;
       public            postgres    false    232    232    232    232            ?           2606    17575    task time_for_answer_exists    CHECK CONSTRAINT     k   ALTER TABLE public.task
    ADD CONSTRAINT time_for_answer_exists CHECK ((time_for_answer > 0)) NOT VALID;
 @   ALTER TABLE public.task DROP CONSTRAINT time_for_answer_exists;
       public          postgres    false    219    219            M           2606    17589 +   type_of_response type_of_response_name_uniq 
   CONSTRAINT     f   ALTER TABLE ONLY public.type_of_response
    ADD CONSTRAINT type_of_response_name_uniq UNIQUE (name);
 U   ALTER TABLE ONLY public.type_of_response DROP CONSTRAINT type_of_response_name_uniq;
       public            postgres    false    227            O           2606    17270 &   type_of_response type_of_response_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.type_of_response
    ADD CONSTRAINT type_of_response_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.type_of_response DROP CONSTRAINT type_of_response_pkey;
       public            postgres    false    227                       2606    17593    users user_nickname_uniq 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_nickname_uniq UNIQUE (nickname);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT user_nickname_uniq;
       public            postgres    false    201                       2606    17150    users user_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 9   ALTER TABLE ONLY public.users DROP CONSTRAINT user_pkey;
       public            postgres    false    201            !           2606    17591    user_role user_role_name_uniq 
   CONSTRAINT     X   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_name_uniq UNIQUE (name);
 G   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_name_uniq;
       public            postgres    false    203            #           2606    17158    user_role user_role_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.user_role DROP CONSTRAINT user_role_pkey;
       public            postgres    false    203            ?           2620    17629    users check_admin_trigger    TRIGGER     u   CREATE TRIGGER check_admin_trigger BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.check_admin();
 2   DROP TRIGGER check_admin_trigger ON public.users;
       public          postgres    false    201    270            ?           2620    25354    task check_task_trigger    TRIGGER     r   CREATE TRIGGER check_task_trigger BEFORE INSERT ON public.task FOR EACH ROW EXECUTE FUNCTION public.check_task();
 0   DROP TRIGGER check_task_trigger ON public.task;
       public          postgres    false    272    219            ?           2620    17612 1   championship datetime_create_championship_trigger    TRIGGER     ?   CREATE TRIGGER datetime_create_championship_trigger BEFORE INSERT ON public.championship FOR EACH ROW EXECUTE FUNCTION public.datetime_create();
 J   DROP TRIGGER datetime_create_championship_trigger ON public.championship;
       public          postgres    false    269    234            ?           2620    17630 /   institution datetime_create_institution_trigger    TRIGGER     ?   CREATE TRIGGER datetime_create_institution_trigger BEFORE INSERT ON public.institution FOR EACH ROW EXECUTE FUNCTION public.datetime_create();
 H   DROP TRIGGER datetime_create_institution_trigger ON public.institution;
       public          postgres    false    269    205            ?           2620    17613 1   notification datetime_create_notification_trigger    TRIGGER     ?   CREATE TRIGGER datetime_create_notification_trigger BEFORE INSERT ON public.notification FOR EACH ROW EXECUTE FUNCTION public.datetime_create();
 J   DROP TRIGGER datetime_create_notification_trigger ON public.notification;
       public          postgres    false    239    269            ?           2620    17614 )   platform datetime_create_platform_trigger    TRIGGER     ?   CREATE TRIGGER datetime_create_platform_trigger BEFORE INSERT ON public.platform FOR EACH ROW EXECUTE FUNCTION public.datetime_create();
 B   DROP TRIGGER datetime_create_platform_trigger ON public.platform;
       public          postgres    false    269    213            ?           2620    17615 1   task_content datetime_create_task_content_trigger    TRIGGER     ?   CREATE TRIGGER datetime_create_task_content_trigger BEFORE INSERT ON public.task_content FOR EACH ROW EXECUTE FUNCTION public.datetime_create();
 J   DROP TRIGGER datetime_create_task_content_trigger ON public.task_content;
       public          postgres    false    225    269            ?           2620    17616 !   team datetime_create_team_trigger    TRIGGER     ?   CREATE TRIGGER datetime_create_team_trigger BEFORE INSERT ON public.team FOR EACH ROW EXECUTE FUNCTION public.datetime_create();
 :   DROP TRIGGER datetime_create_team_trigger ON public.team;
       public          postgres    false    269    229            ?           2620    17617 #   users datetime_create_users_trigger    TRIGGER     ?   CREATE TRIGGER datetime_create_users_trigger BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.datetime_create();
 <   DROP TRIGGER datetime_create_users_trigger ON public.users;
       public          postgres    false    269    201            ?           2620    25425    institution delete_institution    TRIGGER     ?   CREATE TRIGGER delete_institution BEFORE DELETE ON public.institution FOR EACH ROW EXECUTE FUNCTION public.delete_institution();
 7   DROP TRIGGER delete_institution ON public.institution;
       public          postgres    false    205    273            ?           2620    25350     users update_institution_trigger    TRIGGER     ?   CREATE TRIGGER update_institution_trigger AFTER INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_institution();
 9   DROP TRIGGER update_institution_trigger ON public.users;
       public          postgres    false    201    271            ?           2620    25388 "   team_task_user when_action_trigger    TRIGGER     ~   CREATE TRIGGER when_action_trigger BEFORE INSERT ON public.team_task_user FOR EACH ROW EXECUTE FUNCTION public.when_action();
 ;   DROP TRIGGER when_action_trigger ON public.team_task_user;
       public          postgres    false    274    232            ?           2606    17496 %   championship_institution championship    FK CONSTRAINT     ?   ALTER TABLE ONLY public.championship_institution
    ADD CONSTRAINT championship FOREIGN KEY (championship) REFERENCES public.championship(id) NOT VALID;
 O   ALTER TABLE ONLY public.championship_institution DROP CONSTRAINT championship;
       public          postgres    false    3421    234    237            ?           2606    25371 '   team_championship_platform championship    FK CONSTRAINT     ?   ALTER TABLE ONLY public.team_championship_platform
    ADD CONSTRAINT championship FOREIGN KEY (championship) REFERENCES public.championship(id);
 Q   ALTER TABLE ONLY public.team_championship_platform DROP CONSTRAINT championship;
       public          postgres    false    234    244    3421            ?           2606    25453    notification championship    FK CONSTRAINT     ?   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT championship FOREIGN KEY (championship) REFERENCES public.championship(id) NOT VALID;
 C   ALTER TABLE ONLY public.notification DROP CONSTRAINT championship;
       public          postgres    false    239    3421    234            ?           2606    17481     championship championship_status    FK CONSTRAINT     ?   ALTER TABLE ONLY public.championship
    ADD CONSTRAINT championship_status FOREIGN KEY (championship_status) REFERENCES public.championship_status(id) NOT VALID;
 J   ALTER TABLE ONLY public.championship DROP CONSTRAINT championship_status;
       public          postgres    false    234    3423    236            v           2606    17381    institution created_by    FK CONSTRAINT     ?   ALTER TABLE ONLY public.institution
    ADD CONSTRAINT created_by FOREIGN KEY (created_by) REFERENCES public.users(id) NOT VALID;
 @   ALTER TABLE ONLY public.institution DROP CONSTRAINT created_by;
       public          postgres    false    205    201    3359            x           2606    17391    platform created_by    FK CONSTRAINT        ALTER TABLE ONLY public.platform
    ADD CONSTRAINT created_by FOREIGN KEY (created_by) REFERENCES public.users(id) NOT VALID;
 =   ALTER TABLE ONLY public.platform DROP CONSTRAINT created_by;
       public          postgres    false    3359    201    213                       2606    17426    task created_by    FK CONSTRAINT     {   ALTER TABLE ONLY public.task
    ADD CONSTRAINT created_by FOREIGN KEY (created_by) REFERENCES public.users(id) NOT VALID;
 9   ALTER TABLE ONLY public.task DROP CONSTRAINT created_by;
       public          postgres    false    3359    219    201            ?           2606    17436    task_content created_by    FK CONSTRAINT     ?   ALTER TABLE ONLY public.task_content
    ADD CONSTRAINT created_by FOREIGN KEY (created_by) REFERENCES public.users(id) NOT VALID;
 A   ALTER TABLE ONLY public.task_content DROP CONSTRAINT created_by;
       public          postgres    false    225    201    3359            ?           2606    17441    team created_by    FK CONSTRAINT     {   ALTER TABLE ONLY public.team
    ADD CONSTRAINT created_by FOREIGN KEY (created_by) REFERENCES public.users(id) NOT VALID;
 9   ALTER TABLE ONLY public.team DROP CONSTRAINT created_by;
       public          postgres    false    229    201    3359            ?           2606    17476    championship created_by    FK CONSTRAINT     ?   ALTER TABLE ONLY public.championship
    ADD CONSTRAINT created_by FOREIGN KEY (created_by) REFERENCES public.users(id) NOT VALID;
 A   ALTER TABLE ONLY public.championship DROP CONSTRAINT created_by;
       public          postgres    false    234    3359    201            ~           2606    17421    task find_by    FK CONSTRAINT     u   ALTER TABLE ONLY public.task
    ADD CONSTRAINT find_by FOREIGN KEY (find_by) REFERENCES public.users(id) NOT VALID;
 6   ALTER TABLE ONLY public.task DROP CONSTRAINT find_by;
       public          postgres    false    201    219    3359            ?           2606    17516    notification from    FK CONSTRAINT     {   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "from" FOREIGN KEY ("from") REFERENCES public.users(id) NOT VALID;
 =   ALTER TABLE ONLY public.notification DROP CONSTRAINT "from";
       public          postgres    false    3359    201    239            p           2606    17356    users institution    FK CONSTRAINT     ?   ALTER TABLE ONLY public.users
    ADD CONSTRAINT institution FOREIGN KEY (institution) REFERENCES public.institution(id) NOT VALID;
 ;   ALTER TABLE ONLY public.users DROP CONSTRAINT institution;
       public          postgres    false    201    3367    205            ?           2606    17456    team institution    FK CONSTRAINT     ?   ALTER TABLE ONLY public.team
    ADD CONSTRAINT institution FOREIGN KEY (institution) REFERENCES public.institution(id) NOT VALID;
 :   ALTER TABLE ONLY public.team DROP CONSTRAINT institution;
       public          postgres    false    3367    205    229            ?           2606    17501 $   championship_institution institution    FK CONSTRAINT     ?   ALTER TABLE ONLY public.championship_institution
    ADD CONSTRAINT institution FOREIGN KEY (institution) REFERENCES public.institution(id) NOT VALID;
 N   ALTER TABLE ONLY public.championship_institution DROP CONSTRAINT institution;
       public          postgres    false    237    3367    205            ?           2606    25461 !   notification institution_register    FK CONSTRAINT     ?   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT institution_register FOREIGN KEY (institution_register) REFERENCES public.institution(id) NOT VALID;
 K   ALTER TABLE ONLY public.notification DROP CONSTRAINT institution_register;
       public          postgres    false    205    3367    239            t           2606    17371    institution institution_status    FK CONSTRAINT     ?   ALTER TABLE ONLY public.institution
    ADD CONSTRAINT institution_status FOREIGN KEY (institution_status) REFERENCES public.institution_status(id) NOT VALID;
 H   ALTER TABLE ONLY public.institution DROP CONSTRAINT institution_status;
       public          postgres    false    209    3375    205            u           2606    17376    institution institution_type    FK CONSTRAINT     ?   ALTER TABLE ONLY public.institution
    ADD CONSTRAINT institution_type FOREIGN KEY (institution_type) REFERENCES public.institution_type(id) NOT VALID;
 F   ALTER TABLE ONLY public.institution DROP CONSTRAINT institution_type;
       public          postgres    false    211    3379    205            w           2606    17386    platform map    FK CONSTRAINT     o   ALTER TABLE ONLY public.platform
    ADD CONSTRAINT map FOREIGN KEY (map) REFERENCES public.map(id) NOT VALID;
 6   ALTER TABLE ONLY public.platform DROP CONSTRAINT map;
       public          postgres    false    213    217    3389            ?           2606    17511     notification notification_status    FK CONSTRAINT     ?   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_status FOREIGN KEY (notification_status) REFERENCES public.notification_status(id) NOT VALID;
 J   ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_status;
       public          postgres    false    3437    243    239            ?           2606    17506    notification notification_type    FK CONSTRAINT     ?   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_type FOREIGN KEY (notification_type) REFERENCES public.notification_type(id) NOT VALID;
 H   ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_type;
       public          postgres    false    3433    241    239            z           2606    17401    task platform    FK CONSTRAINT     z   ALTER TABLE ONLY public.task
    ADD CONSTRAINT platform FOREIGN KEY (platform) REFERENCES public.platform(id) NOT VALID;
 7   ALTER TABLE ONLY public.task DROP CONSTRAINT platform;
       public          postgres    false    219    3383    213            ?           2606    25376 #   team_championship_platform platform    FK CONSTRAINT     ?   ALTER TABLE ONLY public.team_championship_platform
    ADD CONSTRAINT platform FOREIGN KEY (platform) REFERENCES public.platform(id);
 M   ALTER TABLE ONLY public.team_championship_platform DROP CONSTRAINT platform;
       public          postgres    false    213    244    3383            y           2606    17396    platform platform_status    FK CONSTRAINT     ?   ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_status FOREIGN KEY (platform_status) REFERENCES public.platform_status(id) NOT VALID;
 B   ALTER TABLE ONLY public.platform DROP CONSTRAINT platform_status;
       public          postgres    false    213    215    3387            ?           2606    17471    team_task_user responsibility    FK CONSTRAINT     ?   ALTER TABLE ONLY public.team_task_user
    ADD CONSTRAINT responsibility FOREIGN KEY ("user") REFERENCES public.users(id) NOT VALID;
 G   ALTER TABLE ONLY public.team_task_user DROP CONSTRAINT responsibility;
       public          postgres    false    232    201    3359            s           2606    17366    institution sity    FK CONSTRAINT     u   ALTER TABLE ONLY public.institution
    ADD CONSTRAINT sity FOREIGN KEY (sity) REFERENCES public.sity(id) NOT VALID;
 :   ALTER TABLE ONLY public.institution DROP CONSTRAINT sity;
       public          postgres    false    207    3371    205            ?           2606    17466    team_task_user task    FK CONSTRAINT     x   ALTER TABLE ONLY public.team_task_user
    ADD CONSTRAINT task FOREIGN KEY (task) REFERENCES public.task(id) NOT VALID;
 =   ALTER TABLE ONLY public.team_task_user DROP CONSTRAINT task;
       public          postgres    false    219    232    3391            }           2606    17416    task task_content    FK CONSTRAINT     ?   ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_content FOREIGN KEY (task_content) REFERENCES public.task_content(id) NOT VALID;
 ;   ALTER TABLE ONLY public.task DROP CONSTRAINT task_content;
       public          postgres    false    219    3403    225            |           2606    17411    task task_status    FK CONSTRAINT     ?   ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_status FOREIGN KEY (task_status) REFERENCES public.task_status(id) NOT VALID;
 :   ALTER TABLE ONLY public.task DROP CONSTRAINT task_status;
       public          postgres    false    219    3399    223            {           2606    17406    task task_type    FK CONSTRAINT     }   ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_type FOREIGN KEY (task_type) REFERENCES public.task_type(id) NOT VALID;
 8   ALTER TABLE ONLY public.task DROP CONSTRAINT task_type;
       public          postgres    false    3395    221    219            q           2606    17361 
   users team    FK CONSTRAINT     o   ALTER TABLE ONLY public.users
    ADD CONSTRAINT team FOREIGN KEY (team) REFERENCES public.team(id) NOT VALID;
 4   ALTER TABLE ONLY public.users DROP CONSTRAINT team;
       public          postgres    false    201    229    3411            ?           2606    17461    team_task_user team    FK CONSTRAINT     x   ALTER TABLE ONLY public.team_task_user
    ADD CONSTRAINT team FOREIGN KEY (team) REFERENCES public.team(id) NOT VALID;
 =   ALTER TABLE ONLY public.team_task_user DROP CONSTRAINT team;
       public          postgres    false    3411    232    229            ?           2606    17531    notification team    FK CONSTRAINT        ALTER TABLE ONLY public.notification
    ADD CONSTRAINT team FOREIGN KEY (team_register) REFERENCES public.team(id) NOT VALID;
 ;   ALTER TABLE ONLY public.notification DROP CONSTRAINT team;
       public          postgres    false    3411    229    239            ?           2606    25366    team_championship_platform team    FK CONSTRAINT     z   ALTER TABLE ONLY public.team_championship_platform
    ADD CONSTRAINT team FOREIGN KEY (team) REFERENCES public.team(id);
 I   ALTER TABLE ONLY public.team_championship_platform DROP CONSTRAINT team;
       public          postgres    false    3411    229    244            ?           2606    25466    notification team_register    FK CONSTRAINT     ?   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT team_register FOREIGN KEY (team_register) REFERENCES public.team(id) NOT VALID;
 D   ALTER TABLE ONLY public.notification DROP CONSTRAINT team_register;
       public          postgres    false    239    3411    229            ?           2606    17451    team team_status    FK CONSTRAINT     ?   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_status FOREIGN KEY (team_status) REFERENCES public.team_status(id) NOT VALID;
 :   ALTER TABLE ONLY public.team DROP CONSTRAINT team_status;
       public          postgres    false    3415    229    231            ?           2606    17521    notification to    FK CONSTRAINT     w   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "to" FOREIGN KEY ("to") REFERENCES public.users(id) NOT VALID;
 ;   ALTER TABLE ONLY public.notification DROP CONSTRAINT "to";
       public          postgres    false    3359    201    239            ?           2606    17431    task_content type_of_response    FK CONSTRAINT     ?   ALTER TABLE ONLY public.task_content
    ADD CONSTRAINT type_of_response FOREIGN KEY (type_of_response) REFERENCES public.type_of_response(id) NOT VALID;
 G   ALTER TABLE ONLY public.task_content DROP CONSTRAINT type_of_response;
       public          postgres    false    3407    225    227            r           2606    17631    users user_role    FK CONSTRAINT     ~   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_role FOREIGN KEY (user_role) REFERENCES public.user_role(id) NOT VALID;
 9   ALTER TABLE ONLY public.users DROP CONSTRAINT user_role;
       public          postgres    false    203    201    3363            Q   ?  x????N?@???Sl?b?̞???4?%p8:%=??!D??o?l?88????=????ά?X-??O??n???ǻŁ?.???<?????[XB?/	67.?.U^9??tMz??T?T?Q???<??u?????l?9??5ꖌnS????????Wl??΢??堇??e44bL?M???Jk[v?¢??????6?_4&?8'q?
?+f?.`!?*u?Cp?b??_J?AQ4?-?==?}Ј?iLU=?????1?$??s}N?<^K??)?E=???C?s??F?U1w?A?F??p%趾????E?ZU}?O?w??I?9r?L?ʻЪZ??r
]4????N?K?q?rR0??f???ZF?sCM?L??? ???Ƨ?X?a?J7????&?i?$??)Ml      T   E   x?̱?@???????{q?ux?`Oh:*;6??P?R?p?7nܸq??kE??{????=?we???L      S   8   x?3??0??V?{/l???M\F ǘ???.l???b?Ŏ[/??????? |<?      4   ?  x??TKnA]Ϝ??-ʨ?z?g???A?H,??b??ٱ 6? <??s??+p^??I<i"6?H???^?zUoL?|s?d^?Z~?R6??[i?|?e%W҆?.?E?????????R?Hh?!?<??u?
?(??e??????8L?,n?Bɗ?XI.???%?????J?(:?X3kV??&ot?h]j~?MVZ???	???h???`TC??=?٠?4???'?B?yL@???.,p?뎡x	?Y:?ր?????nJ?]??I???ܘ?sp/Fp2?*w?????1;f????d'OO'???'??=??d?Ⴍ?m????P?8?"?!?+;???????m>iE?doma??jʘ?.???k< ir??0????ګXyv?4??ԩs"?ݟ?W?P??Vr?y?6ٛ???6?NF???u?jW5???ӻ?f?@?n$\+"?+O?h?!???.?<?֎??      8   5   x?3??0??֋v\l?6 n???¦.콰?ˈ???[?\?Jb???? ??-4      :   ?   x???M
?@???)z???x?V??{?Z'Z(?Wx???YUjK??L&y/߃?'???3(??ߨ???q?*?????M?/?*V.?USY-?{(???T????%,'??3Qǿ??~???i?oKal????9???]?T63? ??U      @   9   x?3䌉?071?0?4762??if?f???F@Sscs?????Y??)H=W? ?_3      V   ?   x???1? ?Nѽ
?7??	?t?:u???B?*4J?J?`?ӷ3ތ?	?_??1????
N?&?W?&d?s???c?eY/?B\?]RDJ?.=6~eb??B?2?Dye?qJ]?ݰ?'K?'H????P???????@-`??A?GWE?^??????<???)???d?7SG)@???Yk_??kL      Z   0   x?3??0?¾??x+????.???~a?Ŧ.?B?D? A??      X   y   x????	?`??n夘?i!????!覅???s ?e??o?4?3F<Y???W???+"6L?,?űf????=`Qi?5鶃?<?C??g?51[??r????X?V????Of??~,      <   ?   x???A
?@??x
??!?g&j??]?R?P?????h¬?#	Ax?????????h?FX???d4Ucw?X .-??A. m@O@[?m?' ??A_? ?7??:??G????@V??._Һfg???r!X	?????.$??{???9???+!&$˶??%? ?޳?4??_p?UU} ?Bs?      >   8   x?3??0??V?{/l???M6p??\c??/l???¾{??[Aj?b???? l?#P      6      x?}|[z???sz.:_?x????X?#????$??}???g??X?ZRGݒ??=??? ?????G\`? ? X?????ݷ?{ۋ??????e1ǮSԿ?w?n7?)5????????nWۿSQʃ???f{.??w???Ёro?y{???;^?^?+?w?[2???3????"?@?e?3?.???ﾌ$?U????m??p{????2?g?O$œ?!???\?,BQ??p?h;m???c?qM??+?/pU?????Wڣ??g'kI_?l????G?b??k?R?d^nD??g??v??Z??b??E???????5???<'?R6s?FG?Y2??E??=?=\$?]?9?q?ky+? !G?K~?H??b{)o?{???????y?|{+???.?w??"???Ѷ/?<:?8????Q???6?&?9?J>s?)W«??3z-????v.3????nFe?ݏ6>?+U*ȩsQ?}??+?#?3?? *S?eܝ?c???Gh??2?R?J޾?n???EɆʜ^????#??$}7hSWJߍ??????w?l?7p)?????l???'??N3|"M??5pN?/v??3??]K\??R??'????"???9??"[?	???:??????f?X??($/?\?ZR??cb????????????`?`?Q?~?+$??1p????`2?`r?1M??Рr?Y??E=?f????v??O?mE???4???Z?n??@-???Q??ċ??Ǒ?????????????*`?????X???Q	KQ???X?cR???O(+T?o,
?M??	?Ƿ&??܇???*?L?5X?D??hf???0Xk?4R?u)?07?????????????Z?B???O?u-???&??	?f?`Mz??0??>?-?O?6?=FPD??h#S?s?9:V??fX?S??GN*͟Oh?
??G$ x??)?u?	XSB?-???^	????ˢO?LWܭ?w?8}?[x9???p`??49?r6?)8hfG?8C???)??5???)WR5?}*???.??3?]?YE?????P???J?? ?WZV90??7˝U?e?e???^_L?K#@,<Y>?`8?;??????E?	???4{6)?????,VS	?:?7)Ф?C?dxƟĦ?G׹58:???/? 75?|????EZ????1XI?4C?}m?I?<??>??<#?F?A!?Ǖţ??SZ??.?)?%׊?2?m>??g???S2?m>???????M7? ?)
s??????|C??t???ޒ1ɴ%CO??????????9????҃????~F?X1T?L6?? ??E?Z???[?n?ю?/?l?C???"O??8ԧ?~?E ??0?䴱R??S???8c?c}J_u%?3??zs~2?????Hp?P?s?caI???[p? }W0?????T%???H???o{???f????&Zb4?????w??|?x?M??3?0Ɉ??f?{}F??????%4??>??o\????g??9??oC:0???3>??H8`??? ?J{?,`Pp9+?0?????r^P???c??B?(r?)e??O??(?\??x??V?	???	aT?:#Q?0) ?vl??{?!PB'??͇؂?1??FqM#*?sb??z?;(\?*E??X???B]޶t???Q	7??d ????Q ]???????³??S?+I?ٛ???ՕK?P@ ?bc??"x&q
rO ?@????????K~.ީ3n>???๽?f	"2x?F1?s?5??x?g?f?BL ?5G?h@D ????s????/?\f?:g?v?H?:x???'??
Z?`?g.?V??1͍L |???wj?????y?+_?n??????ý????Y?=? ???nfk?8????e@???O0??Ϝ???x???+?7|??nH??????aEf??4y+?PT?G?????v?qK#B 'Z?(????8*8?#?@???0??jGD?͈?j4???
??Q7L]qq??<D???????!?a?7:Xy???#+???
`K??}4?mЗxD?*?????<#?}??	?ǡ?'JPlQ?8?e]????Aa???r? ?%\???????>]????Z
1P????????0^b??#? ??#"?X?̯?	D<??M66?1J???????  T?G pY?׈???,????vL
j?gF? /to^???B????N`?΢?{S?M"Js??1B?a?gA~V?}????Q???_0?a????I?k[??2!?@K?"?
|?5??i???[???&????!????/??,DpT????#?/??=?fh?GЉ#s????????^?Q7??"ŽG?_?5*[????X?nf?W??-??<??#?^??ǩ?T=?????C??P???^0?\ͭ?Km??6_??B̕?wc?M??(??c?*?W+¦??4?????*}???L=O?d3`??Tfˮ7?2?=?L?r?E1?*3t?g??ܵ?zc??ʖ????eẹ?w????@?	d??:????B?1'o????M
????5RF/3?~RL??Z???UjSWl??????L
nh???` ?/	??bD1VL?????9?o1??8H????N?攬??щ4m?nklv??xtX???M??l?^??Gۏ????S?>???U??T>??T?c????8?ދꦁ?ѤH???o???aS^?ѭ?????i?i????4?x???Q?sU>?DI?eU?i?
]5y?i(?kP7??????fD^?7Oc???=xC?8??p?0??Cw?D?\??dK??4?F?j#Ͼoz=?&׆)?M?Lc?$?y?`DL?դ?i???spif~??
?E1M&?Mݵ{?[??L?????&??L?o+?)8|?7@t???)9tk?{Ӕ+'@1?ګu
????p???????R??I?S???}??u?a
&ͱjSMN!???-į??ҧ??ߖE???? :CѤz????׍?N?????3M?K?'n?ذ<?G?}qC???Dܐ???????ӛ?Z???1?DG?t?> ?C6ҰO????5?~v;?}??v}?YL?2?I???jHҾ??$SJ???|?*ļO?Ӕ[?鎦l?????I?+???
????*???G)??D???j???R?DZ]?l??????pc?x	?S5??W??fk&:_p}f??":`n?7j??|?\0??t??uQ%?Qc ?Ir?G{?w??Ee?`?S?P?e?:'?????A??????q???`????c?0D?*t?-W:?X&?C?iBG	??`$??[??I?F ?|? X?c??r?T# , ?s????0)??6!?K?	 W?u?
/?UՇd??????, Lx????F?? ?t(????%?<?K???[?0ɠ? :?W@??0Y/?E??׍??!*??K??0???HU#?X??C??6???z!T)?ɰ87??1j?G5v.F>?vg)????6?G???_?n,?????Ҁ+??%&)?KOb?Qz?#ɓ2?Q????<??K*͵?m??H?s???????]+???O?a????echB ???Ndu??_M=Y?!?P!?v?ڼ??p"?Q???,1?晄[?U?ej??
Y?[?[&ȅa? ???m????-k?ih8 {???`p?.??J??X?0?6??!?\.TZ????3?l7V??????9W???@??X?p?	O*#??mך?s??????(?#?[?K&?.?b??T??|??S0ReP???3?&??6G?!e%^i@???ڲ?dsW!,$zn4??Y1/N??6?eBPw???ZȔk?}?L^?D~??????O?o('?? k>QQs6??ك?Ï????j?6?A?\??e?
d|??AT?c?W?<n(?X_?	?
\??z(?!???uڼ???Z?^???Y	bG?o?t?Xv???Ӎ??M
?k????i?"|???}??p+?T	X?dt?Gxc6?S???5??&$tQ???l?
?+?*??L
?ˍ?ï??5??    ????_???j?"???zTpk?
2F?f???:?>? g*??z????>????Y=a?@??}eFcSSWa?_?qG???`4?)?q?r?}?Gp??~kIŌ???Y?߲?S????e7tkJ??????8(??C]L?8*H٤I??lY??8???k??O,?*?cL
ڶSgjTiv?iyʬ?ci	?V'N??Kĩo???Y;'???qNt??:????>+4?5R?I8??Sj??1??t*???1U?
????]??I?l?,[?t??q???uk?1?-?f??8??Z???'?q&-U?l?i&\?^IS1??p?%?7q?4??bL??f?d??s??W?8?Ғo=?Sbjf??L?L?熵{bZ??K?3?1?sB?s???i?'q??ЂV??$Pb???b^???i?NW5?)?????F?Ґ???1?sA?rWO?cnf??;??=???z???%7??p?\B?&?y?l?R????1?,"?gJ?p??l???}?&?]??+䢡~?oL?????e?ow?;!%jZp?????Q???+???fQE???5+?t[???_???ެk?[ݜ:'8tIsB???	??+??7uQI??P&u?Y?????<??oMo????(?'?j\?k???F??SI??S?;?????d?Z?>ګ9?ku-[K??y??<?k?JH3?p?l0??A??m{G_U	??fk??K??@sE	??l?????????4P?c=K??k???3????????@?O??	^??l? 7|??K???@}???o??L?u ????????P?Ќ????????[?i???]	?%?w??+d;???B?۸c??y?#Y?*Tɦ???0*M?6?$_??o?\? ???䁀?+P??y{pUɞ????i?4??x?P?????+?m?⿹_?$????CU?`?sb5l) ?8+??GiRP?|?%?R??R?Y?@
?ξJ?,?H?B?d??ww??w???mI???wHhO?????^?? qq?l????#]?1V??O?? ?7?:[??a??3??1??c?O???l??)?$?DN??=,?L??wҜ?????????7}?D ol[6??	?g??v???ߐO???et	^XIk?D8????@i?s?] ??L~??Մ?~?y7-BY!??Ki6uej??"?K?? Ē???|X?R?G??#=U?uR&a%>?B?Oi???VӸ?uY????}?pg_g???a?y??~?q???Vfl???U??B?K?2<?[^Ѭj?k?d??~?5??)?c?=ȓ?.?{H(;āj_rW?ȋ?w
<T?& x??*i??~;?Pq.2<?[?V=???M???m?Z$????2????p?
?[?p? ?:d???8??&??[Fa?e??w?^?p??t??ܱ@???J??~g???^0菆?~??C?????!??,߬?[?dx?wVvb"?o;t?۟?? c??6U???Uɣ??? i? ???s3?*?????1V???^<:??H??4.?<u3?7??+aU?A;C?u?'J??&?I?_ԣlkE???)8?B&?gRy?{=?v??%?wiw?y???M#R?#D29t٠? k?<g?J?a0?1???`k??A&? ????|???T?3ym??9??<???e?T2??w^S?s???h?9v3?E?9??x?%??k?y?????z??U5R???????????)l^????r\???z-2??$q.r?j??Щ??ʑ?8??1Z?_<?yM?w?
??&??q?9Q:??[?B??(??S?Di?8??0?<Xɉ2?6??9?
qj?<@<t?y:?y?;??c?f???~?/Q??fxN|??????}~???`????/]?Q??il?s?+Y???y	K??2l?ɛ?j??3?E??w*w?ϗOsI???ު???QmX)-8?^:???k?(?z??JL???M???7???e?.?g??D️ZZn?V???i?|`?
??w:i??[?4&?D ?t&?8C???>8UP???Q?n?Wz?k&$2wl?{?	???[??0???,nе_??)o(X?a7?ZҊ??`?Q??iaX?PfiRa`??돒6??^7? ??Kio??xQԓ?U?n??A_̨?VUS?eT?5*?+je???1`?V? ?z??
?D)?????fϬ?v??B?/?݃??+????????????	&A??????&?32????z?'B^?????????K?5?????e??:j		,??n?"%(???e?![???Z@2?~\f#??;^??aR??Z???Q ???J?Ũ?%SmVz?P=D???)vRC?+?j????d????[1Vv]??EA?V?jH`?T?y~? -???r?޾k???P?g??h?A???????>?????T?V????Q2t????C??z7T?+?:?pI?CK?/?d?i??6T?1˫???g}3/?T/6???B	?@?q??ת?y?{?c???<%6???D??JS??w???I??j@R?{?k??'?x ?>ƓcPP?; ??e??d?????=%?s=A梤?-4?^?^?{j????yEּ ?z???ȥ1?n
????AGA???^ೖ?+O??x?rF1???xh?g?e??|b???????-4{o?j-H??כ??K&Ϗ???39}d???J?dr??r籢?v?B ???<?m)?>??C?????
"??/?KdQ?;?X?y#?? ;i??NjI7?;???ᗻ?/X vp\T<}??OdFؤ?O?ܬ	???a(?؆]??k?=#?^IO?{???]?u$O?l̻	2)?!?ő?.l?܂t
{??D"??|????.)???3F%????????`	RiH??? Ե??_?(???O???{J????)?%?????0?i??E???|~?????M??+????Z??oXy?!H??|?f	A?o?o~C????j}????5M???????Y\??W??8J?Yֽ?] ??ݯ????mQcm?]+?;?Z??n??Q??tS7??ڐ???Um??`a?YR??j?܇?|????}?34?F?d??<3??<?ҥSi?z???f[85u?^?\f5uq???OA????.;?%T,??J?{??o??Hsh??x&(??{????P???l?"??6M??xe?O ??{m????Д7??m?_?\?1?m?Xx?g>)y??&?Rqx????}????^nh?o???Yb?t???L?l?-?>?sH?;?ϣt?'{0????????n?.?*S??lN{	???????5???Oh??ǭ׊J?h???z"??xv??]34]q?,k??|t|.??B???rb?????f?cF? Yk???A?U<
?C?U???Me???V??????????_??"A!??#?s????m????{??~D-?{_5?ɥ???ߛ??/X?6i]?E?jk.=??;??R?vX?tad(??x?ɉG?????Zװx?>?Ě??_?d`??'?~??_???~????&???
V?N[Z?v?"צ_?A??f???qG??W??Q?????K?4?
B??;?"^?b'G?g?ԾQa?M??#P]???3?????|#??Ϝl,?-?
E?ʝ?G?w?٧????r??6L???v?z?M??ز	GM??_DL???]?f.???P?w???঎?.???̥??\???Tب??!"?Ò?s𐂢?fFST?F??h|'???q"Y?5??~?}e??-?{^p??e???F??į?0?lpL?7)?HD?"ɿX??R`	??'-XB????-B?!YjF???jя????n?ֆ?Y@ܾG??jH??!?h??TS!B????D?[5??)????Cr?c$??Ʋ)??nt?m?9?Օҡ???????????-?S???\R??K???Zf~.?O?????2?????p?H?'_&hG?????@?'?????od~????3?޷???n????O?_??d~?G????????!?O_e?{~	??r?ʲsw?󣛟v??    ????_????S?      B   ?  x???Q??0D??S??? ?l??!z???k?E?b!??4ɲe9?ϧ?????x?? pzze|1?:?j ]כ?7???\?%F?
?J?c??1NFrv$_?ϣF???l??? ???,????l????l˴P??,??N@??A???s?	?@?????'lȒ+w?J2=??z?f'Ec(z:??zE???$f??7Ao4?V(?i{?c:??w?M??????=?T6V???????Fgo?U??????.z[uOlzI???ٿ~K??I?ڪ1j!R???5??	I?$?D?A??L???1??Z?O?ƨ??P?8DǶ???'?      H   3  x???=n[1E?ZZ?????3???&0??p? H???ۤ?i\??Hs=??????????Vo????̋?g?g_O6n?o1^jE?}q?/?Y?v???Q???????????Zվ</???y????ß?o3oY???b~=????8????x?Ꮓu?x?????!??dv???@?!G??8?md⦑??[ˀ?ے??-??C??M?.??xʀ???I^2?׷?t?Kt?[tCt&:?DȀ"e@qv??(?A?? ?C@:?-:?!:H??ˀ2d@?2??<;H?A?? [t?Kt?z& ?!C?Lt0]t0Ct0St0?&?`??`??`.???2????!??LtP.:??Tʀ????͠d@?2??Z2???2??2???=?t?.:??tʀ???I]2???2??^2???2??5d@?d@K7F??
??J??:;X??U2???2d_?d@kˀ??l?l?l?H;e@??`?vɀvˀ??!??-??GC?,??	??p!?F!Zx}?^?? ??u~      F   4   x?3??0??V?{/l???[A,.#??ņ[/v@Ō9/,@???qqq ??#?      D   D   x?3??0?bㅽ?]?$7\?W???[?????8/L????@??.l???b6?1z\\\ ?+3?      L   *  x????N!??٧??܆`?,,?,m?.6????1???%??'?x?=??FX???
`???`@'G??#?2?3???)1'?È??p`l?Xa$?6M?????-?U???ٶh??*nע}?P?*??W6?X?,??[??t?????g?_???????<FWXʣl?C&?ȫL}??w-??}??<?+??kY?????Fk?OoH????{?^??K{???M?kw??|??*??J6?,)/????y?G?|???/?k?h'?bB?`@?Tc?/????o?b?&?I.?8?X?ӡ??OL??8      [   :   x???? ??s<LE:L????d??M%?l?Ǧ????s????"M>?1?w?? ?s?	?      N   5   x?3??0??֋v\l?6 n???¦.콰?ˈ???[?\?Jb???? ??-      O   ?   x?u?K?0еs???Z|?,??9J"%?*,?|?PZ#m???eߑ;???x???J&?#bbc??iG?*???کS,??3J????&V??`?r1/w;X`??-?q2v?)mņ	?l4??????v$?Y??5c*??P0똎?)]1w??X3C?g?%໔?K?q??sB?z?%?R?g?ct֠1??b??!|^??۶? ????      J   F   x?3估?b?ņ?.캰?ˈ?¢[/6^l?2??0?b???@???^?
?;.lU *?waPi? ??%      2   R   x???	?@?I1?ڎ????abǡp?w??ۑ???0???s?????`??h!2=?檣`????p????h:u??y1V      0   ?  x????jG?s?)|????cor??#A?,am????I6???)?)???C@1Q0	?3??Q???3??*"????Uտfƙ??A@?G?5s????\???.h?Z8z???g;?fz?????o?"??o񞅉o&?U????G֙??'?g6?<?????]؟=?>2??_?/?|?`'?&@t-? =0ۻ??=??~<53~??˹?M["~???7???X??ʳ??Y<?????MlW5?uV???`?>j?????pZ?% 4@??(?Z@ ?|??z ?=F?1??!???q @? (???(]f???e?Q??B?0?}F?3e???	?F?4??2???,k?(?i?6?\?ƨj[?~\?.?v???R??&PWY?|??0??Qr2Jq*TB?	?Qr2J|x#УBZ$?r?????^ mH?????sg?խ?h???"(?@?._FzT@?	?>????2??d??$}??e???e?I"?B?q!-?Ze?I"?B?q?2??
??????3??
m?L?u&tZ?KB??q!e?I?????d??7????:?کr?]ox????9?q?n?ָb??v?D?\?"(7?????F?G?????9X????????^6?\&(7?????F???/???3???U^?BCz???u+??h[??yq??bdұ?(?vX5uK8|???N?-\?^?^???????l?k?O?M???]?5?ݚx#?,72_??˳t??}?}?[~?`{?s?W???~?JL?2???g?kx?a?_??Wzw?ӝG??߮^??x[E?җ?__?#??if???}????a?n?wT?RO?_e(ʿ?*?
x???????h<??G[????}"????h?ϫoW????n9W7?x7י?c???r?nR??T?Su'??˩?I???>?????Tݤ?^]>;9)_8??0'?ʝ4?3M?5:????z????^c!?V??K.???d?.?^_????p??     