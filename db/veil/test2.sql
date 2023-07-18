PGDMP     ;    !                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    27808    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    27814    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    27816    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    27822    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    27824 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    27808    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    27816    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   B       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 146, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    27828    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    27830    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   �   x�}ѻ�!�v	��9R��11-��Hb�b�!���7��7��)\Yf0�3�d+��ٜ��_�K��Ɲ�H& �7�LA�`�I�@�`��Ao�D�"��(XA�V�L�Q��f={3��f+�X!XJVPo��7+l��5��f�7+l�4XAg��۷�Z5��      �      x����s� ����p)��*Gf�Vr���V6U9x9 dY� �Ƶ��=�@�β�o�3bL�����_������\̦7W�}�.N���������N��-�rˬ�Oof�b���睍_�Xnm-7��L.G���틶Ͽ.&?�v.�Ń�c2^mΗ���\���W����'������7-z��������'�����Q1_̦�������b����o]o���ts5Y��c>��l�����<�u����˼�]�E�2/���V��e0�M���z�r�u1��,�g���z��^M.>,�ț|����mmZks\Z����|����0�?\�[�����B0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�Q�߼VQ��ІEa�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`��
�(�ppâ0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��"��R��}��-��B���p�L0�,&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&����J�1ܰ(L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�|�U�	&�`�	VI�`�	&�`�	&�`����rFp{��L_�Q�M#8�`y0�L�����[���O���	&�`�	&�`�	&�`�	&�`�	&�`�	&89�}%�nX&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	N^p`�����R�{�����iL0�L0�L0�G�;a��&X%��+X%���	#��<��؂]�[�4����'8U�)�$�`�	&�`�	&�`�	&�`�	&�`�	&XM9��	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	n�`�`0��\n��&�`�	&�`�	&�`�	&�`�	&X!��!x���	&�`���`u4�-XL0�|<�J+#�0���9�*8�!�L0�L0�L0�L0���ྊr7,
L0�L0�L0�L0�L0�7T��r�,L0�L0�L�q[�`�n&�r}i��&�`�	&�`�	&�`�	&�`�	&�`�	n�`�`�-x�9��	#��v�c�8Fa�FX&L0�L0�� �`�4"8�iFL0�L0�L0�Lpm�U�c8�aQ�`�	&�`�	&�`�	&�`�	&�`�l�0�Ml��L�<�`�	&���l�J�����]�YA�`�	&�`�	&�`�	&����.�G,L0�L0�F�\/�J� ��)�,#�������#�0���	&��F
vW��؂%�'K8�ٞL0�L0�L0�?#�������L0�L0�L0�L�Q��Ip`Ip�;�VAp8��#\C���S�3�`�-a	�� �K",�J0�L0�L0�L0�L0�L0�L0��
6���؂��D88aӌ�-XF88aA�`�	&�x���g���֟F0�,&�`�i7�� Lp��S�oO0�L0�L0���1̰(L0�L0�L0�L0�L0���!����a�c�x�)��	L0�lK���L0�L0�L0�L0�L0�L0�Lp� �pp�֯$8�`�4�-X&8�`�0��	���w�;��l�������R���]�L0��u�=�L0�L0��*�0â0�L0�L0�Lp��Fpl�b0�Lp�Y���*X&�`�	&�`��
�~%�_�Y��`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`��l�U�Fa�&�P��&�`�	6ݞ`�S̃XA0�\[��`�c���2�Ǿ�#�����	&�`�	&�`�	&XI9��	&�`�	&�`�	&���	&���e�*XL0�L0�L0�L����C��L��68� 0�R�k
����\��j�D �`�E`�k
X7����#8�`!�Ѐ��B88��fL0��FU[���N��k9�	�Xp�[r~�M�o�I�� �`�M\[�b0��W;,�`�cO�'�`�	&�`�	&�`��fX&�`�	&�`�ӹ�A0�L���!��Ђ��!�~���$8U��"&�`�	&�`�	&�8�-^	p�]/xB0��;� �b���� � gm�Np��� �*�rWqL0�K" XG�u�#�ЀU�Ca��oA0����&8�`�N�2\�&�����0�i.7(�_~���XWp� &�`��� ����NF8Y�),A0�L0��WD����Ea�	&�`�	&�`�	>q[�`�	&8}��V�!�`y0�L0�L0�L0�![���;� 84�j{��b��ސ� ��p���-�����w"2� �|蚫 �B/��Ѐ�B �*��>���B8a�VL0�K#Fa��I�$e�	~Z0� ��!|�~��0��390�I���`5�N�-9�c����V� �`�	&�`��#�ppâ0�L0�L0�Lpx�f!�� L0�L0�K�n$aA�`�	&�ق-�
p�y���ڙr 0� �����h �*�Rq
���o. p`��\n�)90��
�ph��!����FC�DO0�'+؈4�c�EL0����0����?`��`�F�6������ 8�`=	�-X�p��SX)�`�	&�`�	 �������L0�L0�L0�L0�L0�l�'�Lp�r'8U��`�	��%� �!�S����W�b���� 8U��j�&ph�� 82`�Ȁ�� ���TW;`�CG`�!��	&X&�`L0��)X��v)Gpl��0��	˄	�-XApl�z�	�-X&8�`k������L0�L0��U�c8�aQ�`�	&�`�	&�`�	&�`�	&�`�lt�LpJ�wfdLp8�F\?�b0��
�A0�`�h�S�f0������a�Z�D�S\�+`�S��'� �`���0���&؈�k+ؚ�lD���?@pl���c�	�-���4�v)G0��0�5&��'��	� 8�`�0��
Na�2�L0�L0�+&�0â0�L0�L0�L0�L0�L0���,Gp!Lpl�f!�,a�0�Lp�[���Wr \1�`���]i,	�c�Q``�`��&�`�C]�L�L0�\_���P&�`y0��"��`Y����L0�L0��Kp
s�	&�`�	&�`�	&X)9��	&�`�	&�`�	&�`�	&�`�	&�`�	&��	6���؂�`�	&�`�	&�`�	>�`K`\qWD�K� pŀ�}�U�"8�`e4 `��,�8�:� ؘ�c���=�+�A0����+X�pp��� �`Aa�a�k,XF88aA��؂a���'Lp��S�&G0�L0�L0�L�3��
�1ܰ(L0�L0�L0�L0�L0�L0�L0�L0�L0�Lp#[`�n&�$� ���W�h� WX5#�C��� �� |��'����#;� �`�	&�
��W�Lpl���[p������#Lpl�a�c�Apl�b0�����p��S�cD0�L0�L0�L�3����1ܰ(L0�L0�L0�L0�L0� �  L0�L0�L0�L0�L0���`� �f.�`� 0��\t
`�C�A0�L0�����	+B@pl�{�Ҥ�ll���	�-XF88aj�,� �`�	&�`���� w�	&�`�	&�`�	&�`�	&������1ܰ(L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�l��	� +�M$lV�	&�`�&X&���uF[�L0�|<��+#��{',� 8�`��,��`,	&�`�	&�`�	&�`�	&�`�	&�	�}E�nX&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�U�!�����`k�F�E�NX&�`�	&�`�	&���" �`�	&�`�	&���]���`C{&�`�	&�`�	&�`�	&�`�	&�`�k)�������L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��JpF0������q���&8�`��	�-X�pp���	&�`�	&�0�*r[�{�*�}e�	&�`�	&�`�	&�`�	&�`�	&�`�	&89�}5�nX&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&8��~��_O��d�l�����ox��6VM����X��pz�~r����O��~,�ӫ��'������Y�M��&�vߴN��w�׍gE����~���Ǜ��j2ژ�|\�>�駛V'�ڭ�Cg�ݽ}��<;ۼd�a��b��������b���nO��y����٣��������f�Nw�k��>qf��o�|���|1XL�o'/ގ����h�q�w����N>�X潢�[O����[6�5`�Q�4K�|���-���oߠ�ݳ��5{��>L./OGg�a>~��-��Ο>��M��˶�^����e�e�;M7J��ڏ�l{�u�{vZ�4���괛���칖?h�|������:�'ϵUSegg��d��4Y~�f�Gm�	��}>����n�g������n��z�Ng�s���<{�&O��|��-X��I7�g��sM�l����G�w{�uF;�}�=���5��_��N�e�s�������[��#�5;|��;��C~������w^�9v�ؾ�潋ۇ����3gqk��W^/�^2X+x|���GG����������0��w��!�N�S������zR^M,�`6Y��w��Ͽٳ}𞝃�����u�~�@��r��@�;P]�ā��M���W�^�=ޣk     