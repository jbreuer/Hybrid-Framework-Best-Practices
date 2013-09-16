$(document).ready(function () {
    initValidations();
});

//Form validations
function initValidations() {
    if ($("#contactForm").length > 0) {
        $("#contactForm").validate({
            rules: {
                Email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                Name: $("input[name='Name']").data("val-required"),
                Email: {
                    required: $("input[name='Email']").data("val-required"),
                    email: $("input[name='Email']").data("val-invalid")
                },
                Comment: $("textarea[name='Comment']").data("val-required")
            }
        });
    }
}