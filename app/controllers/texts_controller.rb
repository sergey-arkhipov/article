class TextsController < ApplicationController
  before_action :set_text, :set_article, only: %i[update destroy]

  def edit
    @text = Text.find(params[:id])
  end

  def update
    if version_changed?(@text, params) && get_new_version(@text, params).save
      redirect_to article_url(@article), notice: 'Новая версия была успешно создана.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    if can_destroy?
      @text.destroy
      redirect_to article_url(@article), notice: 'Версия была успешно удалена'
    else
      redirect_to article_url(@article), notice: 'Нельзя удалить активную версию! '
    end
  end

  private

  def get_new_version(text, params)
    text_new_version = text.dup #
    text_new_version.changed_on = DateTime.current # Устанавливаем текущую дату
    text_new_version.text = params['text']['text']
    text_new_version
  end

  def can_destroy?
    @text.id != @text.article.active_text_id
  end

  def set_text
    @text = Text.find(params[:id])
  end

  def version_changed?(text, text_params)
    if text.text == text_params['text']['text']

      text.errors.add('Содержание:', 'Нет изменений для создания новой версии')
      return false
    end
    true
  end

  def set_article
    @article = Article.find(@text.article_id)
  end
end
