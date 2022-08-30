JS_COMMENT = %r/^(.*)\/{2}\s*\$(.*)/
RUBY_COMMENT = /^(.*)#\s*\$(.*)/

sample_text = "// This is a javascript comment
              for (let i = 0; i < 10; i++) { // $ This is a javascript comment for Mindbase
                console.log(array[i]); // $ I would like to upload this to Mindbase
              # This is a ruby comment
              array.each do |elem| # $ This is a ruby comment for Mindbase
              # This is a python comment
              <!-- This is an HTML comment -->
              /* This is a CSS comment */"

js_code = "// This is a javascript comment
          for (let i = 0; i < 10; i++) { // $ This is a javascript comment for Mindbase
          console.log(array[i]); // $ I would like to upload this to Mindbase
          } // This is a comment I don't want to upload to Mindbase"

def parse_source_code(text)
  user = User.first
  matches = text.scan(JS_COMMENT)
  code_snippets = []
  comments = []
  matches.each do |match_pair|
    Note.create!(code_content: match_pair[0],
                 content: match_pair[1],
                 user: user,
                 file_path: '/app/code.txt',
                 language: 'javascript')
  end
  @notes = Note.all
end