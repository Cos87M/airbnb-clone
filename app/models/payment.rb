class Payment < ApplicationRecord
  # Establishes a relationship indicating that each payment belongs to a reservation
  belongs_to :reservation

  # Adds methods to handle money values for subtotal, allowing nil values
  monetize :subtotal_cents, allow_nil: true
  
  # Adds methods to handle money values for cleaning fee, allowing nil values
  monetize :cleaning_fee_cents, allow_nil: true
  
  # Adds methods to handle money values for service fee, allowing nil values
  monetize :service_fee_cents, allow_nil: true
  
  # Adds methods to handle money values for total amount, allowing nil values
  monetize :total_cents, allow_nil: true
end
