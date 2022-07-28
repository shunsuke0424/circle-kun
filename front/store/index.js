import Vuex from "vuex";

export const appStore = () => {
  return new Vuex.Store({
    state: {
      serchData: {
        keyword: "",
      },
    },
    mutations: {},
    actions: {},
  });
};
export default appStore;
