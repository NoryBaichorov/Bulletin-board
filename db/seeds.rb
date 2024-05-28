# frozen_string_literal: true

25.times do
  image = Rails.public_path.join('seeds/111.jpg').open

  draft = Bulletin.new(
    title: Faker::Name.unique.name,
    description: Faker::Markdown.emphasis,
    category_id: 1,
    user_id: 2,
    state: :draft
  )
  draft.image.attach(io: image, filename: '111.jpg', content_type: 'image/jpg')
  draft.save!
  sleep 1
end

25.times do
  image = Rails.public_path.join('seeds/111.jpg').open

  under_moderation = Bulletin.new(
    title: Faker::Name.unique.name,
    description: Faker::Markdown.emphasis,
    category_id: 1,
    user_id: 2,
    state: :under_moderation
  )
  under_moderation.image.attach(io: image, filename: '111.jpg', content_type: 'image/jpg')
  under_moderation.save!
  sleep 1
end

25.times do
  image = Rails.public_path.join('seeds/111.jpg').open

  published = Bulletin.new(
    title: Faker::Name.unique.name,
    description: Faker::Markdown.emphasis,
    category_id: 1,
    user_id: 2,
    state: :published
  )
  published.image.attach(io: image, filename: '111.jpg', content_type: 'image/jpg')
  published.save!
  sleep 1
end

25.times do
  image = Rails.public_path.join('seeds/111.jpg').open

  rejected = Bulletin.new(
    title: Faker::Name.unique.name,
    description: Faker::Markdown.emphasis,
    category_id: 1,
    user_id: 2,
    state: :rejected
  )
  rejected.image.attach(io: image, filename: '111.jpg', content_type: 'image/jpg')
  rejected.save!
  sleep 1
end

25.times do
  image = Rails.public_path.join('seeds/111.jpg').open

  archived = Bulletin.new(
    title: Faker::Name.unique.name,
    description: Faker::Markdown.emphasis,
    category_id: 1,
    user_id: 2,
    state: :archived
  )
  archived.image.attach(io: image, filename: '111.jpg', content_type: 'image/jpg')
  archived.save!
  sleep 1
end

Rails.logger.debug { "Created #{Bulletin.count} bulletins" }
