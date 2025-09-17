import * as path from 'node:path';
import { defineConfig } from 'rspress/config';
import sitemap from "rspress-plugin-sitemap";


export default defineConfig({
  base: '/lingro-doc/',
  root: path.join(__dirname, 'docs'),
  title: '灵格若 | Lingro',
  icon: '/Lingro-logo-192x192.png',
  logo: {
    light: '/Lingro-logo-192x192.png',
    dark: '/Lingro-logo-192x192.png',
  },
  head: [
    ['meta', { charset: 'utf-8' }],
    ['meta', { name: 'viewport', content: 'width=device-width, initial-scale=1' }],
    ['meta', { name: 'description', content: '灵格若科技，您的一站式解决方案：MCP工具 · 知识库管理 · 多源数据整合 · 多模型智能切换 · 实时更新 · 深度检索 · 团队协作' }],
    ['meta', { name: 'keywords', content: 'AI知识管理,企业知识库,个人知识库,RAG,MCP,MCP工具,大语言模型,多模型切换,知识库驱动AI,网络引擎搜索AI,智能问答,文档检索,团队协作,效率工具,灵格若科技' }],
    ['meta', { property: 'og:title', content: '灵格若 | Lingro' }],
    ['meta', { property: 'og:description', content: '灵格若科技，您的一站式解决方案：MCP工具 · 知识库管理 · 多源数据整合 · 多模型智能切换 · 实时更新 · 深度检索 · 团队协作' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:url', content: 'https://www.i-lingro.com' }],
    ['meta', { property: 'og:image', content: 'https://www.i-lingro.com/og-image.jpg' }],
    ['meta', { property: 'og:site_name', content: '灵格若' }],
    ['meta', { property: 'og:locale', content: 'zh_CN' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
    ['meta', { name: 'twitter:title', content: '灵格若 | Lingro' }],
    ['meta', { name: 'twitter:description', content: '灵格若科技，您的一站式解决方案：MCP工具 · 知识库管理 · 多源数据整合 · 多模型智能切换 · 实时更新 · 深度检索 · 团队协作' }],
    ['meta', { name: 'twitter:image', content: 'https://www.i-lingro.com/og-image.jpg' }],
    ['meta', { name: 'robots', content: 'index, follow' }],
    ['meta', { name: 'author', content: '灵格若科技' }],
    ['link', { rel: 'canonical', href: 'https://www.i-lingro.com' }],
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['link', { rel: 'alternate', type: 'application/json+oembed', href: 'https://chat.i-lingro.com', title: '灵格若AI助手' }],
  ],
  // themeConfig: {
  //   socialLinks: [
  //     {
  //       icon: 'github',
  //       mode: 'link',
  //       content: 'https://github.com/web-infra-dev/rspress',
  //     },
  //   ],
  // },
  multiVersion: {
    default: 'v1',
    versions: ['v1'],
  },
  plugins: [
    sitemap({
      domain: "https://www.i-lingro.com",
      defaultChangeFreq: "daily",
      defaultPriority: "0.7",
    }),
  ],
});
