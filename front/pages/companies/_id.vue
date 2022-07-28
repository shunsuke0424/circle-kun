<template>
  <el-container>
    <!-- ヘッダー -->
    <el-header class="header-container">
      <div @click="toTop()" class="title">
        <img :height="80" src="logo.png" alt="" />
      </div>
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
    <el-main class="main-container">
      <el-row type="flex" justify="center">
        <el-col :span="20">
          <div class="title-container">
            <div class="title-text">
              {{ company.name }}
            </div>
            <el-button
              type="warning"
              icon="el-icon-star-off"
              size="mini"
              class="favorite"
              plain
              @click="open1()"
            >
              <span>お気に入り </span>
            </el-button>
          </div>
        </el-col>
      </el-row>
      <el-row type="flex" justify="center">
        <el-col :span="20" class="divider">
          <el-divider></el-divider>
        </el-col>
      </el-row>

      <el-row type="flex" justify="center">
        <el-col :span="10"
          ><div v-if="company.images_path" class="image-container grid-content">
            <img :src="`../img/${company.images_path}`" class="image" />
          </div>
          <div v-if="!company.images_path" class="image-container grid-content">
            <img src="/empty.png" class="image" /></div
        ></el-col>
        <el-col :span="10"
          ><div class="circle-info-container grid-content">
            <div>
              <!-- カテゴリ -->
              <div class="keyword-container">
                <el-tag
                  :type="
                    company.company_category == 'art'
                      ? 'primary'
                      : company.company_category == 'culture'
                      ? 'success'
                      : company.company_category == 'athletic'
                      ? 'danger'
                      : 'plain'
                  "
                  class="category-tag"
                >
                  {{ companyCategoryLabel(company.company_category) }}
                </el-tag>
                <el-tag v-if="company.culture" type="info" class="category-tag">
                  {{ company.culture.name }}
                </el-tag>
                <el-tag v-if="company.art" type="info" class="category-tag">
                  {{ company.art.name }}
                </el-tag>
                <el-tag
                  v-if="company.athletic"
                  type="info"
                  class="category-tag"
                >
                  {{ company.athletic.name }}
                </el-tag>
              </div>
              <!-- カテゴリ -->
              <div class="keyword-container">
                <i class="el-icon-location"></i
                ><span class="explain-label">メンバー：</span>
                <span
                  v-for="place in company.places"
                  :key="place.id"
                  class="info"
                >
                  {{ placesLabel(place.place) }}
                </span>
              </div>
              <div class="keyword-container">
                <i class="el-icon-user-solid"></i
                ><span class="explain-label">活動場所：</span>
                <span class="info"> {{ company.number || "-" }}名 </span>
              </div>
              <div class="keyword-container">
                <i class="el-icon-date"></i
                ><span class="explain-label">活動曜日：</span>
                <span
                  v-for="day in company.activity_day"
                  :key="day.id"
                  class="info"
                >
                  {{ acitivityDayLabel(day.activity_day)
                  }}<el-divider direction="vertical"></el-divider>
                </span>
              </div>
              <div v-if="company.hp_link" class="keyword-container">
                <i class="el-icon-link"></i
                ><span class="explain-label">サイトリンク：</span>
                <a v-if="company.hp_link" :href="company.hp_link">
                  <span class="info"> {{ company.hp_link }} </span>
                </a>
              </div>

              <div class="sns-link-container">
                <a
                  class="twi-link"
                  v-if="company.twitter_link"
                  :href="company.twitter_link"
                >
                  <img src="Twitter-Logo.svg" alt=""
                /></a>
                <a
                  class="ins-link"
                  v-if="company.instagram_link"
                  :href="company.instagram_link"
                >
                  <img src="Instagram.svg" alt="" />
                </a>
              </div>
            </div></div
        ></el-col>
      </el-row>
      <el-row type="flex" justify="center"
        ><el-col :span="20">
          <div class="detail-section">
            <div class="detail-label">
              <el-divider content-position="left">団体紹介</el-divider>
            </div>
            {{ company.detail }}
          </div>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<script>
import {
  companyCategoryLabel,
  placesLabel,
  acitivityDayLabel,
} from "@/store/enumKeyToName";
export default {
  data: () => {
    return {
      company: {},
      companyCategoryLabel,
      placesLabel,
      acitivityDayLabel,
    };
  },

  mounted() {
    this.fetchContent();
  },

  methods: {
    toTop() {
      this.$router.push("/");
    },
    open1() {
      this.$notify({
        title: "お気に入りに追加しました",
        type: "success",
      });
    },
    fetchContent() {
      const url = `/companies/${this.$route.params.id}`;
      this.$axios
        .get(url)
        .then((res) => {
          this.company = res.data;
        })
        .catch(() => {
          this.toTop();
        });
    },
  },
};
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
  height: auto;
  object-fit: cover;
  border-radius: 10px;
}

.menu-container > div {
  margin: auto 12px;
}
.title-container {
  font-size: 24px;
  padding: 40px 40px 0;
  font-weight: bold;
  display: flex;
  justify-content: space-between;
}
.image-container {
  padding: 40px;
}
.circle-info-container {
  padding: 40px;
}
.info {
  font-size: 16px;
}
.el-icon-location,
.el-icon-user-solid,
.el-icon-date,
.el-icon-link {
  color: #a1a1a1;
  margin-right: 5px;
}
.explain-label {
  color: #a1a1a1;
  margin-right: 8px;
}
.keyword-container {
  margin: 24px 24px 24px 0;
}
.twi-link > img {
  width: 50px;
}
.ins-link > img {
  width: 55px;
}
.detail-section {
  padding: 40px;
}
.detail-label {
  font-weight: bold;
  margin-bottom: 40px;
}
.el-divider__text {
  font-size: 18px;
  font-weight: bold;
}
.divider {
  padding: 0 40px;
}
</style>
