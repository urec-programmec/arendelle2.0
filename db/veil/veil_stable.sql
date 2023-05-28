PGDMP     *                    {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    24513    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    24519    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    24521    veil    TABLE       CREATE TABLE public.veil (
    id bigint NOT NULL,
    map json NOT NULL,
    dair1 json NOT NULL,
    dair2 json NOT NULL,
    dair3 json NOT NULL,
    dair4 json NOT NULL,
    dair5 json NOT NULL,
    meisters json NOT NULL,
    business json NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.veil;
       public         heap    postgres    false            �            1259    24527    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    24529 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    24513    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200          �          0    24521    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.history_id_seq', 3, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    24532    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    24534    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �      x������ � �      �      x����R[����)�ЛtF&�����4�酢Y�#ᦙ�߽B��MK>k黉�,)�����ٻ��p���������?������w����t2����-���.�o�&����O�}�����哯���Ofgw/��z1�Zʛ���z���{��>�r���ٛ���\�a��ˍO^\ϯ�'?��g�����3'����������b����|1]����_���`�̻�So/f׋շ���߮��[�sv������;��y��c^4x̋����W�:���ͯ��ڛQ��/ϧ��Ww����O�������S>���_ގhw=h���t�?zw�ӭ~����dz��Fw������&Km7�7-_J.��K.��K.�; �G.�)媹�攫�K.��nO���K.��K��K.��K.��K���5�F.��K.��ʹ�K.�m�k�ܜr�\r�%�\�r�%�܊rAr_��n΢�'��P�Q�h䒫�K.��K.�r.�䪹�K.���X�\r�%�\i�\r�%WW�\r�%�\r�m�\9�ܜru��%�\r�\r�Us�%�\r�%�\r�-/w�i�6a7�]�9�[D��K.��K.���B�܊r�\r�%�\r�%W�%�\r�%�\r�%�\r��!׊rs�Us�%�\r�D�K��KnE���9�J�K.��K.��K.�m�; �\r��0�g"7gZ �\r�%w{���K.��J�V���\r�\r�Usɭ"W�%�\r�%�\r�%�\r�m�\sh�攫撛S�~.�9�J��+-��S��K.��K.���-�[Q��Kn
��N3��.��ڟ�\r�%�\r�%�ܝ��#�ܜ}1rɕ�%W�%��\���K.��K.��K.��K.��K.��K.�VܐK��_r�%�\r�%�\r��u�FnN��b����a�E7%]4�+�����u�F.�9�b�+-�K.��K.����%W�%�\r�m�\i�ܜr�\r�%�\r�%�Z1r+�Us��)׊r�%�\i�\r�\r+�5�FnN�j.�9媹�K.�arG�f� Uv3�u�/��K.��ےk4r����%�\i�\r�\r�ȕs��)׆��K.��K.���xt[C7���.��.�袋.����5L.�-�H#�\5�\r�\r�%�\r�%WW�\r�tCn{��E�ܜr�r.�䪹�K.��K����K.��K.��B#�\3�f���K.��K.�z�K.�m�+-�K.����o�\r�%�\r�%�\r�%�\+n�-)w�i�N�e7�]�V�[D�=���)W�%7�\5�ܜr��O.��+-�K.��V�+-��S��K.��K.��:W�܊r�f_��.�袻ż�.�I�K��r�%�\r�%W�%�\r�%�\rwO��.�I����X��&�\r�%�\r�\r�%���r����u3��ӍZt�.�I��K����Kn�Q�h�K.��J�V���@.��+-�K���ɭ(W�%7�\]1rsʕ�%�\r�r�%��rG�f�����싑Kn�k4r�͙t�%�\r�%�\r�%���K.��K.��K.�z�f��T4rsʵ)�I�F-Cݤy]t��%�\�r���%��\5�ܜr�\rs��C]tѭ��E7)]{ݐ��1F.�9�.��K.�r.��j.��.�袋.�袋.��&���@.��K.��K.��K.��Kn{�F�L.��r-/'�\rɵ��\r�\r�%�\r�%�\r��u��]��h�~����#�ܜI�\r�r�%��*r�r�%�\r�%�\r�%�\r�%�)ru���)�i�����a�E]t�E]t�@�\r5��%�\r����%7�\9�\r5�E]t�E]{ݐ�"�v#%7�ܨ��䪹�+�[EnTZ�\@7i�E]t�E]t�E�oM7j�.���0�����.�袋.�越�y`rs6�%7g�\r�%�\i�\r�%�\r�%�\r�%�\r�}��Q�n�>`��欺䒛s.�\r�%�\i��*r�\r�%�\r�%W�%��\5�\r�%�\rɕsɭ(ב��k�t�E]t�E]tw�.��K.��K���.�袋.�袋�nҵ���r���!�\r�%�\r�ȕs�%Ws]t�E]t�E]t�E��t�6_@ݤ]]t��E]t�Eݪt��+׹��K.��K.��V��
�\r�%�\rɕsɭ(׽�䦐;�4C'M��Ѯ���%�\rv�%�\r�%�\r�%�\r�m���䒫�K.��K.��qݤt�%�\r�%�\r]t+��.��t��袋���.�袋.�袋.�袋.���,]�ݐ�sF�\r�%�\rɭ"W�%�\�t�E]t�E��= �\r�%W\@�
���椫ꢋ��K.��K.��
�袋.�袋.���*�ܤr]t��u{��r�vw$�\r�%�ݨ�6�nF�[���+7j�.����.�KnN�Z�袋.�袋.��V�K.�9�*�袋.��a'��ܨm��%�\r�%��*r��ݐK�+4r��^Z�C7i\@ݤy]t�E]t�E]t�E]t�E]tw����%�\r�%�\A]t�E]t�u�	�����.���ʍZ�K.����K.��+�K.��K.��K.��k�ܬr�\r�%�\3��r+ʍ�B#�ܜ9�\r�U���I�nF�[���+7j�}r���] �ܜi����&�被ꢋ��n�E]t�E�V�u0�9�K.��>��ڑ\r�\r�%��*r��%WC]t�E]t�E]t�E��t�1G]t�E]t�E]t�m]t�E]t�E��-3G�`��A7)]�G��SnT�%�ܜI�\r�\r�%�\r�%W�%�\r�%�\r�%�\r�%Wo�\r�%WZ �\k��%����Kn�ܨ�K.�9s.��>��Q��Ĝ݌v��t݉F.�䒻=�n�E7�E�袋.��uD�]Y]t�E�]���ʍZ�@.�9/��%�\r��^O�\r�\r�%�\r�%W?�\r�"�$�袋.�袋.�ߚ�e��&���]t�E]t�-DW�E7)]t�E]t�E]t�Eݝ���rs�u�%7V�����)7j>�\r�%�\r�%�\r�%�\r�%�\r�%���k�\r�%��/��Z�nI�Q�h}r�M�%�\r�}7�4C����ѮM��%�\r��C]t�E]t�E]t�m]rc�F�v$��X�&��%�\r�/�!�\r�%WZ �\r�%�\r�D�K��_t�E]t�E]t3�u�:�袋.�袋.�袋n���0��.��V�; �\r�%�\r���\���+�q=���i��K.�ۛF#�\r�%WZ ��\5�\r�%�\r�%�\r�%�-r���K.��Z+F.��Fn�\r�%�ܭ�\r�}V��N3��9���z�\r�%��5���k�t��Ut�%�\r�%�\rɭx%��j�K.��K.��K�+4rwC����Kn~��ܠ�4袋���.�Ζ"�\r�%�\r�%�\�h袋.�袋.���*���ˍ�Ց\r�%�܇r��ݐKnΜ�ݤE�a'���䒫�K��Kn�j.��K��@.��[Q��@nN�j.�9�F��H.��K��Kn�Q���%7�\��MJ�O.��r��b���rG�f�v3�u�	�E䪹���r�%�\9�\r�\r�%�ܶȕ��)W�%�\r��#�\r�%�\r�%��6�u[�袋.�袋.�U�:���X��E#�\r�Ϳ^�\r�%�\Wh��y��b袋.�袋��K���䚌 wg䪹���]t�E]t�E]t�E]t�m/]gR�K.��Kn�Q3i�K.��Kn�Q��K.��+-�[E����Kn~�.���tG�f�LJv3�u���Kn���䪹��PnԖ!�K.��J�K.��K����!7j�����-Xt�nҢ�.�袋.�袋.�袋.���r�.��h�K.��K.��V��
�\r���E]t�E]t�������#�\r�%�\r+��N.��K��@n�j.��K��r�5��.��[���T�%�\r�%��ܨ����ʍ:4�\r�%�\rɭ"W�%�\r��;�4Cǣ��Ѯ#)�%�\r�A.��K.��V�+�K.��柋 ��X�Q+t�%�\r�ݞ\7Q���]t�vt�EW`@]t�E]t�E]t�E]tw���t�%�\r� �	  7!A.��r��;�K��@.��薡k��I�Z�nR�Qi袛4�J#7g�%�\r�%�\r�ȍ�.�K��K.��K.��K.�m�D#��X����%��t�E]���-J7��:	�ܜE�\rc�F-] �\r�%�\r�ȍ� &�\r�%�ݨ����nF�N&�\r�-�t�%W�%�\rɭ"7j��䪹䒫�[En�
]r��)�m袋.�nFC]t���tt�E]t�E]t�E�V��a@7)]ǩ�����t��)������t�%WZ �\�1t�Ѝ
�袋.��
��*�\�1r�mQ�%��X�Q��%�\r�%��*r�\r�%�\]1r�%�܊r͡�K���h���n����&�&7g�%�\r�%w{�h�K.��Kn�r.�)�:�Љ��f��,`r�%�\r�%�\r�%���ʍZsC.��K.��K.��K.��K.��'�M�袋.�袋.�袋.�袋.�袋.����L��X�=r�M)�q'��+-�K.��K.��K.��K.�O���KnN������K��K.��[E��KnN�z�攫�K.�䒛_��y�E]t��]@ݤ�t�M�Ln΢K.�9�.���ʍZ�@.��K.��V�+璛B���_�nF�N^'��ܨ�.�䪹�K.��Kn�57�K.��J�K.��K.���\sh�攫�@.�n�E�@\@]U]tm�G.��K.��K.���f�Q}1rɍ��rs�Us�%�\r�%�\rɭ(���K.��K.��Kn[�F��K.��K��@n�f"��)��\rs�u�:�I�F]t�M��E7)]gQ�K.��K.��K.�䶥/F.��r�ݐK.�䒻�	`r�}V��N3t���:��"r����K.�ۛ� �\r�%�\r�%�\]1r��[ w7䪹�K.��K�����-ݤt����&�6�#7g^ �ܜs䒫�K��K.��+-�K.���\i�ܜr�\r�%�\r�%�\r�%�\r�%�)ru���)W�%�\r�%�\r�%��\Wh���Jrs�u�:�I�F]t�MJ�y~���.�Kn����K.�r.��K.��ۖ�r��#�\r�M*w�i�N�a7�]gK�[DnT^ �\5�\r�7�K.��K.��K.����%W�%w7䪹�K.����~���䒛S��B�E]t�Gn�v�%�\r����%�\r�%WZ �\rɭ8�K.�j.�䪹�V���K.��K.��K.��K.��K.��K.����%W�%��\wP�K�}�N�"�\r�%��*r�CI.�䒛��K.��K.��K.�wg"�\r�%WW�ܤrG�f�d)v3�u��E�F�r�%�\r��] �\r�%�\r�%�\r�%�\r�%�\r�%�\rɍ�o�\rs�]}�.�袋�]��-!�N��K.���b�K.��>�u'��K.��[E����K.��K.����K.��K.��K.��E���9��%7�\w�K.����|rs�\r�%�\r�%�\r�%�\r�2�K.��K.��K.��K.���\]1rS�u���y��h��R����%W�%�\5�\r�%WZ �\5��ݐ�W��K.��[E�+4rs�u�FnN�Q�ܐKnN��/�E]tѵ�#�%�F]��KnΎ.�����K.��K.�U�ʹ�K.��K.��K.�m�k�ܜr�\rs���%�\rɕ�%W�%�\r�m�\i�ܜr�s��)�}h�{_��y�͙�%7���K.����K.��K.��K.��K.��!WW�\r�%�\r�ݐ;�4C'K��Ѯ3��-"7j��䪹�K.��K.��K.��K.��K.��KnV�����)7j�r��)w��袋.�袋���ڊ�ܜ�rɍ�k�}r�%�\r�%�\r�%�ܶ��[ 7�\5�\r�%�\r�%�\r�%�\r�%��ݓ��KnN�j.��K.��+�[Q�[(�MJ7��:[�ܜA�\r�\r�Usɭ"W�%�\rɕ�%�\r�%�\r�%�)r]���S��Kn
���w�o�d��H���N{���;�V���`�����a�����%{ˏ���W���W�n����s?O'����٫�������?<�t��G޻���{\>1[��d;>���A��w�~`�w#ӿ������g����n��b���<��/���3V�����Y>����z|=��8{s���R����?9=8����ٟ��ݍ�������W����t��~j�_��r�K�������������|<½W#|���=8������^���������a�t�?��ს]W���>L��G������I�7C�;>.�w<{�?9�O�Ɠ�O��у!��:8�(����q��sc��jC�����`�O'�>������q���A����p�w��7^�ƿ����Y������/���3�������,G���=���7��M�\�Oz�G���C����.g��}
�w\͖@~�������/?$��y��W�s���<��w~�A���@=n��quh�1P��}������j)?     