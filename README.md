# Obsidian FolderLink Integration to create and link folders

This Integration enables you to quickly create a folder as attachment to your Obsidian note and open it with the default file manager. This is done by creating a helper file with the same name as the folder and utilizing that Obsidian supports opening and linking files. Since we autoamte the creation of a new file ending and a new desktop application, you can simply link this dummy file, and the new application automatically opens the folder for you. By using Templater plugin, you can easily create a new folder and link it to your note with a single shortcut. It works for all types of Linux Obsidian installations since it is very reliable and only needs the basic Linux launcher functionality and is based on Obsidian being able to open files, which every Obsidian installation can do.

TLDR: Create a new folder and link it to your note with a single shortcut.

**Linux only**

## Usage

Run the playbook to set up the application:

```bash
ansible-playbook main.yml
```

The playbook performs the following:
1. Copies the `.desktop` file to register the new application.
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

```
We assume that the **new folder should be place in the attachments folder** of the current note. The template prompts you to enter a folder name, creates a new `.folderlink` file in the attachments folder, and inserts a relative link to the file in the current note.

### Step 3: Configure a Shortcut in Obsidian

In Obsidian, go to **Settings > Templater > Templates Folder** and set the folder containing your new template. Assign a shortcut to the template file for quick access.

### Step 4: Usage in Obsidian

1. Use the assigned shortcut to create a new `.folderlink` file in the `attachments` folder of the current note.
2. The template automatically inserts a relative link to the file in the current note.
3. Clicking the link opens the `.folderlink` file with the default system application, which triggers the new application registered in this repository.
4. The registered application creates a new folder named after the `.folderlink` file (without the extension) and opens the folder with the default file manager.