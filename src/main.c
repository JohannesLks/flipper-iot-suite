#include <furi.h>
#include <gui/gui.h>
#include <input/input.h>
#include <gui/view_port.h>

static void draw_cb(Canvas* canvas, void* ctx) {
    UNUSED(ctx);
    canvas_clear(canvas);
    canvas_set_font(canvas, FontPrimary);
    canvas_draw_str(canvas, 8, 22, "Hello Flipper!");
    canvas_set_font(canvas, FontSecondary);
    canvas_draw_str(canvas, 8, 40, "BACK zum Beenden");
}

static void input_cb(InputEvent* e, void* ctx) {
    FuriSemaphore* exit_sem = ctx;
    if(e->type == InputTypeShort && e->key == InputKeyBack) {
        furi_semaphore_release(exit_sem);
    }
}

int32_t hello_fap_app(void* p) {
    UNUSED(p);

    Gui* gui = furi_record_open(RECORD_GUI);
    ViewPort* vp = view_port_alloc();
    FuriSemaphore* exit_sem = furi_semaphore_alloc(1, 0);

    view_port_draw_callback_set(vp, draw_cb, NULL);
    view_port_input_callback_set(vp, input_cb, exit_sem);
    gui_add_view_port(gui, vp, GuiLayerFullscreen);

    // Warten bis BACK gedrückt:
    furi_semaphore_acquire(exit_sem, FuriWaitForever);

    gui_remove_view_port(gui, vp);
    view_port_free(vp);
    furi_semaphore_free(exit_sem);
    furi_record_close(RECORD_GUI);
    return 0;
}
