ActiveAdmin.register SocialLink do
  permit_params :name, :url, :linkable_type, :linkable_id, :logo

  # index do
    # selectable_column
    # id_column

    # column :logo do |social_link|
    #   image_tag url_for(social_link.thumbnail) if social_link.logo.persisted?
    # end

    # column :name
    # column :url
    # column :linkable_type
    # column :linkable_id
    # actions
  # end

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :linkable_type, as: :select, collection: ['Post', 'Partner', 'Project'] # You can expand this list as you add more entities
      f.input :linkable_id
      f.input :logo, as: :file
    end
    f.actions
  end

  # show do
  #   attributes_table do
  #     row :name
  #     row :url
  #     row :linkable_type
  #     row :logo do |social_link|
  #       image_tag url_for(social_link.logo) if social_link.logo.persisted?
  #     end
  #   end
  # end
end
