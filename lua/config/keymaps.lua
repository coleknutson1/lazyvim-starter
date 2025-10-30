-- Fat-finger prevention
vim.cmd("command W w")
vim.cmd("command Wq wq")

vim.keymap.set("n", "<F5>", function()
    -- 1. Get the directory of the currently open file
    local file_dir = vim.fn.expand("%:h")

    -- 2. Define the full command pipeline
    local pipeline = "gcc game.cpp -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 && ./a.out"
    -- 3. Execute the command using the shell (sh)
    -- The first argument is the shell executable, the second is the -c flag,
    -- and the third is the command pipeline string.
    local output = vim.fn.system({ "sh", "-c", pipeline }, file_dir)

    -- 4. Print the output and check for errors
    print(output)
    if vim.v.shell_error ~= 0 then
        vim.notify("🔴 Compilation/Execution Failed (Check output)", vim.log.levels.ERROR)
    else
        vim.notify("🟢 Compiled and Executed Successfully", vim.log.levels.INFO)
    end
end, { desc = "Compile and Run main.cpp" })

vim.keymap.set("n", "<C-a>", "ggvG$", { desc = "Select All" })
vim.keymap.set("x", "G", "G$", { remap = true, desc = "Select to End of File (Inclusive)" })
