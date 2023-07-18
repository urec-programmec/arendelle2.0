PGDMP     6                    {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
       public            postgres    false    202            �   �   x�u�K� �5��1؆�#���?G�gS��K�fF�,?P`⒨%�Mv�^���jn$$>3/�Cu��ivg�>�?WO{Q��0U��eY��ȹ��,}���pD��5�x�?jc�����ɰv}s����>�      �      x����s�V� �s�W����*�����3�=L�l�d�r8kK.I��T*���i	�Р(�n|��M�����=t��O?�v���������iv�ﯪׯ�>�N���r9���|y2�Z�6���_�_/^������������^_~�-�����������+?T������s~�|u���:�]���xq~u}����o����_>-�t�<��٧/�t�������_���j~q~�������ůY������W˳z�?Ƿ��7���x�������4�N.>��X��������YYo��&on���i��_^�/.�轋>�.>}�]��vws�������\o�!�7�����.����~���ow�k�r�0���<��t�R'�?4^��h����Mv�6��i�m		��iKH�NJ[B�vR����C���H��`W#��.v��j�CH��.:b���:��	�\���:�d�Mv����)��#�9e��d�-f�M��l��&��0���#�ϲ� Ɏ&[6B6�d�M6�d�M6�j#d�m�l�U���l��9e�[e�h���M5d�-!�hٵ1$�}�� ���v�G�?"�&���d�^|V���._w��V�M���${y��\�ص	�9e7�Ox�BBv1���_��vB��[z�h'�-j��6�h��6�h���nh��^��v4�z���!�\�p�ӈݚ��Iv!������:�k�Ba�IvN�v���S�R6�9e�F��)��qQ������MvN�6��M��d甽E�]{.+����&�l���V!�ϲ�B��S�l�윲���)[6B6�d�G���9e��d-�{�����VAm�юD�(�����(����P�V��Zs��.D��J$��.3�ϗ�e�i�f�5�E�6YCvᲧ]�B���]��h��F{�Em���6ǎvR���Җ����������c"{���7�k�#�.h&��'��vѰ�r͵�#�d�M6�[�V�#;�l�4d��QQd�M6�qd˳Ɏ&��i��&�l��&���Ԑ�g٭]��	�hG���GvN�&!��)[�MvNٲ�s�6	�L���Vd��9�	iڥ���Fm�#�6�D;)m�6�h��v�ڟ�y`{�Ɛڌ���m�嫋�-js�3j�MvJ�{Z�7���"]��!�p�Ӯ�!�.���K��h[��D����ݾ#�f���m���mI6�LB�M�-�d��Ihd�M6�d�M6�d�mI6ٻ���MvN�� ��)[�&;�l1�윲�l���V�#�l��&�l��&�ls�d���G6�b6���-�&;�l1�윲�A��S�l�윲e#d甭�GvѲu��;m��K�-����-!�lu?�{ �5�ֆ	�B`kI7ݻ�}7�E�$�vzؽl櫨�v��m��)dO���d���m�G����T����m���m��d�Mvd�FȎ&[M�윲�l�s����)���,[�&;�lU?�s�6�$;�l1��h��F�&�l��&�l��&�l��&��>�V�&�ϲ�!�l�Ɏ#�$�9e˳�&�l���n�w��hG�mIvNن�d�M6�qd�F��)[q�l��&;�ly6�9e���Z��� ���({�O��,y�6��l�_�[��N�Z�M6�d��I��kOHe?����Mvoe7�y��Ɏ [KH��Ҷ� m��GȎ-[�l��&;��Ͳ�q�	�d�+[�&;�le?��,�\�9e��d��:UcIvx�b6��d���M6�d�M6����9H��ЎE�m�!$��dKG�&�l���V�&�l���&��X��)[�MvNٖ��M6�d� [Տl��&�l�Ɏ�g�.���A;<mS5d�m��윲��Ȏ&����k��F��n�u[���RmQ;m�&;��i�ƐJln[Q�l��.Y����>��2mA[�&�l�?�{&[6Bv4��!�&�l��&��y6�d甭�G6�d�]���[�k���kX�î���a�Ή넮�Ӑ�A���9e?��C��N [�&�l�Ɏ#��윲�l��&��8�7�Fy���=����ͭ�M6�dǑ����������MvN�e-�#�le?��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l���i�/ۅ۶ڏl��l�˖i��S�f1�l�sʖg��S���dG�-�&�l�Ɏ#[Տ�>˖g��S���9e{ �Ii�d�-�&;�le?��&�l��&�l��&�l����aW�����jS�˳�k��2d[Ev�e��$;�l���e7r�"����O��v��#�O�W��uB�r��#���윲��E�&[5����bC̈́l�˕-f��S�f1��Q����F�\ڂ6�d�Mv��<�����Ր�S�t�윲�!;�lCH�SȞvmi	w�-�"�'�%$d�M6�d�M6�d�M6�d�M6�d��M�z6�}�ݺ���]��m�sʶF�윲!Ɏ&[q�l��&�l��&�l��F�&[�&�l��&�l��&�l#H��&�l���#�l���m��$;�l�6��d+���S��݈Ĳ������){�<��ڊ#h�L[�&;�l���&��l�ͯ��S���9e�F�.Z�m��Ҟv�	7�E�V�&�l��-�;ڽ�m��dKG��){�tdB6��e�n���F�`����&��8��B��g�ֲ�M�l�l��&�l��&�l��&�l�!�&;V�o��]=���vأG��Ma/ϒ묮ۗ���l�˥-�&;�l�j�NJ[�&�l��&�l�#$�V���S���s�.k��l���d�M6�d�M6�d�]�RՏ�h��l�s�V�&�ϲճ��)[�MvN�b6�9e˳c�^]��{����w�l�US�US���D����Jp'���M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d��m�6�}�m���d�F�&�l����bǘ>Lh�L[�&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&��ڶ���Sv��lA��5�#�h��[�ɴ�NJ[�F;)�֠]����`��z�=��gr�C�+$�Y���6ٽ�-�&�l���&�Y��)�;��dA�M6�dǑ-!�l�Ɏ#[6B6�d�M6�d�M6�d�M�s�FZ�0M�&�\�b6�d�M6�d�M6�d�M6�d��g٪~d�-f��S�����H6�Ae��d�M6�qd�SCv�e{��9e��d�-f��S��MvNٞXIvN�b6�9e��d�M6�qd�F�.Z�3wC�X�`��rD�<�7��l���/�hoN{�+$�)u[�Jvod����M��6�d[�G6ٲ���6�$;�l1��>�n}RT�QQh��mIvN��~dG�mIvN�[$�u�6��i[�Mv4����&�l��&�l��&�l�MB�M�cd�Sv�r�%f��F;:mS5dG�mI6�d�M6�d˳�&������VH+��O[�&;�l��d�mI6�d�G�<�윲�l�s����)[m��ew�)h���vk�]횶�ydo&{�ΐh�]:���ΐ*$t'�mI6�b6�=��@B6�d�M6�d�J���d甭6Bv_d7r�"e�k���kX�î���a�Ή넮e�dg�-�&�l�Ɏ#�$�}�-�&;�l��d�M6�d�-�&�l1�l��&�l��&�l��&�l��&{�U�F��l������)�^1��"�^1�3����l�F��)���=x2��m��<��<K���Ɏ$�H�sʖe��S�Y���W׸Y�(�{&�c��M�~��b�����.jW�n��#;e���nKʏ�$9*��D�T�mA{S�[4�4���h���d�M6�=�m��9e��d�-f��S��M6�d�G��#d�M6�%��0��&�l��&�l��&�l��&�ϲU����q��j"h����Mv4�m��&��8�-�&�ϲ-c%;�l��d�M6�d�!�nd��6SCvx�j#dG�-!;�l��d�Y��MvN٭#ȺF��m�s�V!�l��~q�ݻ�X�vR�1�]��=��p�u��[YW��E�{�%���n�aZe�=ڢ%$�1q��~d�Sv��t̯���t�윲MՐM6�dǑm!+�Ii�d�M6�d�M��dۿNvN�
�d�-f�M6�d�M6��l��Ȏ/�1.,2f�k���kX�î���a�Ή넮7�\��a���V�#;�l�G��& Y  �l��&;B�m$�Ii[�Gv4����&�l��&�l��&�l��&�ϲU��&�l��ɖ���S�e�d�M6�/.[GH��ބ�cd"{OC�1�\'t-`�6�`w�=���st�.ܶ��d�=!�lO�#�l��d�F��-[6BvN�b6�9e[�GvN�F�dG�m�/�d�M6�d�M6�d�M6�d��g�fj��l�l�s�.k��`�zxG��G�`W��^�%��\˲El��&�l��&�l��a%�l5?��,[6B6�d�M6�d�M6�d�M�s�FU��	O�&;�l�l�s�.k��d��d�m�찲�:�)���vg�o��ց	�g#۹>�넮��"`�6ؽ�=��Re���m�['�l3�d��-!;�ls�d�m�윲�l�sʖg�M6�dǑ=n�]�m�˥m+�d�MvُӑF�l��4�7^8RY9�v���#d�M6�d�Mv�D�\�d�Mv	�e#d甭��l�W�O�t*�_�v%j��9i'���:�]��d����W�b6�9e��d�Y�=�dG�-!�l��&�l�#�ٶ���Sv�s�A;<me?��ɖh�M6�d�M6�d?%[1�S����Ki��uiD�{S�Ӯ-!Mհ]�m��d�m�����!��)[6B6�d�M6�d�W���d甭6Bv4٦��&�l��&�l��&��-����hL[�&;�le?��,�$$�9e��d�-f�M�$�d�Mv��5�D;)m�X�&[q�l��&�l��.Hv����u= ;�lS5dG���G6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d���Ӯ=!�ce�p����M��Mvz�Vh��S��MvN٪#d�-f�M6�dǑ-!;�l��d�-!�ϲ=K��h�e#d�M6�d�Mv�<��윲�b%;�lk�Ȏ&[�M6�d�G�f�ȸ���K��%$�Ii[�G6ي#d�@��6�9e��$;�l1�l��&�٪~d�M6�d�M6�d�M6�d�M6�d�M6�d�M6���m+�9e��d�M6��ʞj	�vR�vՐM�|�l��&��e�~9ث��x�ѓ$%�p�u_v�E?��N	[�M6�d�M6�}�m���>�����ɖ��M6�d�M6��l����)[�&;�l1�윲ճɎ&��l��&�P��A�����d���k�w<�le]�z 	v4�߶��X�Ж��f�ݗ��Ī�d��m��l��&�T�J~d�M6�d�M6�d�]�D��~d��=n�-h����Mv4�m�s������/��cA�riKG�&�l���=��Ҫ(���ݽQ�3����	�IiKH^�v۞�
�LHv��W�1A{ײ����v��_�G�p�uѮ%�d�:���GvN�j~d�-f�M6�d� ��l��&;�엘�!��Re[4BvN�b6�9e�n������6UCvN�
�dG���Gv��ZB�Mv�ő����zY���`�6ػ���)�h�u�����M6٦ �-��j6�d�M6�d�M6�d�M6�d�M6�d��E����"���L�Ae�F�&�l���=��R>�vѶu�Dm���m��NJ{�q丛l���.vטM6ٝ+`���6�d�Mv ي~d�-f�M��#d�M6�d�Mv�<��윲�!;�l1�윲��d�mS�9e˳��)[�MvѲ�w�Ї��eA�6�`�d$�\�Z���~���lm�l��V�&��M@��S�l��h�m�!�l�Ɏ#{�l��w|ɳ'h�].mA�l��&�l��&�l��&�l����i׆���,��ڛ��b%�nh'�-j��	��=m|�ѓ�1(�UQd���w�k�F�l����.ў�v��� �N	[�MvѲ7�E`�F;m;���m3�h'�-!Am��.��%��n����F;>mQ��iw�G�m�mbG;>m�?�s�6�$;�l1�윲!��)[6BvѲ�m�$�e��v���[�u��Xػ���cd��k�:T�]�l��N	;��tTF�V�&�l���&��K�j�юN[�&;�l��dG�mO�d�M6�d�!�&��h��l��&��8�m�$�l��.V��k_�==KG��7�n)+�h��~������i�y�vR��%$�m����l��o�u񮿵�tA�5> ;i�։	m��Fm��L[����ubzA��w��ma���{#�B���tA�^ˊ��������k�
$h'�-!A;)m		�IiKH�NJ[�Fm�юD[�H��l��`��6z`�;ܳG�F;)m#H��ӊ]I����֠�����vRڢ6�Ii��vV�2��Ѷy̾H���K�-!�7��l��&�l��&;B���Mo����&{�N���~;8>=�_/�����_N����֭�|wn>�����_��������`���g'���|���O�d�z4|]�F����?/�wv9�����X��Q���r��o5?]�??���}��ϟ��������ǰ�c0��1l�m�z��d�g�ӿ�z�;��������_������\>:|���z}�h�:��9����/��������'?�?���lq����ӳ���?>������v��lV>u�no��>u�F�v���_��5~��ƽ]_�?`0ZyS9Y:�ʍ�e��Û���>;z�7�{����c�Q��捞��޹�]�Ν�qˆ�'o�p}�_��}���Ug������&��'�k�{UM&��e=�e��������й�;�>~������U�C��e;�|srZ���O7n��w��ԓ�ݹ�]{�7~t�n�]�����}����o�k�߾�T_�e�������xv���vs�'�����_}X���o����큍���7�X��g�?�N�_��.�x���B����/Y�t���Zg�ez��:�G��KV�%�Ǘ��}�]~��Nf�������"��򞻬�ˑ��G;9�v��/�B���P�]���م�P\�߿���������FB�     