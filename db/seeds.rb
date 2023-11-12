# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

Gladiator.create([
                   {
                     name: 'Spartacus',
                     age: 30,
                     attack_points: 80,
                     experience_points: 20
                   },
                   {
                     name: 'Gannicus',
                     age: 35,
                     experience_points: 15
                   },
                   {
                     name: 'Oenomaus',
                     age: 40,
                     attack_points: 90,
                     experience_points: 30
                   },
                   {
                     name: 'Varro',
                     age: 20
                   },
                   {
                     name: 'Barca',
                     age: 20,
                     attack_points: 70,
                     experience_points: 29
                   }
                 ])

Tool.create(
  name: 'The sword of the gods',
  toolable: Weapon.create(attack_points: 50)
)

Tool.create(
  name: 'The hammer of the eden',
  toolable: Weapon.create(attack_points: 100)
)

Tool.create(
  name: 'The arrow of the Odin',
  toolable: Weapon.create(attack_points: 70)
)

Tool.create(
  name: 'The shield of the athen',
  toolable: Shield.create(protection_points: 50)
)

Tool.create(
  name: 'The cloack of invibilty',
  toolable: Shield.create(protection_points: 100)
)

Tool.create(
  name: 'The shield of the truth',
  toolable: Shield.create(protection_points: 70)
)
