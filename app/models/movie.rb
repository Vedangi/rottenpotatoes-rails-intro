class Movie < ActiveRecord::Base
    def self.ratings
        #Movie.select(:rating).distinct.inject([]) { |a, m| a.push m.rating}
        ['G','PG','PG-13','R'].map{|a| a}        #Map the valid ratings
    end    
end