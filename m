Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348D4AF688
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Feb 2022 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiBIQ0F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Feb 2022 11:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbiBIQ0D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Feb 2022 11:26:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43153C05CB88
        for <linux-pwm@vger.kernel.org>; Wed,  9 Feb 2022 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644423965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9tzfRXX9aIJ3ddS/ncBHLRQCL4mho0HZX6VdWoJ+48=;
        b=bD/01IxV8Gfo6Ps5+btDBzwNy6BzV+TEssYStrtPZ9hJ6no62Pcgl9F94kgkw4eTTZgoUp
        uPU7NvlVkGhpCsAWAnzBPCU1nyT/UcH55JDWSMEVAXYlyrJ8PGB7L87O3/0zHzg5pl/dSY
        GOZ7iRqByp6zGoUA1aB3+q/lFrP3Ld4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-6CrH-CEdOwCi1oCS7TvWLw-1; Wed, 09 Feb 2022 11:26:04 -0500
X-MC-Unique: 6CrH-CEdOwCi1oCS7TvWLw-1
Received: by mail-wr1-f69.google.com with SMTP id k3-20020adfb343000000b001e463e6af20so1296526wrd.8
        for <linux-pwm@vger.kernel.org>; Wed, 09 Feb 2022 08:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T9tzfRXX9aIJ3ddS/ncBHLRQCL4mho0HZX6VdWoJ+48=;
        b=IsARu7affaIqCla1ToVK2mVeKRP70CVmADZzGtsx30VWPD1YGtRdIOUCXsIg9OMdm0
         GFJuJ03MvOS7JkAqIdXd/IYKoxhehECiCdQT+3vXX2JYFKrBjiSZGo2ROht4itkg7XvJ
         P/i94DdIFe+22xrN4KG+D8YMm4zivh23moRn1wVdWncUEJQb40ZpcmaZQP6ozIi7lMJP
         fRdKZko6d9lIVQEM+MZdAE0fyZZ6b9DAfkBNV19I769LGlGCPeF2gbesCIN9GI1a5leJ
         hJ1oPhaxtNQ+HKDeVWWn5Jbqe8HJ5jzqLT4w5+he+gzB1BNNi3Slntdi8VP0xGvMS9SW
         Qftg==
X-Gm-Message-State: AOAM531c17odwb6/a3lQN0i12QSza24vhiuJKpc+z6iHLhhA25UnuQbi
        hS23sqDWpv2iBCjWITSqHu75HYMPg1UJzTS7f5Ylbt4z+9wnd0gKkFTg/LO/p3D8AXFHGVB29tV
        QqwtQuUtaujEn/9Ys0JSd
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr2759703wmq.23.1644423962949;
        Wed, 09 Feb 2022 08:26:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKaf2S5vQEeUlpONN8Lw24iZWfuG6UcC4phWOJMjQWloR3GX0YNxop48TsjVq5kgNCNsqZBA==
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr2759672wmq.23.1644423962457;
        Wed, 09 Feb 2022 08:26:02 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p14sm17885082wrr.7.2022.02.09.08.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:26:02 -0800 (PST)
Message-ID: <406152d8-13e4-de8a-9542-bf1d96dbab0a@redhat.com>
Date:   Wed, 9 Feb 2022 17:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPZ3W0e7N7JQ1dT@smile.fi.intel.com>
 <e29eaccc-863a-21d4-e669-0b708604d723@redhat.com>
 <YgPnE0yj0Y0OJxq6@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPnE0yj0Y0OJxq6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2/9/22 17:08, Andy Shevchenko wrote:

[snip]

>> Agreed, as mentioned I'll give it a try to sending all the data as a
>> bulk write with regmap.
> 
> Ah, it might be that it should be noinc bulk op. Need to be checked anyway.
>

Yeah, I'll give it a try for v4. Let's see how it goes.

[snip]

>>>
>>> A-ha, why not in the callee?
>>>
>>
>> I think is easier to read when doing it in the caller, specially since there
>> is only a single call. Than calling it unconditionally and making it a no-op
>> if there isn't a reset GPIO.
> 
> It doesn't matter where the check is and checking that in the callee seems
> better as it relies on the reset functionality. Caller in such case shouldn't
> even think if it's supported or not, not their business.
>

Ok, no strong opinions really so I will change it.
 
> Last, but not least, if you think of power management, you probably want to
> assert reset there as well, means additional checks?
> 
>>>> +		ssd130x_reset(ssd130x);
> 
> ...
> 
>>>> +	if (IS_ERR(ssd130x)) {
>>>
>>>> +		dev_err(dev, "Failed to allocate DRM device: %d\n", ret);
>>>> +		return ssd130x;
>>>
>>> return dev_err_probe() ?
>>>
>>
>> No, because this isn't a resource provided by other driver. If this
>> failed is mostly due a memory allocation error.
> 
> Is it a problem? dev_err_probe() got update in the documentation explaining
> that's fine to call even in such cases. The outcome is less amount of LOCs.
>

Thanks for pointing out. In my mind that was a way to denote in the code that
a probe deferral was possible and that the message should be debug but now I
went and read the comment as you suggested:

 * Note that it is deemed acceptable to use this function for error
 * prints during probe even if the @err is known to never be -EPROBE_DEFER.
 * The benefit compared to a normal dev_err() is the standardized format
 * of the error code and the fact that the error code is returned

So you are correct and using it is preferred even when no probe defer error
will be returned. I'll do that here and in the other places you mentioned.

[snip] 

>>> I have feelings that half of my comments were ignored...
>>> Maybe I missed the discussion(s).
>>
>> I assure you that no comments from you or anyone were ignored.
>>
>> I may had missed something but if if I did was a mistake and
>> not intentionally. I keep a changelog for each revision in
>> the patches with the name of the reviewer so people can check
>> and compare.
>>
>> If something that you mentioned is not there, I apologize and
>> please point me out so I can address it in v4.
> 
> It's just a feeling, because I repeating that dev_err_probe() a lot :-)
> Nevertheless, now I see at least your point why you went that way.
> But see my comments on it.

And I did use dev_err_probe() in the places that could cause a probe
deferral so it wasn't (completely) ignored.

On that topic, I even typed a SPI driver because of your feedback :)

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

