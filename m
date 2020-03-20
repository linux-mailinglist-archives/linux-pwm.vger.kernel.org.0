Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7418CB11
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 11:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCTKCz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 06:02:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTKCy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 06:02:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id h5so6445707edn.5;
        Fri, 20 Mar 2020 03:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKhEFD0HDc489I3cxzxcRx7nCJ4icJCiGjR0lWOPd2k=;
        b=m0yWlKwpPPS1pBzUL5NnkA5mvuLbPIDdPqWMwWiDARWIoLNWkrc7SIYeRA+xASdqMC
         KxCWT1RUD9yR+r5rzYrf4ZaxO1JMtYsYT2rrAohor/ptAzgmtvW4+8WlngVxGhhN+MdT
         Fh+llBMH0889nhVKUbx+xTZiK2/I2BZ2EqnLSvBT5XliZVDAzKQxl1jZp6keYHBnV3XE
         DvuVC/c9xRZTb2HKs5JJLZc7wY8vrP3F+S6rtRuJCZ1BZAJFUEmrcF8dJRJiHkSpvFFp
         NHFLabftPUjMyH54qtF7YYAUnqgE11mPpCFrJMMXISZedAK42TcEPotSCk+UjnQZJt9O
         +IBw==
X-Gm-Message-State: ANhLgQ1IZts2jDJQKOKJ2qcCw7VAIZzOMMMJyg2Zb6FfZlVF+ZVvFFF/
        Z1UJm4df8341Wdyvbjs+2qk=
X-Google-Smtp-Source: ADFU+vtTJo8GuuHT33eJ8VISdzNZK+dw+AG9XHRSiOF+v3/TwxvILo+kc3y2aVtBOdqG/TC06c4U9g==
X-Received: by 2002:a17:906:80d5:: with SMTP id a21mr7612042ejx.240.1584698571643;
        Fri, 20 Mar 2020 03:02:51 -0700 (PDT)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id e16sm319824ejx.53.2020.03.20.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 03:02:50 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:02:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kukjin Kim <kgene@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] arm: dts: pwm: replace polarity constant with
 macro
Message-ID: <20200320100243.GA16931@pi3>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-8-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-8-oleksandr.suvorov@toradex.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 02:32:31PM +0200, Oleksandr Suvorov wrote:
> There is the PWM_POLARITY_NORMAL defined and describled in
> <dt-bindings/pwm/pwm.h> and used by pwm drivers.
> 
> This patch converts all '0' constant in pwms parameters into
> PWM_POLARITY_NORMAL.
> 
> Replace with sed regexp:
> 's/(pwms = <&[a-zA-Z_0-9]+ [0-9]+ [0-9]+) 0>/\1 PWM_POLARITY_NORMAL>/'
> 
> Then:
> - included pwm.h in some dts/dtsi to fix building errors about undefined
>   symbols.
> - fixed the patman warnings about the code format;
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  arch/arm/boot/dts/am335x-cm-t335.dts               | 2 +-
>  arch/arm/boot/dts/am335x-evm.dts                   | 2 +-
>  arch/arm/boot/dts/am3517-evm.dts                   | 2 +-
>  arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi      | 2 +-
>  arch/arm/boot/dts/at91-kizbox2-common.dtsi         | 6 +++---
>  arch/arm/boot/dts/at91-kizbox3_common.dtsi         | 8 ++++----
>  arch/arm/boot/dts/at91-kizboxmini-common.dtsi      | 6 +++---
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts        | 2 +-
>  arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        | 2 +-
>  arch/arm/boot/dts/at91sam9n12ek.dts                | 2 +-
>  arch/arm/boot/dts/at91sam9x5dm.dtsi                | 2 +-
>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts  | 4 ++--
>  arch/arm/boot/dts/da850-evm.dts                    | 2 +-
>  arch/arm/boot/dts/da850-lego-ev3.dts               | 4 ++--
>  arch/arm/boot/dts/exynos4412-midas.dtsi            | 2 +-
>  arch/arm/boot/dts/exynos4412-odroidu3.dts          | 2 +-
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 2 +-
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          | 2 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 2 +-
>  arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    | 4 ++--
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          | 2 +-
>  arch/arm/boot/dts/imx53-tx53-x13x.dts              | 5 +++--
>  arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          | 2 +-
>  arch/arm/boot/dts/imx6q-display5.dtsi              | 2 +-
>  arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       | 2 +-
>  arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       | 2 +-
>  arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi            | 4 ++--
>  arch/arm/boot/dts/imx7-colibri.dtsi                | 4 +++-
>  arch/arm/boot/dts/imx7d-nitrogen7.dts              | 3 ++-
>  arch/arm/boot/dts/imx7d-pico.dtsi                  | 3 ++-
>  arch/arm/boot/dts/imx7d-sdb.dts                    | 3 ++-
>  arch/arm/boot/dts/imx7ulp-evk.dts                  | 3 ++-
>  arch/arm/boot/dts/iwg20d-q7-common.dtsi            | 2 +-
>  arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   | 2 +-
>  arch/arm/boot/dts/meson8b-ec100.dts                | 4 ++--
>  arch/arm/boot/dts/meson8b-mxq.dts                  | 4 ++--
>  arch/arm/boot/dts/meson8b-odroidc1.dts             | 4 ++--
>  arch/arm/boot/dts/motorola-mapphone-common.dtsi    | 3 ++-
>  arch/arm/boot/dts/omap3-gta04.dtsi                 | 2 +-
>  arch/arm/boot/dts/omap3-n900.dts                   | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-edp.dtsi           | 2 +-
>  arch/arm/boot/dts/rk3288-veyron.dtsi               | 2 +-
>  arch/arm/boot/dts/rv1108-evb.dts                   | 2 +-
>  arch/arm/boot/dts/s3c6410-mini6410.dts             | 2 +-
>  arch/arm/boot/dts/s5pv210-aries.dtsi               | 2 +-
>  arch/arm/boot/dts/s5pv210-smdkv210.dts             | 2 +-

For Exynos/S3C/S5P:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
