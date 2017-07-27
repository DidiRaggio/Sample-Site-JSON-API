ActiveAdmin.register User do
 menu priority: 1
 permit_params :attributes, :email, :auth_token, :is_dev, :password , :password_confirmation, :picture, :_destroy
  config.sort_order = 'id_asc'
  controller do

    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end

  end

  form :html => { :multipart => true } do |f|
    f.inputs 'User' do
  	  f.input :email, :required => true
  	  f.input :password, :required => false
  	  f.input :password_confirmation, :required => false
  	  f.input :is_dev, :as => :boolean
  	  f.input :credit
      # f.input :picture, :as => :file






	  f.inputs "Picture", :multipart => true do 
	    f.input :picture, :as => :file, :hint => f.object.picture.present? \
	      ? image_tag(f.object.picture.url(:thumb))
	      : content_tag(:span, "no cover page yet")
	    # f.input :image_cache, :as => :hidden 
	  end






    end
    f.actions
  end




 show do |user|
      attributes_table do
      	row :email
      	row :encrypted_password
      	row :is_dev
      	row :credit
      	row :auth_token

        row :picture do 
           user.picture.url(:medium)
        	image_tag(user.picture.url(:medium))
        end
      	row :reset_password_token
      	row :reset_password_sent_at
      	row :remember_created_at
      	row :sign_in_count
      	row :current_sign_in_at
      	row :current_sign_in_ip
      	row :last_sign_in_at
      	row :last_sign_in_ip
      	row :created_at
      	row :updated_at
    end
 end

 # preserve_default_filters!
 filter :email
 filter :id
 filter :is_dev, as: :select, collection: [["DEVELOPER", true], ["INFLUENCER", false]], :label => 'ROLE'
 filter :picture
 filter :current_sign_in_ip, :label => 'IP'


  index do
	selectable_column
	column :id
  	column :email
  	# column :is_dev, :label => 'ROLE'
  	column :is_dev, :label => 'ROLE' do |user| 
      user.is_dev? ? status_tag( "DEVELOPER", :ok ) : status_tag( "INFLUENCER" )
    end
  	column :credit
	column :auth_token
	column "Picture" do |user|
	  image_tag(user.picture.url(:thumb))
	end

	actions
  end 


end
