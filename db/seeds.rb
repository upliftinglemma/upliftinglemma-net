# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

chris, mary = User.create([
    {email: 'javajunkie314@gmail.com', name: 'Chris Bouchard'},
    {email: 'mferro54@gmail.com', name: 'Mary Ferro'}
])

uplifting_lemma, chasing_bunnies = App.create([
    {name: 'Uplifting Lemma', theme: 'blue', type: 'upliftinglemma'},
    {name: 'Chasing Bunnies', theme: 'purple', type: 'blog'}
])

Role.create([
    {app: uplifting_lemma, user: chris, role: 'owner'},
    {app: chasing_bunnies, user: mary, role: 'owner'}
])
