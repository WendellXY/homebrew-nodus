# homebrew-nodus

Official Homebrew tap scaffold for Nodus.

## User install

Preferred one-command install:

```bash
brew install WendellXY/nodus/nodus
```

Equivalent two-step install:

```bash
brew tap WendellXY/nodus
brew install nodus
```

## Tap repository layout

Create a separate GitHub repository named `homebrew-nodus`, then copy these paths into it:

```text
Formula/nodus.rb
README.md
```

Homebrew resolves `brew tap WendellXY/nodus` to `https://github.com/WendellXY/homebrew-nodus`.

## Maintainer release flow

1. Publish a GitHub Release with the binary archives created by the main repository release workflow.
2. In the main `nodus` repository, run:

```bash
./packaging/homebrew-nodus/scripts/update-formula.sh
```

3. Copy the updated `Formula/nodus.rb` into the `homebrew-nodus` repository.
4. Commit and push the tap repo.
5. Validate locally:

```bash
brew install --build-from-source ./Formula/nodus.rb
brew test nodus
```

## Notes

- The formula installs prebuilt GitHub Release archives instead of compiling with Rust.
- `generate_completions_from_executable` installs shell completions from `nodus completion`.
- If you want Homebrew to build bottles automatically, initialize the tap with `brew tap-new WendellXY/nodus` and keep its default GitHub Actions workflows.
