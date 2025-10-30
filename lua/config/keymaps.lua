-- Fat-finger prevention
vim.cmd("command W w")
vim.cmd("command Wq wq")
vim.keymap.set("n", "<S-CR>", function()
    -- 1. Get the directory of the currently open file (optional, but good for context)
    local base_dir = "/home/cole/workspace/raylib_game/"
    -- 2. Define the full command pipeline
    local command = "g++ "
        .. base_dir
        .. "game.cpp -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 && "
        .. base_dir
        .. "a.out"

    -- 3. Execute the command directly in the shell using vim.cmd()
    -- The 'cd ' part ensures the command runs in the correct directory.

    vim.cmd("!" .. command) -- The '!' executes the command externally

    -- NOTE: Since we are using '!', we cannot check vim.v.shell_error
    -- or print the output here; it runs externally.

    vim.notify("🚀 " .. command, vim.log.levels.INFO)
end, { desc = "Compile and Run game.cpp (External)" })
vim.keymap.set("n", "<C-a>", "ggvG$", { desc = "Select All" })
vim.keymap.set("x", "G", "G$", { remap = true, desc = "Select to End of File (Inclusive)" })
