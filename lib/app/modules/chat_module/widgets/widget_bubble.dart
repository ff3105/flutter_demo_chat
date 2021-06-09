part of 'widgets.dart';

class WidgetBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String dateTime;
  final int type;
  final String? avatar;

  WidgetBubble({
    required this.message,
    required this.isMe,
    required this.dateTime,
    required this.type,
    this.avatar,
  });

  Widget build(BuildContext context) {
    final uri = Uri.tryParse(message);
    if (uri != null && type != 1) {
      if (uri.isAbsolute) {
        return Demo1(
          url: message,
          avatar: avatar,
          dateTime: dateTime,
          isMe: isMe,
        );
      }
    }

    if (type == 0) {
      return _buildTextBubble();
    } else {
      return _buildImageBubble(context);
    }
  }

  Widget _buildTextBubble() {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMe
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.green : Colors.grey.shade200,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(isMe ? 0 : 15),
                                bottomLeft: Radius.circular(!isMe ? 0 : 15),
                              ),
                            ),
                            child: SelectableText(
                              message,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black87,
                              ),
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: message));
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WidgetAvatar(
                          url: avatar,
                          isActive: false,
                          size: 45,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.green : Colors.grey.shade200,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(isMe ? 0 : 15),
                                bottomLeft: Radius.circular(!isMe ? 0 : 15),
                              ),
                            ),
                            child: SelectableText(
                              message,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black87,
                              ),
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: message));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImageBubble(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMe
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        Hero(
                          tag: message,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FullPhoto(url: message));
                              },
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                  ),
                                  width: 200,
                                  height: 200,
                                  padding: EdgeInsets.all(70.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Material(
                                  child: Image.asset(
                                    'assets/images/img_not_available.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                imageUrl: message,
                                width: 200,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WidgetAvatar(
                          url: avatar,
                          isActive: false,
                          size: 45,
                        ),
                        SizedBox(width: 5),
                        Hero(
                          tag: message,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FullPhoto(url: message));
                              },
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                  ),
                                  width: 200,
                                  height: 200,
                                  padding: EdgeInsets.all(70.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Material(
                                  child: Image.asset(
                                    'assets/images/img_not_available.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                imageUrl: message,
                                width: 200,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }
}

class Demo1 extends StatefulWidget {
  final String url;
  final bool isMe;
  final String dateTime;
  final String? avatar;

  const Demo1({
    Key? key,
    required this.isMe,
    required this.url,
    required this.dateTime,
    required this.avatar,
  }) : super(key: key);

  @override
  _Demo1State createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> {
  PreviewData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(
        left: widget.isMe ? 40 : 0,
        right: widget.isMe ? 0 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [widget.isMe ? _buildIsMe() : _buildNotMe()],
          )
        ],
      ),
    );
  }

  Widget _buildIsMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.dateTime,
            style: TextStyle(color: Colors.black26),
          ),
        ),
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(widget.isMe ? 0 : 15),
              bottomLeft: Radius.circular(!widget.isMe ? 0 : 15),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.isMe ? Colors.green : Colors.grey.shade200,
              ),
              child: LinkPreview(
                width: double.infinity,
                text: widget.url,
                linkStyle: TextStyle(color: Colors.white),
                headerStyle: TextStyle(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                onPreviewDataFetched: (data) {
                  setState(() {
                    this.data = data;
                  });
                },
                previewData: data,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNotMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WidgetAvatar(
          url: widget.avatar,
          isActive: false,
          size: 45,
        ),
        SizedBox(width: 5),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: widget.isMe ? Colors.green : Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(widget.isMe ? 0 : 15),
                bottomLeft: Radius.circular(!widget.isMe ? 0 : 15),
              ),
            ),
            child: Container(
              child: LinkPreview(
                onPreviewDataFetched: (data) {
                  setState(() {
                    this.data = data;
                  });
                },
                previewData: data,
                text: widget.url,
                width: double.infinity,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.dateTime,
            style: TextStyle(color: Colors.black26),
          ),
        ),
      ],
    );
  }
}
