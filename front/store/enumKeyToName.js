export const companyCategoryLabel = (category) => {
  switch (category) {
    case "athletic":
      return "運動";
    case "culture":
      return "文化";
    case "art":
      return "芸術";
  }
};
export const placesLabel = (place) => {
  switch (place) {
    case "daiiti":
      return "第一エリア";
    case "daini":
      return "第二エリア";
    case "daisan":
      return "第三エリア";
    case "kasuga":
      return "春日エリア";
    case "taigei":
      return "体育・芸術エリア";
    case "other":
      return "その他";
  }
};

export const acitivityDayLabel = (day) => {
  switch (day) {
    case "mon":
      return "月";
    case "tue":
      return "火";
    case "wed":
      return "水";
    case "thu":
      return "木";
    case "fri":
      return "金";
    case "sat":
      return "土";
    case "sun":
      return "日";
    case "other":
      return "不定期";
  }
};
