package filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashSet;
import java.util.Set;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginFilter implements Filter {

    private static final boolean debug = true;
    private FilterConfig filterConfig = null;
    private Set<String> excludedUrls;

    public LoginFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoBeforeProcessing");
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoAfterProcessing");
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("AuthenFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Check if the current request path is in the list of excluded URLs
        boolean isExcluded = excludedUrls.stream().anyMatch(path::startsWith);

        if (!isExcluded && session.getAttribute("account") == null) {
            req.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            Throwable problem = null;
            try {
                chain.doFilter(request, response);
            } catch (Throwable t) {
                problem = t;
                t.printStackTrace();
            }
            doAfterProcessing(request, response);

            if (problem != null) {
                if (problem instanceof ServletException) {
                    throw (ServletException) problem;
                }
                if (problem instanceof IOException) {
                    throw (IOException) problem;
                }
                sendProcessingError(problem, response);
            }
        }
    }

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenFilter:Initializing filter");
            }
        }
        // Initialize the set of excluded URLs
        excludedUrls = new HashSet<>();
        excludedUrls.add("/LoginActionServlet");
        excludedUrls.add("/LoginChangePage");
        excludedUrls.add("/RegisterServlet");
        excludedUrls.add("/GoogleLoginServlet");
        excludedUrls.add("/LoginActionServlet");
        excludedUrls.add("/index.jsp");
        excludedUrls.add("/login.jsp");
        excludedUrls.add("/login-dentist.jsp");
        excludedUrls.add("/login-staff.jsp");
        excludedUrls.add("/register.jsp");
        excludedUrls.add("/userWeb-verifyEmail.jsp");
        excludedUrls.add("/forgetPassword.jsp");
        excludedUrls.add("/css"); // Exclude CSS files
        excludedUrls.add("/js");  // Exclude JavaScript files
        excludedUrls.add("/images");
        excludedUrls.add("/ForgetPasswordServlet");
        excludedUrls.add("/SendPasswordServlet");// Exclude images
        // Add more URLs to exclude as needed
    }

    public void destroy() {
    }

    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthenFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }
}
