Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73921C47E
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2020 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgGKNwL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Jul 2020 09:52:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbgGKNwK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Jul 2020 09:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594475528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VM5x9KFQSTgZtGGj8AsglFvy9klf+aR0vF9T8W6eBI=;
        b=KCeZ+saCnBfsGgq8Tv1/SmplfHPok9cHHxXDkxhXbIZXCspiFoCoxixO9WVrP9ZuFiRIio
        3YKkCkVSU4c5pWor2qRrNYRCQemvrnMh7YoqRkMHDguVimPpIn+KooQIDsVmphDqvA6w+S
        sxhs7dTeWQXK3vvZB7zALkMfm/v68ag=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-VrHcveOYPA2hqdC93dvDZw-1; Sat, 11 Jul 2020 09:52:06 -0400
X-MC-Unique: VrHcveOYPA2hqdC93dvDZw-1
Received: by mail-ej1-f72.google.com with SMTP id do21so10595914ejc.2
        for <linux-pwm@vger.kernel.org>; Sat, 11 Jul 2020 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3VM5x9KFQSTgZtGGj8AsglFvy9klf+aR0vF9T8W6eBI=;
        b=P8s8r6caRBpwiTj7/jSICLzt6sW9JQLWtquZ7MZXcpHgqakLOPtVvB+ZUM3pcFV+J6
         nPR54idZShRKLrn101CDNNoquz/C2xTg3KZDpwjUs4zMp5RS6uW4xusv2iC4Ar0O23VC
         ZO8yy9cCYm3HRpvh7a16xXFzwrlug000owEjCeZQc+9XWoP2LftFP/q48YKmmfZesDP/
         1myVky6niV8QYV+A4EuwkSstikOBeuvMxHmtYSx8xluhY07lwcCUTRcu3DLE/UqgJpI5
         YISeOf7nuu8YVJJPl+2Z3D8NibPF1B0NPZnh1xchKb0yPgLqr4dgGtRn+9ukSjIPwvpB
         sXHQ==
X-Gm-Message-State: AOAM531MMPepm6x8GyM9+8p+Xe5mB2/G7nbA22SUwho0wAnI0yoapxC+
        nQCgBQY/nPkAbf7dh4QDDhB11Q1zSJf/P4ptKQ831FfkgciIePcRiCi4tWV1LWl8zNy0iGfyrOf
        qRMqy7bClbo1dWKv2CIQi
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr62382532edr.383.1594475519116;
        Sat, 11 Jul 2020 06:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHQOteQJHm7x9NTl3vAhuNXd8O6zdA6ws/dNJAvLTs3sZZWACd+VQRxrDZ40zmgI8MPBVppw==
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr62382507edr.383.1594475518772;
        Sat, 11 Jul 2020 06:51:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id ce19sm5622572ejb.24.2020.07.11.06.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 06:51:58 -0700 (PDT)
Subject: Re: [PATCH v4 16/16] drm/i915: panel: Use atomic PWM API for devs
 with an external PWM controller
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-17-hdegoede@redhat.com>
 <20200711063223.czly2ftjraomuxz6@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0fdcf465-3981-390f-7af4-235c7a48e438@redhat.com>
Date:   Sat, 11 Jul 2020 15:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200711063223.czly2ftjraomuxz6@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/11/20 8:32 AM, Uwe Kleine-König wrote:
> On Wed, Jul 08, 2020 at 11:14:32PM +0200, Hans de Goede wrote:
>> Now that the PWM drivers which we use have been converted to the atomic
>> PWM API, we can move the i915 panel code over to using the atomic PWM API.
>>
>> The removes a long standing FIXME and this removes a flicker where
>> the backlight brightness would jump to 100% when i915 loads even if
>> using the fastset path.
>>
>> Note that this commit also simplifies pwm_disable_backlight(), by dropping
>> the intel_panel_actually_set_backlight(..., 0) call. This call sets the
>> PWM to 0% duty-cycle. I believe that this call was only present as a
>> workaround for a bug in the pwm-crc.c driver where it failed to clear the
>> PWM_OUTPUT_ENABLE bit. This is fixed by an earlier patch in this series.
>>
>> After the dropping of this workaround, the usleep call, which seems
>> unnecessary to begin with, has no useful effect anymore, so drop that too.
>>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v4:
>> - Add a note to the commit message about the dropping of the
>>    intel_panel_actually_set_backlight() and usleep() calls from
>>    pwm_disable_backlight()
>> - Use the pwm_set/get_relative_duty_cycle() helpers instead of using DIY code
>>    for this
>> ---
>>   .../drm/i915/display/intel_display_types.h    |  3 +-
>>   drivers/gpu/drm/i915/display/intel_panel.c    | 71 +++++++++----------
>>   2 files changed, 34 insertions(+), 40 deletions(-)
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
>> index cb28b9908ca4..3d97267c8238 100644
>> --- a/drivers/gpu/drm/i915/display/intel_panel.c
>> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
>> @@ -592,10 +592,10 @@ static u32 bxt_get_backlight(struct intel_connector *connector)
>>   static u32 pwm_get_backlight(struct intel_connector *connector)
>>   {
>>   	struct intel_panel *panel = &connector->panel;
>> -	int duty_ns;
>> +	struct pwm_state state;
>>   
>> -	duty_ns = pwm_get_duty_cycle(panel->backlight.pwm);
>> -	return DIV_ROUND_UP(duty_ns * 100, panel->backlight.pwm_period_ns);
>> +	pwm_get_state(panel->backlight.pwm, &state);
>> +	return pwm_get_relative_duty_cycle(&state, 100);
> 
> Here you introduce a slight difference: pwm_get_relative_duty_cycle uses
> round-closest while you replace a round-up. Is this relevant?

Yes I'm aware of the change in rounding and I do not believe that it is
relevant. One of the advantages of switching to the helpers is not having
to worry about the rounding and letting the helpers figure that out :)

>>   }
>>   
>>   static void lpt_set_backlight(const struct drm_connector_state *conn_state, u32 level)
>> @@ -669,10 +669,9 @@ static void bxt_set_backlight(const struct drm_connector_state *conn_state, u32
>>   static void pwm_set_backlight(const struct drm_connector_state *conn_state, u32 level)
>>   {
>>   	struct intel_panel *panel = &to_intel_connector(conn_state->connector)->panel;
>> -	int duty_ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
>>   
>> -	pwm_config(panel->backlight.pwm, duty_ns,
>> -		   panel->backlight.pwm_period_ns);
>> +	pwm_set_relative_duty_cycle(&panel->backlight.pwm_state, level, 100);
>> +	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
> 
> Similar here: The function used to use round-up but
> pwm_set_relative_duty_cycle() used round-closest.

Idem.


>>   }
>>   
>>   static void
>> @@ -841,10 +840,8 @@ static void pwm_disable_backlight(const struct drm_connector_state *old_conn_sta
>>   	struct intel_connector *connector = to_intel_connector(old_conn_state->connector);
>>   	struct intel_panel *panel = &connector->panel;
>>   
>> -	/* Disable the backlight */
>> -	intel_panel_actually_set_backlight(old_conn_state, 0);
>> -	usleep_range(2000, 3000);
>> -	pwm_disable(panel->backlight.pwm);
>> +	panel->backlight.pwm_state.enabled = false;
>> +	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
>>   }
>>   
>>   void intel_panel_disable_backlight(const struct drm_connector_state *old_conn_state)
>> @@ -1176,9 +1173,12 @@ static void pwm_enable_backlight(const struct intel_crtc_state *crtc_state,
>>   {
>>   	struct intel_connector *connector = to_intel_connector(conn_state->connector);
>>   	struct intel_panel *panel = &connector->panel;
>> +	int level = panel->backlight.level;
>>   
>> -	pwm_enable(panel->backlight.pwm);
>> -	intel_panel_actually_set_backlight(conn_state, panel->backlight.level);
>> +	level = intel_panel_compute_brightness(connector, level);
>> +	pwm_set_relative_duty_cycle(&panel->backlight.pwm_state, level, 100);
>> +	panel->backlight.pwm_state.enabled = true;
>> +	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
>>   }
>>   
>>   static void __intel_panel_enable_backlight(const struct intel_crtc_state *crtc_state,
>> @@ -1897,8 +1897,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
>>   	struct drm_i915_private *dev_priv = to_i915(dev);
>>   	struct intel_panel *panel = &connector->panel;
>>   	const char *desc;
>> -	u32 level, ns;
>> -	int retval;
>> +	u32 level;
>>   
>>   	/* Get the right PWM chip for DSI backlight according to VBT */
>>   	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
>> @@ -1916,36 +1915,30 @@ static int pwm_setup_backlight(struct intel_connector *connector,
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
> 
> What would pwm_is_enabled(panel->backlight.pwm) == true &&
> pwm_get_period(panel->backlight.pwm) == 0 mean? I hope this doesn't
> happen?!

It shouldn't happen this code uses only 2 PWM controller drivers,
pwm-crc and pwm-lpss and the get_state of neither ever sets
period tto 0. This check is just here for extra safety, since getting it
wrong would lead to a divide by 0. Which I see has been fixed by the
helper now (which does its own period==0 check). So I guess I can
(and I will) just drop this extra check for the next version.

>> +		/* PWM is already enabled, use existing settings */
>> +		pwm_get_state(panel->backlight.pwm, &panel->backlight.pwm_state);
>> +
>> +		level = pwm_get_relative_duty_cycle(&panel->backlight.pwm_state,
>> +						    100);
>> +		level = intel_panel_compute_brightness(connector, level);
>> +		panel->backlight.level = clamp(level, panel->backlight.min,
>> +					       panel->backlight.max);
>> +		panel->backlight.enabled = true;
>> +
>> +		drm_dbg_kms(&dev_priv->drm, "PWM already enabled at freq %ld, VBT freq %d, level %d\n",
>> +			    NSEC_PER_SEC / panel->backlight.pwm_state.period,
> 
> .period becomes a u64 soon, so be prepared to fixup here.
> 
>> +			    get_vbt_pwm_freq(dev_priv), level);
>> +	} else {
>> +		/* Set period from VBT frequency, leave other settings at 0. */
>> +		panel->backlight.pwm_state.period =
>> +			NSEC_PER_SEC / get_vbt_pwm_freq(dev_priv);
>>   	}
>>   
>> -	level = DIV_ROUND_UP(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
>> -			     panel->backlight.pwm_period_ns);
>> -	level = intel_panel_compute_brightness(connector, level);
>> -	panel->backlight.level = clamp(level, panel->backlight.min,
>> -				       panel->backlight.max);
>> -	panel->backlight.enabled = panel->backlight.level != 0;
>> -
>>   	drm_info(&dev_priv->drm, "Using %s PWM for LCD backlight control\n",
>>   		 desc);
>>   	return 0;
> 
> Best regards
> Uwe



Regards,

Hans

