#this file belongs in config/initializers

class String
  def is_mbid
    if self.length==36
      l=self.split("-")
      if l[0].length==8 &&
          l[1].length==4 &&
          l[2].length==4 &&
          l[3].length==4 &&
          l[4].length==12
        return true
      else
        return false
      end
    end
  end

  def titleize_proper
    excluded_from_title=["a","an","the","and", "but", "or", "so",
                         "after", "before", "when", "while", "since",
                         "until", "although", "even if", "because",
                         "both", "either", "neither", "nor","as",
                         "at", "by", "for", "from", "in", "into",
                         "of", "off", "on", "onto", "than", "to",
                         "via", "with", "anti", "betwixt", "circa",
                         "per", "qua", "sans", "unto", "versus",
                         "vis-a-vis","ago", "hence",  "through",
                         "withal"]

    string_array=self.split(' ')
    title=Array.new
    string_array.each_with_index do |word,i|

      if i==0
        title<<word.capitalize
      elsif excluded_from_title.include?(word)
        title<<word
      else
        title<<word.capitalize
      end

    end
    title.join(' ')
  end

end
