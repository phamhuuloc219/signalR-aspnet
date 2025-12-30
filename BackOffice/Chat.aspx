<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="BackOffice.Chat" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignalR Chat</title>
    <style>
        .container { padding: 20px; font-family: sans-serif; }
        #discussion { list-style-type: none; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Chat Room</h2>
            <input type="text" id="displayname" placeholder="Nhập tên bạn" />
            <input type="text" id="message" placeholder="Nhập tin nhắn" />
            <input type="button" id="sendmessage" value="Gửi tin nhắn" />
            
            <ul id="discussion">
                </ul>
        </div>
    </form>

    <script src="Scripts/jquery-3.7.0.min.js"></script>

    <script src="Scripts/jquery.signalR-2.4.3.min.js"></script>

    <script src="/signalr/hubs"></script>

    <script type="text/javascript">
        $(function () {
            var chat = $.connection.chatHub;

            chat.client.addNewMessageToPage = function (name, message) {
                $('#discussion').append('<li><strong>' + htmlEncode(name) 
                    + '</strong>: ' + htmlEncode(message) + '</li>');
            };

            // connect
            $.connection.hub.start().done(function () {
                $('#sendmessage').click(function () {
                    chat.server.sendMessage($('#displayname').val(), $('#message').val());
                    
                    $('#message').val('').focus();
                });
            });
        });

        function htmlEncode(value) {
            var encodedValue = $('<div />').text(value).html();
            return encodedValue;
        }
    </script>
</body>
</html>
