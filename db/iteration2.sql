PGDMP     1    8                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    29809    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    29815    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    29817    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    29823    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    29825 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    29809    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    29817    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 134, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    29828    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    29830    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   4  x�u�Mn� �1�K�1�����5���8b�O>�8V�B! ���h_`S��������h�)glqx?�����f�Y�ڋ2<
����jSEn4��:N��~+�����ʣu>Q_m��Q��n�}�=W�Tc�"���+����%X�����`¨*l�jo�l+C�;">��,�(<�%ŜFky�H^�����HΑ�%i�N+�HUoJ�}�Jz����K��,��s��ДQE⑨Ǻj��i,��ż�`}3^�O��Ɉ+A\�1�E��ơ�晢�ZƑ���V
GɎ|Am��S������      �      x���Ms� ��+T�KR%˜����mr�Cj�U{�y�HPfV"U$������ 	��8����v�s	%@���~���껟~�����始��������_T/_\��������������z����c]��f�`]?|�?Nn���|��է���~:z~�n��Ճ�?���<?[>�|��]̯֯�pyq}s���n�>���|\��p��o�?��.������_�_^<|�t~}su��_V��z�������zw�?�w������x�������Ǹ>����cu���_��y����<i��I�6O�|�I�g��������[�]<�q~����z�����|���8���6o���?�]���E;\]��կ~���n�_���/�i|�x��6|���F;4�Q��jߴ�d��N���{u�������M�s��'-�����-3�;�n���u�$���M�>e�v0Y�L��\��z��=�넮g\s]�k�d�M6�qd�3I6�eg�d�]�l1�윲�l����M6�d�Fv���&��l�e#d�M6�d�M6�d�]�Rm�윲�l���]+����|�AО6Ү�f;�mkvD{�Ko<�"{h	I����'�ϯ���]��0�k	0��Cw�Ӣ��K�-t�Mw��GX�Mw;ݱ����=�6�NvN���xfR��bd�|�c�Z��vci�I��`o�ߣ��Ͷ����'��l��h�d��t�M7�tǛs���}��d��SvcF�z�l�����.b��넮e"`
��d�� )�s�6�NvNٲ�s�n>Eʂm������)��1�����윲�H�kǵ�]0mA�l��&;�l���,�,$�9e�F��)[A�윲e#d-[�&��VA{�Em�����#��?v>k]�k���f��!ڎ��l�[�_������(��.YwcfB7ݥ��V2쌰�l�S�$�x4+�\�ٵU�d.��k�H�H�.�v�h��w��Dm�j��Rv��v��~�"НW�̄e&t��-3��h�d��Rv�����h�o���Z��d�M6�[���G6���&�l�H�M6�d�-�&;�쒧i�&�l��&��!�6SC��e7���fh�����9e��$;�l�6�9e�F�.Zv��Y�B����|���Em��F�H��F:2�얲��C7�yuKK��'��T��Rd�t�]v�l��;�ҿ�\�ڔم�>��1�m������IeoU�k�Y����7�)a�k9&h�mw$�d�Y�J6�E#�l��&�l��&��dA�=d���d��K�s����)���=ZîZ<�]�����\gu-b�M���d�M6�d�M6�d��$��5?����&[�M��d��d�m�윲e#d�-!;�lU?������h�X�6���V�C;?��\[kH�K��5$�t�A�k��.��-j�]2l�m��Ҷq�쬲��v�d���mw��OB���-eoU 1%�wټ����n'{���H�vѶ�&�����V�&�l1��!����)�N��,[�&;�lU?�s�6�$;�l1��h��F�&�l��ݴ�m��&�l��&�l��.N��6�C�m��d�Mv�&!��)[�M6�d�G�F�q����vtچ�d�mI6�d��첵C�"�#Z{��Nv�Æ�F{��ɵюF{uO7ޣz�=��a7fں��]H�~�?d��馻s��9`��넮��&�l�;�>��Ғ?������h��FA��Iv��QvS9�i��\�{�v���G� ���؃�v�	��dF���d�Mv����i��d�+[�&;�쒫~d��|����&��S5F�d��-f�M���d�M6�d�!�n�����X��6B�M�t�l��&;�lm��.E�h�j	{�v���Sr�յ�d�-�&;�l�X�&�l�K���G6�d�M6�dGȳDU�Ԡ���y`�[�<��.���6�[�6�d;����h��6���n���^h��k'�-jV�s�0م�>���Bm���ݽ7$�h��6ڑh��#m��$�l�?��'[6Bv4�f"�&�l��&��y6�d甭�G6�d�]����k�՗װj�]=�]5�^}&��6OCv�*#d��8f��&;�l1�l��&;�l#H�s���&�l���n��l���`���6�N6�d�Gvs��Z:�vtڂ6�9e��ԏl����&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��ޮ'�M�lm[w1���юN[��v���M�L��ȶ��h���d�M6�qd+��=d��l�s�V!;�lg������MvN�m���V�#�l��&�l��&�l��&�l��&��l�-�"{Ȳ�A��S�l����7r�"g��5���kX5î���a�>�	]�E��l�G�s�.+!�l�l��*{�-53��.W��MvN��b�FF��62E�ri�d�M6�qdos*�1$��i�3W3;��=�x���1��*���-!;�l#H�S�>����qwo�gY��hKI�Fm�K�M6�d�M6�d�M6�d�M6ٝe�h�=dٍ[kj��O[�&;�l'ꐝS�!$��d+��M6�d�M6�d�M���d��d�M6�d�M6�d�mI6�d�M��~d�m�6ڃ���J�sʖh�M���9e?���X6BvP�b6�9e�˳O�VA�dڂ6�9e+��M6�dg�m~��eO��BjyJv;�[4=�'A�i75⭞D9)	��	�l'�+�G]DK^4p���Fm���6��vۖ��=���s��"��Mvtٍ;~+��.��t�l��&;�l�dY�E�dG�-!�l��&�l��&�l��&{��K���)[Տ윲��Lm�˥-�&;�l�j�NJ[�&�l��&�l�#$�ֱ��S���s�6WCv4��l��&�l��&�l��V�#�l1��!�V�&{Ȳճc�n겔v�.z�옲�����NJ[�S�K���]5��wՐMv˘�d{H�?� �Cm��Fm���6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�M��e��P�l��@6ٲ��&�쨲��7��%���&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l��.u���bd甽a�^v_A{��]��=y$�j+{�)��
[�<���ݽ�<��������R�]�]#+��.C�ސt�խ���]r6�h�=l��e%�l�d��mI6�d�G�l�l��&;�l��d�M6�d�M6�d�M6ٻ��4vc��Mv���l��&�l��&�l��&�l��&{ȲU���)[�&;���1{c�#�d�-f�M6�dǑmO�C����s����)[�&;�l1�윲�XIvN�b6�9e��d�M6�qd�F�&[�1��v��y^{]7B6��do�m�K�}�-$�)uk���h��������h��%d�-!;�lcH�s�����ƣ�*gE���!$�9e+��M�!$�9eo�h�5�hG�m��dKG�&�l��&�l��&�l��6	I6ٚ��=L����1{�6��i��!;�lCH��&�l��&[�M6���M���BZ��vxڂ6�9e�_';�lCH��&��8���d-{"h������ h+����v?Q[�1�[�~�b�>z��vE7�e�F�Ĵ���T&	�{u��>تט�d��bvx�2"� m��&�l�C˶ߗ윲G����H��v��5��aW�`WͰW��넮e�dg�-�&�l�Ɏ#�$�C�-�&;�l��d�M6�d�-�&�l1�l��&�l��&�l��&�l��&{�U��
�d�-f��S��bdE��b\gt-b�=�V���S��M6�d�G�]�d�-�&�h���0��Am�j�~~ٻo1���)t��t��l�S�^������VBwѺ��&�l��������m�����l1�l��&;�l+��&�l�K��d��&�l��&�l��&�l��&{ȲU����i��j&h����Mv4�m��&��8�-�&{Ȳ-c%;�l��d�M6�d�!��Ȩ��L��e���M�l�윲ͮ�=d�b6�9e7� �m������)[q��ewo��mM=�n){�Vc�������Э!�%��	��k��t�Ⱥ������H�K�=٢5$�p�;X�l��9S�4;ڥ��� ;  R>�vѴ�MאM6�d�mA+�h�d�M6�d�M�}�d��ǘ��Mv4�b6�d�M6�d�!϶܏���7ƅE��z���VͰ�G��fث��uB׭'ם7Lvx�j~dG�m�H6�d�M6�dGȳm�D;)mK�Ȏ&[:B6�d�M6�d�M6�d�M6�dY���d�Mv6ٲ�sʶ���ew��m�j�n)[gH���{u;Z��$���X&ۡ#wO��)�\'t-`�6�`w�}Ե+��t�.�v���d�LG�����"�Paw�	))N��-!�l���-!;�l1�윲�d%;�l#H��ɶ˗l��&�l��&�l��&�l���l35dY�z6�9e[7Bv4��l��&�l��&�l�ɶ��l�U���l��d�M6�d�M6�d�M6ٻ��lTA�xF6��e�g��S��~d�-fǔ�|q>��[B���){01�����hw����l=���s�����\s��u�Tl��{а��v�Ta�p����&�$��e�F��)��:�9e��$;�l1�윲��d�M6�qdO�dW�D�ri[�J6�d�G��td#}6	Iv٭�TV��]0m��d�M6�d�!�6WC6�d�]�l��9e+����v%j��6�h�M6ك��<BvN�b6�9e��dY�m�dG�-!�l��&�l�#��v���Sv����������dK�3�r�S�3�L�Fm������m���Uq��wqD��-죮}!Mְ]�mӐd�m�����!��)[6B6�d�M6�d�+�VH�s�V!;�l��d�M6�d�M6�d�]�&�Z�u��-h��S���C�m�윲�l�s��Ɏ&��l��&�P�Z�= ���v�Azc���:"hM�l��&����0����^�����V�#�l��&�l��&�l��&�l��&�l��&�l��&�l��&�l���죮M!�ce�h�#��F[�F{�-�F;)mQ�9i7텯�ދlA�h�b6�d�M� d�FȎ&�L$�9e�F��l��M�l�l��&�l�Ɏ�gA��S���d�m���d˳�&�l���n��L�`��!���B�= �V��=h�e�GFk�UKٓG��������a+h�d��${ ��l��&��d���M6�d�M6�d�M6�d�M6�d�M6�d�M6�d�%�"V�s���&�l���}�-$�)mk0�6�2��Fm�� ��d�M��e+��vJ��l��&�l���l��dY�3GȎ&[6B6�d�M6�dGȳ�Z��m���Ɏ��&[5���6~$�l��.T���h��S�o���=� YW�A�v;�?D��6�;���{�h���ޣ6�h��6�e�V�c;�m��&�l��&���d��K��eO�e�hG�-h�M�D�윲�l��,{���Yȩ��v���#d�M6���>����eQ:�ݎ�B����9���h�W���{����O���g��Ĳ�
�4q[V��v�d�	��w��v˰�ӆ��`���������.ڵ�6�Ŧ"fE;)m+��NJ[�~Nڍ3d�^����iD�M6�d���5d�]�l����)[�&;����NA;>ms5d甭��m�ON������0d��hk�@v)�H/;�溏,[wH���"��I��NJ�캢_ɴ��
��3h��d�h����d�M6�d�M6�d�M6�d�M6�d�Mv�%OՐM�.eox5SCvPٲ��&��beum�O>����hkI7�t�=4ݚCҝW�vc�)�p����b	�dw����s��u��$YV#�`�U�El��F;R�m�Em������$h��6�h��v���Q$�9e;ƒ윲�l�sʖg��S�]�d-;�2m��Nz`<�h�C[o&��l	6�`�v���\s]�kl��F�~��H?��&{�Q[�S���n�n������?lS�d��e#d��Lm��&��!�n��l�����h�K[�&�l��&�l��&�l��&�l�$��k��~v�i}�v;ڽ�aB�bi��h��ΧhB{�ސ�)I��7�);{��;#l�م.�s�E�n�7���vڶ��= ڦ��NJ[B�6�h�]m����@�勦�H��N���,��I���l'�� �vRچ�h'�-j����q$�IiKH�NJ[����N���e��/��ekYMvɲ�;%�p�먍�]�m������Ii7/���f;�ma���ͱ���6h��6�h��v��H�Ɏ&[�&�l�Ɏ#ۖH��&��beu����:�!���v�%�h��w���C��������KH�	�hY!�n�ߘk�uCP�C�i��Dm��Fm�{�-�~Nګ+��
����@|O[���-!!{0�-�&;�l{"�풏�!�e7]7M�ޚ�\�|��Q{���-j?�n-l�Ϋ[^Bw^�2����馛n����>�q�K6�{����ߎ{ɸ溝�%	5n�馛�X��I6�V�;�n38t��-vӝW�؝^��׼VoM۶N@w��,+Am;��Fm�Җ��=�b6�d�M6�d�!�nl����{d�ݾ���w�����,���������?⭍�[���
ܾ����ۿ�������������O./N��r�������d���L^���^>��j>���/����ֿ͇ʃ�ֿ�������%탟�t8�Ƿ?F��?�?F��㍿�VOY~�����oǿ��.��w�_��i����9]_��G/M�x����'��+�ۗ~�z���?��������ɏ���x��������h����������z:�ׇO���w7oqwt�F����]��������__�ߠ^߹���򥓯ܸ_�߿u:��g�w}�F��O�w�z]��y�ܹ�w�z�q�N˸e���G��Lׯ�G�/[��{����դ:;�Ow�];;�����-�U5����6yt�Vq��ݏ�����;W�__����09^��k_����NN�������w|��Y=�ڝ[ܵ�ݸ�w���n���;6�|�����w�Z�t����"�y5>><�������^��+��z��WWw?��{q����o�b�6������� p:�ʗ�p�^,�X0�U���5]�GW����a~�L�_�Tg������U�	��Շ�}_g���'�_����"��������+G�_9���I�W���.�7/�ȅjw��.T�5q�Z\�߿����������5s     