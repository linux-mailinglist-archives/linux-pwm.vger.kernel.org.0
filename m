Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27014B87C9
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Feb 2022 13:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiBPMfB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Feb 2022 07:35:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiBPMfA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Feb 2022 07:35:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB491F8372
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 04:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645014884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fu6TzmgbMlYQuSDAMHkyuQBli3G2K2SmS218sexp9ic=;
        b=OqMVeVekI5dJZIS5uPp2kdfQGRk8GfuHRpjZo7/AFVgxMJxiWHkbHSb71j7sTyY5hlGgNc
        LYWgZpIL4D80ZR5qtlfYsVjH8RJDBKw2um3Nk6xeHl7epdPRUf9YBU0Acqr5tbE7OcFiN5
        QZ5bD+hXlESFjTwmedJc30TEk2oLVMI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-rudX27eyMRmRbGidgkuJBw-1; Wed, 16 Feb 2022 07:34:43 -0500
X-MC-Unique: rudX27eyMRmRbGidgkuJBw-1
Received: by mail-wm1-f70.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso1801555wmz.0
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 04:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fu6TzmgbMlYQuSDAMHkyuQBli3G2K2SmS218sexp9ic=;
        b=Q7kecOIC7nyFus6ToAQ5xymtst+R13QDVs2LKK0ODS9mmlTWD7/a5M4V1PqsgWuATY
         00Hb3+lH8YxeXNB9cJQU6THxKk0rrwR5kD0WyhDLNHqZh4nkUI+JSoUXPdrgslAaq7VQ
         5XpbYqWdV7JdKlzqgc/SSQRByEXxwL7PA38lY81OM4jjmBZF8D3I63qEDY0ElXjHdkvO
         Vg/i4CRpz9IdE39qSxVQbI35U9bwvyHQMlnAO+/xsv1cYEM1mhUM9TAcKaMJoeIxH3so
         q1AHuSVAXYIHGRRFp/XSlaP2YqQKmx6VI9AIs8t+LFM4Opf3kS/qmWVieDqfC8lDi4fu
         jf5g==
X-Gm-Message-State: AOAM531xkAZmd7dGGL5L0YoR5HWV4y7QebaMbkmlpSTawn2Bsjj13Vt8
        rfA7SN/PYXkQuTph+0eH/zWmal1ZU0ikqmnO8iVZX+iZTR4RKdJx0e6fp4NiInjD6bUTaZeEnRo
        0FK74e37SWr+3WorJOfUt
X-Received: by 2002:adf:f005:0:b0:1e3:1957:af07 with SMTP id j5-20020adff005000000b001e31957af07mr2203689wro.311.1645014881498;
        Wed, 16 Feb 2022 04:34:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJww2pEBjWX6+qG9snaBEnYCCDQh6YGaz6Dcc7r7r2Rqwhne1V8moyLnyuF2IvLxEM9om9CJGQ==
X-Received: by 2002:adf:f005:0:b0:1e3:1957:af07 with SMTP id j5-20020adff005000000b001e31957af07mr2203675wro.311.1645014881239;
        Wed, 16 Feb 2022 04:34:41 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12sm32213684wrs.11.2022.02.16.04.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 04:34:40 -0800 (PST)
Message-ID: <2d0e88a3-8fa2-6b21-93da-1c9e6f8e3e84@redhat.com>
Date:   Wed, 16 Feb 2022 13:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 0/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220214133710.3278506-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2/14/22 14:37, Javier Martinez Canillas wrote:
> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
> 
> Using the DRM fbdev emulation, all the tests from Geert Uytterhoeven repo
> (https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes.
> 
> I've also tested it using the display as a VT output and even though fbcon
> seems to work, it is mostly unusable on a 128x64 SSD1306 display.
> 
> This is a v6 that addresses the issues pointed in v5. Thanks a lot to all
> reviewers that gave me feedback and comments.
> 

Pushed this series to drm-misc (drm-misc-next). Thanks all!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

