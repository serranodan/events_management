ActiveAdmin.register User do
  permit_params :email, :name, :role, :password, :password_confirmation

  scope :all
  scope :professor
  scope :student

  controller do
    def update
      model = :user

      if params[model][:password].blank?
        %w(password password_confirmation).each { |p| params[model].delete(p) }
      end

      super
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :role
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :role
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name

      if current_user.professor?
        f.input :role, as: :select, collection: User.roles
      end

      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
