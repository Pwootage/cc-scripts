--Will auto-update this repository

local pwd = shell.dir()
local dlDir = shell.resoolve(pwd.."/..")

print(dlDir)
shell.run("github", "pwootage", "cc-scripts", dlDir)