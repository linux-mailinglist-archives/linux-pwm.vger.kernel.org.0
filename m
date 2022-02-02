Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051294A705D
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Feb 2022 12:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbiBBLyh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Feb 2022 06:54:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231839AbiBBLyg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Feb 2022 06:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643802876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bL5rgnJNtTCmd2esmcO6OG/N+9v3ttozfnd4SZakfGQ=;
        b=hcaa9dCAp+0ejVhy5Si3NvBgyZAOq3Yq7JwkNYlaEUnEcJ0B0cFGKL+0X+qKFT0jMmqYr/
        9CRRXeSTTiIWCQp2RDx8U65N6TLrQgm712aZ7hzzEQNhRIZAhI1nFbG8ZRq0mxmyWq9i2/
        NR1gv90BlL150MxQnr9KRJaf2kUnWoY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-4Uoq02A8P1Ojm6hJje50kg-1; Wed, 02 Feb 2022 06:54:35 -0500
X-MC-Unique: 4Uoq02A8P1Ojm6hJje50kg-1
Received: by mail-wm1-f71.google.com with SMTP id n7-20020a1c7207000000b0034ec3d8ce0aso2382552wmc.8
        for <linux-pwm@vger.kernel.org>; Wed, 02 Feb 2022 03:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bL5rgnJNtTCmd2esmcO6OG/N+9v3ttozfnd4SZakfGQ=;
        b=2z2mf4Tg+5sV+kH7C9RPR8odp309tPUJgXJdZ1pwnnUNKfej3L5wpzBqxYHrJinawD
         PABGIbeVRx2F/71zxDYQNUh4xHDTnE44R80GFY6MUwk/uW7XsH4Jl/1O7BHpBDhpFJY1
         gsUxCp3nOTRc4mlLELUnXj4FBpr0250mKgp27VuZGlhDOwk7ZXG5/yR/+Pe5o9bQVusW
         aS1IGc+c3VpKOYoLt2AWW5/CuoxqXcfFzq6iFwwqHLaMDQ/ghMQda26zROvivsHFuHUL
         sFrrJxWNlzbENy5Gi0kn8kj2YX20RCuVIy+CPO2kvQIO80p8iIrlv2ABxdktUGfBPr2l
         NqWA==
X-Gm-Message-State: AOAM530eq5tWl5re3IK5cmr6xGpwd22VpesCaMRtKm93ZyagdaQpCAOv
        7dgb8/qkmyHHLP79QMHGhQ0a7rZGe0egHIPVGBjnN0+N8mQNoOtIYpeEqQA1RbvvWpz0qXZ2CUR
        TykRTSZsPzENuiyahk3Lh
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr1969719wry.191.1643802874129;
        Wed, 02 Feb 2022 03:54:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9uaj1noGIyEUrpXHbn9QwweYL02b/7HPtTFauTRqXOp7zTH9jXowWwcKexaK5dPFtRxWRqw==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr1969689wry.191.1643802873900;
        Wed, 02 Feb 2022 03:54:33 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j5sm1444854wrq.31.2022.02.02.03.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 03:54:33 -0800 (PST)
Message-ID: <a3a06362-ab9f-e29b-4f03-968e3f1865ba@redhat.com>
Date:   Wed, 2 Feb 2022 12:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
References: <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
 <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
 <YfploeCM6C5y3Imj@smile.fi.intel.com>
 <2f149fef-b991-9e34-98cb-426e561192ff@redhat.com>
 <YfpwGtjj5hGkN7A4@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfpwGtjj5hGkN7A4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2/2/22 12:50, Andy Shevchenko wrote:

[snip]

>> What's your suggestion then to solve the issue mentioned above ? With my distro
>> maintainer hat I don't care that much, since the fbdev drivers will be disabled.
> 
> I think both of them can work together. If user doesn't care, the first one wins.
> 

I don't think this is a good idea but as mentioned I don't really care that much
since we will disable all fbdev drivers anyway. So I'm happy to allow them both.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

