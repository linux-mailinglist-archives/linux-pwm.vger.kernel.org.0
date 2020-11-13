Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6742B17F1
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 10:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgKMJNB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 04:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMJM6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Nov 2020 04:12:58 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B923C0613D1
        for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2020 01:12:58 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id y17so6652938ejh.11
        for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2020 01:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZEmt/VsFl2qImvUHyYQ40Mn9lV8wv5XsZxCOGudpurw=;
        b=f1bUvjmhfWE+ct5QqgGMY6/gkTD5psyD2wc7dPODO9KgsCqB0ixK2JPE4ApZME0L+f
         o+j/KQpgc+LGI+sy9NKih2qxrYPBpaQK80/YlKEIfiam5j6/jox/xl7S67zEJBgHRhL8
         cC2JAk2kdxb8hl2qPEL8s8diqprVyEXWPho7OWj77Yhoa/sErE0JYFAGOOaQ5cATUGKY
         F5Cjaa+3H9MMjuJX7ZjrIP+4lHKh1L9GJKuN6KYWlOjulGQ+fl9kGjcaX+U5ulY6njT2
         GONrmz7QkZvDGLaoc1q1EP8N6ae56fXmTlM6BM1RdxoaTw2tDzKkqRm1xqynDenDFr/+
         WHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZEmt/VsFl2qImvUHyYQ40Mn9lV8wv5XsZxCOGudpurw=;
        b=TDhvdtfo74Jp1cZ45YSY9cq4IAZe/DJlmd2ds5lYNZLPZH8ZtknZkLTL/HgJaR4vgV
         ZjbbwE/f9PvdZDx4uyMTCHmAqYOVBQeiu5edp4u4URdxpGdN+axbNL2Sw2Ufv/iL5YkO
         j+0nNYL+/FwAfIm++yEqJtqvA5zk85oi+C+GN7406T/GZAS64mvoVxDDtxezyP4jI4YA
         R4C89urNUAUKoIChjR7vN8tecHGDxjXvi7iXgP7qx7MRqxcJ85j0V4nJm7C/UCynWxBi
         7LRthzoLG5VBkjMkVOEoSfunNmMqtBxgePIab+XlDvO4Fl7GK/2xjmUqJ3JlZ3KePm26
         z1yg==
X-Gm-Message-State: AOAM533HhrMe+QCD4kaBWbwwZDT8eRqlvIoVaWUmLWbS79GOVK4NKat6
        QQwXKJzJLwfmZKswczxC3bH4SuQdJZKn1RuO0JBIFg==
X-Google-Smtp-Source: ABdhPJxtT1qVgA2FoQk7OAdlmJdj+DkZw+qwoVg8AzHfWl781Sx239Ic//jhdSO4tEd0RKQpUy7u9kHYLDSFOZst3ZE=
X-Received: by 2002:a17:906:1c83:: with SMTP id g3mr989338ejh.168.1605258777288;
 Fri, 13 Nov 2020 01:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20191229080610.7597-1-tiny.windzz@gmail.com> <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
 <20201112190649.GA908613@ulmo> <20201112211429.kfyqzkmmchjo6pll@pengutronix.de>
 <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
In-Reply-To: <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 13 Nov 2020 10:12:46 +0100
Message-ID: <CAMpxmJXWqKwhNxgY7CKG6ZvszWLxrVo-JCy4riWoXN8y+bCLUA@mail.gmail.com>
Subject: Re: About devm_platform_ioremap_resource [Was: Re: [PATCH 01/32] pwm:
 sun4i: convert to devm_platform_ioremap_resource]
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-riscv@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>, shc_work@mail.ru,
        Kevin Hilman <khilman@baylibre.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-pwm@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, claudiu.beznea@microchip.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Nov 13, 2020 at 8:04 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> [Added lkml and the people involved in commit 7945f929f1a7
> ("drivers: provide devm_platform_ioremap_resource()") to Cc:. For the
> new readers: This is about patches making use of
> devm_platform_ioremap_resource() instead of open coding it. Full context
> at https://lore.kernel.org/r/20201112190649.GA908613@ulmo]
>
> On Thu, Nov 12, 2020 at 10:14:29PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, Nov 12, 2020 at 08:06:49PM +0100, Thierry Reding wrote:
> > > I also think that it's overly narrow is scope, so you can't actually
> > > "blindly" use this helper and I've seen quite a few cases where this =
was
> > > unknowingly used for cases where it shouldn't have been used and then
> > > broke things (because some drivers must not do the request_mem_region=
()
> > > for example).
> >
> > You have a link to such an accident?
>
> I got a hint in private here: https://lore.kernel.org/r/1555670144-24220-=
1-git-send-email-aisheng.dong@nxp.com
>
> devm_platform_ioremap_resource() is platform_get_resource() +
> devm_ioremap_resource() and here it was used to replace
> platform_get_resource() + devm_ioremap().
>
> IMHO the unlucky thing in this situation is that devm_ioremap_resource()
> and devm_ioremap() are different by more than just how they get the area
> to remap. (i.e. devm_ioremap_resource() also does
> devm_request_mem_region().)
>
> So the problem is not the added wrapper, but unclear semantics in the
> functions it uses. In my eyes devm_ioremap() and
> devm_platform_ioremap_resource() should better be named
> devm_request_ioremap() and devm_platform_request_ioremap_resource()
> respectively. Is it worth to rename these for clearity?

But devm_ioremap() doesn't request the region. Did you mean
devm_ioremap_resource() should become devm_request_ioremap_resource()?

Bartosz
