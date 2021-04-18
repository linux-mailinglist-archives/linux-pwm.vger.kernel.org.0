Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312283637FD
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Apr 2021 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhDRWE3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 18:04:29 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:46783 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhDRWE3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 18:04:29 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Apr 2021 18:04:29 EDT
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 96E351F60D;
        Sun, 18 Apr 2021 23:54:32 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
Message-ID: <881fb5a3-fb51-3967-63de-a09950839855@somainline.org>
Date:   Sun, 18 Apr 2021 23:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20201021201224.3430546-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bjorn,

On 10/21/20 10:12 PM, Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. It can operate on fixed parameters or based on a
> lookup-table, altering the duty cycle over time - which provides the
> means for e.g. hardware assisted transitions of LED brightness.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Luca Weiss <luca@z3ntu.xyz>


Thanks for these patches.  I have tested them successfully on the Sony 
Xperia XA2 (Discovery, Nile platform) with the leds on the PM660l - feel 
free to add my Tested-by.  Should I send the configuration your way for 
inclusion in this patch, or submit them separately (either applied 
after, or included as separate patches in the next version of this series)?

> +/**
> + * struct lpg_data - initialization data
> + * @lut_base:		base address of LUT block
> + * @lut_size:		number of entries in LUT
> + * @triled_base:	base address of TRILED
> + * @pwm_9bit_mask:	bitmask for switching from 6bit to 9bit pwm


Our downstream kernel derives this from the "LPG subtype" for each 
distinct channel, read from register offset +0x5.  A value of 0xb is 
subtype "PWM" with a shift of 2, a value of 0x11 is subtype "LPG_LITE" 
with a shift of 4.  Can we do the same here instead of hardcoding it for 
all channels in the LPG at once?  How should we determine if the mask is 
one or two bits wide, for the 3<<4 case?

> + * @num_channels:	number of channels in LPG
> + * @channels:		list of channel initialization data
> + */

> +	if (ping_pong) {
> +		if (len % 2)
> +			hi_pause = 0;
> +		else
> +			hi_pause = pattern[len + 1 / 2].delta_t;


len + 1 should be wrapped in parentheses just like the reassignment to 
len= below, otherwise this is always an out of bounds read (at len + 0).

> +		lo_pause = pattern[len - 1].delta_t;
> +
> +		len = (len + 1) / 2;
> +	} else {
> +		hi_pause = pattern[len - 1].delta_t;
> +		lo_pause = 0;
> +	}
> +
> +	ret = lpg_lut_store(lpg, pattern, len, &lo_idx, &hi_idx);
> +	if (ret < 0)
> +		goto out;
> +
> +	for (i = 0; i < led->num_channels; i++) {
> +		chan = led->channels[i];
> +
> +		chan->ramp_duration_ms = pattern[0].delta_t * len;


Perhaps this could store the duration of a single step instead, since 
the only use in lpg_apply_lut_control divides it by pattern length again?

> +		chan->ramp_ping_pong = ping_pong;
> +		chan->ramp_oneshot = repeat != -1;
> +
> +		chan->ramp_lo_pause_ms = lo_pause;
> +		chan->ramp_hi_pause_ms = hi_pause;
> +
> +		chan->pattern_lo_idx = lo_idx;
> +		chan->pattern_hi_idx = hi_idx;
> +	}
> +
> +out:
> +	return ret;
> +}

> +static int lpg_init_lut(struct lpg *lpg)
> +{
> +	const struct lpg_data *data = lpg->data;
> +	size_t bitmap_size;
> +
> +	if (!data->lut_base)
> +		return 0;
> +
> +	lpg->lut_base = data->lut_base;
> +	lpg->lut_size = data->lut_size;
> +
> +	bitmap_size = BITS_TO_LONGS(lpg->lut_size) * sizeof(unsigned long);
> +	lpg->lut_bitmap = devm_kzalloc(lpg->dev, bitmap_size, GFP_KERNEL);


Would it be nicer to use BITS_TO_BYTES here, or otherwise 
devm_kcalloc(..., bitmap_size, sizeof(long), ...) without mutiplying 
with sizeof(unsigned long)?

> +
> +	bitmap_clear(lpg->lut_bitmap, 0, lpg->lut_size);
> +	return lpg->lut_bitmap ? 0 : -ENOMEM;
> +}
> +
> +static int lpg_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +	struct lpg *lpg;
> +	int ret;
> +	int i;
> +
> +	lpg = devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
> +	if (!lpg)
> +		return -ENOMEM;
> +
> +	lpg->data = of_device_get_match_data(&pdev->dev);
> +	if (!lpg->data)
> +		return -EINVAL;
> +
> +	lpg->dev = &pdev->dev;
> +
> +	lpg->map = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!lpg->map) {
> +		dev_err(&pdev->dev, "parent regmap unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	ret = lpg_init_channels(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lpg_init_triled(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lpg_init_lut(lpg);
> +	if (ret < 0)
> +		return ret;


How about turning these returns into dev_err_probe?  I'm not sure if 
that's the expected way to go nowadays, but having some form of logging 
when a driver fails to probe is always good to have.

Thanks!
Marijn

> +
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		ret = lpg_add_led(lpg, np);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < lpg->num_channels; i++)
> +		lpg_apply_dtest(&lpg->channels[i]);
> +
> +	ret = lpg_add_pwm(lpg);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, lpg);
> +
> +	return 0;
> +}
