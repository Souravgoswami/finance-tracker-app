require 'etc'

ITEMS = 200
NAME = (?a..?y).to_a.permutation
FORK_PIDS = []
PROCESSORS = Etc.nprocessors * 2

time = Time.now
ITEMS.times do |i|
	if FORK_PIDS.length > PROCESSORS
		Process.wait(FORK_PIDS.shift)
		redo
	else
		elap = Time.now - time
		est_rem = ITEMS.*(elap)./(i).-(elap).round(2)
		print "\e[2K#{i}/#{ITEMS} | Elapsed #{elap.round(2)} s | Rem #{est_rem} s | Active #{FORK_PIDS.count}\r"
		name = NAME.next.join.capitalize

		FORK_PIDS << Process.fork do
			begin
				User.create!(username: name, email: "#{name}@fn.net", password: 'randomuser')
			rescue ActiveRecord::RecordInvalid
				puts $!.full_message
			rescue Exception
				sleep 0.1
				retry
			end
		end
	end
end

FORK_PIDS.each(&Process.method(:wait))
