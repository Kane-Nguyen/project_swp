<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Image Upload</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <style>
    .img-container {
    display: inline-block;
    position: relative;
    margin: 10px;
}

.img-container img {
    width: 100px;
    height: 100px;
    object-fit: cover;
}

.delete-btn {
    background-color: transparent;
    border: none;
    color: red;
    font-size: 20px;
    cursor: pointer;
    position: absolute;
    top: 0;
    right: 0;
}



        </style>
    </head>
    <body>
        <form id="uploadForm" action="UploadServlet" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <th>Product ID</th>
                    <td><input type="text" name="product_id" required></td>
                </tr>
                <tr>
                    <th>Images</th>
                    <td>
                        <input type="file" name="images[]" id="imageInput" multiple required onchange="previewImages()">
                        <div id="imagePreview"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="submit">Upload</button>
                    </td>
                </tr>
            </table>
        </form>

        <script>
            function previewImages() {
    let imageInput = document.getElementById('imageInput');
    let imagePreview = document.getElementById('imagePreview');
    imagePreview.innerHTML = '';

    Array.from(imageInput.files).forEach(file => {
        let reader = new FileReader();
        reader.onload = function(e) {
            let imgContainer = document.createElement('div');
            imgContainer.classList.add('img-container');

            let img = new DocumentFragment().appendChild(document.createElement('img'));
            img.src = e.target.result;
            imgContainer.appendChild(img);

            let deleteBtn = document.createElement('button');
            deleteBtn.innerHTML = '✖'; // Red X icon
            deleteBtn.className = 'delete-btn'; // Apply CSS class
            deleteBtn.onclick = function() {
                imgContainer.remove();
                removeFile(file);
            };
            imgContainer.appendChild(deleteBtn);

            imagePreview.appendChild(imgContainer);
        };
        reader.readAsDataURL(file);
    });
}

function removeFile(fileToRemove) {
    let imageInput = document.getElementById('imageInput');
    let dt = new DataTransfer();
    Array.from(imageInput.files).forEach(file => {
        if (file !== fileToRemove) {
            dt.items.add(file);
        }
    });
    imageInput.files = dt.files;
}


        </script>



    </body>

</html>
