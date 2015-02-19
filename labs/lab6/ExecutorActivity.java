package ssamot.mt;

import android.app.Activity;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class ExecutorActivity extends Activity {

    private final BlockingQueue<Runnable> fiboQueue;
    private ThreadPoolExecutor fiboExecutor;
    private final int n_threads;
    // all runners, so we can get the result for each thread
    FiboRunner runners[];

    public ExecutorActivity() {
        fiboQueue = new LinkedBlockingQueue<Runnable>();
        this.n_threads = Runtime.getRuntime().availableProcessors();

        //n_threads = 100;

        Log.v("Fibo", "n_threads=" + n_threads);

    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.v("Fibo", "Starting Threads");

        // Start a new threadpool
        fiboExecutor = new ThreadPoolExecutor(
                n_threads,       // Initial pool size
                n_threads,       // Max pool size
                5,
                TimeUnit.SECONDS,
                this.fiboQueue);


        runners = new FiboRunner[n_threads];
        for (int i = 0; i < n_threads; i++) {
            runners[i] = new FiboRunner();
        }


        // There are multiple ways of acquiring thread results
        for (int i = 0 ; i < n_threads; i++) {
            fiboExecutor.execute(runners[i]);
        }

    }

    @Override
    protected void onPause() {
        Log.v("Fibo", "Stopping Threads");
        super.onPause();

        // Stopping threads
        fiboExecutor.shutdownNow();

        // wait until shutdown is over
        while(!fiboExecutor.isTerminated()) {
            try {
                Log.v("Fibo", "Sleeping...");
                Thread.currentThread().sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        for (int i = 0; i < n_threads; i++) {
            Log.v("Fibo", "Fibonacci Number for Thread " + i + " " + runners[i].current_number);
        }
    }

    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(new DummyView(this, this.n_threads));



    }


}

class DummyView extends View {
    int n_threads = 0;


    public DummyView(Context context, int n_threads) {
        super(context);
        this.n_threads = n_threads;
    }

    public DummyView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public DummyView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    @Override
    public void onDraw(Canvas g) {
        Paint bg = new Paint();
        bg.setColor(Color.BLACK);
        bg.setStyle(Paint.Style.FILL);
        g.drawRect(0,0,getWidth(),getHeight(),bg);
        Paint textPaint = new Paint();
        textPaint.setColor(Color.WHITE);
        textPaint.setTextSize(20);
//
//        int width = getWidth();
//        int height = getHeight();

        g.drawText("Calculating fibonacci sequence with n_threads = " + n_threads, 10, 300, textPaint);
    }
}

class FiboRunner implements Runnable {

    long current_number = 0;

    @Override
    public void run() {


        int f_n2;
        int f_n1 = 1;
        int f_n = 1;
        for (; ; ) {
            f_n2 = f_n1;
            f_n1 = f_n;
            f_n = f_n2 + f_n1;

            // Notice interrupt handling
            if(Thread.currentThread().isInterrupted()) {
                Log.v("Fibo", "Stopping Thread" + Thread.currentThread().getName());
                current_number = f_n;
                break;

            }

        }

    }
}
