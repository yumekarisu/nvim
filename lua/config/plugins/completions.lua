return {
    {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "*",

	opts = {
	    -- 'default' for mappings similar to built-in completion
	    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
	    keymap = { preset = 'super-tab' },

	    appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = 'mono'
	    },
	},
	opts_extend = { "sources.default" }
    }
}
