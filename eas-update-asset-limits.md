# EAS Update Asset Limits

End-user devices download only assets that have not yet been downloaded, but each asset is listed in the update's manifest. A large number of assets will result in a larger manifest and potentially more assets to download, which is slower and more costly for the end user and will use more bandwidth under the developer's EAS account.

EAS therefore has a limit of 1000 assets per update. This hard limit is set to be much higher than a healthy number of assets in most apps.