class AnnoncesController < ApplicationController
	before_action :find_annonce, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show, :search]
    def search
    	if params[:search].present?
    		@annonces = Annonce.search(params[:search])
    	else
    		@annonces = Annonce.all.order("created_at DESC").paginate(page: params[:page], per_page: 4)
    	end
    end

	def index
		if params[:category].blank?	
		@annonces = Annonce.all.order("created_at DESC").paginate(page: params[:page], per_page: 4)
	     else
	     	@category_id = Category.find_by(name: params[:category]).id
	     	@annonces = Annonce.where(:category_id => @category_id).order("created_at DESC").paginate(page: params[:page], per_page: 4)
		end
	end

	def myannonces
		@MyAnnonces = Annonce.where( :user_id => current_user.id )
	end

	def new
		@annonce = current_user.annonces.build
		@categories = Category.all.map{ |c| [c.name , c.id] }
	end

	def create
		@annonce = current_user.annonces.build(annonce_params)
		@annonce.category_id = params[:category_id]
		if @annonce.save
			redirect_to root_path
		else
			render 'new'
	    end
	end

	def show
    end

	def edit
		if @annonce.user_id == current_user.id 
		@categories = Category.all.map{ |c| [c.name , c.id] }
	    else
		 	redirect_to root_path
		end
	end

	def update
		@annonce.category_id = params[:category_id]
	    if @annonce.update(annonce_params)
	    	redirect_to @annonce
	    else
	    	render 'edit'
	    	
	    end
	end

	def destroy
		if @annonce.destroy
			redirect_to root_path
		else
			render 'show'
		end

	end
	
	private

	def annonce_params
       params.require(:annonce).permit(:title, :price, :description, :phone, :city, :image, :category_id)
	end

	def find_annonce
		@annonce = Annonce.find(params[:id])
	end
end
