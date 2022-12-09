<template>
  <el-container class="default-layout">
    <!-- ヘッダー -->
    <el-header class="header-container">
      <div class="title"><img :height="80" src="logo.png" alt="" /></div>
      <div class="menu-container">
        <el-menu
          class="header-menu"
          mode="horizontal"
          active-text-color="#651cb7"
        >
          <el-menu-item index="new">
            <i class="el-icon-s-order new"></i>全てのサークル
          </el-menu-item>
          <el-menu-item index="ranking">
            <i class="el-icon-s-flag flag"></i>急上昇
          </el-menu-item>
          <el-menu-item index="favorite">
            <i class="el-icon-star-on star"></i>お気に入り
          </el-menu-item>
        </el-menu>
      </div>
    </el-header>
    <!-- ヘッダー -->

    <!-- コンテナー -->
    <el-container class="center-container">
      <el-aside width="240px" class="aside-container"> </el-aside>

      <el-main class="card-container">
        <el-empty
          v-if="users.users != undefined && users.users.length == 0"
          description="条件に当てはまるデータがありません"
        />
        <div class="grid-container">
          <div
            v-for="user in users.users"
            :key="user.id"
            @click="toShow(user.company.id)"
            class="grid-item"
          >
            <el-card v-if="user" :body-style="{ padding: '0px' }">
              <div class="name">{{ user.display_name }}</div>
              <div class="name">{{ user.email }}</div>
              <div class="detail-container">
                <p v-if="user.company" class="ellipsis">
                  {{ user.company.name }}
                </p>
              </div>
            </el-card>
          </div>
        </div>
      </el-main>
    </el-container>
    <!-- コンテナー -->
    <el-footer></el-footer>
  </el-container>
</template>

<script>
import { computed, defineComponent, reactive } from "@nuxtjs/composition-api";
export default defineComponent({
  mounted() {
    this.getUsers();
  },
  onMounted() {
    this.getCategory();
  },
  name: "DefaultLayout",
  data() {
    const item = {
      date: "2016-05-02",
      name: "Tom",
      address: "No. 189, Grove St, Los Angeles",
    };
    const state = reactive({
      users: [],
    });
    return {
      users: Object,
    };
  },
  methods: {
    getUsers() {
      this.$axios.$get("/users").then((response) => {
        this.$data.users = response;
      });
    },
    toShow(id) {
      this.$router.push(`/companies/${id}`);
    },
  },
});
</script>

<style scoped>
.card-container,
.header-menu > li.is-active > i.star {
  background-color: #f3f4f7;
}

.header-container {
  display: flex;
  height: 60px;
  box-sizing: border-box;
  border-bottom: 1px solid #eee;
  padding: 0;
}

.title {
  display: flex;
  align-items: center;
  width: 240px;
  box-sizing: border-box;
  cursor: pointer;
}
.menu-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: calc(100% - 240px);
}

.image {
  width: 100%;
  display: block;
  height: 150px;
  object-fit: cover;
}

.menu-container > div {
  margin: auto 12px;
}
.card-center {
  justify-content: center;
}
.grid-container {
  display: grid;
  grid-template-columns: 350px 350px 350px;
  justify-content: center;
  padding-top: 20px;
}
.grid-item {
  padding: 16px;
  text-align: center;
}
.name {
  font-size: 18px;
  font-weight: bold;
  text-align: left;
  margin: 16px;
}
.ellipsis {
  width: 250px;
  font-size: 12px;
  white-space: nowrap;
  color: #a1a1a1;
  overflow: hidden;
  text-overflow: ellipsis;
}

.el-card {
  border-radius: 15px;
}

.detail-container {
  margin: 16px;
  border-bottom: 1px solid #9f4bff;
}
.keyword-container {
  font-size: 12px;
  text-align: left;
  margin: 16px;
}
.keyword-tag {
  margin-right: 4px;
}
.second-keyword-container {
  margin: 16px 16px 0;
  font-size: 12px;
  text-align: left;
}
.el-icon-location,
.el-icon-user-solid,
.el-icon-date {
  color: #a1a1a1;
  margin-right: 5px;
}
.between {
  justify-content: space-between;
  display: flex;
  align-items: center;
}
.sns-link-container > a > img {
  width: 30px;
}
.sns-link-container {
  margin: 12px 12px 8px 0;
}
.search-item {
  margin-bottom: 28px;
  width: 100%;
}
.aside-container {
  padding: 40px 16px 16px;
}
.search-button {
  width: 100%;
  background-color: #6b00e3;
  color: white;
  border-radius: 10px;
}
.select,
.radio {
  margin-bottom: 28px;
  width: 100%;
}
.search-label {
  font-size: 12px;
  font-weight: bold;
  margin-bottom: 8px;
}
</style>
