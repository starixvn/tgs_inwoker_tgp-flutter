import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tgp_flutter/extension/screen_apis.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DepositHtml extends StatefulWidget {
  final String htmlText;

  DepositHtml({
    Key key,
    this.htmlText,
  }) : super(key: key);

  @override
  _DepositHtmlState createState() => _DepositHtmlState();
}

class _DepositHtmlState extends BaseState<DepositHtml> {
  WebViewController _controller;
  String text = r"""<!DOCTYPE html> <html> <head>
  <title></title>
  </head>
  <body>
  <form method="post" name="SendForm" action="https://directpay.testingzone88.com/MerchantTransferRedirection.aspx?al=hTbPW0eXGZpWze2Seu%2fAneRIsmQvQsbnwgQZ1zxwSSU%3d">
  <input type='hidden' name='MerchantCode' value='PHP-G1' />
  <input type='hidden' name='CustomerID' value='INT0492_4udwadfdvua6' />
  <input type='hidden' name='RefID' value='390620' />
  <input type='hidden' name='Currency' value='PHP' />
  <input type='hidden' name='BankCode' value='BDO' />
  <input type='hidden' name='Amount' value='70.00' />
  <input type='hidden' name='Remark' value='' />
  <input type='hidden' name='TransactionDate' value='2021-11-26 10:02:31AM' />
  <input type='hidden' name='ReturnURL' value='http://api.testingzone88.com/BackResponse/3d01ce60-e2f9-4d52-8ecc-cefba1fd7214/' />
  <input type='hidden' name='FrontURL' value='https://api.testingzone88.com/FrontResponse/3d01ce60-e2f9-4d52-8ecc-cefba1fd7214/' />
  <input type='hidden' name='Language' value='en-us' />
  <input type='hidden' name='EncryptedSign' value='760EFB63BF659580017BCEB7AEC1F884' />
  <input type='hidden' name='ClientIP' value='::ffff:10.0.55.191' />
  <input type='hidden' name='TransferType' value='' />
  <input type='hidden' name='SpecificBankAccountUID' value='' />
  <input type='hidden' name='LogoUrl' value='https://api.racethewind.net/images/logo_blank.png' />
  </form>
  </body>
  </html>
  <script>history.forward();</script>
  <script>SendForm.submit();</script>
  """;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: gradientDecoration,
          ),
          centerTitle: true,
          title: Text(
            getTranslatedText("deposit"),
            style: TextStyle(fontSize: 20.auto),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Builder(builder: (BuildContext context) {
            return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                _loadUrl();
              },
              //javascriptMode: JavascriptMode.unrestricted,
            );
          }),
        ));
  }

  _loadUrl() async {
    _controller.loadUrl(
      Uri.dataFromString(
        widget.htmlText,
        mimeType: 'text/html',
      ).toString(),
    );
  }
}

/*class _CustomWidgetFactory extends WidgetFactory {
  _CustomWidgetFactory(HtmlWidgetConfig config) : super(config);

  @override
  NodeMetadata parseLocalName(NodeMetadata meta, String localName) async {
    if (localName != 'form') return super.parseLocalName(meta, localName);

    return lazySet(null,
        buildOp: BuildOp(
          onWidgets: (meta, _) => [
            Builder(
              builder: (context) => RaisedButton(
                child: Text("Submit this form."),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => _FormSubmit(meta.domElement.outerHtml))),
              ),
            ),
          ],
        ));
  }
}

class _FormSubmit extends StatelessWidget {
  final String html;

  _FormSubmit(String formHtml)
      : html = """<html>
<body onload="document.getElementsByTagName('form')[0].submit();">
  <p>Loading...</p>
  <div style="opacity: 0">$formHtml</div>
</body>
</html>""";

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: webview_flutter.WebView(
      initialUrl: Uri.dataFromString(
        html,
        mimeType: 'text/html',
      ).toString(),
      javascriptMode: webview_flutter.JavascriptMode.unrestricted,
    ),
  );
}*/
