class SourceCodeParser
  OPENING_CHAR = "$"
  CLOSING_CHAR = "$$"

  LANGUAGE_EXTENSION = {
    rb: "Ruby",
    pl: "Perl",
    py: "Python",
    r: "r",
    erl: "erlang",
    js: "javascript",
    c: "c",
    cpp: "C++",
    java: "Java",
    kt: "kotlin",
    cs: "C#",
    php: "PHP",
    go: "Golang",
    rs: "Rust",
    hs: "Haskell",
    html: "HTML",
    htm: "HTML",
    css: "CSS",
    scss: "CSS"
    }

  LANGUAGE_COMMENT_CHAR = {
    ruby: "#",
    perl: "#",
    python: "#",
    r: "#",
    erlang: "%",
    javascript: "//",
    c: "//",
    cpp: "//",
    java: "//",
    kotlin: "//",
    c_sharp: "//",
    php: "//",
    golang: "//",
    rust: "//",
    haskell: "--",
    html: "<!--",
    css: "/*"
  }

  # This pattern captures all of the text on the same line as the special comment,
  # as well as everything that comes afterwards, up to the special closing comment.
  # A special comment is the language's comment character followed by (a whitespace and) a dollar sign ($).
  # A closing comment is the language's comment character followed by (a whitespace and) two dollar signs ($$).
  # e.g. in Java a special comment would be //$ and a special closing comment would be //$$.
  COMMENT_PATTERNS = {
    "//" => /^(.*)\/{2}\s*\$([^$]*)\${2}/,
    "#" => /^(.*)#\s*\$([^\$]*)\${2}/,
    "--" => /^(.*)--\s*\$([^$]*)\${2}/,
    "%" => /^(.*)%\s*\$([^$]*)\s*\${2}/,
    "<!--" => /^(.*)<!--\s*\$([^\$]*)\${2}/,
    "/*" => /^(.*)\/\*\s*\$([^$]+)\${2}/
  }

  def self.parse_file(file, params, user)
    params[:note][:category_ids].delete("")
    file_name = params[:source_code].original_filename
    programming_language = LANGUAGE_EXTENSION[file_name.split(".").last.downcase.to_sym]

    # Create category for programming language if it does not yet exist
    language_category = Category.find_by("name = :query", query: programming_language.capitalize) ||
                        Category.create(name: programming_language.capitalize, category_type: "Language", user:)
    match_pattern = COMMENT_PATTERNS[LANGUAGE_COMMENT_CHAR[programming_language.downcase.to_sym]]
    matches = file.read.scan(match_pattern)
    matches.each do |match|
      clean_content = clean_text(match, programming_language)
      note = Note.create!(comment: clean_content.first,
                          code: clean_content.second,
                          user:,
                          file_name:,
                          language: programming_language)
      # Place note in its language category
      CategoryNote.create(note:, category: language_category)
      # Place note in the categories selected by the user
      params[:note][:category_ids].each do |cat_id|
        CategoryNote.create!(note:, category_id: cat_id.to_i)
      end
    end
  end

  def self.clean_text(note, language)
    # code comes after the comment
    if note.first.strip == ""
      note_parts = note.last.partition("\n")
      comment = note_parts.first.strip
      code = note_parts.last.strip
      if code.end_with?(LANGUAGE_COMMENT_CHAR[language.downcase.to_sym])
        code.chomp!(LANGUAGE_COMMENT_CHAR[language.downcase.to_sym]).chomp!
      end
    # code comes before the comment (inline comment)
    else
      code = note.first.strip
      comment = note.second.strip
    end
    [comment, code]
  end
end
