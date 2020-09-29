Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE627D3BC
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgI2Qhl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgI2Qhl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Sep 2020 12:37:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA7FC061755;
        Tue, 29 Sep 2020 09:37:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so2950412pjb.0;
        Tue, 29 Sep 2020 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tg5f8r5u/C7h4zTCABx8TCIEL7vsD7cEWgNSNx1Mhuo=;
        b=mMzxQvjL29Mh9yG57bCHo7dUr7BOU1mi5S7nRbttYY7qjpEtgyB3th6JKvs04eLZpD
         bh1InFSWp/G9PLsIwwV7KNWy/n6UOR1S07EU87EwmcT8rJ+fyEQfQC0pvCCMmtBTmLHG
         UrA0dz164V3sVMRVinQXq3o7e0+3WYj5EEePB6e9WimQJ7sZd2WBOdPrAGcIiVT+OtC5
         QGf7hXTxUyc5W2F2kMvrCl5PrnByNb+GrZLatlCcQbQI4NeohOxJy6Mou4s5orbOWctl
         hU2+4OJ1CZf+APEJEIGwP8F7MxU2ILjNVscUd9h2NsS9+8csPUh2ANMVEPYXb8NKHenx
         +ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tg5f8r5u/C7h4zTCABx8TCIEL7vsD7cEWgNSNx1Mhuo=;
        b=YYtisWy8rzkYuF9VdIg4yAR9SivXQ4p7mWENJspVud4FtTUuMfRwpsakr7SqR+ocPz
         4lmYnkwTj7exc+xOS6DnIebbv6F2jt/HCDM9CmYzlxCxoD9mHB/q6zSbmLbCLVMP1/+f
         mdh4gAf323ImNVotNPF3xKea2AgTzgAMWlq/a73fpihshDDhxCaLQnIH6q/woaArsxDB
         0oKIDnW5zZKwHhNxnq6jyXmIOWepbfnBUuuRvKp4J3cuBtkxpbYybI7BrD/Vbn+MK6nM
         FspfhXG6AKicEgqiLvH7JiE4QENJOaAHU7n4f8ERspCowDi2fodXCC0s/MpZOd0xyEP9
         buug==
X-Gm-Message-State: AOAM531FiQlPaSE6aaSSfq21YgLmoX/LfVK0/S7XtFQ1Um0BmlgFIS+U
        qWhhwaLqFxP7kD6gsJZ//ugeP98tYmPtMagX00Y=
X-Google-Smtp-Source: ABdhPJzZ2MWu7BgoxsmDjhQpS0GWZbywEzkmOKzpwIhLoaMANgTMAtb9GN0oR97r5Kd5jzUPLjGd6xvp9GBlEWkoC5E=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr4713204pjb.129.1601397460322;
 Tue, 29 Sep 2020 09:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-4-j.neuschaefer@gmx.net> <CAHp75VdUHPsuvDPLnfP9sM2p1FDiCsjkCf1SSM-y02ZsQxSDWQ@mail.gmail.com>
 <20200925213207.GA2510@latitude>
In-Reply-To: <20200925213207.GA2510@latitude>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 19:37:21 +0300
Message-ID: <CAHp75VchfQ-djkK6u+fLjq6kfqpzb0nqSLJOe76cb5S3J_F9GQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mfd: Add base driver for Netronix embedded controller
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
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
        devicetree <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Sep 26, 2020 at 12:32 AM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
> On Fri, Sep 25, 2020 at 12:29:45PM +0300, Andy Shevchenko wrote:
> > On Thu, Sep 24, 2020 at 10:26 PM Jonathan Neusch=C3=A4fer
> > <j.neuschaefer@gmx.net> wrote:

...

> > > +               dev_alert(&poweroff_restart_client->dev,
> > > +                         "Failed to power off (err =3D %d)\n", res);
> >
> > alert? This needs to be explained.
>
> I copied the dev_alert from drivers/mfd/rn5t618.c.
>
> Upon reconsideration, I'm not sure what the correct log level would be,
> but _warn seems enough, or maybe _err is better

It's up to you to decide, but crit/alert and similar has to be
justified (commit message / comment in the code).

...

> > > +       /*
> > > +        * NOTE: The lower half of the reset value is not sent, becau=
se sending
> > > +        * it causes an error
> >
> > Why? Any root cause? Perhaps you need to send 0xffff ?
>
> Unknown, because I don't have the EC firmware for analysis. The vendor
> kernel sends 0xff00 and gets an error.
>
> Sending 0xffff doesn't help.

Maybe a slightly elaborated comment that it's copied from the vendor
kernel (which is?).

> > > +        */

...

> > > +       dev_info(ec->dev,
> > > +                "Netronix embedded controller version %04x detected.=
\n",
> > > +                version);
> >
> > This info level may confuse users if followed by an error path.
>
> Right. I suppose printing incompatible versions is still useful, so how
> about something like the following?
>
>
>        /* Bail out if we encounter an unknown firmware version */
>        switch (version) {
>        case 0xd726: /* found in Kobo Aura */
>                dev_info(ec->dev,
>                         "Netronix embedded controller version %04x detect=
ed.\n",
>                         version);
>                break;
>        default:
>                dev_err(ec->dev,
>                         "Netronix embedded controller version %04x is not=
 supported.\n",
>                         version);
>                return -ENODEV;
>        }

This is better.

...

> > > +               WARN_ON(poweroff_restart_client);
> >
> > WARN_ON? All these alerts, WARNs, BUGs must be explained. Screaming to
> > the user is not good if it wasn't justified.
>
> poweroff_restart_client being already set is not a situation that should
> happen (and would indicate a bug in this driver, AFAICT), but I guess
> the log message could be better in that case...

As per above.

--=20
With Best Regards,
Andy Shevchenko
