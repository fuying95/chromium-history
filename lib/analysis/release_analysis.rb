# For each file in a given release, populate the necessary metrics
class ReleaseAnalysis

  def populate
    r = Release.find_by(name: '11.0') #hard-coded to Release 11 for now
    r.release_filepaths.find_each do |rf|
      rf.num_reviews = rf.filepath.code_reviews.size
      rf.num_reviewers = rf.filepath.reviewers.size
      rf.num_participants = rf.filepath.participants.size
      rf.perc_security_experienced_participants = rf.filepath.perc_security_exp_part(r.date)
      rf.avg_non_participating_revs = rf.filepath.avg_non_participating_revs(r.date)
      rf.avg_reviews_with_owner = rf.filepath.avg_reviews_with_owner(r.date)
      rf.avg_owner_familiarity_gap = rf.filepath.avg_owner_familiarity_gap(r.date)
      rf.perc_fast_reviews = rf.filepath.perc_fast_reviews(r.date)
      rf.perc_overlooked_patchsets = rf.filepath.perc_overlooked_patchsets(r.date)
      rf.vulnerable = rf.filepath.vulnerable?(r.date)
      rf.save
    end
  end

end
