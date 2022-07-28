<template>
  <div v-loading="loading" class="container">serch</div>
</template>

<script lang="ts">
import {
  defineComponent,
  computed,
  onMounted,
  useRoute,
  useRouter,
  ref,
  reactive,
  PropType,
} from "@nuxtjs/composition-api";
export default defineComponent({
  name: "SearchMenu",
});
</script>

<style scoped>
.container {
  padding: 16px;
}

.search-title {
  font-size: 16px;
  font-weight: bold;
}

.search-item {
  margin: 16px 0;
  width: 100%;
}

.search-label {
  font-size: 14px;
  margin-bottom: 8px;
}

.disable-button {
  width: 150px;
}

.search-button {
  width: 100%;
}

.input-date {
  width: 100%;
}

.input-left {
  width: 80%;
}

.input-select {
  width: 100%;
}

.unit-font {
  font-size: 14px;
}

.topkeyword-box {
  margin: 8px, 0;
}

.keyword-container {
  margin: 16px 0;
  display: flex;
  flex-flow: wrap;
}

.keyword-button {
  margin: 4px 4px 4px 0;
  font-size: 12px;
  color: black;
  white-space: normal;
  line-height: 16px;
}

.registration-info {
  margin: 16px 0;
  font-weight: bold;
}

.d-flex {
  display: flex;
  margin: 16px 0;
}

.offices-info {
  padding: 4px 0;
}

.propaty-name {
  color: #6f6f6f;
  font-size: 14px;
  width: 80px;
}

.company-info {
  font-size: 14px;
  color: #6f6f6f;
}

.company-name {
  font-size: 14px;
  color: #6f6f6f;
  font-weight: 600;
}
</style>
