Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26242177D1
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2020 21:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGTVn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jul 2020 15:21:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31437 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728036AbgGGTVn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 15:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594149700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7C3OOhak1R0HOERqt5hRDg2mN9tt9iBSGOpLDrOsRs=;
        b=LniOkpZ3peAHANtrW7sMjM8gpMSjIEsH8NqIu2/gEf0KDWzUbux7rhwwAYjY47n5BNX9Xo
        Cl20n5LvtHBjjS2ApHa1NwYqhw9QPQkoLdqHkmLP/LiSfv9D1SkhGjI7Trkw0uGVTh1Cbp
        1F7kL3sjVhP/kil+tFdCQAzoPUmjz/s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-dqKvQ88oNau6sxqTJOnocQ-1; Tue, 07 Jul 2020 15:21:38 -0400
X-MC-Unique: dqKvQ88oNau6sxqTJOnocQ-1
Received: by mail-ej1-f70.google.com with SMTP id b24so40567983ejb.8
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2020 12:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7C3OOhak1R0HOERqt5hRDg2mN9tt9iBSGOpLDrOsRs=;
        b=RsGQvQmZ8Cenf1izDS1C6hsT2VJFWuUFI7ZLN+0W+WLsJKFOrCQWAaFsWdthBTxLuE
         EEMPAIV8xtLXxs/L/mBREY1z5Gl3RLoS1sV4ZJsMCK+A1jcJ1/K+5A7hX34a9of7+zrd
         ZcqsJ7nnB611S8PERyHxaiRNZM1amdqFIohcq/uesHBvXBAgMm1twksww2BH+ZjvynxA
         jqrt77vy4ndGH1im20lzeC/aGKcj6a8VYkmmuEmPgMAw8dJmWVqJVryV0vIVtl7cu8AK
         YL5O3Wc+QNxd9nN/DwLhcGPtojXlMST4DQPUT6P005yVc81uzeUqHFPovmCcXnGM87Lu
         xpAw==
X-Gm-Message-State: AOAM5309Y7Xuc79XXxyADXkofM+GQtGLrHrLj17O3GnKEUwN8HmfCQGV
        vm+zfUSFOaTPThmDxE6UgZcWlFpOwUdITUjE6lDdaDbxWFmqpN1qpCYxn5lGEBawd/wHFBr8hjq
        aFz/PlAJ5Jbqx3aoOQdub
X-Received: by 2002:a05:6402:1ca8:: with SMTP id cz8mr45504840edb.55.1594149696800;
        Tue, 07 Jul 2020 12:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweMem1HnkyFWuja5VXmzqhwTLcmAIHYAGXGFap1GO1a7kswmdFcs5m7fWuZ6BPJUAW7y3bPg==
X-Received: by 2002:a05:6402:1ca8:: with SMTP id cz8mr45504820edb.55.1594149696516;
        Tue, 07 Jul 2020 12:21:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id sd15sm753309ejb.66.2020.07.07.12.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 12:21:35 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 15/15] drm/i915: panel: Use atomic PWM API for devs
 with an external PWM controller
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-16-hdegoede@redhat.com>
 <20200707075056.22w5kzi7qwhkctsn@pengutronix.de>
Message-ID: <6d84d2ba-5e3f-d504-b662-edd98222d941@redhat.com>
Date:   Tue, 7 Jul 2020 21:21:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707075056.22w5kzi7qwhkctsn@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 7/7/20 9:50 AM, Uwe Kleine-König wrote:
> Hello Hans,
> 
> On Sat, Jun 20, 2020 at 02:17:58PM +0200, Hans de Goede wrote:
>> Now that the PWM drivers which we use have been converted to the atomic
>> PWM API, we can move the i915 panel code over to using the atomic PWM API.
> 
> Note that there is no hard dependency, the atomic API should work just
> fine even with a non-converted driver. (Of course a converted driver
> behaves better, but the i915 using the atomic API with a non-converted
> driver is just as good as the legacy API with the same driver.)
> 
> So regarding your plan to get this series in soon: There is no hard need
> to halt the efforts for the drm part if the pwm patches take a bit
> longer (or vice versa).

I understand, but the main reason to do the conversion to the atomic
API, is to be able to skip the step where we force the backlight
to 100% brightness (which can look quite ugly during boot).

After this patch the intel-panel code initializes its internal
backlight state and the brightness reported under /sys/class/backlight
with the "brightness" returned from the PWM-drivers' get_state callback.

Without getting the PWM patches in first I think that things will
mostly work, but we will always report an initial brightness value
of 0. Lets say it is actually 50% and the user then presses the
increase-brightness hotkey, causing userspace to change it from 0% to 5%
so instead of increasing it by 1/20th, it just decreased it a lot.

So I do believe it is better to get the whole series in as a whole,
since we are at rc4 already (time flies) I guess it might not make it
in this cycle, but that is fine.

Talking about merging this, is it ok for me to push the entire
series upstream through the intel-drm-next-queued branch,
once all the PWM patches have your Ack?

>> The removes a long standing FIXME and this removes a flicker where
>> the backlight brightness would jump to 100% when i915 loads even if
>> using the fastset path.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../drm/i915/display/intel_display_types.h    |  3 +-
>>   drivers/gpu/drm/i915/display/intel_panel.c    | 73 +++++++++----------
>>   2 files changed, 37 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
>> index de32f9efb120..4bd9981e70a1 100644
>> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
>> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
>> @@ -28,6 +28,7 @@
>>   
>>   #include <linux/async.h>
>>   #include <linux/i2c.h>
>> +#include <linux/pwm.h>
>>   #include <linux/sched/clock.h>
>>   
>>   #include <drm/drm_atomic.h>
>> @@ -223,7 +224,7 @@ struct intel_panel {
>>   		bool util_pin_active_low;	/* bxt+ */
>>   		u8 controller;		/* bxt+ only */
>>   		struct pwm_device *pwm;
>> -		int pwm_period_ns;
>> +		struct pwm_state pwm_state;
>>   
>>   		/* DPCD backlight */
>>   		u8 pwmgen_bit_count;
>> diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
>> index cb28b9908ca4..a0f76343f381 100644
>> --- a/drivers/gpu/drm/i915/display/intel_panel.c
>> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
>> @@ -592,10 +592,11 @@ static u32 bxt_get_backlight(struct intel_connector *connector)
>>   static u32 pwm_get_backlight(struct intel_connector *connector)
>>   {
>>   	struct intel_panel *panel = &connector->panel;
>> -	int duty_ns;
>> +	int duty_ns, period_ns;
>>   
>>   	duty_ns = pwm_get_duty_cycle(panel->backlight.pwm);
>> -	return DIV_ROUND_UP(duty_ns * 100, panel->backlight.pwm_period_ns);
>> +	period_ns = pwm_get_period(panel->backlight.pwm);
> 
> The transformation is correct, but using
> 
> 	pwm_get_state(pwm, &state);
> 	duty_ns = state.duty_cycle;
> 	period_ns = state.period;
> 
> is a bit more effective as it calls pwm_get_state() only once.
> 
> There is a function pwm_get_relative_duty_cycle which is similar (with
> scale = 100) just used different rounding.

Ah nice, that is better then doing our own stuff.
I will switch to that for v4 of this patch-set.

>> +	return DIV_ROUND_UP(duty_ns * 100, period_ns);
>>   }
>>   
>>   static void lpt_set_backlight(const struct drm_connector_state *conn_state, u32 level)
>> @@ -669,10 +670,10 @@ static void bxt_set_backlight(const struct drm_connector_state *conn_state, u32
>>   static void pwm_set_backlight(const struct drm_connector_state *conn_state, u32 level)
>>   {
>>   	struct intel_panel *panel = &to_intel_connector(conn_state->connector)->panel;
>> -	int duty_ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
>>   
>> -	pwm_config(panel->backlight.pwm, duty_ns,
>> -		   panel->backlight.pwm_period_ns);
>> +	panel->backlight.pwm_state.duty_cycle =
>> +		DIV_ROUND_UP(level * panel->backlight.pwm_state.period, 100);
>> +	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
>>   }
>>   
>>   static void
>> @@ -841,10 +842,8 @@ static void pwm_disable_backlight(const struct drm_connector_state *old_conn_sta
>>   	struct intel_connector *connector = to_intel_connector(old_conn_state->connector);
>>   	struct intel_panel *panel = &connector->panel;
>>   
>> -	/* Disable the backlight */
>> -	intel_panel_actually_set_backlight(old_conn_state, 0);
>> -	usleep_range(2000, 3000);
>> -	pwm_disable(panel->backlight.pwm);
>> +	panel->backlight.pwm_state.enabled = false;
>> +	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
> 
> Did you drop intel_panel_actually_set_backlight and the sleep on purpose?

Yes, that was on purpose. But I should probably have
added a note about this to the commit message.

For v4 of the patchset I will add the following note about this to the
commit message for this patch:

"Note that this commit also simplifies pwm_disable_backlight(), by dropping
the intel_panel_actually_set_backlight(..., 0) call. This call sets the
PWM to 0% duty-cycle. I believe that this call was only present as a
workaround for a bug in the pwm-crc.c driver where it failed to clear the
PWM_OUTPUT_ENABLE bit. This is fixed by an earlier patch in this series.

After the dropping of this workaround, the usleep call, which seems
unnecessary to begin with, has no useful effect anymore, so drop that too."

>>   }
>>   
>>   void intel_panel_disable_backlight(const struct drm_connector_state *old_conn_state)
>> [...]
>> @@ -1916,36 +1919,30 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>>   		return -ENODEV;
>>   	}
>>   
>> -	panel->backlight.pwm_period_ns = NSEC_PER_SEC /
>> -					 get_vbt_pwm_freq(dev_priv);
>> -
>> -	/*
>> -	 * FIXME: pwm_apply_args() should be removed when switching to
>> -	 * the atomic PWM API.
>> -	 */
>> -	pwm_apply_args(panel->backlight.pwm);
>> -
>>   	panel->backlight.max = 100; /* 100% */
>>   	panel->backlight.min = get_backlight_min_vbt(connector);
>> -	level = intel_panel_compute_brightness(connector, 100);
>> -	ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
>>   
>> -	retval = pwm_config(panel->backlight.pwm, ns,
>> -			    panel->backlight.pwm_period_ns);
>> -	if (retval < 0) {
>> -		drm_err(&dev_priv->drm, "Failed to configure the pwm chip\n");
>> -		pwm_put(panel->backlight.pwm);
>> -		panel->backlight.pwm = NULL;
>> -		return retval;
>> +	if (pwm_is_enabled(panel->backlight.pwm) &&
>> +	    pwm_get_period(panel->backlight.pwm)) {
>> +		/* PWM is already enabled, use existing settings */
>> +		pwm_get_state(panel->backlight.pwm, &panel->backlight.pwm_state);
>> +
>> +		level = DIV_ROUND_UP(panel->backlight.pwm_state.duty_cycle *
>> +					100, panel->backlight.pwm_state.period);
>> +		level = intel_panel_compute_brightness(connector, level);
> 
> In pwm_enable_backlight() the order of these two steps is reversed
> compared to here. Maybe this calculation can be moved into
> intel_panel_compute_brightness()?

The intel_panel.c code deals with 7 different types of PWM controllers
which are built into the GPU + support for external PWM controllers
through the kernel's PWM subsystem.

The code this patch changes is for the external PWM controller case,
intel_panel_compute_brightness() is used for all supported PWM
controllers.

intel_panel_compute_brightness()'s function is to deal with panels
where 100% duty-cycle is backlight fully off instead of fully-on.
Normally it is called just before setting the duty-cycle, inverting
the value/range before sending it to the hardware, since here we
are reading back the current value we call it after reading back
the value from the controller as the internally cached value is
always in 0==min/off 100==max range, so if the panel inverts the
range, we need to invert the read-back value to be in our
"normalized" internal range.

What we can do here is use pwm_get_relative_duty_cycle as you
suggested above. I will change that for v4.

> 
>> +		panel->backlight.level = clamp(level, panel->backlight.min,
>> +					       panel->backlight.max);
>> +		panel->backlight.enabled = true;
>> +
> 
> Best regards
> Uwe
> 

Regards,

Hans

