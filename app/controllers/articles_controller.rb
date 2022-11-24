class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :set_search, only: :index

  # GET /articles or /articles.json
  def index
    @pagy, @articles = pagy_elasticsearch_rails(@articles, items: 3)
    render :index, locals: { query: params[:query] }
  end

  # GET /articles/1 or /articles/1.json
  def show
    # console
    @text = Text.find(@article.texts.ids)
    version = params[:version] ? params[:version].to_i : @text.count - 1
    render :show, locals: { version: }
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.texts.build
  end

  # GET /articles/1/edit
  def edit
    text = Text.find(params[:version])
    render :edit, locals: { edit: 'edit', text: }
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'Cтатья была успешно создана.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  # def update
  #   respond_to do |format|
  #      if check_params(@article, article_params) && gets_version(@article, article_params).save
  #       format.html { redirect_to article_url(@article), notice: 'Article version was successfully created.' }
  #       format.json { render :show, status: :ok, location: @article }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @article.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Return Elasticseach when search or all
  def set_search
    @articles = if params[:query].present?
                  search = "#{helpers.sanitize(params[:query])}*"
                  Article.pagy_search(search).records
                else
                  Article.pagy_search('*').records
                end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:id, :author, :title, :version, :status, :changed_on,
                                    texts_attributes: %i[text changed_on archive])
  end
end
