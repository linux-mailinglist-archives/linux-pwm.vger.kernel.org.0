Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9937FCAA
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhEMRoe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 May 2021 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhEMRoc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 May 2021 13:44:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ECEC06175F
        for <linux-pwm@vger.kernel.org>; Thu, 13 May 2021 10:43:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z3so24823738oib.5
        for <linux-pwm@vger.kernel.org>; Thu, 13 May 2021 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rmirlcoRqiQkPgRG3x53Crex7jCaDOSES3PYSmlMKwM=;
        b=O6u3p5AvPdivCUE35+1pKcX4yC/UonePeGPLCiwwtckCVhU4E6DI8zHcXOd1UCkjqB
         ddgSB9M2q78ms+QYQMd7HdH5mxCpAhZy17+zayMNoVZY2wElACd396OLuoOxrfpslau9
         aQ2UTSjvZL7Pq4oN3Ol3mytOpO4cc8L6giDzwqc/xzjD1ETzNMsVYZXP9+MpmriLoUOn
         +mVQ/limknIY3VjtsoM7nWrpcUCoSDUpgBLG7IJOvskMBnrSXU1nlRzsTx19VjOjTVGP
         KclVkU1c8IImyzBjXSJmU3zK1hFbw2nUUD2tEqnSdzgSrKOLkrVfqVgjK7x3XuS7Besc
         QzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rmirlcoRqiQkPgRG3x53Crex7jCaDOSES3PYSmlMKwM=;
        b=RxqwTveNWg5t5+sUVBpjKZeBKXdY0FcNZUepJMbIjd+TAPfIowx7i67E6919ayN7jw
         yNhRKNsDuWEn+l6SGJ0KgoebuzLL0JhIMV84Q/jr9d/L0vOtjsHSMok9jUuupM8FoXXq
         gdpolRz8ntm0zOViMZcLKsAWyEV0Smb5h6ThDNlT0v5KqHF1sgw8kzuEBSR//Xsq4LV3
         /eyJqLV5vrePQjVXmGbOmtxFjW7HDdXKVHf/2/VRKaTiIr030DJ05DN0cpX7sIpnD72v
         h45iMmnZ9Ea75QGowJ3eYlsjWnj630UG6jW9/R8vylqRH1djO28jHuqKSWNbV0JYCB/K
         XEHg==
X-Gm-Message-State: AOAM533jBwUo9ua7Ra86/XTVBfOAoZhpSPVGAwK+LHVqlQcSrdJp1emX
        rabKFaC83OMjULEmv6vnca4VsA==
X-Google-Smtp-Source: ABdhPJy2yWVoN94XJYQGrENPiReo4mj33+y4Jyhc4dXw69CkJll+MePV5Gs1TpseS4y9OscTeLhr7A==
X-Received: by 2002:a05:6808:2d2:: with SMTP id a18mr5353611oid.82.1620927800590;
        Thu, 13 May 2021 10:43:20 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c13sm759750oto.18.2021.05.13.10.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:43:20 -0700 (PDT)
Date:   Thu, 13 May 2021 12:43:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20210513174317.GM2484@yoga>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <20210505051534.id36dvocqfqg3jqc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505051534.id36dvocqfqg3jqc@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed 05 May 00:15 CDT 2021, Uwe Kleine-K?nig wrote:

> Hello Bjorn,
> 

Thanks for your feedback, and the input on extending the PWM api related
to patterns. I'll revisit the calculations, and PWM_DEBUG accordingly.

Regards,
Bjorn

> On Wed, Oct 21, 2020 at 01:12:22PM -0700, Bjorn Andersson wrote:
> > +static const unsigned int lpg_clk_table[NUM_PWM_PREDIV][NUM_PWM_CLK] = {
> > +	{
> > +		1 * (NSEC_PER_SEC / 1024),
> > +		1 * (NSEC_PER_SEC / 32768),
> > +		1 * (NSEC_PER_SEC / 19200000),
> > +	},
> > +	{
> > +		3 * (NSEC_PER_SEC / 1024),
> > +		3 * (NSEC_PER_SEC / 32768),
> 
> 1000000000 / 32768 is 30517.578125. Because of the parenthesis this is
> truncated to 30517. Multiplied by 3 this results in 91551. The exact
> result is 91552.734375 however.
> 
> > +		3 * (NSEC_PER_SEC / 19200000),
> > +	},
> > +	{
> > +		5 * (NSEC_PER_SEC / 1024),
> > +		5 * (NSEC_PER_SEC / 32768),
> > +		5 * (NSEC_PER_SEC / 19200000),
> > +	},
> > +	{
> > +		6 * (NSEC_PER_SEC / 1024),
> > +		6 * (NSEC_PER_SEC / 32768),
> > +		6 * (NSEC_PER_SEC / 19200000),
> > +	},
> > +};
> > +
> > +/*
> > + * PWM Frequency = Clock Frequency / (N * T)
> > + *      or
> > + * PWM Period = Clock Period * (N * T)
> > + *      where
> > + * N = 2^9 or 2^6 for 9-bit or 6-bit PWM size
> > + * T = Pre-divide * 2^m, where m = 0..7 (exponent)
> > + *
> > + * This is the formula to figure out m for the best pre-divide and clock:
> > + * (PWM Period / N) = (Pre-divide * Clock Period) * 2^m
> > + */
> > +static void lpg_calc_freq(struct lpg_channel *chan, unsigned int period_us)
> > +{
> > +	int             n, m, clk, div;
> > +	int             best_m, best_div, best_clk;
> > +	unsigned int    last_err, cur_err, min_err;
> > +	unsigned int    tmp_p, period_n;
> > +
> > +	if (period_us == chan->period_us)
> > +		return;
> > +
> > +	/* PWM Period / N */
> > +	if (period_us < UINT_MAX / NSEC_PER_USEC)
> > +		n = 6;
> > +	else
> > +		n = 9;
> > +
> > +	period_n = ((u64)period_us * NSEC_PER_USEC) >> n;
> > +
> > +	min_err = UINT_MAX;
> > +	last_err = UINT_MAX;
> > +	best_m = 0;
> > +	best_clk = 0;
> > +	best_div = 0;
> > +	for (clk = 0; clk < NUM_PWM_CLK; clk++) {
> > +		for (div = 0; div < NUM_PWM_PREDIV; div++) {
> > +			/* period_n = (PWM Period / N) */
> > +			/* tmp_p = (Pre-divide * Clock Period) * 2^m */
> > +			tmp_p = lpg_clk_table[div][clk];
> > +			for (m = 0; m <= NUM_EXP; m++) {
> > +				cur_err = abs(period_n - tmp_p);
> > +				if (cur_err < min_err) {
> > +					min_err = cur_err;
> > +					best_m = m;
> > +					best_clk = clk;
> > +					best_div = div;
> > +				}
> > +
> > +				if (m && cur_err > last_err)
> > +					/* Break for bigger cur_err */
> > +					break;
> > +
> > +				last_err = cur_err;
> > +				tmp_p <<= 1;
> 
> This is inexact. Consider again the case where tmp_p is
> 3 * (NSEC_PER_SEC / 32768). The values you use and the exact values are:
> 
> 	m     |       0        |      1       |      2      |      3     | ... |        7 |
> 	tmp_p |   91551        | 183102       | 366204      | 732408     |     | 11718528 |
>         actual|   91552.734375 | 183105.46875 | 366210.9375 | 732421.875 | ... | 11718750 |
> 
> So while you save some cycles by precalculating the values in
> lpg_clk_table, you trade that for lost precision.
> 
> > +			}
> > +		}
> > +	}
> 
> Please don't pick a period that is longer than the requested period (for
> the PWM functionality that is).
> 
> This can be simplified, you can at least calculate the optimal m
> directly.
> 
> > +	/* Use higher resolution */
> > +	if (best_m >= 3 && n == 6) {
> > +		n += 3;
> > +		best_m -= 3;
> > +	}
> > +
> > +	chan->clk = best_clk;
> > +	chan->pre_div = best_div;
> > +	chan->pre_div_exp = best_m;
> > +	chan->pwm_size = n;
> > +
> > +	chan->period_us = period_us;
> > +}
> > +
> > +static void lpg_calc_duty(struct lpg_channel *chan, unsigned int duty_us)
> > +{
> > +	unsigned int max = (1 << chan->pwm_size) - 1;
> > +	unsigned int val = div_u64((u64)duty_us << chan->pwm_size, chan->period_us);
> 
> Please use the actually implemented period here instead of the
> requested. This improves precision, see commit
> 8035e6c66a5e98f098edf7441667de74affb4e78 for a similar case.
> 
> > +
> > +	chan->pwm_value = min(val, max);
> > +}
> > +
> > [...]
> > +static const struct pwm_ops lpg_pwm_ops = {
> > +	.request = lpg_pwm_request,
> > +	.apply = lpg_pwm_apply,
> 
> Can you please test your driver with PWM_DEBUG enabled? The first thing
> this will critizise is that there is no .get_state callback.
> 
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static int lpg_add_pwm(struct lpg *lpg)
> > +{
> > +	int ret;
> > +
> > +	lpg->pwm.base = -1;
> 
> Please drop this assignment.
> 
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
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


