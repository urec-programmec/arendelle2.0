PGDMP                         {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
       public            postgres    false    202            �      x������ � �      �      x���AsGv ��+T�e�J+C �r���V6U9�8@$(#�HI���� "!����C���.�	q ������݃�~��ףw�W/����}1x������t1�x�����������������}y�����Y>�����lq�n��_��������K�g7�G����ëk��y9��\�����v���G�w���?,��x�*o�>��w\]�������X�,�.?r6��������_�ͣW���gw���ߖ}�\�ެ_����������x|���Y]ٔ��I�K~h��?���ή�W׿���>̯>\�o�{�9�g���Ż�o��I~��ûw���M;�_������n�k�<��������G>|R$�/[>~��_�e1����`��n�����E�[�,�ਂ�Fr�
p�!�(�� ��7E���p�<���~'��ӯ�d�	&��C�Lp�,�`��
�	�*�,��	�*xH0�L��kJ#��FrG,� �`�	&�`�	&�F�j� X&8�`�4�s�E�[�Up�0��'\֜f��QK#�A���y7-����*�RO�k,U�N�u���� ����/�
��[ŉ��H�	~v�ӗ/$�pjâ0�&�� 1�`�	&���L0�5
�wR�1 ��;	ࠀ#� !�x�/�13)0��[ Gpn�Z�	�*8�(�`�e�*�[v�і�p0��[bDpT��o'8�ಝ"Z�ƶ� ,L0�G�)F�[�Y9��
����+\�`Y�L�Z�wɉ�Ga��	v��
.[�A0���U�j��Gȃdpπ�J~�M�W ��`�SG`�8��?HN)�� �m�Gp���`�s6�Lpn���s�EU�e�� �90 !� �΀#l�0� ��_M�G���	N-X!��L�#�!&�^=�*8���	νF�`�CT�	&�`�	&��GhK#��G;� ���	+��[�I9�s��[�ie�klR�ਂe� X&8�`Y�56�#8�`{��[����l$Gpn�b�c` N]� `��p��4�6�#��Ӯ'�1�p�!��	�[p�2�a��O�,��	�-X"LpT�{�A��J��
���L0�L0�5
.���Up��J�	6'G0�b0��+X&8�`1�ਂU�&�`�	&�`�	�Q�99�k��Fpn�b0��˃	�-X&8�`sr�,� 8�`Y����U�ø�-XLpn�e1XApn��i�,&8�`Y�Q?�H�uG�3�7�_�q�$�ਂ-1"8��i���f8�ay�U
VL#8�`gz\�`Y�Q�T&8�`Y����[�Z�����l��s.�E��GlV��܂U��-X&8�`��	&�`�	&�`�	&�`�	&8^5M=��܂�EL0�[eD0��`�	&��l���,a��6�#8�`C9�	&�`gL�b�Lp6��`�s�Up�a�q�~�M�W
A0��u�Ӯ��)�1İ}�>x�[���i�,�I�w��.��G��F0��?�e��6��	޿`1��܂M�\�`SGlJ���Ni�@�<��܂�"&�`�	&��g��Ӝ�p�e=�rG,� �`�	V&�`�	�Q���-�,˃	�-X{%�L�j�L0�GpY���3�J�4�MiU�)�sVN#8�`C9�	&�`�	&XLp���v���*�AO�*���p���	&�`��+L�Lp�����-XApT�f�&�`�	&��n��z�	&8�`�4�s.��!�ਂU��A���
V� 8���<$��D��`�	&��HY������L0�ѳ���j7/�z{�6�Lpn�:{�Ap�6�4���	6��kN#8�`�4�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�@O�)g�'�Aw\��;�ਂ�`�s�	�[pY&�ਂ���l�2��˃	&�`��g�i�,&8�`��s����	��,&8�`�4�	&�`�	&�`�	&�`�	&�`�	.������#8��eF���
ލ�[�КU&8�`Y��'�H��܂eG�Lpn�e���E�	޿`1��܂���
ۧZ�a��OX&�`�	��F���7�C8as�,� 8�`�Gl(Gp*�Ӯ���A���L�D�`�	&�`�	&�`�	&�`�	&�`�K��[pS$�u�F�D#��	�A�a�s6�#8�`��	&�`�	&�`�k\VV� 8�`1�`�	&�`�	&���U&�`�	�.Xo�Q����Aᰄ˂����*ؤ��+��[�n"�v@�,�ਂ�`�s.ɵn!��p0����#�`�	�^6�LpT�&��A�,�`�	&x���1�p�*�L0���XF89�ݒ��4�3	�F�[p�b��4�	�\��.� �p ���	&���i�Y9�s�aIpT���	&�`�	&�`�	&��l��V{j�!8���ƈ-�b0������ƈ1�D��܂����2�#�	&�`�	&��n��W\�`s��C�ਂ��L0�L0��(����,�[�z0��;���˃	�-X&8�`y0�Q���Zi,�@��	Ow��SPc8�a%a�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	N!�R9�s�Ј�܂eL0�ѳ�� �� L0�L0�L0�L0�L0�L0�L0�L0�L0�L0����YfDpT�e-�M�`A�,��EpT�ei�D�ਂ�`�kl(Gp�Sg�1�ܰ�0�&��H�L�`�	&x��_IpT�&�	�-�H�`�	&XA0�}��&8�`Y�L0�L0�Lp6�eմ��`&��b0�L0�L0�L0���F0�b0�L0�L0�[eDp݂�Apn�b0�����,�[����-X&8�`'i�[�,��܂�C0��?��;�mB�/��t��hX�ԉr'7����\VO#�ਂ�(Gp����*XApn�Fr�,�[pټr�=�� ���F��E��܂��-�,�hM��a��O����,� �`�	&�`�	&�`�	�&ؤ�5v���o�����#�¦4�-�P�`�	&�`�	�s('&8�`=�G\V�h_*�C� �a�s.[*g^��܂��*X1��܂-�'��b0������Apn�b0��˃	&�`��9UNE��T��W&�J�b0���FL0��L��-�$8�`��M��.S\��	�-XL0�)6'Gp&����,� �`�	&�`���Ƀ	�*X&�`�	&�`�	&�`�	&�`��S���V�`���	�-�*#�M�UF�,�I��`�s.[�)L0���`����(،�Q���U�<��������� w\6%'� 8�`9�S	��(g(�p*�6� �`�	$Xc�����\V��	�*X&�`�	�>��ApT�e1�`��
��	�L0�L0�L0���F0����f4�m�A���	�-X"L0��?��	�A��J��
�EL0�L0�}փ���ڼ`3��ApT���s6�Lpn�6`%���#��A��.K#a��
�Apn��_%8�`�=�!;��մ	������|� �\I3!Gp�����f8�a�i��o��Ĥ2�K#�-�,�� �`�	ޟ`ݕ'',L0�;Փ`�?l�2��;���܂�`�	&�`�	&��`k�	�-xw$�5g�J��	�E�I��J�s6�#�`�	&�`��̃��C8,a��,� �`�	&�`�	&�`�	&�`���U��*�A� XApn��+	�*X�0�5�L�;�������s�o!`��
�Ӯ����� �M�|`��pG0�a�"�*XApn�vM#�����
�P&�`�il$GpF��yL0� `
  L0�L0�L0��)ج2����[���s�L0�L0�\�`ݕ� X5�ਂeL0�L0�L0����"�6��	޿`\�`�iGlN����#8�`��	���#`'���sQ��5��&��9� �΀#,��R��ݳ���C0�p��3�G\���#8�`Y�56�Lpn����-X&8�`]=�l$Gpn�e1x�&x�H��?a��L0���;��5�lR����ˆr��� ,� �`�	&�`��j(gN��L��+�[�,��܂�b�r�a	�L0�L�r�5
�	�-�2�sv����"&�`�	&��n�˦��3"8����#NCX9�ਂ%�L0�Lp^�485`!��ܥ!�R�Ӯgʙ�`8�a�r�`��\���*XL0�L0��)�B9��
�0�A0���	&�`�	&�`�	&��.�E�.�l���p 0��+�\�`�r�,�[�LpT�FrL0�Lp�y��J�sV� �`�	�ܞ`�������m�Np ��z�[�j�L0�L0�L0�L0�L0�L0�L0�| ���G��f8�a�>0�z�	�A�a�s�	�-X5�ਂ�"�-XAp�eGlV��܂e�l��s�EL0�L0�f4&Xw%���M#8�`y0�L��7E��m��h@�Lpn�e��	�-X-��܂Ճ	�-؜����L0��iL0�L0�L0�L0�L0�Lp��uW�[�L0��l���'ʕ���_�p�v� �J����
.�"&8��Y�	� ���0���i ��$�`�	&�`�3
��	���U"lApT���	&�`�	&�ϑ��4��
�0�L0���z&X=��Z�L0�L0�{��#`~��y�+��܂��ܴV&8�`�L0�	+L0�L0��F�u��\�m�]� �p0�QK�	�-X"Lpn�e�r[��&�Ƃ0��',� �`�	~6�����t�0�ʰ��W)X9�ਂ��Cpn����3�b�k~�M\L�]��F�+&8l��Fpn�
iG\�,U�,��܂��&�`��g�[����
v����*9�E ���)�sV&8�`�4�	�V� �pY_D�����:	�Ԁ���H!&8�`S�G,� �����*8B-�`�	&�`�	&�`�	&�`�	&�`�s.[$gF�ਂwg��ę� 8�`Y�L�	�v=IN�p��r�`��� X�;�Q?�i㎀d�o��#0� ���`�{΁U�	�*�Z{�sV&8�`Y��� �`�	&�`��̃���-XO�Q���[��s�>��˃	�-XL0�_0�=�w 0� ����o�q���P
&8�`�� X)�ਂ#��'�`Y��
�<�`�	&8z�u�Ƨ<x�0��',L0�L0�L0�L0�=
�v=INk�Ak� �J�b0�L�.�p��=��bĄ_~c�~�i ��J��&x���`��	�Ȉ�L�#�N0�}�dL0�:�&�`�KpY-b��Re�#.+F(�U�I9�s�	�A���Q�"�-8�"9��9;�ࠀ#,0��I0� �lGp�5rL0��n�����j��i��p�PN&8�`���
�B�`�	&�`�	�A0�Q��L0�ѫi�L0��s�\Yk�O ��8�2#�	�HL���WpQ1u�,#�S�`��؁���Apn�Z{&�`���UpY�uP�`A���F�[�a�	&��艰=O�-X1�ਂm_Ipn���k,� 8�`[�[�,����&��o����a�K�	>X��3�*8©�,&�`1���,�[�Ur'',� 8�`k�&�`�e,L0�L0��)���r��/x:��ף����vy�g�ۿ~�O/qmcu�����X?�������y;?>>??�<��������O�߽��i0�_6����W��ϫ�;����v�K�^�h��ͯ���o�8�79{��}��O���p���x�e���dt�e�����GV/�r>?�����^�������|J�������͹޹��\?�<�z��������h����X�f�/���vv�8�a����˷����9;?�����|�ۓ��f<�7�_�������&>�<ٹ�[����֗}߹���f�'�+O6��v�~^\\�:���6篟�Ν�go���[޲����7z�[7����nݺ���d�m>l�͕��ܲ�����|֜=�g��|2<��gmu���~�F;w�>0���r�8vƹq'�'���l����Ys:��.����o]3i&_�u���twn�s��>]ó���}�v�ek6W>�����2�y5���o>l�w`��w`����>�}i�l���݅[?zo�����?���Ks����W>���W�r�b��Œ�Z��[�����_x���������|ܼ�?�e���{v�~u�7������(b�׋e���g��.W�t�r���Q�+~Qo��Q'ި�7j�*{�Fި�7���������zʢ[     