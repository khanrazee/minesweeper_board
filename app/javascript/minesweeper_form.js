function validateMines() {
    var widthField = document.getElementById('board_width');
    var heightField = document.getElementById('board_height');
    var minesField = document.getElementById('board_mines');

    var width = parseInt(widthField.value);
    var height = parseInt(heightField.value);
    var mines = parseInt(minesField.value);


    var totalCells = width * height;
    var maxAllowedMines = Math.ceil(0.15 * totalCells);

    if (mines < 0 || mines > maxAllowedMines) {
        alert('Please enter a valid number of mines. It should be minimum 1 and maximum ' + maxAllowedMines + '.');
        widthField.style.borderColor = '';
        heightField.style.borderColor = '';
        minesField.style.borderColor = 'red';
        return false;
    } else {
        widthField.style.borderColor = '';
        heightField.style.borderColor = '';
        minesField.style.borderColor = '';
    }

    return true;
}