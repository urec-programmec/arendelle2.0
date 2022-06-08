<template>
  <div class="login">
    <div class="login-header">Регистрация</div>
    <a @click="changeSign" class="login-change">есть аккаунт?</a>
    <div class="login-form-item-error-message" v-if="errorMessage !== ''">{{ errorMessage }}</div>
    <form class="login-form" autocomplete="off">
      <div class="login-form-item">
        <div class="login-form-item-title">Email</div>
        <input :maxlength="50"
               v-model="email"
               type="text"
               readonly
               @focus="onItemFocus"
               name="cool-name"
               placeholder="username@email.adr"
               :class="['login-form-item-value', { 'login-form-item-error': emailErrorMessage !== '' }]"/>
        <div class="login-form-item-error-message" v-if="emailErrorMessage !== ''">{{ emailErrorMessage }}</div>
      </div>
      <div class="login-form-item">
        <div class="login-form-item-title">Никнейм</div>
        <input :maxlength="50"
               v-model="nickname"
               type="text"
               readonly
               @focus="onItemFocus"
               name="cool-name"
               :class="['login-form-item-value', { 'login-form-item-error': nicknameErrorMessage !== '' }]"/>
        <div class="login-form-item-error-message" v-if="nicknameErrorMessage !== ''">{{ nicknameErrorMessage }}</div>
      </div>
      <div class="login-form-item">
        <div class="login-form-item-title">Имя</div>
        <input :maxlength="50"
               v-model="name"
               type="text"
               readonly
               @focus="onItemFocus"
               name="cool-name"
               :class="['login-form-item-value', { 'login-form-item-error': nameErrorMessage !== '' }]"/>
        <div class="login-form-item-error-message" v-if="nameErrorMessage !== ''">{{ nameErrorMessage }}</div>
      </div>
      <div class="login-form-item">
        <div class="login-form-item-title">Фамилия</div>
        <input :maxlength="50"
               v-model="surname"
               type="text"
               readonly
               @focus="onItemFocus"
               name="cool-name"
               :class="['login-form-item-value', { 'login-form-item-error': surnameErrorMessage !== '' }]"/>
        <div class="login-form-item-error-message" v-if="surnameErrorMessage !== ''">{{ surnameErrorMessage }}</div>
      </div>
      <div class="login-form-item">
        <div class="login-form-item-title">Роль</div>
        <toggle-switch :defaultItems="roles" :selectedItem="role"
                       @changeSelection="changeRole" style="width: 100%"/>
      </div>
      <div class="login-form-item">
        <div class="login-form-item-title">Учебное заведение</div>
        <model-select :options="institutionOptions"
                      readonly
                      @focus="onItemFocus"
                      name="cool-name"
                      :class="[{ 'login-form-item-error': institutionErrorMessage !== '' }]"
                      v-model="institution" />
        <div class="login-form-item-error-message" v-if="institutionErrorMessage !== ''">{{ institutionErrorMessage }}</div>
      </div>

      <div class="login-form-item">
        <div class="login-form-item-title">Пароль</div>
        <div style="position: relative">
        <input :maxlength="50"
               v-model="password"
               :type="passwordShow ? 'text' : 'password'"
               readonly
               @focus="onItemFocus"
               name="password"
               autocomplete="new-password"
               style="padding-right: 28px"
               :class="['login-form-item-value', { 'login-form-item-error': passwordErrorMessage !== '' }]"/>
        <div class="login-form-item-error-message" v-if="passwordErrorMessage !== ''">{{ passwordErrorMessage }}</div>
        <i :class="['bx', passwordShow ? 'bx-hide' : 'bx-show', 'hide']" style="font-size: 1.3em"
           @click="passwordShow = !passwordShow"/>
        </div>
      </div>

      <div class="login-form-item">
        <div class="login-form-item-title">Повторение пароля</div>
        <div style="position: relative">
        <input :maxlength="50"
               v-model="passwordRepeat"
               :type="passwordRepeatShow ? 'text' : 'password'"
               readonly
               @focus="onItemFocus"
               name="cool-name"
               style="padding-right: 28px"
               :class="['login-form-item-value', { 'login-form-item-error': passwordRepeatErrorMessage !== '' }]"/>
        <div class="login-form-item-error-message" v-if="passwordRepeatErrorMessage !== ''">{{ passwordRepeatErrorMessage }}</div>
        <i :class="['bx', passwordRepeatShow ? 'bx-hide' : 'bx-show', 'hide']" style="font-size: 1.3em"
           @click="passwordRepeatShow = !passwordRepeatShow"/>
        </div>
      </div>
    </form>
    <div style="width: 100%; display: flex; justify-content: right">
      <div class="submit" @click="submit">зарегистрироваться</div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { ModelSelect } from 'vue-search-select';
import 'vue-search-select/dist/VueSearchSelect.css';
import ToggleSwitch from '../Main/ToggleSwitch';

export default {
  name: 'SignIn',
  components: { 'toggle-switch': ToggleSwitch, 'model-select': ModelSelect },
  data() {
    return {
      pathGetInstitutions: 'http://localhost:5050/allInstitutionsText',
      pathCheckEmail: 'http://localhost:5050/checkEmail',
      pathCheckNickname: 'http://localhost:5050/checkNickname',
      pathSaveUser: 'http://localhost:5050/saveUser',
      items: [],
      errorMessage: '',

      email: '',
      emailErrorMessage: '',

      nickname: '',
      nicknameErrorMessage: '',

      name: '',
      nameErrorMessage: '',

      surname: '',
      surnameErrorMessage: '',

      roles: [
        {
          type: '1',
          name: 'студент',
          disabled: false,
        },
        {
          type: '2',
          name: 'преподаватель',
          disabled: false,
        },
      ],
      role: '1',

      institutionOptions: [],
      institution: {
        value: '',
        text: '',
      },
      institutionErrorMessage: '',

      password: '',
      passwordShow: '',
      passwordErrorMessage: '',

      passwordRepeat: '',
      passwordRepeatShow: '',
      passwordRepeatErrorMessage: '',
    };
  },
  methods: {
    submit() {
      this.errorMessage = '';
      this.email = this.email.trim();
      this.nickname = this.nickname.trim();
      this.name = this.name.trim();
      this.surname = this.surname.trim();
      this.institution.text = this.institution.text.trim();
      this.password = this.password.trim();
      this.passwordRepeat = this.passwordRepeat.trim();

      if (this.email === '') {
        this.emailErrorMessage = 'email обязателен';
      } else if (!String(this.email)
        .toLowerCase()
        .match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)) {
        this.emailErrorMessage = 'email должен соответствовать шаблону username@email.adr';
      } else {
        this.emailErrorMessage = 'проверка существования email';
        axios.post(this.pathCheckEmail, { email: this.email })
          .then((res) => {
            if (!res.data.isValid) {
              this.emailErrorMessage = 'такой email уже существует';
            } else {
              this.emailErrorMessage = '';
              this.finalCheck();
            }
          })
          .catch((error) => {
            this.errorMessage = error;
            console.error(error);
          });
      }

      if (this.nickname === '') {
        this.nicknameErrorMessage = 'никнейм обязателен';
      } else if (this.nickname.length < 3) {
        this.nicknameErrorMessage = 'длина никнейма от 3 до 50 символов';
      } else {
        this.nicknameErrorMessage = 'проверка существования никнейма';
        axios.post(this.pathCheckNickname, { nickname: this.nickname })
          .then((res) => {
            if (!res.data.isValid) {
              this.nicknameErrorMessage = 'такой никнейм уже существует';
            } else {
              this.nicknameErrorMessage = '';
              this.finalCheck();
            }
          })
          .catch((error) => {
            this.errorMessage = error;
            console.error(error);
          });
      }

      if (this.name === '') {
        this.nameErrorMessage = 'имя обязательно';
      } else if (this.nickname.length < 2) {
        this.nameErrorMessage = 'длина имени от 2 до 50 символов';
      } else {
        this.nameErrorMessage = '';
      }

      if (this.surname === '') {
        this.surnameErrorMessage = 'фамилия обязательна';
      } else if (this.nickname.length < 2) {
        this.surnameErrorMessage = 'длина фамилии от 2 до 50 символов';
      } else {
        this.surnameErrorMessage = '';
      }

      if (this.institution.text === '') {
        this.institutionErrorMessage = 'учебное заведение обязательно';
      } else {
        this.institutionErrorMessage = '';
      }

      if (this.password === '') {
        this.passwordErrorMessage = 'пароль обязателен';
      } else if (this.password.length < 6) {
        this.passwordErrorMessage = 'длина пароля от 6 до 50 символов';
      } else {
        this.passwordErrorMessage = '';
      }

      if (this.passwordRepeat !== this.password) {
        this.passwordRepeatErrorMessage = 'пароли не сопадают';
      } else {
        this.passwordRepeatErrorMessage = '';
      }
      this.finalCheck();
    },
    finalCheck() {
      if (this.emailErrorMessage === '' &&
        this.nicknameErrorMessage === '' &&
        this.nameErrorMessage === '' &&
        this.surnameErrorMessage === '' &&
        this.institutionErrorMessage === '' &&
        this.passwordErrorMessage === '' &&
        this.passwordRepeatErrorMessage === '') {
        let color = Math.random() < 0.9 ? `hsla(${Math.random() * 100 + 170}, 50%, 50%, 1)` : `hsla(${Math.random() * 30}, 50%, 50%, 1)`;
        let data = {
          email: this.email,
          nickname: this.nickname,
          name: this.name,
          surname: this.surname,
          institutionId: this.institution.value,
          password: this.password,
          color,
          role: this.role,
        };
        axios.post(this.pathSaveUser, data)
          .then((res) => {
            this.$emit('signIn', res.data.user);
          })
          .catch((error) => {
            this.errorMessage = error;
            console.error(error);
          });
      }
    },
    changeSign() {
      this.$emit('changeSign');
    },
    changeRole(data) {
      this.role = data['selection'];
    },
    onItemFocus(event) {
      event.srcElement.removeAttribute('readonly');
    },
  },
  props: {
    defaultItems: {
      type: Array,
      default: () => [],
    },
  },
  mounted() {
    this.items = this.defaultItems;
    axios.get(this.pathGetInstitutions)
      .then((res) => {
        this.institutionOptions = res.data.institutions;
      })
      .catch((error) => {
        this.errorMessage = error;
        console.error(error);
      });
  },
};
</script>

<style scoped>
.login {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 43%;
  height: fit-content;
  background-color: rgba(241,243,244,0.24);
  border-radius: 0.25rem;
  padding: 10px;
  color: #F5F5F5;
  overflow: hidden;
}
.login-form {
  margin-top: 5px;
  max-height: 60vh;
  overflow: scroll;
}
.login-header {
  margin: 10px;
  font-size: 50px;
}
.login-change {
  margin: 10px;
  font-size: 0.9em;
  color: #F5F5F5;
  transition: all 0.2s ease;
  border-radius: 0.25rem;
  padding: 2px;
  background-color: rgba(241,243,244,0.24);
}
.login-change:hover {
  cursor: pointer;
  background-color: rgba(0,0,0,0.18);
  text-decoration: none;
  border: 1px solid;
}
.login-form-item-value {
  width: 100%;
  border-radius: 0.25rem;
  padding: 5px;
  border: none;
  transition: all 0.2s ease;
}
.login-form-item {
  margin: 10px;
  display: flex;
  flex-direction: column;
}
.hide {
  position: absolute;
  right: 5px;
  top: 17px;
  transform: translate(0, -50%);
  color: rgba(0,0,0,0.6);
  transition: all 0.2 ease;
  border-radius: 0.25rem;
}
.hide:hover {
  cursor: pointer;
  color: rgba(0,0,0,0.8);
}
.submit:hover {
  background-color: rgba(0,0,0,0.18);
  cursor: pointer;
}
.submit {
  margin: 10px;
  padding: 10px;
  width: 30%;
  min-width: fit-content;
  text-align: center;
  border-radius: 0.25rem;
  border: 1px solid;
  background-color: rgba(241,243,244,0.24);
}
.login-form-item-error {
  box-shadow: 0 0 6px 6px rgba(255, 54, 54, 0.5) !important;
}
.login-form-item-error-message {
  font-size: 0.9em;
  margin-top: 7px;
  padding: 2px 5px;
  width: fit-content;
  background-color: rgba(241,243,244,0.24);
  border-radius: 0.25rem;
  color: rgba(255, 23, 4, 0.99);
}
</style>
