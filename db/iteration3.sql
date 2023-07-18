PGDMP     9    /                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    30525    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    30531    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    30533    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    30539    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    30541 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    30525    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    30533    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   _       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 149, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    30544    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    30546    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   �  x�u�ɭ�0 гӋ�������_�pQ0���ͤ��� \�7����u
����B7��Mg�@��%�=Z�@���^�E��.��n�B���Ȍ�S
+��_/<��+��#��{Y0r���w]5��O5&�)R ,�j9W�3cI�#��cLE�����M�ʾ![���R��.���C0c#_�CJ��͇�#%�Q�&�W�^�8�^!���5��"#'A5����5Vj��ϭF�BSFɏD=�UϪ������c�}2�;#.� ��D��ʩ��s�Zi5gέ�P
KI����*߁��H�}� ���ڵ���1�d6�Z��E����TO�P�-��to:+��F,"m�$	�0�ܱ-V(��T�c}3��St�X�Tj�k+�8�r+,Ԡ�d;ݷ�^��I�,�JW]��ߧ��N���{�?Q]��qk�N�2�h��[��l��oy�^� wA)�      �      x���MsWv ���W���L�,���K��b*��,l,(�1�HI����@"�lP-4�~���%�������q�?����Go��\���o�gG���x������l~z�䑛�������������c��Ńe���;���c�ܻ�/��?|�2�<�_}\<�c�������������f����ϟ��n�������Ç��_?/�t���w��_?���7��=�������G�g�w7׿����.�8��]~����s���z�����\��n�?����������?}i��,_Y6yҠɓ�M�4�擖���������[�]<�yv��rv������X,�����k�&T����.����~���ow�k�z� �p�|��)?���[�����ӏM7�t�Mw��kq2�#��馛n�馛���Hv1"{ײWW�򜢷�;L��"v����1�\t=i����ù�f���ud�M6�d�b�H6���M6�b6�d��d�A��l��&��ld7�Fu����]vZ#��v����)���:?�r;��m��Fm��F;Eڪ#h��v7Q�$��f�w��ދt�}�ݤ%t�}��Z�%�xG���>��>�n�J���nw
	�t���bV�;��Ʊ����w���n��׽����to>���6��:�/�kQ;1�i��!��]ɮ^�ɾm��n,{���[Ij؄v"��5��&r�M�!tkLw�t�L覛n�馛n�$�އ�Y��.�I���Q��|d6�I�L���'\s���3Ǹb��m���6�dk�J6ٲ��~�4)+��Ξ��MvL������l�Ȏ)�E�]���V����&�l�� [q��>�6IvLٲ�c�V�&;�l�l�N�fMtӝR��n��n�w����f(����#��G�Z����M7�t'�[fBw\ݵcJM$ᎀ�6r�w"�;�I&�a`��l!�쐫J�<��k����
W��=ݶ}�7l'm;�nh���s��n(;ùv��>�n��n��;?�2�����NZ7�d����Q�`��4��\sm-�II��&��V�ka;���e[�GvL���&�l���G�<���d�<MC6�d�M6�d�A����,���u1A��i+��S�IH�cʖh�S�6M�a��MS7Ӑlڇ���a����馛n���];��b�����tӭҍw7�5�;$��6�tw��&�l���d��k��tmW;ى˞n�=�m�����x���nU���(Y���;�7�!ag��O�f;f�&��;%�&�id�M6�d�M6�d���l#H��,[=�옲�iIvL�b6�1e��dǔ-f���lU?��&�l��&�l��6I6٪~d�-f��O��l�c��Ɏ)�$�1e�Fv$���(��5,�����GvLق6�h˴��m		�Ai����vm��7$؉���n����n���I�m�c�Mvn����ߣ�g_����[��d���mo�"�6i܉]�1�Sn�͌$�tBw7i	�t�M�\&�q�mw$�d�l�M�3��&[�&���l�cʶ��>��Ɏ)[Տ옲� Ɏ)[�&;7�j#d�M6ىʮ[��6�h�M6�d�M6�d''[A��>˶p�l��&;�&!Ɏ)[�M6�d����J�񘍠�v"���@m�H��F�iKH�J[�S��$1��n�91�����(��5q۽�ܛ�E��f�n�����{���Z�l��&{+��m�Ej:�vʴ�ԣ��g�Y_��i�Jwv��ɺ馻����L�;mܙEm��V$�l����f�ȸ��l�ӕ-f�Sv�s6d���?����&�թ#H���-f���l���&�l��&;�<�v�b?��]�����dKG�&�l�󑭠M6�d�M��dǔ-�&;�l�X�&�l�.������h��6�h��9�ˢ
;k�N�vf�?->�n[K=���� �t'��x� ��J�Fm�s�m�� �=LvT��m�Fv�j[k&���n�x�n�閗��o�$юI[�&�l@�{ [6Bvn��G�M6�d�M6�9��d�S���d�Mv���o�P�aϯaQ�x�����L\tm����UFȎ)�e��Mv �b6�d�Mv>�� Ɏ)[�&�l���Gv�l��w�?����^��u��&��|d�7C(�#h�N[�&;�촖��M���d�M6�d�M6�d�M6�d�M�nLhG��=$�Ai�M6�d�M6�d�M6�I���f���yh7�ݮ{^7k�����n���^���{��c�g�rn��n�&;�l�l��$�ly6�d�Mv��S���M�<�l��F�&�ahh�-h�S�D���d+��M6�d�M6�d�M6�d�M6�d�Mv4ٖD��g�� Ɏ)[6Bv��+9F����v�������zث��u@�r�=ʮ;�콜o�(�5����������n��f�6�	���J�YԮd�_$c��Nض��6�h��*���mNg��@r�6ڍh��A���6�h����m[CBvodE�B�t�6�#�c���v���Y#E7��tKL���m�c�&�l��&�l��&�l��&��e�\�&��}ˮ�fSj9�v��m�c�v��1eB���l���&�l��&�l��V!�l1�l��&�l��&�l�� �&�l�ɶ֏l�-�F�w��_IvL�m�s���GvL�/cv%�F��T��MvL����ڳ�G�N���MvL�)G���]��S�c;�&�Ɏ){����d�����G��E;ڣV���;��m;Ev3��JW����aJ�5҃;p��H��6��vۖ������c�n��L�&;wٵ�~��N��t�l��&;�)�D�M�u�d�-!�l��&�l��&�l��&{��j#�D�S���1e�/�h�K[�MvLٶՠ���M6�d�M6�d�h[�JvL��jȎ)�\ٹɖg�M6�d�M6�d�M���d��d�Yv��l�=r�]�@a��=Fݷdꦜ�aי,_1�P��CC&�#��:i�[�;��n��tӽ�d��b�k�&�����e�HE@� �Jm��Fm���6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M��e��3�l���@6ٲ��&��\e��7�)�)���&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��Nu���bdǔ]1�([�F;wښ聝2lM���;bw!v�Awm讐���pkIw\ݚ���#�)�J�Fm��M��d�m���eC�M6�d�#[6B6�d���l��d�M6�d�M6�d�M6ٻ���6e��Mv���l��&�l��&�l��&�l��&�ϲU�Ȏ)[�&;��1���l�3�-f�M6�d�#۞��,�y#dǔ-f�S��MvL�b6�1e;��옲�l�c���&�l��-!�G���;��Z�U�v�n�l����������B�R���h��v�)	�hk�6��Ѷ����%$hgG�0���Em�{M����Ql�o�8���U�����|do�m��lA{G��%�h�N�N�s�-!�l��&�l��&�l��&{����dǔ���1eW*�_c�m�s�m����dB�M6�d�M6��l��v�6�d｠]X��v��m�c�6�NvLن�d�M6����&���f�RZ���&n�}@ݵǘlt9�c[�$>�C�	�h7��:E��������p��n�Ɏ+{��Wd�U�6ݎ�F�j�h���x��Fm��F;gڶ����
	ڽ�]I3��]�e�/bQ/�x!�����L`�[�-d�F�<�l��&;��!��ly6ٹɖ��M6�d�M6��l����&�l��&�l��&�l��&�l��[��T��&;S�b6�1e�,Fv_d�+�uD�"6���m��1e��d�M6��ȶ�옲u�;e��:֘��;mޙ���>D�ŭ��!t���ň�Nt�5�.Bꖕ�Kvo����tG�ݢO�Z	�I�ά�M6�d��k�:נ���M6�b6�=�-f�M6�d�#ۢm��&��d;\�l��&�l��&�l��&�l���lU?��,{\'���h�N[�&;7�m��&��|d[�Mv�e[�Jvn�e#d�M6�d�Mvyv%�^`35dg/[m���d�FȎ)��:�}�-f�Sv��,�F;wڂ6�1ewS�� �f�slI #  7݇�]�4J/=�C�n����;Ɍ�]N2٩���u��
��G/XMY/?$�QUע�$(�5>��·�yH�S�=j�n��ƝYU�l��9Q�$;ک�޾3�|��i��N6�d��ٖ�����M6�d�M6�d�K�]�dǔ��MvL�b6�d�M6�d��C�m���ˮ�����v��b�����>�]7�\w�0���V�#;7�Əd�M6�d�Mvy���h�m�ٹɖ��M6�d�M6�d�M6�d�M6�}���G6�d�M�l�옲�Yƪ���`��-V��q�<��Nw���C���w�>c��ͷۍ$�\sе�6�`����}!�9Ng�6ڍh�z����6�h�H����}cH����4����ɎY!�l��M��M6�Ne%;�l#H�s�m�/�d�M6�d�M6�d�M6�d��g�fj��l�l�cʶn���d˳�&�l��&�l��&�*V��V�#�ϲe#d�M6�d�M6�d�M6�d�6R���?��l�s���MvL����Sv71[�����C{1��N\�	�xwD���v��v;�'\sеD�Da�����:Ѷ�z硝2�e�n���F{�5�E;m�o�l�Ҿ1����<;�d�,��M��M6��l��&��ز�u��R��v��-d%�l���G��t��>�IvٍW�Nh@;a����&�l��&;�D�\�d�Mv
�e#dǔ��v�N�Bm��Ή6�d�F���dKG��mQ{W�W��Yɶ�W�N��t�l��&�l��NNv�<۞1�cʮ?����S�]׋I������h��6�h��6گ��o�lEm���Uy���u����v��k�ik��6�iLנ��ڥ��(���$�CEt��,!!�l�#�޸��dg![�> m;"�J�rV���m�� ��&�l��&�l����b�o�;�	��Ɏ)[ݏ�>�6IvL�b6�1e��d�&��l��&;Q��֠�#ږ���k��#h'M�l�c���F��
��'���i��A;;�jh�M6�d�M6�d�M6�dk[�6�h��o�d�M6�d�M6�d�M6�d��T�t������2텔����:F7݇�-vӝ��6�"5�<y���o�J��ޢI����Em��F�hKH�Ύ��I��Җ���k�N�A;;���F�Ti�MvodD��g�ݬn%�l���&[�M6�d����f�ȸ���S���x�{Dے?�{M[y��i+i�M�iH�{ [�&;iٹ��6�*h��6�dǔ���h��6�h��6�h��6�
$d�M6�}�m5+�1e��d�M6��ʞ���ګ��
�ʭI	v��L����N�v�Q��n�����m�Fx���;�n��);�2 �`����M�Fh��v��k'Q����;�vP�"A;;����F�Ti�Mvodb��d�*[�&;�l1�۲7��N� b%m1;i�F�d�M6���vh<�h����d���k#��+��=Dl��n�:���h��Sڕb�hǡ-j��6�h�K[�� ������,�`k`�7�b6�dG�m�/�}�=��-h��;mA���dK�Ɏ)[�&�ϲ+����h�K[:B6�d����鶭"�?@;e��2՞�Ph�Jwݵ��n�Sҭ[$�Q��6/���_��n�;��'`����$\s��k�m��ME�9�U�&����t���dm���6���m0�6�h���'��F���o�l�[��C�����}����u�v��I�`��v���M6ٍ�mm��wf��&���v$p���]w���k��溿�u Cm��lge;�#��&{�Q�<$�I�ά�M6�d�M6�d�M6�d�M6�d�M6�do#;��d��K��fj��T�l�l��&;Y��m�F���y�Dh�I7�tӝ�n]#�#�c��v1�dgr	�`�d��W�M7�)����n�s�mi	�x��6�h��9��h���$�t�h�-�F����L�e�vҮ�<�5I�n5s�M�Ͷ�}��m���q�ag6�l��;�-�\s��kl���E�>l]��v��vm�S�Z����YH��Ҷx�&��V��*�Q<����m��6�d�Fv�d��v|ͳ'h��.mA�l��&�l��&�l��&�l�����$;�-�|V���v�0�h�dg%�M�H}QS�]{N_q�n���>�;J�'`�����DW�9��e7���h��v:��F[�Mv[��>P�rk�r��a��m��@��?�#�~��Qt�]��9�ý�M�t��X��覻Fw7cJ���馻�n�J���YZ�6�A��Mvڲ�ܙ��`��x~	�zף�����밬kU��v�;a�\sѵ��Qm�F���������I�u�������;j��]������o������u�x�w�h��6�hgD;�"7�dk�D6�d���)�$�l����鶭$;:n��l7����V���;�Nv��MvS�;o&	7�p�KJ��t'Y%i��o�5�%(��}@�f#�Fm��F��i˵�J�������v��e$hgGۂm��.���Mw\�)�%p�����)::lgs���uH`[��馛�H���K�[즛n��;���pÝ�A���)�
v]����a�Jn��,+�v���$��t�M7�y�n7��ŭ�Mw�fp莫[�;�n��;�D�7ޝ�&��ҝ�n�����m�c��,%!�l���&�l��&��\e7˳k����d7o29���G�����]>�����o��#��X޺՟�����]_����_>̎�/.�֏�mvv}u�����N�\LFoG÷�h���]9���y7��_~���UZ�*OZ�V�����OK�G����xX���+?�����&��,?��lv�����bW���������E^��/�͋�����d�zaq|�z���{ss���?������������?],����qy~1����9�cg7��f��x�p��pG�o���U���C�G�7���7(��w��_ZNV�-^�s��//ߝOg��ɮ��`|�a�Woqˊ�b���ݺ��u�緮�P�u�iܳ��/����-��o��[v9�z7*.N���..&��ߵ�*qw_�ы;����~�=��߸��������~�ʓ��/�p�N�ޝ��g�ӳō���Ε�r�ڝ[ܵ�ݸ�����W����+������w���6����W��"�y7<=>��}x���_�b�%Xk={�����Ï���yxa�+��W��f�޳���3��W��ǋO���f�����=��׬���֧�|��߾;+.�����G���ͧ�_���糳ٓ�/��f�H��>�1��敃�_9�����^����P߼P�م�P�.�ȅjp������_�����_:��     