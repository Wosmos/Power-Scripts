// for modulejs
// import { readdirSync, statSync, writeFileSync } from "fs";
// import { join } from "path";
//for commonjs
const { readdirSync, statSync, writeFileSync } = require('fs');
const { join } = require('path');


function createDirectoryStructure(dirPath, depth = 0, output = []) {
  const files = readdirSync(dirPath);
  files.forEach((file) => {
    const filePath = join(dirPath, file);
    const stats = statSync(filePath);
    const indent = '    '.repeat(depth);

    if (file !== "node_modules" && file !== ".git") {
      if (stats.isDirectory()) {
        output.push(`${indent}📁 **${file}**`);
        createDirectoryStructure(filePath, depth + 1, output);
      } else {
        output.push(`${indent}📄 ${file}`);
      }
    } else {
      output.push(`${indent}📦 ${file}`);
    }
  });
}

function generateTxtFile(dirPath, directoryStructure) {
  const outputFilePath = join(dirPath, "directory_structure.txt");
  const txtContent = directoryStructure.join("\n");
  writeFileSync(outputFilePath, txtContent);
  console.log(`Directory structure saved to ${outputFilePath}`);
}

function generateReadme(dirPath, directoryStructure) {
  const readmeContent =
    directoryStructure
      .map((item) => {
        if (item.includes("📁")) {
          return item.replace(
            /📁 (.*)/,
            "📁 $1\n<details><summary>See contents</summary>"
          );
        } else {
          return item;
        }
      })
      .join("\n") +
    "\n".repeat(2) +
    "</details>";
  writeFileSync(join(dirPath, "README.md"), readmeContent);
  console.log(`README.md file generated successfully.`);
}

const currentDirectory = process.cwd();
const directoryStructure = [];
createDirectoryStructure(currentDirectory, 0, directoryStructure);
generateTxtFile(currentDirectory, directoryStructure);
generateReadme(currentDirectory, directoryStructure);
