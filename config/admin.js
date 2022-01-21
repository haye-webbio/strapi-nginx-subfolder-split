module.exports = ({ env }) => ({
  auth: {
    secret: env("ADMIN_JWT_SECRET", "6e0931a451ab6c0ffcc5c0dd3a35e686"),
  },
  url: "http://localhost:1337/dashboard",
});
