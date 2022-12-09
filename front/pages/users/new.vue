<template>
  <div class="container">
    <el-card>
      <div slot="header" class="form-header">
        <p>ユーザー新規作成</p>
        <div class="button-group">
          <el-button type="primary" class="submit-button" @click="submit()">
            保存する
          </el-button>
        </div>
      </div>
      <el-form ref="form" class="form" :model="state" label-width="150px">
        <el-form-item label="所属サークル" prop="company_id">
          <el-select
            v-model="state.company_id"
            placeholder="選択..."
            class="category-select"
          >
            <el-option
              v-for="company in companies.companies"
              :key="company.id"
              :label="company.name"
              :value="company.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="氏名" required>
          <div class="inline">
            <el-form-item prop="last_name">
              <el-input
                v-model="state.last_name"
                placeholder="田中"
                class="input-name"
              />
            </el-form-item>
            <el-form-item prop="first_name">
              <el-input
                v-model="state.first_name"
                placeholder="太郎"
                class="input-name"
              />
            </el-form-item>
          </div>
        </el-form-item>
        <el-form-item label="メールアドレス" prop="email">
          <el-input
            v-model="state.email"
            class="input-text"
            placeholder="hojokin@example.com"
          />
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script lang="ts">
import {
  computed,
  defineComponent,
  onUnmounted,
  useRouter,
  reactive,
  onMounted,
  ref,
} from "@nuxtjs/composition-api";

export default defineComponent({
  mounted() {
    this.getCompanies();
  },
  // onMounted() {
  //   this.getCompanies();
  // },
  name: "NewUser",
  data() {
    const state = reactive({
      email: "",
      first_name: "",
      last_name: "",
      company_id: null,
      companies: [],
    });
    return {
      users: Object,
      companies: Object,
      email: "",
      first_name: "",
      last_name: "",
      company_id: null,
      state,
    };
  },
  methods: {
    getCompanies() {
      this.$axios.$get("/companies").then((response) => {
        this.$data.companies = response;
      });
    },
    submit() {
      this.loading = true;
      const url = "/users";
      this.$axios
        .$post(url, {
          first_name: this.state.first_name,
          last_name: this.state.last_name,
          email: this.state.email,
          company_id: this.state.company_id,
        })
        .then(() => {
          this.$router.push(`/users/`);
        });
    },
    toShow(id) {
      this.$router.push(`/companies/${id}`);
    },
  },
});
</script>

<style lang="postcss" scoped>
.form-header {
  display: flex;
  justify-content: space-between;
}

.button-group {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.submit-button {
  height: fit-content;
}
.input-text {
  width: 400px;
}

.input-name {
  width: 190px;
  margin-right: 20px;
}

.input-number {
  width: 240px;
}

.category-select {
  width: 400px;
}

.submit-button {
  height: fit-content;
}

.inline {
  display: flex;
}

@media screen and (max-width: 1200px) {
  .form-header {
    flex-direction: column;
    overflow: scroll;
  }
}
</style>
