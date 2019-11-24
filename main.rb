def make_gitignore(file, does_init, str)
  if does_init
    `git init`
    `git commit --allow-empty -m "initial empty commit"`
  end
  if !(str.nil? || str.to_s == "")
    `gibo dump #{str} > .gitignore`
  end
  if File.exist?(file)
    open(".gitignore", 'a'){|output|
      open(file) {|input|
        output.puts("\n")
        output.write(input.read)
      }
    }
  end
  `git add .gitignore`
  `git commit -m "add .gitignore by gibo"`
end

option = ["-i", "-init"]

file = ARGV[0].to_s
does_init = option.include?(ARGV[1].to_s)
start = (does_init ? 2 : 1)

str = ""
for i in start...ARGV.size()
  str += ARGV[i].to_s
  if i < ARGV.size() - 1
    str += " "
  end
end

make_gitignore(file, does_init, str)
