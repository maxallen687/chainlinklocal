import * as dotenv from "dotenv";
import "solidity-docgen";

import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  paths: {
    sources: "./src",
  },
  docgen: {
    pages: "files",
    pageExtension: ".mdx",
    templates: "custom_templates",
    exclude: ["test"],
    outputDir: "api_reference/solidity",
  },
};

export default config;
