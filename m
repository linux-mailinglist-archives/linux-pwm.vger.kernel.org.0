Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A222B6A8B
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Nov 2020 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgKQQov (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Nov 2020 11:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgKQQou (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Nov 2020 11:44:50 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC86FC0613CF;
        Tue, 17 Nov 2020 08:44:49 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id oc3so800361pjb.4;
        Tue, 17 Nov 2020 08:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8QzwI2A4JiMjBdpbYfzTZikgzOSJPgc8kyE3psYOaY=;
        b=ccOT9e4Cq3nEg1uwVEtpv1U8N4LontAVmAzlX5HUNjjcXHx5n/NZNL9SRvY+Dd1vrm
         Wab0TbCtv/RB2fqIYXQ2+5cQoWXCPUR5mGj1/HJkYwnfw2FLRJYXaTUuWBsYtUUmVe59
         4EaLdkrcGNnETkIRr6RCMMp2/DRjEGZoLAO94SbuivESyoQphgeg3WuqtfKoNOkQxjja
         tbbXCtdfs8nio7bMoHtA3hKEdPZvxdqEwO1S1ofu3Ryl+GcDr5Ig9v8e7hgk5FVgIT6N
         bz5mV4/qPRABguAyyP+L5gCq4aXEht8Ryu6CHMoT9V1mie7wg+ZtNRyKuRx4HoUsLOnH
         5fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8QzwI2A4JiMjBdpbYfzTZikgzOSJPgc8kyE3psYOaY=;
        b=nvbHNDugd/Qp16/alLMb9yxjXFhrS8EBuX1h5ZmTsF3ZsqXOygm3Qw4DTEqYQQF5kb
         Do+7pmOtGnIpgZWkd6C/5+xvQ7OqHD+KGYGr5w4vLSb2r8gULgfpQAUnXay4ZVvwLGaO
         qVuI8W+taag9EODJeY4B4aj7zpBNbE4YevQ83tlU4AyvYkikexhRGm1KMNhhkdbUPsuA
         GQyunNpY0TsNGWlw2DzrjmRJOLVn+tQVOsJjAgjNWolywTY2ldlGRJ2mZmQ5V1OKQ/7J
         c2k7sYQXU//4rcduIR0ONn73m145is2QsDUP2kdxkSy2Ukj+BJFvGcFUGIUuCsYK0pP9
         4oqQ==
X-Gm-Message-State: AOAM533br2oZ2N56/R06n8VI+vWxjhoClEStA9ckp23SEDmSwUnxvaYw
        3asTTAXMk89mmIRuQeCHoDDyuTLLtd/g1K7Uwf8=
X-Google-Smtp-Source: ABdhPJwvYdEFzP8xHWLyXY+/m9CfiCPoozx6BGYVNLVbOYR5fdvQzRfgXO1baMYIKH18JHEtpDcfCR9bmqf6oaksZPY=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr231762pjv.129.1605631489523;
 Tue, 17 Nov 2020 08:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20201117154340.18216-1-info@metux.net>
In-Reply-To: <20201117154340.18216-1-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Nov 2020 18:45:37 +0200
Message-ID: <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 5:45 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> The of_match_ptr(foo) macro evaluates to foo, only if
> CONFIG_OF is set, otherwise to NULL. Same does ACPI_PTR with
> CONFIG_ACPI. That's very helpful for drivers that can be used
> with or without oftree / acpi.
>
> Even though most of the drivers touched here probably don't
> actually need that, it's also nice for consistency to make it
> the de-facto standard and change all drivers to use the
> of_match_ptr() and ACPI_PTR() macros.
>
> A nice side effect: in some situations, when compiled w/o
> CONFIG_OF/CONFIG_ACPI, the corresponding match tables could
> automatically become unreferenced and optimized-away by the
> compiler, w/o explicitly cluttering the code w/ ifdef's.

NAK.

It prevents using DT-enabled drivers on ACPI based platforms.

+Cc: Jonathan who had done the opposite in the entire IIO subsystem.

-- 
With Best Regards,
Andy Shevchenko
