Return-Path: <linux-pwm+bounces-3265-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0EF978AF3
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 23:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A298A1C230DB
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDC154BEC;
	Fri, 13 Sep 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcQMUsYv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA617BEC7;
	Fri, 13 Sep 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264523; cv=none; b=MVvSHcovw5Yi2KV6/lWKKPJ4C8zGS2BTTD0ZfClMlWEAROPZH2rpboO6sFjGwdFGvxY58i7SkIiSgJD/SvNAMRmhFfr3I+uEXv89vhpJrCqOyniuAu8qPgtR5ckrJcw/GHuRSWMdy8b6UpOdj3vDfiUmBgJuaz4Q1yd+pg4ekYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264523; c=relaxed/simple;
	bh=q6149tWf9a83IHhHEMU2VwoiZlrZy13ezqBewO8qXZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcsuYDbuWAUT87YcEqOy+FEPIAKObB1KrATnnyCW0rBG6ubFiXKzrgraCnr5P8DX2JQnMsWSK5/p9BGKIOCy0q0FRSOARE5xH4y9VRLbXCLXeZyNAsdyByWEfeZoV8JypDfeGWMZMdf7LWYjedBmjkfBPiRGjJrsctihbkobcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcQMUsYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B8EC4CECC;
	Fri, 13 Sep 2024 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726264522;
	bh=q6149tWf9a83IHhHEMU2VwoiZlrZy13ezqBewO8qXZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcQMUsYvo9iMfCXqKzz6WfBOeSf3QnxCe7qBB55jtluaLCdkajX3PK+h6pyWyBX07
	 PnEet5lNBh2xMOHyEUtFlosiTzo3hwcMA6t3RS+egfoow2NGG+5Npxa7L2SoCr/Fwq
	 +7PxDup8jdlmXiDh0wY+Xr8SAzjC+G1FGXhlQ9FtrV5qrJACiTJ7rzq5GLGeGaPylO
	 GB8gfB5GU9GIUuRgX2zsW3uP0oSuG9V+oz/AGRvxv9tI7ACCSGFP0+5eFAjyG+icUO
	 Rv2Mvreqixc/gkn8utok04BwajsZETiwRjz2Yoy/B6F6jeyNk8jWAZP9/okZ+fjhXI
	 EJdZKnyjanX/A==
Date: Fri, 13 Sep 2024 16:55:21 -0500
From: Rob Herring <robh@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Simona Vetter <simona@ffwll.ch>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 05/27] dt-bindings: mfd: add maxim,max77705
Message-ID: <20240913215521.GA864207-robh@kernel.org>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-5-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-5-2d2efd5c5877@gmail.com>

On Fri, Sep 13, 2024 at 06:07:48PM +0300, Dzmitry Sankouski wrote:
> Add maxim,max77705 core binding part.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes in v4:
> - change dts example intendation from tabs
>  to spaces
> - remove interrupt-names property
> - remove obvious reg description
> - split long(>80) lines
> ---
>  .../devicetree/bindings/mfd/maxim,max77705.yaml    | 169 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 170 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> new file mode 100644
> index 000000000000..40a67d15e312
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77705 multi functional
> +  device.
> +
> +  The Maxim MAX77705 is a Companion Power Management and Type-C
> +  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> +  Type-C management IC.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77705
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  charger:
> +    $ref: /schemas/power/supply/power-supply.yaml
> +    additionalProperties: true

No, true is only valid for incomplete schemas (i.e. common ones included 
by another complete schema).

And since you reference another schema, you want 'unevaluatedProperties' 
instead if you want to use any properties defined in power-supply.yaml.

> +    properties:
> +      compatible:
> +        const: maxim,max77705-charger
> +
> +    required:
> +      - compatible
> +      - monitored-battery
> +
> +  fuel_gauge:

fuel-gauge

> +    $ref: /schemas/power/supply/power-supply.yaml
> +    type: object
> +    additionalProperties: true
> +    description: MAX77705 fuel gauge with ModelGauge m5 EZ algorithm support.

blank line

> +    properties:
> +      compatible:
> +        const: maxim,max77705-fuel-gauge
> +
> +      shunt-resistor-micro-ohms:
> +        description: |

Don't need '|'.

> +          The value of current sense resistor in microohms.
> +
> +    required:
> +      - compatible
> +      - shunt-resistor-micro-ohms
> +      - monitored-battery
> +      - power-supplies
> +
> +  haptic:
> +    type: object
> +    additionalProperties: false

blank line

> +    properties:
> +      compatible:
> +        const: maxim,max77705-haptic
> +
> +      haptic-supply: true
> +
> +      pwms:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - haptic-supply
> +      - pwms
> +
> +  leds:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Up to 4 LEDs supported. One LED is represented by one child node.

blank line

> +    properties:
> +      compatible:
> +        const: maxim,max77705-led
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        type: object
> +        $ref: /schemas/leds/common.yaml#

blank line

> +        properties:
> +          reg:
> +            description:
> +              LED index.

blank line

> +        unevaluatedProperties: false

blank line

> +        required:
> +          - reg
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@66 {
> +            compatible = "maxim,max77705";
> +            reg = <0x66>;
> +            interrupt-parent = <&pm8998_gpios>;
> +            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +            pinctrl-0 = <&chg_int_default>;
> +            pinctrl-names = "default";
> +
> +            leds {
> +                compatible = "maxim,max77705-led";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@1 {
> +                    reg = <1>;
> +                    label = "red:usr1";
> +                };
> +
> +                led@2 {
> +                    reg = <2>;
> +                    label = "green:usr2";
> +                };
> +
> +                led@3 {
> +                    reg = <3>;
> +                    label = "blue:usr3";
> +                };
> +            };
> +
> +            max77705_charger: charger {
> +                compatible = "maxim,max77705-charger";
> +                monitored-battery = <&battery>;
> +            };
> +
> +            fuel_gauge {
> +                compatible = "maxim,max77705-fuel-gauge";
> +                monitored-battery = <&battery>;
> +                power-supplies = <&max77705_charger>;
> +                rsense = <5>;

Not documented.

> +            };
> +
> +
> +            haptic {
> +                compatible = "maxim,max77705-haptic";
> +                haptic-supply = <&vib_regulator>;
> +                pwms = <&vib_pwm 0 50000>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b65cfa1d322d..59d027591e34 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14064,6 +14064,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
>  F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
>  F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
>  F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
> +F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
>  F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
>  F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
>  F:	drivers/*/*max77843.c
> 
> -- 
> 2.39.2
> 

