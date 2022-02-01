Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5012C4A5EEA
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Feb 2022 16:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiBAPDf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Feb 2022 10:03:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239712AbiBAPDf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Feb 2022 10:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643727814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPLTvSXEJtxG27SsdT3y+GsVxpcB9uraDlu1oQaaT6o=;
        b=FctOW/9QgpLr6G1TVeutqJT5b1zOFRU2ZP5GrGpU45xkiWxtXhujMFAR9g/L15b76qYc4u
        NC2AgTxLCUWqGJxtTDwWbrSx7TwuMPL+1gNn5Uo3QrTZrqi58XuGYn3EZP3Fu5ho5j7Fkk
        3qKV4GG84DPc40AiyfkKRIggP1JY+L8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-KMjh-Gr0PYqycMQn3kqmPA-1; Tue, 01 Feb 2022 10:03:33 -0500
X-MC-Unique: KMjh-Gr0PYqycMQn3kqmPA-1
Received: by mail-wm1-f69.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so1742000wmb.7
        for <linux-pwm@vger.kernel.org>; Tue, 01 Feb 2022 07:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wPLTvSXEJtxG27SsdT3y+GsVxpcB9uraDlu1oQaaT6o=;
        b=7vrGCV+AQA4CsmfPghc/9Br35ZO4ebRhPWlWi2BqA5X5ZK+7+6tZGFZ0jb4h5ngGrV
         1m9gOIwODk8Vo5je1N8gdCVHIwT2dSGNL3Z2aGVdJLoempWLKxU5ni1PUbR/LdvU7pUB
         6ineigdupZAyHaPXrtSUkfQtZjVlVEZMs6hHVUWcPE/5EmwOm2SgcUb+mFYNJbFZfsTG
         AaR4Zjo/4bCmhOeExlyq06sSpb/1uNbi22OMeL2XfjjTIXCMqtNMYjURUZF0Ub3rnVyi
         e/QH3droQ62qNwIaTjUEHBQik9iWaX5eOIe7roO60mSjlaXN7XlXVQldUDTTZ2DYVRwj
         KLbw==
X-Gm-Message-State: AOAM531PBobQgIZepL1ahGVfWJIfQkxsPzo/3Ea7q7rr7WLOOKJrVunh
        8rhxFT6X26jNWszwTrXMqgARbH+cdNbs9Fbkdwv+UHtKFYow9N79GckTP/9lWBuo1InkEhrbtCv
        7XNUrO2fXl3ez1Mr2Liux
X-Received: by 2002:adf:f701:: with SMTP id r1mr21141480wrp.557.1643727812089;
        Tue, 01 Feb 2022 07:03:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD7IWYf2w/UYRoUr7WHXdQ9VbX1SC5Yn+ZVdm0j1WeFTSfMhrKanoXWWOixVKguyUocjP+4A==
X-Received: by 2002:adf:f701:: with SMTP id r1mr21141458wrp.557.1643727811754;
        Tue, 01 Feb 2022 07:03:31 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o12sm17764493wry.115.2022.02.01.07.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 07:03:31 -0800 (PST)
Message-ID: <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
Date:   Tue, 1 Feb 2022 16:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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
        Lee Jones <lee.jones@linaro.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Geert,

On 2/1/22 15:14, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Tue, Feb 1, 2022 at 2:09 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> On 2/1/22 12:38, Geert Uytterhoeven wrote:
>>>> Since the current binding has a compatible "ssd1305fb-i2c", we could make the
>>>> new one "ssd1305drm-i2c" or better, just "ssd1305-i2c".
>>>
>>> DT describes hardware, not software policy.
>>> If the hardware is the same, the DT bindings should stay the same.
>>>
>>
>> Yes I know that but the thing is that the current binding don't describe
>> the hardware correctly. For instance, don't use a backlight DT node as a
>> property of the panel and have this "fb" suffix in the compatible strings.
>>
>> Having said that, my opinion is that we should just keep with the existing
>> bindings and make compatible to that even if isn't completely correct.
>>
>> Since that will ease adoption of the new DRM driver and allow users to use
>> it without the need to update their DTBs.
> 
> To me it looks like the pwms property is not related to the backlight
> at all, and only needed for some variants?
>

I was reading the datasheets of the ssd1305, ssd1306 and ssd1307. Only the
first one mentions anything about a PWM and says:

  In phase 3, the OLED driver switches to use current source to drive the
  OLED pixels and this is the current drive stage. SSD1305 employs PWM
  (Pulse Width Modulation) method to control the brightness of area color
  A, B, C, D color individually. The longer the waveform in current drive
  stage is, the brighter is the pixel and vice versa.

  After finishing phase 3, the driver IC will go back to phase 1 to display
  the next row image data. This threestep cycle is run continuously to refresh
  image display on OLED panel. 

The way I understand this is that the PWM isn't used for the backlight
but instead to power the IC and allow to display the actual pixels ?

And this matches what Maxime mentioned in this patch:

https://linux-arm-kernel.infradead.narkive.com/5i44FnQ8/patch-1-2-video-ssd1307fb-add-support-for-ssd1306-oled-controller

  The Solomon SSD1306 OLED controller is very similar to the SSD1307,
  except for the fact that the power is given through an external PWM for
  the 1307, and while the 1306 can generate its own power without any PWM. 

> And the actual backlight code seems to be about internal contrast
> adjustment?
> 
> So if the pwms usage is OK, what other reasons are there to break
> DT compatibility? IMHO just the "fb" suffix is not a good reason.
>

Absolutely agreed with you on this. It seems we should just use the existing
binding and make the driver compatible with that. The only value is that the
drm_panel infrastructure could be used, but making it backward compatible is
more worthy IMO.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

