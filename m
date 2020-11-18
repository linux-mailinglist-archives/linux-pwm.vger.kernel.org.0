Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7B2B7AD0
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 10:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKRJ4H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 04:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKRJ4H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:56:07 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE023C0613D4;
        Wed, 18 Nov 2020 01:56:05 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id h12so780926pjv.2;
        Wed, 18 Nov 2020 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iN17+NL6h1ATpfyCdibmddqKJUozPpM85yOX+t7P07s=;
        b=iH601Gg7erHx4XMuGEchEuetzhu7G/RZ5OWbOS3W3/wzXOSJsmX0VTIax8BjL9m5uz
         GXQ3Js7foFc2XTpaTDPT3YqS7DQ2CzIhnXwQN7MRiheKtQc5DwMKeKKuz3qnGmlnbcla
         +3kvcBguWTTCeqyc9l+yoldR9X9PFhz4w7+wqEfluCVzevJxHfuWykfpTMFOcJzNDpVC
         7VDtRtPCcjoutmpn0ruSU0o6anEAKcagv1kx0rgK3ptvJwtGIX6DNkLh1UbkvDazxf/n
         SfenlBosZtKaZ1+lT8+/fpV74scF7KMfLWXqVGoqafv6CfEeQlSteF8mDj8xx6qbiZog
         oZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iN17+NL6h1ATpfyCdibmddqKJUozPpM85yOX+t7P07s=;
        b=WjIO/WMVHnNw9qz0Ied2W5+NJSVO/9kcqUj/1GqEt85ypXSR6bi5owIqtkh/+gsjlr
         p63PmIgzkEwozEbrFKiEn2l7A0nDMDnnMs9/N+HYq67TdNoGYCc2w0GUdt4oUcGxuXR2
         yB+iHnLxeco/jF6lj6ZdrRQrNTawe121sHvTnjAxpxzvAPKUQzi9rVZcp4r9uFThxgpO
         mZwz/vpBCGbYpgjA1uVSNgLfgxPS7Vu+CHZBOiozzyfIZeFBb7rHRp+IU/x3SkrAdJaW
         DBXCsAi3MO8oU2JTkdFqCUW+8XORjhnuHuIZqe1NhYRcDYpNBR5NMaLTDPtypdNJfim/
         1/kg==
X-Gm-Message-State: AOAM533zjdOrfpcZt2cXtvGLHqowSeZVAjO9+wSsf/jgiyM2u8pZ8NBL
        mvpOaCZeOwVL0OytAdW8kqY6D0PwERHmr6GIwSY=
X-Google-Smtp-Source: ABdhPJwdxF1Zf/yjvQENLno08HERXXeTB9PR24kk98KO1SzJYVXr7enJkFxf3Vj9hg7d/FeAQooIGQGeN9ak0W7yBM0=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr3343024pjv.129.1605693365044;
 Wed, 18 Nov 2020 01:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20201117154340.18216-1-info@metux.net> <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
 <20201118095342.sviuxvfsbmmn22mo@pengutronix.de>
In-Reply-To: <20201118095342.sviuxvfsbmmn22mo@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Nov 2020 11:56:53 +0200
Message-ID: <CAHp75Vd9QUCcUoPLUW3kkJC0h=mPUqHNqNJPY74gDGSu67t8Hw@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>, zhang.lyra@gmail.com,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>, orsonzhai@gmail.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-pwm@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Scott Branden <sbranden@broadcom.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>, baolin.wang7@gmail.com,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 18, 2020 at 11:54 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Nov 17, 2020 at 06:45:37PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 17, 2020 at 5:45 PM Enrico Weigelt, metux IT consult
> > <info@metux.net> wrote:
> > >
> > > The of_match_ptr(foo) macro evaluates to foo, only if
> > > CONFIG_OF is set, otherwise to NULL. Same does ACPI_PTR with
> > > CONFIG_ACPI. That's very helpful for drivers that can be used
> > > with or without oftree / acpi.
> > >
> > > Even though most of the drivers touched here probably don't
> > > actually need that, it's also nice for consistency to make it
> > > the de-facto standard and change all drivers to use the
> > > of_match_ptr() and ACPI_PTR() macros.
> > >
> > > A nice side effect: in some situations, when compiled w/o
> > > CONFIG_OF/CONFIG_ACPI, the corresponding match tables could
> > > automatically become unreferenced and optimized-away by the
> > > compiler, w/o explicitly cluttering the code w/ ifdef's.
> >
> > NAK.
> >
> > It prevents using DT-enabled drivers on ACPI based platforms.
>
> So a system without CONFIG_OF might still make use of .of_match_table?

Yep!

> If so: TIL ...

--=20
With Best Regards,
Andy Shevchenko
