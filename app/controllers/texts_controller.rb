class TextsController < ApplicationController
  before_action :set_text, :set_article, only: :update

  def edit
    @text = Text.find(params[:id])
    # @article = Article.find(@text.article_id)
    render :edit, locals: { text: @text, text_button: 'Создать новую версию!' }
  end

  def update
    respond_to do |format|
      if check_params(@text, params) && gets_version(@text, params).save
        format.html { redirect_to article_url(@article), notice: 'Новая версия была успешно создана.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity, locals: { text: @text, text_button: 'Создать новую версию!' } }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def check_params(text, text_params)
    if text.text == text_params['text']['text']

      text.errors.add('Содержание:', 'Нет изменений для сохранения')
      return false
    end
    true
  end

  def gets_version(text, text_params)
    text_orig = Text.find(text.id)
    text_version = text_orig.dup
    text_version.text = text_params['text']['text']
    text_version.changed_on = DateTime.current
    text_version
  end

  def set_text
    @text = Text.find(params[:id])
  end

  def set_article
    @article = Article.find(@text.article_id)
  end
end
