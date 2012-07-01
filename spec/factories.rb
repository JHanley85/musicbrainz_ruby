FactoryGirl.define do
	sequence(:mbid) {"#{SecureRandom.hex(8)}-#{SecureRandom.hex(4)}-#{SecureRandom.hex(4)}-#{SecureRandom.hex(4)}-#{SecureRandom.hex(12)}"}
	sequence(:release_date) {Time.at(from + rand * (to.to_f - from.to_f))}

	factory :release do
		mbid
		release_date
	end
end