Time::DATE_FORMATS[:nice_ordinal] = lambda do |time|
    time.strftime "%B #{time.day.ordinalize}, %Y at %-I:%M%P"
end

