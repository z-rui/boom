This change file enables mouse actions.

Since mouse actions are supported, we no longer need the following statement.
@x 1. Introduction
In fact, the program can also be extended to support mouse actions.
@y
@z

We need to add cases for mouse events in the main loop.
@x 25. The main loop
	switch (ch) {
@y
	@<Set up mouse mask@>;
reswitch:
	switch (ch) {
	@<Cases for mouse events@>;
@z


Add new sections for mouse actions before the index.

@x
@* Index.
@y
@ To enable the program to process mouse events, we need to call
|mousemask|.

@<Set up mouse mask@>=
mousemask(BUTTON1_CLICKED|BUTTON3_CLICKED, NULL);

@ @s MEVENT int
@<Cases for mouse events@>=
case KEY_MOUSE:
{
	MEVENT event;

	if (getmouse(&event) != OK) break;
	if (!wmouse_trafo(fieldwin, &event.y, &event.x, FALSE))
		break;
	if (event.bstate & BUTTON1_CLICKED)
		ch = ' '; /* reveal */
	else if (event.bstate & BUTTON3_CLICKED)
		ch = 'm'; /* mark */
	else
		break;
	y = event.y;
	x = event.x;
	assert(!(0 <= x && x < s->cols && 0 <= y && y < s->rows));
	z = y * s->cols + x;
	goto reswitch;
}
@* Index.
@z

% vim: ft=change
