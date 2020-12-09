Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C4E2D4D1B
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Dec 2020 22:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbgLIVsF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Dec 2020 16:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388024AbgLIVsF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Dec 2020 16:48:05 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5ECC061794
        for <linux-pwm@vger.kernel.org>; Wed,  9 Dec 2020 13:47:24 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id p126so3381532oif.7
        for <linux-pwm@vger.kernel.org>; Wed, 09 Dec 2020 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pwCUH49fVUFbxLs3AmViLHi2PCjEJq12uGKdYxre9Bg=;
        b=BspLMgJinmRzVFbbn6PNvVojIA03MUcWolzknnBLj5U3Ytl/UYR6HnadQuAbC2FgGH
         sKPlJaplcjmNYobtJReo6FZuFV9bFcBxG6VuCUR/TMkh4C69BA+gpAgXEpnpF/SK6oB+
         8ydCeeKXh4m7MPtDKiTb/gnq6+Xy5ATYc4MVk4aWAVumReGPN2KBo/8v/oLTaQojSOCs
         Eh2UhU0f4IHZ3RHw6kNDde/hjv9kgms/e47OIKWU46Kn026aeY+MngaUp1NLyZ1ZQFWg
         Wcop3f1zveYmPBTZsmAeSNWJNbEhaI1jIxJ6i8GmzKJKSxr3c8GQMzc+HdMnEFdAikJG
         9OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pwCUH49fVUFbxLs3AmViLHi2PCjEJq12uGKdYxre9Bg=;
        b=nXay5gxPnLhkVc1jkHMhCRuTWzUq8hkM2Zb477uAtXS114NxgIUybyZXYgdoYenLmb
         eOMwVERGYKVr1aRNf+C3qNwTMp/cXrKMQC6dY8ywsVivAdWOAceL9cSQMGdq6hAlTxbW
         w7J2AuH1Xr7O2MgHzjNV7LKH/80X0sPwonHpjjHP3Etwq02DQPesENvS4rDIuaLaaX4y
         jGFVJ371cmLpmZc+4nYe/aT+h7XaY+4TlF636ySM4q06EKIObT+Avx79LhaTQk1q4veD
         pobDSLX1Fjdm+WSn4tbyrbe9BXkZfXwRwcMMwIG14zt73ZBJPRZD9qi8OrLCZ8u0WRHn
         VTew==
X-Gm-Message-State: AOAM532Uzl74smk31iHxjLTxy4IC6NqHEECweuBDj08VA0ZBNBb4tdyi
        X+gAkhw8PNenGPhHrWOEKbNnvQ==
X-Google-Smtp-Source: ABdhPJx0WNLo9S3T32e1UAtJL+g0rWFENM7Hgz1uN7UnR+PAT+k7ugNymFSIME8pAl0O9gae8yU7JA==
X-Received: by 2002:aca:eb41:: with SMTP id j62mr3302234oih.88.1607550443870;
        Wed, 09 Dec 2020 13:47:23 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y8sm336230oix.43.2020.12.09.13.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 13:47:23 -0800 (PST)
Date:   Wed, 9 Dec 2020 15:47:20 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
Message-ID: <X9FF6Jg8SkSwMHuK@builder.lan>
References: <20201208044022.972872-1-bjorn.andersson@linaro.org>
 <20201208080433.szy7dek2qvn3d4vb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208080433.szy7dek2qvn3d4vb@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue 08 Dec 02:04 CST 2020, Uwe Kleine-K?nig wrote:

> Hello,
> 
> On Mon, Dec 07, 2020 at 10:40:22PM -0600, Bjorn Andersson wrote:
> > The SN65DSI86 provides the ability to supply a PWM signal on GPIO 4,
> > with the primary purpose of controlling the backlight of the attached
> > panel. Add an implementation that exposes this using the standard PWM
> > framework, to allow e.g. pwm-backlight to expose this to the user.
> > 
> > Special thanks to Doug Anderson for suggestions related to the involved
> > math.
> 
> Did you test this with CONFIG_PWM_DEBUG? (I think you didn't, because
> otherwise there would be a .get_state callback.)
> 

I had not, but have now explored this further and will follow up with a
get_state implementation :)

> > @@ -162,6 +171,12 @@ struct ti_sn_bridge {
> >  	struct gpio_chip		gchip;
> >  	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
> >  #endif
> > +#if defined(CONFIG_PWM)
> 
> Would it make sense to introduce a separate config symbol for this?
> Something like CONFIG_PWM_SN65DSI87?
> 

I don't think it adds much value at this point in time, if anyone needs
to squeeze those extra few bytes out of the kernel it's an easy change
to do later.

> > +	struct pwm_chip			pchip;
> > +	bool				pwm_enabled;
> > +	unsigned int			pwm_refclk;
> > +	atomic_t			pwm_pin_busy;
> 
> struct ti_sn_bridge has a kernel doc comment describing all members,
> please add a description of the members you introduced here. Please also
> point out that you use pwm_pin_busy to protect against concurrent use of
> the pin as PWM and GPIO.
> 

Yes, sorry for missing this.

> > +#endif
> >  };
> >  
> >  static const struct regmap_range ti_sn_bridge_volatile_ranges[] = {
> > @@ -499,6 +514,14 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn_bridge *pdata)
> >  
> >  	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
> >  			   REFCLK_FREQ(i));
> > +
> > +#if defined(CONFIG_PWM)
> > +	/*
> > +	 * The PWM refclk is based on the value written to SN_DPPLL_SRC_REG,
> > +	 * regardless of its actual sourcing.
> > +	 */
> > +	pdata->pwm_refclk = ti_sn_bridge_refclk_lut[i];
> > +#endif
> 
> I don't understand this code. 'i' seems to be something more special
> than a counter variable, so I wonder if it should have a better name.
> (This is however an issue separate from this patch, but it would be
> great to first make the code a bit better understandable. Or is this
> only me?)
> 

The sn65dsi86 can either run off an external "reference clock" or
derive the clock from the video signal (afaict). In both cases 3 bits
are used to inform the chip about this clock rate - and the two
possible lists of frequencies are defined in ti_sn_bridge_refclk_lut[]
and ti_sn_bridge_dsiclk_lut[] above.

i is the index into these arrays, and the value being programmed into
this register. (And yes, that might not be the best named variable...)


The specification states that the PWM refclk is either straight off
the external refclk, in which case it's ti_sn_bridge_refclk_lut[i] or
somehow derived from the video signal down to
ti_sn_bridge_refclk_lut[i].

So this would be slightly cleaner if I just read SN_DPPLL_SRC_REG,
masked out the bits and did a lookup in ti_sn_pwm_apply(). But I wanted
to avoid the extra i2c read...

> >  }
> >  
> >  static void ti_sn_bridge_set_dsi_rate(struct ti_sn_bridge *pdata)
> > @@ -981,6 +1004,161 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn_bridge *pdata)
> >  	return 0;
> >  }
> >  
> > +#if defined(CONFIG_PWM)
> > +static int ti_sn_pwm_pin_request(struct ti_sn_bridge *pdata)
> > +{
> > +	return atomic_xchg(&pdata->pwm_pin_busy, 1) ? -EBUSY : 0;
> > +}
> > +
> > +static void ti_sn_pwm_pin_release(struct ti_sn_bridge *pdata)
> > +{
> > +	atomic_set(&pdata->pwm_pin_busy, 0);
> > +}
> > +
> > +static struct ti_sn_bridge *
> > +pwm_chip_to_ti_sn_bridge(struct pwm_chip *chip)
> 
> All your functions share the same function prefix (which is fine), but
> this one doesn't.
> 

I'll fix that.

> > +{
> > +	return container_of(chip, struct ti_sn_bridge, pchip);
> > +}
> > [...]
> > +	if (state->enabled) {
> > +		/*
> > +		 * Per the datasheet the PWM frequency is given by:
> > +		 *
> > +		 * PWM_FREQ = REFCLK_FREQ / (PWM_PRE_DIV * BACKLIGHT_SCALE + 1)
> > +		 *
> > +		 * In order to find the PWM_FREQ that best suits the requested
> > +		 * state->period, the PWM_PRE_DIV is calculated with the
> > +		 * maximum possible number of steps (BACKLIGHT_SCALE_MAX). The
> > +		 * actual BACKLIGHT_SCALE is then adjusted down to match the
> > +		 * requested period.
> > +		 *
> > +		 * The BACKLIGHT value is then calculated against the
> > +		 * BACKLIGHT_SCALE, based on the requested duty_cycle and
> > +		 * period.
> > +		 */
> > +		pwm_freq = NSEC_PER_SEC / state->period;
> 
> Here you should better have some range checking. Consider for example
> state->period being > NSEC_PER_SEC. (Hint: This makes pwm_freq = 0 and
> in the next line you divide by pwm_freq.)
> 

I didn't consider the case where someone would drive their backlight <
1Hz. But given that this is a generic pwm_chip now I should do something
about it - or reject it...

> > +		pre_div = DIV_ROUND_UP(pdata->pwm_refclk / pwm_freq - 1, BACKLIGHT_SCALE_MAX);
> > +		scale = (pdata->pwm_refclk / pwm_freq - 1) / pre_div;
> 
> I'm still trying to wrap my head around this calculation, but dividing
> by the result of a division is always loosing precision. This is really
> involved and I'm willing to bet this can be done easier and with more
> precision.
> 
> ... some time later ...
> 
> You wrote "PWM_FREQ = REFCLK_FREQ / (PWM_PRE_DIV * BACKLIGHT_SCALE + 1)",
> so (I think) that means you have:
> 
> 	period = (PWM_PRE_DIV * BACKLIGHT_SCALE + 1) / refclk
> 

Yes, this matches my math.

Which would imply that the PWM period is (PRE_DIV * SCALE + 1) ticks of
the refclk.

> right? I deduce from your formula how the duty_cycle is defined and I
> think it's:
> 
> 	duty_cycle = (PWM_PRE_DIV * BACKLIGHT + 1) / refclk
> 
> is this right? And now your idea to "best suite the requested period" is
> to select a small divider such that you can still use a big value in
> SCALE to define the period and so have a fine separation for the
> duty_cycle, right?
> 

Above formula helps us calculate the period if we know the PRE_DIV and
SCALE, but what I'm given is the period by the framework and I need to
find suitable values for PRE_DIV and SCALE.

With the purpose of maximizing the resolution of duty_cycle (i.e.
[0, SCALE]) the SCALE is fixed to 65535 and the smallest PRE_DIV that
results in a period larger than the requested one is calculated.

With this PRE_DIV determined SCALE is then adjusted to match the
requested period. The duty_cycle is then just calculated as a fraction
of this.

> I will stop doing maths here now until you confirm my steps up to now
> are right.
> 
> > +		backlight = scale * state->duty_cycle / state->period;
> 
> This is an u64 division, you must use do_div for that. Also you're
> losing precision here.
> 

Are you suggesting that it would be better to just calculate the
backlight the same way as scale is calculated, rather then just scale
it? I.e:
		duty_freq = NSEC_PER_SEC / state->duty_cycle;
		backlight = (pdata->pwm_refclk / duty_freq - 1) / pre_div;

> > +		ret = regmap_write(pdata->regmap, SN_PWM_PRE_DIV_REG, pre_div);
> > +		if (ret) {
> > +			dev_err(pdata->dev, "failed to update PWM_PRE_DIV\n");
> > +			goto out;
> > +		}
> > +
> > +		ti_sn_bridge_write_u16(pdata, SN_BACKLIGHT_SCALE_REG, scale);
> > +		ti_sn_bridge_write_u16(pdata, SN_BACKLIGHT_REG, backlight);
> 
> How does the PWM behave in between these writes? Are the register values
> shadowed until the third write happens (which would be the optimum), or
> does this result in (maybe) emitting an output wave that doesn't
> correspond to the requested setting (assuming the PWM is already enabled
> of course)?
> 
> What happens if the value written to SN_BACKLIGHT_SCALE_REG is less than
> the previous value in SN_BACKLIGHT_REG? ti_sn_bridge_write_u16 wraps two
> regmap writes, is there a race, too?
> 

I have no idea, I don't find anything about this in the datasheet:
https://www.ti.com/lit/ds/symlink/sn65dsi86.pdf?ts=1607491553008

> > +	}
> > +
> > +	pwm_en_inv = FIELD_PREP(BIT(1), !!state->enabled) |
> > +		     FIELD_PREP(BIT(0), state->polarity == PWM_POLARITY_INVERSED);
> 
> Please introduce symbolic names for BIT(1) and BIT(0) here.
> 

Okay, will do.

> How does the hardware behave with the enable bit unset? Does it emit the
> inactive level according to the polarity bit?
> 

I'm doing this work on a consumer device, so unfortunately I have no way
to scope the signal. But as far as I can tell from my testing the
inverse bit does nothing when the PWM enabled bit is not set.

And clearing the PWM enable bit results in max brightness on the
display.

> > +	ret = regmap_write(pdata->regmap, SN_PWM_EN_INV_REG, pwm_en_inv);
> > +	if (ret) {
> > +		dev_err(pdata->dev, "failed to update PWM_EN/PWM_INV\n");
> > +		goto out;
> > +	}
> > +
> > +	pdata->pwm_enabled = !!state->enabled;
> > +out:
> > +
> > +	if (!pdata->pwm_enabled)
> > +		pm_runtime_put_sync(pdata->dev);
> > +
> > +	return ret;
> > +}
> > +
> > [...]
> > +static struct pwm_device *ti_sn_pwm_of_xlate(struct pwm_chip *pc,
> > +					     const struct of_phandle_args *args)
> > +{
> > +	struct pwm_device *pwm;
> > +
> > +	if (args->args_count != 1)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	pwm = pwm_request_from_chip(pc, 0, NULL);
> > +	if (IS_ERR(pwm))
> > +		return pwm;
> > +
> > +	pwm->args.period = args->args[0];
> > +
> > +	return pwm;
> > +}
> 
> This is done to optimise away the 0 needed in each phandle to implement
> the "usual" pwm binding. IMHO this function should either move into the
> pwm core, or you should stick to the usual binding.
> 

You're right and I'd be happy to post a of_pwm_single_xlate() helper to
the PWM core.

> Apropos binding: Is there already a binding document for the hardware?
> You should expand it to describe your additions.
> 

The #pwm-cells = <1> was included in the DT binding from the beginning,
just no one ever implemented it in the driver.

> > @@ -1282,6 +1476,12 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
> >  		return ret;
> >  	}
> >  
> > +	ret = ti_sn_setup_pwmchip(pdata);
> > +	if (ret)  {
> > +		pm_runtime_disable(pdata->dev);
> > +		return ret;
> > +	}
> 
> I'm not sure about the purpose of the containing hardware, but I wonder
> if it would be saner to not break probing of the device if adding the
> PWM functionality fails. Ideally the driver would provide an mfd driver
> that allows its components to be probed independently.
> 

Due to the possible circular dependency between this bridge driver and
the associated panel's dependency on the pwm_chip the suggestion of
splitting the driver in more pieces did came up. So I'm looking into
this now.

That said, the first issue I ran into while looking at this is how to
register a pwm_chip associated to the child's struct device and have
of_pwm_get() be allowed to find it (this made up node does not have an
of_node and there's no way to specify that the parent's of_node should
be used in the lookup).


Thanks for the review.

Regards,
Bjorn

> >  	i2c_set_clientdata(client, pdata);
> >  
> >  	pdata->aux.name = "ti-sn65dsi86-aux";
> > @@ -1320,6 +1520,8 @@ static int ti_sn_bridge_remove(struct i2c_client *client)
> >  
> >  	drm_bridge_remove(&pdata->bridge);
> >  
> > +	ti_sn_remove_pwmchip(pdata);
> > +
> >  	return 0;
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


