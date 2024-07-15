import fs from 'fs-extra';
import path from 'path';
import jsdoc2md from 'jsdoc-to-markdown';

const MDX_EXTENSION = '.mdx';
const outputDir = path.join(process.cwd(), 'api_reference/javascript');

const jsFiles = ['scripts/CCIPLocalSimulatorFork.js'];

const generateMarkdownDocs = async (
  files: string[],
  outputDirectory: string
) => {
  await fs.ensureDir(outputDirectory);

  for (const file of files) {
    const absoluteFilePath = path.join(process.cwd(), file);
    const fileName = path.basename(file, path.extname(file));
    const outputPath = path.join(
      outputDirectory,
      `${fileName}${MDX_EXTENSION}`
    );
    const markdown = await jsdoc2md.render({ files: absoluteFilePath });
    const fixedMarkdown = markdown.replace(/&lt;\{/g, '&lt;\\{');
    await fs.outputFile(outputPath, fixedMarkdown);
  }
};

generateMarkdownDocs(jsFiles, outputDir)
  .then(() => console.log('Markdown documentation generated successfully.'))
  .catch(err => console.error(err));
