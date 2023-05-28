PGDMP                         {            veil    13.10    13.10     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17622    veil    DATABASE     a   CREATE DATABASE veil WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE veil;
                postgres    false            �            1259    24775    history    TABLE     �   CREATE TABLE public.history (
    id integer NOT NULL,
    dair smallint NOT NULL,
    resource smallint NOT NULL,
    count integer NOT NULL,
    date character varying NOT NULL,
    period smallint NOT NULL
);
    DROP TABLE public.history;
       public         heap    postgres    false            �            1259    24781    history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          postgres    false    200            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          postgres    false    201            �            1259    24783    veil    TABLE       CREATE TABLE public.veil (
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
       public         heap    postgres    false            �            1259    24789    veil_id_seq    SEQUENCE     �   ALTER TABLE public.veil ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.veil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            *           2604    24791 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    24775    history 
   TABLE DATA           J   COPY public.history (id, dair, resource, count, date, period) FROM stdin;
    public          postgres    false    200          �          0    24783    veil 
   TABLE DATA           f   COPY public.veil (id, map, dair1, dair2, dair3, dair4, dair5, meisters, business, period) FROM stdin;
    public          postgres    false    202   �       �           0    0    history_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.history_id_seq', 3, true);
          public          postgres    false    201            �           0    0    veil_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.veil_id_seq', 1, true);
          public          postgres    false    203            ,           2606    24794    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            postgres    false    200            .           2606    24796    veil veil_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.veil
    ADD CONSTRAINT veil_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.veil DROP CONSTRAINT veil_pkey;
       public            postgres    false    202            �      x������ � �      �      x����R[G �u�*f�TɄ{%��d�`2U�P������@I0�T�w�gK�Z�}Z�&2��@�����������;'�󫳣�q1��k�n�vf��dxz�L5f:��_MG���so��������g��O����M�N^t���xz�)��f��_��s��A��>{������b�g����ѯ_>���lr~����xv9=����d6�xx:�����_û������SWg�����4�_������d�����;�u^�Y�E�u^���n^��p:��O��ڛQ�_��g�_=���V7���ɇ����륿�ѽ�Aۻ���}�����1OχG�_>3z�w��6�k����`�Rr�%�\r�%�\r����䆔+�S��K.�䒻9�r�%�\r�%�\y.��K.��K.�['���K.��+�%�\r��E�54rc�s�%�\r��%�\rK��M$�-����5��&��j�F.�b.��K.��+�%�\1�\r�%7_��6��K.��+[ �\r�U#�\r�%�\r�+�%7�\U1r�%�\y.�䊹�K.��K.��/w�n�5a7�]��-D��K.��K.��j�Kn�r�\r�%�\r�%W�K.��[��p��n��m%䒛�\���ɵ�ܘr�\r�%�\�+�%�D��rcʕ-�K.���&�����K�l�ܭ��%�\r~�ȍ�-�K.�䒻��_r�%�\re�"7�94r�s�%��1�\rs�+�K.�䆔�.��
��f'�������%W�@�V�U�%7�\��1��ȍ)w���i���@n�r�\r�%�\�r�W��Kn��v���.��j�D.�䒛�ܧ�#��䊹��&��b��"�7fY�\r%�+�[�\=���z���7"\!�\r�%�\r�%�\r�%�\r�%�� rS�C#�ܴr-��K.���&��=n�%7�b.���5C#7�\U1rɭ�~t�IW{&r�����ܘrSM��%7fY�\re�K.��K��䊹�K.��ʕ-�S��K.��K.��J/Gp�r��~r�%��嚟�S��KnL�V�ȍ)W�%7�\1�\r�%7��A��Vu����x�X#�\r�%�\rK��j�F.�1+��+[ �\1��R��sɍ)W�}r�%�\r�%�\r�u9���MU\@]Q]t�E]�4r� �KnF�4r�s�%W�%�\r�%�\rU��%W�r󕫋.�1��s�%7L�=�����^N�$�� 7��K.�J�K.��K.��k�F�ʵAnL��cnM.�!効�K.�j�K.�����%�\r�[ �\r�%�\r�%�\r�%׎r��;h��.�e7�]�V�[�\-�ȍ)W�%7�\1�ܘr��'�\rɕ-�K.��(W�@nL�b.��K.���Z)rK��j��-�袋.���E7(]rɵA.�ϕ�i�[�Kn�r�\rs�+�%�\r�%�\rt�EW�r����3��K.��+�%�\r�-]�����:��.����t�.�A�.�
c�K.���M5G#�\r�%W�@n)r��%�\re���jrK�+�S���1���-Y��{��K�l�\r�%7��A���Pu��rvc���%7�9���&7U�K.�9��5��s���効�K.�����wn�<��ӫ�\�%��M��Z�@nH��\r�%�\�r�u)����C�nP������n�|]t��%�\�r�U�%��b.�1��sɍ)W]]t�E��|]t����ܘ�1r��!�m���#���s��M�<�\r�E]t�E]t�E]t����@.��K.��K.��K.��Kn�rS�&�ܴrm/'�\rɵ��\r�\r�%�\r�%�\r��;h���:�Ѯ~��"7U]�\rcf��+[ �\r�-E�l�\r�%�\r�%�\r�%�@�U�\rU��%�m�䒫�#�袋.��+�%7�\%]r�%�\%]rɕ�K���袋.�被��a��FJnL�/X[ڥK.�b.���s�-E��l��"r�t�E]t�E]t�E���ڧ�.�q�#�EW.�袋.��n]����,0�Kn����K.��r�%�\r�%�\r�%�\r�%���ڭ���[�e7f�%�ܘk�K.����-E��K.��K.���s�-Q��K.��K.���s�-Q�+)�%W�t�E]t�E]t��.��K.��K�D]t�E]t�E������i��uC.�9ȭ��V䒛�\1�����s�%Wq]t�E]t�E]t�E���j��.�A���+a@]t�E]tK�k�ܴr_�G^�#�܈r�\r���i�k�.���s��M���K.��+�%�D�����6�U[ wsr�V�MS�F��)r�%����K.��K.��K.���������+�K.��K.�%�upݠt{�K.��K.�]t�?�.���M�E]t%袋.�袋.�袋.�袋�����ܘ+�K.��Kn)r�䒫��.�袋.��>�n�\r�%�\���Э�E7&]Q]t���K.��K�D]t�E]t�E]t���*W�E7(]�#�M+7UwGr�%�\r��V�eS�F����K.�i�ڨK.�1��S��.�袋.�袋.���%�ܘr]t�E]���[��Tm��%�\r�%��R��wC.�fh䒻�lAYݠ�����E]t�E]t�E]t�E]t�Ewk�j�D.��K.��Jt�E]t�E]מ����Tu�%7��T[u�%W�@.��K.���s�%�\r�%�\r�%�\rɵ�FnT�b.��K��r�u����7C�4���%��<�\r_T��껓�݈v7u�%7��T���%7fu�\rcf��4]@]Q]tu�A]t�E]t���.`rc�%�\r�},7�y4r�s�%��r�&�+w��K����*袋.�袋.�袋.��fN�st�E]t�E]t�Eݬ�0��.�袋.����]t��;ݠt]AnL���.����t�%W�%�\r�%�\r����r���F�+�K.��Kn�r��-Yn�	��y�+[ ���r�#��E�5��&��j�F.�1�\r�}Q��v���9��n,�u�\r�%wsr�E7�$]t�E]m�-��\]t�E���#�M+7��rɍ9I#�\r�%��5�Nܕ�z�%7L�]�B.�a䊹�K.���k]t�E]t�E�@tm�E7(���njtэIwi�]t��u�AW��nP�*袋.�袋.�袋.�[A���n�����==r���<��KnnrS�G�Knrẙ���効�K.��K.��K.����6�U[ ��54r�%�\r���[�\��J7Uq�&�ܐ���K.�׃v���9��jbN.��[�\�1t�E]t�E]t�Eݬ�*0��Vn�ݎ䒛V��4r�%���o�%�\rɕ-�K.��K.�V"�%��/�袋.�袋.���}]t�E]t�E]t�E7+�*袋.�%��K.��K.�䮔��r��u]�1�jB.��K����%�\rɕ-�[�\1�ܒ�6­�%7w�b.��K.��n�\���K.����K��ȭ�%�\r��X�K.�/*w�n�50g7�]���%�\r���KnL��ܠ���K.��K.��Kn��(�%WA�\r�%�\r�%�\r������b�K.����r����.��F�+ꢋ����%�\r�%�\r�-^�)�袋.�袋.���5K#7��T]�%�\r�},7�srɍ�皢�4��ܘ�.�䊹�+�[�\1�\r�%W�@.��[����w�z=���+!�ܜ�l�M�ґ\r�%�\E1rK��j���Ɣk�#�A��䒛Tn���侨�A��w�	�����B䊹�Ɣ�r�%�\y.���s�%�\rs�+[ 7�\1�\r�%WU�\r�%�\r�%�\rs��X�袋.�袋.���uE�i��ܒ�v��V�[�~1r�%�\r���%w�\e1t�E]t�EW�K����ZF#wk�s{Mp-��[`�k��.�袋.�袋.�袋.�躓�\r�%�\r�u�:��K.�䒻��T��%7��pW�#�\��䪊�K.��(��t_���껓�݈v7V^ ��䊹��&W�@nL�b.�1�jB.��K� �  l��풫*FnL�b.���}��X�#���[�%7fm��t�]t�E]t�E]t�E]t�E]�L����,�.-��Kn�b.�1�Vrɍ(W�%��\r���E]t�E]t�E�,��@rU��%�\r�%���i�H.��K�l��R䊹�K.�V"�%��/�袋n�tݦJ.��K.���MU#�ܴrS]A.��K.��"W�K.�䒛L���oȮK�؍��K.���Xn�s�K.��&�{.�O�[7˽�^Is��Y�	��(W9�ܘrSm�%�\r�%wsr��D7�]t�t�EW.�袋.�袋.�袋.��;��K�\r�%�m'�#7�vGrɕ-�K����е�ݠt�wD7(�T�4t��뚥�3�%�\r�%�\rK����@.�b.��K.��K.��沈F.�i�ZC#�\�E]tmC�P������ɍt�%7��T[�%�\r�%��R�Z &�\r�%�z�n�ݧ�nD�n&w���Mp+r�-/�%��b.��K.�9�\ �\1�\r�\rK��j�.��Ɣ�X�袋��h袋.��MW.�袋.�袋.�袛]t��u�*�A��KnL���Sn�L�\re䒫0�n1tS%�袋.��J�E�,��r*c��>�%�ܴrS�] ���6�]ٓ�\rs�+撛�\y.��KnȢ��K.����%׾t��%�A���nP��W�3�K.�䒻�9��� �����%w�r�.Zs��T�<��r�V߅��F��*`r�%�ܬ���\r�\r�%��R��sC.��K.��K.��K.��K.��'�!Jt�E]t�E]t�E]t�E]t�E�Xt5�%7�܊\rC�u�	�1���%�\r�%�\r�%�\r��\p�s�%W9���j�D.��K.��"W�KnL�j�Ɣk!�\r�%7�\�y�E]t7Y]@ݠ�t��0��ܘA�\rcf�䒛Vn���K.��Kn)r�䆐;h����f7�]��[��T]r�s�%�\r�}$� \p�o�!�\r�%W�K.��K.��K�vȵ�FnL�j���/���+ꢋ��x�K.��K.��K.�9�MU#�ܴr��CnL�b.��K.��K.�%�5C#�\r�%�\r�%�\r��En���K.����-E��rcʵ?�ܘr�[G7(�T�.����E7(]WQ�K.��&��\p#�r�%�\r_�,F.�i��sC.��K����%�E�ڭ�˥؍h���B#܊\r���%�\r���Z�䆑��q\p��r�%�\r_i�\r��%W�%�\r�%�\r����z���n�t]t����3_ �ܘk�+�K��K.��+[ �\r����rc�s�%�\r�%�\r�%�\r�%��*FnL�b.�%��4�]�@�\rs�+�K.�䚡���r��$7�\���J7U�Eݠt]�Gn���䆩.�nD�B.��\r�%�\r�%7���"�%WQ�\r�%7��A��wA���Z��B���%W�%��ͭ��K.��K.��K��䊹�n�\1�ܒ�6�]�Z�\re��Xn����S�^!袋.���[�\Mt�%�\rs��K.��+[ �\rɍ%7��/�䆉������z���镐Kn�rS�ܚ\rC�s�%�\r��܈p�\r�%�\r�%�\r�%�\���B�b.�1�:?I.��r�+E.��K.���u%��Kn�z.��K.��K.��؛�\r��]<�.��b�{=h��.Dc7�]�J�[��D���7\!�ܘ�r�%�\r�%�\r�%�\r�%�\r�%�\r�%���Z'�ܘro�@]t�EWO<r���)�%��4���%������ ���Kn���%�\r�%��R䪊�K.��K.�V"�-Q��r�%�\r�%�\r�Wn�����kb.��ɵ�KnL�N�K.��Ɨ�zrc��K.��K.��K.���o�\r�%�\r�%�\r�%�\r����b䆐;h����a7�]7K�[��T��䊹��ܘ�k����/��� W�%77��rc�sɍ)7U�r��A��;�Knr�\rs�k�FnL�fh�Ɣ�����Ɣ{��袋.��9�[��Ts4rɍY�%�ܘ]r�%�\r�%���\r�%�\r�%�\r�%��\�ZC#7�\1�ܘr�s�-Yn�	��3��+[ �\���K�l�\r�s���Ρ�K�\��3[ �ܘ34r�%�\r7W�%�\r�%��r�&�+wܐKnr�\r�%����m�+[ WU�\r�%�\r��E���Y�݈v݉Fn!rS�#�\1�\r�%�\r�%�\r�%�\r�%�\r�%�\rɍ*��1��rC.�1��~�.�袋.�袻��V���,/�KnZ�Z�K.��K.��K.���"Wm�ܘr�\r�%�\r�%�\r�%�\r�%�\r�O�z.�1効�K.��K�<���:B�nP������ȍ��K��K.�ύ��&��&W�%�\r��
�fh�K.��K.��(��ܘr�\rC�~�sG;wWJ�?�p������nݽ}���>t�:�����W��/ٙ����v�v��~��w|��_ǣ�����������u�u���ۭ��Y��=Ο��~����~�O��|��adꇡ�Ʀ~��?����f������ǣ�����G\MOo~��Ï?�.����ϓ�'?��������/N~ڹ~�Σ�^�����u����뽯�����G���09=�=:���/F���W�F�h�����]�|L���Ao���=������a}�%�ޣ�����F�Ac�>>>��}���V����N>���p4����?�;�ݣ����և�᪱��kiC;���nw�7�������>p-i��{����u�ƥ���_~���������t�����;��-�濣���t�;z<�/1jǓ��r�;�����硫v>'s��h��������?}�9�{�;;�~g����=P�́����k�����Zc��������͛��?'     