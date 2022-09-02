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
  # A special comment is the language's comment character directly followed by a dollar sign ($).
  # A closing comment is the language's comment character directly followed by two dollar signs ($$).
  # e.g. in Java a special comment would be //$ and a special closing comment would be //$$.
  COMMENT_PATTERNS = {
    "//" => /^(.*)\/{2}\$([^$\n]*)$([^$]*)[\/{2}]{0,1}\${2}/,
    "#" => /^(.*)#\$([^\$]*)\${2}/,
    "<!--  -->" => /^(.*)<!--\$([^\$]*)[-->]*([^\$]*)\${2}-->/,
    "/*  */" => /^(.*)\/\*\$([^$]*)[\*\/]*([^$]*)\${2}\*\//,
    "--" => /^(.*)\-{2}\$([^$]*)\R*(.*)[--]*\${2}/,
    "%" => /^(.*)%\$([^$\n]*)\n*(.*)\%*\${2}/
  }

  def self.parse_file(file, params, user)
    params[:note][:category_ids].delete("")
    file_name = params[:source_code].original_filename
    programming_language = LANGUAGE_EXTENSION[file_name.split(".").last.downcase.to_sym]

    # Create category for programming language if it does not yet exist
    matching_categories = Category.where("name ILIKE :query", query: "%#{programming_language}%")
    if matching_categories.empty?
      Category.create(name: programming_language.capitalize, category_type: "language", user: user)
    else
      language_category = matching_categories.first
    end
    match_pattern = COMMENT_PATTERNS[LANGUAGE_COMMENT_CHAR[programming_language.downcase.to_sym]]
    matches = file.read.scan(match_pattern)
    matches.each do |content|
      clean_content = clean_text(content, programming_language)
      note = Note.create!(before_comment: clean_content[0],
                          comment: clean_content[1],
                          after_comment: clean_content[2],
                          user: user,
                          file_path: file_name,
                          language: programming_language)
      # Place note in its language category
      CategoryNote.create(note: note, category: language_category)
      # Place note in the categories selected by the user
      params[:note][:category_ids].each do |cat_id|
        CategoryNote.create!(note: note, category_id: cat_id.to_i)
      end
    end
  end

  def self.clean_text(note, language)
    # raise
    code_before_comment = note.first
    if note.last.include?("\n")
      note_parts = note.last.partition("\n")
      comment = note_parts.first.strip
      code_after_comment = note_parts.last
      if code_after_comment.end_with?(LANGUAGE_COMMENT_CHAR[language.downcase.to_sym])
        code_after_comment.chomp!(LANGUAGE_COMMENT_CHAR[language.downcase.to_sym]).chomp!
      end
    else
      comment = note.last.strip
      code_after_comment = ""
    end
    [code_before_comment, comment, code_after_comment]
  end
end
