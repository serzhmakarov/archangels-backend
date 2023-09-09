ActiveAdmin.register SocialLink do
  permit_params :name, :url, :linkable_type, :linkable_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :linkable_type, as: :select, collection: ['Report', 'Partner', 'Project'] # You can expand this list as you add more entities
      f.input :linkable_id
    end
    f.actions
  end
end
