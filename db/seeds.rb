# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Gladiator.create([
  {
    name: 'Spartacus',
    age: 30,
    attack_points: 80
  },
  {
    name: 'Gannicus',
    age: 35
  },
  {
    name: 'Oenomaus',
    age: 40,
    attack_points: 90
  },
  {
    name: 'Varro',
    age: 20
  },
  {
    name: 'Barca',
    age: 20,
    attack_points: 70
  },
])
