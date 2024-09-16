Return-Path: <linux-pwm+bounces-3277-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A620C979E13
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 11:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CE5282EB6
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31491149C57;
	Mon, 16 Sep 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdGTUia0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B941C62;
	Mon, 16 Sep 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478043; cv=none; b=uz9YH2o45jO5Oz1qQ5zglfAbNsL81Zu2/+pz2cUzTbQlaPmu31sZM0KPqk8hwm15ukC2O3rhm6D+qKwUlKRIxJZY7qbo6S6o5G6ZglJ4PHjhMsMKj35Eg7UeDLJ0SHqkSUtTQig8DL992ncdR/p9foQYobWxi6Ap4kyaYT3ZdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478043; c=relaxed/simple;
	bh=XefrUJ67gJuBnyR8xA7a23eB3BjecjUoWUUh+qaYcPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/wHXKwuqWC7V6dkwRQ6H3T8z/EXHdYs+YF3nSOp/WxAo2HtNM/Fp6Zo2r2vA6XG7Tb6XvnGLKxkaAR/gn/6+QJG1pVmcL5x+pjoMkp7B3Lolz53Gc7MfqIUQ+Cd/UGkjPY4k5YLYpXPq1mm10K8Sn7Bdni853alkmY2C5BZ6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdGTUia0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A15BC4CECD;
	Mon, 16 Sep 2024 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478042;
	bh=XefrUJ67gJuBnyR8xA7a23eB3BjecjUoWUUh+qaYcPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdGTUia0eN/xyEaTo1jz+KBKCtm5h0YXkrYjmIi5+1sKjv0JkrNR3RzAutCPPBejz
	 Pwjh122qU3EOS73Ivig/Besss3fJy0NNp0x/5U1c6DzIV/aK6f5CwefrjE3LQsL6lM
	 /YLhuHn/KwoRVEFniyD9dY3AMqtUUA69h2ZwHQu4+hvxIeTEcJjrCEsn0bNXRe/kee
	 TIY536bsrU0TJfIdvI1m7KDVeVqM692WaDK0PUsMhs0GkYip7DFiPDrFOXq7dcnlA6
	 OOQFNI88dDRS9rfDHi0UH32gJLn9vQnbipIFDOmRHicW1z76cyW3lw2iIHs+QYMrm8
	 TOkfqSksVpnKg==
Date: Mon, 16 Sep 2024 11:13:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 06/27] dt-bindings: mfd: add samsung,s2dos05
Message-ID: <bpujvanzp4yph2jkgog2rkvoywjtqad3jgk47kkex6v223flpb@66zporslyjzt>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-6-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-6-2d2efd5c5877@gmail.com>

On Fri, Sep 13, 2024 at 06:07:49PM +0300, Dzmitry Sankouski wrote:
> Add samsung,s2dos05 MFD module binding.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes in v4:
> - split long(>80) lines
> - fix indentation
> - merge with regulators binding
> - drop pmic suffix
> - drop unused labels in example
> - correct description
> ---
>  .../devicetree/bindings/mfd/samsung,s2dos05.yaml   | 99 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 100 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
> new file mode 100644
> index 000000000000..534434002045
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/samsung,s2dos05.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S2DOS05 Power Management IC
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +description:
> +  This is a device tree bindings for S2DOS family of Power Management IC (PMIC).

Drop this sentence, not really useful. I know that I put it into other
Samsung PMIC bindings, but let's don't grow this pattern.

> +
> +  The S2DOS05 is a companion power management IC for the panel and touchscreen
> +  in smart phones. Provides voltage regulators and
> +  ADC for power/current measurements.
> +
> +  Regulator section has 4 LDO and 1 BUCK regulators and also
> +  provides ELVDD, ELVSS, AVDD lines.

What are these? Input supplies?

> +
> +properties:
> +  compatible:
> +    const: samsung,s2dos05
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    patternProperties:
> +      "^buck1|ldo[1-4]$":

s/buck1/buck/

> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        required:
> +          - regulator-name
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@60 {
> +        compatible = "samsung,s2dos05";
> +        reg = <0x60>;
> +
> +            regulators {

Messed indentation.

Use 4 spaces for example indentation.

> +                ldo1 {
> +                    regulator-name = "s2dos05-ldo1";

Such name is useless, so it's a clear sign you should not require it. If
you keep it in example, then say something useful - see your DTS.

> +                    regulator-min-microvolt = <1500000>;
> +                    regulator-max-microvolt = <2000000>;
> +                    regulator-active-discharge = <0x1>;
> +                };

...

> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 59d027591e34..92135252264a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20465,6 +20465,7 @@ L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
>  B:	mailto:linux-samsung-soc@vger.kernel.org
>  F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
> +F:	Documentation/devicetree/bindings/mfd/samsung,s2dos*.yaml
>  F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml

Maybe just change this pattern to s2*.yaml ?

>  F:	Documentation/devicetree/bindings/mfd/samsung,s5m*.yaml
>  F:	Documentation/devicetree/bindings/regulator/samsung,s2m*.yaml
> 
> -- 
> 2.39.2
> 

