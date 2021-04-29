Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC136F0A1
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 22:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhD2Tb5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 15:31:57 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:39589 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhD2Tbz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 15:31:55 -0400
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id ACE66200F8;
        Thu, 29 Apr 2021 21:31:01 +0200 (CEST)
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <881fb5a3-fb51-3967-63de-a09950839855@somainline.org>
 <20210428223939.GN1908499@yoga>
From:   Marijn Suijten <marijn.suijten@somainline.org>
Message-ID: <f7fa3d57-3541-130a-e5fc-0df31206598f@somainline.org>
Date:   Thu, 29 Apr 2021 21:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428223939.GN1908499@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/29/21 12:39 AM, Bjorn Andersson wrote:
> On Sun 18 Apr 16:54 CDT 2021, Marijn Suijten wrote:
> 
>> Hi Bjorn,
>>
>> On 10/21/20 10:12 PM, Bjorn Andersson wrote:
>>> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
>>> PMICs from Qualcomm. It can operate on fixed parameters or based on a
>>> lookup-table, altering the duty cycle over time - which provides the
>>> means for e.g. hardware assisted transitions of LED brightness.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Tested-by: Luca Weiss <luca@z3ntu.xyz>
>>
>>
>> Thanks for these patches.  I have tested them successfully on the Sony
>> Xperia XA2 (Discovery, Nile platform) with the leds on the PM660l - feel
>> free to add my Tested-by.  Should I send the configuration your way for
>> inclusion in this patch, or submit them separately (either applied after, or
>> included as separate patches in the next version of this series)?
>>
> 
> Thanks for testing, let's try to land this first iteration first and
> then we can add PM660l and PM8150* definitions/support on top.


I'll keep an eye out for when these patches land and send them on top. 
Feel free to add me to the CC list for future revisions.

>>> +/**
>>> + * struct lpg_data - initialization data
>>> + * @lut_base:		base address of LUT block
>>> + * @lut_size:		number of entries in LUT
>>> + * @triled_base:	base address of TRILED
>>> + * @pwm_9bit_mask:	bitmask for switching from 6bit to 9bit pwm
>>
>>
>> Our downstream kernel derives this from the "LPG subtype" for each distinct
>> channel, read from register offset +0x5.  A value of 0xb is subtype "PWM"
>> with a shift of 2, a value of 0x11 is subtype "LPG_LITE" with a shift of 4.
>> Can we do the same here instead of hardcoding it for all channels in the LPG
>> at once?  How should we determine if the mask is one or two bits wide, for
>> the 3<<4 case?
>>
> 
> I don't see any obvious solution to the latter, so perhaps we should
> just stick with defining this per compatible? Or am I reading your
> suggestion wrong?


Assuming these devices have a different "LPG subtype" you should be able 
to read their value and add it to the list as third option. 
Alternatively, can you point out the driver this `3<<4` mask was based 
on?  With all the information available it should be possible to derive 
this from hardware for every channel instead of hardcoding it.

>>> +
>>> +	bitmap_clear(lpg->lut_bitmap, 0, lpg->lut_size);
>>> +	return lpg->lut_bitmap ? 0 : -ENOMEM;
>>> +}
>>> +
>>> +static int lpg_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device_node *np;
>>> +	struct lpg *lpg;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	lpg = devm_kzalloc(&pdev->dev, sizeof(*lpg), GFP_KERNEL);
>>> +	if (!lpg)
>>> +		return -ENOMEM;
>>> +
>>> +	lpg->data = of_device_get_match_data(&pdev->dev);
>>> +	if (!lpg->data)
>>> +		return -EINVAL;
>>> +
>>> +	lpg->dev = &pdev->dev;
>>> +
>>> +	lpg->map = dev_get_regmap(pdev->dev.parent, NULL);
>>> +	if (!lpg->map) {
>>> +		dev_err(&pdev->dev, "parent regmap unavailable\n");
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	ret = lpg_init_channels(lpg);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	ret = lpg_init_triled(lpg);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	ret = lpg_init_lut(lpg);
>>> +	if (ret < 0)
>>> +		return ret;
>>
>>
>> How about turning these returns into dev_err_probe?  I'm not sure if that's
>> the expected way to go nowadays, but having some form of logging when a
>> driver fails to probe is always good to have.
>>
> 
> The intention is that each code path through these functions will either
> pass or spit out an error in the log. I looked through them again and
> think I cover all paths...


That is true, all the errors not covered are extremely unlikely like 
-ENOMEM.  I vaguely recall having to insert extra logging to get through 
initial probe, but that might have been something inside lpg_add_led as 
well.  Fine to leave this as it is.

- Marijn
