# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Pending Reservations" do
          table do
            thead do
              tr do
                th "Event Place"
                th "Reserved By"
                th "Status"
                th
              end
            end
            tbody do
              Reservation.pending.map do |reservation|
                tr do
                  td reservation.event_place.name
                  td reservation.reserved_by.name
                  td reservation.status
                  td link_to("View", admin_reservation_path(reservation))
                end
              end
            end
          end
        end
      end

      column do
        panel "Total Accepted Current or Upcomming Reservations" do
          table do
            thead do
              tr do
                th "Event Place"
                th "Location"
                th "Total Reservations"
              end
            end
            tbody do
              EventPlace.all.map do |event_place|
                tr do
                  td event_place.name
                  td event_place.location
                  td event_place.reservations.accepted.upcomming.count
                end
              end
            end
          end
        end
      end
    end
  end
end
