# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

projects = Project.create([
  { name: "Codenohito", descr: 'Internal tasks' },
  { name: "Svezhov", descr: 'Сайт компании «Свежов»' }
])

nakamas = Nakama.create([
  { name: "dymio" },
  { name: "riceking" }
])

TimeRecord.create([
  {
    theday: Date.today,
    amount: 40,
    nakama: nakamas[0],
    project_id: projects[0],
    comment: 'Столы двигал, голым прыгал',
  },
  {
    theday: Date.today,
    amount: 130,
    nakama: nakamas[1],
    project_id: projects[2],
    comment: 'Вёрстка коробки',
  },
])

MoneyRecordCategory.create([
  { kind: MoneyRecord::KIND_INCOME, name: 'common' },
  { kind: MoneyRecord::KIND_INCOME, name: 'support' },
  { kind: MoneyRecord::KIND_CONSUMPTION, name: 'оплата работы' },
  { kind: MoneyRecord::KIND_CONSUMPTION, name: 'покупка мат. активов' },
  { kind: MoneyRecord::KIND_CONSUMPTION, name: 'оплата услуг' },
  { kind: MoneyRecord::KIND_CONSUMPTION, name: 'выплаты государству' },
  { kind: MoneyRecord::KIND_CONSUMPTION, name: 'дивиденты' },
  { kind: MoneyRecord::KIND_CONSUMPTION, name: 'другое' }
])
