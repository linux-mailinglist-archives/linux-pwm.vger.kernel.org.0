Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9E260DF1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Sep 2020 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgIHIsT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Sep 2020 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIHIsM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Sep 2020 04:48:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A0C061573;
        Tue,  8 Sep 2020 01:48:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so2452773pff.6;
        Tue, 08 Sep 2020 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WIilKc8voJhD6HqanhXRrbRJ65/BRRqTx9fPQ2X84aw=;
        b=DtQB0Zi8VPGsU9ZAdMtlxkJCMDrklHDXIioGjOdUl/k01/kYRbapRmv7/mCfqa5ZHq
         LVeMjiDoYdZ0dE1D6kXGHDjnoLw08ELYqOKARUTg60IGXSvToqd4oXCirspt2nlbTdHR
         9sl+fjC/1tFjTgZrumKMTja5vQS1+68FA8OauxUgyi4BSDLct91TGdlUpBd+nYY7STqb
         TnFPEGLvCFUPEdH6dEwJrbkSdHkJdy61xkL5qc/wJqyh89IcLRFdkuIgu1jLDgUFViu5
         XCufnUxY0/pMxOOPXa0yKqony8olavXMOYwF5lByif2GrkCu+yQpd/CSotjAY2xrtliX
         8meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WIilKc8voJhD6HqanhXRrbRJ65/BRRqTx9fPQ2X84aw=;
        b=F4iRLxeEzXyOsNY7GFTD7yU4psZbaHbhrbllZJ8dp6OX5uQaCiRlGqA3lZcViQixkk
         4kkvs6ctq/28PDCv5FX2bNZZDmXYsV33mvmXx72Qhk3sfT+M2/4rRt6itdrO+ZPiWYQq
         sn5Y1DbmsTsKFXpBbTmx291+vY2ZMaojuyStabmGLxO3a3fuJQAi6xfK2iRZkqv7tNGi
         p6W15zo0OdGVXyhiQmwXIwVhlw3Vc0GOegSozU7xYygYsvEgU90DDDRlKA5nfSewHmPq
         WGigk7K9KzdOe5ZYBsEPURelmV32ayat/aPRg3zR0UB1HL/6TxMWnL4epbzTHMCd644z
         QV7g==
X-Gm-Message-State: AOAM530bHUSkQ3GB45eciPFcWG/iLpzsTFSql/U4uOz+lRn3s2eDmzSm
        chgDP6iHjveXEX571r7/Ma/l6mxGa6a3pXWDP0M=
X-Google-Smtp-Source: ABdhPJwRuR5MsOCJy67DoZUhY4YMRXetafBxDeFh+WzwRES/sWLA4/43R1Up45IAx7gKq8+np9lhqvh3NtmziG0OdOo=
X-Received: by 2002:a17:902:28:: with SMTP id 37mr23494899pla.107.1599554892083;
 Tue, 08 Sep 2020 01:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-6-j.neuschaefer@gmx.net> <CAHp75VdUHoOyM3bObzhdfiqpne0AmSK_UakteTZxnjqJVrNV9A@mail.gmail.com>
 <20200908081445.GC4400@dell>
In-Reply-To: <20200908081445.GC4400@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Sep 2020 11:47:54 +0300
Message-ID: <CAHp75Veb5nVasy28FSksf06eVVhC8N5hHsEPM-2YcFbMjZ5Rhw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] pwm: ntxec: Add driver for PWM function in
 Netronix EC
To:     Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Sep 8, 2020 at 11:14 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 05 Sep 2020, Andy Shevchenko wrote:
> > On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer <j.neuschaefer=
@gmx.net>
> > wrote:

...

> > > +config PWM_NTXEC
> > > +       tristate "Netronix embedded controller PWM support"
> >
> >
> >
> >
> > > +       depends on MFD_NTXEC && OF
> >
> >
> > I don=E2=80=99t see need to reduce test coverage and use of the driver =
by sticking
> > with OF. Actually it=E2=80=99s not used.
>
> If the device is only known to boot with OF, then it's pointless
> building it when !OF.

No, it's not. As I pointed out the (compilation) test coverage is better.

> If you want to increase test coverage enable
> COMPILE_TEST instead.

It is one way to achieve that, yes;

       depends on OF || COMPILE_TEST
       depends on MFD_NTXEC

--=20
With Best Regards,
Andy Shevchenko
