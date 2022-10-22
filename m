Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37450608F41
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Oct 2022 21:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJVTfb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Oct 2022 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJVTf3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Oct 2022 15:35:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66013645F1
        for <linux-pwm@vger.kernel.org>; Sat, 22 Oct 2022 12:35:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso3939642pjz.4
        for <linux-pwm@vger.kernel.org>; Sat, 22 Oct 2022 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHMj5gP50YkDnVtpzbnoFnxAZpOBc2+tzU5B6MVDdlQ=;
        b=EFs8gZZuAc/O2PsMWiw/HMOkf5HCphClEdS3/450t7OB4UxnvNyQUlLd3ieDeoiS7W
         FhMuSYQJ/c7cTyEja0yxqznCiDC2aePMJ0jIegVWL7x7OkdrD0lIbZ9xGv+4yYu1LIN7
         d8Cgn36EDR2sYzxEG6BLE77AmGfFOOOh4bClo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHMj5gP50YkDnVtpzbnoFnxAZpOBc2+tzU5B6MVDdlQ=;
        b=ds7ccrZCIxEWHRc4aRtKwHhB/zMXYJKOec25/CoWX32pjNy5oJwe5wmCZFFZSRtwhi
         msOWj5hP8GZq6RNtqY2+tjVXxL4rzd5bufOgPIwMafbKArIqEBrxm6hgyn/p59lULN7T
         fZoxLMr9LLPYUtlkRFrnfzWg5wL5MTdR3r0SuYcTl9LWcjWaimtLm7gqlimtm5mQxNHq
         Lg4I2tcyErCOfoEkEVzbEadynAHQJl2ZcR1WRrkujeyY6QIthwIBQzjve4JIxBuNLdKP
         47cTomSPAe/v92x8PCYdIL44SM+/zV5trEyyJ+RI6TfQftpWFxg5PpUFOrK23kZrVVvX
         8IVw==
X-Gm-Message-State: ACrzQf0hCJIMNPxM6OazfyoA4i4uVAiA5a+ZIzXJ2t4gEuKHNxXxI+NV
        f5zABej+ZyzGoxjtux5LOl75Sg==
X-Google-Smtp-Source: AMsMyM4d9hENdAtejRBCm7znm3f+8BMf4kvsub8C4CdT2WgdTqkQsqysWSarb5tX0pwtPZ+YAquxVQ==
X-Received: by 2002:a17:90b:2751:b0:20a:e437:a9e8 with SMTP id qi17-20020a17090b275100b0020ae437a9e8mr64190149pjb.181.1666467326631;
        Sat, 22 Oct 2022 12:35:26 -0700 (PDT)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id v15-20020a17090ad58f00b002036006d65bsm3435734pju.39.2022.10.22.12.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 12:35:25 -0700 (PDT)
Message-ID: <a9c974f1-fc66-b964-c7f0-b7e4320f2177@schmorgal.com>
Date:   Sat, 22 Oct 2022 12:35:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-5-doug@schmorgal.com>
 <20221019073929.3abj6ohhcreifyso@pengutronix.de>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 4/5] pwm: pxa: Wait for final PWM period to finish
In-Reply-To: <20221019073929.3abj6ohhcreifyso@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 10/19/2022 12:39 AM, Uwe Kleine-König wrote:
> On Sun, Oct 02, 2022 at 06:55:45PM -0700, Doug Brown wrote:
>> If the clock is turned on too quickly after being turned off, it won't
>> actually turn back on. Work around this problem by waiting for the final
>> period to complete when disabling the PWM. The delay logic is borrowed
>> from the pwm-sun4i driver.
>>
>> To avoid unnecessary delays, skip the whole config process if the PWM is
>> already disabled and staying disabled.
> 
> I wonder if there is some documentation available about this issue. This
> feels like a workaround without knowledge about the details and so might
> break at the next opportunity.

Thanks for reviewing! Yes, it does feel like a crazy workaround. I'm not
super proud of it. The best documentation I've been able to look at is
the PXA168 software manual [1]. Page 502 of the PDF talks about a
"graceful shutdown" where turning off the clock enable bit doesn't
immediately stop the clock, and instead it waits for the current PWM
period to complete first. This driver is currently configuring it for
graceful shutdown mode, because the PWMCR_SD bit is not set (page 1257).

I've experimentally determined that if you try to turn the clock back on
when a graceful shutdown is still scheduled, it doesn't cancel the
graceful shutdown, so the clock ends up off afterward, even though the
common clock framework thinks it's still on. The hacky delay in this
commit works around that problem. This almost seems like a problem that
should be solved on the common clock framework side instead, but it
doesn't know what the PWM frequency is so it wouldn't know how long to
delay.

Do all the other similar drivers in the kernel do a graceful shutdown
like this when they are turned off? If not, a simpler solution would be
to start turning on the PWMCR_SD bit instead, so the clock stops
immediately (potentially resulting in the final duty cycle being short).
I tested that change in place of this commit and it seems to work pretty
well, although I can still cause it to fail if I turn my PWM backlight
off and back on quickly without a "sleep 0.000001" in between. It feels
to me like there are some weird interdependencies between the clock
enable bits and the actual PWM controller block, at least in the PXA168,
likely due to "graceful shutdown" mode's existence.

What do you think? Turning on the PWMCR_SD bit would be very simple, but
it doesn't fully fix the issue in my testing. I'd still be okay with it
though, because the only failure case I can reproduce is a minor edge
case (plus, I don't love the delay solution).

> 
>> [...]
>> @@ -122,6 +127,18 @@ static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	if (!state->enabled && pwm->state.enabled)
>>   		clk_disable_unprepare(pc->clk);
>>   
>> +	if (state->enabled)
>> +		return 0;
>> +
>> +	/* Wait for the final PWM period to finish. This prevents it from
>> +	 * being re-enabled too quickly (which can fail silently).
>> +	 */
> 
> Please stick to the usual comment style. i.e. put the /* on a line for
> itself.

My bad, thanks for pointing this out. If this comment still exists in
the next version of the patch, I'll fix it.

Thanks,
Doug

[1] 
https://web.archive.org/web/20160428154454/http://www.marvell.com/application-processors/armada-100/assets/armada_16x_software_manual.pdf
