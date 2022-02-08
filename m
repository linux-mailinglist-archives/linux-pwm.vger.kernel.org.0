Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909FD4ADC14
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Feb 2022 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379509AbiBHPK6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Feb 2022 10:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245039AbiBHPK5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 10:10:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B6ECC061579
        for <linux-pwm@vger.kernel.org>; Tue,  8 Feb 2022 07:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644333054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEdNY3YBugunq8yXpBBABtVIZDrmoxsBt8YDexXqqEo=;
        b=ASvoJxYo9vPV7gZdwqRDokLdmB6sQfHMa6ZZU+clWuu+1uMngawhe3FtvRyBqxs+BNPNED
        BGbZdx93DiOi64TQIC8W2+LFKActIutOUf5ubWgPIne00Qbs326Xe/M8LLdi/2wGyY8nsY
        1vY07UqxcYGutO+9l6TV97k9JzeVH/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-JF5tB0NxPriUDO8MXnjpPQ-1; Tue, 08 Feb 2022 10:10:53 -0500
X-MC-Unique: JF5tB0NxPriUDO8MXnjpPQ-1
Received: by mail-wm1-f72.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so1167340wms.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Feb 2022 07:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zEdNY3YBugunq8yXpBBABtVIZDrmoxsBt8YDexXqqEo=;
        b=GjyjtNH7Pzto1XYCW98DFNKvG9Wg6wJ+K5DHEyJJ8Fhkajb9ZFzbGcwSkS14Dr5S4B
         4hqZlfYaIomIpNVnXwp8uGIV8tqjqYue8N8A/CZmjOMZ3ybU+mcva4MUMRUR4f6eZ3Qo
         qNs10reRo/6vyDx3Gd6cUgIIL0ujoJasQkqD5jSTR9EiHBz8hFpjPAjiZvXgoIbo/OkB
         Lm8s3GV9hUEy6DAPUI2RNYJyBwWT0wQE8TKGUabCPUcIzlke3oa/AIfWnLZgn/RSTns2
         kATjkuO5sWm8LdNOpwEkZmC+9XZUMDehRzGa/nFTXDjYdKlu3SvOQg94mL+rtFNMKvnm
         isJQ==
X-Gm-Message-State: AOAM533ROybkxh4ytTlcWFvo4gBKalggvq0JK1m5UimkqBfk4OMH2CBy
        fD0BbV27794r7yKd57pHkaVBBd7Pd+K3W9LaxcO1H+3fVou+11SRxL/J4yJLqCZC+B/GfRigbVH
        qOl3lI2fbjisjKDopFFBd
X-Received: by 2002:adf:ef10:: with SMTP id e16mr3652224wro.428.1644333051932;
        Tue, 08 Feb 2022 07:10:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFW9XXEiShgJBRMmm2UkmN1bA7P1SHblO06AiaMNERAOilbmNeV2HVlkYhh60Zpx3AWddEMQ==
X-Received: by 2002:adf:ef10:: with SMTP id e16mr3652206wro.428.1644333051654;
        Tue, 08 Feb 2022 07:10:51 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n13sm2601507wms.8.2022.02.08.07.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:10:51 -0800 (PST)
Message-ID: <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
Date:   Tue, 8 Feb 2022 16:10:49 +0100
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
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

Hello Geert,

Thanks a lot for testing!

On 2/8/22 15:19, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Fri, Feb 4, 2022 at 2:43 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
>> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
> 
> I gave it a try on an Adafruit FeatherWing 128x32 OLED, connected to an
> OrangeCrab ECP5 FPGA board running a 64 MHz VexRiscv RISC-V softcore.
> 
> Findings:
>   - Kernel size increased by 349 KiB,
>   - The "Memory:" line reports 412 KiB less memory,
>   - On top of that, "free" shows ca. 92 KiB more memory in use after
>     bootup.
>   - The logo (I have a custom monochrome logo enabled) is no longer shown.

I was able to display your tux monochrome with ./fbtest -f /dev/fb1 test004

>   - The screen is empty, with a (very very slow) flashing cursor in the
>     middle of the screen, with a bogus long line next to it, which I can
>     see being redrawn.
>   - Writing text (e.g. hello) to /dev/tty0, I first see the text,
>     followed by an enlargement of some of the characters.


So far I was mostly testing using your fbtest repo tests and all of them
(modulo test009 that says "Screen size too small for this test").

But I've tried now using as a VT and I see the same visual artifacts. I
wonder what's the difference between fbcon and the way your tests use
the fbdev API.

>   - "time ls" on the serial console (no files in the current directory,
>     so nothing to print) increases from 0.86s to 1.92s, so the system is
>     more loaded.  As ssd1307fb relied on deferred I/O too, the slowdown
>     might be (partly) due to redrawing of the visual artefacts
>     mentioned above.
>

I was trying to first have the driver and then figure out how to optimize
it. For v3 I'm using regmap to access instead of the I2C layer directly.

I noticed that this is even slower but it makes the driver more clean and
allows to support both I2C and SPI (untested but will include it as a WIP).

> So while the displays seems to be initialized correctly, it looks like
> there are some serious bugs in the conversion from xrgb8888 to
> monochrome.
>

Yes, that's possible. I haven't tried to use it as a console before because
the display resolution is just too small. But will include now in my tests.

> Gr{oetje,eeting}s,
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

