ActiveAdmin.register Reservation do
  permit_params :event_place_id, :start_time, :end_time, :status

  scope :all
  scope :accepted
  scope :pending
  scope :rejected
  scope :cancelled



  before_create do |reservation|
    reservation.reserved_by = current_user
  end

  index do
    selectable_column
    id_column
    column :event_place

    if current_user.professor?
      column :reserved_by
    end

    column :start_time
    column :end_time
    column :status
    column :created_at
    actions
  end

  filter :event_place
  filter :reserved_by

  form do |f|
    f.inputs do
      if current_user.professor?
        f.input :event_place
        f.input :start_time, as: :datetime_picker
        f.input :end_time, as: :datetime_picker
        f.input :status, as: :select, collection: Reservation.statuses
      end

      if current_user.student?
        f.input :event_place, input_html: { disabled: object.persisted? }
        f.input :start_time, as: :datetime_picker, input_html: { disabled: object.persisted? }
        f.input :end_time, as: :datetime_picker, input_html: { disabled: object.persisted? }

        if object.accepted?
          f.input :status, as: :select, collection: Reservation.statuses, input_html: { disabled: true }
          f.input :status, label: "Change Status", as: :select, collection: ["cancelled"]
        end
      end
    end

    f.actions
  end
end
