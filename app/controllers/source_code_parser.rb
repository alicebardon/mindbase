class SourceCodeParser
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
    programming_language = file.content_type.split("/")[1]
    matches = file.read.scan(JS_COMMENT)
    matches.each do |content_pair|
      note = Note.create!(code_content: content_pair[0],
                          content: content_pair[1],
                          user: user,
                          file_path: '/app/code.txt',
                          language: programming_language)
      params[:note][:category_ids].each do |cat_id|
        CategoryNote.create!(note: note, category_id: cat_id.to_i)
      end
    end
  end
end
