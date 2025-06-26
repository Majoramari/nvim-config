local M = {}

M.setup = function(opts)
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      local mini_files = require("mini.files")
      local keymaps = opts.custom_keymaps or {}

      vim.keymap.set("n", keymaps.open_tmux_pane, function()
        local curr_entry = mini_files.get_fs_entry()
        if curr_entry and curr_entry.fs_type == "directory" then
          require("config.keymaps").tmux_pane_function(curr_entry.path)
        else
          vim.notify("Not a directory or no entry selected", vim.log.levels.WARN)
        end
      end, { buffer = buf_id, noremap = true, silent = true })

      vim.keymap.set("n", keymaps.copy_to_clipboard, function()
        local curr_entry = mini_files.get_fs_entry()
        if curr_entry then
          local path = curr_entry.path
          local cmd = string.format([[osascript -e 'set the clipboard to POSIX file "%s"' ]], path)
          local result = vim.fn.system(cmd)
          if vim.v.shell_error ~= 0 then
            vim.notify("Copy failed: " .. result, vim.log.levels.ERROR)
          else
            vim.notify(vim.fn.fnamemodify(path, ":t"), vim.log.levels.INFO)
            vim.notify("Copied to system clipboard", vim.log.levels.INFO)
          end
        else
          vim.notify("No file or directory selected", vim.log.levels.WARN)
        end
      end, { buffer = buf_id, noremap = true, silent = true, desc = "[P]Copy file/directory to clipboard" })

      -- ZIP current file or directory and copy to the system clipboard
      vim.keymap.set("n", keymaps.zip_and_copy, function()
        local curr_entry = require("mini.files").get_fs_entry()
        if curr_entry then
          local path = curr_entry.path
          local name = vim.fn.fnamemodify(path, ":t")                       -- Extract the file or directory name
          local parent_dir = vim.fn.fnamemodify(path, ":h")                 -- Get the parent directory
          local timestamp = os.date("%y%m%d%H%M%S")                         -- Append timestamp to avoid duplicates
          local zip_path = string.format("/tmp/%s_%s.zip", name, timestamp) -- Path in macOS's tmp directory
          -- Create the zip file
          local zip_cmd = string.format(
            "cd %s && zip -r %s %s",
            vim.fn.shellescape(parent_dir),
            vim.fn.shellescape(zip_path),
            vim.fn.shellescape(name)
          )
          local result = vim.fn.system(zip_cmd)
          if vim.v.shell_error ~= 0 then
            vim.notify("Failed to create zip file: " .. result, vim.log.levels.ERROR)
            return
          end
          -- Copy the zip file to the system clipboard
          local copy_cmd =
              string.format([[osascript -e 'set the clipboard to POSIX file "%s"' ]], vim.fn.fnameescape(zip_path))
          local copy_result = vim.fn.system(copy_cmd)
          if vim.v.shell_error ~= 0 then
            vim.notify("Failed to copy zip file to clipboard: " .. copy_result, vim.log.levels.ERROR)
            return
          end
          vim.notify(zip_path, vim.log.levels.INFO)
          vim.notify("Zipped and copied to clipboard: ", vim.log.levels.INFO)
        else
          vim.notify("No file or directory selected", vim.log.levels.WARN)
        end
      end, { buffer = buf_id, noremap = true, silent = true, desc = "[P]Zip and copy to clipboard" })

      -- Paste the current file or directory from the system clipboard into the current directory in mini.files
      vim.keymap.set("n", keymaps.paste_from_clipboard, function()
        -- vim.notify("Starting the paste operation...", vim.log.levels.INFO)
        if not mini_files then
          vim.notify("mini.files module not loaded.", vim.log.levels.ERROR)
          return
        end
        local curr_entry = mini_files.get_fs_entry() -- Get the current file system entry
        if not curr_entry then
          vim.notify("Failed to retrieve current entry in mini.files.", vim.log.levels.ERROR)
          return
        end
        local curr_dir = curr_entry.fs_type == "directory" and curr_entry.path
            or vim.fn.fnamemodify(curr_entry.path, ":h") -- Use parent directory if entry is a file
        -- vim.notify("Current directory: " .. curr_dir, vim.log.levels.INFO)
        local script = [[
          tell application "System Events"
          try
          set theFile to the clipboard as alias
          set posixPath to POSIX path of theFile
          return posixPath
          on error
          return "error"
        end try
      end tell
      ]]
        local output = vim.fn.system("osascript -e " .. vim.fn.shellescape(script)) -- Execute AppleScript command
        if vim.v.shell_error ~= 0 or output:find("error") then
          vim.notify("Clipboard does not contain a valid file or directory.", vim.log.levels.WARN)
          return
        end
        local source_path = output:gsub("%s+$", "") -- Trim whitespace from clipboard output
        if source_path == "" then
          vim.notify("Clipboard is empty or invalid.", vim.log.levels.WARN)
          return
        end
        local dest_path = curr_dir ..
            "/" ..
            vim.fn.fnamemodify(source_path, ":t")    -- Destination path in current directory
        local copy_cmd = vim.fn.isdirectory(source_path) == 1 and { "cp", "-R", source_path, dest_path }
            or { "cp", source_path, dest_path }      -- Construct copy command
        local result = vim.fn.system(copy_cmd)       -- Execute the copy command
        if vim.v.shell_error ~= 0 then
          vim.notify("Paste operation failed: " .. result, vim.log.levels.ERROR)
          return
        end
        -- vim.notify("Pasted " .. source_path .. " to " .. dest_path, vim.log.levels.INFO)
        mini_files.synchronize() -- Refresh mini.files to show updated directory content
        vim.notify("Pasted successfully.", vim.log.levels.INFO)
      end, { buffer = buf_id, noremap = true, silent = true, desc = "[P]Paste from clipboard" })

      -- Copy the current file or directory path (relative to home) to clipboard
      vim.keymap.set("n", keymaps.copy_path, function()
        -- Get the current entry (file or directory)
        local curr_entry = mini_files.get_fs_entry()
        if curr_entry then
          -- Convert path to be relative to home directory
          local home_dir = vim.fn.expand("~")
          local relative_path = curr_entry.path:gsub("^" .. home_dir, "~")
          vim.fn.setreg("+", relative_path) -- Copy the relative path to the clipboard register
          vim.notify(vim.fn.fnamemodify(relative_path, ":t"), vim.log.levels.INFO)
          vim.notify("Path copied to clipboard: ", vim.log.levels.INFO)
        else
          vim.notify("No file or directory selected", vim.log.levels.WARN)
        end
      end, { buffer = buf_id, noremap = true, silent = true, desc = "[P]Copy relative path to clipboard" })

      vim.keymap.set("n", keymaps.preview_image, function()
        local curr_entry = mini_files.get_fs_entry()
        if curr_entry then
          vim.system({ "qlmanage", "-p", curr_entry.path }, {
            stdout = false,
            stderr = false,
          })
          vim.defer_fn(function()
            vim.system({ "osascript", "-e", 'tell application "qlmanage" to activate' })
          end, 200)
        else
          vim.notify("No file selected", vim.log.levels.WARN)
        end
      end, { buffer = buf_id, noremap = true, silent = true, desc = "[P]Preview with macOS Quick Look" })
    end,
  })
end

return M
