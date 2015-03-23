# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

chris, mary = User.create [
  {email: 'javajunkie314@gmail.com', name: 'Chris Bouchard'},
  {email: 'mferro54@gmail.com', name: 'Mary Ferro'}
]

uplifting_lemma = UpliftingLemma::App.create(
  name: 'Uplifting Lemma',
  license: 'cc by-nc 4.0',
  description: <<-TEXT.strip_heredoc
    is the main app.
  TEXT
)

uplifting_lemma_blog = Blog::App.create(
  name: 'Uplifting Lemma Blog',
  slug: 'blog',
  license: 'cc by-nc 4.0',
  description: <<-TEXT.strip_heredoc
    is my test blog app.
  TEXT
)

chasing_rabbits = Blog::App.create(
  name: 'Chasing Rabbits',
  description: <<-TEXT.strip_heredoc
    is in fringilla cursus hendrerit. Aliquam nec enim ac velit fermentum
    ullamcorper vitae non ipsum. Praesent a diam vitae velit elementum finibus
    vel ac odio. Ut quis posuere tortor, ac pretium arcu. Maecenas non cursus
    arcu. Phasellus sem augue, convallis sit amet elementum eu, tempor vel orci.
    Integer non ullamcorper dolor, ut lacinia sem.
  TEXT
)

Role.create [
  {app: uplifting_lemma, user: chris, role: 'owner'},
  {app: uplifting_lemma_blog, user: chris, role: 'owner'},
  {app: uplifting_lemma_blog, user: chris, role: 'writer'},
  {app: chasing_rabbits, user: chris, role: 'writer'},
  {app: chasing_rabbits, user: mary, role: 'owner'},
  {app: chasing_rabbits, user: mary, role: 'writer'}
]

uplifting_lemma_blog.articles.create(
  title: 'Testing my Blog',
  body: <<-TEXT.strip_heredoc
    This is a test article. Look at how it has a title and body. Test test
    test.
  TEXT
)

PaperTrail.whodunnit = mary.id.to_s

test_article = chasing_rabbits.articles.create(
  title: 'This is a Test',
  body: <<-TEXT.strip_heredoc
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sit
    amet egestas erat. In egestas molestie mauris ac volutpat. Mauris
    mollis, arcu eu condimentum cursus, tellus augue mattis augue, vitae
    accumsan quam ante sed felis. Praesent congue elementum neque a auctor.
    Quisque velit lorem, porta sit amet sapien sit amet, fringilla finibus
    dolor. Interdum et malesuada fames ac ante ipsum primis in faucibus.
    Donec non ligula ac metus sollicitudin laoreet sed eu tortor. Quisque
    quis consectetur urna. Aliquam posuere, ipsum ac pellentesque egestas,
    odio leo commodo purus, id tristique tellus odio sit amet nunc. Aliquam
    ultricies orci nec dolor commodo consequat. Integer eu tortor sed elit
    imperdiet mollis porta porta libero. Morbi et pharetra libero. Donec
    egestas ipsum vel nunc luctus, ut vulputate mauris fringilla. Cras et
    sodales elit. Fusce turpis sapien, congue a augue vel, vehicula varius
    tellus. Fusce vitae odio ut sapien blandit elementum ut vitae neque.

    * * *

    Etiam et diam eget tellus hendrerit feugiat. Vestibulum a tellus purus.
    Maecenas nunc ligula, aliquam fringilla turpis a, elementum dictum
    mauris. Integer eget leo ut arcu tempus molestie a in velit. Sed ut
    risus sit amet mi vulputate pulvinar a id magna. Aliquam id enim eu
    urna tempor molestie. Sed ac nunc in nisl condimentum vestibulum.
    Maecenas venenatis cursus dignissim. Mauris venenatis turpis vel nibh
    congue, non tincidunt lectus mollis. In ut pharetra nunc, sed eleifend
    neque.
  TEXT
)

PaperTrail.whodunnit = chris.id.to_s

test_article.comments.create(
  body: 'This is a test comment!'
)

PaperTrail.whodunnit = mary.id.to_s

test_article.comments.create(
  body: 'Hello world. Foo bar baz!'
)

