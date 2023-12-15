ActiveAdmin.register EventPlace do
  permit_params :name, :location

  before_create do |event_place|
    event_place.created_by = current_user
  end

  index do
    selectable_column
    id_column
    column :name
    column :location
    column :created_by
    column :created_at
    actions
  end

  filter :name
  filter :location

  form do |f|
    f.inputs do
      f.input :name
      f.input :location
    end
    f.actions
  end

end
