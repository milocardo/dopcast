class Search
  CATEGORIES = %w[business comedy education sports technology science politics society arts design society music other]
  TYPES = %w[podcast episode playlist]
  DURATIONS = ['0 - 15 min', '15 - 30 min', '30 - 45 min', '45 - 60 min', 'over 1 hour']
  LANGUAGES = %w[English Spanish French Portuguese Other]
  SORTBY = %w[popularity relevance rating newest oldest]

  def self.categories
    make_collection(CATEGORIES)
  end

  def self.types
    make_collection(TYPES)
  end

  def self.durations
    make_collection(DURATIONS)
  end

  def self.sortby
    make_collection(SORTBY)
  end

  def self.languages
    make_collection(LANGUAGES)
  end

  def self.make_collection(constant)
    constant.map do |element|
      [element.to_sym, element.capitalize]
    end
  end
end
