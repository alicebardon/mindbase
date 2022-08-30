class NotesController < ApplicationController
  JS_COMMENT = %r/^(.*)\/{2}\s*\$(.*)/
  RUBY_COMMENT = %r/^(.*)#\s*\$(.*)/
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

  def parse_source_code(text)

  end
end
