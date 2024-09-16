Return-Path: <linux-pwm+bounces-3282-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2897A817
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 22:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A84228698E
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C25915CD7C;
	Mon, 16 Sep 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCc4wEl1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706ABE6C;
	Mon, 16 Sep 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517293; cv=none; b=je0QMuSTiN2BtFSlktD3YbOj+dTpsqp6j2AYaQdyY2qg+tkYpS9Yqg/VQotRXoOb6lAjaMXa4CDIRPpDjFlwu2QZ7U5hzHsbGS3zNEU/1Zyn3Y2BMC/IOYZU3ZlT9ujtoL++sb12vLREcz/ZGZIafMa9mRaeyCeKCYROXwjIYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517293; c=relaxed/simple;
	bh=YBjWbfo0a0keCQPpKYbQNbu61ItDdyOZQNE68ZGbl3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kifx2puFdEVocehIEV+YuDhVxVX8qCvh2hEppCnew2RdNFNTX12YgfeFCjMcBuE7/3uuoTN+gE2z3vY/WWO0XpCpXxWLoOhjOkRh307x+o7QiKX0EHzNLfaIVCfUOYrdo6EMPZ8zThxjXyA2qePAHZTCtstvfLoW2IB/ZAhlZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCc4wEl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FD6C4CEC4;
	Mon, 16 Sep 2024 20:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726517292;
	bh=YBjWbfo0a0keCQPpKYbQNbu61ItDdyOZQNE68ZGbl3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCc4wEl18k4kWLqBq6iNCPK6cahPYo3qxIvef7bzOZEcMsaklUsZ/9Ikn+ieTTqso
	 26VxtnAJENQ+rpPAAXF4d6yIE9QA1f/qvHhymWujw9IA3PY7CgA1QPh13MqeBxpn8Z
	 RX+xwBGIMuB8UozvYwQ7YE0IuPhUSx2ivrKllorV4d2IrifhxK8NEiAg1CIPKsZFIs
	 CGszExjt27bjR+I+saWIrhWkocBeCBJdT9ctx05FDwlZDj8F4ei+AJyCxir62WTpAT
	 g+WHnXXtDrbr6Gx43p8h9c8MmgVZZnzia19ZEtCOjFOMxY2J/V9Ru/dYeO7z8Gpnzn
	 YjcnTucvqpqOQ==
Date: Mon, 16 Sep 2024 22:08:08 +0200
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
Subject: Re: [PATCH v4 04/27] dt-bindings: panel: add Samsung s6e3ha8
Message-ID: <oldqqsnonmbczvhbtzuaxvnpm23uq3kuyvy5o2igq7c4ojlmsl@bket5pssbmmc>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-4-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-4-2d2efd5c5877@gmail.com>

On Fri, Sep 13, 2024 at 06:07:47PM +0300, Dzmitry Sankouski wrote:
> Add binding for the Samsung s6e3ha8 panel found in the Samsung S9.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---
> Changes in v4:
> - change dts example intendation from tabs
>  to spaces
> - remove reset-gpios description
> ---
>  .../bindings/display/panel/samsung,s6e3ha8.yaml    | 75 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> new file mode 100644
> index 000000000000..94c812e07571
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6e3ha8.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung s6e3ha8 AMOLED DSI panel
> +
> +description: The s6e3ha8 is a 1440x2960 DPI display panel from Samsung Mobile
> +  Displays (SMD).
> +
> +maintainers:
> +  - Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6e3ha8
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios: true
> +
> +  port: true
> +
> +  vdd3-supply:
> +    description: VDD regulator
> +
> +  vci-supply:
> +    description: VCI regulator
> +
> +  vddr-supply:
> +    description: VDDR regulator
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - vdd3-supply
> +  - vddr-supply
> +  - vci-supply

If there is going to be resend, then keep the same order as in
properties: block.


> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "samsung,s6e3ha8";
> +            reg = <0>;
> +            vci-supply = <&s2dos05_ldo4>;
> +            vddr-supply = <&s2dos05_buck1>;
> +            vdd3-supply = <&s2dos05_ldo1>;
> +            te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +            pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
> +            pinctrl-1 = <&sde_dsi_suspend &sde_te_active_sleep>;
> +            pinctrl-names = "default", "sleep";
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&mdss_dsi0_out>;
> +                };
> +            };
> +      };

Indentation is still mixed up.

> +    };
> +
> +...

Best regards,
Krzysztof


