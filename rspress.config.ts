import * as path from 'node:path';
import { defineConfig } from 'rspress/config';

export default defineConfig({
  base: '/lingro-doc/',
  root: path.join(__dirname, 'docs'),
  title: '灵格若 | Lingro',
  icon: '/Lingro-logo-192x192.png',
  logo: {
    light: '/Lingro-logo-192x192.png',
    dark: '/Lingro-logo-192x192.png',
  },
  // themeConfig: {
  //   socialLinks: [
  //     {
  //       icon: 'github',
  //       mode: 'link',
  //       content: 'https://github.com/web-infra-dev/rspress',
  //     },
  //   ],
  // },
  // multiVersion: {
  //   default: 'v1',
  //   versions: ['v1'],
  // },
});
