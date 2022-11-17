import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/localization/default_localizations.dart';
import 'package:gsy_app_test/common/style/style.dart';
import 'package:gsy_app_test/widget/card_item.dart';
import 'package:gsy_app_test/widget/input_widget.dart';

//issue 编辑输入框
class IssueEditDialog extends StatefulWidget {
  final String dialogTitle;

  final ValueChanged<String>? onTitleChanged;

  final ValueChanged<String> onContentChanged;

  final VoidCallback onPressed;

  final TextEditingController? titleController;

  final TextEditingController? valueController;

  final bool needTitle;

  IssueEditDialog(this.dialogTitle, this.onTitleChanged, this.onContentChanged,
      this.onPressed,
      {this.titleController, this.valueController, this.needTitle = true});

  @override
  State<IssueEditDialog> createState() => _IssueEditDialogState();
}

class _IssueEditDialogState extends State<IssueEditDialog> {
  _IssueEditDialogState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,

            //触摸收起键盘
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Center(
                child: CardItem(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //dialog标题
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 15),
                          child: Center(
                            child: Text(
                              widget.dialogTitle,
                              style: TextConstant.normalTextBold,
                            ),
                          ),
                        ),

                        //标题输入框
                        renderTitleInput(),

                        //内容输入框
                        Container(
                          height: MediaQuery.of(context).size.width * 3 / 4,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            color: ColorUtil.white,
                            border: Border.all(
                                color: ColorUtil.subTextColor, width: 0.3),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, top: 12, right: 20, bottom: 12),
                          child: Column(
                            children: [
                              Expanded(
                                child: TextField(
                                  autofocus: false,
                                  maxLines: 999,
                                  onChanged: widget.onContentChanged,
                                  controller: widget.valueController,
                                  decoration: InputDecoration(
                                    hintText: BaseLocalizations.i18n(context)!
                                        .issue_edit_issue_title_tip,
                                    hintStyle: TextConstant.middleSubText,
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                  style: TextConstant.middleText,
                                ),
                              ),

                              //快速输入框
                              _renderFastInputContainer()
                            ],
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              child: Text(
                                BaseLocalizations.i18n(context)!.app_cancel,
                                style: TextConstant.normalSubText,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                            Container(
                              width: 0.3,
                              height: 25,
                              color: ColorUtil.subTextColor,
                            ),
                            Expanded(
                                child: RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              onPressed: widget.onPressed,
                              child: Text(
                                BaseLocalizations.i18n(context)!.app_ok,
                                style: TextConstant.normalTextBold,
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderTitleInput() {
    return (widget.needTitle)
        ? Padding(
            padding: EdgeInsets.all(5),
            child: InputWidget(
              onChanged: widget.onTitleChanged,
              controller: widget.titleController,
              hintText:
                  BaseLocalizations.i18n(context)!.issue_edit_issue_title_tip,
              obscureText: false,
            ),
          )
        : Container();
  }

  _renderFastInputContainer() {
    //因为是Column下包含了Listview，所以需要设置高度
    return Container(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RawMaterialButton(
            //取消间距
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            child: Icon(
              FAST_INPUT_LIST[index].iconData,
              size: 16,
            ),
            onPressed: () {
              String text = FAST_INPUT_LIST[index].content;
              String newText = "";
              if (widget.valueController?.value != null) {
                newText = widget.valueController!.value.text;
              }
              newText = newText + text;
              setState(() {
                widget.valueController!.value = TextEditingValue(text: newText);
              });
              widget.onContentChanged.call(newText);
            },
          );
        },
        itemCount: FAST_INPUT_LIST.length,
      ),
    );
  }
}

var FAST_INPUT_LIST = [
  FastInputIconModel(IconUtil.ISSUE_EDIT_H1, "\n# "),
  FastInputIconModel(IconUtil.ISSUE_EDIT_H2, "\n## "),
  FastInputIconModel(IconUtil.ISSUE_EDIT_H3, "\n### "),
  FastInputIconModel(IconUtil.ISSUE_EDIT_BOLD, "****"),
  FastInputIconModel(IconUtil.ISSUE_EDIT_ITALIC, "__"),
  FastInputIconModel(IconUtil.ISSUE_EDIT_QUOTE, "` `"),
  FastInputIconModel(IconUtil.ISSUE_EDIT_CODE, " \n``` \n\n``` \n"),
  FastInputIconModel(IconUtil.ISSUE_EDIT_LINK, "[](url)"),
];

class FastInputIconModel {
  final IconData iconData;
  final String content;

  FastInputIconModel(this.iconData, this.content);
}
