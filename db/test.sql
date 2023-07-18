PGDMP         6                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 146, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    27828    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    27830    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �      x������ � �      �      x����s���s�Wd���L� 	aoo�^{��v��D¡���n3�����(�E/|.Qx����G??�G���۷O.�����??ܖ'y�}��dv[���UKR�L���n:(g��?�5���?�Z;U����j8���w��<��[t��f�'�>-�Ӫi��M9�;^Onf��Ï'�G?����'U�ޮ���|2-��>m�m<On���|:����+�=zU������S�tw3�ϖ/c6�ܭ��,�?��z=Ӑ�����!;�_�i�����t<�~mߪᶜ�^��գ��Y�?7����?r�OkOޏhg5h�ոtVo��zw˷��?�yP�[t{[T-L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�����+�rGmX&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&8^��D9�#7�
L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��	n��|p�j0�L0�L0�L0�L0�L0�L0�L0�L0��@p!Q�����L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��N�7��EpgA��&�YGF���� �=�n+a+a�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�;\Ȕc8rê0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0����M�%r��a�rj0��^���r�a��	n��\O�`��*ص�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�%�1��V�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�#��k�uF���� ��n��"�6	Nz�0'l%L0�L0�L0�L0�L0�L0�L0�L0�'��rGnX&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�(8�X��-�L0�L0�L0�L0�L0�L0�L0�L0�Lp��ܰ*L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�?�	N� �|x�j0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0���B�ÑV�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	n��4��	p�Lp$��`��*8Q�	�Z�U�q��Y���*����ᵈ5��"8� ޺pԀ�!&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&���	.��1�aU�`�	&�`�	&�`�	&�`�	&�`�	&�`�	�Pp$؝�n�`5�`�	&��&�Y8{:Vy3��y3���n��_|`�	&�`�	>�a!��]J#���.� 8n�i��a�O8"l!Lp[K�$8n�a5��8}��ȷ,��6,"���7������k`���qL0�L0�L0�L0�L0�L0�L0�L0�L0�Q.D�1�aU�`�	&�`�	&�`�	&�`�	&�`�	&�H��4��SYa�O8A�	��;�q�&�`�	&�`�	&�`�	�M� ��,���}���DD��3���߈�*� G�)�|K�r`�mCND!�`Qr Gx�%0� G�e`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�����ܰ*L0�L0�L0�L0�L0�[��I�8�!���	��s��K1"�����jAp��-#r5���
�{{�BX�'�m �j�L0����(8��~c�&X���*�_�pJ��I0 ���qA������=� �>�e[���o�+`�����O��]]� �����8�����L0�L0�L0�L0�L0�L0�L0�L0�L0�Q.d�1�aU�`�	&�`�	&�`�	&�`�	&�`�	&�H���Ľ�	�[�Lp[��7�`��*�:�`�	&�`�	&��c��k����#���ik��V�	n��"��W�@p�� ��!	`��\���g ��ioK��` ����`��܆o3 `��}2�L0�L0�L0�L0�L0�L0�L0�L0�L0�[.d�1�aU�`�	&�`�	&�`�	&�`�	&�`�	&�`�	�Pp�[I0�j0�L0�L����o>k�lΚ	ϧw� �L0�Ǖ�A0��N�[�%�_p�|x�a_hdM��	�E�~�� ��e�r�UpX	nL�?"8��~�\���ਯ0� �C�L0�L0�L0�L0�L0�L0�L0�L0�L0�[.D�1�aU�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&���
nC��2"�X���F�;K�`��	>�`I0 G}%`�`�ا8�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&��c\�c8rê0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L�w*`�������F\��߈�Z|���0� [CL0�L0�L0�L0�L0�L0�L0�L0�L0�L0�G'�%�p�Ua�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`��\H�c8rê0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��
.$�1�aU�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&��x��ܰ*L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��Dp$8m��F���a�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	�Vp!R�����L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0���LpԂ� ���Ӕ`�#���ua�O�B�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	>j��H9�#7�
L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0��]	N��� �A���2����p�A�kApD�Êp#`���@p�JX&���]� �`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�` 2  �	&�`�	&X��GnX&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	n���<�&������ay\j0�m�	��`�[*�:�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	>j��D9�#7�
L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�;��(���
V�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&�`�	&8Z��D9�#7�
L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0�L0���x��?���,���ӿ<�痸������F`y���j���Oe�3��m�����p�����Cr��λ��<�9M{?.�M���7�x��zS�V5��j<\���_/h��{w����&�,7ݵM��o�k��W�,^�MY���6�ޕˆ���Q���\m{��L7��u��>@��zv�U�n�<q�W�wVm~x3���������Q5��e'����o/<���L{e�v�4�g��WM�����f3�6/�����S׭�����gVwM����㫫��y6HGg����׿���W�Yr��'_�4w����<uݧS�\�Mݰs�m�Y}��u�n�)�ߜ�ɨ�w~��F���O��T%��ϝm�8c�ƌ�*�O�����ٞ���t��d돯O�t����+w<u�yz���UӶ���m��������;��m�jK��ڞ;٪��i��闃���m9�F��:x�ֻ��&���Ͻ�︶���z��0�c�����	�a�S�⅃W��W����!k���h]���
v:HF���|���a�ݟ^/�^`ގ������j��y����6=��{v��o�����Tf���k��*7P��E����˗/�V���     