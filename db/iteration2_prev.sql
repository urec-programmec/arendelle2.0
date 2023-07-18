PGDMP         5                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    29608    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    29614    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    29616    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    29622    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    29624 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    29608    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    29616    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202          �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 115, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    29627    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    29629    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   �   x�u�K� �5��1؆�#���?G�gS��K�fF�,?P`⒨%�Mv�^���jn$$>3/�Cu��ivg�>�?WO{Q��0U��eY��ȹ��,}���pD��5�x�?jc�����ɰv}s����>�      �      x���KsWv ���W���L�,�Q�%�f1�IU6	ʜH���f�r�� �-6�6^}��o3�  v8>��ǩ��㏿����t}�߿|����勣�����O����|�=��-�<}�?�/��?X�O�����,�{�i6������_\]��?�}������W��G�y������un���������yx���?/>�������������o_?������맏\���oo~���'��?|y��n����������#���t}u��1��o>-�X=���ӗ6?��u�'��<i��I��}��Y�<����������8���~v��ۗ��x����z���6o�[�����/����W?^�v���gsssx���8>�?���>��h����Mv�o�c���&����6�������M�!t����M�!t�L�Ϋ[즻h�=ɮ&d��OٻLV�`��]Ğr�uB�'\s]�k3�d�M6�qd�3I6�eg�d�]�l1�윲�l����M6�d�Fv�+��&��l�e#d�M6�d�M6�d�]�Rm�윲�l�s�V�#;�l��9eO[e�h���M5d��O:R�v'�u��+�{׺f{-��Mwo�{�gE�M�!t��t�ݮ{�,�{��^����=�6�NvN�ë|bR��bd��|�_��YH{y;:��{����m���C趠�y�-p��7p�M7�t�oΝn���s�MvN٭���d"�����k����.����)�1Rd�m��윲e#d��~���h��-h��S��cdG��/�9eo�h��kE�`ڂ6�d�Mvي#dY�YH�sʖ���S��6�9e�F�&�l���V!;�l1��e���#�?��?v:k]�k���f��!ڎ��l�[�_�����(���-3���Rt�T+9쌰�l�SN܌��Hז��]���M�EZF�vѶ�u@@����'j;Q�쎲ζ�M�!t�@w^�2��ꖙНW�̄�u�MvJ�����a��kkILJ�M6�do%����d;D�l�"E6�d��[�<��h�K��!�l��&�l�� �L�C��ڿ�:A�贕���)�$$�9eK���)[6BvN�&!w$��YLE��NH[�.����6�h��v?�H'Ɠ�Qv��t�;�ni	޽T �����6�t�R(��&�l�KL��[�7��"]��!�p٧�v�d�8��ZѶ�zyd�ڻk�Ѿ9�6e�w!�n�S��rL�f��H�Ɏ���l��F6�d�M6�d�M6�%�6�${Ȳճ��)�9�d�-f��S��MvN�b6��d���M6�d�M6�d�M�9H��V�#�l1��aʖg��S��MvN�� ��)[6BvNٲ�s�V�#�h���%��iui�eڢvѴ�#d���G� d�&�:1�]l�!�{�_�w�9��vɰ���NJۮ1���>ݴA$�ln;T>���z�:��?����x�����_�Q[����m�M6��#d���M6�b6�C�-f��S�}dY��MvN٪~d�mIvN�b6��d���M6�d�M6�d�M6�d�M6�C���M��e[7B6�d�G�9H�sʖg�M6�dǑ��;�d#h���!$�9eB�M6�dǑ-!;��~�#�z��v����F{��ɴюF������Q��5����Bb��ސ%�Ҧ��G�����k��V�#�l���H�馭!-�c�pۡJ�d��Kٍr^�3�z�v[1z=�qI�#�<e;Z���_��gk�?@;A>�>Bv�*d�M6�qdw�F�m�O�&�\�b6�9e�\�#�l�!�&[�&��oN�A�^��Mv4�j#d�M6�d�Mv�<�u�b?�c�n�|`Iv4����&��8���&�l������윲��d�m+�d�Mv	�U��&�l��&��yv뒨ʮ����<�ak��6�e��F{�F�l'�]��6�h�vk'g��B��\;!mQ��ڟӆ�.\�馽!-�f�pۡ��d�M��d��Q�8�4;ڂ��M6�
d�-!;�l�d�M6�d�Mv�<�l�s�V�#�l��.Sv������kX�î����a/?�	]��!;�l��s�~��d��@��M6�d�G�$�9e��d�M6�qdw�Fy��;����ͭ�M6�dǑ����������MvN�e-�#�le?��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l���i�/ۅ۶ڏl��l�˖i��Sv��M6�9e˳��)�NH��ɖg�M6�dǑ��G��e˳��)[m�윲��vRڂ6�9eK�Ɏ&[ُl��&�l��&�l��&�켲G+����p�{�v���Sr͵�Mv�-�"{Ȳ�@��S�l����9F�s���u�Ǫv������3q�е\����6~$;��r��V�&{����PsB6������)�[�ndԟk#S��.���M6�d�G�6g2C��v?s5���^���{�׾�dG���,�"[ȶp��в� �N!�t�~�Ɛp��۪(�"[BB6�d�M6�d�M6�d�M6�d�M6��d�g�=d٭�jj���O[�&;�l�鐝S�!$��d+��M6�d�M6�d�M���d��d�M6�d�M6�d�mI6�d�M��~d�m�6ڃ���J�sʖh�M���9e?�ٍH,!;�l1�윲��٭Gh+��]2mA�윲G�&�l���6�NvN�����;��-�����}@�mMx��('%��;a���a{��t�搆��\a�l��&;�l��h��edg�-!;��-ґ�Ɏ.�u�o�6�Ӗ��M6�dǑm��!˶���h�e#d�M6�d�M6�d�M6�d��I6�ê��V��������+�ŧ�:���e#S!�riK���)ۦ�����&�l��&����U�d�m��윲˚�!�ly6�d�M6�d�M6�d�;�T�#;�l1�윲ճ��l�l�sʖg��S��MvNٚ���������SS�}O�Bv7���B��� ��6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d��Zvɫ��&۞1�ɖ��M6�dG��Ŧ1���.���M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�Mv��m#;���/�m����=��eO6�-�F;)�~���ydw���?o�Ɋn��Э5$�yu�l�=�%��d�M6�d;��l�ͳ�U�$�d�Mvٲ��&��8�e#d�M6�d�M6�d�M6�d�6�ڌ�l�˕-f�M6�d�M6�d�M6�d�M6�C���GvN�b6�9e?�ٍ=�d�T��M6�d�G�=5dY��F��)[�&;�l1�윲�l�s�vb%�9e��d�-f�M6�dǑ-!�hٛw�뇶�bdw�ݹ{^�l��G覻��-C��v�O5��;�n�Y�����V�&�l���&[6BvT�F�d�-f�=d٭�EUN�B;<mCH�s�V�#;�lCH�s��"Ѯk�юN�&��ɖ��M6�d�M6�d�M6�d�m�l��#{�����1{�6��i��!;�lCH��&�l��&[�M6���M���BZ��vxڂ6�9e�_';�lCH��&��8���d�-f��S��MvN�j#d-{���m=���(�ss���vE7�e�F�ĴO�7�T$�;�nCI�����l�m��&�l��&{_���%;�l���"��c)�^�����U;�����3q�е,���e�d�M6�qd��${Ȳ��dG�-!�l��&�l���d�-f�M6�d�M6�d�M6�d�M6�d��ר�MvP�b6�9e�+F�Pd�+�uF�"6�Ñm��9e��Gks�I;�I�\�9�ŧ�k��H��$;�lY6�9e���){y��Uь�7o/�m]j�쎲w�^L�<�S���.Z7�d��� A7�Yuo�R���u�o�M6�d@�u$d�-f��S��MvN�b6�d�Mv��k�M6�d� ۩:d�M6�d�M6�d�M6�d�M��e���=d��6�Չ��vtڂ6��dK��&�l��ȶ@��!˶���h�e#d�M6�d�Mv�<��Q�>�����V!;�l��9e�]'{Ȳ�l�s�nA�5�hG�-h��S���dk���ao�h��eQt�}��1�]��`�p�u��[YW��3�6Y���5n<��({�EcH�c���,��Mv?G�eG;<m��9e��N6�d�G�� �  �h'�-h�M6�d�M6���m;�9e+h��S��M6�d�M6�dGȳ��#;��Ƹ�Ș]�`W__êv�v�{���N���ӆ�/[͏�h���&�l��&��y�}�h'�m���dKG�&�l��&�l��&�l��&��!�V�#�l���&[6BvNٖ��M�V5`���tSw[k��.'�mk2��v����0r�5�	]�`�6��>ݴ'��t�.�v���d�LG�&��~d�-!�l�ٹe�F��)[�&;�lY��)���h�m�%�l��&�l��&�l��&�l��,�L�C���MvN�e��`W__�I;��3�UW؋O�u<ײl�l��&�l��&�lkX�&[͏�!˖��M6�d�M6�d�M6�d����H�
���'d�]�z6�9e��ҏl��l��6IvX�����%�7��ց	�=g#۹~�5�	]o���6�`�馽 UF�.ܶ�u��6Ivzٲ�s�6�NvN�& ��)[�&;�ly6�d�Mv��6�U-�F�\�ְ�M6�dǑ�<i��&!�N#������-!�l��&�l�#$��j�&�l�K�-!;�le���^�>��S�}ڕ�-j礝D���\gt-b��6B�Pe��d�-f�=d����M�l�l��&�l�Ɏ�g�.FvN���2X7�vx��~dG�-�&�l��&�l��^'[1�S����4R��4"d����-!Mհ]�m��d�m�����!��)[6B6�d�M6�d�+�FH�s�V!;�l��d�M6�d�M6�d�]��Z�u��-h��S���C�m�윲�l�s��Ɏ&��l��&�P�B����u�d��8B6�d�M6�d$�ax��u= ;�lS5dG���G6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�=٧��������m�/F6�b6��e[�MvN�b6�9e����S��M6�d�G�l��h��B��S�l��!�v���d�F�&�l��&��y�$�9e[�JvN����M�<�l��&;��n�ȴ���K��%$�Ii[�G6ي#d@��6�9e��$;�l1�l��&�٪~d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�}ɶ��윲�l��&��be�j	�vR�vՐM�|�l��&��βG`��	��l�S�V�씰e�d�M6�d�=�f ��l獐M�l�l��&�l�Ɏ�g[�GvN�b6�9e��d甭�Mv4�F�d�M6م�����{��f3�\s��d+�j�H������d��z6�h�v#�Z�F��Gm��Fm�ˠ���v�d�M6�d�M6��ɶ˗�!˞���юN[�&;�l�6�9e��dYv���Yȩ��v���#d�M6���>ݴ+d?ˢ�>@����-��sB��t/�i��a��"	���Ʋ��4q[Vr@�mʪq����	��w�v������ӆ��`�������#\s]�kEm�C��V��^�uQd�-f�M6�d� ��l��&;��C�ҐMv���#;�l1�윲[wC:v���MՐ�S��6��d+���@v�#��&���Ȇ��溏,[kH���"[�I��NJ��:�E�V��ms�lm;X9�l��&�l��&�l��&�l��&�l���Dv�S5d��K��fj�*[6B6�d�]���M�B����z�v7ںB�M7�tM�ΐt�սݘr
7��C
�d0s� a����%YV�`�U�E��l���"�l1��!ȶ��l��&�l�Ɏ�gA��S�,��)[�&;�ly6�9e��KvN��l�sʖg�]��oӓ��BdA�6�`�d$�\�Z�[�1�����6�{�ڞ�݅v����{TO�o��M@�]t����M�5d�M6�C��-i������.���M6�d�M6�d�M6�d�M6�dH�馽!��,����h��~	m���-j�=$���]��ZB��$7ݥ��)�>쌰�l�]��4����-f7���v����= ����NJ[B�6�h�]m�ʣ�v8M�6��i������ȴ���hǧ��GvN��d�-f��S�!$�9e�F�.Zv�M�d�]��7 ���a��g�l��-[�j�K�6�)a�;UGm�m�l���E�l���دF��m�s�6�Nv4�vՐM6�d�M6��l�Ɏ&[�&�l�Ɏ#�FH��&��be�n����t�?`���pKY�F{���3�6�{���)�Iio��T��.�B�݊�1�\k~���i��Dm��Fm�{�-�>$mݘH���ma[�.Ķ����ȶT{W��gd�r0+ڂvR�%�C�e��G�ir������]/��{��mQ�����;�ny	�yu�L�Ϋ[즛n�鎧[�H��l/�`���z`�{AB��n��;��톒����N���yu��t��-v�����^���&�m{'�;v������-fж{���E�i�G��l1�l��&�l�Ɏ�g�v��{�=����Q��O��]\\������������?⃍ŭ[���xx���9�������ˣ�c���\_,����۳?W'�����z2yy����e����쯏����O��~�'�~�������G?���x\�~��~�?F�����N�OY|�����g�|��]�����V���y�s��8��^>����ꅓ����K?ݾ_�b������������~��_�W����r4}�����r���n`=����u7���͛��ݿѳ�׸+���}߸7��׫7M��|��,^:�ƍ�����W'������o�hz�v�7o~Ǫ���7���}窷�;wQ�-O�޲�ꖍ��e{u�jR]��;��]^����~���:9��m��-����OCg�wn����&�;W�^��/��ՇW�����|~�f;�s�I}�;7�k��q�g7���5�h���;6]��a�h��kܱQ��[6�l^�ώ�f�o�|��@��
���?����������^<����%��+Vo�|�����+�o|y��x���\��9��/Y�v��\���Ez�꼺�֯g_.Yu�%�>����������|����7���g����%��䕣�_9�����^��u�~�B�\�nj�Bu�P�Å��O�w?�����2�b�     