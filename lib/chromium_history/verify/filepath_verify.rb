require_relative "verify_base"

class FilepathVerify < VerifyBase
	
	def verify_commit_files_have_no_ellipses
		helper_check_file_path('\.{2,}', "File Paths with Ellipses")
	end

	def verify_commit_files_have_no_spaces
		helper_check_file_path('\s', "File Paths with Spaces")
	end



	private
	def helper_check_file_path(regex, message)
	    #trying to display the commit that belongs to on fail
	    #but the commit id not being saved to commit_file only
	    #after batch command done running
	    count = 0

	    # Get all the commit_files by the filepath column value
	    files = CommitFile.pluck(:filepath)
	    rgx = Regexp.new(regex)

	    files.each do |path| 
	      if path.match(rgx)
	        count+=1
	      end

	    end#end each
	    verify_count(message, 0, count)

	end #end helper_check_file_path

	def verify_count(name, expected, actual)
	    if actual > expected
	      fail("More than #{expected} #{name} found. Actual: #{actual}")
	    elsif actual < expected
	      fail("Less than #{expected} #{name} found. Actual: #{actual}")
	    else
	      pass()
	    end
  end

end#class

