class Place
  class << self
    def all
      {
        daiiti: '第一エリア',
        daini: '第二エリア',
        daisan: '第三エリア',
        kasuga: '春日エリア',
        taigei: '体育・芸術エリア',
        other: 'その他',
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
