class Movie < ActiveRecord::Base
    def self.ratings
        Movie.select(:rating).distinct.inject([]) { |a, m| a.push m.rating}
        #['G','R','PG-13','PG'].map{|a| a}#     
    end    
end