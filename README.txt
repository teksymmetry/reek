== Reek

Code smell detection for Ruby.

The documentation is at http://wiki.github.com/kevinrutherford/reek
The code lives at http://github.com/kevinrutherford/reek/tree


== How to use Uncommunicative name verifier extension ?

 * Create your configuration reek file under your source base (RAILS_ROOT/app/app.reek)

 * Add the following configurations -
    UncommunicativeName:
      verifierExtention:
      - <path to your ruby script file>

	example - 
	UncommunicativeName:
      verifierExtention:
		  - config/smells/strict_uncommunicative_variable_name_verifier

 * Remember ruby class name and file name must be similar,
   Use "_" for separating different words. ie SimpleVerifier => simple_verifier.rb

 * Write following class - 
	class StrictUncommunicativeVariableNameVerifier 
		def accepted?(p_context, p_variable_name)
		  # do stuffs with variable name 
		  # if it match your requirement 
		  # return true, nil
		  # otherwise
		  # return false, "error message"
		end
	end
	 