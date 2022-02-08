Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33B4ADF5A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Feb 2022 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384178AbiBHRUE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Feb 2022 12:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384244AbiBHRUB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 12:20:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1980AC0612C1
        for <linux-pwm@vger.kernel.org>; Tue,  8 Feb 2022 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644340799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvtYV1w2OGJoib9qyPYwsPmSmom8EsfjJ6qIk3HrlMg=;
        b=GTKz7n8Z9pRiMrxlwXmfbsLPhgBVRXFTXaK65uyWiHLYQixlqHwB2PSgiA2jEVmoAKkYAH
        K4n1+cfZ2edo85MbkvmNxAEwtxR00L/GgDm0Fm+KmCVkYc6nKafkc7NLZ0Gl1m+fzI6tof
        nF5ctuQB/jE186AvPm9r4KGBcjvwa3U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-l0fll0KiM22hROFa9x-pdQ-1; Tue, 08 Feb 2022 12:19:58 -0500
X-MC-Unique: l0fll0KiM22hROFa9x-pdQ-1
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso821912wmb.6
        for <linux-pwm@vger.kernel.org>; Tue, 08 Feb 2022 09:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=gvtYV1w2OGJoib9qyPYwsPmSmom8EsfjJ6qIk3HrlMg=;
        b=7LUE8cUN17/Yk73QuxU0xyPdJjQkNeF6MnJqo+NDtXapcpnPP3HIRO82yYBqKrKhsR
         2wVqgr9raxktr5veg4F6tgR94dF/s9SforeFkYKLvpIAeBUDMv70IIh8yzdWpVjHdWQA
         avWjvOOdS3FmvSz1lsCDTeEFAC6Qk6PDwKsqS26yf7Iz0s0LWvVSppMpPynmEDitsGXm
         HdOjkiDmVxOlbmOWV48aW3VlJlwazBZWl1mh1VfTnAZrAOlDX8e8TMkPKCJ/Q2I12Sz9
         BddJdNwcijDDALppZNEFQ0wrSB+jy4tCSuY8IHebuS9/NChAacO0T38VnXxLJfGj13cO
         FvXg==
X-Gm-Message-State: AOAM531+TMf/XnNgz4tv2yAKV2wQ4FKAiGdhYHAraPKBf5M9zYTU8xak
        WD7/cTZJ/T17wyyUmSyCfzKywH4MrnC8xqCcpvS5FVXKi0LUACt4a9qltXMWyAGWciFHROOHOwv
        kUl+cGBgmyGNSY2lIeNKS
X-Received: by 2002:a05:600c:4e4f:: with SMTP id e15mr1970588wmq.53.1644340796898;
        Tue, 08 Feb 2022 09:19:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCtP21kxl63t75zqIHQ/e55SNAp8JmtgJLzIfz68aaypGLhZPiKZoSOCdl+lNIIxOdEqmTpg==
X-Received: by 2002:a05:600c:4e4f:: with SMTP id e15mr1970578wmq.53.1644340796715;
        Tue, 08 Feb 2022 09:19:56 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h17sm2393719wmm.15.2022.02.08.09.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 09:19:56 -0800 (PST)
Message-ID: <bb474101-eaa4-e815-0fa0-7adba3d56925@redhat.com>
Date:   Tue, 8 Feb 2022 18:19:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
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
 <02d5b225-e1a8-77f6-7e4e-18d6a1df5e48@redhat.com>
In-Reply-To: <02d5b225-e1a8-77f6-7e4e-18d6a1df5e48@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2/8/22 16:40, Javier Martinez Canillas wrote:
> On 2/8/22 16:23, Geert Uytterhoeven wrote:

[snip]

>>
>> Fbcon does small writes to the shadow frame buffer, while fbtest
>> writes to the mmap()ed /dev/fbX, causing a full page to be updated.
>>
> 
> I see. Thanks for the information.
> 

I found the bug. Partial updates where indeed broken and only a full
screen update was working. I didn't notice because where using your
fbtests that mmap and do a full update.

Thanks a lot for reporting this, the issue should be fixed in v3.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

