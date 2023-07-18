PGDMP                         {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    29193    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    29199    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    29201    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    29207    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    29209 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    29193    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    29201    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 106, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    29212    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    29214    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �      x������ � �      �      x����sב ��W����J�9�%ho�\���l�l(���HI%�r�_�D����y��]��̇V�~�MW����o.ο����������z������xq���3���/����s���u���哃��g���j���k�.�̗�����������;���ӣ��w_�����ӫ=����b��O�g�W������p������W�5����n�8��������\\.���>s2���8��/�#��sT���������ߗO}9[\]^������V��������Y�s��E�&/5y��_�zտ�..�������?�/���8�O�߳Ň_����߷����O����������]�_����Vo�i4[>���[O�=d�َm{XG�b����kö�����$lg�-'a��'�=B�F�;�H�1�d�)��q$�d�'`���l�˄m�m��F;m3�h'�m"���Em�����G{�6�h��v �E��Bm�H�і���6�h��6�h��vA�H�����NJ[����%$h'�=��=`���m�A;)m	�IiG����X�?����юG{`҆m�˸�� m��v�?���j��v�[�7<�i�]���WGw�f7�Ym��l��6�l��6�l���ᯖ6/H{}ݶ^:~�(lQ���i��(A�f�;�FނvF�B6٥ʶ9���mE@;)m%m��Җ����v�����c;�ma����!C;m��NJ{�d{�f�l�l[�Fm�юD[��^�6�vR����V�F;)m		�h��v$�*$h'�-j����
	�Ii����6�hG�m�vRچ�h�M�}{��2]��.�B2쌰�l�K��Q�M6�9c�!$���7R��q����6�Y�}�����6��vV�r��ږ���ն�����5kB���6V����`�����l����l�-#ym�6�h�m�/�hTA����Fm�іk���E�נ�6�h��6���m��^Ӯmd]M�f;�m�?���6�vRڒm��Җ������H��Җ�������6�h���a$�Ii˵�Fm�#іk�]6��}#5!C�h�Ѣ6�d�M6�q���MvΘm���7���<�u�g��p��G[�~v���#p����vٶ�%�F���H�Ѷ�m��m��Fm��Fm�#�F[]m��F�����vzڢ6�Ii��h�����6�h��6�h��6�f#�F[�m�Em�{M[��vRڢ6�Ii��D;)m		�IiKH�NJ[����Em��Җk����������NJ[��vٴ�w�������~ɷ-ikCFv�
	�dK��F��1�3Ҟ��	7ܥ㖒���-��zIi��l���2��F�^Ж�����6�Ii��h'�-j�����h�����vRڊh'�m�vRڢ6��h����6�h��6�h��6�h��6�h�k��k�֐��6�hG�m6�����h��6ڑho��		�l��m�vR�Ƒh��6ڑhKH�NJ[�m��F;m�6�Ii˵�.�v]�ȢWlk��v���߁vF����F햴gm;G*��]:num��K{�����v�:G��ն�l��J�vt�
�h��6ڑh7KH&u��h�]0mQ���U���5m�6h'�-j���v휍a$��i��h���B�6�h��6�hwN{��HK��f�n7�q$��h�H�Fm�#�V�Fm���G��Z�NJ[��vR�V���6�h�A[�m��Fm�����*�l؎oۜ�Ii��A;)m�?���6�D;�p�#�f��0��g��-��3�v#b��Ҟ��� w�ն�F��i?8$��l�#3��Em��V�C�w�%$h��m>m��Fm���v�\m���V�Cm��.�v�������I��eW;��z��;!l6h���>�vRڻQ{�6�h��h��6ڑhF������6�h��v��d+����5���iv��F�H��#d$l��-l���va��F[�m��Fm��Fm��Fm��Fm��Fm��Fm��Fm��F��ki�/ܥ��m�Em�CӖm���v���6�Ii˵�NJ��H��іk��6�hG����v�i˵�NJ[����������m��Җl�����h��6�h��6�h��6��i7�����;����W_l��l��muڽ�m.���%$h'���f�9�>x�� ���]��~`�>x����#��h'�]X:�6ڪ�h���[l�h�]0mQ����E����k�d�6����Fm�#���V�lǷm����e$h'�m	��hG�����m�H#I���m��}�-'Am��Fm��Fm��Fm��F���յ��5�ڭ6=�؎o[�F;)mk��NJ�8�p��H�Fm��Fm��F[�m�Em��Fm��Fm��a$�h��v>�V������lg�힖h'�-�F;m�?���ލ�[�XB�vTڢ6�Ii7˵ko��D�vѶ�m���V"Am���G�T;�Ii���������i��f;��Y���t�]�n�m��F��Ͷ���������������H�h��v��ߊm�K�-#Am�юD�|$ڽ�mi+��hKH�Fm��Fm��Fm�ѶCm�C���UC���US٫�vV��KH&�6�ۖj����m6lg�-l��6�h��6ڝӶ��^�6e�vRڅM٠��\m��Fm��Fm��F*������vR���h����6�Ii˵�NJ[�F;)m�vP�닑^v�摵�l*�lʷݛ�]�=R���ն�Fm��Fm��Fm��Fm��Fm��Fm��Fm��Fm��F��жf�^Ӷ��p�%$h��6ڑhﱉL�&���-l��6�h��6�h��6�h��6�h��6�h��6�h��6�h��6�h��6�h��6�h��9m;���5�-ķ��m����b��i�oD&�f;�mq����3��ov�c��ٮm���g��H����p�ܪ�h���tm��F;m7lE;)m��h��m�6�h����m��F;m		�h��6�h��6�h��6�/ӭi�6����Fm��Fm��Fm��Fm���NJ[�F;)�ݨ��m�����Fm�#Ѷ��^�v�����NJ[�F;)mQ��������Em�����Fm�#і��]6�iB�6ۥ����*���nF{�a�fm��=�>�mE�?��%%h�����6�Ii[ �vR����6�D;)mQ�^Ӯ��T�.RlǷm�vRڪh��m�vR�{$ۃ�l��m�6��h�H�Fm��Fm��Fm��6�6�{�-"A;>��
�ר=a����٠��q$�h��6�h��9m�6ڽ�m3�Ii�o��b�����m���6ՎvR�Ƒh��6ڑh˵�NJ[�F;)mQ���UH�.�v���6�Ym?&۾ov������=$ᆻ|ܳ��*%xg�m8�6ڢ6ڽ��P�6�h��6�h���6���UH�N@{+�(��`#���z�Վ�^����N[��v
�2m��F�H��E��k�rm��і���6�h��6ڝӖk������6�h��6�h��6�h��6�h��[��*���vTڢ6�Ii�>�voh�>vJ�b6�=�m	�Ii���#�7MGve���`��h��m_$�Ii˴�NJ�tMP�닑^v�6Mh�ݛ��2-��f;����v5ni[2�s&�d��캼|��qI�W ¥�p�My��7�`�y�n��6�h����$h'�-j������vRڢ6�h��v$����6�h�A�Mv�Fm��Fm��Fm��Fm����5�I�j*l�޶��v8ڒm��F�H�-�F�״�jE;m		�h��6�h��9�f��VV�9`S6hǧ�B�v8����6юv�i��h'�];��f;�ma����H�Fm�;�ݾ��Rlg��Q�֭	��ǑS��.vGS6d��S�D{_�u�N�	e���	wP��v��H����&;f�َo[F�vRڦl�Fm�#Ѷ������m��Fm��Fۦv��~�����v8ڢ6�h��6�h��9mk������a�Q{��]�?�U��jGvU/{}�`'��x��]�юO[��p�"�Fm��F��i��v�m[��v8�2��Fm��Fm��Fm��Fm�?��F�|�%$h'�mU+�h��v�   5�d��Bl�B�v���	�`g�-d�M6�d��=k�7�v�.w�1$�h'�H�F���F[B�6���Ӗ�������vR������a$��h���6�h��6�h��6�h��6�h�m��^�V�F;)��֐7�����;����W_�x�e�b6�h��6�h��6ږ������hKH�Fm��Fm��Fm��~�
�V-ds�S��O[]���[��6ڢ6�h��D;0���zJ$l��������i"����`�쌰[g#d����G6�Me����T��tܦ��F���m�Mؠ��iv�����6ڢ6�h˵�Fm��Ӟ�Ѯ�m��mI+�h��v$ڻ�V
m:�<�/"��"a�d�2��Fm��F�s�&m�Fm�#і���������^q�;�]	��vR�Yhk�vJ�b6�
$h�����vRڢ6ڽ�m�/��hKH�Fm��F��i7˵m C;)���5XB�v|۪h��-�Fm��Fm���mM���)[�F;i�D�&���Y�Α�l�.��H��. #Am=��F[B�6�h��6�hǤms$�Ii������v��Fm��Fm��.n��@�v�K�-l�����ڽ�m:���Em�����G�0m��F�X�G��նe�h��D�6�h��6�hF{���E@;>ms6h�����6�h��6�h��6�h��6�h��6�h��6�h��6�h��6�h��;ڳ��#-k��tܶ������vh[��vRڢ6�Ii��������6�h�����p��G������^�v���і���6�h��6ڝ�6�D�״-jE;)m+��G[��6�h��v��dR'۔����:����-�Cm%�{A[a���MG������6�h�]m�?��Fm��Fm��Fm��Fm��Fm��F��i[ԊvRڢ6�h��v��gZG�}6h�-%Am�юJ���dH���^_���49,��0Z�[��Y�#�윲��h��6�h���f"��5mw!A;m		�h��6�h��9��'��F��(����F[]���#�Fm����m$�YmwD�]K�`��̣��,!�/v���v4�u;������C]:���vo��V,V�F;m36h��6���V�Cm��Fm��F�(S6h��������vx��6��hK��NJ[�F�״�����ll[F�6�h�]0�Y۶��H�]6���lܰ�����I��j[N�k���)%ц�禽_��-�dg����	�`[��v�S�Jh'���vRڢ6�h��v�#�Fm�#�~����.���#h'�-j���v��H�"a;�ms6h'����v8ڪhg��u$�h]"i�l�sf�d�]���b�F��i���6��n�L;�e㎖m����H�юT�Fm��Fm��Fm��Fm��Fm�M٠����k����%$h��6�Ӟ��)%��l���4��6�l�m?�l?�`rҒ�6dd�-�u�F�������~f�J�h��6ڑh��������v8ږ���6�h��6ڝ�6�D�״� A;)mQ�����h'�m��Ii˵�NJ[��vٴ�7�Ї��iGF�M6�d�f[$�`[�&�ܾ���p��m��.���6ڦ"�F[B�v?h�b�6�h��v��d+���kO�f�`��6�h��6�h��6�h��6�h��;ڳ��#���>�}t� w3�{�l}�B���[䆻�uR��3��h˸�L���ݾ�^G+ Em����~��)�d��H��
 �d?�l�6�e�n��l�e��D�E��v��H��.׶��m��f��� h�v�m����m�uF2��ms;�	l� �����$�Ii��h'�m�vR��˦�2{$u��I�q���ֲ)?���F�h��ܴ��F�h���׀6��h�q��?��ƍ6�hQ�C�n���f;�ma���ʹ���}6h��6�h��v���NJ[�Fm�юD��e�h��6�}�=k�C�Q�ٹ�v�$��Lw���l������p�­A*�iqTc��.�T��@�_Pv�I&���Z���l=��f�m��f��ض��/j[Ϧ��������-n��[J�vh[��d��#��侭h��Ym������H�vV�r��ږ���ն������m��f��X��KN[�&��f��m$#��g����e��c��crm������e�׻�m�MܰͶ��6��6۽�m�$�iqKJ؎gێ2�%�F[�.ֶ������Fm��F��i7˵k��=�vm���=�}�������jy��>^_���z��6V�n�߷g����?^������OO6��}~|~v������TMǯǣ׃������ϫם^������o?��*w��|������ѧ탟�r8�����������a�����%��9��O�v���o�l�W����6?������\�}�y����-�w��뷎��?����o�|�ӏ�WGW���>�x�<�o懃�����?>����Ov��|p��|{s���.�p�n]��������h������w7o��u�~Y|���d:<��}�+7������d��j��?��ݿt���KwR�5�\�͏m�y��������͸:=�<�o��t::|𷶺T�t��?���[�w7�wcg9n�����~lG�Oo�OǓ��啛?�L�o]��e{�+7ٹr7�����?p]_����w������2�y3::<�����]���3��z|�����������^ݼq�k����|����7��{N&���.�x���R��%�k�������֧�b��_�9�N'����SVܦ�G�V�}�_~^̏�"�p�X��__s�w�y��;G��9n���/�D��:Q�N�ȉjv��NT���w��?�������e     