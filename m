Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6181202784
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 02:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgFUACc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 20:02:32 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44155 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgFUACc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Jun 2020 20:02:32 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A3856FF808;
        Sun, 21 Jun 2020 00:02:20 +0000 (UTC)
Date:   Sun, 21 Jun 2020 02:02:20 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix
 embedded controller RTC
Message-ID: <20200621000220.GB131826@piout.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200620224222.1312520-6-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 21/06/2020 00:42:18+0200, Jonathan Neuschäfer wrote:
> The Netronix EC implements an RTC with the following functionality:
> 
> - Calendar-based time keeping with single-second resolution
> - Automatic power-on with single-minute resolution
> - Alarm at single-second resolution
> 
> This binding only supports timekeeping for now.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/mfd/netronix,ntxec.yaml          |  7 +++++
>  .../bindings/rtc/netronix,ntxec-rtc.yaml      | 27 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> index 6562c41c5a9a9..f6a32f46f47bb 100644
> --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> @@ -34,6 +34,9 @@ properties:
>    pwm:
>      $ref: ../pwm/netronix,ntxec-pwm.yaml
> 
> +  rtc:
> +    $ref: ../rtc/netronix,ntxec-rtc.yaml
> +

Shouldn't the node simply be documented here?

Also, do you really need a compatible string to be able to proe the
driver? What are the chances that you'll get a similar EC without an
RTC?

>  required:
>    - compatible
>    - reg
> @@ -61,6 +64,10 @@ examples:
>                              compatible = "netronix,ntxec-pwm";
>                              #pwm-cells = <1>;
>                      };
> +
> +                    rtc {
> +                            compatible = "netronix,ntxec-rtc";
> +                    };
>              };
>      };
> 
> diff --git a/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
> new file mode 100644
> index 0000000000000..4b301ef7319c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/netronix,ntxec-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RTC functionality in Netronix embedded controller
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +description: |
> +  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +
> +  The Netronix EC contains an RTC, which can be used for time-keeping, alarm,
> +  and automatic power-on. Note that not all of this functionality is currently
> +  supported in this binding.
> +
> +allOf:
> +  - $ref: "rtc.yaml#"
> +
> +properties:
> +  compatible:
> +    const: netronix,ntxec-rtc
> +
> +required:
> +  - compatible
> --
> 2.27.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
