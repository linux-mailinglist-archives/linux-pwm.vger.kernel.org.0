Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E512F1D7F71
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgERQ7z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERQ7y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:59:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2661BC05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:59:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so221606wmb.4
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hEjGI1/oMuYkFLZLVjZZ8KYl7hNgNzy4DZ5GkRwZr74=;
        b=SBRGAenlIl5yNjQQOhWyyDkL0+yfXd40SNdMBtGBKlUG2KGGCdJwMbdVwSZP3ckDq6
         oxVWTYWxj4WWzD5mtVsJpuDdhETZrHzpwe270cNxrFQsI87psVq9nfSENCgIPTkeziWT
         hJMsYIH0c19gjZQXlzzh6+SwqysE4xp0MpvO7JAbBq/t4R1LsLjDTEG41HcgvU9lpCiT
         Wu+FOeAeBwvIrVil5UwUtIfi2OWHyywoBJIls13w9LXlcxEJe7rVw0MfeQUbBRK3p00J
         5It9hB2TQFiAqkO/z1vQhPcGKsYtSLjnbbyplkL/8htvM/NgL5yTK7kMsmg2s1yBRuSG
         VrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hEjGI1/oMuYkFLZLVjZZ8KYl7hNgNzy4DZ5GkRwZr74=;
        b=I6Jk1KxK9GicSphNQ5u7nJ6FwLzoLzZzw+K1DGyYGMCD2rLYNS1XNoWHm+xGvtPtQT
         ICPk9Ljg9+kseYfRiPeESSN72zVCMT6306uDU1pdUApVGuveJsDwkkHcMN+bYUNXGNeS
         2ZOwpIp5Qn3blx65G9BhBGwHgUqbJMT+tNf7DcZ4KfFiumHQeT8Zmv70qN/7xw2N00Se
         dnj3DgmmaSnClLXYfBmFHLK5hkhPqjjO0BPaHyY3c1ZzwcNlwzjA6JNdlK60AWxxv1og
         vHAMfFIPu2jJetTbkmK7hQOyyYJTi6C9qHC4go26uSEu8lpTh9UurhsWPWC15LooH+/G
         ciwg==
X-Gm-Message-State: AOAM533RyIwVkaQa0uK8DVavRoUDVjGH92DkEfror4tnjIx2GSV/I6IG
        Mezr2OOESmWL+F2+wqben4bvIQ==
X-Google-Smtp-Source: ABdhPJySEnUHV9FY/4ORVCs+rN/GnR3qzd8edZYEOk7ENbaWdo8EgP+AIDWCkE9GaZZfiS8ry6I3IQ==
X-Received: by 2002:a05:600c:1403:: with SMTP id g3mr319158wmi.51.1589821192739;
        Mon, 18 May 2020 09:59:52 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p7sm204743wmc.24.2020.05.18.09.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:59:52 -0700 (PDT)
Date:   Mon, 18 May 2020 17:59:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
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
        Jani Nikula <jani.nikula@intel.com>,
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
Subject: Re: [PATCH v2 16/16] backlight: use backlight_is_blank() in all
 backlight drivers
Message-ID: <20200518165950.lrua4iswhpx655zi@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-17-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200517190139.740249-17-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:39PM +0200, Sam Ravnborg wrote:
> Replaces the open-coded checks of the state etc.,
> with the backlight_is_blank() helper.
> This increases readability of the code and align
> the functionality across the drivers.
> 
> v2:
>   - Fixed so changelog is readable
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: patches@opensource.cirrus.com

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/88pm860x_bl.c    |  8 +-------
>  drivers/video/backlight/adp5520_bl.c     |  5 +----
>  drivers/video/backlight/adp8860_bl.c     |  5 +----
>  drivers/video/backlight/adp8870_bl.c     |  5 +----
>  drivers/video/backlight/as3711_bl.c      |  8 +++-----
>  drivers/video/backlight/bd6107.c         |  4 +---
>  drivers/video/backlight/corgi_lcd.c      |  5 +----
>  drivers/video/backlight/cr_bllcd.c       | 22 +++++++---------------
>  drivers/video/backlight/da903x_bl.c      |  8 +-------
>  drivers/video/backlight/ep93xx_bl.c      |  3 +--
>  drivers/video/backlight/gpio_backlight.c |  4 +---
>  drivers/video/backlight/hp680_bl.c       |  4 +---
>  drivers/video/backlight/jornada720_bl.c  |  2 +-
>  drivers/video/backlight/kb3886_bl.c      |  4 +---
>  drivers/video/backlight/led_bl.c         |  4 +---
>  drivers/video/backlight/lm3533_bl.c      |  4 +---
>  drivers/video/backlight/locomolcd.c      |  4 +---
>  drivers/video/backlight/lv5207lp.c       |  4 +---
>  drivers/video/backlight/max8925_bl.c     |  8 +-------
>  drivers/video/backlight/pwm_bl.c         |  4 +---
>  drivers/video/backlight/qcom-wled.c      |  4 +---
>  drivers/video/backlight/tps65217_bl.c    |  4 +---
>  drivers/video/backlight/wm831x_bl.c      |  8 +-------
>  23 files changed, 31 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
> index 20d96a5ac384..162c83ab0f5a 100644
> --- a/drivers/video/backlight/88pm860x_bl.c
> +++ b/drivers/video/backlight/88pm860x_bl.c
> @@ -123,13 +123,7 @@ static int pm860x_backlight_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.state & BL_CORE_SUSPENDED)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return pm860x_backlight_set(bl, brightness);
> diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
> index 0f63f76723a5..d817b0d95c9d 100644
> --- a/drivers/video/backlight/adp5520_bl.c
> +++ b/drivers/video/backlight/adp5520_bl.c
> @@ -67,10 +67,7 @@ static int adp5520_bl_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return adp5520_bl_set(bl, brightness);
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 19968104fc47..a0ce2a3701fa 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -363,10 +363,7 @@ static int adp8860_bl_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return adp8860_bl_set(bl, brightness);
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 4c0032010cfe..ae4269fdb189 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -401,10 +401,7 @@ static int adp8870_bl_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return adp8870_bl_set(bl, brightness);
> diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
> index 33f0f0f2e8b3..7fa76008c7bf 100644
> --- a/drivers/video/backlight/as3711_bl.c
> +++ b/drivers/video/backlight/as3711_bl.c
> @@ -107,13 +107,11 @@ static int as3711_bl_update_status(struct backlight_device *bl)
>  	int brightness = bl->props.brightness;
>  	int ret = 0;
>  
> -	dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
> +	dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, state %x\n",
>  		__func__, bl->props.brightness, bl->props.power,
> -		bl->props.fb_blank, bl->props.state);
> +		bl->props.state);
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	if (data->type == AS3711_BL_SU1) {
> diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
> index d5d5fb457e78..f6a5c1dba3bc 100644
> --- a/drivers/video/backlight/bd6107.c
> +++ b/drivers/video/backlight/bd6107.c
> @@ -84,9 +84,7 @@ static int bd6107_backlight_update_status(struct backlight_device *backlight)
>  	struct bd6107 *bd = bl_get_data(backlight);
>  	int brightness = backlight->props.brightness;
>  
> -	if (backlight->props.power != FB_BLANK_UNBLANK ||
> -	    backlight->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    backlight->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +	if (backlight_is_blank(backlight))
>  		brightness = 0;
>  
>  	if (brightness) {
> diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
> index 25ef0cbd7583..c9adf4e26355 100644
> --- a/drivers/video/backlight/corgi_lcd.c
> +++ b/drivers/video/backlight/corgi_lcd.c
> @@ -422,10 +422,7 @@ static int corgi_bl_update_status(struct backlight_device *bd)
>  	struct corgi_lcd *lcd = bl_get_data(bd);
>  	int intensity = bd->props.brightness;
>  
> -	if (bd->props.power != FB_BLANK_UNBLANK)
> -		intensity = 0;
> -
> -	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bd))
>  		intensity = 0;
>  
>  	if (corgibl_flags & CORGIBL_SUSPENDED)
> diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
> index 4624b7b7c6a6..d5ab7675f55c 100644
> --- a/drivers/video/backlight/cr_bllcd.c
> +++ b/drivers/video/backlight/cr_bllcd.c
> @@ -59,26 +59,18 @@ struct cr_panel {
>  
>  static int cr_backlight_set_intensity(struct backlight_device *bd)
>  {
> -	int intensity = bd->props.brightness;
>  	u32 addr = gpio_bar + CRVML_PANEL_PORT;
>  	u32 cur = inl(addr);
>  
> -	if (bd->props.power == FB_BLANK_UNBLANK)
> -		intensity = FB_BLANK_UNBLANK;
> -	if (bd->props.fb_blank == FB_BLANK_UNBLANK)
> -		intensity = FB_BLANK_UNBLANK;
> -	if (bd->props.power == FB_BLANK_POWERDOWN)
> -		intensity = FB_BLANK_POWERDOWN;
> -	if (bd->props.fb_blank == FB_BLANK_POWERDOWN)
> -		intensity = FB_BLANK_POWERDOWN;
> -
> -	if (intensity == FB_BLANK_UNBLANK) { /* FULL ON */
> -		cur &= ~CRVML_BACKLIGHT_OFF;
> -		outl(cur, addr);
> -	} else if (intensity == FB_BLANK_POWERDOWN) { /* OFF */
> +	if (backlight_is_blank(bd)) {
> +		/* OFF */
>  		cur |= CRVML_BACKLIGHT_OFF;
>  		outl(cur, addr);
> -	} /* anything else, don't bother */
> +	} else {
> +		/* FULL ON */
> +		cur &= ~CRVML_BACKLIGHT_OFF;
> +		outl(cur, addr);
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/video/backlight/da903x_bl.c b/drivers/video/backlight/da903x_bl.c
> index 62540e4bdedb..ca351badfdcf 100644
> --- a/drivers/video/backlight/da903x_bl.c
> +++ b/drivers/video/backlight/da903x_bl.c
> @@ -79,13 +79,7 @@ static int da903x_backlight_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.state & BL_CORE_SUSPENDED)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return da903x_backlight_set(bl, brightness);
> diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
> index 4149e0b2f83c..491185df1411 100644
> --- a/drivers/video/backlight/ep93xx_bl.c
> +++ b/drivers/video/backlight/ep93xx_bl.c
> @@ -38,8 +38,7 @@ static int ep93xxbl_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return ep93xxbl_set(bl, brightness);
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 75409ddfba3e..94b65e4d2aa0 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -25,9 +25,7 @@ static int gpio_backlight_get_next_brightness(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return brightness;
> diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
> index 8ea42b8d9bc8..01d805ca8415 100644
> --- a/drivers/video/backlight/hp680_bl.c
> +++ b/drivers/video/backlight/hp680_bl.c
> @@ -35,9 +35,7 @@ static void hp680bl_send_intensity(struct backlight_device *bd)
>  	u16 v;
>  	int intensity = bd->props.brightness;
>  
> -	if (bd->props.power != FB_BLANK_UNBLANK)
> -		intensity = 0;
> -	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bd))
>  		intensity = 0;
>  	if (hp680bl_suspended)
>  		intensity = 0;
> diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
> index f0385f9cf9da..996f7ba3b373 100644
> --- a/drivers/video/backlight/jornada720_bl.c
> +++ b/drivers/video/backlight/jornada720_bl.c
> @@ -54,7 +54,7 @@ static int jornada_bl_update_status(struct backlight_device *bd)
>  	jornada_ssp_start();
>  
>  	/* If backlight is off then really turn it off */
> -	if ((bd->props.power != FB_BLANK_UNBLANK) || (bd->props.fb_blank != FB_BLANK_UNBLANK)) {
> +	if (backlight_is_blank(bd)) {
>  		ret = jornada_ssp_byte(BRIGHTNESSOFF);
>  		if (ret != TXDUMMY) {
>  			dev_info(&bd->dev, "brightness off timeout\n");
> diff --git a/drivers/video/backlight/kb3886_bl.c b/drivers/video/backlight/kb3886_bl.c
> index 1dfe13c18925..a0fd5d3d82f5 100644
> --- a/drivers/video/backlight/kb3886_bl.c
> +++ b/drivers/video/backlight/kb3886_bl.c
> @@ -89,9 +89,7 @@ static int kb3886bl_send_intensity(struct backlight_device *bd)
>  {
>  	int intensity = bd->props.brightness;
>  
> -	if (bd->props.power != FB_BLANK_UNBLANK)
> -		intensity = 0;
> -	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bd))
>  		intensity = 0;
>  	if (kb3886bl_flags & KB3886BL_SUSPENDED)
>  		intensity = 0;
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index 3f66549997c8..c655ddd99cfb 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -56,9 +56,7 @@ static int led_bl_update_status(struct backlight_device *bl)
>  	struct led_bl_data *priv = bl_get_data(bl);
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & BL_CORE_FBBLANK)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	if (brightness > 0)
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index ee09d1bd02b9..476146b62c4e 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -41,9 +41,7 @@ static int lm3533_bl_update_status(struct backlight_device *bd)
>  	struct lm3533_bl *bl = bl_get_data(bd);
>  	int brightness = bd->props.brightness;
>  
> -	if (bd->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bd))
>  		brightness = 0;
>  
>  	return lm3533_ctrlbank_set_brightness(&bl->cb, (u8)brightness);
> diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
> index cdc02e04f89d..8064cad8d683 100644
> --- a/drivers/video/backlight/locomolcd.c
> +++ b/drivers/video/backlight/locomolcd.c
> @@ -113,9 +113,7 @@ static int locomolcd_set_intensity(struct backlight_device *bd)
>  {
>  	int intensity = bd->props.brightness;
>  
> -	if (bd->props.power != FB_BLANK_UNBLANK)
> -		intensity = 0;
> -	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> +	if (backlight_is_blank(bd))
>  		intensity = 0;
>  	if (locomolcd_flags & LOCOMOLCD_SUSPENDED)
>  		intensity = 0;
> diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
> index c6ad73a784e2..ef8aa9803577 100644
> --- a/drivers/video/backlight/lv5207lp.c
> +++ b/drivers/video/backlight/lv5207lp.c
> @@ -48,9 +48,7 @@ static int lv5207lp_backlight_update_status(struct backlight_device *backlight)
>  	struct lv5207lp *lv = bl_get_data(backlight);
>  	int brightness = backlight->props.brightness;
>  
> -	if (backlight->props.power != FB_BLANK_UNBLANK ||
> -	    backlight->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    backlight->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +	if (backlight_is_blank(backlight))
>  		brightness = 0;
>  
>  	if (brightness) {
> diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
> index 97cc260ff9d1..b8af2c6407d3 100644
> --- a/drivers/video/backlight/max8925_bl.c
> +++ b/drivers/video/backlight/max8925_bl.c
> @@ -66,13 +66,7 @@ static int max8925_backlight_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.state & BL_CORE_SUSPENDED)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return max8925_backlight_set(bl, brightness);
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 82b8d7594701..7d0ffcd37f07 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -111,9 +111,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  	int brightness = bl->props.brightness;
>  	struct pwm_state state;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & BL_CORE_FBBLANK)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	if (pb->notify)
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 3d276b30a78c..9600f5d58ece 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -261,9 +261,7 @@ static int wled_update_status(struct backlight_device *bl)
>  	u16 brightness = bl->props.brightness;
>  	int rc = 0;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & BL_CORE_FBBLANK)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	mutex_lock(&wled->lock);
> diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
> index 762e3feed097..1041e5e62ee3 100644
> --- a/drivers/video/backlight/tps65217_bl.c
> +++ b/drivers/video/backlight/tps65217_bl.c
> @@ -82,9 +82,7 @@ static int tps65217_bl_update_status(struct backlight_device *bl)
>  	if (bl->props.state & BL_CORE_SUSPENDED)
>  		brightness = 0;
>  
> -	if ((bl->props.power != FB_BLANK_UNBLANK) ||
> -		(bl->props.fb_blank != FB_BLANK_UNBLANK))
> -		/* framebuffer in low power mode or blanking active */
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	if (brightness > 0) {
> diff --git a/drivers/video/backlight/wm831x_bl.c b/drivers/video/backlight/wm831x_bl.c
> index e55977d54c15..dc2ab6c8b7f9 100644
> --- a/drivers/video/backlight/wm831x_bl.c
> +++ b/drivers/video/backlight/wm831x_bl.c
> @@ -93,13 +93,7 @@ static int wm831x_backlight_update_status(struct backlight_device *bl)
>  {
>  	int brightness = bl->props.brightness;
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> -		brightness = 0;
> -
> -	if (bl->props.state & BL_CORE_SUSPENDED)
> +	if (backlight_is_blank(bl))
>  		brightness = 0;
>  
>  	return wm831x_backlight_set(bl, brightness);
> -- 
> 2.25.1
> 
