Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4659B4D3ADB
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Mar 2022 21:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiCIUPu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Mar 2022 15:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiCIUPu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Mar 2022 15:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC2A3366BC
        for <linux-pwm@vger.kernel.org>; Wed,  9 Mar 2022 12:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646856890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbuX/KcuT6SLK06TjipzKmC4j8Z46swn7ffrS8FTipc=;
        b=WjtioXeFx0DGsVNcBks1pcxAt2iA5ou4fb5b1u1wWa0UQjY5JbL+jeq7ksrvNHlvseKAML
        rJEAjplc//Rvrp90cYftvTGouD2EpfvXaKiIb0V2IT4dDceYtP0x1oIxBbZFBlCmdicYHZ
        rlCoH0lhF36F/d6voBtCwtXEfHZ9xpI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-CXLLXaBMO9WUEEtR-LHHWA-1; Wed, 09 Mar 2022 15:14:49 -0500
X-MC-Unique: CXLLXaBMO9WUEEtR-LHHWA-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso3054163wmh.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Mar 2022 12:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IbuX/KcuT6SLK06TjipzKmC4j8Z46swn7ffrS8FTipc=;
        b=keMqmFtyhfykdy7gGZtVEbTMhHBB41IzqfqQpCPjngwpxWbLoePCf8LawRzN9iqNpu
         NWkHn/Y2eTjDFE7hVn3MF39ZvlqSYHK1cfhHmGQvQSbfEPjqWRVvJMn0AStvOx/FDZup
         uRDunTkdb3rye1nQzK1zzyUmXuy2MylGpdeXjjO2z9JUVISF3mYH0CmodMK/HNi8+bNY
         R0mjVEnoE+ptSp7+GHWpY3qOwxs7wt7PHpNGnBvScwOUt5sbOYZuIFL7YEkuaw3Trmtx
         atATP0PXhmUcV/pckAtTki9YEE1JtWs1yMbHcNwNSm8UGpujyxnSuhHYP2A/iM8DPwVk
         g3cg==
X-Gm-Message-State: AOAM5338cDVkJgiYOIgleVoY/oe/yAs8wpAX97oPTS7ZrWTWbs2ojjMV
        wk4kZ4UXB9EyOw0gjHyfJ4QgEpGYq/8XOD6VMSYxKR6mQmFS0CO/HBDeQjr0I0sY330IkSsSEyM
        edWMlEmrkXaga/as/Amt5
X-Received: by 2002:a05:600c:508:b0:389:8dfd:7994 with SMTP id i8-20020a05600c050800b003898dfd7994mr863606wmc.115.1646856887710;
        Wed, 09 Mar 2022 12:14:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyepWTtYPUTkB3MsGPzD36ku1cklArD4cEY/LhV7qmnXuX8mjfZUZo8/4jccrD5xCfv5ZW5kg==
X-Received: by 2002:a05:600c:508:b0:389:8dfd:7994 with SMTP id i8-20020a05600c050800b003898dfd7994mr863576wmc.115.1646856887407;
        Wed, 09 Mar 2022 12:14:47 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b00384d42a9638sm2742260wma.2.2022.03.09.12.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:14:28 -0800 (PST)
Message-ID: <8770f564-921e-b4e7-5ca4-ad05c46d2baf@redhat.com>
Date:   Wed, 9 Mar 2022 21:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-4-javierm@redhat.com>
 <CAMuHMdUuTAsqpx4=WnosfyjLo-t9ryQPQMaE1OeMBk4Ws9DTpQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUuTAsqpx4=WnosfyjLo-t9ryQPQMaE1OeMBk4Ws9DTpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Geert,

On 3/9/22 21:04, Geert Uytterhoeven wrote:

[snip]

>> +
>> +               /* Last page may be partial */
>> +               if (8 * (i + 1) > ssd130x->height)
>> +                       m = ssd130x->height % 8;
>> +               for (j = x; j < x + width; j++) {
>> +                       u8 data = 0;
>> +
>> +                       for (k = 0; k < m; k++) {
>> +                               u8 byte = buf[(8 * i + k) * line_length + j / 8];
> 
> As buf does not point to (0, 0), the above is not correct if rect.x1 !=
> 0 or rect.y1 != 0.  After fixing that, writing more than one text line
> to the console works, but I still see an issue with updates where the
> rectangle size and/or position are not aligned to 8 pixels horizontally.
> Will do more investigation, and send fixes...
>

Right, I believe this is a consequence of introducing shadow buffers at
some point and not adjusting the logic in this function.

Thanks a lot for tracking down the issues and working on fixes for them!
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

