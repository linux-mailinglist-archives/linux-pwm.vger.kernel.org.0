Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D03282269
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Oct 2020 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgJCISQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 3 Oct 2020 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCISQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 3 Oct 2020 04:18:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D070C0613D0;
        Sat,  3 Oct 2020 01:18:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so2390576pji.1;
        Sat, 03 Oct 2020 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+BYI0/u6OpMKyw3gjay+S2BO3oSX5QDwS4LJbDTNE+0=;
        b=MKgL9seMPv5Xnyriytx9J/qyyRCDv2PJfCoEFgTjWbSksEOeFbBffkBa/WpD1oB1r7
         xCerWCditb25c/6DdUc5pJt8z79TB3ojEvNDSs99M6Jom+NsmByO8xW0iNMLJiwurBwt
         mfDTfL2xASh5zpm9mBgG9wM1NmdAf6ZC+IIjYLai+nz5YO2zmR2jWemMXSUwWbSGmtSg
         kK2EDni/h0qbZWohVEb4CDHyoEBJhwUmR3VyCDTGVxVVfz7CQwDx34WCJo2pxi4xsCKK
         UBOY+1GWrj90IiUX655XMwlQgLr39jT/SbQmn/InoPRsuB9oVNGH9NfOH3HsZHPUwjjr
         N9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+BYI0/u6OpMKyw3gjay+S2BO3oSX5QDwS4LJbDTNE+0=;
        b=dxe/ueZsMwXL28qV/jO8FcKhjK08rf5907FSemby0aGjFsr++2pq9uTS+0pXn6weQP
         kF1tAmtL7sBC7uW3Qy/w3Xhy6gpUawryFHO5TYT4IK22USq7wWk+z+6dMXqk4/16fAc2
         Ofr2gNtEPAcpGoyRv9zogc5JBTFNmNcebq/WPKDxN9HroBXjAW2MaTtv5Ls892pxfYEy
         NKS4hmDVpKn38YCpy7NnVk6Ehb6ZJZKX5+n2E+QK8dNPOqt2Pb8q2jOTsq44d10Cjgft
         jGdRv4QyzFNAypUXg8OKdhfzpjvxkwAtUavLKcRDKL/CCZNU7o5F+uHcNlZO/XK05KYY
         K3+A==
X-Gm-Message-State: AOAM533EXkh1cD7cgmkKs8RIzeQWbLpfZPiCCX/kg3XQCKQ2poNFnAgB
        i0WxekKiM1dlRDm40/aNIb12v5Y6iEJKC/CSbK0=
X-Google-Smtp-Source: ABdhPJywj3WBJFKaEItRt4k8MI0LfRZi8eXCe2NuFYGEk4FbyHWblbBuqNEFRs63V6ZVeA12FGaXPyYhwrKDMBchlv4=
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr6734978pjr.228.1601713095383;
 Sat, 03 Oct 2020 01:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-5-j.neuschaefer@gmx.net> <20200925063037.fcrmqvpe5noi3ef4@pengutronix.de>
 <20200927211044.GC2510@latitude> <20200928083546.gwu7ucx7os5yc5bn@pengutronix.de>
 <20201002233630.GB500800@latitude>
In-Reply-To: <20201002233630.GB500800@latitude>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Oct 2020 11:17:58 +0300
Message-ID: <CAHp75VeSB4i_QNOX1UbrooNo0twqgbOhoaxnwk5a+=dEFWMzqA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Oct 3, 2020 at 2:36 AM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
> On Mon, Sep 28, 2020 at 10:35:46AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Sun, Sep 27, 2020 at 11:10:44PM +0200, Jonathan Neusch=C3=A4fer wrot=
e:

...

> > You can even check this with an LED using something like:
> >
> >       pwm_apply(mypwm, {.enabled =3D true, .duty_cycle =3D $big, .perio=
d =3D $big});
> >       pwm_apply(mypwm, {.enabled =3D false, ... });
> >
> > . If the period is completed the LED is on for $big ns, if not the LED
> > is on for a timespan that is probably hardly noticable with the human
> > eye.
>
> The longest configurable period is about 8ms, so it's not long enough to
> see anything. However, after writing enable=3D0, it can take about a
> second for the PWM signal to turn off... this hardware is a bit weird.

Sounds like you have 1/128 divisor and off/on is done on lower
frequency. (We saw PWMs with an additional 7-bit counter, reminds me
Crystal Cove PMIC PWM).

--=20
With Best Regards,
Andy Shevchenko
