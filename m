Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0774A6D09
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Feb 2022 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiBBIi6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Feb 2022 03:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245043AbiBBIi4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Feb 2022 03:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ96plJnExVz4IofZgZgy11FIOo1veP7nuoBU4KJMcA=;
        b=BQmHESqj7So+lESTgNlrXx12KcqJ3SGlSnqbUdeIlnOt3tKjzBvXxDV41RnR54R0yfUfJu
        06JSlQkc7butqaeEC/TdQ5eYG6XMhfZ5Ywga6YikkPbmvlchYrs9qMwMh2bDRLSn21JkoT
        /d9U9GsE9K1hS1tBz4jgxYb70LQz5Vc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-x3TdfoXMOQG5SN8SFOSUhw-1; Wed, 02 Feb 2022 03:38:54 -0500
X-MC-Unique: x3TdfoXMOQG5SN8SFOSUhw-1
Received: by mail-wr1-f70.google.com with SMTP id i25-20020adfaad9000000b001e01f5804abso3955281wrc.2
        for <linux-pwm@vger.kernel.org>; Wed, 02 Feb 2022 00:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IQ96plJnExVz4IofZgZgy11FIOo1veP7nuoBU4KJMcA=;
        b=qc+PXVUtuF8kMxiYKIC8rQOnmktvjyWPAJMiM1psKFEsJ1crwCIGz9uG1wolLydntm
         DM8jaR+UE3AJUo4oJWnZxcbR1MxGcgQ3QtqjjgXrDcSwhS4dpFi+VrcZTVZNdmlFlwH8
         jBfFk/XKAzuxtIFYc84xQXjb7ZGBuaLr8Q7HHKsIODF58uvxTqiO0xUe09PEDHqXKUDU
         LRu09/PeNbg+NsI79kWMI7KLCiPIaakroM/x47LKtIUh+oaF5GQH85FZTvUDasUNAoXp
         bXXT4xPog/yInzw6oAcNRC6eB2rjMTJbDtRtsfEoQyPMrOeQZT01WaFXtniQ2W6O+iz/
         dcqw==
X-Gm-Message-State: AOAM530YrrqU7zCktCrFR9L7O+aL4GUDJxhS8yEfeUjf3w22KBoN4UNw
        4oDNj551Zcq0VUUsdZb0scqM3GBSkefLoEmBkbnaoRZQYfnxlJzvLfYAr2lmC1xhMTWfkOBwTnf
        pPJlZhYvE5WNDW6IHEyOh
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5150568wmj.59.1643791133573;
        Wed, 02 Feb 2022 00:38:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC9orog6Z8LfxDGH06ODz7grjUoMzfg+w2FlDgm3DeIkMP38HoKyw95IAqRi1WUhNTRJi28Q==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr5150546wmj.59.1643791133371;
        Wed, 02 Feb 2022 00:38:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z17sm3963598wmf.47.2022.02.02.00.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:38:52 -0800 (PST)
Message-ID: <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
Date:   Wed, 2 Feb 2022 09:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfmaqUBqCrgp0QdO@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Sam,

On 2/1/22 21:40, Sam Ravnborg wrote:

[snip]

> 
> I took a look at the datasheets - and all ssd1305, ssd1306 and ssd1307
> are the same. They have timing constrains on the Vcc.
> The random schematic I found on the net showed me that a PWM was used to
> control the Vcc voltage - which again is used to control the brightness.
> 
> All the above has nothing to do with backlight - I had this mixed up in
> my head.
>

Yes, same here. I was leaning towards fixing the DT binding but then due
Geert comment and after reading the datasheets for ssd130{5,6,7} like you
I had the same understanding.

Glad that you agree.

[snip] 

> 
> Last I recommend to drop the fbdev variant - if the drm driver has any
> regressions we can fix them. And I do not see any other way to move
> users over. Unless their setup breaks then they do not change.
>

As I mentioned in this thread I wouldn't propose to drop the fbdev variant.
I prefer to use the carrot and not the stick. Peter Robinson suggested to
make the driver mutually exclusive and add !FB_SSD1307 in the config symbol.

I think that makes sense and will do it in v2.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

