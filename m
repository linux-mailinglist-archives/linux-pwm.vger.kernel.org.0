Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6CB2B6AAB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Nov 2020 17:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKQQtL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Nov 2020 11:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgKQQtK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Nov 2020 11:49:10 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F23C0613CF;
        Tue, 17 Nov 2020 08:49:10 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gv24so761090pjb.3;
        Tue, 17 Nov 2020 08:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eWscDwZQ3CWBezdlVFPaRIFcqDLiQIitdTtQk021vM=;
        b=eYd32u3aYWqn822wbN6Yre+7CnFye2qgszav79YI4UwMHcwhGdd028xLX04IEPZ7Ef
         F/LLkqJ2hYuKisTwNUFovM992EVpyZ2MclzbJBaOzIE/O7v+WH3jvOWb7tudVWHuhrGe
         57yyAQR85HcMiNfy6hePe3zTYcMs9rhqipOTWrEEfSVEwaoG3lWIBS2p1mpPOZpSlria
         xpd5qjJhQokn739B5AH8JkQjvsXgqSIw3Hz7R3d5DTenkbMXIvuvxMa8XN774ysR4uHC
         HNolsKSMDYI4+tWvwjabV2mpW2GZZSV7KPKFr5XZe3hb/TpHolpGO0JtHhGplN2FNQpf
         XLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eWscDwZQ3CWBezdlVFPaRIFcqDLiQIitdTtQk021vM=;
        b=dbfdzry7YHyCDVv7xKtcVd2LxElNG3WeA5Dolq2IX/oGEYSbXb6Hl01UCFijfkWKlU
         QAM7Qsdh2A4OJHuWcf16Yq4hecmAblwZbYS4uzCZKaa64Mb4LqKzAS/HrRtBj13HPdn6
         dZ2JA+9RXGJ2eA9inYzF8JA6sEbQ/EG8rRDD6pEDywNgAS+EJDUA7+rlfsVXsEh/ldfj
         6Q/CeaY6qbUlEVimMRiQPZbHx/S4e2mFlkmT+R8bQSF+sADDdhUG5dtaRudVTaBcuCcZ
         o6cBJzJlypctZzkHnWcltr8E5/brSnYesGX92BqTtmXqvbvGn8n6hYvHRQG3V0BrB60I
         MQoQ==
X-Gm-Message-State: AOAM533d1FxVEIM5AHQglvMa2jUNaP8vezWFs00oK7PNi0Jti+sbr05B
        EH0wORcDd2kNjV9B5T85jn2Du2g2FE8XOUhWW2U=
X-Google-Smtp-Source: ABdhPJz6rWufym/vh0udkK67P2ipA+U/+eKLZoaBuqlA0jxR3jhdsU6ECiUF/iIcNPOepG57WTDzW7gedgg653jY1Go=
X-Received: by 2002:a17:902:ac93:b029:d8:d2c5:e5b1 with SMTP id
 h19-20020a170902ac93b02900d8d2c5e5b1mr34128plr.17.1605631748839; Tue, 17 Nov
 2020 08:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20201117154340.18216-1-info@metux.net> <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
In-Reply-To: <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Nov 2020 18:49:57 +0200
Message-ID: <CAHp75Vfgs=-_SZoxGf9T93sBdKb6ak_YUi8=WPPF3YeZUsxQcA@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        Vladimir Zapolskiy <vz@mleia.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 17, 2020 at 6:45 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Nov 17, 2020 at 5:45 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
> >
> > The of_match_ptr(foo) macro evaluates to foo, only if
> > CONFIG_OF is set, otherwise to NULL. Same does ACPI_PTR with
> > CONFIG_ACPI. That's very helpful for drivers that can be used
> > with or without oftree / acpi.
> >
> > Even though most of the drivers touched here probably don't
> > actually need that, it's also nice for consistency to make it
> > the de-facto standard and change all drivers to use the
> > of_match_ptr() and ACPI_PTR() macros.
> >
> > A nice side effect: in some situations, when compiled w/o
> > CONFIG_OF/CONFIG_ACPI, the corresponding match tables could
> > automatically become unreferenced and optimized-away by the
> > compiler, w/o explicitly cluttering the code w/ ifdef's.
>
> NAK.
>
> It prevents using DT-enabled drivers on ACPI based platforms.
>
> +Cc: Jonathan who had done the opposite in the entire IIO subsystem.

And a side note: use of_match_ptr() and ACPI_PTR() in 99% is a mistake.



-- 
With Best Regards,
Andy Shevchenko
