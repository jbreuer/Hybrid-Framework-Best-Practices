var UmbracoProject = UmbracoProject || {};

UmbracoProject.Validation = UmbracoProject.Validation || (function () {
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
    return {
        initValidations: initValidations
    };
}());

$(document).ready(function () {
    window.UmbracoProject.Validation.initValidations();
});