# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

MoneyAccount.create([
  { name: 'основной' },
  {
    name: 'защитный',
    descr: 'Тут нужно собрать и держать сумму, которая позволила бы два месяца' \
           ' жить без какого-либо дохода. Гарантированные оплаты постоянных' \
           ' специалистов, деньги на оплату периодических услуг: хостинг,' \
           ' ведение счетов в банке, репозиторий и пр.'
  },
  {
    name: 'развития',
    descr: 'Счёт для перевода 20% от прибыли. Эти деньги планируется тратить' \
           ' на развитие: покупка книг, поездки на конференции и пр.'
  }
])
