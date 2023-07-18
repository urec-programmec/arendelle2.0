PGDMP     ,    5                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    30821    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    30827    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    30829    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    30835    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    30837 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    30821    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    30829    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   _       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 149, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    30840    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    30842    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   �  x�u�ɭ�0 гӋ�������_�pQ0���ͤ��� \�7����u
����B7��Mg�@��%�=Z�@���^�E��.��n�B���Ȍ�S
+��_/<��+��#��{Y0r���w]5��O5&�)R ,�j9W�3cI�#��cLE�����M�ʾ![���R��.���C0c#_�CJ��͇�#%�Q�&�W�^�8�^!���5��"#'A5����5Vj��ϭF�BSFɏD=�UϪ������c�}2�;#.� ��D��ʩ��s�Zi5gέ�P
KI����*߁��H�}� ���ڵ���1�d6�Z��E����TO�P�-��to:+��F,"m�$	�0�ܱ-V(��T�c}3��St�X�Tj�k+�8�r+,Ԡ�d;ݷ�^��I�,�JW]��ߧ��N���{�?Q]��qk�N�2�h��[��l��oy�^� wA)�      �      x���MSY� �uկp0����L}�g7��YtLO�,�X`.zlp 
���@�$<�R"߻y6%#K�$����}���_��{u������4���W��W{ןf'��<s5���|u2�^>7y��_�o�Y��~���ܜ�s�ڛ�ϳ�_��|����������?�{���-�]|��.fW�?���xyq}s��{7ws�q�}��iq�7�O��t��������������gNg�7W���ey ��ώ?\/������_o��2�������a\�\~^������÷6�g�κ͋Fm^4n��7_�xտ����/������f��>̮�?���O��S�����o7]>�K�/������/����W�_�v���o�srsw���2��Su4z#�?5�|x�t�M7�t�;�����w���n�馛n��{��{�]M�޶���k������K��r��"v����i{��\��Z�v���������o�G6�d�M�6n�&�x����d�-f�M��M�d��&�l��.Fv�ld��]�Mv���`W���${�v���(�.ϵ\D� �Fm��Fm��Α��ڃ��OԮ�&�����=��]���%t��t��=M�n�����[�[jB7�[������pým܍tC�;�n�	�t�M7ݛokO���(������3s�����ޖ����:�&��ֲ�^��b+I���Cv���n��~	ݺ �=0���n����qkr^wj��`��qV���:f��L2�,G%�E����z˙�-\��鶀Mvn�l��G%�l��d?�����hO[�&;�lk��.M�F	dǔ�!Ѯw�e+�h�d�M6�C��8B��e�$;�l��1e+h�S�V6`�[�&���)ߦ�n���-�����8�E������؃n������n�馛n��ުn��&�l�����$�wi���6ŕ��em�;Ғ���]Z;��J���d��]�h;�p�n��n�馻<�������Z7�d��]�N�`��5�\sm&�!I��&��N���mHv���#;�l�m�M6�d�#[�Mvi�s�!�l��&�l�� �H�C���f]��v鴕�Ȏ)� $�1eK�Ɏ)[���ۥ)�َd��m�x���馛n���N�Sj�w��n��V�ƻޅ��Ɏ��{�q�[�l���B����:K�V�����M{G��vֶmOvPٝ�~酒��3�-p�����I����vaA�l���@6�6H#�l��&�l��&�lw�d��;���dǔmOK�c��Ɏ)[�&;�l1���d���M6�d�M6�d�M�1H��V�#�l1��aʖg�S��MvL�� Ɏ)[6�%٩���=�5,�����GvLق6�hK��m		�Ai+�����ydg-[wH��ށ��ᖔ�Mvϥ�ֽO����L����Qﲳ��cd���D��vֶ7o��GOj5v����M7�t]w�& ���m��&��?�����MvL�b6�1e��dǔm-�C�-f�S���1e��$;�l1���d���M6�dg*;5Qm��&�l��&�l���N��6�C�m��d�Mv9�B�S�<�l��&�ٍ��k6�6ڙ���m��D��6�hL[B�vP��{�����	�tӝǆ�pwĝj'S�-t��=�н�]dΓ�馻��`��뀮� �&�l�7�}TV�H}��nG[�1��~4���Aw�P�.��Mwi�;ж2�q��&[�l��&{��e#��C���W��MvL�6$!{Ȳ��$;�l1�옲�C5� �.^��Mvi��F�&�l��&�������~h�E;���-$٥ɖ��M6�d�#[A�l��&;�lȎ)[�MvL٦��M6�d���Te?��Fm��F�w��EUVְ����J:|��v��cZ��w2r�w޸�M���B	�h��v鴍������Ɏ*�hӎ��`�먭1��hwk;F7��-��;�I����M6�
�d@�l���d�$�l��&�l�Kȳ�&;�lU?��&��<e���^����*�z�J�^�]�!;�l��c�~��d�@��M6�d�]�lw�dǔ-f�M6�d�#�]6��;Vl{���ml�l��&���V�t��i�dǔ��T?��V�#�l��&�l��&�l��&�l��֍	�贵�D;(m��&�l��&�l��&;�ސIں硝	�n�����t����n���^^��g����m˹���I�&�
�ɶ*��!Ȗg�M6�d�#�C�O6Bv���dǔ�6BvL�6CC;(mA�옲%�d�&[ُl��&�l��&�l��&�l��&�l���6%��!�6IvLٲ�˗��1�]�W����Jî���Ұ���u@�r��N��Q���m��@JFM;�lm�5�@{��;,�9D�i��h��.j7���;�)�lgl[�Fm��Εv�Id��v~#9A�V��� �Q�&��eKH��ڶ9$dF��H�C�>ڴMdOw�z����v�Nz�)R:�ѝ�n�	�x��vL�d�M6�d�M6�d�M6�d���l�~����*�Z�1���-h�S�vȎ)�-$٥�V!�l��&�l��&�l�����&�l��&�l��&�$�d�M6����M�	�h���+Ɏ)[�Mvi���Ȏ)�i�nDb�م��Ɏ)�]���K[q�i�dǔݡ8������mw�S�c;��Ɏ){��d�����Gt�%;ٓN����;�G����L����^^��K���[=�om��m��lG�m�ك�-!;����!�d�.;��B�iKG�&�l�ˑmV+�C�mV+٥ɖ��M6�d�M6�d�M6�d���ڈ)Qdǔ��GvL��#SA�|iK�Ɏ)۲�����&�l��&��m�XɎ)�X�1e�!�4��l��&�l��&�l��V�#�l1��!�n��d���k�0�!S����i$��k2�x��~LlG�]t6�M��Mw\�n�sֽ��5��אM�w����m" \+=��Fm��F�w�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�;��n>���Ȏ)�>d�&[6B6�d�]����4eB;gڂ6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6ٹNж\�옲�����.��&z`�[=������xn��-tӝ�n-"鎫[�1�D�C����6�h��g����dǔm����d��$�l��.G�l�l��&�ٲ��&�l��&�l��&�l��YI6e:$��|e��d�M6�d�M6�d�M6�d�M��e���S��MvL�Ocvc�#�d*[�&�l��.G�55dY��FȎ)[�&;�l1�옲�l�cʶc%�1e��dǔ-f�M6�d�#[6B��dk��u�۵�k�^���Mv;ٺB������t�ԭ+$���sJ�6ںB���f�M�C;(m		���v�vPڢ6ڃ���.��_���v�vPڪ��^���k*��G�O[���֬u�6ڥӶ���dKG�&�l��&�l��&�l���fm�0$�1e�5FvLٍ��}̞��v�Ր]�l��d�M6�d�M�<�l�m�M6�;/hWfh�]<mA�옲���S�[H��&��rd'��jײuA �칔=>�q��H�S���u9�c[�$>�C�	�h���:E��	�N)I?��覻�n��L��i�H�m�趩6�h��h���6�h��6�h����h�����ڍ4#K��Jv��$Vi���UZ���.�D[��ly6�d�Mv9��C�=d��l�K�-!�l��&�l���d�-f�M6�d�M6�d�M6�d�M6�d��ר�Mv���l�cʶX��ȶV�눮El��#۬�c���&�l�ˑm$�1ek	vΰK�Y#n��^cz֐�������I�����jBw/�Sͨ���%%Ò=��� A7�Quwh�TBwֺM%!�l��.G��5h�-h�M��M� d��d�M6���6g�l��&;���!�l��&�l��&�l��&�l��,[Տ�!˞�dW��6ڥ���.M�D�l��&��&h�=d٦��]�l��d�M6�d�]B��ȨWl����e���]�l��1e]'{Ȳ�l�c�N�A�5�h�N[�&�l��~i�%v����Н����pw   ��w���p��G+���38I��<a]�e�8H���N�n���D�.��aH�s�=��n���m��d��P�;ڹ�޼1�|��i[�N6�d�= �f�����M6�d�M6�d�J�E�dǔ��MvL�b6�d�M6�d�]B�m����n�f���'�Ū4��	�5�Ŗ��u@׭�m6Lv����.M��G��&�l��&��<�BH���6Տ��dKG�&�l��&�l��&�l��&��!�V�#�l�Ɏ&[6BvL�I�ծc��`��ݭ�X7�pÝ1�d���n��ŭ�/�9��	��k����l�7�}�ic�~h��F��ފ#h��-m��lgm{�ΐ6�C;k��F�M�t��Ȗ��S��MvL�I��l�������d[�K6�d�M6�d�M6�d�M6�dY����,[=�옲�!�4��l��&�l��&�l��6��l�U���l��d�M6�d�M6�d�M6�۬�4� �>$���e�g�S��~dǔ���:C��	�>���Mw?��H����'�o�m��L���>��뀮%�`g
�[�o�5י���;�iw(��3Ď6�;��O��6�mi�~�ygH���Κ��Qd��AFB6�b6�d˳�&�l�c˞�dW�D�|i��J6�d�]���H#}�$��0�[���Ѐvƴ�#d�M6�d�Mv	�����&��d�FȎ)[�����6�h�]m���l��Ȗ��= ڢ��h/���Th�N�J_Q;k����&�l��&;;���l��Ȏ);�;��#h�B;ՌI������h��6�h��6����p�lEm��.���v[�G���쇶nch�����h���&�ӓ�R=��Y��tIwց��(��&�7��נ��F��"h�/HۢH���6���hgG; m��&�l��&���dwX�[kǎvƴm�c�V�#{Ȳ�C�S��MvL�b6٥�vI6�d���l�k�mSY�4m����M6�1e�h���v���A@�|��k�.����h�M6�d�M6�d�M6�:נ�6�h�6�d�M6�d�M6�d�M6�d��}�i�H���Ι�\J�fz��M7�!t��tg���v���[����lx��F[�1��Fm�%$h�L��$�AiKH�4m;��]m		�h��v���&{0��D�=d�ɐM6��˶Y+٥ɖg�M6�d�#�]62M�6VCv.�m���h����i+���5m%m��6I� d��dg-{��G��vδU��@�l�c���m��Fm��Fm��Fm��&���6��옲�l��&��le�������x�A�]����[c�n�kFhgO���w?I	�t�nM#�n�c�&�쐲+�vH���dk�6�h�O;5�R���[H{��Aiۉ��hKH�Fm�s�M6ك�����&;W�b6�1e��ߖ��Mv�[�i�Y�vI6�d�]�l�ƣ��Vi��L6�`�,��v;�ŭ�D���nT��F;mQm��F;_�*l�M��d���O�&6C�-h�Mv4ٖ��=d�ӴlA��i�d�&[�MvL�b6�C��0|_�
�h�K[:B6�d����M�Eꁀvδ�5eJ���xn�ŝ��pÝn�"�
l�C��U��`� n�	�\g�Ze��lS�d���1���jt�B����Λ7�h���I��F�h�<�6�m���js����������ޅn�[��[�vJڑ�� �-oG;(�~F��&�u�m�m���.�6�d��]֒���ڵ�6�`��ݰ5!Cm�le��M��{�A�@$�Y�.��M6�d�M6�d�M6�d�M6�d�M6�do"��H�z6�E�nx5RCv��e#d�M6���>ڴmd���cd�![�H���"q�	xh�=���m��&;�rv������3m���Y��t��-v�]�n�J���m��F��i[v�v ڕ�t��-p���t�A�N��c/��T#����K���Gn��_B�|�y�d��6�`�6ػX#�5�Y���ֈLa��-�t����5h�JvL�2m���6y�6�S3P��T/�.e[`�v��M6ك��.i������v��m��&�l��&�l��&�l��&{@��6�i�V�s�]����F����9Rg��p�� w�Ψ��D�[�n黧��=�3�;o�R�3��g#4����.f7���v�vi@{@�e��e{O�ƥ�ʵ]����F; m��Ў@��+�5�Twեe�4�{���馻�n{H�MwBw�n�C��鎫�m%�y�V�F��6�d�-{Õ	k`�V��ǧp�v=y�j�zq�Xc-`�M6�d���l�s����vTۥ�&�e{YB��>+��հ-j�����o�#��鎫�@�K�m��x��6�h�]���%�&['��&��!��@�:��&��L�I���\�ng���v��F����p�n��N�&tӝe���N;c���-A��m<m��Fm��\��������.޶���h���v �U���t�՝sZ7ܭqo{��Ɠ/�[���&p�M7݃֝SZ7�B7�t�M7��t���<6�tEYQ�S�b*�3��m?�W��Z������\�n�馻,���$����ᎀ���aq��p��-r�wO�'�ƻ��D�T�3�m��x��vL�ߐ=�b6�d�M6�d�]B��l·�|d�ݾ��������̯��������xkcq��zn?�����{��n��v��z�ﳓˋ���\�w���p�z2~]O&�����?/^wv5����X�����Wy���:?]��8�����믟�����a��0n<�&w��O�˗,�b6;����_�b���������I�?NW'���۫���T������?_}X�j�?�|}s|s~�����?������~}z6���ǧ�����KXOg�z�%<��|󫸥+8zr�e������������յ۟����t���k����oNG'������hz�n��o~Ѫ�j����.���]���W�k\��<�Z5^}���7Z]�z�|�虫����ͤ:;�O���;;;���-�Vux��o���E[�Ƿw'#h��nT/?������߸������㛓��dz|2�v�-_���>|���/�����ɵ����O���}�������a��������>s��YΛ��������/��9�֜��ؓ�����{��V���.�7߱���g���GN��|���G���j���­��'-uΟ��5g���|��_�9�Φ����)���&��WW~�i~:����<�������k�f�k޹4�|�h�7�7}�d�7~�%�=I����=GϞݒN�h�'icHϞ�N�8Ǔ�1�g���'i�$mi�����񏿾��������     