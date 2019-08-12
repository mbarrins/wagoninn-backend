# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

user_types = [
  {position: 'Owner', allow_override: true}, 
  {position: 'Manager', allow_override: true}, 
  {position: 'Employee', allow_override: false}
]
user_types.each{|type| UserType.find_or_create_by(type)} 

user = {
  user_type: UserType.find_by(position: 'Manager'),
  username: 'user1',
  password: 'password',
  first_name: 'First',
  last_name: 'Last',
  job_title: 'Manager',
  email: 'email@email.com'
}

check_user_exists = User.find_by(username: user[:username])
User.create(user) if !check_user_exists

color = ['Black', 'White', 'Orange', 'Grey', 'Calico']
color.each{|color| Color.find_or_create_by(name: color)}

breeds = [
  {name: 'Labrador', banned: false}, 
  {name: 'Golden Retriever', banned: false}, 
  {name: 'Cocker Spaniel', banned: false}, 
  {name: 'German Shephard', banned: false}, 
  {name: 'Jack Russell Terrier', banned: false},
  {name: 'Pit Bull', banned: true}
]
breeds.each{|breed| Breed.find_or_create_by(breed)}

sex = ['Male', 'Female']
sex.each{|sex| Sex.find_or_create_by(name: sex)}

sizes = ['X-Small', 'Small', 'Medium', 'Large', 'X-Large']
sizes.each{|size| Size.find_or_create_by(name: size)}

pet_type = ['Dog', 'Cat']
pet_type.each{|type| PetType.find_or_create_by(name: type)}

immunisation = [
  {pet_type: PetType.find_by(name: 'Dog'), name: 'DHLPP or DHPP'}, 
  {pet_type: PetType.find_by(name: 'Dog'), name: 'Rabies'}, 
  {pet_type: PetType.find_by(name: 'Dog'), name: 'Bordatella'},
  {pet_type: PetType.find_by(name: 'Cat'), name: 'FVRCP'}, 
  {pet_type: PetType.find_by(name: 'Cat'), name: 'Rabies'}
]
immunisation.each{|imm| Immunisation.find_or_create_by(imm)}

validities = [{code: 1, name: '1 year'}, {code: 3, name: '3 years'}]
validities.each{|validity| Validity.find_or_create_by(validity)}

health_details = [{name: 'Heart problems', alert: false}, {name: 'Blind', alert: false}, {name: 'Deaf', alert: false}, {name: 'Three legs', alert: false}]
health_details.each{|detail| HealthDetail.find_or_create_by(detail)}

special_needs = [{name: 'Agressive eater', action_needed: 'Cannot be fed around other dogs', alert: true}]
special_needs.each{|need| SpecialNeed.find_or_create_by(need)}
# Special Needs - action needed on dog as specific to the dog, not the condition?

sociabilities = [{name: 'Friendly', alert: false}, {name: 'Playful', alert: false}, {name: 'Old', alert: false}, {name: 'Cannot be with other dogs', alert: true}]
sociabilities.each{|soc| Sociability.find_or_create_by(soc)}

medication = ['Insulin', 'Prozac']
medication.each{|med| Medication.find_or_create_by(name: med)}

doses = ['Pill', 'Shot']
doses.each{|dose| Dose.find_or_create_by(name: dose)}

schedules = [{name: 'Once Daily', fee: 1}, {name: 'Twice Daily', fee: 2}]
schedules.each{|schedule| Schedule.find_or_create_by(schedule)}

foods = ['Dry', 'Wet']
foods.each{|food| Food.find_or_create_by(name: food)}

measures = ['Cup', 'Scoop', 'Can']
measures.each{|measure| Measure.find_or_create_by(name: measure)}

phone_types = ['Home', 'Cell', 'Work']
phone_types.each{|type| PhoneType.find_or_create_by(name: type)}

booking_statuses = ['Quote', 'Reservation', 'Active', 'Completed']
booking_statuses.each{|status| BookingStatus.find_or_create_by(name: status)}

issues = [{name: 'Strong Puller', alert: false}, {name: 'Excessive Barker', alert: true}, {name: 'Chews Blankets', alert: true}, {name: 'Excessive Digging', alert: true}]
issues.each{|issue| Issue.find_or_create_by(issue)}

concerns = [{name: 'Cost', alert: false}, {name: 'Pay on drop off', alert: false}]
concerns.each{|concern| Concern.find_or_create_by(concern)}

pen_types = [
  {pet_type: PetType.find_by(name: 'Dog'), name: 'Dog Run', max_per_pen: 3, no_pens: 15, always_show: true},
  {pet_type: PetType.find_by(name: 'Cat'), name: 'Cat Room', max_per_pen: 2, no_pens: 10, always_show: true},
  {pet_type: PetType.find_by(name: 'Cat'), name: 'Cat Pen', max_per_pen: 1, no_pens: 1, always_show: false},
  {pet_type: PetType.find_by(name: 'Dog'), name: 'Dog Grooming Pen (overflow only)', max_per_pen: 1, no_pens: 4, always_show: false}
]
pen_types.each{|pen| PenType.find_or_create_by(pen)}

rates = [
  { 
    pen_type: PenType.find_by(name: 'Dog Run'),
    no: 1,
    desc: 'Dog Run single dog',
    amount: 30,
    effective_from: '2019-01-01'
  },
  { 
    pen_type: PenType.find_by(name: 'Dog Run'),
    no: 2,
    desc: 'Dog Run two dogs sharing',
    amount: 45,
    effective_from: '2019-01-01'
  },
  { 
    pen_type: PenType.find_by(name: 'Dog Run'),
    no: 3,
    desc: 'Dog Run three dogs sharing (all small)',
    amount: 60,
    effective_from: '2019-01-01'
  },
  { 
    pen_type: PenType.find_by(name: 'Cat Room'),
    no: 1,
    desc: 'Cat Room single cat',
    amount: 22,
    effective_from: '2019-01-01'
  },
  { 
    pen_type: PenType.find_by(name: 'Cat Room'),
    no: 2,
    desc: 'Cat Room two cats from same family',
    amount: 33,
    effective_from: '2019-01-01'
  },
  { 
    pen_type: PenType.find_by(name: 'Cat Pen'),
    no: 1,
    desc: 'Cat Pen single cat',
    amount: 30,
    effective_from: '2019-01-01'
  },
  { 
    pen_type: PenType.find_by(name: 'Dog Grooming Pen (overflow only)'),
    no: 1,
    desc: 'Dog Grooming Pen single dog',
    amount: 30,
    effective_from: '2019-01-01'
  }
]
rates.each{|rate| Rate.find_or_create_by(rate)}

pens = [
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '1 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '2 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '3 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '4 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '5 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '6 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '7 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '8 (large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '9 (X-large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '10 (X-large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '11 (X-large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '12 (X-large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '13 (X-large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '14 (X-large door)'},
  {pen_type: PenType.find_by(name: 'Dog Run'), name: '15 (X-large door)'},
  {pen_type: PenType.find_by(name: 'Cat Pen'), name: 'Cat Pen'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (1)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (2)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (3)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (4)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (5)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (6)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (7)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (8)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (9)'},
  {pen_type: PenType.find_by(name: 'Cat Room'), name: 'Cat Room (10)'},
  {pen_type: PenType.find_by(name: 'Dog Grooming Pen (overflow only)'), name: '20 (grooming pen)'},
  {pen_type: PenType.find_by(name: 'Dog Grooming Pen (overflow only)'), name: '21 (grooming pen)'},
  {pen_type: PenType.find_by(name: 'Dog Grooming Pen (overflow only)'), name: '22 (grooming pen)'},
  {pen_type: PenType.find_by(name: 'Dog Grooming Pen (overflow only)'), name: '23 (grooming pen)'}
]
pens.each{|pen| Pen.find_or_create_by(pen)}

Faker::Config.locale = 'en-US'

30.times do 
  agreed = rand(100) > 30
  address_lines = rand(3) + 1

  Owner.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    primary_phone: Faker::PhoneNumber.phone_number,
    primary_phone_type_id: PhoneType.all.sample.id, 
    secondary_phone: Faker::PhoneNumber.phone_number,
    secondary_phone_type_id: PhoneType.all.sample.id, 
    address_line_1: address_lines > 1 ? Faker::Address.secondary_address : Faker::Address.street_address,
    address_line_2: address_lines == 3 ? Faker::Address.community : address_lines == 2 ? Faker::Address.street_address : nil,
    address_line_3: address_lines == 3 ? Faker::Address.street_address : nil,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zipcode: Faker::Address.zip_code,
    emergency_contact_name: Faker::Name.name,
    emergency_contact_phone: Faker::PhoneNumber.phone_number,
    partner_name: Faker::Name.name,
    partner_phone: Faker::PhoneNumber.phone_number,
    agreed_terms: agreed,
    agreed_date: agreed ? Faker::Date.birthday(0, 3) : nil
  })
end

50.times do 
  dog = rand(100) > 20
  spayed_neutered = rand(100) > 20

  Pet.create(
    { owner_id: Owner.all.sample.id,
      pet_type_id: dog ? PetType.find_by(name: 'Dog').id : PetType.find_by(name: 'Cat').id,
      name: dog ? Faker::Creature::Dog.name : Faker::Creature::Cat.name,
      dob: Faker::Date.birthday(0, 10) ,
      sex_id: Sex.all.sample.id,
      color_id: dog ? nil : Color.all.sample.id,
      size_id: Size.all.sample.id,
      breed_id: dog ? Breed.all.sample.id : nil,
      spayed_neutered: spayed_neutered,
      notes: '',
      special_needs_fee: false,
      no_return: false,
      inactive: false
    }
  )
end

Owner.select{|owner| owner.pets.length == 0}.each do |owner|
  dog = rand(100) > 20
  spayed_neutered = rand(100) > 20
  pets = rand(5)

  pets.times do
    Pet.create(
      { owner_id: owner.id,
        pet_type_id: dog ? PetType.find_by(name: 'Dog').id : PetType.find_by(name: 'Cat').id,
        name: dog ? Faker::Creature::Dog.name : Faker::Creature::Cat.name,
        dob: Faker::Date.birthday(0, 10) ,
        sex_id: Sex.all.sample.id,
        color_id: dog ? nil : Color.all.sample.id,
        size_id: Size.all.sample.id,
        breed_id: dog ? Breed.all.sample.id : nil,
        spayed_neutered: spayed_neutered,
        notes: '',
        special_needs_fee: false,
        no_return: false,
        inactive: false
      }
    )
  end
end

100.times do 
  check_in_date = rand(Date.new(2019,7,1)..Date.new(2019,10,01))
  check_out_date = check_in_date + [2,3,4,5,6,7,8,9,10,11,12,13,14].sample
  
  owner = Owner.all.sample
  dogs = owner.pets.select{|pet| pet.pet_type.name === 'Dog'}
  dog_pens = (dogs.length / 2) + (dogs.length % 2)
  dog_rates = dog_rates = ([2] * (dogs.length/2)) + ([1] * (dogs.length % 2))
  cats = owner.pets.select{|pet| pet.pet_type.name === 'Cat'}
  cat_pens = (cats.length / 2) + (cats.length % 2)
  cat_rates = cat_rates = ([5] * (cats.length/2)) + ([4] * (cats.length % 2))

  booking_status =  if check_out_date < Date.today
                      BookingStatus.find_by(name: 'Completed')
                    elsif check_in_date <= Date.today
                      BookingStatus.find_by(name: 'Active')
                    else
                      ([BookingStatus.find_by(name: 'Reservation')]*9 + [BookingStatus.find_by(name: 'Quote')]).sample
                    end

  booking = Booking.find_or_create_by(
    {
      owner_id: owner.id, 
      check_in: check_in_date, 
      check_in_time: ['AM','PM'].sample, 
      check_out: check_out_date, 
      check_out_time: ['AM','PM'].sample, 
      booking_status: booking_status
    }
  )
  
  dog_rates.each_with_index do |rate, index|
    booking_pen = BookingPen.find_or_create_by({
      booking: booking, 
      pen_type: PenType.find_by(name: 'Dog Run'),
      rate_id: rate
    })

    count = 0
    rate.times do
      BookingPenPet.find_or_create_by({
        booking_pen: booking_pen,
        pet: dogs[count + (index*2)],
        special_needs_fee: false
      })
      count += 1
    end
  end

  cat_rates.each_with_index do |rate, index|
    booking_pen = BookingPen.find_or_create_by({
      booking: booking, 
      pen_type: PenType.find_by(name: 'Cat Room'),
      rate_id: rate
    })

    count = 0
    rate.times do
      BookingPenPet.find_or_create_by({
        booking_pen: booking_pen,
        pet: cats[count + (index*2)],
        special_needs_fee: false
      })
      count += 1
    end
  end
end

  

