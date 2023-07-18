PGDMP         	                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
       public            postgres    false    202            �      x������ � �      �      x����sZ��u�Wx�M:�*�����n��4��"a� ٴ��Ar�L��{A$����<�!.�{^��r�_��ïGo&�﯆���ft�ח�W/�noF�q���=������`t���/O���t��齍���Ǘ��՛僖?;��4���y;z��/fw��w]�|5�,7|w}u{7��ף�G����/M{��O��]OF��?���������=��������-^���W�������:������W���˸\�_�os����M���ٖ�M���A�M�����s2_O~��;nF�7����Og�,���y{�G��Ó_����b�5���x�Ż��ͷ��oSu��~�M��Hp�`���`�	&�`�	&�`�K��H��ps[�; \�nv���6��o�%��7�-&�	���=��`��L0�;�Lp]�`�	&�`U�W�!�`�	&xo���L0���	&�`�	&�`�	6�#�`�	&�`�	&�`�	&��4�U�&�`�	&�`���L0�i��XET�ο� � pկL��:�UBL0�^p��K��1mX
|`���H0��� �`�	&x?������`!\S��%pw`���x��_~�YA(�X�`�	&��}4�	���*XL0�L0����v�������`�	&�`#9�	&����-XL0�L0�\�`#9���`���`���F�`�	&XL0�������7NY��:����7د ��5�n��`��� �`��1\�a�`�	&�`�	&�`�	&��x�z�G[�B�����i \����פ�	��u�L0��*������	��� 8[�&8[pNgL0�L0������l$Gp�`Lp�`���,�	��&�`�	VEL0��(XA0��L0�2����-�l�wx�_�0� ?C#b�_Z	0�Fq�!�g!9��;�A0�\#���	&�`U�Lp��}��L0�L0�%
�M#8[p�L�&�`�	&�`�	&��/��F0�L0�Lp����&�`�	&�`�	&�`�	&�`�	&�`�	&���v��قe0�قe0�L0�L0�%
��H�"`k�[��`��+!v����YN��p���	&��	��L��;%Gp�`Lp�`a���E�-X�-X�-X/��l�2��l��ig��g֋ �`�	&�`�	&�`�	&�`�u�&�`�	&���6���l�2�`�	&�`�	&�`�	&�`�	�M#�`L0�L0�L0���l9.�� �5���UBL0�^p�rr���iL0�L���	�,�	���F0��?�&��-X�-X/�`�	&X7�`�	&�D�����EL0�L0��;'Gp�`����"&�`���	&�`�K�Ap�`L0�L0��L0�L0��`�	&��2;�Ap�`Lp�`#9�	&�`�	&XLp��]'Gp����7�� �`�	&�`�	&�`�	&�`���#�`�	&�`���Np�`#9����Cp�`L0��A0�����	��L0�u�"&8I�&�`�	VELp5��*�-XL0��O���g��g�M#�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�Dpϊr�v��&X�-X%Lp�`Lp�`u0�قe0�ق��L0���	&�`�	&�`�	&�`�	&���iL0�L0�L0�L0���`�`�	&���	v��قe0�L0�L0�%
�&8[�^�قe0�ق��g��L0���	&�`�	&�`�	6�#��O�YQ��p���L�:�`�	&�`�	&�`�	&�`�	&�`�7�Lp���G��L0�L�^�L0�L0�o*X?��l�2�`�	&�`�	&��;'G0�L0�Wl%���`��;'Gp�`�4����	�,�	�l$Gp�`Lp�`L0��L0�2�`�	&�`�	ޡ���7�#L0�\#������-XAp�`3�	��&8[�*�`�	&XA0�\�`U�L0�L0�Lp�`3{��:/�M0�A�e0�ق��g6���l�2�`�	&�`�	�&��4�	&�`�	&XL0�L0�L0��
6���l�2��l��igVEL0�L0�\�`#9���VW��Oc8ʰ�0�L0�L0�L0�L0�L0�L0�L0�L0�G6���l���-XA0��� �`L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��:9�Kl�;�L�*�`�e0�Lp���(�p�aa�Lp�`�	&�`�	&XG���L0��"&�H���"&�`�	&�`�	&�`����-XL0�L0�L0�L0��i,�	&�`�	&�`�	&�H�`�	&�`�	&�`�	&�`�	&�`��C@p�e0�قe0�L����?�	&��gܳ���ͯ$����-X%L0��� �`#9�K,�	��2�قe0�قe0�ق����� 8[�3gVEL0�L0�L0��	�M#�`�	&�`��� �D�FrL0�L���Lp�`����`���N�`�	&XA0�2�`�	&�`�	&�`�	&�`�	&�`��*������0�Q��� �`�	&�`�	&��#����֓�l���	&���	v�'�ق��L0��`�	�&�D���	&�`�	&�H���`�	&�`�	&�`�	&�`�	&�9��U�Lp�`Lp�`g4&�`�	&��m��&8I�+=	&�`�UL0�Lp�`u0�قe0�/7�w�*`����� 8JpouA9C9���#&�`�k$XAp�`Lp�`����`�	&�`#9�	���(�W�L0�L0�L0�L0��i��`g4�,�	��&�`�	ޟ`�	&�`�UL0�Lp�`�`�	&�`U��`�K�L0��� �`Lp���p'8[�&8[�f�^��-����|�/�����o�%��7`�4���VW�c��(�R���Lp�`Lp�`L0�L0�L0��&X/��l��T&8[�*��l�2�`�	&�`�	�&�Urg6�#�`�	vF�`���&�`�	&�`u0�o*X/��l���	&�`�	&�`�	&�`�	&X?�`�7l~0�L0��&�`�	>L��u�-fp
��"��_~K�0� �g19���2�	&��8�	&�`�U%؅�L0���	6�#�`�	N�2O�	&�`�	&�`�	&�`�	&�9;'Gp�`�`���`����	&�`�	&�`�	.Q�^�L�*�`�	&�`�	&�`�	&��M�E�-��EL0��"&�`�K�A0���+��u�!N��7�o�
`�+��"��:�M�~n��յ�\��p�ag3>0�u��	&ط�L0�L0�L�6�#8[�&8[�&8[���L0���2�ق����� �`�	&�`���.Q�3gVE�-X�-XL0�L0��i�(X�-�����"��� �`�	&�`��	vV�`�	&�`�	VL0�L0��	���рE0��nEt�n�D0���g=9���|`�e0�قe0�قe0�L0�L0�%
6�#8[���L0�L0��(X/��l�2��l��iL0�L0��(�H�`�	&�`�	VL0�L0��)ؼ���`���`���L0�L0�L0�L0�L0�L0�L0�L0�"������iG6���l~%�L0�L0�%
6�#8[�&�`�	ޟ`g��,�	�l$Gp�`U�L0��&�`�	N��Fp�`u0�L���&8Z�&8[�^�L0�L0�L0���F0�L0�L0�L0�L0�L0����#XL0�?����r��c8ʰo� �`�	��`U�ق7���:��m	n�n�6� G  8��0�р�L0��(����סA0���	&�`�	&�H�`��D���L�*�`���&�`�	&��P��+�_�8�	&�`�	&�`�	&��b�L0�L0�\�`s+	��k+	&�`����&�D����-XA0��l�{��ɩ#�2�&�`�	��`�4��o���u�[�-	���u("N��7��V��"��~��gWL0��`��	�,�	�l$G0��� �`�	.Q�I=g��L0�L�n��G0� W��iU'�����^]0�Fq*��J�	&�`U�Lp����&�`�	&�`�	&�`�	&�`�	&�����#8[���gVEL0�?�����7l,G��	��L0�QE�Tl#~��r�����m����	��2�ق�PL�*��R�A0�L0���	&�`����-����"&�`�	&��]
���рw� 0� ��9~���_�8��� �`L0�#ؤ���`���<�`�	&XA0�2�`�	&�`�	&�`�	&�`�	������7lf�L0��%��]����.����u��3~��g ﶄ �ʀu�&�`�	&���&�Ё�Lp���L#�`�	֋ �`��K,�	�,�	&�`�U��n��ܖ`���`�������Z� G6�#����K#�`�	&�`���#�D�FrL0�����	&�`�	&X/���`�	&�`�4�	&���VW�33��(�R�`�	&�`�	���f��`�c����`�+vV��l��`���`�	&�`�	&XLp��e0�ق�&�`�	VL0��(��v���`�	&�`U��`�	�C��*��:��|�� ���`�	&�`����Fp�`L0�L0�L0��&�%FL0���	��L0�L�s
6/��(���W�������(�/�����Ĺ�١[����?���r��џ�G�������G����7�7����g�W�ΫV���q�:���q����71{�ݧw-�ʣ���j<\��꿛�>�����N�3�i7�7�'7���M��Og���^��h4�������&�G�;�w���t�<�=Y���������/�m��.6�t�����Mo�����7|3~�曋��?5ZË���n�����֎`�d4j5>uO��� n� �W����>r��#�Yn�Z>A{�e{�i�sG�����xx��.N�}��'��O����y�\~��[8t��]��ɡ�㘵W�����]n�i|�]����͋~k������Y������P5�ζ�a��E0���<������	:_�a�����I0=r�-��Y��s�nzضw�NV�����3|�ܾ��l����}��6�m�;�F48����@�{`�u���w��7�����^�o���O�X>��G�7���O>��mL_���˩��Ss��l�_�ӟ�[�F�Y�{<h^��NG��y�Pb�'�f�}Y_ތG�ǣ��L�Ӻ���<��U�lW޲Sy�n�-ި��;�mGm��:v�f;�kGm��>|�|���/��)     