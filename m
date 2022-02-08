Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3A4ADD18
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Feb 2022 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381209AbiBHPkU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Feb 2022 10:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381355AbiBHPkT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 10:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC076C0612BB
        for <linux-pwm@vger.kernel.org>; Tue,  8 Feb 2022 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644334816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3+ygx7WT3LgjARaNLFe1zhALwKjcISILkzjd4t3g78=;
        b=QrBnP80borMCiE9iMIYH0/RL+5dFSfYpD2wxs02qMZFaeCYJRgeAuHDrlEpf8YzRGS2Y0T
        +jgpSyp+MOifsvLvBjyA+TvQCSoSjXRkKHGPvFMUNEGDrGXTiVsONPs/yz7yChXnMvjEAS
        9nF+157J6zhEEr8TrSh2SjNhn0OF0z0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-jx8Spqh7MvCwhjYSt3_oEQ-1; Tue, 08 Feb 2022 10:40:15 -0500
X-MC-Unique: jx8Spqh7MvCwhjYSt3_oEQ-1
Received: by mail-wm1-f72.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so1200729wms.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Feb 2022 07:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R3+ygx7WT3LgjARaNLFe1zhALwKjcISILkzjd4t3g78=;
        b=xh5MojUYKNTVo44vUbV/6LLhizop1IFQjnCzVxvrjQ7Pe+fONeedxZ9RMXdn3vh7Lf
         IA1O5zxWsZaKvMkJiP62KdKs7MxOlJW3PFD6luR4Cxvd0UjmHj0HY+ZVJsdYQtQlQVSu
         2LJQihN9e3AADwGCYaETu56cfYeLzqD6cfB9XmSPQ+chvk9GFGfv9OVbZOZOg0AEVvtI
         iD/A/vTsElh8KD7kFuTJaxwISbad6jwlFwofrF5TvFIxUFAgWQ80F/d9dVHCw0sBAfqp
         IEIeGUvLWtL6VBlTow+t0vhCVCgjZAV9fsPs0hfqGhkU0EV01m19x9GtY3m70cnmu50Y
         PCNw==
X-Gm-Message-State: AOAM531H29elOcfO9gmr4thP60ZjEXg2weaWMY701mGQIW18Pwf/JKIF
        lLe1EgPUo/CJlhLFvgkaCDuNRO2ETLz8XDmInAAt4EaCRclNcU6FxlbAv70mO5p7H9TDRwqpwPK
        XFeJk1SVT8ygn2v8iRNmV
X-Received: by 2002:a5d:588e:: with SMTP id n14mr4244923wrf.45.1644334814512;
        Tue, 08 Feb 2022 07:40:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgsRW+lrC/D9yn6NeNRRQqunCaYEb9CMC26g+Mn3KPfiRrXRhLKFGC8C3j1dq2BkDZsEKSLg==
X-Received: by 2002:a5d:588e:: with SMTP id n14mr4244901wrf.45.1644334814281;
        Tue, 08 Feb 2022 07:40:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v18sm9972089wrm.105.2022.02.08.07.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:40:14 -0800 (PST)
Message-ID: <02d5b225-e1a8-77f6-7e4e-18d6a1df5e48@redhat.com>
Date:   Tue, 8 Feb 2022 16:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
 <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
 <CAMuHMdWvrJip+W6ZZoO2ZURLc5CYmFno3=Sa2mL4xJE8gMzFqg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWvrJip+W6ZZoO2ZURLc5CYmFno3=Sa2mL4xJE8gMzFqg@mail.gmail.com>
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

On 2/8/22 16:23, Geert Uytterhoeven wrote:

[snip]

>>>   - The logo (I have a custom monochrome logo enabled) is no longer shown.
>>
>> I was able to display your tux monochrome with ./fbtest -f /dev/fb1 test004
> 
> I meant the kernel's logo (FB_LOGO_*),. Obviously you need to enable
> a smaller one, as the default 80x80 logo is too large, and thus can't
> be drawn on your 128x64 or my 128x32 display.
>

That makes sense.
 
>>>   - The screen is empty, with a (very very slow) flashing cursor in the
>>>     middle of the screen, with a bogus long line next to it, which I can
>>>     see being redrawn.
>>>   - Writing text (e.g. hello) to /dev/tty0, I first see the text,
>>>     followed by an enlargement of some of the characters.
>>
>> So far I was mostly testing using your fbtest repo tests and all of them
>> (modulo test009 that says "Screen size too small for this test").
>>
>> But I've tried now using as a VT and I see the same visual artifacts. I
>> wonder what's the difference between fbcon and the way your tests use
>> the fbdev API.
> 
> Fbcon does small writes to the shadow frame buffer, while fbtest
> writes to the mmap()ed /dev/fbX, causing a full page to be updated.
>

I see. Thanks for the information.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

