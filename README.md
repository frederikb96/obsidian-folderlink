# Obsidian FolderLink Integration to create markdown links to folders

**Linux only**

This integration enables you to link an existing folder to your Obsidian note.

It works by creating a helper `.folderlink` file that stores the path to the desired folder. The integration leverages Obsidian's ability to open files with the systems default application. Therefore, this playbook registers a new application that lets you drag and drop or select a folder and stores its path in the `.folderlink` file. 

When you click the link in Obsidian, the new appliation then handles everything for you and directly opens the folder in your default file manager.

TLDR: This integration allows you to create markdown links to folders in Obsidian.

## Usage

Run the playbook to set up the application:

```bash
ansible-playbook main.yml
```

The playbook performs the following:
1. Copies over the `.desktop` file and script to register the new application.
2. Adds the MIME type for `.folderlink` files.
3. Updates the desktop and MIME databases to register the changes.

The setup is non-destructive, as it only adds new files and registers the `.folderlink` extension.

---

## Post Setup to Make It Work with Obsidian

### Step 1: Install the Templater Plugin

Install the [Templater plugin](https://github.com/SilentVoid13/Templater) in Obsidian. This plugin allows you to create templates with customizable actions.

### Step 2: Create a New Template File

Create a new template file in Obsidian with the following content:

```javascript
<%*
const userInput = await tp.system.prompt("Enter a Link Name for the Folder Link");
if (userInput) {
    
    // Create the full filename by appending the user input with the extension
    const fullFileName = `${userInput}.folderlink`;
    
    // Get the directory of the current note
    const currentDir = tp.file.folder(true);
    
    // Define the path to the attachments folder in the current note's directory
    const attachmentFolder = `${currentDir}/attachments`;
    
    // Full file path for the new file
    const fullFilePath = `${attachmentFolder}/${fullFileName}`;
    
    // Create the new file with a newline as content
    await this.app.vault.create(fullFilePath, ".");
    
    // Insert a relative link to the new file in the current note
    const relativePath = `attachments/${fullFileName}`;
    tR += `[[${relativePath}]]`;
}
%>
```

We assume that the **helper file should be place in the attachments folder** of the current note. The template prompts you to enter a name for the link to the folder, and inserts this as relative link to the folder in the current note.

### Step 3: Configure a Shortcut in Obsidian

In Obsidian, go to **Settings > Templater > Template Hotkeys** and set the new Tempalte as new Hotkey. Assign an 'insert' shortcut to the template file for quick access.

### Step 4: Usage in Obsidian

1. Use the assigned shortcut to create a new `.folderlink` file in the `attachments` folder of the current note and links it in the note.
2. Clicking the link opens the .folderlink file with the default system application, triggering the application registered by this integration.
3. The application then asks you to link the folder or if already linked, opens the folder in your default file manager.