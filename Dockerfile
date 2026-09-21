# Use the official Bun image which includes bun and bunx (compatible with the repo's bun.lock & bunx scripts)
FROM oven/bun:latest

# Set a working directory
WORKDIR /app

# Copy package manifest and lockfile first to take advantage of Docker layer caching
COPY package.json bun.lock* ./

# Install dependencies (this will use bun and respect bun.lock)
RUN bun install

# Copy the rest of the project
COPY . .

# Expose Expo default ports
EXPOSE 19000 19001 19002

# Ensure the dev server binds to all interfaces inside the container
ENV REACT_NATIVE_PACKAGER_HOSTNAME=0.0.0.0
ENV EXPO_DEVTOOLS_LISTEN_ADDRESS=0.0.0.0

# Start the app using the project's start script.
# Note: the repository's package.json appears to use bunx in scripts, so we use bun to run the script.
CMD ["bun", "run", "start", "--tunnel"]
