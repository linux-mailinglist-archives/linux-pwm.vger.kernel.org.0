Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207292B579
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 14:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfE0MhK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 08:37:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35982 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0MhK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 08:37:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id v22so8445610wml.1
        for <linux-pwm@vger.kernel.org>; Mon, 27 May 2019 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=58p9uFjWmpCFDMR48fg0NW3P4SQ0InNf8hSLgO2E5y0=;
        b=PZJIz7jKVldlj98SfaUUp48OS0pnWzI5Ub7kGcwfcQMi8kVT0za3XanBWNyq7YcEq2
         /EI2nVDwiCyArbTm4hlB3OesVnnAQyknSLi81N5RYCpuTa30qPSwMIc5GJjI68FiyC0J
         +vV2EQ1frXQmsc9756ZAfozjBBWE+syHppQ0UgCHJRvHGRsDxfP0pRJQFa66jwc52rs+
         /UkF3v8UYFHMwLAg5d6PA/E1u2838kdckck8oavFSRCzPs8LXZDrJHVRklBdwJ+Ba65I
         nbWD/4JgQW3gejx4kkhyc0wEO3PQIIVYIELkDsMrepV8i0xO8HEx2IShFpO1K4oV13yu
         iqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=58p9uFjWmpCFDMR48fg0NW3P4SQ0InNf8hSLgO2E5y0=;
        b=psZetyqj5PUclw7ic3siXK0kWi/ZBajlDb1deSfausXDcPAbBBRuCb8oaWIVqWX4if
         c8QfxP+7MSasIt77X95IQuQkWTss/8SAK9MYhrG+BxSFw2qHmNzZWGs2uLF2L6lcysP4
         OSpDw/xOZsg59cbh+KwX1Wfg6w/lRqHLPrPKBcGq5MLwzWp9hYpTPepwoZfaGSkKecP4
         JXENWwGDQQUZUHoGHlFtTo2L4UlaM6emg0OlxzW7K7twbFh2tXUgs3fvzY0Xz/A1jk09
         XJ0XepeLMqnIep+G3aegmcdRcC9MnX/0sV9O+9EG0E32I9jemu2K24mUlY91FeHbmGxo
         29Rw==
X-Gm-Message-State: APjAAAXCQQqwBx45DLrAe/pYUwSDIS35K8H7uIpJO/qV0AfM3dPN3r6U
        /YsTXmGBywraJRv3DS0vcP5tWby7cZlb2w==
X-Google-Smtp-Source: APXvYqxItBLqxtzO+Yw1rp1kbwyAY8BvgzlyOqnPwe3LFgNUDugvsWrcQo5yDV2eMDZoaO2lyNnH8w==
X-Received: by 2002:a1c:98cf:: with SMTP id a198mr10499483wme.51.1558960627267;
        Mon, 27 May 2019 05:37:07 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t15sm9153447wmt.2.2019.05.27.05.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:37:06 -0700 (PDT)
Subject: Re: [PATCH 10/14] pwm: meson: simplify the calculation of the
 pre-divider and count
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-11-martin.blumenstingl@googlemail.com>
 <20190526194120.uzuq6ncz5l2z4hfm@pengutronix.de>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <d51106ff-1b1e-b6bd-c17e-df9bb8536c2e@baylibre.com>
Date:   Mon, 27 May 2019 14:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190526194120.uzuq6ncz5l2z4hfm@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 26/05/2019 21:41, Uwe Kleine-König wrote:
> On Sat, May 25, 2019 at 08:11:29PM +0200, Martin Blumenstingl wrote:
>> Replace the loop to calculate the pre-divider and count with two
>> separate div64_u64() calculations. This makes the code easier to read
>> and improves the precision.
>>
>> Two example cases:
>> 1) 32.768kHz LPO clock for the SDIO wifi chip on Khadas VIM
>>    clock input: 500MHz (FCLK_DIV4)
>>    period: 30518ns
>>    duty cycle: 15259ns
>> old algorithm: pre_div=0, cnt=15259
>> new algorithm: pre_div=0, cnt=15259
>> (no difference in calculated values)
>>
>> 2) PWM LED on Khadas VIM
>>    clock input: 24MHz (XTAL)
>>    period: 7812500ns
>>    duty cycle: 7812500ns
>> old algorithm: pre_div=2, cnt=62004
>> new algorithm: pre_div=2, cnt=62500
>> Using a scope (24MHz sampling rate) shows the actual difference:
>> - old: 7753000ns, off by -59500ns (0.7616%)
>> - new: 7815000ns, off by +2500ns (0.032%)
>>
>> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 27915d6475e3..9afa1e5aaebf 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>  #include <linux/kernel.h>
>> +#include <linux/math64.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> @@ -145,7 +146,6 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>  	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
>>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>>  	unsigned long fin_freq = -1;
>> -	u64 fin_ps;
>>  
>>  	duty = state->duty_cycle;
>>  	period = state->period;
>> @@ -164,24 +164,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>  	}
>>  
>>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
>> -	fin_ps = (u64)NSEC_PER_SEC * 1000;
>> -	do_div(fin_ps, fin_freq);
>> -
>> -	/* Calc pre_div with the period */
>> -	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
>> -		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
>> -					    fin_ps * (pre_div + 1));
>> -		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
>> -			fin_ps, pre_div, cnt);
>> -		if (cnt <= 0xffff)
>> -			break;
>> -	}
>>  
>> +	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>>  	if (pre_div > MISC_CLK_DIV_MASK) {
>>  		dev_err(meson->chip.dev, "unable to get period pre_div\n");
>>  		return -EINVAL;
>>  	}
>>  
>> +	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
>> +	if (cnt > 0xffff) {
>> +		dev_err(meson->chip.dev, "unable to get period cnt\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> There is a slight modification in the calculation of pre_div that isn't
> catched by the examples above.
> 
> Before this patch we had:
> 
> 	pick smallest pre_div such that
> 		round_closest(period * 1000 / (round_down(1e12 / fin_freq) * (pre_div + 1)) <= 0xffff
> 
> New approach is:
> 
> 	pre_div = round_down(fin_freq * period / (1e9 * 0xffff))
> 
> An advantage of the new approach is better as it rounds only once and is
> easier.
> 
> Consider fin_freq = 99990001 and period = 655355, then the old algorithm
> picks pre_div = 1 while the new picks pre_div = 0.
> 
> I didn't continue here to check which are the resulting waveforms, I
> assume they are different though.
> 
> As there is currently no definition what is a "better" approximation for
> a given requested pair (duty_cycle, period) I cannot say if these
> changes are good or not.
> 
> And that's a pity, so I still think there should be a documented
> definition that lays down how a lowlevel driver should round. Without
> that a consumer that cares about fine differences can not rely an the
> abstraction provided by the PWM framework because each low-level driver
> might behave differently.
> 
> @Thierry: So can you please continue the discussion about this topic.
> The longer this is delayed the more patches are created and submitted
> that eventually might be wrong which is a waste of developer and
> reviewer time.
> 
> Assuming the people who care about meson don't object after reading this
> I wouldn't want to stop this patch going in though. So:
> 
> 	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Best regards
> Uwe
> 

I don't have a strong view on this, Martin showed similar or much greater
accuracy in the 2 principal use cases of the driver, so I'm ok with it.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
