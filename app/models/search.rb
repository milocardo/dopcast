class Search
  CATEGORIES = [
   [122, "Society & Culture"],
   [93, "Business"],
   [68, "TV & Film"],
   [111, "Education"],
   [77, "Sports & Recreation"],
   [107, "Science & Medicine"],
   [88, "Health"],
   [82, "Games & Hobbies"],
   [100, "Arts"],
   [99, "News & Politics"],
   [132, "Kids & Family"],
   [133, "Comedy"],
   [134, "Music"],
   [127, "Technology"],
  ]

  TYPES = %w[podcast episode playlist]
  DURATIONS = [
    ['0,15', '0 - 15 min'],
    ['0,30', '0 - 30 min'],
    ['0,45', '0 - 45 min'],
    ['0,60', '0 - 60 min'],
    ['0,1000', 'over 1 hour']
  ]
  LANGUAGES = %w[English Spanish French Portuguese]
  SORTBY = %w[popularity relevance rating newest oldest]

  def self.categories
    CATEGORIES
  end

  def self.types
    make_collection(TYPES)
  end

  def self.durations
    DURATIONS
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
