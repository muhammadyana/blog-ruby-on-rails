class ArticlesController < ApplicationController
  impressionist :action=> [:show,:index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show] #can't create article without login
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :current_user, only: [:edit, :update, :destroy]
  # GET /articles
  # GET /articles.json
  
  def index
    #@articles = Article.all
    # @article = Article.friendly.find(params[:id])
    # impressionist(@article)
    @articleOrder = Article.article_order(params[:page])
    @articles = Article.order('created_at DESC').paginate(page: params[:page], :per_page => 4)
    # all.page(params[:page]).per(4)
    @articles_corousal = Article.all
    # use scope
    @article_paginate = Article.paginate(page: params[:page], :per_page => 4)
    @widgetArticle = Article.widget_article(params[:page])
    
  end
  def service
    @article = Article.all
    render json: @article
  end
  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.friendly.find(params[:id])
    impressionist(@article)
    @widgetArticle = Article.all.paginate(page: params[:page], :per_page => 3)
    @categories = Category.all
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, :image, :meta_keyword, category_ids: [])
    end

    def require_same_user
      if current_user != @article.user
        flash[:danger] = "you can only edit or delete ypur own article"
        redirect_to root_path
      end
    end
end
