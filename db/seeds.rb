# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# MoneyRecordCategory.create!([
#   { kind: MoneyRecord::KIND_INCOME, name: 'common' },
#   { kind: MoneyRecord::KIND_INCOME, name: 'support' },
#   { kind: MoneyRecord::KIND_CONSUMPTION, name: 'оплата работы' },
#   { kind: MoneyRecord::KIND_CONSUMPTION, name: 'покупка мат. активов' },
#   { kind: MoneyRecord::KIND_CONSUMPTION, name: 'оплата услуг' },
#   { kind: MoneyRecord::KIND_CONSUMPTION, name: 'выплаты государству' },
#   { kind: MoneyRecord::KIND_CONSUMPTION, name: 'дивиденты' },
#   { kind: MoneyRecord::KIND_CONSUMPTION, name: 'другое' }
# ])

nakamas = Nakama.create!([
  { name: "rick" },
  { name: "morty" },
  { name: "summer" }
])

PaymentRate.create!([
  { nakama: nakamas[0], hour_rate: 42.0, hour_cost: 46.4, active_from: Date.yesterday() },
  { nakama: nakamas[1], hour_rate: 10.0, hour_cost: 12.2, active_from: Date.yesterday() },
  { nakama: nakamas[2], hour_rate: 22.0, hour_cost: 25.0, active_from: Date.yesterday() },
])

clusters = Cluster.create!([
  { name: "Codenohito", descr: 'Internal tasks of our team' },
  { name: "Svezhov", descr: 'Website of «Свежов» company' }
])

projects = Project.create!([
  { cluster: clusters[0], name: "Growth", descr: 'Team growth work: learning, amrketing etc.' },
  { cluster: clusters[0], name: "CP", descr: 'Control panel' },
  { cluster: clusters[1], name: "TR", descr: 'Technical requirements' },
  { cluster: clusters[1], name: "Dev", descr: 'Website development' }
])

User.create!([
  {
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    nakama: nakamas[0],
    perms: 1
  },
  {
    email: 'user@example.com',
    password: 'password',
    password_confirmation: 'password',
    nakama: nakamas[1]
  }
])

TimeRecord.create!([
  {
    theday: Date.today,
    amount: 40,
    nakama: nakamas[0],
    project: projects[0],
    comment: 'Столы двигал, голым прыгал',
  },
  {
    theday: Date.today,
    amount: 130,
    nakama: nakamas[1],
    project: projects[1],
    comment: 'Вёрстка коробки',
  },
])
