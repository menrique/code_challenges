# 1. Given an array of jobs using the following format:

# [{type: 'employment', start_date: '1999-10-12', end_date: '2002-02-25'},
#  {type: 'employment', start_date: '2002-03-01', end_date: '2005-07-17'},
#  {type: 'employment', start_date: '2005-08-20', end_date: '2010-03-07'},
#  {type: 'employment', start_date: '2010-06-07', end_date: '2018-08-06'},
#  {type: 'employment', start_date: '2018-08-21', end_date: '2020-04-01'}]

# Write a function that calculate the employment gaps, by detecting unemployment periods longer than the specified days
# amounts. The result should look like:

# [{:type=>"employment", :start_date=>"1999-10-12", :end_date=>"2002-02-25"},
#  {:type=>"employment", :start_date=>"2002-03-01", :end_date=>"2005-07-17"},
#  {:type=>"gap", :start_date=>"2005-07-17", :end_date=>"2005-08-20"},
#  {:type=>"employment", :start_date=>"2005-08-20", :end_date=>"2010-03-07"},
#  {:type=>"gap", :start_date=>"2010-03-07", :end_date=>"2010-06-07"},
#  {:type=>"employment", :start_date=>"2010-06-07", :end_date=>"2018-08-06"},
#  {:type=>"employment", :start_date=>"2018-08-21", :end_date=>"2020-04-01"}]

require 'date'

def detect_gaps(jobs, threshold = 30)
  jobs.each_with_object([]).with_index do |(job, result), index|
    start_date = job[:start_date]
    prev_end_date = index > 0 ? jobs[index - 1][:end_date] : start_date

    if Date.parse(start_date) - Date.parse(prev_end_date) > threshold
      result << { type: 'gap', start_date: prev_end_date, end_date: start_date}
    end

    result << job
  end
end

jobs = [{type: 'employment', start_date: '1999-10-12', end_date: '2002-02-25'},
        {type: 'employment', start_date: '2002-03-01', end_date: '2005-07-17'},
        {type: 'employment', start_date: '2005-08-20', end_date: '2010-03-07'},
        {type: 'employment', start_date: '2010-06-07', end_date: '2018-08-06'},
        {type: 'employment', start_date: '2018-08-21', end_date: '2020-04-01'}]

detect_gaps(jobs)
# => [{:type=>"employment", :start_date=>"1999-10-12", :end_date=>"2002-02-25"},
#     {:type=>"employment", :start_date=>"2002-03-01", :end_date=>"2005-07-17"},
#     {:type=>"gap", :start_date=>"2005-07-17", :end_date=>"2005-08-20"},
#     {:type=>"employment", :start_date=>"2005-08-20", :end_date=>"2010-03-07"},
#     {:type=>"gap", :start_date=>"2010-03-07", :end_date=>"2010-06-07"},
#     {:type=>"employment", :start_date=>"2010-06-07", :end_date=>"2018-08-06"},
#     {:type=>"employment", :start_date=>"2018-08-21", :end_date=>"2020-04-01"}]