//
//  Released by YoYo Games Ltd. on 17/04/2014. Intended for use with GM: S EA97 and above ONLY.
//  Copyright YoYo Games Ltd., 2014.
//  For support please submit a ticket at help.yoyogames.com
//
//


package ${YYAndroidPackageName};

import android.util.Log;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.InterstitialAd;
import android.os.Build;
import ${YYAndroidPackageName}.R;
import android.app.Activity;
import android.view.ViewGroup;
import android.view.View;
import android.widget.AbsoluteLayout;
import com.yoyogames.runner.RunnerJNILib;

public class GoogleMobileAdsExt extends AdListener
{
	private AdView adView=null;
	private InterstitialAd interstitialAd=null;
	//private String BannerId;
	private String InterstitialId;
	private String InterstitialStatus = "Not Ready";
	private String TestDeviceId;
	private boolean bUseTestAds=false;
	private AdSize BannerSize;
	private int BannerXPos;
	private int BannerYPos;
	
	private static final int EVENT_OTHER_SOCIAL = 70;
	
	public void GoogleMobileAds_Init(String _Arg1)
	{
	
		InterstitialId = _Arg1;	
	}
	
	public void GoogleMobileAds_ShowInterstitial()
	{
		if(interstitialAd!=null)
		{
	
			RunnerActivity.ViewHandler.post( new Runnable() {
    		public void run() 
    		{
				Log.i("yoyo","showinterstitial called");
				if (interstitialAd.isLoaded()) 
				{
					RunnerActivity.CurrentActivity.runOnUiThread(new Runnable() {
						public void run() {
							interstitialAd.show();
						}
					});
				} 
				else
				{
					Log.i("yoyo", "Interstitial ad was not ready to be shown.");
				}
    		}});
		}
    	
	}
	
	private void initInterstitial()
	{
	
		interstitialAd = new InterstitialAd(RunnerActivity.CurrentActivity);
		interstitialAd.setAdUnitId(InterstitialId);
			
		interstitialAd.setAdListener(GoogleMobileAdsExt.this);
	}
	
	public void GoogleMobileAds_LoadInterstitial()
	{
		RunnerActivity.ViewHandler.post( new Runnable() {
    	public void run() 
    	{
			if(interstitialAd==null)
				initInterstitial();
				
			AdRequest.Builder builder = new AdRequest.Builder();
			builder.addTestDevice(AdRequest.DEVICE_ID_EMULATOR);
			if( bUseTestAds)
				builder.addTestDevice(TestDeviceId);
			AdRequest adRequest = builder.build();

			// Load the interstitial ad.
			interstitialAd.loadAd(adRequest);
		}});
	}
	
	private void sendBannerLoadedEvent( boolean _bLoaded )
	{
		int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
		
		RunnerJNILib.DsMapAddString( dsMapIndex, "type", "banner_load" );
		double loaded = (_bLoaded) ? 1 : 0;
		RunnerJNILib.DsMapAddDouble( dsMapIndex, "loaded", loaded);
		
		if( _bLoaded)
		{
			GoogleMobileAds_MoveBanner(BannerXPos, BannerYPos);
		
			RunnerJNILib.DsMapAddDouble( dsMapIndex, "width",  GoogleMobileAds_BannerGetWidth());
			RunnerJNILib.DsMapAddDouble( dsMapIndex, "height",  GoogleMobileAds_BannerGetHeight());
		}
		
		RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
	}
	
	private void sendInterstitialLoadedEvent( boolean _bLoaded )
	{
		int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
		RunnerJNILib.DsMapAddString( dsMapIndex, "type", "interstitial_load" );
		double loaded = (_bLoaded) ? 1 : 0;
		RunnerJNILib.DsMapAddDouble( dsMapIndex, "loaded", loaded);
		RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
	}
	
	public void GoogleMobileAds_AddBanner(String _bannerId, double _sizeType)
	{
		GoogleMobileAds_AddBannerAt( _bannerId, _sizeType, 0, 0);
	}
	
	public void GoogleMobileAds_AddBannerAt(String _bannerId, double _sizeType, double _x, double _y)
	{
		final String bannerId = _bannerId;
		BannerXPos = (int)_x;
		BannerYPos = (int)_y;
		int type = (int)(_sizeType+0.5);
		
		switch(type)
		{
		case 1: BannerSize = AdSize.BANNER; break;
		case 2: BannerSize = AdSize.MEDIUM_RECTANGLE;break;
		case 3: BannerSize = AdSize.FULL_BANNER;break;
		case 4: BannerSize = AdSize.LEADERBOARD;break;
		case 5: BannerSize = AdSize.WIDE_SKYSCRAPER; break;
		default: Log.i("yoyo", "AddBanner illegal banner size type:" + _sizeType); return;
		}
		
		RunnerActivity.ViewHandler.post( new Runnable() {
    	public void run() 
    	{
    		AbsoluteLayout layout = (AbsoluteLayout)RunnerActivity.CurrentActivity.findViewById(R.id.ad);
			ViewGroup vg = (ViewGroup)layout;
			
			//remove existing banner
			if( adView != null )
			{
				if(vg!=null)
				{
					vg.removeView( adView );
				}
				adView.destroy();
				adView = null;
			}
			
    		//create new banner
			adView = new AdView(RunnerActivity.CurrentActivity);
			//adView.setAdListener(GoogleMobileAdsExt.this);
			adView.setAdListener( new AdListener() {
				/** Called when an ad is loaded. */
			    @Override
			    public void onAdLoaded() 
			    {
			    	Log.i("yoyo", "Banner Ad onAdLoaded");
			    	sendBannerLoadedEvent(true);
			    }
			    
			    @Override
			    public void onAdFailedToLoad(int errorCode)
			    {
			    	Log.i("yoyo", "Banner Ad onAdFailedToLoad");
			    	sendBannerLoadedEvent(false);
			    }
			    
			});    
		
			int sdkVersion =Build.VERSION.SDK_INT;
			if (sdkVersion > 10)
				adView.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
		
			//adView.setAdSize(AdSize.BANNER);	
			adView.setAdSize( BannerSize );
			adView.setAdUnitId(bannerId);
			
			if(vg != null)
			{
				vg.addView((View)adView);
			
				AdRequest.Builder builder = new AdRequest.Builder();
				builder.addTestDevice(AdRequest.DEVICE_ID_EMULATOR);
				if( bUseTestAds)
					builder.addTestDevice(TestDeviceId);
				AdRequest adRequest = builder.build();

				// Start loading the ad in the background.
				adView.setVisibility(View.INVISIBLE);
				adView.loadAd(adRequest);
			}
		}});
	}
	
	public void GoogleMobileAds_RemoveBanner()
	{
		if( adView != null )
		{
			RunnerActivity.ViewHandler.post( new Runnable() {
			public void run() 
		    {
				AbsoluteLayout layout = (AbsoluteLayout)RunnerActivity.CurrentActivity.findViewById(R.id.ad);
				ViewGroup vg = (ViewGroup)layout;
				if(vg!=null)
				{
					vg.removeView( adView );
				}
				adView.destroy();
				adView = null;
				
		    }});
		}
	}
	
	public double GoogleMobileAds_BannerGetWidth()
	{
		if( BannerSize !=null )
		{
			int w =BannerSize.getWidthInPixels(RunnerJNILib.ms_context); 
			return w;
		}
		return 0;
	}
	
	public double GoogleMobileAds_BannerGetHeight()
	{
		if( BannerSize !=null )
		{
			int h = BannerSize.getHeightInPixels(RunnerJNILib.ms_context);
			return h;
		}
		return 0;
	}
	
	public void GoogleMobileAds_MoveBanner( double _x, double _y )
	{
		Log.i("yoyo", "MoveBanner:" + _x + "," + _y);
		final int x = (int)_x;
		final int y = (int)_y;
		BannerXPos = x;
		BannerYPos = y;

		if( adView != null )
		{
			RunnerActivity.ViewHandler.post( new Runnable() {
			public void run()
			{
				if( x < 0 || y < 0) {
					adView.setVisibility(View.INVISIBLE);
				}
				else
				{
					AbsoluteLayout.LayoutParams params = new AbsoluteLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT, x,y );
					adView.setLayoutParams( params);
					adView.requestLayout();
					adView.setVisibility(View.VISIBLE);
				}
			}});
		}
	}
	
	public void GoogleMobileAds_UseTestAds( double _useTest, String _deviceId )
	{
		bUseTestAds = (_useTest >=0.5);
		TestDeviceId = _deviceId;
	}
	
	public String GoogleMobileAds_InterstitialStatus()
	{
		if(interstitialAd!=null)
		{
			RunnerActivity.ViewHandler.post( new Runnable() {
    		public void run() 
    		{
				if(interstitialAd.isLoaded())
					InterstitialStatus="Ready";
				else
					InterstitialStatus = "Not Ready";
			}});
		}

		return InterstitialStatus;
	}
	
	@Override
     public void onAdLoaded() {
		Log.i("yoyo","onAdLoaded called");
		sendInterstitialLoadedEvent( true );
     }

    @Override
    public void onAdFailedToLoad(int errorCode) {
		Log.i("yoyo","onAdFailedToLoad called");
		sendInterstitialLoadedEvent( false );
    }

	
/*	 @Override
  public void onResume() {
    super.onResume();
    if (adView != null) {
      adView.resume();
    }
  }

  @Override
  public void onPause() {
    if (adView != null) {
      adView.pause();
    }
    super.onPause();
  }
*/
  /** Called before the activity is destroyed. */
  /*
  @Override
  public void onDestroy() {
    // Destroy the AdView.
    if (adView != null) {
      adView.destroy();
    }
    super.onDestroy();
  }	
	*/
}



