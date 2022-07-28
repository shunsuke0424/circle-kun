class ActivityDay
  class << self
    def all
      {
        mon: '月',
        tue: '火',
        wed: '水',
        thu: '木',
        fri: '金',
        sat: '土',
        sun: '日',
        other: '不定期',
      }
    end

    def enum_hash
      all.keys.map(&:to_s).map { |k| { k => k } }.inject(&:merge)
    end

    def to_options
      all.map { |key, name| { key: key, name: name } }
    end

    def to_option(key)
      { key: key.to_s, name: all[key.to_sym] }
    end
  end
end
