require_relative "../verify_base"

class ConsolidateVerify < VerifyBase

  def verify_filepath_consolidation_count
    assert_equal(1147,Filepath.all.count)
  end

  def verify_10854242_participants
    exp =[
      "agl@chromium.org",
      "derat@chromium.org",
      "kbr@chromium.org",
      "keescook@chromium.org",
      "palmer@chromium.org",
      "wez@chromium.org",
    ]
    assert_equal exp, Participant.joins(:developer).where(issue: 10854242).pluck(:email).sort
    #Note: ben@chromium.org is a reviewer, but did NOT participate
    #      sadrul@chromium.org too
  end

end#end of class
