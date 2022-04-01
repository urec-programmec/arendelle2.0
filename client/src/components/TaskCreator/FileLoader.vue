<template>
  <div class="container">
      <!--UPLOAD-->
      <form enctype="multipart/form-data" novalidate v-if="isInitial || isSaving">
        <div :class="['dropbox', { 'dropbox-saving': isSaving }]">
          <input type="file" multiple :name="uploadFieldName" :disabled="isSaving" @change="filesChange($event.target.name, $event.target.files);"
                 accept="image/*" class="input-file">
          <div class="i">
            <i v-if="isInitial || isSaving" :class="['bx', { 'bx bx-loader-alt bx-super-spin': isSaving }, { 'bx-image-add': isInitial } ]"></i>
          </div>
        </div>
      </form>
      <!--SUCCESS-->
      <div v-if="isSuccess">
        <ul class="bx bx-revision list-unstyled" @click="reset()">
          <li v-for="(item, index) in uploadedFiles" :key="index">
            <img id="image" :src="item.url" class="img-responsive img-thumbnail" :alt="item.originalName">
          </li>
        </ul>
      </div>
      <!--FAILED-->
      <div v-if="isFailed">
        <h2>Файл не был загружен</h2>
        <p>
          <a href="javascript:void(0)" @click="reset()">попробовать снова</a>
        </p>
        <pre>{{ uploadError }}</pre>
      </div>
    </div>
</template>

<script>
// swap as you need
// import { upload } from './file-upload.service';   // real service
// import { wait } from './utils';
const STATUS_INITIAL = 0;
const STATUS_SAVING = 1;
const STATUS_SUCCESS = 2;
const STATUS_FAILED = 3;
export default {
  name: 'FileLoader',
  data() {
    return {
      uploadedFiles: [],
      uploadError: null,
      currentStatus: null,
      uploadFieldName: 'photos',
    };
  },
  computed: {
    isInitial() {
      return this.currentStatus === STATUS_INITIAL;
    },
    isSaving() {
      return this.currentStatus === STATUS_SAVING;
    },
    isSuccess() {
      return this.currentStatus === STATUS_SUCCESS;
    },
    isFailed() {
      return this.currentStatus === STATUS_FAILED;
    },
  },
  methods: {
    reset() {
      this.currentStatus = STATUS_INITIAL;
      this.uploadedFiles = [];
      this.uploadError = null;
      this.formData = null;

      this.$emit('fileUpload', { formData: this.formData });
      this.$emit('changeSize', { w: 0, h: 0 });
    },
    save() {
      // upload data to the server
      this.currentStatus = STATUS_SAVING;
      this.upload()
        .then((x) => {
          this.uploadedFiles = [].concat(x);
          this.currentStatus = STATUS_SUCCESS;
          this.$emit('fileUpload', { formData: this.formData });
        })
        .catch((err) => {
          console.error(err);
          this.uploadError = err.response;
          this.currentStatus = STATUS_FAILED;
        });
    },
    filesChange(fieldName, fileList) {
      this.formData = new FormData();
      if (!fileList.length) return;
      this.formData.append('image', fileList[0], fileList[0].name);
      this.save();
    },
    upload() {
      const photos = this.formData.getAll('image');
      const promises = photos.map(x => this.getImage(x)
        .then(img => ({
          id: img,
          originalName: x.name,
          fileName: x.name,
          url: img,
        })));
      return Promise.all(promises);
    },
    getImage(file) {
      return new Promise((resolve, reject) => {
        const fReader = new FileReader();
        const img = document.createElement('img');
        img.onload = (event) => {
          this.$emit('changeSize', { w: event.target.width, h: event.target.height });
        };
        fReader.onload = () => {
          img.src = fReader.result;
          resolve(img.src);
        };
        fReader.readAsDataURL(file);
      });
    },
    // getBase64Image(img) {
      // const canvas = document.createElement('canvas');
      // canvas.width = img.width;
      // canvas.height = img.height;
      //
      // const ctx = canvas.getContext('2d');
      // ctx.drawImage(img, 0, 0);
      // const dataURL = img.src;
      // return dataURL;
    // },
  },
  mounted() {
    this.reset();
  },
};
</script>

<style scoped>
.container {
  width: fit-content;
  color: #F5F5F5;
}
.container p a {
  padding: 2px 5px;
  margin: 0;
  border-radius: 0.5rem;
  color: #F5F5F5;
  background: rgba(241,243,244,0.14);
  width: fit-content;
}
.dropbox {
  border: 2px dashed #F5F5F5;
  border-radius: 0.25rem;
  /*outline-offset: -10px;*/
  background: rgba(33, 37, 41, 0.6);
  height: 300px;
  width: 300px;
  position: relative;
  cursor: pointer;
}
.dropbox-saving,
.dropbox:hover {
  background: rgba(33, 37, 41, 0.8);
}
.dropbox p {
  font-size: 1.2em;
  text-align: center;
  padding: 50px 0;
}
.dropbox .i {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  color: #F5F5F5;
  font-size: 2em;
}
.input-file {
  opacity: 0; /* invisible but it's there! */
  width: 100%;
  height: 100%;
  position: absolute;
  cursor: pointer;
}
.dropbox-saving,
.dropbox-saving .input-file {
  cursor: wait;
}
.bx-super-spin {
  animation: spin 2s linear infinite;
}
.list-unstyled {
  position: relative;
}
.list-unstyled:before {
  position: absolute;
  opacity: 0;
}
.list-unstyled:hover:before {
  border-radius: 0.25rem;
  background: rgba(33, 37, 41, 0.6);
  opacity: 1;
  height: 100%;
  width: 100%;
  cursor: pointer;
  color: #F5F5F5;
  border: 1px dashed #F5F5F5;
  font-size: 2em;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
