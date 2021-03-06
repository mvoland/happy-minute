require 'administrate/base_dashboard'

class ItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    business: Field::BelongsTo,
    happy_prices: Field::HasMany,
    item_photo_attachment: Field::ActiveStorage,
    # item_photo_blob: Field::HasOne,
    item_tags: Field::HasMany,
    tags: Field::HasMany,
    category: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    price: Field::String.with_options(searchable: false),
    available: Field::Boolean,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    position: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    business
    title
    price
    happy_prices
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    business
    happy_prices
    item_tags
    tags
    category
    id
    title
    price
    available
    description
    created_at
    updated_at
    position
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    business
    happy_prices
    tags
    category
    title
    price
    available
    description
    position
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how items are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(item)
    "##{item.id} #{item.title}"
  end
end
