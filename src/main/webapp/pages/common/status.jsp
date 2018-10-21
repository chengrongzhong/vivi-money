<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Threads in ldcstudy.com</title>
<style>
body {
	font-size: 8pt;
}

ol {
	line-height: 18px;
}
</style>
</head>
<body>
	<strong>java.io.tmpdir:</strong>
	<ul>
		<li><%=System.getProperty("java.io.tmpdir")%></li>
	</ul>
	<br />
	<strong>Memory:</strong>
	<ol>
		<li>freeMemory=<%=Runtime.getRuntime().freeMemory() / (1024 * 1024)%>M
		</li>
		<li>totalMemory=<%=Runtime.getRuntime().totalMemory() / (1024 * 1024)%>M
		</li>
		<li>maxMemory=<%=Runtime.getRuntime().maxMemory() / (1024 * 1024)%>M
		</li>
	</ol>
	<br />
	<%
		java.util.List<Thread> threads = list_threads();
	%>
	<strong>Thread:<%=threads.size()%></strong>
	<ol>
		<%
			for (Thread t : threads) {
		%>
		<li><%=t.getName()%>(<b><%=t.getState()%></b>) : <%=t.getClass().getName()%></li>
		<%
			}
		%>
	</ol>
	<%!public static java.util.List<Thread> list_threads() {
		int tc = Thread.activeCount();
		Thread[] ts = new Thread[tc];
		Thread.enumerate(ts);
		return java.util.Arrays.asList(ts);
	}%>
</body>
</html>
