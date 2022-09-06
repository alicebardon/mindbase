const makeFlashesDisappear = () => {
  console.log("time our set")
    setTimeout(() => {
      console.log("time out called")
      document.querySelector('.alert').style.display = 'none';
    }, 3000);
};

export { makeFlashesDisappear };
