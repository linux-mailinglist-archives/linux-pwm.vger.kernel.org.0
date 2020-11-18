Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702272B7AFD
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 11:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgKRKOT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 05:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRKOS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 05:14:18 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C4C0613D4;
        Wed, 18 Nov 2020 02:14:17 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so1102340pfq.11;
        Wed, 18 Nov 2020 02:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HN6u+FaAjlCZ1H4jPrUouV4ZFgMNcWdPZdmdiKhmcQE=;
        b=WPTRWJnYWV1uyEiESoGUSJC5xeaHrjCL0uIuthI6VL4iIXHMc3a8Yx/9DjzmyWshCj
         kfusP6YtKW1SPZAnAz6d+4ZLHBsZi+Gd7G0eRO1+CmutyJnJ0iOENrRWBsQEc7z8ZN+0
         xpWbVFCntQRGMvBzJiRJEe5eXiVgQ9eZcMTM/cF0ay9hto/A1EJ8rYzwAv2CA842w3iI
         V2Z34PviqHHx8+YmrrDLc+E236LZ3V8nlyHhTzyMFuULO1KTWeqhd3wamNX+dK+grvw4
         N2KcO5xRBO0k2Wu5ss4tXaK9IjIQTHShhesm0IjxdpH/guK/H5+MXKnVDACQZuEtmnSr
         BJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HN6u+FaAjlCZ1H4jPrUouV4ZFgMNcWdPZdmdiKhmcQE=;
        b=n5V77fBaGGxraE0RIJDO/w4CF/TRVgPMZkyHUzvUrTW0dScQg5seDhWIXGH0B+W/74
         JjUzWw0ZvE15DtHQZ/4N4tLCUc30Ai0YeAaTzEjbPB32niMIQPUwG+DceeoNIZpnV3vH
         k/CzlSTmgVkYJEzz110HXg/2MhaQk0SE7S4xspB6ktvJ/QaiMlRoKGbSCQHRgul7zYdX
         vYcrKk3FBonwOdS6lvtTgDNaWmJBXkEl8XiR1sE9UJWRqBt/wH4I3DazimpmNejh23M8
         ylinTu67aD1/4O9JWOHigzTAIfCPRVIdOQ0kBC8uU33LaoCRAgpVkoC75WjMJefUVoqR
         xmaQ==
X-Gm-Message-State: AOAM532BD47Q/QtrYaINrlF4EWUE9JU5suczZte8f/Jsc4IyJnCudI7d
        x9hr32akYistepd8TQERQsoB8jNIFj0NdT41EYM=
X-Google-Smtp-Source: ABdhPJwgZoth9XotQe6oYHEscjQKz6WMp04ErJrrau3wx2TytZxtGiTtOJ0WqYvYj0mKnzMPvmckakWe+5SXArELSW0=
X-Received: by 2002:a62:7c95:0:b029:18c:5002:a1ab with SMTP id
 x143-20020a627c950000b029018c5002a1abmr3757599pfc.40.1605694456561; Wed, 18
 Nov 2020 02:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20201117154340.18216-1-info@metux.net> <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
 <20201118095342.sviuxvfsbmmn22mo@pengutronix.de> <CAHp75Vd9QUCcUoPLUW3kkJC0h=mPUqHNqNJPY74gDGSu67t8Hw@mail.gmail.com>
 <CAHp75Vcdu1aOLuF+EFDZibbi0OwGH4QfBhJQm9VZQkeEGEeKDQ@mail.gmail.com> <20201118100856.GQ1869941@dell>
In-Reply-To: <20201118100856.GQ1869941@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Nov 2020 12:15:05 +0200
Message-ID: <CAHp75VcO6Abz5=go0w2Vg6uTEuTw59fZ-yHfFCY9CQ=_JZXWFg@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
To:     Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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

On Wed, Nov 18, 2020 at 12:09 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 18 Nov 2020, Andy Shevchenko wrote:
> > On Wed, Nov 18, 2020 at 11:56 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Nov 18, 2020 at 11:54 AM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Tue, Nov 17, 2020 at 06:45:37PM +0200, Andy Shevchenko wrote:
> >
> > ...
> >
> > > > So a system without CONFIG_OF might still make use of .of_match_tab=
le?
> > >
> > > Yep!
> >
> > If you are curious:
> > https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L615
>
> This still doesn't sit quite well with me.
>
> Not the process of ACPI using OF artifacts or the possibilty to embed
> OF type structures into ACPI tables, but the fact that an OF-only user
> (or so they think) should have to care about that special use-case.

OF-only users shouldn't take care about this. If you are sure that the
driver may not be used on a non-OF platform.

> What if we make ACPI select OF?  Or handle the ACPI case explicitly in
> the of_match_ptr() declaration?

I guess you are a bit late, but you always may propose patches to ACPI
maintainers.

--=20
With Best Regards,
Andy Shevchenko
