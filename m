Return-Path: <linux-pwm+bounces-2837-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED2933347
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09411282740
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897976048;
	Tue, 16 Jul 2024 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tghLh9jf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56155894;
	Tue, 16 Jul 2024 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164279; cv=none; b=TxPSgiLM86lWTblezeoihhGxnVvchw8+RSqD37ANO9O6c2NMMd0wh3KSA2lgFkS1f6a+yWwcLkEbQ+FtO+Vy9qEJ88JxrENlRwG5P54fcCzT7TUZhN8MlD3OByXE2soTRDgpB/m6/5TxHs60GroLom80xsUQpOvytes/Zt5/oiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164279; c=relaxed/simple;
	bh=1jW0L9A3iRqmH7/WtH+jzNTYliriggcP44IDfWuj9xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAkvXAYrZh84LOptooEL3ehskJs7j5DU933k1BApAIQ57NRV+IRzw/lgDR7zyQsn4NxhPt6EchkErTaZdfo1JD7atBPvOOEtBGUUR25EU9CFg0VU0nUqykI9aJlZHSAcC8J9R2fVgTNwnVQBspvU2IXpv5g+BsKoLsf+4ZqtHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tghLh9jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC982C116B1;
	Tue, 16 Jul 2024 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721164279;
	bh=1jW0L9A3iRqmH7/WtH+jzNTYliriggcP44IDfWuj9xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tghLh9jfOMBim3IX1QfM4yS2ofpN385lvpnXmFBp0BfF5oCxcniZ0tkKnocDQTqd/
	 c8XPw4rL2wdcmKF15SxMmzDfCWDFSSuUv2L0O0nkePDvp3igaULT1EO95aHbsMpR1K
	 0qGUejPBbh+Bx429UbcQtuozzegrutlE9LCl/l9XrudayzjyML9933cVEFWExtK5I/
	 5NdKIUBZWOxxo+pGqZCueUAXxngGiwkDg2bgMaXznBMWoWZELO5Jqghqk6i0OQDsJQ
	 aJgP89unBMxjg7/iCi/f+EyySFTuwbpjqq7NljneNSmUDix0HbUGYPfFn2ikM4zHyd
	 9qmwVfzEH77ng==
Date: Tue, 16 Jul 2024 15:11:17 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: mfd: Add i2c device adi5585
Message-ID: <20240716211117.GA387758-robh@kernel.org>
References: <20240716-adi-v1-0-79c0122986e7@nxp.com>
 <20240716-adi-v1-1-79c0122986e7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716-adi-v1-1-79c0122986e7@nxp.com>

On Tue, Jul 16, 2024 at 03:28:24PM -0400, Frank Li wrote:
> Add adi5585, which provide gpio, pwm and keypad controller.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> new file mode 100644
> index 0000000000000..03c4760242ddd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADI adp5585 GPIO, PWM, keypad controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  adp5585 is a multifunctional device that can provide GPIO, PWM and keypad.
> +
> +properties:
> +  compatible:
> +    const: adi,adp5585
> +
> +  reg:
> +    items:
> +      description: I2C device address.
> +
> +  gpio:
> +    type: object
> +    properties:
> +      compatible:
> +        const: adp5585-gpio
> +
> +      gpio-controller: true
> +
> +      "#gpio-cells":
> +        const: 2
> +
> +    required:
> +      - compatible
> +      - gpio-controller
> +      - "#gpio-cells"
> +
> +    additionalProperties: false
> +
> +  pwm:
> +    $ref: /schemas/pwm/pwm.yaml
> +    properties:
> +      compatible:
> +        const: adp5585-pwm
> +
> +      "#pwm-cells":
> +        const: 3
> +
> +    required:
> +      - compatible
> +      - "#pwm-cells"
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mfd@34 {
> +            compatible = "adi,adp5585";
> +            reg = <0x34>;
> +
> +            gpio {
> +                compatible = "adp5585-gpio";

Missing vendor prefix. However, ...

> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            pwm {
> +                compatible = "adp5585-pwm";
> +                #pwm-cells = <3>;
> +            };

There's no need for these child nodes. This can be just:

mfd@34 {
    compatible = "adi,adp5585";
    reg = <0x34>;
    gpio-controller;
    #gpio-cells = <2>;
    #pwm-cells = <3>;
};

Rob

