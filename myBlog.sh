#!/bin/bash

# Create directories for posts and pages
mkdir -p posts
mkdir -p pages

# Create sample post and page
cat <<EOF > posts/sample-post.html
<!DOCTYPE html>
<html>
<head>
    <title>Sample Post</title>
</head>
<body>
    <h1>Sample Post</h1>
    <p>This is a sample post.</p>
    <p>Date: $(date +%Y-%m-%d)</p>
</body>
</html>
EOF

cat <<EOF > pages/sample-page.html
<!DOCTYPE html>
<html>
<head>
    <title>Sample Page</title>
</head>
<body>
    <h1>Sample Page</h1>
    <p>This is a sample page.</p>
</body>
</html>
EOF

# Generate index.html
cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>My Blog</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        h1, h2, h3, h4, h5, h6 {
            font-weight: bold;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        h2 {
            font-size: 2rem;
            margin-top: 40px;
            margin-bottom: 10px;
        }

        h3 {
            font-size: 1.5rem;
            margin-top: 30px;
            margin-bottom: 10px;
        }

        p {
            font-size: 1rem;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        ul, ol {
            margin: 0;
            margin-bottom: 20px;
            padding-left: 20px;
        }

        li {
            margin-bottom: 10px;
        }

        a {
            color: #000;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>
        <h1>My Blog</h1>
    </header>

    <nav>
        <ul>
            <li><a href="index.html">Home</a></li>
            $(find pages -name '*.html' | while read page; do
                title=$(sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p' "$page")
                echo "<li><a href=\"$(basename "$page")\">$title</a></li>"
            done)

        </ul>
    </nav>

    <main>
        <h2>Latest Posts:</h2>
        <ul>
            $(find posts -name '*.html' | sort -r | while read post; do
                title=$(sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p' "$post")
                date=$(sed -n '(?<=<p>Date: ).*?(?=</p>)' "$post")
                echo "<li><article><h3><a href=\"$(basename "$post")\">$title</a></h3><time datetime=\"$date\">$date</time></article></li>"
            done)
        </ul>
    </main>
    <footer>
        &copy; $(date +%Y) My Blog
    </footer>
</body>
</html>
EOF
