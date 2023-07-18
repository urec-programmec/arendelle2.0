PGDMP     ;    &                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    30525    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    30531    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    30533    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    30539    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    30541 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    30525    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    30533    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 136, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    30544    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    30546    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   N  x�u�In� �ur� ������Q���4��̓m>���A@|A��~@jC����'Bs��E9C�`��׳Z@�j_��W{Q�¥.}*�b��ȍ�-���]l�o��pך�h~w��X�#
Է����\�r���) ^�\��5g,��*��gzQ�`}U{S�.�w�~FħR�B��=YR�Y��h.OҒg�:Ø�WK�Q�C�\;���fJ�}]JZ�I����*ݱR�u�o5�ҋH\�XW�Uۃ��?��j[���3|2�B`L�ȯ2E�0�)�Y0���,�����/���x�?�`0Um�ʖ��#�3X>��y�߆y��      �      x���Ms�Xv ����p)��*�[ ?Dg�d��T&UYtk!K��[rI�L������HK�@&⽋��4ɡ������q�?����G�o�?_]��o��G���x������|q���#7����7����c�������w�����v~����w7���x�y��bq�~�ȏœ�o{�..W������W����?��������Gw���~���������?}�H\��/�����X�.���>r1���������v���ه�Շz�?g������|�������cܞ_^������ӗV?��e�'��<i��I�o>i�����,�o������ן>�o��ܛ�ջ������wm���?>\���E;^_����~�����_ϖ��V/�y)���t��N��<��c�M7�tӝ��Z܅̄���n�馛n��{��{�]L�&�K�=&El��t�.`O��:��Ys��\�u?����#�l��&{cG���^v?�l����&[�&{��d�M6�dg#�Y62��]�Mv��A�6����'�`Ma�>%�������d�M6�d�M6�d���Mv�3�%�`7�]��ؑ��~t�}��d%t�}��Z�%�xG����x�׿s�9�=�6����nw 	�t���bV얙���8vW�q���Lq�t�]�{�-馻�����]���l��%�bx�g]'�d��X���W{�"�Wډ�n��M7݇Э0��-3��n�馛n�u����u˹��'e�k�cF��1�`'93�.b�p�u@�{�D������l�S�d��;*�d�F�&��Ӥ��F;{ڂ6�1e�?Fvn��J ;���v����h�-h�M6�dA���C�m�옲e#dǔ��MvL��ـ�2l͚�;�	�t��t�A���PƱ��Gx��ܵ��٣�n��NZ�̄kǔ�H�wm��Dp���̚�.�;�B6�!W��xH+�\w��
W��}�k�H;n�N�vn��F;(m�Ɠ�Pv�s�t�}�b7�t�Mw~�e&t��-vӝ�n��);�� �;i�o���Z��d�M6٭d��v ��˶��옲��M6�d���ly6ٹ�Ny��l��&�l���l35dYvm;�b�6ڹ�V�#;�l��dǔ-�&;�lm���l��~�!������t��-v�M7�t移vL���!t˻�[��~xk�vH��m���%l7M�6�`���2��\'�ڮv��}�k�H��Nڶ#��*�Uݯ~�di�D|�`�����?A��A�l�c�$�l��M6�d�M6�d�MvJ�� ��l�l�c�v�%�1e��dǔ-f�S��Mvn�U��&�l��&�l��&�$�d���M��M�0e˳Ɏ)[�&;�ls�dǔ-!;�l��1e�������χ��J[��vP����V�C;(��\[oH���7$�tw��n���I�m�c�Mvn��������(���a��bv��l�����[D��#�;��4Fv�-"������C��'-����ɔ�$2n��G ��|�m��v&�d��dA��MvL��"�=d�b6�1e���S�$�1e��d�&[m�l��&;Q�u+��F; m��&�l��&���d+h�=d���M6�d�#�$$�1e˳�&�l��]�;���Ν�!$�1eB�M6�d\��ch����-�n&;�Y�F�s���6ڝӮ�:�����m="S^�M7�;��-�\t��G6�d�����][D�4�vʴ�ѣ��V��T�����t��u�Mw3�-hێ wڸ3��d��
H6�d�=�Ͳ�i��d�+[�&;���l�&�Qd�-f�M��S5F�dg/[�&;7�j#d�M6�d�Mvyv���~h�E�n�!$ٹɖ��M6�d�#[A�l��&;�l�Ȏ)[�MvLٖ��M6�d� [Տl��&�l���!Ϯ]U�U�v����;e�:額v'i��v�F�l�]אm��F�=��/]yN�v'�M���h;m�쨲Ow���Bmݘ�nF�]�1��[^�w?��D;&mA�l� ��l�ٹ�6I6�d�M6�d�g�MvL٪~d�M6�i�N�B��]|}�z��3�E=��g�:�k�4dG��2BvL��c��l����&�l��mIvL�b6�d�Mv>��e#��c��@v��ͭ�M6�d�#��B)A;wڂ6�1e��ԏl����&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��n���M�z�݌v��y������C���n�{}O+�Qn}�qǶ��p���Mv�6�d�I6��l��&��\e�\�#�ly6�d���M����N[�&;�l�6ٹ�V�#�l��&�l��&�l��&�l��&��h�-�"{Ȳ�A�S�l���eWr�$g�����kX��.��.�a�?�]�E��l�G�c�N+!�l�l��*�Ŗ��d�+[�&;��f1��Q��L�F;]ڂ6�d�Mv>�ۜ���rB6ٍd��A�uIm�;�-!a;i�֎�=��d��}�k{Ȟ��z����v�z�,����v�%&xG��6�1i�M6�d�M6�d�M6�d�M�βS.j�Mv/{lJ���Ξ��MvLَ�!;�lCH�s��8B6�d�M6�d�M6�j#d�-f�M6�d�M6�d�M�$�d�M6����M��h���+Ɏ)[�Mvn���Ȏ)�y̮Db�ٙ��Ɏ)�Y�]{����)��Ɏ);��^c`7���6z�~l�b�;�1eO2;sD>Bv?����h'B{Ҫ��tg��t�N���&��;����h(s��n����5�C{@�ͷ����dF�|�옲[�#3���]v���m��-!�l���Gv�3�d�m]+�d�F�&�l��&�l��&�l���Ev�ڈ%Qdǔ��GvL��G��6��Җh�S�m5h�-h�M6�d�M6�9$�ֱ�S���c�6WCvn���d�M6�d�M6�d���G6�b6�C��r=[o��`�5Po}�I�-��)g��v���;�z�/�L(^wА���m&i�[�;��~��t���H�vsM��������}��M�" ��k��6�h��6�h�N�l��&�l��&�l��&�l��&�l��&�l��&�l��&�c�)�$�l�4�M�l�l��&;W�-��iʄvʴm��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l�S]�m��1eW?���Ν�&z`�[=�����]��tG�]�+�ᆻ7�ZD�W�fch�vʵ��F�a�v<+�d�o';k�Ɛd�M6��Ȗ��M6�d�#[6B6�d�M6�d�M6�d�M�>k#�M�fd���l1�l��&�l��&�l��&�l���lU?�c��Ɏ)�y̮�y$��Le��d�M6��ȶ���!�v��1e��dǔ-f�S��MvL�N�$;�l1�옲�l��&��|d�F��l���Nv��y���!��f�u�E;0�Sm!��[[H�D;�m���D{ش-�#�l��Y�6�$;�l1��!ˮ=*�pV���6�$;�le?�s�mIvL�-��D��iۂ@vn��#d�M6�d�M6�d�M6�d��$�lM����J��K̞��v�MՐ��lCH��&�l��&[�M6���Mv�[!��F;{ڂ6�1e�_';�lCH��&��|d��g�~ v3�K)-z{���>����h�rǶ
I|�y�n%��n���$;��Ϸ+�ᆻ7�d�W���&�)WI��/讫j�ս{�1#I������-'�$��&�l��&;k����S���C�]�1��]n`__âv�vQ{����Z�Mvٲl��&��|d��${Ȳ��d�&[6B6�d�M6�d˳�&[�&�l��&�l��&�l��&�l����W��Mv���l�cʶW��ȶW�눮El��#۪�c���&�l��m$�1ek	vʰ�5�1W�wڼ3�-p�}��]�[=�C�n��	�t�J�&����~E7�Qu�h�VBwҺ3�q�M6�dZ���h�-h�M��M� d��d�M6��ȶh�l��&;��!�l��&�l��&�l��&�l��,[Տ�!˞��.f�6ڹ����M�D�l��&;�h�=dٖ����l��d�M6�d��C�]ɨ7�L���V!;7ٲ�c�6�N��e��dǔ];�,K��Ν��MvL��Gt> ���D�M�!t�.��K����e&#��N2�n���� �  �z�a]|}�z֓g����W�ꨪkQW���
�X���<$٩Ȟ�h	7�I�ά�M6����c��Th��R>�vҴmb'�l���l�Y�J[�&�l��&�l���m;�1e+h�S��M6�d�M6�d�g[�Gv��+��$cv���t�X����b���u@׍'ם6Lv������M��#�d�M6�d��C�m#$�Ai[�Gvn��#d�M6�d�M6�d�M6�d�M��e���M6�dG�-!;��~����v3��z����9�������wf��6��N4�n7��r�u@�6�`���Owm��y:#��nD{������h��9m����^_��s���޽3����-l[E6���&[6BvL�b6�1e����l�� �&�^_��&�l��&�l��&�l��&�l35d���MvT�֍���ly6�d�M6�d�M6�d[�J6٪~dY�l�l��&�l��&�l��&��}�F*U����Mv�ճɎ)�Z?�c��'f�{�������ݩ�L�ަ[���{��V�;�t������Z�v���U�F\s�h[H���N�v��_?S�h��9m�|�Jۦ1�����$;�dǬ��M��M6��l��&��ز�u��R��v���b%�l���G��t��>�Ivٍ���g@;a����&�l��&;�D�\�d�Mv
�e#dǔ��vڎ�Bm��Ή6�dF���1e��dǔ-f�=dٶ����l��d�M6�d��C�m��1e��`����V�#;7��Ȳ�����L�Fm������2m���Wu���u��Owm���)��?m�Ә�A;7�u5��{O�o��!�N:hg���M6�d�M6�d�Ivl�����l��d�M6�d�M6�d���.�Rv��-h�S���C�m�옲�l�c����M�$�d�Mv����C{@�-dE{д�G�N�6�d�M6��]1���Z���l�5d�&[ݏl��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&{�Owm���)�^Ji�e��Mct�}�b7�qu��Kw\����w]{��yk�m���i�d�M6��-!;7٦%Ɏ)[6B��e;\���d�F�&�l��&���l#H�c��gI+�d;��l���d�M6ٹ�n��L�`��!;ٺD�= �V��=h��#h'M[I�l�MC�= �b6�d�Mv
����&�l��&�l��&�l��&�l��&�l��&�l���m+�1e��d�M6���>�%�-��Z�TQVnMJ��c;n�n�����n�馛n����l�C�ά6�!a�n�M6�d�M�d�<I6�N!�l��d�M6�d����W��M��cd�-f�M�z6ٹ�6�$�l��NT��h��W�ow�6�� kYW��Dl��n�:�]�h��Wڕb�hǡ-j��6�h�K[�� ��&�l��&�l���m�/�C�=��-h��;mA���dK�Ɏ)[�&{Ȳ+�7��
�h�K[:B6�d�����]{Dj}�vʴ��b�=������kC7�t��-3�;e��MJ����5��vO�l���v<}�k��v��Mv��H?G���d�V������}H��+SyN�w��d��E��m,I6�d����g��&[�1����&�ŭ�� A;����Sv?��`o�`���c[f"�����3�M6�IHv܄�5�}d�ZEr�5�\w�:��h��9m���~I���Ȩ�d��yFmӐl'm;�j6�d�M6�d�M6�d�M6�d�M6�d����7�M�>eW���!;Sٲ��&��de���%���Nch'B[�H�馛���%�n��uO�;�F�6�)�쐰�l���6����VJ�M��M7����+�;o��Fm�3���X�l�u�$�l1�l���dǖ��`����*���[��ՌM?�6ۂ�!t˶�N��nM`G���0l���L�Fr�uҮl��Sa��u�ZںF�����ΏB��i��D;(m�G�nB�n	ʤ�����%lk���&{0��%#���K�=C�ti�d�M6�d�M6�d�M6�d�M��d���7���bf%��lg����M��ek��v"�۵Ah�n�Cv��vD���]��4����,fW���v���Cm�6�me�0�ʭIʵ����F; m��Ў@��+�4�T�����Nv����F�!���"qp�!t�3���n��n���6��;mޙ�%h��9m�l�&{o���m\__¢���뢩�Շ�:,�Z�Z���;l���N6�\Gt���vT۹�&�����!�xzk�r�j�F[���ڭtׯ�+��;o�����;G�v���7�h��6��ά�M6ٚ6�M6�dAvʻ#�&�l�.�t��=���V����n}+�hwN��]dd�ݹl�QɎ)�]:RL�F;��H�Uc���A���6�6�h��6�h�N[�}H�u�'hwC������-l'b[BB�`d[�Mv �vD�= �)�#d��P����)z:^g{O�-��D`[��馛�H���K�[즛n��;�&�pÝƼ��{ɲ��}����n7��q/YV��]�Hȵ馛n����n$Y�[�������W��Mw\�b7�qu��yo�{KMtL�;q�v���7�hǤ�YJB6��t �l��&�l�s��,Ϯm��y�=��n�V��O��]\,�w�������/����֭��x�������_���������h������W��y�����l�z2~]N&��ߔӿ��wy3����X}�I��ͯ���o��X��:���}��/����������Ǹ�c4y�1��m�~���\��=���+v5�����|O�_�������<{��ۯ^?ۼ�8>Y�tr������Ŗ?�������������?].����qyq9������9�co7������x�p��pO�o���U���]�G�7����7(�ݺ���k�ܹ_>������˓}߹��������'��7��u��w��_ߺ�]��]�q�f���G��-��_9�ܲ�x�}X\���g��޿l������/��^���m�g�l�>�8;{�sӓ��͝{�y����o��ߜ_��ӳ�卛��Ε�r�ҝ[޵�ݸ����_T����+��斕�w8ټ�|�~m�җm�ۼ�����=~��/A��l��?����Ï�����^=���Ե��+6o�~��Ï��+�����O���j�����=��׬�?��[����b��߾9/.�����G�)����Ս�䗟�����/��f����<�1��啣�_9�����^����P߼P#�م�P�.�ąjp�����_�����&䕱     