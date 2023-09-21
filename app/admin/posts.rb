ActiveAdmin.register Post do
  permit_params :name, :short_description, :long_description, 
  :date, :photo, social_links_attributes: [:id, :name, :url, :_destroy]

  index do
    selectable_column
    id_column
    column :photo do |post|
      image_tag url_for(post.thumbnail) if post.photo.persisted?
    end
    column :name
    column :short_description do |post| 
      raw post.short_description
    end
    column :long_description do |post|
      raw post.long_description 
    end
    column :date
    actions
  end

  filter :name
  filter :date

  form do |f|
    f.inputs do
      f.input :name
      f.input :short_description
      f.input :long_description
      f.input :date
      f.input :photo, as: :file
    end
    f.inputs 'Social Media Links' do
      f.has_many :social_links, heading: 'Links', allow_destroy: true do |link_f|
        link_f.input :name, label: 'Social Network Name', hint: 'e.g. Instagram'
        link_f.input :url, label: 'Profile Link', hint: 'e.g. https://www.instagram.com/archangels.in.ua/{{POST_ID}}'
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :short_description do |post| 
        raw post.short_description
      end
      row :long_description do |post|
        raw post.long_description
      end
      row :date
      row :social_links
      row :photo do |post|
        image_tag url_for(post.photo) if post.photo.persisted?
      end
    end
  end
end
