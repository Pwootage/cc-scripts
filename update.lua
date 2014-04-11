--Will auto-update this repository

local pwd = shell.getRunningProgram()
local dlDir = fs.combine(pwd, "../..")

print("Updating scripts in "..dlDir)
shell.run("github", "pwootage", "cc-scripts", dlDir)