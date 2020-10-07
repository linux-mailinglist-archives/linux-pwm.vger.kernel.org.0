Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0052859CF
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Oct 2020 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgJGHqp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Oct 2020 03:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgJGHqp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Oct 2020 03:46:45 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2932720870;
        Wed,  7 Oct 2020 07:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602056804;
        bh=R4+hRjeXx44BI8Hcdv5NdWTepbPaIEsQ9jUrvEd5YUk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x3m4w3PfO9rY8rRGo1rQ1CjNzTrKpKQ2aeHGJ12WZoiDbP4hB6FBpIqezhvDckLa8
         xmevP6p3xYTJjV16vCqm/G0s4vpHrdN3ZNNck4WfOqL2u5cY5Dx3YehHss9WItbnI3
         ffUes45WIg6s14zBmdKxvmCiQ4DSzR/ESnm0GgRg=
Received: by mail-ed1-f54.google.com with SMTP id b12so1110929edz.11;
        Wed, 07 Oct 2020 00:46:44 -0700 (PDT)
X-Gm-Message-State: AOAM531s7OBuSS+VDNBAfpccWPr+kSLaFuQQHNZv3daIPO7gOEw3Srb2
        sj87vQhcgJPT/6NL2Rshb40n6/sY8i3Y4Cn7PAc=
X-Google-Smtp-Source: ABdhPJwNzl1urhb9nVWyMFf0v62ujPzA20R0+9EZ7zY78dXLqzBp3vrmcCnYB4Kd9+I9bzs0Q6IFpFOhmgYHVbhC46o=
X-Received: by 2002:a50:e78f:: with SMTP id b15mr2224622edn.104.1602056802570;
 Wed, 07 Oct 2020 00:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net> <20200925050818.2512375-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200925050818.2512375-1-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 7 Oct 2020 09:46:30 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfRh4vyJ21ACM3Bf5+HtWZUy+anV47VBAmtitfLuAeUjw@mail.gmail.com>
Message-ID: <CAJKOXPfRh4vyJ21ACM3Bf5+HtWZUy+anV47VBAmtitfLuAeUjw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 25 Sep 2020 at 07:10, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> Enable the Netronix EC on the Kobo Aura ebook reader.
>
> Several features are still missing:
>  - Frontlight/backlight. The vendor kernel drives the frontlight LED
>    using the PWM output of the EC and an additional boost pin that
>    increases the brightness.
>  - Battery monitoring
>  - Interrupts for RTC alarm and low-battery events
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> v3:
> - Remove interrupt-controller property from embedded-controller node
> - subnodes of embedded-controller node in to the main node
>
> v2:
> - https://lore.kernel.org/lkml/20200905144503.1067124-3-j.neuschaefer@gmx=
.net/
> - Fix pwm-cells property (should be 2, not 1)
> ---
>  arch/arm/boot/dts/imx50-kobo-aura.dts | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/im=
x50-kobo-aura.dts
> index a0eaf869b9135..2d1a59091a37c 100644
> --- a/arch/arm/boot/dts/imx50-kobo-aura.dts
> +++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  #include "imx50.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
>         model =3D "Kobo Aura (N514)";
> @@ -135,10 +136,24 @@ &i2c3 {
>         pinctrl-0 =3D <&pinctrl_i2c3>;
>         status =3D "okay";
>
> -       /* TODO: embedded controller at 0x43 */
> +       embedded-controller@43 {
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_ec>;
> +               compatible =3D "netronix,ntxec";
> +               reg =3D <0x43>;
> +               system-power-controller;
> +               interrupts-extended =3D <&gpio4 11 IRQ_TYPE_EDGE_FALLING>=
;
> +               #pwm-cells =3D <2>;
> +       };
>  };
>
>  &iomuxc {
> +       pinctrl_ec: ec {

This should fail on dtschema check - pinctrl groups should end with "grp".

Best regards,
Krzysztof
