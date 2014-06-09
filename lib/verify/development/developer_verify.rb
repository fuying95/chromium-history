require_relative "../verify_base"

class DeveloperVerify < VerifyBase

  def verify_watch_email
    assert_equal("ben@chromium.org", Developer.where("email like ?","ben%").take[:email],"Email +appenders not being ignored")
  end

  def verify_blacklisted_email_local_chomium_reviews
    assert_equal(true, Developer.blacklisted_email_local?("chromium-reviews"), "chromium-reviews should be blacklisted")
  end

  def verify_blacklisted_email_local_reply
    assert_equal(true, Developer.blacklisted_email_local?("reply") , "reply should be blacklisted")
  end

  def verify_blacklisted_email_local_not_blacklisted
    assert_equal(false, Developer.blacklisted_email_local?("GLaDOS") , "GLaDOS should not be blacklisted")
  end 

  def verify_blacklisted_email_domain_googlegroups
    assert_equal(true, Developer.blacklisted_email_domain?("googlegroups.com"),"googlegroups.com should be blacklisted")
  end
  
  def verify_blacklisted_email_domain_not_blacklisted
    assert_equal(false, Developer.blacklisted_email_domain?("aperturescience.gov"),"aperturescience.gov shouldn't be blacklisted")
  end

  def verify_sanitize_validate_email_tag
    assert_equal(["rouslan@chromium.org",true], Developer.sanitize_validate_email("rouslan+watch@chromium.org"), "Tag isn't being removed")
  end

  def verify_sanitize_validate_email_google_to_chromium
    assert_equal(["aa@chromium.org", true], Developer.sanitize_validate_email("aa@google.com"), "Domain isn't being changed from google.com to chromium.org")	
  end
  
  def verify_sanitize_validate_email_no_domain
    assert_equal([nil, false], Developer.sanitize_validate_email("dgozman@"), "Email doesn't have a domain and shouldn't be valid")	
  end

  def verify_sanitize_validate_email_blacklisted
    assert_equal([nil, false], Developer.sanitize_validate_email("me@googlegroups.com"), "Email shouldn't be valid because it is blacklisted")	
  end

  def verify_sanitize_validate_email_gtempaccount
    assert_equal(["dgozman@chromium.org", true], Developer.sanitize_validate_email("dgozman%chromium.org@gtempaccount.com"), 
		 "Email should be valid and switched to orginal domain")	
  end
  
end#end of class