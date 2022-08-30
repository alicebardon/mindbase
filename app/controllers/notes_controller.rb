class NotesController < ApplicationController
  JS_COMMENT = %r/^(.*)\/{2}\s*\$(.*)/
  RUBY_COMMENT = /^(.*)#\s*\$(.*)/

  @sample_text = '// This is a javascript comment' \
                 'for (let i = 0; i < 10; i++) { // $ This is a javascript comment for Mindbase' \
                 '# This is a ruby comment' \
                 'array.each do |elem| # $ This is a ruby comment for Mindbase' \
                 '# This is a python comment' \
                 '<!-- This is an HTML comment -->' \
                 '/* This is a CSS comment */'


  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def parse_source_code(text)\
    raise

  end
end
