/*
The MIT License (MIT)

Copyright (c) 2015-present Badoo Trading Limited.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import UIKit
import Chatto
import ChattoAdditions

public class TextAutolayoutPresenterBuilder: ChatItemPresenterBuilderProtocol {

    public func canHandleChatItem(chatItem: ChatItemProtocol) -> Bool {
        return chatItem is TextMessageModel ? true : false
    }

    public func createPresenterWithChatItem(chatItem: ChatItemProtocol) -> ChatItemPresenterProtocol {
        assert(self.canHandleChatItem(chatItem))
        return TextAutoLayoutPresenter(
            textModel: chatItem as! TextMessageModel
        )
    }

    public var presenterType: ChatItemPresenterProtocol.Type {
        return TextAutoLayoutPresenter.self
    }
}

class TextAutoLayoutPresenter: ChatItemPresenterProtocol {

    let textModel: TextMessageModel
    init (textModel: TextMessageModel) {
        self.textModel = textModel
    }

    static func registerCells(collectionView: UICollectionView) {
        collectionView.registerNib(UINib(nibName: "TextAutolayoutCell", bundle: nil), forCellWithReuseIdentifier: "TextAutolayoutCell")
    }

    func dequeueCell(collectionView collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TextAutolayoutCell", forIndexPath: indexPath)
        return cell
    }

    func configureCell(cell: UICollectionViewCell, decorationAttributes: ChatItemDecorationAttributesProtocol?) {
        guard let textCell = cell as? TextAutolayoutCell else {
            assert(false, "expecting status cell")
            return
        }

        textCell.textView.text = self.textModel.text
    }

    var canCalculateHeightInBackground: Bool {
        return false
    }

    func heightForCell(maximumWidth width: CGFloat, decorationAttributes: ChatItemDecorationAttributesProtocol?) -> CGFloat {
        return 0
    }
}
