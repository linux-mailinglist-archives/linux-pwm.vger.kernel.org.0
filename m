Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BDB4A7018
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Feb 2022 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiBBLjg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Feb 2022 06:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230155AbiBBLje (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Feb 2022 06:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643801974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udGfbFsD3WjS9bv8IIFrQcIv1RwbGFk7ab6Qa1eMKEE=;
        b=Bg6r97C51QpJwbqu7TlwIIR815gx4ev2ec39cX9RhT7lTnH2QbPUklB9gCpDszLU/c3tl8
        Q+AFwMrDmzM525W9buVa3TXUMB+7g6pt9ab2ZexshMwH1c7Q/C/PGkUEoIwHH3qflU51dx
        oLgLTrWwFaWkl/Yb93+EqdCGKbpLAnM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363--DGxKmobOuKlpYOyjY9QMg-1; Wed, 02 Feb 2022 06:39:33 -0500
X-MC-Unique: -DGxKmobOuKlpYOyjY9QMg-1
Received: by mail-wr1-f71.google.com with SMTP id e15-20020adf9bcf000000b001de055937d4so6719175wrc.13
        for <linux-pwm@vger.kernel.org>; Wed, 02 Feb 2022 03:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=udGfbFsD3WjS9bv8IIFrQcIv1RwbGFk7ab6Qa1eMKEE=;
        b=K3+pqAy1PhgqF4DZ535fIK1krFoC8hbLJ1dVDL6K5UEcyIvRww/C8bhnPOq7XT7+dT
         l1uwqyaYR1Qe5U1p599opNA2b39jq83uyTBkqhEcFjHF7jIm3RRKomtId9yFho8v3O8X
         NVnwZc+HiscPCVbUS138d0hDL0CoUdTCMCg9udRh2yoA2noJ3M+FZlOlKh8J0UdD/MUl
         FriqDDsbJRv3XfhKhw9KjEk4rith5y8/LOUrmFxx1ZRpRGRMNERScZL3vLCJQPeNIXmf
         QlxouCKxB46gzLeHxgiCZy3ApMXBgK4WigNxI3+75s3/0xMPhrsVivMYZ4ny55p7uOr3
         OHCA==
X-Gm-Message-State: AOAM533zi1pDmNB2i8bSXUiToupYrizkoiUvARAFf6ftDvYnwJ0zZS5F
        O71NcohM3WDHw0/lXeC1eaxdPkYWw7KKmaDnP7rzxmTuAdoXBCaeMh70YtpU2QFswU29878j8cy
        397xJH13If9VW39sA2pKx
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr25289513wrc.234.1643801972289;
        Wed, 02 Feb 2022 03:39:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIYnUCCInjr37c9/22HdQPcKzX7C106buTPKlsAaiTOOtU5+XcopMUfetRz5oizfbknnWbWw==
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr25289493wrc.234.1643801972038;
        Wed, 02 Feb 2022 03:39:32 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m11sm4097810wmi.16.2022.02.02.03.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 03:39:31 -0800 (PST)
Message-ID: <2f149fef-b991-9e34-98cb-426e561192ff@redhat.com>
Date:   Wed, 2 Feb 2022 12:39:29 +0100
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
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
 <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
 <YfploeCM6C5y3Imj@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfploeCM6C5y3Imj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Andy,

On 2/2/22 12:06, Andy Shevchenko wrote:
> On Wed, Feb 02, 2022 at 09:38:51AM +0100, Javier Martinez Canillas wrote:
>> On 2/1/22 21:40, Sam Ravnborg wrote:
> 
> ...
> 
>> Peter Robinson suggested to
>> make the driver mutually exclusive and add !FB_SSD1307 in the config symbol.
> 
> And how will distros choose "the right" option in this case?

It depends on the distro. In Fedora we are disabling *all* the fbdev drivers.

> What to do when I wan to see a regression and I want to change drivers w/o
> recompilation?
>

If you want to have the two drivers without recompilation (and same compatible
to match) then how would kmod / udev choose which one to load ? It becomes a
race condition between the two drivers which one probes first.
 
> NAK from me to that proposal.
> 

What's your suggestion then to solve the issue mentioned above ? With my distro
maintainer hat I don't care that much, since the fbdev drivers will be disabled.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

