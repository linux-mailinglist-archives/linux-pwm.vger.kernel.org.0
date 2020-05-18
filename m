Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA11D7F8E
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 19:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgERRDk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 13:03:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:51867 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERRDk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 May 2020 13:03:40 -0400
IronPort-SDR: UJAhcV0hIdAGDvxncguY1T4xIAH5p43qKqu7V2Pbb7EIHTOlUqj8U9fk/vsfBWSjhPDkJKrD88
 U5Q8H7wY9+YQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 10:03:38 -0700
IronPort-SDR: pKtxDuWKX1oYAizRStGbvkJdLKNNCHg2tJSb/F0sX9Ke5ECDD66CKShy8scFV05EHzv05NbVTR
 3BljPhTDViAg==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="439291692"
Received: from ahermans-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 10:03:24 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 06/16] backlight: improve backlight_device documentation
In-Reply-To: <20200518160324.mak4mhgyrgdbr7ww@holly.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-7-sam@ravnborg.org> <20200518160324.mak4mhgyrgdbr7ww@holly.lan>
Date:   Mon, 18 May 2020 20:03:21 +0300
Message-ID: <87o8ql2n1i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 18 May 2020, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On Sun, May 17, 2020 at 09:01:29PM +0200, Sam Ravnborg wrote:
>> Improve the documentation for backlight_device and
>> adapt it to kernel-doc style.
>> 
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> ---
>>  include/linux/backlight.h | 81 ++++++++++++++++++++++++++++-----------
>>  1 file changed, 58 insertions(+), 23 deletions(-)
>> 
>> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
>> index 7f9cef299d6e..e2d72936bf05 100644
>> --- a/include/linux/backlight.h
>> +++ b/include/linux/backlight.h
>> @@ -14,21 +14,6 @@
>>  #include <linux/mutex.h>
>>  #include <linux/notifier.h>
>>  
>> -/* Notes on locking:
>> - *
>> - * backlight_device->ops_lock is an internal backlight lock protecting the
>> - * ops pointer and no code outside the core should need to touch it.
>> - *
>> - * Access to update_status() is serialised by the update_lock mutex since
>> - * most drivers seem to need this and historically get it wrong.
>> - *
>> - * Most drivers don't need locking on their get_brightness() method.
>> - * If yours does, you need to implement it in the driver. You can use the
>> - * update_lock mutex if appropriate.
>> - *
>> - * Any other use of the locks below is probably wrong.
>> - */
>> -
>>  enum backlight_update_reason {
>>  	BACKLIGHT_UPDATE_HOTKEY,
>>  	BACKLIGHT_UPDATE_SYSFS,
>> @@ -221,30 +206,80 @@ struct backlight_properties {
>>  	enum backlight_scale scale;
>>  };
>>  
>> +/**
>> + * struct backlight_device - backlight device data
>> + *
>> + * This structure holds all data required by a backlight device.
>> + */
>>  struct backlight_device {
>> -	/* Backlight properties */
>> +	/**
>> +	 * @props:
>> +	 *
>
> As last patch. Why no brief descriptions?

There are no "brief descriptions" in kernel-doc struct member inline
markup.

It would be possible to shorten this to:

	/**
	 * @props: Backlight properties
	 */

BR,
Jani.


>
>
>> +	 * Backlight properties
>> +	 */
>>  	struct backlight_properties props;
>>  
>> -	/* Serialise access to update_status method */
>> +	/**
>> +	 * @update_lock:
>> +	 *
>> +	 * update_lock is an internal backlight lock that serialise access
>> +	 * to the update_status() method. The iupdate_lock mutex shall not be used
>> +	 * by backlight drivers.
>
> In addition to the typo this directly contradicts the advice in the
> original "Notes on locking".
>
> A change this dramatic needs to be fully explaining in the patch
> description.
>
>
> Daniel.
>
>
>> +	 */
>>  	struct mutex update_lock;
>>  
>> -	/* This protects the 'ops' field. If 'ops' is NULL, the driver that
>> -	   registered this device has been unloaded, and if class_get_devdata()
>> -	   points to something in the body of that driver, it is also invalid. */
>> +	/**
>> +	 * @ops_lock:
>> +	 *
>> +	 * ops_lock is an internal backlight lock that protects the ops pointer
>> +	 * and is used around all accesses to ops and when the operations are
>> +	 * invoked. The mutex shall not be used by backlight drivers.
>> +	 */
>>  	struct mutex ops_lock;
>> +
>> +	/**
>> +	 * @ops:
>> +	 *
>> +	 * Pointer to the backlight operations. If ops is NULL, the driver that
>> +	 * registered this device has been unloaded, and if class_get_devdata()
>> +	 * points to something in the body of that driver, it is also invalid.
>> +	 */
>>  	const struct backlight_ops *ops;
>>  
>> -	/* The framebuffer notifier block */
>> +	/**
>> +	 * @fb_notif:
>> +	 *
>> +	 * The framebuffer notifier block
>> +	 */
>>  	struct notifier_block fb_notif;
>>  
>> -	/* list entry of all registered backlight devices */
>> +	/**
>> +	 * @entry:
>> +	 *
>> +	 * List entry of all registered backlight devices
>> +	 */
>>  	struct list_head entry;
>>  
>> +	/**
>> +	 * @dev:
>> +	 *
>> +	 * Parent device.
>> +	 */
>>  	struct device dev;
>>  
>> -	/* Multiple framebuffers may share one backlight device */
>> +	/**
>> +	 * @fb_bl_on:
>> +	 *
>> +	 * Multiple fbdev's may share one backlight device. The fb_bl_on
>> +	 * records the state of the individual fbdev.
>> +	 */
>>  	bool fb_bl_on[FB_MAX];
>>  
>> +	/**
>> +	 * @use_count:
>> +	 *
>> +	 * The number of uses of fb_bl_on.
>> +	 */
>>  	int use_count;
>>  };
>>  
>> -- 
>> 2.25.1
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
