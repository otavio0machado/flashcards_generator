// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use tauri::Manager;

#[tauri::command]
fn get_app_info() -> serde_json::Value {
    serde_json::json!({
        "version": env!("CARGO_PKG_VERSION"),
        "name": env!("CARGO_PKG_NAME"),
    })
}

#[tauri::command]
fn set_window_title(window: tauri::WebviewWindow, title: String) -> Result<(), String> {
    window.set_title(&title).map_err(|e| e.to_string())
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_shell::init())
        .plugin(tauri_plugin_notification::init())
        .plugin(tauri_plugin_http::init())
        .plugin(tauri_plugin_os::init())
        .invoke_handler(tauri::generate_handler![get_app_info, set_window_title])
        .setup(|app| {
            let main_window = app.get_webview_window("main").unwrap();

            // Always maximize and show the main window
            let _ = main_window.maximize();
            let _ = main_window.show();
            let _ = main_window.set_focus();

            // Close splash screen
            if let Some(splash) = app.get_webview_window("splashscreen") {
                let _ = splash.close();
            }

            #[cfg(debug_assertions)]
            {
                main_window.open_devtools();
            }

            Ok(())
        })
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
