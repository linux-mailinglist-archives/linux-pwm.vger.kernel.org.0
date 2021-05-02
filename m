Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39806370F44
	for <lists+linux-pwm@lfdr.de>; Sun,  2 May 2021 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhEBVQi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 May 2021 17:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhEBVQh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 May 2021 17:16:37 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EFC061756
        for <linux-pwm@vger.kernel.org>; Sun,  2 May 2021 14:15:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id d21so1600284oic.11
        for <linux-pwm@vger.kernel.org>; Sun, 02 May 2021 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y8HQ+dXr/9DI00Tczt+t4bbUXXiIp9vh0T4ZqfMbYF4=;
        b=qHd1m3qVp0GUXMefU/3LfcUVW3nC72mDUkQ3yRuTXmW+A9qrjV1XNKzdjgDRiybu99
         +qYS1qm4Tk9U8czDKJjPbvysWv7TVQHOnGXqrQW28Y9SNbMzx9xxE7QL+fZdmqvshzLw
         U185l6YtZurVPCCXQf2I6V0GU3xmvrgG+o7KYWkjVM+Z2v+s9nsWXkacOXsacWp5L4mw
         FX1+CxCG4+vyrT77MN56FZZIe/mZO/6gumrUD2XF1Cx4BBODFl+oSFq4AYxY5+Ymmqw0
         S+0K1srlon8f8QcUl1zSBv1CyOPLFGjhkUmfg5KAGnbC8oGINgNgQ2oQ/FbruBxNqMdV
         LWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y8HQ+dXr/9DI00Tczt+t4bbUXXiIp9vh0T4ZqfMbYF4=;
        b=D/vGOYCf+Du98amYpRoxoNgJKCCF7HqcbRA7ea0EbejSY2PJLWyKxL9mrb3IlibUS/
         Q9onMp/ywdwwYQzEP3t0EGWm6+RNbZjLXnkHuTwrWiM/fcFIiIZe2x4oLAa5sDgMcBCz
         rOO8FhYgdhiQdsLo+FoGjTKQgJPt785YT978/TrRzSg+GDnPTzPnd3IR079c6n3mPUYq
         d6NN0C1N14DhnNvLZxv2QcfD1JNDSiBJ4g4WUnVEITrJDpCfObYJ6C5w4Knxm85cu1dq
         Y0AVkB3+OSCCWAxTk58dZ/fEJhbUt97tPcWJXS10s3AqNQIi3M6NS4jZ/I9h41YI96ub
         /G9A==
X-Gm-Message-State: AOAM533FtKrMTHqW6Y6eHFQZatd3qllrPTtZzMo08QPuERGr9iG8gZy9
        g9XvAMvS2K92XAUPTiNusLwYZw==
X-Google-Smtp-Source: ABdhPJwPvB9uFbYuLo9g265jJQ86mmJEHSmsQ9Fsq9sFGvyj+mj9dstBybFqwUdnsX6GUSpKg75Q7A==
X-Received: by 2002:a54:470c:: with SMTP id k12mr10143103oik.42.1619990145255;
        Sun, 02 May 2021 14:15:45 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o6sm2488747ote.14.2021.05.02.14.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 14:15:44 -0700 (PDT)
Date:   Sun, 2 May 2021 16:15:42 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v7 2/6] leds: Add driver for Qualcomm LPG
Message-ID: <20210502211542.GE2484@yoga>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
 <20210429211517.312792-3-bjorn.andersson@linaro.org>
 <55b56fd9-0ba5-58d9-2be8-98aa639e4496@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b56fd9-0ba5-58d9-2be8-98aa639e4496@somainline.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat 01 May 16:09 CDT 2021, Marijn Suijten wrote:

> Hi Bjorn,
> 
> On 4/29/21 11:15 PM, Bjorn Andersson wrote:
> > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > PMICs from Qualcomm. It can operate on fixed parameters or based on a
> > lookup-table, altering the duty cycle over time - which provides the
> > means for e.g. hardware assisted transitions of LED brightness.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v6:
> > - Moved code into drivers/leds/rgb/
> > - Reverted to earlier qcom,dtest handling to support routing pwm signals
> >    through dtest lines.
> > - Remember the duration of each step of the pattern, rather than adding up and
> >    then dividing when the value is used.
> > - Added missing error prints on DT parse errors.
> > - Added sm8150[lb] and made led source and atc presence optional
> > - Added missing parenthesis around (len + 1) / 2 in search for hi_pause in the
> >    pattern.
> > 
> >   drivers/leds/Kconfig             |    3 +
> >   drivers/leds/Makefile            |    3 +
> >   drivers/leds/rgb/leds-qcom-lpg.c | 1286 ++++++++++++++++++++++++++++++
> >   3 files changed, 1292 insertions(+)
> >   create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c
> > 
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index 49d99cb084db..8ab06b3f162d 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -933,6 +933,9 @@ source "drivers/leds/blink/Kconfig"
> >   comment "Flash and Torch LED drivers"
> >   source "drivers/leds/flash/Kconfig"
> > +comment "RGB LED drivers"
> > +source "drivers/leds/rgb/Kconfig"
> 
> 
> It looks like this file is not included in any of the patches.
> 

Sorry about that, seems like I missed adding them to the commit :(

> > +
> >   comment "LED Triggers"
> >   source "drivers/leds/trigger/Kconfig"
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index 7e604d3028c8..8cad0465aae0 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -106,6 +106,9 @@ obj-$(CONFIG_LEDS_USER)			+= uleds.o
> >   # Flash and Torch LED Drivers
> >   obj-$(CONFIG_LEDS_CLASS_FLASH)		+= flash/
> > +# RGB LED Drivers
> > +obj-$(CONFIG_LEDS_CLASS_MULTICOLOR)	+= rgb/
> 
> 
> This file appears to be missing from this patch(set), too.
> 

Right, missed both the new files.

> > +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> > +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> > +{
> > +	unsigned int idx;
> > +	u16 val;
> > +	int i;
> > +
> > +	/* Hardware does not behave when LO_IDX == HI_IDX */
> > +	if (len == 1)
> > +		return -EINVAL;
> > +
> > +	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> > +					 0, len, 0);
> > +	if (idx >= lpg->lut_size)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < len; i++) {
> > +		val = pattern[i].brightness;
> > +
> > +		regmap_bulk_write(lpg->map, lpg->lut_base + LPG_LUT_REG(idx + i), &val, 1);
> 
> 
> This and the other regmap_bulk_write in lpg_apply_pwm_value used sizeof(val)
> before.  As far as I'm aware qcom-spmi-pmic specifies 16-bit addresses
> (.reg_bits) but 8-bit register sizes (.val_bits).  Writing one register
> means only 8 out of 16 bits in u16 val are written?
> 

You're right and I should have used test pattern that shown that I lost
that 9th bit...

I'll restore the sizeof()

> > +static void lpg_apply_lut_control(struct lpg_channel *chan)
> > +{
> > +	struct lpg *lpg = chan->lpg;
> > +	unsigned int hi_pause;
> > +	unsigned int lo_pause;
> > +	unsigned int step;
> > +	unsigned int conf = 0;
> > +	unsigned int lo_idx = chan->pattern_lo_idx;
> > +	unsigned int hi_idx = chan->pattern_hi_idx;
> > +	int pattern_len;
> > +
> > +	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
> > +		return;
> > +
> > +	pattern_len = hi_idx - lo_idx + 1 > +
> > +	step = chan->ramp_tick_ms;
> 
> 
> Since this is not dividing a full pattern duration by pattern_len anymore,
> that variable is now never read and best removed.
> 

Ok

> > +static int lpg_parse_channel(struct lpg *lpg, struct device_node *np,
> > +			     struct lpg_channel **channel)
> > +{
> > +	struct lpg_channel *chan;
> > +	u32 color = LED_COLOR_ID_GREEN;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = of_property_read_u32(np, "reg", &reg);
> > +	if (ret || !reg || reg > lpg->num_channels) {
> > +		dev_err(lpg->dev, "invalid reg of %pOFn\n", np);
> 
> 
> Like \"color\" below, escape reg with \"reg\"?
> 

Sounds good.

> > +static int lpg_add_led(struct lpg *lpg, struct device_node *np)
> > +{
> > +	struct led_classdev *cdev;
> > +	struct device_node *child;
> > +	struct mc_subled *info;
> > +	struct lpg_led *led;
> > +	const char *state;
> > +	int num_channels;
> > +	u32 color = 0;
> > +	int ret;
> > +	int i;
> > +
> > +	ret = of_property_read_u32(np, "color", &color);
> > +	if (ret < 0 && ret != -EINVAL) {
> > +		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
> > +		return ret;
> > +	}
> > +
> > +	if (color == LED_COLOR_ID_MULTI)
> 
> 
> Since this driver now lives under rgb/, and is specifically for RGB leds
> (afaik), should this and the rest of the code use LED_COLOR_ID_RGB instead?
> There was a patch floating around on (if I remember correctly) ##linux-msm
> by Luca Weiss that performs the conversion, with some related changes.
> 

I thought MULTICOLOR was the right color, but reading the comment on the
defines it seems RGB is the color I actually want. Will check out
z3ntu's changes as well.

> > +static int lpg_init_lut(struct lpg *lpg)
> > +{
> > +	const struct lpg_data *data = lpg->data;
> > +	size_t bitmap_size;
> > +
> > +	if (!data->lut_base)
> > +		return 0;
> > +
> > +	lpg->lut_base = data->lut_base;
> > +	lpg->lut_size = data->lut_size;
> > +
> > +	bitmap_size = BITS_TO_BYTES(lpg->lut_size);
> > +	lpg->lut_bitmap = devm_kzalloc(lpg->dev, bitmap_size, GFP_KERNEL);
> > +	if (!lpg->lut_bitmap)
> > +		return -ENOMEM;
> > +
> > +	bitmap_clear(lpg->lut_bitmap, 0, lpg->lut_size);
> 
> 
> devm_kzalloc already zeroes the bitmap.  Is it necessary to clear it again
> (assuming a "cleared" bitmap is implementation-dependent and does not imply
> zeroed memory) or could the memory be allocated with devm_kalloc instead?
> 

You're right, I can drop the explicit clear of the bitmap.

Thanks,
Bjorn
