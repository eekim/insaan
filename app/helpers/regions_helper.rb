module RegionsHelper

  def total_leaders_in_country(country)
    total = 0
    country.regions.each do |r|
      total += r.total_leaders
    end
    return total 
  end
  
  def total_female_leaders_in_country(country)
    total = 0
    country.regions.each do |r|
      total += r.total_female_leaders
    end
    return total
  end

  def total_male_leaders_in_country(country)
    total = 0
    country.regions.each do |r|
      total += r.total_male_leaders
    end
    return total
  end  
end
