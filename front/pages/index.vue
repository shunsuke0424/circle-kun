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
      <el-aside width="240px" class="aside-container">
        <el-form class="form" :model="state" label-width="120px">
          <div class="search-label">フリーワード検索</div>
          <el-input
            v-model="keyword"
            class="search-item"
            placeholder="キーワード"
            clearable
          />
          <div class="search-label">分野で絞る</div>
          <el-radio-group
            v-model="company_category"
            class="radio"
            size="medium"
            @change="getCategory"
          >
            <el-radio-button label="athletics">運動</el-radio-button>
            <el-radio-button label="arts">芸術</el-radio-button>
            <el-radio-button label="cultures">文化</el-radio-button>
          </el-radio-group>

          <div class="search-label">カテゴリで絞る</div>
          <el-select
            class="select"
            v-model="category_name"
            clearable
            placeholder="カテゴリ"
          >
            <el-option key="all" label="全て" :value="null" />
            <el-option
              v-for="category in categories.categories"
              :key="category.id"
              :label="category.name"
              :value="category.name"
            >
            </el-option>
          </el-select>
          <div class="search-label">活動場所で絞る</div>
          <el-select
            class="select"
            v-model="place"
            multiple
            clearable
            placeholder="活動場所で絞る"
          >
            <el-option value="daiiti" label="第一エリア"></el-option>
            <el-option value="daini" label="第二エリア"></el-option>
            <el-option value="daisan" label="第三エリア"></el-option>
            <el-option value="kasuga" label="春日エリア"></el-option>
            <el-option value="taigei" label="体育・芸術エリア"></el-option>
            <el-option value="other" label="その他"></el-option>
          </el-select>
          <div class="search-label">活動曜日で絞る</div>
          <el-select
            multiple
            clearable
            class="select"
            v-model="day"
            placeholder="活動曜日で絞る"
          >
            <el-option value="mon" label="月曜日"></el-option>
            <el-option value="tue" label="火曜日"></el-option>
            <el-option value="wed" label="水曜日"></el-option>
            <el-option value="thu" label="木曜日"></el-option>
            <el-option value="fri" label="金曜日"></el-option>
            <el-option value="sat" label="土曜日"></el-option>
            <el-option value="sun" label="日曜日"></el-option>
            <el-option value="other" label="不定期"></el-option>
          </el-select>
          <el-button @click="search" class="search-button">
            検索する　<i class="el-icon-search"></i>
          </el-button>
        </el-form>
      </el-aside>

      <el-main class="card-container">
        <el-empty
          v-if="
            companies.companies != undefined && companies.companies.length == 0
          "
          description="条件に当てはまるデータがありません"
        />
        <div class="grid-container">
          <div
            v-for="company in companies.companies"
            :key="company.id"
            @click="toShow(company.id)"
            class="grid-item"
          >
            <el-card :body-style="{ padding: '0px' }">
              <div v-if="company.images_path">
                <img :src="`img/${company.images_path}`" class="image" />
              </div>
              <div v-if="!company.images_path">
                <img src="img/empty.png" class="image" />
              </div>
              <div class="name">{{ company.name }}</div>
              <div class="detail-container">
                <p class="ellipsis">{{ company.detail }}</p>
              </div>
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
                  size="mini"
                  class="category-tag"
                >
                  {{ companyCategoryLabel(company.company_category) }}
                </el-tag>
                <el-tag
                  v-if="company.culture"
                  type="success"
                  size="mini"
                  effect="plain"
                  class="category-tag"
                >
                  {{ company.culture.name }}
                </el-tag>
                <el-tag
                  v-if="company.art"
                  type="primary"
                  size="mini"
                  effect="plain"
                  class="category-tag"
                >
                  {{ company.art.name }}
                </el-tag>
                <el-tag
                  v-if="company.athletic"
                  type="danger"
                  size="mini"
                  effect="plain"
                  class="category-tag"
                >
                  {{ company.athletic.name }}
                </el-tag>
              </div>
              <div class="keyword-container">
                <el-tag
                  v-for="keyword in company.keywords"
                  :key="keyword.id"
                  type="warning"
                  size="mini"
                  class="category-tag keyword-tag"
                >
                  {{ keyword.content }}
                </el-tag>
              </div>
              <!-- カテゴリ -->
              <div class="keyword-container">
                <i class="el-icon-location"></i>
                <span
                  v-for="place in company.places"
                  :key="place.id"
                  class="info"
                >
                  {{ placesLabel(place.place)
                  }}<el-divider direction="vertical"></el-divider>
                </span>
              </div>
              <div class="second-keyword-container">
                <i class="el-icon-user-solid"></i>
                <span class="info"> {{ company.number || "-" }}名 </span>
              </div>
              <div class="between">
                <div class="keyword-container">
                  <i class="el-icon-date"></i>
                  <span
                    v-for="day in company.activity_day"
                    :key="day.id"
                    class="info"
                  >
                    {{ acitivityDayLabel(day.activity_day)
                    }}<el-divider direction="vertical"></el-divider>
                  </span>
                </div>
                <div class="sns-link-container">
                  <a v-if="company.twitter_link" :href="company.twitter_link">
                    <img src="Twitter-Logo.svg" alt=""
                  /></a>
                  <a
                    v-if="company.instagram_link"
                    :href="company.instagram_link"
                  >
                    <img src="Instagram.svg" alt="" />
                  </a>
                </div>
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
import CompanyCard from "../components/CompanyCard.vue";
import {
  companyCategoryLabel,
  placesLabel,
  acitivityDayLabel,
} from "../store/enumKeyToName";
export default defineComponent({
  mounted() {
    this.getCompanies();
  },
  onMounted() {
    this.getCategory();
  },
  name: "DefaultLayout",
  components: { CompanyCard },
  data() {
    const item = {
      date: "2016-05-02",
      name: "Tom",
      address: "No. 189, Grove St, Los Angeles",
    };
    const state = reactive({
      keyword: "",
      company_category: "",
      category_name: "",
      place: "",
      day: "",
      companies: [],
      categories: [],
    });
    return {
      companies: Object,
      categories: Object,
      keyword: "",
      company_category: "",
      day: "",
      place: "",
      category_name: "",
      state,
      companyCategoryLabel,
      placesLabel,
      acitivityDayLabel,
    };
  },
  methods: {
    getCompanies() {
      this.$axios.$get("/companies").then((response) => {
        this.$data.companies = response;
      });
    },
    search() {
      this.loading = true;
      const url = "/companies";
      this.$axios
        .$get(url, {
          params: {
            keyword: this.keyword,
            company_category: this.company_category,
            athletic_id: this.athletic_id,
            culture_id: this.culture_id,
            art_id: this.art_id,
            category_name: this.category_name,
            place: this.place,
            day: this.day,
          },
        })
        .then((response) => {
          this.$data.companies = response;
        });
    },
    getCategory(category) {
      this.loading = true;
      this.$axios.$get("/" + category).then((response) => {
        this.$data.categories = response;
      });
    },
    selectCompanyCategory(companyCategory) {
      if (companyCategory) {
        getCities(companyCategory);
      }
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
