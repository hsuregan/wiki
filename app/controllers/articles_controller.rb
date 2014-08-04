class ArticlesController < ApplicationController
	before_filter :authorize, only: [:new, :edit, :update, :destroy]

	
	def index
	@articles = Article.order(updated_at: :desc).limit(25)
	end
	
	def show
	@article = Article.find(params[:id])
	end
	
	def new
  		@article = Article.new
	end

	def create
  		@article = Article.new(article_params)
  		@article.user_id = User.find(session["user_id"]).id
  		if @article.save
    		redirect_to @article, notice: 'Your article has been published!'
  		else
    		render "new"
 		end
	end
    
   def destroy
        @article = Article.find(params[:id])   
        if (@article.user_id == User.find(session["user_id"]).id)
       		@article.delete
       		redirect_to action: "index"
       	else
			redirect_to @article, notice: "you have no right! you did not write!"
       	end
    end
    
    def edit
    end

	private
  	def article_params
    	params.require(:article).permit(:title, :content,  :user_id => 1, :category_ids => [])
  	end
  	
  	
  	
	end