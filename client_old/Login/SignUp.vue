<template>
  <div class="login">
    <div class="login-header">Авторизация</div>
    <a @click="changeSign" class="login-change">нет аккаунта?</a>
    <div class="login-form-item-error-message" v-if="errorMessage !== ''">{{ errorMessage }}</div>
    <div class="login-form">
      <div class="login-form-item">
        <div class="login-form-item-title">Email</div>
        <input type="password" name="password" value="" style="display: none" />
        <input :maxlength="50"
               v-model="email"
               type="text"
               readonly
               @focus="onItemFocus"
               placeholder="username@email.adr"
               :class="['login-form-item-value', { 'login-form-item-error': emailErrorMessage !== '' }]"/>
        <div class="login-form-item-error-message" v-if="emailErrorMessage !== ''">{{ emailErrorMessage }}</div>
      </div>
      <div class="login-form-item">
        <div class="login-form-item-title">Пароль</div>
        <div style="position: relative">
          <input :maxlength="50"
                 v-model="password"
                 :type="passwordShow ? 'text' : 'password'"
                 readonly
                 @focus="onItemFocus"
                 style="padding-right: 28px"
                 :class="['login-form-item-value', { 'login-form-item-error': passwordErrorMessage !== '' }]"/>
          <div class="login-form-item-error-message" v-if="passwordErrorMessage !== ''">{{ passwordErrorMessage }}</div>
          <i :class="['bx', passwordShow ? 'bx-hide' : 'bx-show', 'hide']" style="font-size: 1.3em"
             @click="passwordShow = !passwordShow"/>
        </div>
      </div>
    </div>
    <div style="width: 100%; display: flex; justify-content: right">
      <div class="submit" @click="submit">войти</div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'SignUp',
  data () {
    return {
      pathCheckSignUp: 'http://localhost:5050/checkSignUp',
      items: [],
      errorMessage: '',
      email: '',
      emailErrorMessage: '',
      password: '',
      passwordShow: '',
      passwordErrorMessage: ''
    }
  },
  methods: {
    submit () {
      this.errorMessage = ''
      if (this.email === '') {
        this.emailErrorMessage = 'email обязателен'
      } else if (!String(this.email)
        .toLowerCase()
        .match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)) {
        this.emailErrorMessage = 'email должен соответствовать шаблону username@email.adr'
      } else {
        this.emailErrorMessage = ''
      }
      if (this.password === '') {
        this.passwordErrorMessage = 'пароль обязателен'
      } else if (this.password.length < 6) {
        this.passwordErrorMessage = 'длина пароля от 6 до 50 символов'
      } else {
        this.passwordErrorMessage = ''
      }
      if (this.emailErrorMessage === '' && this.passwordErrorMessage === '') {
        axios.post(this.pathCheckSignUp, { email: this.email, password: this.password })
          .then((res) => {
            if (!res.data.isValid) {
              this.emailErrorMessage = 'email или пароль неверны'
            } else {
              this.$emit('signUp', res.data.user)
            }
          })
          .catch((error) => {
            this.errorMessage = error
            console.error(error)
          })
      }
    },
    changeSign () {
      this.$emit('changeSign')
    },
    onItemFocus (event) {
      event.srcElement.removeAttribute('readonly')
      event.stopPropagation()
    }
  },
  props: {
    defaultItems: {
      type: Array,
      default: () => []
    }
  },
  mounted () {
    this.items = this.defaultItems
  }
}
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
  box-shadow: 0 0 6px 6px rgba(255, 54, 54, 0.5);
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
