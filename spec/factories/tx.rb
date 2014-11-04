FactoryGirl.define do
  factory :tx1, class: :tx do
    target_address_id 1
    txid "3377cf20fb72f1b16a8148a485866e66f9bd0e852dd70e263ebab06f9e95cf41"
    dt '2014-01-01'
  end

  factory :tx2, class: :tx do
    target_address_id 1
    txid "83fd0d7921322230ceacbcc144aeb2051f93ea76c7b70f9dbd0ed52a2abda225"
    dt '2014-11-01'
  end

  factory :tx3, class: :tx do
    target_address_id 1
    txid "cf45903499e3e1c22421bd4d257e28040994723e7ea84c3682a088e789777915"
    dt '2014-11-01'
  end

end