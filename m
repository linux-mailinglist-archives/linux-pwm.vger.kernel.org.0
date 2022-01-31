Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511E94A5354
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Feb 2022 00:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiAaXiF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jan 2022 18:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbiAaXiE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jan 2022 18:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643672283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3CTm7Bs/ix/5LXGiIgLCJVvM0GoznV6Mmk0dN1zWSQ=;
        b=WmMhPbWNL6RIu+D8D2PYYAsAcaHZyYDUGEDHqBfBXBOlgox+XDai7Oxe6c4tCrgI+NLHni
        SOhu51pG/KZ7kN1uFXKfftJNOvtUi4PtHAfOKdt+VCzm2YlvUu71BIibE5BZ8pLqkNvfYO
        JQqXiJ9HoaEWPnOj+5nzvf6OzozrUng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-G6NF4BHEMEmK4meqETsAXA-1; Mon, 31 Jan 2022 18:38:02 -0500
X-MC-Unique: G6NF4BHEMEmK4meqETsAXA-1
Received: by mail-wm1-f72.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso443880wma.6
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jan 2022 15:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C3CTm7Bs/ix/5LXGiIgLCJVvM0GoznV6Mmk0dN1zWSQ=;
        b=uQLWdvf7pktEdtV4+ESWRhAzI/hgcW3rO7jXSPsysXeJlAlsiwQYPN0R17xbORPy9y
         e0zdbRAd9qI5ljs+Ankg+EvzRAwEaVgLRwJQHc2kN2uXURoXq9CFZsFsB42CmjdhduUK
         /A5Lbdo9B7YcvBxeBshbVkcG7Sx1kBatBcAW5vPz+HN1c18ZSGHarGfRhyBmzXSCTsOA
         p8LSBuvQUPQmbYudL63mz6HO78nVdP4/gkdlQuhf1WOkyRrV5g2KGqJhDMv8pfxGu1YB
         bjwMC7c7L3RqecQddKMwAX+wEII2oNRVo7Q7uCCHKjrhd/7NjDkDc1EGbUGp18JcqDQV
         5ahw==
X-Gm-Message-State: AOAM5309AE70PrwTRr3U8Gmvw/F91RPSJDN4dDJvXGYCQS2XsiBnMZ9w
        RTXMiKS4yWIhx05Royv/W1n286VUg9xkknpIWc6WqZGrnu89yAcrjcXpxQIHeEkHFYiInfDx11L
        gPPOf+VKosxOFnUZku4FS
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr19192569wry.94.1643672281298;
        Mon, 31 Jan 2022 15:38:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVQSH23aLGjRqSo4FwmBefiCFx1sZwod/Bbj1r+ksyBNqib6t/bplSkWRXeqqfzdh6Ym8gbQ==
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr19192561wry.94.1643672281120;
        Mon, 31 Jan 2022 15:38:01 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 8sm603298wmg.0.2022.01.31.15.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:38:00 -0800 (PST)
Message-ID: <0924dfdc-a8c3-5e0f-9362-6c27811b4bd6@redhat.com>
Date:   Tue, 1 Feb 2022 00:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfhM97cVH3+lJKg0@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 1/31/22 21:56, Sam Ravnborg wrote:
> Hi Javier,
> On Mon, Jan 31, 2022 at 09:12:20PM +0100, Javier Martinez Canillas wrote:
>> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
>> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
>>
>> Using the DRM fb emulation, all the tests from Geert Uytterhoeven's fbtest
>> (https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes:
> 
> Impressed how fast you did this!
> Saw the picture you posted a link to on irc - nice.
>

Thanks :)

What's impressive is how many helper functions the DRM core has, so typing a
new DRM driver is something that could be achieved in a few hours. Which was
one of my goals with this experiment, to understand how much effort would be
for a developer with no prior experience with DRM to port a fbdev driver.
 
>> Patch #3 adds the driver. The name ssd1307 was used instead of ssd130x
>> (which would be more accurate) to avoid confusion for users who want to
>> migrate from the existing ssd1307fb fbdev driver.
> Looking forward the name ssd130x would make more sense. There is only so
> many existing users and a potential of much more new users.
> So in my color of the world the naming that benefits the most users
> wins.
>

Agreed. That's also what Andy suggested and makes a lot of sense to me.
 
> 	Sam
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

