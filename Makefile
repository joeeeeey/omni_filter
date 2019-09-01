test_stt:
	/usr/bin/ruby main.rb "stt,stage"

test_sttc:
	/usr/bin/ruby main.rb "stt,prod,伦敦"	

test_stc:
	/usr/bin/ruby main.rb "color,#4c4c4c"

test_jira:
	/usr/bin/ruby main.rb "jira,442"

test_stf:
	/usr/bin/ruby main.rb "allkeys"

test_stg:
	/usr/bin/ruby main.rb "stg,search"

test_code:
	/usr/bin/ruby main.rb "code,r"

test_subl:
	/usr/bin/ruby main.rb "subl,r"

test_idea:
	/usr/bin/ruby main.rb "idea,r"

test_pycharm:
	/usr/bin/ruby main.rb "pcm,r";

test_string_operation:
	/usr/bin/ruby main.rb "str_operation,da\".do";

single_quoto_str_operation:
	/usr/bin/ruby main.rb "single_quoto_str_operation,da\'.u";