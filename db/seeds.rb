# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

chris, mary = User.create [
    {email: 'javajunkie314@gmail.com', name: 'Chris Bouchard'},
    {email: 'mferro54@gmail.com', name: 'Mary Ferro'}
]

uplifting_lemma = UpliftingLemma::UpliftingLemma.create(
    name: 'Uplifting Lemma', user: chris, license: 'cc by-nc 4.0'
)

chasing_rabbits = Blog::Blog.create(
    name: 'Chasing Rabbits', user: mary
)

Role.create [
    {app: uplifting_lemma, user: chris, role: 'owner'},
    {app: chasing_rabbits, user: mary, role: 'owner'}
]

PaperTrail.whodunnit = mary.id.to_s

test_article = chasing_rabbits.articles.create(
    title: 'This is a Test',
    body: <<-BODY.strip_heredoc
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

        ---

        Etiam et diam eget tellus hendrerit feugiat. Vestibulum a tellus purus.
        Maecenas nunc ligula, aliquam fringilla turpis a, elementum dictum
        mauris. Integer eget leo ut arcu tempus molestie a in velit. Sed ut
        risus sit amet mi vulputate pulvinar a id magna. Aliquam id enim eu
        urna tempor molestie. Sed ac nunc in nisl condimentum vestibulum.
        Maecenas venenatis cursus dignissim. Mauris venenatis turpis vel nibh
        congue, non tincidunt lectus mollis. In ut pharetra nunc, sed eleifend
        neque.
    BODY
)

PaperTrail.whodunnit = chris.id.to_s

test_article.comments.create(
    title: 'Test Comment',
    comment: 'This is a test comment!'
)

