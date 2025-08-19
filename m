Return-Path: <linux-pwm+bounces-7096-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF57B2BB78
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 10:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898B77AF4E8
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276E3112BA;
	Tue, 19 Aug 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0k8Dtay"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339621D3EE;
	Tue, 19 Aug 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591221; cv=none; b=QFUiP4TLRSbBJEriMgRyAXZg/j8h7ayXYBJif+5pD20KDQdDxAnKv82EnX1tpCnYsM2f+XdPjg3JCreSyITNcbULnYp0rClgLc0nc/SZ5XAvL3+CWupsJ4Y1A95Q/y0vAx+5ceM/MpJSNOxGDfjqGgUkQK0SQSviW0rHZTUSg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591221; c=relaxed/simple;
	bh=2yVlUV3HdLjqtIleFPeXs0Fygaa4xDGVTHo3K0iJ3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKRaiXxkytcsg7CF1PwtZ2aNING7hIxwy/gqrSy5MNc8J575EcUYScqbni+myJkvDN9t4vSWkBS+eTO19/XRWUBb83LYB//qmM6tmlP5djkf2Iq7+g7PZzgF2fOmmt11Wkftw2s4CJwXQk2cw2QRc8nP4H9gkAUuIVfA9DM1Fqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0k8Dtay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F155FC4CEF1;
	Tue, 19 Aug 2025 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755591221;
	bh=2yVlUV3HdLjqtIleFPeXs0Fygaa4xDGVTHo3K0iJ3rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0k8DtayNPX9Bmp/eEdw3xh/rIPjBSz5bNk+Y9WGelr9lttG12k7UmD/ZgwUFGu3Y
	 +TizwhNxLUdogXzM0sPGTTFl+K0yTmZKY8fWPBVPO4YKFopcTnhnT41Kc/rAemb016
	 7eTyaUR7exdE0bahllIvGGepHEZe7qySMKeJep0pupT4cx+nQP+xmMv8cmMPX6ZWBw
	 vkVfZWuGMd7zM5N3/ngxhBAUh1yEo1d/t3I7teMwFjP3V1eKRQeBz6T559/7giV162
	 PbOB1Vsme7Pwykxjc7yJzMwUdWa8gYoJkREltkBVLxSGw36Nf9o9F4NOaVLGcgCCTy
	 j5VEtkwZYUxLA==
Date: Tue, 19 Aug 2025 10:13:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, andreas@kemnade.info, 
	peter.ujfalusi@gmail.com, dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org, 
	ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org, 
	linus.walleij@linaro.org, brgl@bgdev.pl, aaro.koskinen@iki.fi, khilman@baylibre.com, 
	rogerq@kernel.org, tony@atomide.com, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, 
	shuah@kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250819-humongous-muscular-curassow-5accd5@kuoka>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
 <20250816021523.167049-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250816021523.167049-2-jihed.chaibi.dev@gmail.com>

On Sat, Aug 16, 2025 at 04:15:18AM +0200, Jihed Chaibi wrote:
> Update the TI TWL family Device Tree binding to include additional
> subnodes for TWL4030, TWL6030, and TWL6032 devices.
> 
> The simple power and PWM bindings (ti,twl4030-power, ti,twl-pwm, and
> ti,twl-pwmled) are now defined directly within this binding.
> 
> Other child node definitions (audio, gpio, keypad, usb, etc.) are also
> added to the schema. These additions fix 'unevaluated properties'
> errors found during dtbs_check for boards like the omap3-beagle
> and improve the binding's overall completeness.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v3:
>  - New patch to consolidate simple bindings (power, pwm) and add
>    definitions for all child nodes to fix dtbs_check validation
>    errors found in v2.
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 191 ++++++++++++++++++
>  .../devicetree/bindings/mfd/twl4030-power.txt |  48 -----
>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
>  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
>  4 files changed, 191 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index f162ab60c..b0f1cb7b5 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -76,6 +76,98 @@ allOf:
>            properties:
>              compatible:
>                const: ti,twl4030-wdt
> +
> +        audio:
> +          type: object
> +          $ref: /schemas/sound/ti,twl4030-audio.yaml#
> +          unevaluatedProperties: false
> +
> +        keypad:
> +          type: object
> +          $ref: /schemas/input/ti,twl4030-keypad.yaml#
> +          unevaluatedProperties: false
> +
> +        pwm:
> +          type: object
> +          $ref: /schemas/pwm/pwm.yaml#
> +          unevaluatedProperties: false
> +          description: |
> +            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
> +          properties:
> +            compatible:
> +              enum:
> +                - ti,twl4030-pwm
> +            '#pwm-cells':
> +              const: 2
> +          required:
> +            - compatible
> +            - '#pwm-cells'
> +
> +        pwmled:
> +          type: object
> +          $ref: /schemas/pwm/pwm.yaml#
> +          unevaluatedProperties: false
> +          description: |
> +            TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
> +          properties:
> +            compatible:
> +              enum:
> +                - ti,twl4030-pwmled
> +            '#pwm-cells':
> +              const: 2
> +          required:
> +            - compatible
> +            - '#pwm-cells'
> +
> +        'twl4030-usb':

No need for quotes.

> +          type: object
> +          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#

Are you sure your patchset is bsiectable? Apply this patch and test. You
will see errors and you must fix these. Even after fixing you have
strict dependencies so your cover letter must explain these (or merging
constraints)...

I suggest listing here only compatible with additionalProperties:true
and splitting entire patchset per different maintainers.

Best regards,
Krzysztof


