/**
 * @type {import('semantic-release').GlobalConfig}
 */
export default {
  branches: [{ name: 'main' }],
  plugins: [
    [
      '@semantic-release/release-notes-generator', // Generates release notes for the commits included in the release
      {
        preset: 'conventionalcommits',
        presetConfig: {
          types: [
            { type: 'feat', section: 'New Features' },
            { type: 'fix', section: 'Bug Fixes' },
            { type: 'update', section: 'Other Updates', hidden: false },
            {
              type: 'perf',
              section: 'Performance Improvements',
              hidden: false,
            },
            { type: 'chore', hidden: true },
            { type: 'docs', hidden: true },
            { type: 'style', hidden: true },
            { type: 'refactor', hidden: true },
            { type: 'test', hidden: true },
            { type: 'ci', hidden: true },
            { type: 'revert', hidden: true },
            { type: 'build', hidden: false },
          ],
        },
        parserOpts: {
          noteKeywords: ['BREAKING CHANGE', 'BREAKING CHANGES', 'BREAKING'],
        },
      },
    ],
    '@semantic-release/github', // Creates a GitHub release
  ],
  tagFormat: '${version}', // Don't use 'v' prefix for tags
};
