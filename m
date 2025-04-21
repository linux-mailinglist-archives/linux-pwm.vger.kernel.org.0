Return-Path: <linux-pwm+bounces-5600-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE097A94E68
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB9C189084B
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A3210185;
	Mon, 21 Apr 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SlIpkAcf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F720D51A;
	Mon, 21 Apr 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745226449; cv=none; b=Wolbs7NcuYgxRdS6n6Alhhsl7QDqgrck0jFh2gHegOZjxfrDti8KkihiwZefDB+GUwmeyFadlCX/xJd3RrriepuIyzfVGrOuuKH2jWAs3ds+vvFG3qXgNYo/O97BYS8e/KyWYHazDhL+P4bdJh2pniBp+qEoGyD0VKg+ckPHtc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745226449; c=relaxed/simple;
	bh=DnIrezZi1ApKCi9+caRlCPr+E1q3cCVrWQYylv8sVIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyjhyoxMxiESkcaqtj1+hkufiCzJUBNlNA26z0GPHkLm3cR3QAlVy3VG6btBe5i8Y+2E5+ZaAovE2IK6TGRtkEcGMRM7K96dxaLMvxe788bNq0o8/IZeerWETFM/YCf2keJxyjdmniQHDnOI58BwK6/dVoQYTLveAaq/e8dOh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SlIpkAcf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA50F6D5;
	Mon, 21 Apr 2025 11:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745226319;
	bh=DnIrezZi1ApKCi9+caRlCPr+E1q3cCVrWQYylv8sVIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlIpkAcfVCr4cT70sRL63N/I9WpNYlKFO00wIj3pdqqUCXyQRSKv3zYZJXAhHBYYg
	 ckTIVfsYtSmfefV6SsArbvoCaEeq8fWEjSMaGnV/xA+RLzYrD64TcPqWQZEppcOF3C
	 jCCUJ9f27IoD8kTAWp/8lZwqH1D/OwY/i7wn6LYM=
Date: Mon, 21 Apr 2025 12:07:23 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 05/17] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Message-ID: <20250421090723.GD29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-5-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-5-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:21PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> programmable logic, reset generator, and PWM generator.
> 
> We can't really have adp5589 devices fallback to adp5585 (which have
> less pins) because there are some significant differences in the register
> map.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       | 47 +++++++++++++++++-----
>  .../devicetree/bindings/trivial-devices.yaml       |  2 -
>  2 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index e30e22f964f78519b2ec207e9415e4897db5c702..d690a411b3a4307f6dd5f4a432a357e89fefabb0 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -15,14 +15,21 @@ description:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - adi,adp5585-00  # Default
> -          - adi,adp5585-01  # 11 GPIOs
> -          - adi,adp5585-02  # No pull-up resistors by default on special pins
> -          - adi,adp5585-03  # Alternate I2C address
> -          - adi,adp5585-04  # Pull-down resistors on all pins by default
> -      - const: adi,adp5585
> +    oneOf:
> +      - items:
> +          - enum:
> +              - adi,adp5585-00  # Default
> +              - adi,adp5585-01  # 11 GPIOs
> +              - adi,adp5585-02  # No pull-up resistors by default on special pins
> +              - adi,adp5585-03  # Alternate I2C address
> +              - adi,adp5585-04  # Pull-down resistors on all pins by default
> +          - const: adi,adp5585
> +      - items:
> +          - enum:
> +              - adi,adp5589-00  # Default
> +              - adi,adp5589-01  # R4 defaulted to RESET1 output
> +              - adi,adp5589-02  # Pull-down resistors by default on special pins
> +          - const: adi,adp5589
>  
>    reg:
>      maxItems: 1
> @@ -62,7 +69,17 @@ allOf:
>      then:
>        properties:
>          gpio-reserved-ranges: false
> -    else:
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adp5585-00
> +              - adi,adp5585-03
> +              - adi,adp5585-04
> +              - adi,adp5585-02

Alphabetical order please. With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +    then:
>        properties:
>          gpio-reserved-ranges:
>            maxItems: 1
> @@ -71,6 +88,18 @@ allOf:
>                - const: 5
>                - const: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adp5589-00
> +              - adi,adp5589-01
> +              - adi,adp5589-02
> +    then:
> +      properties:
> +        gpio-reserved-ranges: false
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 8da408107e55483affedb7e697eb79e8c8902ed9..208fe4242672d9da66799c2742a9381938737232 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -39,8 +39,6 @@ properties:
>            - ad,adm9240
>              # AD5110 - Nonvolatile Digital Potentiometer
>            - adi,ad5110
> -            # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
> -          - adi,adp5589
>              # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
>            - adi,lt7182s
>              # AMS iAQ-Core VOC Sensor

-- 
Regards,

Laurent Pinchart

