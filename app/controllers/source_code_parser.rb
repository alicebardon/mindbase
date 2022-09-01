class SourceCodeParser

  LANGUAGE_EXTENSION = {
    ruby: %w[rb],
    perl: %w[pl],
    python: %w[py],
    r: %w[r],
    erlang: %w[erl],
    javascript: %w[js],
    c: %w[c],
    cpp: %w[cpp cc],
    java: %w[java],
    kotlin: %w[kt],
    c_sharp: %w[cs],
    php: %w[php],
    golang: %w[go],
    rust: %w[rs],
    haskell: %w[hs],
    html: %w[htm html],
    css: %w[css scss]
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
    html: "<!--  -->",
    css: "/*  */"
  }

  # This pattern captures all of the text on the same line as the special comment,
  # as well as everything that comes afterwards, up to the special closing comment.
  # A special comment is the language's comment character directly followed by a dollar sign ($).
  # A closing comment is the language's comment character directly followed by two dollar signs ($$).
  # e.g. in Java a special comment would be //$ and a special closing comment would be //$$.
  COMMENT_PATTERNS = {
    "//" => /^(.*)\/{2}\$([^$]*)\n([^$]*)\/{2}\${2}/,
    "#" => /^(.*)#\$([^\$]*)\n([^\$]*)#\${2}/,
    "<!--  -->" => /^(.*)<!--\$([^\$]*)-->([^\$]*)<!--\${2}/,
    "/*  */" => /^(.*)\/\*\$([^$]*)\*\/([^$]*)\/\*\${2}/,
    "--" => /^(.*)\-{2}\$([^$]*)\n([^$]*)--\${2}/,
    "%" => /^(.*)%\$([^\$]*)\n([^\$]*)\%\${2}/
  }

  def self.parse_file(file, params, user)
    params[:note][:category_ids].delete("")
    file_name = params[:source_code].original_filename
    code_language = file_name.split(".").last
    match_pattern = COMMENT_PATTERNS[LANGUAGE_COMMENT_CHAR[code_language.to_sym]]
    matches = file.read.scan(match_pattern)
    matches.each do |content|
      note = Note.create!(before_comment: content[0],
                          comment: content[1],
                          after_comment: content[2],
                          user: user,
                          file_path: file_name,
                          language: code_language)
      params[:note][:category_ids].each do |cat_id|
        CategoryNote.create!(note: note, category_id: cat_id.to_i)
      end
    end
  end
end
