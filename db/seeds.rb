# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
color.each{|color| Color.find_or_create_by(color: color)}

breeds = [
  {breed: 'Labrador', banned: false}, 
  {breed: 'Golden Retriever', banned: false}, 
  {breed: 'Cocker Spaniel', banned: false}, 
  {breed: 'German Shephard', banned: false}, 
  {breed: 'Jack Russell Terrier', banned: false},
  {breed: 'Pit Bull', banned: true}
]
breeds.each{|breed| Breed.find_or_create_by(breed)}

sex = ['Male', 'Female']
sex.each{|sex| Sex.find_or_create_by(sex: sex)}

sizes = ['X-Small', 'Small', 'Medium', 'Large', 'X-Large']
sizes.each{|size| Size.find_or_create_by(size: size)}

pet_type = ['Cat', 'Dog', 'Hamster']
pet_type.each{|type| PetType.find_or_create_by(animal: type)}

immunisation = ['DHLPP or DHPP', 'FVRCP', 'Rabies', 'Bordatella']
immunisation.each{|imm| Immunisation.find_or_create_by(immunisation: imm)}
# Pet type per immunisation? How to define required ones? Hard code?

validities = [{code: 1, duration: '1 year'}, {code: 3, duration: '3 years'}]
validities.each{|validity| Validity.find_or_create_by(validity)}

health_details = ['Heart problems', 'Blind', 'Deaf', 'Three lega']
health_details.each{|detail| HealthDetail.find_or_create_by(health_detail: detail)}

special_needs = [{special_need: 'Agressive eater', action_needed: 'Cannot be fed around other dogs'}]
special_needs.each{|need| SpecialNeed.find_or_create_by(need)}
# Special Needs - action needed on dog as specific to the dog, not the condition?

sociabilities = [{sociability: 'Friendly', alert: false}, {sociability: 'Playful', alert: false}, {sociability: 'Old', alert: false}, {sociability: 'Cannot be with other dogs', alert: true}]
sociabilities.each{|soc| Sociability.find_or_create_by(soc)}

medication = ['Insulin', 'Prozac']
medication.each{|med| Medication.find_or_create_by(medication: med)}

doses = ['Pill', 'Shot']
doses.each{|dose| Dose.find_or_create_by(dose: dose)}

schedules = [{schedule: 'Once Daily', fee: 1}, {schedule: 'Twice Daily', fee: 2}]
schedules.each{|schedule| Schedule.find_or_create_by(schedule)}

foods = ['Dry', 'Wet']
foods.each{|food| Food.find_or_create_by(food: food)}

measures = ['Cup', 'Scoop', 'Can']
measures.each{|measure| Measure.find_or_create_by(measure: measure)}

person_types = ['Owner', 'Emergeny Contact']
person_types.each{|type| PersonType.find_or_create_by(person_type: type)}

phone_types = ['Home', 'Cell', 'Work']
phone_types.each{|type| PhoneType.find_or_create_by(phone_type: type)}

room_types = ['Dog Run', 'Cat Room', 'Cat Pen', 'Dog Grooming Pen']
room_types.each{|type| RoomType.find_or_create_by(room_type: type)}

booking_statuses = ['Quote', 'Reservation', 'Active', 'Completed']
booking_statuses.each{|status| BookingStatus.find_or_create_by(status: status)}

issues = [{issue: 'Strong Puller', alert: false}, {issue: 'Excessive Barker', alert: true}, {issue: 'Chews Blankets', alert: true}, {issue: 'Excessive Digging', alert: true}]
issues.each{|issue| Issue.find_or_create_by(issue)}

concerns = [{concern: 'Cost', alert: false}, {concern: 'Pay on drop off', alert: false}]
concerns.each{|concern| Concern.find_or_create_by(concern)}

pen_types = [
  {pet_type: PetType.find_by(animal: 'Dog'), pen_type: 'Dog run'},
  {pet_type: PetType.find_by(animal: 'Cat'), pen_type: 'Cat room'},
  {pet_type: PetType.find_by(animal: 'Cat'), pen_type: 'Cat pen'},
  {pet_type: PetType.find_by(animal: 'Dog'), pen_type: 'Dog grooming pen'}
]
pen_types.each{|pen| PenType.find_or_create_by(pen)}

pets = [
  { pet_type: PetType.all.sample,
    name: '',
    dob: '',
    sex: Sex.all.sample,
    color: Color.all.sample,
    size: Size.all.sample,
    breed: Breed.all.sample,
    spayed_neutered: true,
    notes: '',
    special_needs_fee: false,
    no_return: false,
    inactive: false
  }
]

