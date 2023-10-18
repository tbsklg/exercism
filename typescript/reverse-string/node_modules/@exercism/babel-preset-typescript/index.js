module.exports = function (_api, opts = {}) {
  return {
    presets: [
      [
        require('@babel/preset-env'),
        {
          targets: {
            node: 'current',
          },
          useBuiltIns: 'usage',
          corejs: opts['corejs'] || '3.30',
        },
      ],
      require('@babel/preset-typescript'),
    ],
    plugins: [],
  };
};
