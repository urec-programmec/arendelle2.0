PGDMP                         {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    28887    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    28893    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    28895    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    28901    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    28903 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    28887    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    28895    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 106, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    28906    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    28908    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �      x������ � �      �      x���Ms[Gv��+T�f�J# ��%�f1�IU6	�H(RER3q���~@$LHF ҷ�{��Ђ������ݷ����/{�//>�����g{��j������������#����O�ǳ���?�o��_/?�/����|�����/�}������/���џ?������o������7?�����?\�_]���뻗s��O����g?���..g'����_�/�?r2������_�_�գW��⿎��_o�u�Ч�����˸:��t������?~���y�p�o:��F�|���~��w����r~q�{߻x���������O�������O׻��_W���ݿ���ߗ��_}�����5:Z�[Ȼy���#[���ʃ�_1�h��}�N� m���^[����H��-����s��M����-��&�M�"�&��=�D���n�v��F�J�MC�J�4$ڡ�Um�Ci��h��=Bm��F����E���a$�h$h��6�h��6�h���0R��Pڪ6ڡ�5���-��J{����m��۶��P�	ڡ��#���V��ڪ6�=��j���s��rH6�-���~`�-h���6�W/_�D�F���ׯ	w&num�Um��Fm��Fm��~y�ͳ;ʆ���(T�3ewG�&��4�l�a+�d�*ۦH�Ciۃ�v(mm�Ci$h��^�(��خo[�F;���ch���@�Ci���n��v˶�m��F�J��H��5m�h��H�����v(m�m��F�m�Ci��h���!A;��	�h��v%چ�h��6�D;�vG���cd7� ��v"l%��Vew���&;�fA���F����:num�Um�{@�,;ڡ��Ci$h��H���&�3e;��j�����d7-�{��n3�����6�hW���v(m�5h�Ҷ�m��F�mY�r����Am��Fm��A۔ڽ������m�����C;���H�Ci�h��H��m:�P�	ڡ�Um��F�J�#��-k��6�hW�-k�J��cdg��h�M6�d�]g��dg�lCH�_��H��nw�D�6��l���vy��6ڡ��m�Ci[B�v(mkZ�.Gۍ��Fm��Fm��F�0m����F�l$ڽ��j�J[�F;����v9ښh��6�h��6�h�m6m�5��F[�F�״em�Ci��h��6�v(m��P�	ڡ�5����j�J[�F;��@�v(m�?�Ci��h��H����0�햲AvӰ�Gv��m��Ѷ{���mύ���q�$h����6�h�]��@�6�h�]��@�v9�:�h��V����j�J�N�{M[�F;���ڡ�#���j�]��	�h��6�h��6�h��6�h����6ڽ�m	�h��v%�f#��-k��6�hW��=	�l��m�v(m�H��F�J��Cik���6�hW�-k�J[�F���l;^��e6؉����F�-iO�=7R���qkk��_�+=�?�sh��h����l���$A�m�?��F�J�7$�u�'h��0mU�Pںh���9�Ci��h��^;gc�v}ڪ6��h될�6�h��6ڝ��a6��?���^��8�r�%��F�J�5��Fm��h�U+ڡ�em�Ci[Պ6�h��m�?��Fm��F�s�;���g�v}��l��m��Pںh��m�6�h��6�hwN[�F�״݆��iO�=<R���q�l��6�h����v�Ci��h����C;��@�v9��#�Fm��F��io���F;����h��v����v(mS6hG��!A;��Ӫ=B�ڪ6�h��v%چ�h��V��Fm�+��,��D��v����6ю6�h�]�����	��m+�h�Ҷ��r�u��Fm��Fm��Fm��Fm��Fm��Fm��Fm��Fm�{G{��ёv���:nk��F[�F�4mi�PڛUm���-k�J��H��і��Fm�+���C�״em�Ci될J۽��N��l�J[�F�m�?��Fm��Fm��Fm��Fm���m}ڽ�m6�P�	��Wb��v�sh$h���a$ڡ������F;���l&h��0mU�PڛU�T��C2f��m+�h��6ڕh�r�I���6i�v(m��P�V��]��q$����i$Iw󺭑B�/�e��Fm��Fm��Fm��Fm������v�i��j3t��m+�h�Ҷf�P�Ƒh���E�6�h��6�h��6�:$h��j��6�h��6�h��v�#�Fm��h[��v(m��N�힖h����.G[��P�O��J-HЮJ[�F;��fY{�-��H�nڶ��v(m-��F�<ڦ������v(m�m��F���mO����q�l��6�h��m����ض���	ڡ�wH$��.O{����l�l["Am�ѮD�|$ڽ�ma+��h$h��6�h��6�h��6�h��6ښh����E$ce��m�h�Ҷц�T��6�h��6�h��9m�Z��5m�6h��6i�v9ڲ6�h��6�h��6�hk������6���h����6ڡ�em�Ci��h�Җ����v���6��=}z|�������Fm��Fm��Fm��Fm��Fm��Fm��Fm��Fm��F��жd�^Ӷ��r���F�J�w�C�&����l��6�h��6�h��6�h��6�h��6�h��6�h��6�h��6�h��6�h��6�h��9m;���5����m���v�ڡ��m�Ci��h��6�D�u�SgG�[k��Ж��Fm��h�[+ڡ��H�.G�0m��F�m�m��F�m�m��Fm��Fm��F�?樦	�h7L[�Fm��Fm��Fm��Fm����C;����v(��U{e$�hW��j��6�hW�m�ڽ��>$h��V����j�J[�F;���Y�J[�F;����6�h�]��@�6�h��*��֐��C۔�iO�	w*n�Z����"	�h����F;���$ڡ����6�D;����v�i�����خo�8�Pںh��m�v(���p�6��m[��v9�	�h��6�h��6�h��6ڦ#�F{�ƶE$hק����\��l�]޶9���6�Dm��Fm�;�-k��k�6#�J{��H+�ٮo[�F;���v�CiG��6�hW�-k�J[�F;����v(m�Ci��h�Җ��Fm�;�=}zz$�pg�6�DmU���#Am��Fm���E헩�:$h�^�h��C[�F;����6�h�]���H�{M[�F�m�m��Fm����v(mUm��Fm��Fm��Fm��F�i�o�ч6�Ui��h�Ҷ���ж��Pڪ6�=�m	ڡ�Um��F�J��D;����v(mS6h��6ڕh��h��ޭj��}H6�-�V��Fm���=���H��n��6�h��vh[D�v(mU�Pڪ6ڡ�Um��F�J�-"Am��n��{젍6�h��6�h��6�h��6�hk���k��u�e���m�����Fm�+Ѷ`�^Ӷ��r���Fm��F�sڛe�T�|��lЮO[��r��Ci�hG�״Um�Ci�F�l�]޶��v(m-��F�J���B;�vGU��zd7=���v��;��!��L�r6�/n$�p���� m���Ŏyv��ۖH��m�m��F�m�Z�N��l��6�h��6ڶ�����Tm�m���V��Fm��F��i[��voh�Um�sho<��.�hק���v9چ�h��6�h��v��d�߶-�C�m�m��Fm��Fm��Fm��F[�m��F;��@�v(m�Z�Fm�+і��F�)dd���(r6؉��l��&��dO�=7�v�nw�1$�h�&��v�?��H�F[ A;��@�v(mU�Pږ��J�0�r���Em��Fm��Fm��Fm��6e�v�i�k�J���і��Fm��Fm��FۢV����Cm�m��Fm��Fm��F�g�B�/x�6��i�k�J��?�Ci��h��6�v9�:$h��5�﷔�&�_8���-�`'��:��Mvfߏl�7�=���H��[�m�m�H$h�m�m�M���v��?��V��F[�Fm�ю�=^G{0��nض�h��6 #	  ڕh?M$+�t$�9�7^D2����mK$h��6�h��v�Mڠ�6�hW�-��J[���T��6�h��6�h��9m-�Ci��h��V���5m;�.G[ Am��Fm�;��Yֶ��P����`	��m���]����6�h��6�h��5ڎ!#;S���vh�D�&{S��mώ4gw�MG��v�m��B�6�	�h��6�h�]��͑h���!A�m3�h��6�h��6�h��ܾߡs��nٶ��v(m�?�{M�t$ڡ�Um�Ci��h��m�6�h��6�hwN۪V�{M[�m��Fm����
��v,��i��A�m�?��Fm��Fm��Fm��Fm��Fm��Fm��Fm��F��ўn{t�e�p���2��V���m+����j�J[��Pڪ6�h��v%�	��h��D;��@�v�i����h$h��6�h��v�#��5m�Z��m���h��h��6ڕhoH��d��A�eڪ6ڡ���C�״uH�����v(m��h��V��Fm�۠���6�h��6�h��6�h��6�h��6�h��6�h��9m�Z���j��6�h7L{��H�Sq�g�6�"	�h��vU���Ɏ,�d����#��Lق6�h��6�h����H�{M�mH�.G[ Am��Fm�;���,;�h�N������6���h���a$�h��6�h����o)l�_xi	ڡ���h��b]m�sh��Am��n����h��6�h��6�h��A�g�=^O[�f��me�r��m�Ci��h���
��ӑce��mK$h��6�Ӟn{l�%Rp�����F[���H���Q q�/,{��[��N��m{��n���v�aD��P��~h��V��Fm�۠m�6�h�]��1]�6��Ҷ|�Pڪ6ڡ���t�l��A;���6��h�����O�l���l�l�3�6�dgʖ��n;���v��Ͳ�J[ A;���H���n���6�h��6�h��6�h��6�h��6�h��A�ߥ�֔�Ui$h��6�Ӟn{b�Hw�$�Fm�{@�f�Ci�6�o)��c`7{�M6ٙi�l�3k���6�h���6ڪ6څi[A�6�h��6�hwN�0�^Ӷ~�Pڪ6ڡ�em�Ci�a�v(mY�Pڲ6�h;~��B�;E�M6�d�]fS$�`7��fiki��6�hW����v(m�h��H�.G���F�J�7$+��s֞��vö�m��Fm��Fm��Fm��F�w��۞i	ܭ㶌m�Um��F���;Z���1�_X�n-�	�`'�V��nU���v ��h��C��!$�h�Fm�і��Fm��Aۺ?��F�J�7$�u�mhg;���ڡ��#���j�J�8�P�	ڡ�;�I6ٙy�l�3�d����&;S�!$ڡAm��F�J�?���f�ߐm���V����E�v9��ؠ�6�h��6ڝ���F;����6�h�]�v�kZ�Fm��N{�홑n�Cw�5I�F[&A��-#A;��n�dp�%m'���Y��&;S�8�v�qm��Fm��F[�F�/�^A�@[�f��m��r���Fm�ѮD{�@�&;h���"A;��@�v(m��P�	ڡ�Um��F�J�wFN��6�M��z��dC�����6��k�N��V�@�v}ڲ6ڡ�Um�Ci��h�Ҷ3��T�	��h�>�6�h�]��@�v(mUm��Fm����fY{��zN�C�!���7����̯W���������/���ͥ���w���_���a�����OO����mv|q~r�7����i09|}8z=<<|��f8�����^�f��%n^���C�_��C��j~ro��������?�n���~�|98��2Z����[n^��lv�ף�>�������u�7y�u�|s.�<}�|�`�n�e�<stx���������7[|��wW�G������w�x�����'��7������~}�+8�f��/]��wWoq��<��+����ʗ���h����,�y�|��kW���ٛ�������s_���ѻ/��l�v���>å���ޭ\��6����k���.�9���%;���9�O���vz:��vs���3~��\�����ݗ�ǵ��w����߇�h������x|t��r�g�t��p�K��l�w��O��ݧkt��\ח��l��3�e�ڇm�mތ���f��>l������R���_}4��2�����WwO\��{���X����=��2�����W>���W|���B���[O߲u���w��և��&�_�9���ogo�`�!b]~����|�q>;~<�X����"����ܽ�3�~�h�gn�̇_���oԁ7j�7j���:�Fm�F������|�����\Q�     