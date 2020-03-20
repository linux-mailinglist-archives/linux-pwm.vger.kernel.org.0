Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF418CB15
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 11:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCTKDf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 06:03:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43285 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTKDf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 06:03:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id n25so5498009eds.10;
        Fri, 20 Mar 2020 03:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tSuC6rirFkPp7o5onqQW1YOkCb60MvR5bv8PP1Z/cQg=;
        b=lp0xIiy6Wn/aibB1fZexd9fa/Fb1OZP9f12DuwFgHgpHk4+Fo4AVv63sPnOhgV3Pm8
         ymHlowyYOJxbXqTXBVTi+kI01QpIkjIA6hJ7WBNr77I1efQtzTcLA3rhxx0yvt8raaNK
         N0y+5DDTVDl9pHKeeska8DVMNOVGZWDPDN8SS7GHLkrXFlSDq1tfNC5V1wY2Hf754H9p
         n2/SRpDUb7caox81eQI9mrgbZPqRD0UHZpKYZOEmg6EaBEr3EG5b/ayK9MpaWfhgKqbw
         Q3bdYFGLRu8VtyTY88fa7W1pkLIJpod9h0PD6WBVOd+VFeTueK+0Fa7vawXomRfI3IN8
         puJQ==
X-Gm-Message-State: ANhLgQ2vEe6t4UEwY4Eg+NtVJ3pYL4XBQLl0GHQq/2IM9p7Oi82x5ngx
        Nlneq2dEI8p2Zy5dlRVPu3s=
X-Google-Smtp-Source: ADFU+vugt2YyfL8cQT7+vpLHG9am8cCqBSB7XauUNUkR7U3UGvGj4jp51sCnSueZSIT/VpkoqnmJXA==
X-Received: by 2002:aa7:c658:: with SMTP id z24mr6922331edr.298.1584698613669;
        Fri, 20 Mar 2020 03:03:33 -0700 (PDT)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id y14sm330361ejc.85.2020.03.20.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 03:03:32 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:03:29 +0100
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
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Andy Yan <andy.yan@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Kever Yang <kever.yang@rock-chips.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kukjin Kim <kgene@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nick Xie <nick@khadas.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Soeren Moch <smoch@web.de>, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] arm64: dts: pwm: replace polarity constant with
 macro
Message-ID: <20200320100329.GB16931@pi3>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-7-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-7-oleksandr.suvorov@toradex.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 02:32:30PM +0200, Oleksandr Suvorov wrote:
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
> - include pwm.h in some dts/dtsi to fix building errors about undefined
>   symbols.
> - fix the patman warnings about the code format;
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts      | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts       | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts             | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi                 | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi          | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts          | 5 +++--
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts            | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts         | 5 +++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi    | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts       | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts       | 7 ++++---
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi        | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                  | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts       | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts     | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi           | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi       | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi          | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts       | 3 ++-
>  .../boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts    | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
>  .../arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi      | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts      | 5 +++--
>  arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts         | 3 ++-
>  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi         | 4 +++-
>  arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts     | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts           | 7 ++++---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi      | 3 ++-

For Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
