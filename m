Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B6C2160CD
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2020 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGFVF3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jul 2020 17:05:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25768 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgGFVF2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 17:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594069526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joj3ugB6R/6J+5A0HiLDzW8Xgi+NkTicU2Iuhf30mzk=;
        b=QDhWnSXHkVrHin56tz9Yv0Ih8g/ngYa0UD5fYSpcxusPIem2dxv/VYoVUvJ5y6wLz1b1d7
        Cr71b5LfNIgVWsvayoAzkMOvvG684RE4NdP9K1hBfDC/d1B1VhDOCuIQzhPpPxak0dQShF
        qPavwX7i2OoIpMzNC/IcN3j+Zrgu5IE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-adWKYAmxOyuEi1ufNXbX6g-1; Mon, 06 Jul 2020 17:05:23 -0400
X-MC-Unique: adWKYAmxOyuEi1ufNXbX6g-1
Received: by mail-ed1-f71.google.com with SMTP id x20so50867640edr.20
        for <linux-pwm@vger.kernel.org>; Mon, 06 Jul 2020 14:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=joj3ugB6R/6J+5A0HiLDzW8Xgi+NkTicU2Iuhf30mzk=;
        b=r9Ts3pNizE82mJgCgPD07FHor1kX9G78xARfXEHwuBvSJud8s+teaoWu0ll0VMNcwC
         t0WLKBHYWFZA1fGzdWHvxUKh1+liKSobCBsflS2/CQVTCNUQCZtV6iLVRs5xSZQzUBtg
         GFbfyc4mHwWID7cbepy+riWfqMBefuICiPLHcsJSPYpkYZZcxIfLTtpqvYoZANaodl3W
         1oxoLcYsH/lX9tyIepWUStKMs2btHf3OkhsAclU24iqyVJ4+46m6OSLkXkgR+QamMDOs
         W3ySgWG1vSQukuOJ5r6CWEsL7p8ne+hWwkIV9+baWidJpCtE6eAcY33A488HGC3k6xQ7
         U6vA==
X-Gm-Message-State: AOAM532yOimlwnsYwx9ZDunxFLNjx2wJ0II4Q3E80+cfqFbzRiXyC9ov
        4WZISX54YBTAdzdCwATCPHkQqCzIRuGLlxn6WRwePr2vv38zypu/7zQuy+v3US7N2PO9dMEWUkw
        u81a/RHn+tbTMA9W6uQfJ
X-Received: by 2002:a17:906:fa92:: with SMTP id lt18mr33000426ejb.534.1594069522020;
        Mon, 06 Jul 2020 14:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK9F8LwD6ImPYy5wRucrWx7eh1AqEMfwqNCkCL/l8TpHT/un27SnONteRcUHtIlD5wblFxWA==
X-Received: by 2002:a17:906:fa92:: with SMTP id lt18mr33000405ejb.534.1594069521782;
        Mon, 06 Jul 2020 14:05:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y11sm16560013ejw.63.2020.07.06.14.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 14:05:21 -0700 (PDT)
Subject: Re: [PATCH v3 11/15] pwm: crc: Implement get_state() method
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
 <20200620121758.14836-12-hdegoede@redhat.com>
 <20200622075730.lenaflptqnemagff@taurus.defre.kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <59babd32-9421-0b31-187f-ceff7c003f54@redhat.com>
Date:   Mon, 6 Jul 2020 23:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622075730.lenaflptqnemagff@taurus.defre.kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/22/20 9:57 AM, Uwe Kleine-König wrote:
> On Sat, Jun 20, 2020 at 02:17:54PM +0200, Hans de Goede wrote:
>> Implement the pwm_ops.get_state() method to complete the support for the
>> new atomic PWM API.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Add Andy's Reviewed-by tag
>> - Remove extra whitespace to align some code after assignments (requested by
>>    Uwe Kleine-König)
>> ---
>>   drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
>> index 8a7f4707279c..b311354d40a3 100644
>> --- a/drivers/pwm/pwm-crc.c
>> +++ b/drivers/pwm/pwm-crc.c
>> @@ -119,8 +119,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
>> +
>> +	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
>> +
>> +	state->period = clk_div * NSEC_PER_USEC * 256 / PWM_BASE_CLK_MHZ;
>> +	state->duty_cycle = duty_cycle_reg * state->period / PWM_MAX_LEVEL;
> 
> Please round up here.

Ok, I can fix that for the next version of this patch-set. Before I
post a new version of this patch-set, you have only responded to
some of the PWM patches in this set. Do you have any remarks on the
other PWM patches ?

Regards,

Hans

