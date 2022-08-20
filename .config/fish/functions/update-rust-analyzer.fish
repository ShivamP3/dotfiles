function update-rust-analyzer
	set before (rust-analyzer --version | awk -v N=3 '{print $N}')

	curl -# -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer
	chmod +x ~/.cargo/bin/rust-analyzer

	set after (rust-analyzer --version | awk -v N=3 '{print $N}')
	echo "$before -> $after"
end
