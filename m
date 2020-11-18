Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC6E2B7AD8
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 11:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgKRKAQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 05:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKRKAQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 05:00:16 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9DC0613D4;
        Wed, 18 Nov 2020 02:00:16 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id ms7so238716pjb.4;
        Wed, 18 Nov 2020 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vOMoj3JcYFJpC78SC4JjkXbWcE8b6UEDSKzYgEipYeE=;
        b=QY0N9ghrVe02DLSa7pj8DVYtHxKFtAbLvy8ElMArB7uh93fU9NRKdJk+IJ5rPrffo+
         YwN4krm08Z9g81+dArBT2UQda9qs+Gxhr/MP8o+C25B7+16LyAl+28b4TYgGrw3e3DPX
         JSQ5PfJEMhGcPtkyiLTfXClcmlW+0lHr1AaKuk8MHFHODIv3k0/krapIrAdCuUBAiPhW
         zmJIYQ1Ab3JzLLRVOErqSmDpQquTNN+Uxhg4fj9UGIfKY+l305jdbt4E1nFHgj9xRf+T
         JatEFnS9S40EcXW4sQuBPRFKSHyJ5tHWCGzqflJ6PAe/esHCGbbw8Txmqe2bd8xXRkIg
         zSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vOMoj3JcYFJpC78SC4JjkXbWcE8b6UEDSKzYgEipYeE=;
        b=pciuUxG/e/3Ftox1I0/rPOXhrbshEJk3TUpcXZCI7vIiO9MjSbGUoMsRJ0EqHDWG8q
         BDa3mbxJToV+vU4oJ81rGb9IfJzYsrF8HiM51GZ8yxTjvvQkEyAL8Jy6G6ilCSWkDlFO
         9GcpTZwKT1hlB7d7vLAl427TpJW9sSiZL9afPSmRmUPBKDGyYi4LVQDARjZdSyr5t9qp
         f+UDFKAoQNaQ7YSHyxyNUsBaGWteSpjtRBr5dqCOE8SJCX20qFTMgVsD8a6vBkZB48tY
         CU/AbaHkUlBVDH9+vP24kE3Yk1nBUFYTaYD0DxdgY3763WlfxR7DlQk7WwRI1cD8V2d/
         UapQ==
X-Gm-Message-State: AOAM531mX+iIzeSdnS8OUCEQdhUCDpP51J1ml+piz3E5XFB0XUWrRtNe
        GFp8QW7/rMRfLwZA+a4FS69uYQOb3qAy3qz1Y68=
X-Google-Smtp-Source: ABdhPJyzFNHW1FQgZWOVWKBr6UNnnHoTHWsAvDKjHjBDqb1b71Y97DRhiHez2Kvu9NLoczNOCIRBRlBf0riNgbMrFUU=
X-Received: by 2002:a17:90a:9f8e:: with SMTP id o14mr3174658pjp.181.1605693615773;
 Wed, 18 Nov 2020 02:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20201117154340.18216-1-info@metux.net> <CAHp75VfPio=TacTTrY=vZp8vZ7qst_7zWeXKDpYvJ6q7oh2Hdw@mail.gmail.com>
 <20201118095342.sviuxvfsbmmn22mo@pengutronix.de> <CAHp75Vd9QUCcUoPLUW3kkJC0h=mPUqHNqNJPY74gDGSu67t8Hw@mail.gmail.com>
In-Reply-To: <CAHp75Vd9QUCcUoPLUW3kkJC0h=mPUqHNqNJPY74gDGSu67t8Hw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Nov 2020 12:01:04 +0200
Message-ID: <CAHp75Vcdu1aOLuF+EFDZibbi0OwGH4QfBhJQm9VZQkeEGEeKDQ@mail.gmail.com>
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

On Wed, Nov 18, 2020 at 11:56 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Nov 18, 2020 at 11:54 AM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 17, 2020 at 06:45:37PM +0200, Andy Shevchenko wrote:

...

> > So a system without CONFIG_OF might still make use of .of_match_table?
>
> Yep!

If you are curious:
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L615

--=20
With Best Regards,
Andy Shevchenko
