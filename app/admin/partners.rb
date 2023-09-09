# TODO: change full_description to long_description
# TODO: implement correct way to add project for partners and separate at the same time. You know what i mean:)

ActiveAdmin.register Partner do
  permit_params :name, :short_description, :full_description, :project_ids,
  :date, :photo, social_links_attributes: [:id, :name, :url, :_destroy]
  
  index do
    selectable_column
    id_column
    column :name
    column :short_description
    column :full_description
    
    column :projects do |partner| 
      partner.projects.count
    end
    
    column :photo do |partner|
      image_tag url_for(partner.photo) if partner.photo.persisted?
    end

    actions
  end

  filter :name
  filter :date

  form do |f|
    f.inputs do
      f.input :name
      f.input :short_description
      f.input :full_description
      f.input :photo, as: :file
    end

    # f.inputs 'Project Details' do
    #   f.input :name
    #   f.input :short_description
    #   f.input :full_description
    #   f.input :partners, as: :check_boxes
    # end

    f.inputs 'Social Media Links' do
      f.has_many :social_links, heading: 'Links', allow_destroy: true do |link_f|
        link_f.input :name, label: 'Social Network Name', hint: 'e.g. Instagram'
        link_f.input :url, label: 'Profile Link', hint: 'e.g. https://www.instagram.com/yourusername/'
      end
    end
    
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :short_description
      row :full_description
      row :social_links
      row :projects
      row :photo do |partner|
        image_tag url_for(partner.photo) if partner.photo.persisted?
      end
    end
  end
end
