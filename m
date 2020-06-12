Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D4C1F7BE8
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLRAt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Jun 2020 13:00:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726085AbgFLRAs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 13:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591981247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTihYUKXSrTnrV1cw1wXoVKUqiDmvG+bRKMsuvDOElI=;
        b=ZE3sal9NQR3R10QuAceUB/O2ra3l3GQ6Pspn4X2FeM+lh+05Hca8RccMmfmiaepBMKYGld
        MYguJAZc/xkYP6l75FEgncrRLii1aJlhJ6sXyhzh4iE3K2rYqCkwrYxXoJ4ITxP7USVxuV
        LpLopsTxPPshGLZkSIk7n0BqZ59VYyE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-cEb_muNdMsihUiXz9pFlHA-1; Fri, 12 Jun 2020 13:00:45 -0400
X-MC-Unique: cEb_muNdMsihUiXz9pFlHA-1
Received: by mail-ej1-f70.google.com with SMTP id do21so4455706ejc.2
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2020 10:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTihYUKXSrTnrV1cw1wXoVKUqiDmvG+bRKMsuvDOElI=;
        b=YVDZP/ICRgHK33uKW/1CBAvzKEZo2RFiRCvHlam0siIG8ot1FSEKI1WwHDP/PJjVpY
         PxCUj3INFbaQJNcQdox9pXqh+3ZsMUEXGu/3X+C+VPzd02oHaloK8t0w8Ul6Tgyk1wGG
         5rJ6KTdOAddbrh4Xup5uCxTweRDFYpWxKp0h+nFZqTx7IK7/VXawwahNxEszpvg+PrHN
         mxAby8IWQKj2J73moajPpX9eP0UEFqqBFV7jhgEzPYnfNCqgnG/QHgq+N3mR2Yi+NnJu
         UOoVIcFliLPWeezVTcOa9wHJ3R9CO9jVX1TPm/ypE0pV9QSNOuto7ik4VI8pIcZ4wNuU
         x/IQ==
X-Gm-Message-State: AOAM533/roIXPga8wndKruPr+GCG/f6sht5r9lIwonHAQF6Bj0lxNamc
        tNOzlyYF4RHwZ4WZ0APSP2smQsc7mkBdheTNWEpWAdT6tuvZ8Z/XQwa+fB1a0ObIqIwfAv+Ur4m
        FfhnV8WJxoFrM5WZVUraN
X-Received: by 2002:a50:af25:: with SMTP id g34mr12664931edd.85.1591981244267;
        Fri, 12 Jun 2020 10:00:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1ZL1hLqchv/eFpUYGZFQqouDUrpcBFi1A1KbkRuhgNPPw1kwQ6gTpxpqVqI+lMaYQMqCDKg==
X-Received: by 2002:a50:af25:: with SMTP id g34mr12664913edd.85.1591981244074;
        Fri, 12 Jun 2020 10:00:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id x11sm3852082ejv.81.2020.06.12.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 10:00:43 -0700 (PDT)
Subject: Re: [PATCH v2 11/15] pwm: crc: Implement get_state() method
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
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-12-hdegoede@redhat.com>
 <20200611213744.6gg2oy45cende6ba@taurus.defre.kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f2a268ef-2b65-d027-0b0c-b83e12a04f20@redhat.com>
Date:   Fri, 12 Jun 2020 19:00:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611213744.6gg2oy45cende6ba@taurus.defre.kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/11/20 11:37 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Jun 07, 2020 at 08:18:36PM +0200, Hans de Goede wrote:
>> Implement the pwm_ops.get_state() method to complete the support for the
>> new atomic PWM API.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
>> index 58c7e9ef7278..6c75a3470bc8 100644
>> --- a/drivers/pwm/pwm-crc.c
>> +++ b/drivers/pwm/pwm-crc.c
>> @@ -114,8 +114,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	return 0;
>>   }
>>   
>> +static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			       struct pwm_state *state)
>> +{
>> +	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
>> +	struct device *dev = crc_pwm->chip.dev;
>> +	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
>> +	int error;
>> +
>> +	error = regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
>> +	if (error) {
>> +		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
>> +		return;
>> +	}
>> +
>> +	error = regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_reg);
>> +	if (error) {
>> +		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
>> +		return;
>> +	}
> 
> I assume that duty_cycle_reg cannot be bigger than 0xff? Would it make
> sense to mask the value accordingly to get more robust code?
> 
>> +	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
>> +
>> +	state->period     = clk_div * NSEC_PER_MHZ * 256 / PWM_BASE_CLK_MHZ;
>> +	state->duty_cycle = duty_cycle_reg * state->period / PWM_MAX_LEVEL;
>> +	state->polarity   = PWM_POLARITY_NORMAL;
>> +	state->enabled    = !!(clk_div_reg & PWM_OUTPUT_ENABLE);
> 
> These aligned = look strange (IMHO). If you don't feel strong here I'd
> like to see a single space before a =.

Ok, will change for the next version.

Regards,

Hans

