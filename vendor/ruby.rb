# Tестовые задания


# class Array

#   def my_map
#     return unless block_given?

#     result = []
#     i = 0

#     while self[i] do
#       result << yield(self[i])
#       i += 1
#     end
#     result
#   end

#   def my_map(&block)
#     return unless block_given?

#     result = []

#     each do |el|
#       result << block.call(el)
#     end
#   result
#   end
# end

# module MyModule
#   def my_attr_accessor(*args)
#     args.each do |arg|
#       define_method arg do
#         self.instance_variable_get("@#{arg}")
#       end

#       define_method "#{arg}=" do |value|
#         self.instance_variable_set("@#{arg}", value)
#       end
#     end
#   end
# end

# class Car
#   extend MyModule
#   my_attr_accessor :name, :age

#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end

# class Text
#   def initialize(body, format)
#     @format = format
#     @body = body
#   end

#   def formatted
#     puts @format.render(@body)
#   end
# end

# class HtmlFormat
#   def render(text)
#     "<div> #{text} </div>"
#   end
# end

# class JsonFormat
#   def render(text)
#     "{ body: #{text} }"
#   end
# end

# text = Text.new('My message', HtmlFormat.new)
# text.formatted

# array = [1, 2, 3, 4, 5, 5, 6, 7, 8, 8, 9]
# puts array.uniq
# puts '============================================'
# puts array.select { |i| array.count(i) > 1 }.uniq

# require 'set'
# puts '============================================'
# puts new_arr = Set.new(array)

# def reverse(str)
#   rev_str = []

#   str.each_char do |c|
#     rev_str.unshift c
#   end

#   rev_str = rev_str.join
# end

# def type_of_type(value)
#   [Hash, Range, Array].include?(value.class) ? :complex : :simple
# end

# require 'date'

# def next_day
#   Date.today.next.to_time
# end

# module MyNumber
#   def self.reverse_int(num)
#     reversed_num = num.to_s.reverse.to_i.abs
#     num.positive? ? reversed_num : -reversed_num
#   end
# end

# def invert_case(str)
#   result = ''

#   str.each_char do |c|
#     c.downcase == c ? result += c.upcase : result += c.downcase
#   end
#   result
# end

# def intersection(arr1, arr2)
#   result = []

#   arr1.each do |el|
#     result << el if arr2.include? el
#   end
#   result
  
#   arr1 & arr2
# end

# data = [
# ['11-9-2020', 'russia', 10_000],
# ['11-10-2020', 'usa', 35_000],
# ['13-12-2020', 'india', 55_000],
# ['12-11-2020', 'russia', 13_000],
# ['12-12-2020', 'usa', 22_000],
# ['11-12-2020', 'india', 54_000],
# ]

# def sort_cases(data)
#   data.sort_by do |row|
#     day, month, year =  row.first.split('-')
    
#     Time.new(year, month, day)
#   end.reverse
# end

# def get_words_count_by_lang(text)
#   # text.split.tally
  
#   words = text.split(' ')
#   result = {}

#   words.each do |word|
#     result[word] ||= 0
#     result[word] += 1
#   end
#   result
# end

# data = {
#   'Queen' => [
#     'Bohemian Rhapsody',
#     "Don't Stop Me Now"
#   ],
#   'Metallica' => [
#     'Nothing Else Matters'
#   ],
#   "Guns N' Roses" => [
#     'Paradise City',
#     'November Rain'
#   ],
#   'AC/DC' => [
#     'Thunderstruck',
#     'Back In Black',
#     'Shoot to Thrill'
#   ]
# }

# def plainify(data)
#   result = []
  
#   data.each do |band, songs|
#     songs.each do |song|
#       result << { band:, song: }
#     end
#   end
#   result

#   # data.keys.flat_map do |band|
#   #   data[band].map { |song| { band:, song: } }
#   # end
# end

# data = [
#   ['ruby', 'dynamic', 'strong'],
#   ['js', 'dynamic', 'weak'],
#   ['c', 'static', 'weak'],
#   ['kotlin', 'static', 'strong']
# ]

# def convert(data)
#   # data.map do |langs|
#   #   lang_name, lang_type, lang_diff = langs
#   #   [lang_name, lang_diff]
#   # end

#   # data.map { |lang_name, _, lang_diff| [lang_name, lang_diff] }
# end

# hash1 = { key: 'value' }
# hash2 = { key2: 'value2' }
# hash3 = { key3: 'value3', key: 'new value' }

# def merge_all(hash, *hashes)
#   hash.merge(*hashes)
# end

# puts merge_all(hash1, hash2, hash3)

# def link_to(name, link, attributes = {})
#   attr_pairs = attributes.any? ? [''] : []

#   attributes.each do |key, value|
#     attr_pairs << "#{key}=\"#{value}\""
#   end

#   attr_line = attr_pairs.join(' ')
#   "<a href=\"#{link}\"#{attr_line}>#{name}</a>"
# end

# users = [
#   { name: 'Bronn', gender: 'male', birthday: '1973-03-23' },
#   { name: 'Reigar', gender: 'male', birthday: '1973-11-03' },
#   { name: 'Eiegon', gender: 'male', birthday: '1963-11-03' },
#   { name: 'Sansa', gender: 'female', birthday: '2012-11-03' },
#   { name: 'Jon', gender: 'male', birthday: '1980-11-03' },
#   { name: 'Robb', gender: 'male', birthday: '1980-05-14' },
#   { name: 'Tisha', gender: 'female', birthday: '2012-11-03' },
#   { name: 'Rick', gender: 'male', birthday: '2012-11-03' },
#   { name: 'Joffrey', gender: 'male', birthday: '1999-11-03' },
#   { name: 'Edd', gender: 'male', birthday: '1973-11-03' }
# ]

# def get_men_count_by_year(users)
#   years = []

#   users.map do |user|
#     years << user[:birthday].split('-').first if user[:gender] == 'male'
#   end
#   years.tally
# end

# def apply_blocks(data, blocks)
#   blocks.each { |proc| data = proc.call(data) }
#   data
# end

# proc1 = proc { |x| x + 1 }
# proc2 = proc { |x| x * 2 }

# strings = ['wow?', 'One?', 'tWo!', 'THREE']

# def convert(strings)
#   strings.filter do |str|
#     str.end_with?('?')
#   end.map(&:downcase).sort
# end

# def my_filter(coll)
#   res = []

#   coll.map do |v|
#     res << v if yield(v)
#   end
#   res
# end

# sentence = 'hexlet helps people to become developers'

# def words_by_letters(sentence)
#   words = sentence.split

#   words.each_with_object({}) do |word, acc|
#     acc[word[0]] ||= []
#     acc[word[0]] << word
#   end
# end

# def gen_diff(obj1, obj2)
#   keys = obj1.keys | obj2.keys

#   keys.each_with_object({}) do |key, acc|
#     acc[key] =
#     if !obj1.key?(key)
#       'added'
#     elsif !obj2.key?(key)
#       'deleted'
#     elsif obj1[key] == obj2[key]
#       'unchanged'
#     else
#       'changed'
#     end
#   end
# end

# puts gen_diff(
# { one: 'eon', two: 'two', four: true },
# { two: 'own', zero: 4, four: true }
# )

# def leap_year?(year)
#   (year % 400).zero? || (year % 4).zero? && !(year % 100).zero? ? true : false
# end

# def method(arr)
#   result = []

#   arr.each do |el|
#     result << el
#   end
#   result
# end

# select * from User
# where User.id = (select user_id from Bucket where user_id = 2)

# Необходимо найти все слова для которых действительны следующие условия:

#     1. Следующее слово начинается с большой буквы
#     2. Слово расположено на нечётной линии


# str = "Дисперсия, в первом приближении, в принципе транслирует интеграл Пуассона.
# То, что написано на этой странице неправда! Следовательно: связное множество
# стремительно привлекает возрастающий скачок функции, таким образом сбылась
# мечта идиота - утверждение полностью доказано. Линейное уравнение, как
# следует из вышесказанного, проецирует изоморфный разрыв функции. Собственное
# подмножество позитивно проецирует разрыв функции, в итоге приходим к
# логическому противоречию. Правда, некоторые специалисты отмечают, что
# иррациональное число накладывает интеграл от функции, обращающейся в
# бесконечность вдоль линии.

# Скачок функции нейтрализует контрпример. Высшая арифметика изменяет
# ортогональный определитель, что несомненно приведет нас к истине. Теорема
# Ферма специфицирует контрпример. Огибающая семейства прямых, как следует из
# вышесказанного, непосредственно обуславливает максимум."


# def capitalized?(word)
#   word == word.capitalize
# end


# str.each_line.with_index do |line, index|
#   if (index.even?) && (line != "\n")
#     words_collection = line.split(' ')

#     words_collection[1..-1].each.with_index do |word, index|
#       following_word = words_collection[index+1]

#       if capitalized?(following_word)
#         words_collection[index]
#       end

#     end
#   end
# end



# Дано: день пребывания в отеле в рабочий день стоит 1000р, а в выходной 1500р.
# Задача: написать код который посчитает стоимость за пребывание в течении X дней(не включительно)
# с указанной даты. Можно пользоваться любой документацией, тут главное сам процесс разработки, 
# и просто рабочий результат (не нужно перфекционизма)
# 
## Friday 05.02.2021 = 1000 + 3000
# puts calc(Date.new(2021, 2, 5), 3)
# # Monday 3000
# puts calc(Date.new(2021, 2, 1), 3)
# # Friday 05.02.2021 = 1000 + 3000 + 2000
# puts calc(Date.new(2021, 2, 5), 5)
# 
# require 'date'

# def calc(date, days_count)
#   cost = 0
#   sum = 0

#   days_count.times do 
#     if date.saturday? || date.sunday?
#       cost = 1500
#     else
#       cost = 1000
#     end
#     sum += cost
#     date += 1
#   end
#   puts sum
# end

# calc(Date.new(2021, 2, 5), 5)