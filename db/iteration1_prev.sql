PGDMP                         {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    29553    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    29559    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    29561    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    29567    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    29569 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    29553    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    29561    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202          �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 115, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    29572    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    29574    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   �   x�u�K� �5��1؆�#���?G�gS��K�fF�,?P`⒨%�Mv�^���jn$$>3/�Cu��ivg�>�?WO{Q��0U��eY��ȹ��,}���pD��5�x�?jc�����ɰv}s����>�      �      x���MsG� г�+��L�,����3�=L�l�l(�1+�
��Y���}	�!�Q��.�p��!��U�Y}��O�����tq�߿~�����勣돳�����\ͮ/?]�ήWύ>����oO���g���f���ko�>������������?o{��ϗ�.?��_����>\^\����������>���ş��G3���������˧�9��_^<|�lv}su��_VGp�x�������]���������O}���\�����������u�x��ۼh��E�6/}�E�W����j~y���.��8���~v�����,?�/��~���C~��˻3z�:iǫ�r��ՏW�����������m?���:��a�ɇ��6ڡi�dWh��vcЖ��������%$h�����d��J��ґj6�E�>�l����c��N�z�5�E�6�N6�d�G��G�s�6�HvN�b6�9e��dG�=$�l��&;�쒗B�M�$�d�F�&�l��&�l��&�����9e��d甭�GvNٲ�s�7ʮ�F;:m�j��)[:BvѲkcH��L{���yh��k��n'��Ⳃ���Mw���޷�n��\%9�����zϮ�H��){����'*$d#{��ΐl'�ݽ����vRڢ6�h��6�h��6�h��a����yF٫˱���V���u<Mﺧ�0��d��}�T�5�\'t-`�](l;"��)ۮ1�s�V�&;�l��9e7�.�Z?������)ۆ1������윲wH�k�eE�`ڂ6�d�Mvي#d�Y�YH�sʖ���S��6�9e�F�&�l���V!;�l1��ew�X�8�vRڪ#h��6ڑhE����a��:1��R�N�����M�����H&\s]f>��/�%�>P�=��"]��!�p�Ӯ}!���.�v��h�����h9v��Җ���������%$h'���md�Ѿ��v��)�%G�`w��a��kKG�&�l�w���GvN�fi��)ۭ��&�l��Ȗg�Mv��4d�M6�d�Mvd��!�ϲ�TW�юN[ُ윲MB��S�D�윲e#d�m�d7��w�N([�.����6�h���A$�Ii˵�Fm����![��[���B�2�^��-_]�mQ��Q�l�S�>Њ��\��\م˞v��vq�����#�h7�'[��;����5�l��-l�]4m�H��.`�l�m�$�l�A#�l��&�l��&�l#H��ޟl�l�s�6IvN�b6�9e��d�-f�M���d�M6�d�M6�d��$�lU?�����ly6�9e��d�m�윲e#d�-!;�lU?����y��i�S]�l���]4m��d+���هɳ5��e��SS��d$t���wI���"s��TH�~F�MU��V�IZ��i燝-b�2Fv
�Ӯ�!�f�p��,��<�</�l1m�{@[:B6�d��ٲ���V�&;�l1�윲�l�sʶ��>����)[Տ윲� ��)[�&;�l���&�l��&�l��&�l��&�ϲճ��l�F�&�l���6IvN��l��&��8�7��lm���6�$;�lCH��&��8�e#d甭8B6�d�G�<�윲�g�.vc+���Q�#d�K�َf������p�uB��l��&��N��][B*��]�mm�{+{��gz�����D;)m��F[}��زU��&�l���n����`O�&�\�b6�9e+���g��j��)[�&;��Ʃ#H����Ɏ&[m�l��&�l�Ɏ�g7�AZ�v,�M�!Ɏ&[:B6�d�G��6�d�Mv6���JvN��l�sʶ��l��&�٪~d�M6�d�Mv�<�qITeW��i��!;�lS5d甭�Gv4ن�d'�]��6�h�vc�[��![�-h'��N�dg�=��R���m�i�M6�%��:�#lm!���l��V�#�g�e#dG�m�l��&�l�Ɏ�g�MvN٪~d�M6�e�.��A��]}y�f��#�U3��1q�еy�3�V!;���1{H6�	d��d�M6�qdA��S��M6�d�Gv�ld#�X��2�^��u��&��8�����������)���~d���G6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M�n!m�e�p�V��M��Mv`�2m�s�n��&;�ly6�9e�	Iv4��l��&��8�U���ly6�9e����S�������MvN�m���V�#�l��&�l��&�l��&;���v����-��Qr͵�Mv�-�"�ϲ�@��S�l����7r�"����ƏU3���-���1q�е\����6~$;��r��V�&���w�P3!��re��d��.fodԟk#c��.���M6�d�G�.�d0�D;<ms5d�-!;�l+GȎ&�����]BD�]:nˢ��l		�d�M6�d�M6�d�M6�d�M6�dg���Mv�e7n��uC;<mA�윲��&;�lCH���V!�l��&�l��&�l�����&�l��&�l��&��l��&�lk��&�m�{G�m+��)[�Mv4��~d��8foDb��Ae��d��.�n�����%����)[q�l��&;�l��d甭�GvNٲ���=B����]�B�wѸմ�&�l�C�6Ŏvoh[�Gv���s��!��Mvtٍ}+��.��t�l��&;�l��d�Y���dG�-!�l��&�l��&�l��&�nH�ɎU��aW-a�����^%�Y]7/�h�K[�MvN�6ՠ����M6�d�M6�dGH��b%;�l35d�]�L�d˳�&�l��&�l��&������d��d甭�Mv�e�g��S�<�윲�l�sʖgǔ�:��awo
ٸ�����xڽ	��]!U��N�[M�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��N-�m��,ێ1��ɖ��M6�dǑ�Î1m��.���M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�Mv��m#;�����m����;��ewo1&�F;)mQ���3��Lvc�խ�1z"�?T�B��5j+j���2m��&��l�ݑ�윲M��M�$�d�Mvٲ��&��8�e#d�M6�d�M6�d�M6�d?em��ӄl�˕-f�M6�d�M6�d�M6�d�M6�}���GvN�b6�9e?��{�&;�l1�l��&;�l{j��l�!;�l1�윲�l�s����)�+��)[�&;�l1�l��&;�l��Eˎ�]m����؃��8��v����BM֠�v{�S]!�N��ZV�{#�]BB6�9e�j��S�d�-!;�l#H�s������;EUn�vxچ�d甭�Gv4ن�d甽C�]�h���e�dG�-!�l��&�l��&�l��&�$$�d�1Fv?eoT�?��1�hG�m���h�!�&�l��&�ly6�d�{@6���
i�6��i�d�m~�윲!�&�l��Ȗg��S��MvN�b6�9e���]���!m���>L��}��d��m�K�=}��d�R��#�&[�&�l��&�l��&{߲m�%;�l���"{#�(Rv��]}y�f��#�U3��1q�е,���e�d�M6�qd��$�ϲ��dG�-!�l��&�l���d�-f�M6�d�M6�d�M6�d�M6�d��Q�#�젲�l�sʶW��ȶW�댮El��#۪�s�.+f��"[`���"�a/��k�El�#ɶ�윲e�d�m�&���9N�{�%�c��M̎�Zm���ըm���N�h�����r��V���X/ADK�����ޡ�q$�E�V�&�l���l�G��)[�&;�l1�윲�l��&��8�-!�l��.A�{�M6�d�M6�d�M6�d�M6�}���Gv�e��dWA��m��ɖh�M6�dǑm�6�}�m+��d�F�&�l��&��y�FF�>`35d���6Bv4ٲ�s�6�Nv�e��d��8��k�юN[�&;�l���&��g�ݽ[�5Qh'�}����E!'\s]����ԀvJؒ�]e7�0�$�=ڡ#$�1m��e��&�0��1��vx���s�6SC6�d�G�u�h'�-h�M6�d�M6���m�:�9e+h��S��M6�d�M6�dGȳ��#;��qa�1�^î�<�U3����꘸N�����^����d?�M6�d� O  M6��l� �NJ�R?��ɖ��M6�d�M6�d�M6�d�M6�}���G6�d��M�l�윲-c%�l��~v�B��v��#��!�k����l�;��v��>:ln;��l�s�#d���~d�-!�l�ٹe�F��)[�&;�lK���)���h�m�%�l��&�l��&�l��&�l��,�L�}���MvN�e��aW-a�����^%��\˲El��&�l��&�l��a%�l5?��,[6B6�d�M6�d�M6�d�M�S�F6� ���Mvt���d�]�J?����&�$�ae7u�SA�δ�t���{�Fvs��k���vʒ�`��=��Re���m�['�샧#d�m��l�ͭ�M�	H�s����)[�M6�d�G��IvUK��.��5�d�M6�qd?NG6�g��d���z�He��Ӗ��M6�d�M6�ms5d�M6�%Ȗ���S��ߓ�^�>d@v%h�9i'���:�]��d+���W�b6�9e��d�Y�-�dG�-!�l��&�l�#��v���Sv�m,A;<me?��ɖh�M6�d�M6�do����)a�d�,��`��=���Tۅ�6	I6�OG�&[w1�ɖ��M6�d�M6��d�IvN�j#dG�mz�l��&�l��&�l����[뼎v��m�s�V�#�ϲMB��S��MvN�b6��dA�M6�d*[CH��Ҷ��l�G�&�l��&��do^��d��m���h�U��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l�{!{ڵ'�u�ln�~1����N/�
m�s����)[u�윲�l��&��8�e#dG�m�윲e#d�Y�{�M�l�l��&�l�Ɏ�gA��S�U�d�m���d˳�&�l���n����`��!��ZB�����~d��8Bvd+h��S�IH�s���&�l�K���G6�d�M6�d�M6�d�M6�d�M6�d�M6�d�}(�V���S��M6�d�]�쩖�l'�mW�d�G�&�l�C�>L62 ��`�.��K[IJb=���S��;%l96�d�M6�d�A��G��,��FȎ&[6B6�d�M6�dGȳ��#;�l1�윲�l�s�V�&;�l#H��&��Bek�vR����l���� �0�F���i����x*�?4�"��d�%dob�l���6OC6�d�]�l%?��&�l��&�l����D�d�[��Y���vtڂ6��dK���)[�&�ϲ7���h�K[:B6�d�]��i�n�VE�]���jܘ���H�NJ[B����(�_��}�ޭ@�l��:�q�k��v-�&���u5?�s�V�#;�l1�l��&��F�d�M6�qd?�,�d�*ۚ�s����)�q'�[������s�V�&;�le?�Ȏ��l��.�t�v�5�)�l������m��N��:�E����M�)H�ɎS�&�l��&�l��&�l��&�l��&�l���6SCv_dox5SCvPٲ��&��beO�6����]��h��Fm���F������m9�&[1�ˆ�5f�Mv��_���`���6�d�Mvي~d�-f�M��#d�M6�d�Mv�<��윲�!;�l1�윲��d�mS�9e˳��)[�MvѲ�w�Ї��eA�6�`�d$�\�Z���~���lm�l��.��G6�& �&[6Bvd�PC6�d�Gv�ld#���gO�F�\ڂ6�d�M6�d�M6�d�M6�d��#�Ӯ!�tD�����a%�nh'�-j�݆�ꚶ��A_aK���>T���5�0��l��-{���l��\u���`��,��e��E6���v�� �F��$�hK[B�6�h�]mK�ʣ�8MM6��e��v�td��v���V�#;�lcH�s����)��윲e#d-;�nH��Q��w{^���� k{߰3~$��}�֠��e�vJ�;ܘA͏��m�M6����&�0K�j�юN[�&;�l��dG�mO�d�M6�d�!�&��h��l��&��8�K^�J6�d��s�Ӯm!t/��ng;�RV���;�ä$h��w�Z�����n	I5B�"+$���!�Żn���x��AI��= ;i�ֈ	m��Fm��L[����5bz>���e�ڢv!��#d�F�u�O%{k�An�J�����[��k��#h'�-!A;)m		�IiKH�NJ[�Fm�юD[H��l��`��&z`�{���z�����������:h�m�m�Em�����OۦH��ږ�����c�E�M��](m�ٽ�-f�M6�d�M6����Vz{�G6���DN������l~���'�o/��~>�[�K�����������?�������������N//Ζs���ɟ����h���^���^���j6���/�<�כO��O�������ɇ%����t<�����ۇ���`t�0��i�z��`.f�����z����������O��q�>9W��^����}��ꍃ��������Z<���뛓�����~<_��W����|0~�����|���]�z<���ۮ��k����.��]���˷qQo7}����������Z}���2����dpZ��~�+7�����[\��u��捞����t�ۍKwV�5�G_^���5嚽�_�U�'�ٓ���'��_�嵪&�'���]�U\|s�p�0t��}���0�|��q�߶���W�g����tq�fO|��I=�ڥ[\���r�GW���5<����З��?lU�e��חlX}�-R�WÓ�����/��������Ӈ����{������/]��|��cV�=�{��� p6�ʷ�xq�K/
^,�*x|ʚ���3��l}�͗������|\��ݟ���>�>���������|v:{����拴��k���.�t~��;G��y��:Q�<Q'�݉:Q�N�ȉjq�~�����W����,y@>     