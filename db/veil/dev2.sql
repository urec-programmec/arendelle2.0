PGDMP                         {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    27271    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    27277    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    27279    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    27285    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    27287 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    27271    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    27279    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 106, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    27290    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    27292    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �      x������ � �      �      x���KsW �u�+\�MR�(t��]f��HM�j	HfF�T '�J�� ��i;�6����&D-A���羲�~������ݻ��~�����e�����~2�o��M�w�f��|}�ۭ�_���8�Z�|7�Oo�7O�����a���ԫ��|����^-�Cw��Nf�����V?�~��쯾�_���o�����n6����_������#���av�����`��]]��{��WWG�/���>�Woc>�{���l����S����̼̓�e��)��>i��_����n�g�]�����L�럞n��U�{;�~��%/�~뗏W���h��ui�?zk��V��p��h�ny�O�ő�	&8�`1�`�	&�`�	&��&
.גk��%�0�	��0����\�7�E`��������~���د"�L�Aq��`1�`�	&XA0��w&�`�	�M�<�`�	&XA0�L0�L0�ZrL0�L0����^�,G��	�Fpl���	&����H�<�`�	&8�,���ʋ�� � �k���o
~�'+x�8�y�}�	>�����6�c8�aQ��l+D�	&��Գ�	&�`�OU�m4 >pl'D�\.w� �H�(�K���f!`U�	&���h,�T��bp�j=��!�� L0�l�v�	�Pp��"
�ܲ�'@X&�`�	֔#�`�	n�`��[�L0�L0�Lpk�[�Lpl�b0����A0�,&��C������攍� N�!����~`�Ś�j%� ���q�H���V&�`�	&�`�	&�`�	/X-�`��T�}` >pa+D��i �����kP����F\N0����G�3��؂���,� 8�`1��؂S�� �`�	&�`�#
֒#8��/؎6�#�p��a�c�)Gpl�b0���� �`�	�EL0�7Q�,�`�	&X=�`��`��(XK��؂S����������`����îZ	0�Zq7C��Nr7�?��F
.�&�#�p���L0���L0�[u�`�	&�`�	&�`�U�&8��,L0�L0�L��VM#�`�	&�`�	&�����&�`�	&�`�	&�`�	&�`�	&�`�	&�����Apl�b0����L0�L0�7Q�[r�̈��V�� ��`S�n�����nXA0���`�L0��'X�������"Lpl�j�,[�Lpl�j�,[�j������A0�L0�L0�L0���L0�L0��6���؂�`�	&����E��a���	&�`�	&�`�4�OK�L0�L0�Lp�0@�~\ � �5���+� �`�	������nغi��୑�N�Lp$�F�#�� Lpl�
jL0��	.7½W�O0���	�-X��L�j�Rpa����	�E[�Z�L0�|�>9��N��1��,� �`�	V&�`�	n�`K`[�L0�L0���L0�L0�����C{2�4CX&8U��4�-X&8�`M9�	&�`�	&XLp�[����'"x`S9���GL0�L0�L0�L0�z�&�`�	&�����q'8�`-9�c������L0�j���)l�;��
�	&�`�S�"&8�`1�`�	&8�,bk�Z���W��؂��n���e�s������,� 8�`�4�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�Dl)�ppæi|b��`�c�	[�Lpl��`�c�	�-XL0�,� �`�	&�`�OS���NX&�`�	VN#�`�	&�`�	&�`�	&�`�	&�`�`�	&��f
6͈�؂wc��.�N�L0�L0��|����"
'i�	&�~�b0���˃�*l�7��F�~0�Lp�iD�|{m9���	&�`�	&�`M9�CT�TNc�TK$>1�	�	&�`�	&�`�	&�`�	&�`�	.+X=��؂�R�'j�v4B80�L0��A0�L0�L0�e�+Lp���`�	&�`�	&�`��(X��L0�\Mp��4F8Y0���#8�`�4�c�M�mNp$�b0���k�.!��p
�a�cVN#�`�	V&�`1�`�	&�`�	>��A�]�f8�*�L0�		ֱ�pp»%a���$XApl��&�Lp���%�=�>��OXA0��zA0�L�,�`�	&�`�	&�`�	&�`�=	�.xw`D�`�	.��F�F�~�a�c.7��4��%,L0�L0���F0�L0�˃	&�`�	&�`�	&��`�+	�-X&8�`�4�c�EL0�L0��D��Zr��42�4>>���r
j�2�$L0�L0�L0�L0�L0�L0�L0�L0�L0�!�*Gpl��[�,�`�	&8�,�n0'KX&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	6Q���\n�{^�w���	NU�4��؂�`�	&��	�S������	>1�m�	&�`�	&�`a�(XK�`�	&XA0�Zr7Q�,�`�	&�`�	&�`�	&8��rմ��`�\�`1�`�	&�`�	&�`�	&�`�	VM#�`1�`�	&�`�	&�`��2"�`�	&�`�	&�`�	&�`�	&�`��t�b0����L0��	�]�okZ�	'X&8a�;�1ܰ���`�4�c�	L0��"&XK��&
�	�-�\�r�=�e{N�� Lpl��[������"
�<G��	�� 8�`i�L0�L0�Lp4�:�&�`�S�5���OX���k�L0�L0��L0����EO�3B���l��L�,�`��`�	&�`�	&�`�	&�`�	&�`�	ޫ���r*��2�O�`�	&�`�	&�`��T#�.�dO�c�E|j��V�"���[x��؂��L0�)��I�z0���"&�`�	&�`-9��(X&�`�	&�`�	&�`�	&�`��)x�W�[ �p+�>��/X&8�`=��`���-X&8�`�	�-�LO�	&�`Y�L0�M�<��؂�`�	^κw�*`]r�,� 8����r�r�2,� �`�	NH�,��؂�`�cV� 8�`1�`�	&XK�`��`��(ؒ'L0�L0�L0�L�j��\�G�p	���'@X&8�`�0�Lp}�&�`�	�EL0�L0����o�ѵy�z4#X&8U���c�	�-X=��&.l��9��OXApl���c�j�����\.�� g�lC.�S�}~�M�o!�<���J��v��c��P�Ea�OL�x�S����K�`�	&8u�FW"�� L0��A0�
6Y��؂e�,L0�L0���'Gpl��-��8�WN�Lp$�z4�-XK�`�	&�`�	>dl���V� 8�`i�L0�L0�L0��^A�`�Sl�0�L0�,&�`�	>M��"��38
�R!��/�Ml�0� 7��~r7�d&��$�qL0��"n�`�	&�`�e�%G0�M�i�L0�L0�L0�L�1�#8�`�`�c�	�-XL0�L0�Lp�EL0��"&�`�	&�`�	&�`�	.+�\-"/�'���[/�`�	&8�,�`�	&�`��	>����	��r�~��r0������.��v��3O��P�+�f�Q&8U�)��l��	&�`�	&�`�	��Zr�,[p��+��#\?aC+	&�`���ۭ�ՅL0��.ה+��p��L0�L�rI�~e�c�E[p����p��a�	&�`�	&X9��&
�	�-�4�c�E[�,�`�	&�`�	�&���� �x½��!,��`�0�L0�W�� X&�Х�n�<�>2��=�nX=�� 3  ,[�Lpl�b0�L0�L0�M�%Gpl���	&�`�	&�`�	n��r��©����N�� Lpl��iL0�L0�7Q���L0�,&�`�	&�`��)�$�c.�����;�	�	�-X5�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	>���-�f8�ac�	>1��WL0�L0��D�Zr�,L0��'X������l��c�EL0�L0�z4&�`��	VM#8�`y0�Lp}��R�{E��h��`1��؂�"&�`�	&�`�	&�`�	&�`�4�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`}r��`1�`�	&�h��;ʕ�)�0É�b�LpB�e�\.�� g����>l���4�XL0�L0��Cpl�)T"&XA0�L0�k�L��֒#�`�	�EL���L0�T�늀��W;�`�	&�$�Z�L0��A0�L0�L0�a[Ipl�喭��s��BX&8U�a�c�[p�N����7��F�~���	&��	�n'gtá�F0���`5�c.��E��|O�mfp
I���.�U].�_~S�+&8vA0�L�g
6:��؂�`�c֒#�`�	�EL0�7Q�A=����,�p0�L�r��(`�+�㸈�������I�a��V�lh%�L�,�`�	&���S�L0�L0�L0�L0�Lp�&�[�n��ք8�	N\�,�`�	&�h�v�c8�am9�OL�L0�|YD�"`���`��]�7��ˁ	�-�Le�cN!&�`Y�MlT�L0�,&�`�	�&X5��؂�h[�,�`�	&�`�	>�`�aC0� 0�5M����j��3�`��`�	&��0��!8�`1��؂M� �`�	N=���Tc�>��OX&�`�	&�`�	&�`�	&�`�(x`'9��64�`�	&�`�	ޓ�r�4
�m���� N!���7� |�`�+VI#��o�$��p��`�#	VI#8��rL0�Mld�Lp굈^`S�N��b��+[�L0�,� ��C��v�l_�8t�ʀS�`0���v�84`�8�Sl`�L0�|�Zp���a��'�)G0�\�`34&�`�	&��C#&8U�b0�L�j�Lpv��+74'��X&�`�	&�`���u+
���|ع� \�ne�c�[�L0�L0�2�ڨ���0���	�-�a�	&���a�	&�`�-�G0�b0�Lp:�e�,L�Zp�"`~�M�o�)F �`)�L0�7J�R����L0�L�!�%�pp0��
6ǈ`�	&XA0�b0�L0�|L�_����>�����φ���aq��7�ۿz�?�����֭���
�^otw����/��V���ls�����v�����r�u���v^����y��f����d���X������Gyvh������%���~����C��z�l=��������,���d2�a����f�&��{���[Z�"/{��3�9=ߜ�m^`5`yf��>��]}qf7�O�x������a:�n�������?����U�w����o������$o}�^<޽�M��l�����Ҿ�z���u6��ho�loN�>u��Lon����(�����k�����-nYv�m�{�=ܺ·�.�ܺu�4�Y{�m�l�͙��'n������]��޿kWW�N�ߵ����=~ٺ;wl_?>����tn\{������o�G�|��wn��[�����n������v��㷫3����[��/[�9��_�O}���yg�NF�O_���>r6ZG�?z'{|�6�{�x��S����ؼ���'���ƽO|{[�w�t�r����J��%+��;W�#W��d�L���쪗_L�.Yv��bgo��}�_�O'�筈�̦�����<��U�lW>�S��n�3�>�����B��P�܅�P%.����?��x���P֔D     