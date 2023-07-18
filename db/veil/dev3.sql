PGDMP         4                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
       public            postgres    false    202            �      x������ � �      �      x���AsǕ ��+T�KR������e��C*٪=�8@$(c�"U$���� "a����C���.�	q ������݃o����w�W/�����|1x������t1�x�����������������{y�����Y>�����lq�n�����������K�g7�G�����յW���_o.|uys����ۻ�u�����w�z���������g����X�,�.?r6�������_�ͣW���gw���_�}�\�ެ_����������x|���Y]ٔ��I�K~h��?���ή�W׿���>̯>\�o�{�9�g���Żo��I~��ûw���M;�_������n�k�8��������G~%��H�|��	&x���b�I��g��e�,� 8�`Y�Q����<�~CpQ1�sn� �;��x�/���N��7�_E��
�ApT�q,� �`1����˲1�ਂ�L0��M��4�kl$GpT���	&�`�	&�`�k�Ap��`�sVM#8�`Y���[7#��e�iiU�4����Gp�"X9�ਂ-�$��b0�Q?�\�M�� ��i��A0�_�U�ؼ��$��g<}���Arr1,
|`����A0�l�`�	�L0��
v��=��NB8(�Y0� GH!^��o�B
pj���[�:�QG�L�,��Z�n=��NCX&8�`K��*����\�SDk"�ض� �a�	&���C9��s6+GpT�6�#8�`a�k,� �`�	V� �`#9�Kp��"&�!0�*�l���l$GpT��i�!v���i~�M�W ��`�SG`�8��?HN)�� �m�Gp���`�s6�Lpn���s�EU�e�� �90 !� �΀#l�0� ��_M�{���	N-X!��L�#�!&XLp��#�� ���k�	&8D5�`�	&�`�	�Jp��4�	��q��	� Lpn�&��-X&8�`��� ؤ�Q�"�A�LpT���k���ਂ�Fpn��i�l$Gpn�b�c` N]� `��p��4�6�#��Ӯ'�1�p�!��	�[p�2�a��O�,��	�-X"LpT�{�A��J��
���L0�L0�5
.���Up��J�	6'G0�b0��+X&8�`1�ਂU�&�`�	&�`�	�Q�99�k��Fpn�b0��˃	�-X&8�`sr�,� 8�`Y����U�ø�-XLpn�e1XApn��i�,� 8�`Y�Q?�H�uG�3�7���`�{�LpT���J��yr3İ<��*+�U�3=	�A�,�ਂ5W�[�,��܂U�	�-X-��܂�`�s�]��kp'8�`�����Fpn�b0���EL0�L0�L0�L0��i����/�`�	&�*#�	�L0�gܴg#��������[�I9��
v���+FL0�G,&8�`y0�QGhv� ����~�L0�_<�z��b�A�7�����I��Fp:�b0���pG89� �ApT�
jL0��\��>n<!����	�-ؤ�56�ApT��4�Ap딆��˃	�-X-�`�	&�`�	~�99�iG \��n(GpT���	&�`a�	&���#dG\�	&8�`�L0��iL0�Lp�eypkk��*��6�ApT��4�-X9��܂�&�`�	&�`y0�5
.۵���<�z��Hf8��y��l,Gpn��	�-XApn��i�,� 8�`�rL0�Lp7�z�	�-X5��܂�z{�`��
VM#��f4�*X-��܂wc�E�w��
�	&�`�#eFrg,L0�G�"��U� 8�`��������o���a�s֜Fpn��iL0�L0�L0�L0�L0�L0�L0�L���v=R�bO���LCw�Q���,&8��L0�Q˃	�-�re�s�L0�G�"T��-XLpn�j�l�)���	�-X"LpT��iL0�L0�L0�L0�\*Xk�56'GpT�NE$8����u
�Ye��	�E|x����-XLpT����\V�h]�1!����	�-�,ު�}�E�Fx��a�	&���iD�z{c9��6�Apn���s�ApT��r�<�z����Q�z��,� �`�	&�`�	&�`�	&�`�	&��R�Z#�-�)ܺP�q����#��z�	�-X"LpT��L0�L0��(�� �ApT�b0�L0�L0�5
6�L0�]��4��
.;MC�0�a	�a��U�I9�sVN#8���D��pY�Q���\6�k�BX1��a�s6+G0�� ,� 8�`�r� XA0���S�f8�aa�	&��@�M,#���nIX��K#�-�l��LpT�e�p�r��a��OXA0�=�0+Gpn�v�!8�`Y�L0�L0�Lp6�e�=M+U�ncĖV1�����bp{c�a��OX"Lpn�e���i �� L0�L0�w������ 8�`�G,&�`�	&�`�	&�F��W&8�`1��܂Ճ	�-ؙ\� XLpn�b0��˃	�*�l$׺Hc`���Ox�{���é+	L0�L0�L0�L0�L0�L0�L0�L0�Lp
����[��F�,� �`�	��E8ᰄa�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&��߿P�2#��
.kqo��g!,� 8��4�`��
�	�A���AO�)�pr�J����	&�`���%�Q�X&8�`#9�	&�`Y��9�#�ਂeL0�L0�L0���U�ZO��L����L0�L0�L0�L�j���L0�L0�l��u�_�����,�[�Lpn�#�	N-X&8�`'i�[pY&�ਂ�C0��?��;�mB+� 8�`3<u����$�����[pY&l^��܂���*XApn�Fr�,�[pټr�=�� ���F�\����*�P��܂˲��D�iFx����Lpn���	&�`�	&�`�	&��l�M�\�`�4�s�Z��)�a��Oؔ���L0�L0���ǝ�l��j�K�t#�����\�Tμ2���U�b��[pOp��`�sV� 8�`��s�	�-XL0��ϩr*��2l�2�U
�	�-X5��܂�+U��0��[�Ipn�j��]�&8��Ş���
�L0�Gʃ���I��r�,� �`�	&�`���Ƀ	�*X&�`�	&�`�	&�`�	&�`��S���V����֣4&��b0��[eD�	�ʈ�܂�`�3	�_������	&�`��M0���&8�`#9��
�g��˃	�ApQ�:
pW�eSr���
6�#8����r�r�2l���,U���s�	�-��!U���5�EUp�HNc�Q��`�	�*ؖ'L0�L0�L0�L�j��
.��h�{`l��	�-X"L0��?��	�A�a��
�EL0�L0�}փ���ڼ`3��ApT���s6�Lpn�6`%���#��A����	��k� 8�`���[����G���8B���oL���g pϕ4r<�=O�a�S֚F��	��OL*#��4��܂˂���L0�������E�[�4�ਂˊU�����\Z�s�	&�`�	&��n��U&8��ݑ����+	N'XAp&��+	�-�H�`�	&�`�	�3�Rᰄ#�-XA0�L0�L0�L0��+[�IpT�e��[�,��܂�WU�a�k,� 8��~Gr�38B��o�a\�)� p��]ϓ��	�A��bG0�a�"�*XApn�*\�`Y�Q�" �
  �-Xc�5�@�ਂ-�$�`�	&�`�	&�`�	&�`��S�Ye�sV&8�`}�,&�`�	&�`�	&�F��+	�A�j�Q�"&�`�	&�`�	&�`��	.�E4m�'��2"��z��*؜�56'GpT�j|/�MG�N������k~�M�s0��GX�	0�����g��+��T�;�f�Q&8��<�|�Q�ef3�-،2����[�LpT��z�-XApn�e1x�x� ���	k�$�`�	ޟ��i�)d�r\6�km��@8 ai�L0��TC9�	�$ؼ2���"�-�,+�!�� L0�L0�+�\�`1��܂-�'8�`�h�[�,�`�	&�`�	�&�lZ�:#�sn_p�1�4����*X"L0�L0���@#�S�	�]��.<�z��)��6)G��	� Lpn�e1�P�ਂ��L0�Lp��-�#8��SlZ�`�	&�`�	&�`���ZD�R���� ,�[���klR��܂Mi�[�LpT�FrL0�Lp�y��J�s�	�-X5�ਂ�#�`��
.������ĝ� �-�$8�`�4�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�@Ow���!�p*��|`�)Gp�u�[�Lpn��Gl�=���"�A�LpT�f��-X&8�`{��[�,�`�	&�`�	�3V&8�`ݕG�7��܂��L0���	�6�Ap �b0���&��j��Lpn����-X&�`�	VM#�`�	&�`�	&�`�	&�`�	&�`�	&�`������܂�`�	&��g<�=Q�l��1l���,U�,��܂#d' �/�~C0� ���pj��`�	&�`�	�(Xc���U"lApT���	&�`�	&�ϑ��4��
�0�L0���z&���*�H�`�	&�`�	޻�7��o��8]�,� 8��E�j0�y�� �`�	NX� �`�	&�`�	&��4���$8��m+��a���	�*X"Lpn�a�s.���j��4)7��?ai�L�	��'����T�u�\�`���
�k�����~w�q������򛸘�u�~���W
Lp��`��
VH#8���`1�ਂe�l$G0�,� ��>k� 8�`���[�W���]�y�� 8�`i�Q+�L��
�΀��/�kw;�������`�S�"� �ంM)U�,����#8���`�	&�`�	&�`�	&�`�	&�`�	�!�"9�sޝU�ZgF����eL0��&x��$9y�Aw��N#8�`��� X�;�Q?aEx�������s����B p�9�j0�Q[kOpn��`�	�E\�`]L0�L�<�`��D�M��J�s6�Apn��g\�`y0��˃	&��8u9`��=-���~�;��LpT�&3�A�R0�QGXgO0���kly�Lp�,b�P�Oy�a��OX&�`�	&�`�	&�`�	&�`�{<�z��1�5��*kO#8�`Y�QGX�� #�#��	������ ��J��&x��R��t�-2"8�`�4�s�0�#��˃	�*Xg�Lp�Zĸ���G \V�PN#8�� l(GpT�b0�56�#8�`Y��GX$0�=��~���8�#�N�pj�Fqk�$�`�	>\���"8��Zp{cZ�0��'\6��	�-X1�ਂ�� �`�	&�`��,FLpT�b0�Lp�j�ErL0���%W�a��� �̈`�%,\�����`g�3�~�� �3`G*�[�,��܂��L0�G,&8��<x����0��',� 8�`�L0��a{��[�b�Q۾��܂e� X&8�`[�[�,��e�����7���K� 8`)�aK�	�-X&8���*L���	�	>\�b0��[%�pr����
�ƈ`�	&XA0�b0�L0������,.Gq�����o~>���-n�wyv����'���6V����ށ��^]��9���������c��^]�������������e3�<~Ռ���������w��������*���V��{��+�G?���x��_N��_�[_NFw_�[�M�d�b.���~Z>���������m�)-��_Ǜ7�z��fs�`��u �+���K�����b��-��ớ��������wߝ/��W�����d���>����/Ov��|�����{˛�D7�d�nݖ��[_�}熛���l�<�\:�ҝ�qqq��lrrڜ�~�;w2����goy������	n��׷n�v�֝Ÿg';�l�am��],._�����?k����g?k�[5�L���6ڹc����ݗ�Ǳ3΍;�<���}�f���NϚ���ty��O|�I3�ҭ[޶��s�;w���m���[��/[����_�/}ؖ�ͫ��x6?}��a[��ϼ�������Ks�e�g/�.���{��Wl�����w_��_8��{�|�+/�
^,��em���;��w��|�J�o^�������[68zH�g��W�}�_~X�O�"�Op�X���~�!��r�I�+���u����F��u�*{��ި�7j�*x�~�f��������j�q     