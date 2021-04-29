Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEF36E265
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 02:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhD2AM5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 20:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhD2AM4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 20:12:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA0C06138B
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 17:12:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t24so7418328oic.10
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 17:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SBQkZZ+AM0rdRiolN8pMUJvJaHdqRcP6uvGtBB7hbVU=;
        b=ZoTQshL6LSUn3Lj4/ZAJK9Rw3XfU8aTAMNv0jvQ6LotAVOdLClfvB+3CeSpCEioye0
         Xtopma3PqjaDfDfsQayOuP4TbqJWt9iSo+X07bTjJZrtqsrpD62HHGpNjKK8gv1NaNtS
         j+jH6knXMDHPhdU/nGtL0OIOSn/aAekpdbSYjfJzWoxRqf7OTjh4v4eEpfubQ2W/pv6d
         Z+RgHfkEWL9+um/+yz3n1MeBS04aaAlWZ1J852+CB8wQARNwCvxGxntYdB7vjtAt8hzm
         umKD+6zJY4V0bBk45x5b0yvwel00U0JtsWLN76hqI9/nZIU2JQov5EqcHbyL4pPBuLAT
         GL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SBQkZZ+AM0rdRiolN8pMUJvJaHdqRcP6uvGtBB7hbVU=;
        b=kiS8AuM62TfdVpHQdfnOzaONITQ5JBVDWyswHt/Y37IL+jJcn8LwvRp2Xk4MFzcovU
         KjRfoqEIzwjAmyOlj6hpQ3bXG5n39b1cnQ6AfPjF0+u0tJjvWAi+DWHGOuF7EPT64kUn
         MXT6sm/To9YiEug865ujspzizxghGN5uE1Z7FTBnUHFb4hrL1EvmtedYWbaindS8fXV3
         O0DitUzbop+svhVyCH3fuKXIcFgpoOehxrP7RG5WoPi82REYt5pMQf9jZZjel4hX0GKJ
         LB9Vn4YRosaH72Gj8cAvpM321qJte8JdMsLBbl2a38Za0E+RvqeKxTlQPjUeHyROjRee
         EhqA==
X-Gm-Message-State: AOAM533ftPPoaSaltDF721e9bYzmEGI4Nh2dsom2OqqxOHviaeTxFV37
        9hRnlhnXBXm14UaTJfRP1SgA7Q==
X-Google-Smtp-Source: ABdhPJxVHBqD0ADdSUFDRMR3ZR31HODm2e3SR+lV5ybAgqah5lCuPwSWrEvzbrK39xY68/DgooIHzA==
X-Received: by 2002:aca:5845:: with SMTP id m66mr5007370oib.0.1619655123470;
        Wed, 28 Apr 2021 17:12:03 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r63sm305743oia.43.2021.04.28.17.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:12:03 -0700 (PDT)
Date:   Wed, 28 Apr 2021 19:12:00 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <YIn50NW+Pimqfsih@builder.lan>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <20201029181357.GE26053@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029181357.GE26053@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu 29 Oct 13:13 CDT 2020, Pavel Machek wrote:

> Hi!
> 
> > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > PMICs from Qualcomm. It can operate on fixed parameters or based on a
> > lookup-table, altering the duty cycle over time - which provides the
> > means for e.g. hardware assisted transitions of LED brightness.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v5:
> > - Make sure to not used the state of the last channel in a group to determine
> >   if the current sink should be active for all channels in the group.
> > - Replacement of unsigned -1 with UINT_MAX
> > - Work around potential overflow by using larger data types, instead of separate code paths
> > - Use cpu_to_l16() rather than hand rolling them
> > - Minor style cleanups
> > 
> >  drivers/leds/Kconfig         |    9 +
> >  drivers/leds/Makefile        |    1 +
> >  drivers/leds/leds-qcom-lpg.c | 1190 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 1200 insertions(+)
> >  create mode 100644 drivers/leds/leds-qcom-lpg.c
> 
> Let's put this into drivers/leds/rgb/. You may need to create it.
> 

Will do so.

> 
> > +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> > +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> > +{
> > +	unsigned int idx;
> > +	__le16 val;
> 
> No need for __XX variants outside of headers meant for userspace.
> 

__le16 is the in-kernel return type for cpu_to_le16(), but after further
review I believe I don't need to do this.

> > +#define LPG_ENABLE_GLITCH_REMOVAL	BIT(5)
> > +
> > +static void lpg_enable_glitch(struct lpg_channel *chan)
> > +{
> > +	struct lpg *lpg = chan->lpg;
> > +
> > +	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
> > +			   LPG_ENABLE_GLITCH_REMOVAL, 0);
> > +}
> > +
> > +static void lpg_disable_glitch(struct lpg_channel *chan)
> > +{
> > +	struct lpg *lpg = chan->lpg;
> > +
> > +	regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
> > +			   LPG_ENABLE_GLITCH_REMOVAL,
> > +			   LPG_ENABLE_GLITCH_REMOVAL);
> > +}
> 
> Helper functions for single register write is kind of overkill...
> 

Yes, it is, but it keep lpg_apply() tidy.

> > +static int lpg_blink_set(struct lpg_led *led,
> > +			 unsigned long delay_on, unsigned long delay_off)
> > +{
> > +	struct lpg_channel *chan;
> > +	unsigned int period_us;
> > +	unsigned int duty_us;
> > +	int i;
> > +
> > +	if (!delay_on && !delay_off) {
> > +		delay_on = 500;
> > +		delay_off = 500;
> > +	}
> 
> Aren't you supposed to modify the values passed to you, so that
> userspace knows what the default rate is?
> 

I had missed this.

> 
> > +	ret = lpg_lut_store(lpg, pattern, len, &lo_idx, &hi_idx);
> > +	if (ret < 0)
> > +		goto out;
> 
> Just do direct return.
> 

Will do.

> > +out:
> > +	return ret;
> > +}
> 
> > +static const struct pwm_ops lpg_pwm_ops = {
> > +	.request = lpg_pwm_request,
> > +	.apply = lpg_pwm_apply,
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static int lpg_add_pwm(struct lpg *lpg)
> > +{
> > +	int ret;
> > +
> > +	lpg->pwm.base = -1;
> > +	lpg->pwm.dev = lpg->dev;
> > +	lpg->pwm.npwm = lpg->num_channels;
> > +	lpg->pwm.ops = &lpg_pwm_ops;
> > +
> > +	ret = pwmchip_add(&lpg->pwm);
> > +	if (ret)
> > +		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
> > +
> > +	return ret;
> > +}
> 
> Do we need to do this? I'd rather have LED driver, than LED+PWM
> driver...
> 

Yes, I believe we need to do this.

Because each piece of hardware has N channels, which can be wired to
LEDs, grouped with other channels and wired to multicolor LEDs or be
used as PWM signals. And this configuration is board specific.

One such example is the laptop in front of me, which has 3 channels
wired to an RGB LED and 1 channel wired as a backlight control signal
(i.e. using pwm-backlight).  Another example is a devboard where the
4 channels are wired to 4 LEDs.

Regards,
Bjorn
