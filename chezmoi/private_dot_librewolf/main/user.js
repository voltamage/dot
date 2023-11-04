user_pref("browser.cache.disk.enable", false); // disable disk caching
user_pref("browser.download.autohideButton", true); // hide download ui intil first dl
user_pref("browser.toolbars.bookmarks.visibility", "never"); // hide bookmarks toolbar
user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org"); // set dark ui
user_pref("privacy.sanitize.sanitizeOnShutdown", false); // do not clear history on close

// SETTINGS
// General
user_pref("browser.startup.page", 3); // Open previous windows and tabs

// Tabs
user_pref("browser.ctrlTab.sortByRecentlyUsed", true); // Ctrl+Tab cycles through tabs in recently used order
user_pref("browser.link.open_newwindow", 3); // Open links in tabs instead of new windows
user_pref("browser.tabs.loadInBackground", true); // When you open a link, image or media in a new tab, switch to it immediately
user_pref("browser.tabs.warnOnClose", false); // Confirm before closing multiple tabs
user_pref("browser.warnOnQuitShortcut", false); // Confirm before quitting with Ctrl+Q
user_pref("privacy.userContext.enabled", true); // Enable Container Tabs

// Language and Appearance
// Fonts
user_pref("browser.display.use_document_fonts", 1); // Allow pages to choose their own fonts, instead of your selections above

// Language
user_pref("layout.spellcheckDefault", 0); // Check your spelling as you type

// Files and Applications
// Downloads
// // TODO: XDG user directories for the download folder
user_pref("browser.download.useDownloadDir", false); // Always ask you where to save files
