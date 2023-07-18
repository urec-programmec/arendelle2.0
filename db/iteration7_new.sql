PGDMP     )    "                {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    34237    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    34243    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    34245    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    34251    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    34253 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    34237    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200   �       �          0    34245    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   X       �           0    0    history_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.history_id_seq', 196, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    34257    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    34259    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �   �  x�u�K��( �u�]L��������-!��6dd�� !	#���C@|@?��B;���*����nF?�1x���	Tj�ٿŢ}QS�T��
�T�PdF�K
̷_?�E3��G�{��ۂ�@���dx��μ�S��)R ,�j�W�=c	�g����$8a
6f�o�����Έ�*�\h*̝m�k���x6K�/�<�x.�{���S?�ت^!���u*�EFd�j�^�J3�Ԣ\�U�p
�2�H\�(Wݫ��־3�?h}2��'c�2�B`ܴ�?U9��������c�� S)����Ts�,�m��8���u��S=�RVxb����=��՗T(�R�ٺ�߸�1��X2	ccQcK����B��H�Ŵ�Pt6+�Qd����
VBq4岱����u/Ž0�!Ec��W���z�n�z���d�f�1�&�s .G�'s��rFc�|
�Q���8~���C�2aJLa6�>�=^e�F>v���Ő���pF󋴭�s0����nϠ�1g:٪���B���1�ek9���qm�y�[�w4ch-�s�وb��Zjǩ*x����h���	���h`�3�d��~�F-�|o�"/G�$�9���Yl�L!�η��g��۠�]�p�����ko���w���=''IQ�����j��ٳ��۪K��A�=��l*���,�o��Ķ7�z��zG<QK�������	�-H0�yk�^L����N�2Zd�ՙ�7�>����Y[�9Y�����loK>����-�1�Y��2�G]"��z�Ǜ�	�3y	�R�w�_eO���q��hV��p�Q����jn�R���YK&�������`y	���r�y�}8�d-*Dތ��{Z�勌�:6-��5,��z~A�"�k���bCd��}��>�Qt�6�l����K�OD�rw�nU� R���x��d~�S;��|��ތ�w�<�������u      �      x���Ms�q���W0�)�����}�}�Aa9�	r!s	 JV(��{�z�,�{��z��2ߋ���p�AnVVU��͟�������_o���v�}g޿�<~���]y������������s�?����i����O������_���}����}���������C_��w�������=��9���O�_�ܟ��yz�b~�v|_�:|�t��ݷ�W��t�����/?���ǻ���?s�{|z��ǿ_���ӟ��<^�����n_�����O}�z���^������?��w�������N��l��S����/:|�߯��~�k�������e�x�S��~o?���}��)��|�/�wt{|Ӷ��e{��o�;����z�oo��mޫ����Z�t[#�*�o��t��^��BzELG�
�Ё�:�Q���WBn�����#6n����j�~���s;���5�\,�^��Ne�������������K2s����"� y�"(]���3G9�7�E����TY�����%�Ev���p��g�5�P��+�ۘBzQ �b�A:�G��Kw�7�:g�>XaÜ,桅��O���9�ra~��-g_��%-o�q���C��>މ�t���^��#]���ǤǼYd=�gЁ�AOpg�;����]�t�:�UH7JG���>��T�3o��@/�Mt!�"�#]�����t�� �S�ɩ�d�s��:b:��~|4#F�׏	��&霈~��ҳ�)_��o֣y���t3U:�E��V�E�2:�E��O��QI ��)?�ܽ���y��)]���E~���ر�(G�f��Ev��=�*
���_��(ґ�B::�U@/�0�t�֣HW!����[邕���(T6�(��|nm���_5�W�7�s����C��r�\r+tK��I�r�\�΅�9֞q��eD4�5�o!i�y ��6\���ν
�Ds��̃6@׉�^'r�("}��\��*n�����Vf�h��s1�-2δ�ϑ�[��m"�:��as���}stN)�<Py��o�����ζ�TZ`�|�¹�IE��;�s���Y@�K�u�mP�됞o��t�Y�"]��.\HW!�)�uH/��t�s����n�� ]���Q���Q�r������N�J�sg6�����a�8�K �������r�;��'��G�:�ҁ��e��*�s�*�Ӭ�:�SyA���M9]�ܡs�F:�7+6s����g�oA�S�@���3r)��|M��������+(_5)�L�\�9�Ây/�,R`y�:��(By��:�3e���l~�\~ZN^��5���X� �r��k�r��W�����>-�D��)�onꨘ��a�<�R")��o~r����
�(OQ�W�P�r�;�����s���n(("]���kCH�!�#�HW!����t�9��t��ӑ�B:!�*�7,H��J_�Ҝ�z�����r�EA.��qS� ;��(�o�۩���+_��bv�H^����0㽁<���\%By��^�'W/V�U�SdA�S.}*SB��������T�Wa� ��.:�s����X�����M[�^�3��<�y--*��0d.��\��0��?��3�0��|�9�9��/A�By����%�+`�K��oQ�� �	��~����l�\~,/�B��r1�Č��Ny�]g1̹�s���a��yM�����0�y ��[ʱE��{��Xx���9�Ý���G�t�F-@_zoD�	:�́�#w�"�ϖ�L��|�,��(ҝt����U�.4;G��Ё�:�*�g,F��Bz�u���N��iI�;f.'OGz+=�0���7[��|3�-*�=Dq<44��[t䂹�����G��tA���(ҏ����D7�/�K�6�KfN���m���� s15��0��*�0��+��`�g!��^�q-B-t�w�,����)n[ ]~U�(w�E/C�Ey��B9�9ȇ��)�4(G�x�5	����kδ��1=t������,��P.^97�P.�`n8Ђ���\�i�,0O�9=��A~|2#<O:FE|��DQ1'1'�/ }��ܫ4w���B:�������4�Yz6���.}nh
.HO����4�HW!�>�HW"�@� =#�#]�t.�"�I?�(޿�<�%c��Z�W������Wӡϭ��c诒�~�1L�*��2��{rK���ύ�B#�)O ���t[��\�r
�(?*�<E�`s�\�Ĺ�f.H��~r07�9�EH�ө*"�I?������Q-H�c���Et���,Ha>�\Ly�b���[��&-e��:*暯��\A��`n��yWW�?\1���$�@�����0j�Ez`~�@</�Ss�|�-��V�l��<y
��v�(R.��B:��WN=����|4ĥw4��9�q>}��w�"��'}�P.?g�^��+o��Gy`f�@���s�+`����י"�ǜ]~�2��](��(�.�K>˥~�ˏ��(o�4$SS��)B}0��aN��
����<0;�=�e�8��^���c�XP\o��EJ�@�3tٳB��G����h��:�7m]��
�HW!=#}A��t1�\*�#�I��<�>����3�+�SC	�8wΥO��8�����,:����)�=��ngJ��-B���t<���R��y�%��*
s#,��a�a����7�a��9KP�wE����Πs�/ =��"���XnIA9��;�B�Y�y���ySl1�������a\��D��J.D�|H��JKNZ���<OSy]���c9�P���"s�`.�ii<�r�)KMʂr����(Ļ�,'�I����b��'��'��O^���g�kb9�Ô���Qe,��0O0�{5�9��qJ��Y��s�D��\�r*�(�����r��i��r�ʍA9��f'��^в�N��9[%�㐮"�7�!��钙3��:R�!}xp��%�a��9�Q�?����y*���Jg��:�SqA���ؒ���A�����~ןI]`�<��Dr���q����yr�Ba��9��0MZz�Ǖ�X��¼�)���h���p�	�[4_�?��@�e.)4�3�p��s.9�g��<Ly�9�+@>�\LI1G9��+��9�(�n�r�\�%�Rq)�Z�yÑ��W�1�����塓S8�E-��S���.̇r1�@i��r�'�H�{��C^�9k���7�M?���ø@���+>�AsƳ���ʃz�� ��αD�/!=���;�H�.�v�Sm�z`Q���PsC����D��0�������I.�\u)��N�P�';�����q\�'��� gt�GG��D��Ћ��_w9�q^QCǹs~�1z��b_��҃�z��k�:؏�3�h.�G�Ǽ�o(�g8���Z�g��\P�c�"C�����٩U���P>7s�[��|#~ZrI��D���Y��\>��9��3�HZ`.�y�x���[Z��@�LP�Pd�-�q�������������RnI]P�<�ehIQ�C��[
p�\���-(������XP�IčP��憭!��W��D��Wޠ僉��ǅ���'e��,b���Dy���%���<Ly
��-�9�Ø�3��,�@Q�bb�5��P�ޛ��?�҅hJ�e��G�Ot:	M�P~�@$9�����̧%潝�#������b��s'�լA�>}ZL�:	:������e��n��|re�9�[����$8��k�"��/�]�tC�]X�b:�_K��;2t�>���Pw��R�h
���d�9Ca>�<�� >y}�`�;�� c�:ґ�$Eo�c�s�.uT�-Gvaȼ�b���yI��ι䤥���r��9��n:�b��Α�cj(3��.?q)8��r�ʷ(G�t�5�Q.^�a��gl�|H��KM�h��Щ-	��s��@��Zʨ�9�D�+5W� �y`8O��h�s����9�0�"�ŗ�K��<�l��!\���Y@�3g�0�y ���!S4g���c��gO��9��a>    7�sj�N�Ph)�sʉHOJ��̥B:�[����1�h.�MP����\R"zA��g��*��#]�����Gec��u�/�=h\n>���\�6P��f��(%�s@�G{oeS���G1�k�Cc�2�onA���艊0����ǅ���]�	��4�j�r�o4LS�8�u�y��W�p%��Sk���&.\�x�4WyWh難(z�
�*�s�
J-(����(�?���I���RnX��\~�r�KGnP��%��[�����`�q���s���S.�x�yr	�� ���S�K����ᄅ��k*�{�ߧ�VFZ򾄬8��#Z�\�-�)K��y\���ϱ��9�UtΘ]���~���ν!��^#��W��0W��(R.�\Mi��O@�0�*��[p�<,iɦ+�=��\ �J-!���rW�:&����:�WHG��ΐP��.zp�Q>�|Z�R�!?{�gx�eC���<~�9ґ���Z�r�ꁩK���c.0��mX��\>s��9̇��IZ���g^Sm�yWm=Aѐ�#]����sHw�%+���#/�m�r��+j-(R>���;y��Jy�n?�����'��+���+�'4��+�?��+�d,(����,(_Il��Q.>��6����g:�IX@.>�l}��)��?�9��V���͹���O�9�r�\z�P�Q�/ =��ΤP�/!=��[�/Po�K�ןqq�aK�uZ��mQWD�
.q)7d�(�.��\��c�(��X6BQ�<��!v�A�"��VL<	�1Bvn^g�or; ݾ�n�R?�f�G.]�~�~?̟�_I�JE�N��Q�a>�<���Hw�`�<����B����ނ���%����BKʊ0��-��2���e�j��4s��:_g�y(�8ܲ����i_?����?�	(�$p&�ӊDt�A9}��s�ǵ6*�%W�`�<�K4mA��֡�Q.^9��P�@9�ZP.^9�+P._y��-���X8���
�˟'W���<L�Ie�9��Q1����y���2�'�\��9��+g�	r��Nk��)�*&//)��<l��{�"�Ar,>A�� ����g?e�C���������G������H���$Я��Ӂ~.�q�]h���V��ą�"�U���"����W�CꁩKw,�
s�:w,P�V���'��t� ]��В�"̟�_��*��N@G���Z�s�s�[��<�y�<��"���?-4';Gy�<�m"�7���B���bd���gv.�F�%�G=�=��s�`���$�����/�߶�7����_����<-�e�>�BN*��!*&7��IԻ��t��Kn��<,iI`'��\�SL��:咛�|H�����9��+����+'/G����Ȭ$��X�Jy��~��W����g��B�x�5��WN�P��W^ScA��J�I�0�X�r��<����jA�|��и.���Sc���%�+qśM!��a\X$7�H��MP[���X�
�<�yќn�0W0���B(o��K��@�?�#�:�S:G��4ND��%ґ��tSL�>wjbA�q9�}'o�A�ET��2^��8wA	��A��::��H?J��t���\	z���S.��-�Q^mQ�r��i���%�%p��������)�� ��<�U(ݷ��\W��"$�gDt����i��e7�N��@����QI����=���E��JӪ��\PW0%��S.��37�q��|�s��W�V��+/�i�A�1W	�(���O������q.?�S5���ܼ�n(��3/�a>�\�M"�9�C�'�忡�s�I��9��3��s���yhn~��w�8����0�_ii�0��s9I��`��o���f?�Q�<�`n���@�+P�Lun�3���߲Տ�Vy�����B�I�-^��(O6��Hψ�HW!�"�#}�a;E�t�sW�5�;�+E������x��^�S��{�+����+?�A+9ʻz��9�5u�;��Y|���
�y(�ޖD�T��t�Ss�A��
E�S6X.h	z��ϜR���,t���sR��&�'r��i!�q����K����yj���֡셢�U��:4�i��B��t1�-�C���$p¥!w�� s1Ѽf���[��0�Ϝ��5�Td���O�QFs�)�_�oΞ�~��rӯ���@�r�M��-��A�(&
��x|�@>��)E9Pε ]���mP���^SmA���������KSO� :;EHב���;颙W�Ga.�9��a��9�rQ._9�[`><�HsΞ�|Py�E���������G%�r��HO s�8����E����6E���&j(+�\9�d���3��ɦ�>��E�;�+!/��)-b|U�Y�r~�ґ�Dr��_ɝj9�s�<����p\v�`.�9��Ny�0���s��/�s���ht�K%��̽���ߊ_z�E:�5H7�B��{��5<�H_@z��CΟ#}T����ԡ�R�̜�0W�����3��������� �UH�*4�G�Ǽa䗤�� �IO�)�[`~Q�	�>�8��A�b��.0�Ϝ�0W��hs���a�]�\n������I)O����P������1>�� /bRN(����r�q�\s�9��B�EK=�cҧ[N�*݋��-�k�"!���Zx���"���8�H�9��hр�����s5�����]Hҡ><��̛��gU�L.��Lϫ�o��e��a�ê�����c�h�J��ЂPs�<��ػ�o�2���v�Q�<�`�S0���y�4����s���^�� ]A�Bs\�;�)����:�[�'�qL�Jf)RBG���>���$��}n�m�+Zn����1sML'riƵj@����$���-�/B����]��[p���Q���/�:�3�:��@�&�N�>�+N ��U���hT��'�����9a��~L)8��ԬE	遉K
�E��\A��M:��gΔ\�+`^���<ɪ��i.��\|0���s�O�]7�"�G+�סc��	t�G]L⒱����Zm�/s�k�t�o�˭H_��JOl��W���|<q�����ϷxI'G�����-���e9齭N�<���I��	�)��t,���5kQ�'��'9������1#���\�@y`�<�X^q���X~%w��!���1=���-0W��Rf�������7-.���h�����䊟z��9���܅{0_bW���DH_@�*�D�&��]�@_�޿�tRt��B��_�a���d�����0��yK�y.��I�mmTԙ�uA�$KGzxP� WŖП����[�(��v�=Lz�a���@_ �:!ݯ�(�:�[��l�\st��W����#>�냼��"��Ul�	z��h�;蒕g\�@��p�p��@?��^�ه[x���� }�a�D�t�v.tr��BSZ,�^��QO�%:��>C�����FH�!}�t�k���� ]�t�/HOsB���"R�;撕���\�r�.�\��"��WN���_}r=��̯�N��9�s�\�,�Z ]��j�_��/Z���]v���]GC���NH��㟼�]����!���l�r|���2��7���\�����Ӿ���):̻�Et�R�k�t�K�HW!=g��c�c^��@g1��g�A��ޠnb�N[���R�2�:ԡ�R����ܒ��|�/�y�H��Oy\[F%�a� ����<0����GyE0G��Ŗ�/2�Ё� �ވ��E��;��].���������#.0?[�ו��)P�_Xd7�JƋr��N��]�ґ�t���^"�*��9ґ�?���s�9�s�Q��!�1������Y`.?�g�@a.�y��9�7�G��#�K4�_�V��$Z-}����@�.{�bM��Z�R���+��(w��/z�-$� O��iEη�|0aÜ�\0W�������	�-HZ`ȼ7��Ŝ`��p.��i�uH���t����� �	   �wA���Q���$xb�k�hv�o4�͉�P�^(�ӑ�
֢;�0�9�a.�ys��ʼ����!3�C.���|"�/1Z1~��[�~�>��I�0�4�����NOh�+�����|4��)+"�mUQ�ќq�Hw�ŏ��"���kQ�2���U�ałh�e���_zT��sP�ŕ@Dϩ��|�����p`��9#�`��t��MU8��[p�KNZjn@�\�rRs��_�ʎ?ʝr�Cs
�H�!�j�_�����9����QO�TEf}�١�t�v&rV�_���Ѿe.q��b\~���?�W�V.��g�Q������/ �����'W�^m��3A��T�a��u�נ3����N���Q�1/H}�3���M�R������}�Ia��a��{a���\��������sWս��Ё=���<:�G���5�-ԡ�I����r:ʝ���]�5^p�パ\JjnP��5#�%�s��θ�*�a�<�Sn�2Ϧ+}U���"g\P��j�#��xrn1��P6�q�х�m8���N�l�]��B�%SG�
�\�C����@��a��䂹c.Y9�Qx�%��E���ӕ���+�L9��P.?1/I�a.�yAf���ܑ���P�;�)�*���ύ"����4t���)��?�W���t糧-Rwz]r@��Νs��9���6�KFΆ(�WO�/!�z�U@϶HG��4�@��t1G]**�P廓�N�:��c���ԡ�,�jf-�u�w�B�oEة3B}���u�Ё]v���oֱ�b=�n�_����s2�Ƞ���Ȝ���g��z)3yI��j]������E�S�֝Q�4��x�w�9{E wȅ��k8���,����^���-�(�����.��Gz�h����^����^����]������ZT2sV�0�
=)�<�[ꨜ� �
����
��0�ϼd?��s��gn�
g���I)/�Y��+�cE����9O�`�W�h��`.�9�,`�r~K���9ҝ��ѹ�\���љ����z}��"ʓQ>��B��r�\0�S� I�'I?ɷ�����tO��t
.HW!�"�H_��tθD������8y�0�t���yd�c��bN-�+�:��6HG��nBf�}�M1�z1]�����;��qՔ���{C��Z�W[��}�=�cD���B�
�%�F���P>��H��'�|vւr��W�SIG�x��r�'��ŇyF��*
-�s����6җ��{�1�*�� �\��*B:Ё�zΙt��Jsψv]H,��Qސ��\>�::��Ēs��El��|H��X^���\���'��2�^�v�x��(�):��+�Y}�+W48�j�D����fj�2�_��`.V��r�<�-P&-��̉�0?2�=P�EH%}�n\�I:�,�:k�����K~~�M[@.���[�	:�Z�Α�B�a.�UH�����G?����@_��ʳ{�f����.}���#��H^h>�t%sE���i�b�[�#}Lz�ً�<�t���
�]v��`W��X�h�ȅ#���^R�A���t��.�>?t������(Of�ST��S�c<�N��)_��9�m#����Fw�<$�洤C����H�((���
�%!�*�ӆ�:�3/�KH�AZN��q�t�tB:�U�tZ�#]�]��"��.Y��E�s�s���A>�\L(��(��+�R��+�{���ޱ�uT���(o�_]�柛��ۻ��S�������/��8<��?������q�����v��Ӧ�ܟv7�_o������ߚ�x_��mQ��~���_��a��c���^��Oٷ���Vw��k_Do�������C�u�Y�~�O�T���b��v����˯����=�W�;;�M�,�7��ͷW���0����[�����C����᯶���?<>]?���������?���SV~��Ͽ����#��ng�C��j��).��7O��dO>���LU@�����V�Z��9/F�ݏw_�|�����Z��e����_��C3��~��^�ˇg>�<��H����g����(��8[�����s�r��Ca>]����>}������y�����3cϭx�܎�i?ܼ��?>w�����{x�s����Z���]������ޔ�7�G�[�����c�n�ܖ��'����'��[��5�/���~@�=2��]�ό<�}��!��^�n>����w���֛��ܴl���w��o<�ң����~��g��v���ȯ�v������3p
޾e}���wz���iww��?ܘO��v/o�ټ���?�{�h~����^�y�����yI���(����ߘ���b�7��%Gߤ�����h��M�M���&͆4���&�1�I�!����ߤBԛ4����Ͽ�~�ˇ~���Cw�{     