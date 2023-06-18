# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(email: "admin@archangels.in.ua", password: "12345678")

50.times do 
  Post.create(
    name: "Генератор у Форпост Донеччини🇺🇦",
    date: '08.03.2023',
    short_description:
     "Наш Фонд передав генератор, щоб військові та поліцейські, які несуть там службу, змогли облаштувати пункт для цивільних, де можно заряджати телефони, ліхтарі і інші прилади.",
    long_description:
     "Форпост Донеччини🇺🇦\r\n\r\nВелика Новосілка- прифронтове селище в Донецькій області, яке росіяни намагаються захопити із березня 2022 року. Майже рік  селище під постійним вогнем артилерії та авіації. \r\n\r\nНе дивлячись на гуманітарну катастрофу, відсутність світла, тепла, води- весь цей час там залишаються люди і маленькі діти. \r\n\r\nНаш Фонд передав генератор, щоб військові та поліцейські, які несуть там службу, змогли облаштувати пункт для цивільних, де можно заряджати телефони, ліхтарі і інші прилади. \r\n\r\nНагадуємо, що підтримати нас можно за реквізитами: \r\nБО \"БФ \"АРХАНГЕЛЬЄРИ КИЄВА\"\r\nЄДРПОУ 44733736\r\nР/р UA373003460000026003000002157\r\nв UAH, EUR, USD\r\nПризначення: БЛАГОДІЙНА ДОПОМОГА",
  );
end


50.times do |i|
  Partner.create(
    name: "Нова Пошта",
    short_description: "Лідер на ринку експрес-доставок в Україні надає послуги швидкої, 
    зручної та надійної доставки документів, 
    посилок та вантажів в будь-яку точку країни.",
    full_description: "This is Partner #{i+1} full description",
    social_networks: "{\"instagram\"=>\"https://www.instagram.com/archangelsofkyiv\", \"telegram\"=>\"https://www.instagram.com/archangelsofkyiv\"}"
  )
end

Partner.all.each do |partner|
  5.times do |i|
    partner.projects.create(
      name: "Підтримка Благодійних Організацій",
      date: DateTime.now,
      short_description: "Проект підтримки безкоштовними відправками по Україні від Нової Пошти",
      full_description: "Проект підтримки безкоштовними відправками по Україні від Нової Пошти",
      social_networks: "{\"instagram\"=>\"https://www.instagram.com/archangelsofkyiv\", \"telegram\"=>\"https://www.instagram.com/archangelsofkyiv\"}"
      priority: 0,
    )
  end

  partner.projects.last.update(priority: 1)
end