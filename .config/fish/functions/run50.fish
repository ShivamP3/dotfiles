function run50
	set file $argv[1]
	set output (echo $argv[1] | sed 's/\.c//')
	gcc $file -lcs50 -o $output
	./$output
end
