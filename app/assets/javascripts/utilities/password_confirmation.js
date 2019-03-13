document.addEventListener('turbolinks:load', function () {
    var control = document.getElementById('user_password_confirmation')

    if (control) { control.addEventListener('input', passwordCheck) }
});

function passwordCheck() {
    var pass = document.getElementById('user_password').value
    var passConf = this.value

    if (passConf === pass) {
        document.querySelector('.octicon-thumbsup').classList.remove('hide')
        document.querySelector('.octicon-thumbsdown').classList.add('hide')
    } else {
        document.querySelector('.octicon-thumbsup').classList.add('hide')
        document.querySelector('.octicon-thumbsdown').classList.remove('hide')
    }

    if (passConf == 0) {
        document.querySelector('.octicon-thumbsup').classList.add('hide')
        document.querySelector('.octicon-thumbsdown').classList.add('hide')
    }
}
