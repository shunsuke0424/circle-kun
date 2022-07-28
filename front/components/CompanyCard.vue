<template>
  <el-card>
    <el-container> {{ name }} </el-container>
  </el-card>
</template>
<script>
import {
  defineComponent,
  PropType,
  useRouter,
  computed,
} from "@nuxtjs/composition-api";
export default defineComponent({
  name: "CompanyCard",
  props: {
    company: {
      type: Object,
      required: true,
    },
  },

  setup(props) {
    const router = useRouter();
    const clickCompany = (companyId) => {
      router.push("/companies/" + companyId);
    };

    const name = computed(() => props.company.name);

    return {
      clickCompany,
      name,
    };
  },
});
</script>

<style lang="postcss" scoped></style>
