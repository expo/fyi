# Remove alpha channel from app icon

According to [Apple's Human Interface guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/), transparency is not allowed in app icons.

There are a variety of ways to remove transparency from your app's icon.

### Using Preview app (Mac)

- Open the image in Preview
- File > Duplicate (Command-Shift-S)
- File > Save (Command-S)
- In the save dialogue, deselect the "Alpha" checkbox
- Delete " copy" from filename (including the space)
- This will overwrite your original, if you want to keep the original, just leave "copy" in the name or name it something else.
- Save
- Click 'Replace' to confirm you want to overwrite the original (Only necessary if you are overwriting your original)

### Using Alpha-Channel-Remover App (Mac)

If you have many images to process you may want to use an open source program to remove alpha channels.

Find Alpha-Channel-Remover on GitHub [here](https://github.com/bpolat/Alpha-Channel-Remover), and download it [here](http://alphachannelremover.blogspot.com/)

### Using ImageMagick

ImageMagick is a command line utility for editing images.

- Run `brew install imagemagick`
- Then run `convert <ORGINAL_IMAGE_NAME>.png -background black -alpha remove -alpha off <OUTPUT_IMAGE_NAME>.png`.

---

Once you've removed transparency from your app icon, rebuild your app.
