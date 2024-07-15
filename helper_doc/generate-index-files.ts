import fs from "fs-extra";
import path from "path";

const MDX_EXTENSION = ".mdx";
const rootDir = path.join(process.cwd(), "api_reference");

const generateIndexFile = async (dir: string, header: string) => {
  const files = await fs.readdir(dir);
  const mdxFiles = files.filter(
    (file) => file.endsWith(MDX_EXTENSION) && file !== `index${MDX_EXTENSION}`
  );
  const subDirs = files.filter((file) =>
    fs.lstatSync(path.join(dir, file)).isDirectory()
  );

  let content = `# ${header}\n\n`;

  const allEntries = [...mdxFiles, ...subDirs];

  if (allEntries.length > 0) {
    allEntries.forEach((entry) => {
      const fileNameWithoutExtension = path.basename(entry, MDX_EXTENSION);
      const linkName = entry.endsWith(MDX_EXTENSION)
        ? fileNameWithoutExtension
        : entry;
      const linkPath = entry.endsWith(MDX_EXTENSION)
        ? entry
        : `${entry}/index${MDX_EXTENSION}`;
      content += `- [${linkName}](${linkPath})\n`;
    });
  }

  await fs.writeFile(path.join(dir, `index${MDX_EXTENSION}`), content);
};

const traverseDirectory = async (dir: string, header: string) => {
  await generateIndexFile(dir, header);

  const files = await fs.readdir(dir);
  const subDirs = files.filter((file) =>
    fs.lstatSync(path.join(dir, file)).isDirectory()
  );

  for (const subDir of subDirs) {
    await traverseDirectory(
      path.join(dir, subDir),
      `${subDir.charAt(0).toUpperCase() + subDir.slice(1)} API Reference`
    );
  }
};

traverseDirectory(rootDir, "API Reference")
  .then(() => console.log("Index files generated successfully."))
  .catch((err) => console.error(err));
