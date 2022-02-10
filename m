Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3743D4B14B2
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Feb 2022 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbiBJRzx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Feb 2022 12:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiBJRzw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Feb 2022 12:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 577F3115A
        for <linux-pwm@vger.kernel.org>; Thu, 10 Feb 2022 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644515752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pgYKgbH/aywvATf7zLUXZmomBX6TKWirDhHOAVvfKM=;
        b=OgSgGqQlmfjf0OsfqDfVNKDiQQ4QRY1uTIo+QtIiKQGRs4GNxj65fDGuWe2D0rGbpogqet
        AlnqMtcgs0Lf2v9PXbliRzit0tRhxfhXmfX2FthgH0yNYpiGWsNtOqQFaGA8669VIWwhGV
        vAXP24Y2J2rIDA1xjJO6hEsDWopfpeM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-BjgNRP7WPiG7EntZIRpzwg-1; Thu, 10 Feb 2022 12:55:51 -0500
X-MC-Unique: BjgNRP7WPiG7EntZIRpzwg-1
Received: by mail-wm1-f72.google.com with SMTP id r187-20020a1c44c4000000b0037bb51b549aso1164826wma.4
        for <linux-pwm@vger.kernel.org>; Thu, 10 Feb 2022 09:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2pgYKgbH/aywvATf7zLUXZmomBX6TKWirDhHOAVvfKM=;
        b=B19KDo288+N1lBUoIk/aeN25hev3e6p1+o9ZXjlX9iCaVXoINnx7t6zlRPZSCBUDvF
         LjA7Lot1yx5aJ85o8yAkjpAkrJFyCIAGvEFButH3IMVEUs4WJmWOd/UlhXyqstf/6oiY
         ocP1eY+njwmWrqivk56Ozs24xL2VW1mTn5CP15tlhrmAgsORFDQWnmKHipAD1L1D636w
         fwDGwOL3ghFw2GkTgWXaVrInOCSykQQMvnu7d5W9P9S7ZLUb9MfphwUWva3nkVpUV+A7
         o54veNy4Db77g6Tlsn0bv1ltairHh4NnnENkRhjojizqfOenVXhXrMRKscEahOKt+7OX
         0wrg==
X-Gm-Message-State: AOAM530JuKNHhGRfS2WO6BBSPcdbyjicw/3nCd3J495MWf88Iv5dSePz
        q99son4/je5IFHqV8xj1gT4mb8/8ijTcR+upfFkKOUo8Y0Tk0kVMBbM65AlnfWM9lwukj6qVjMw
        MN3aktt5J57mV46u2Mcl/
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr3110917wmr.141.1644515750098;
        Thu, 10 Feb 2022 09:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzztOtP2nPNM37UZbRdKgmrkAzYQV0Pr1R7MI99JcWycnjK/AG6TWJyvSRPiuS1u8x26j6AYA==
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr3110886wmr.141.1644515749879;
        Thu, 10 Feb 2022 09:55:49 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p8sm21716128wrr.16.2022.02.10.09.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:55:49 -0800 (PST)
Message-ID: <e910fc2f-2acb-b81d-4b8c-532562952aeb@redhat.com>
Date:   Thu, 10 Feb 2022 18:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
 <CAMuHMdVKmfOAdTG70KF+eAw3noXHSGCPyGjw3cSVyQOvzUafhQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVKmfOAdTG70KF+eAw3noXHSGCPyGjw3cSVyQOvzUafhQ@mail.gmail.com>
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

Hello Geert,

On 2/10/22 18:06, Geert Uytterhoeven wrote:
> On Wed, Feb 9, 2022 at 1:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Feb 9, 2022 at 10:03 AM Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
>>> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
>>
>> [...]
> 
>> The logo is not shown, even when I create a 16-color or 224-color
>> version of the small monochrome logo I'm using.
> 
> My mistake, I messed up the hook-up, causing it to pick a different
> logo that was too large to be displayed.
>

Great, thanks for all the testing.
 
> Of course it's using the 224-color logo reduced to monochrome instead
> of the real monochrome logo, as fbcon thinks it's running on XRGB8888.
>

Right. Once the patch lands, I'll look at wiring up the needed support in
DRM for the drivers to be able to advertise 8-bit grayscale and monochrome
to avoid the unnecessary conversions and to have feature parity with fbdev.

But I just wanted to do it incrementally and first port to DRM as first step.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

