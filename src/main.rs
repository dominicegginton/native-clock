#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

extern crate chrono;

use chrono::Local;

fn main() {
  tauri::Builder::default()
    .invoke_handler(tauri::generate_handler![time])
    .run(tauri::generate_context!())
    .expect("error while running application");
}

#[tauri::command]
fn time() -> String {
  let date = Local::now();
  format!("{}", date.format("[%Y-%m-%d][%H:%M:%S]"))
}
