
export const noop = () => {};

export function click(){
    let audio = document.getElementById("clickaudio");
    audio.play();
}


export function playringtone(){
    let audio = document.getElementById("ringtonedata");
    audio.play();
}

export function stopringtone(){
    let audio = document.getElementById("ringtonedata");
    audio.pause();
}