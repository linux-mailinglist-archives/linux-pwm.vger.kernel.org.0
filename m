Return-Path: <linux-pwm+bounces-7232-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD86B3D819
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Sep 2025 06:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4219F18976AF
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Sep 2025 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9821B9E0;
	Mon,  1 Sep 2025 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExXBLmxs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97E2AE77;
	Mon,  1 Sep 2025 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699692; cv=none; b=ePBHMUS0B6zY0wDHwKUu5Tnp+AEFCe6CTSbwNNW6fd5SbP30sIJQ5z7Oo6SlJzTfzSZkVolAYZmANbX6+iWSk4H1zlSu98f/pMgM9ZmDvXdjyxgkx4bnQlIny9tOAZZq7fRbM+EYIGMkE52EZWE5vC377iHLDd9KTRCRzkTKK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699692; c=relaxed/simple;
	bh=8n+ZuGOwVskIkUL1IWD7BbgHrNgaykzQ+uT1sWEAI70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhC0xgA8CGhRP4mrXpTtvra0RxT0nV9T9Oit5v/iDVh533vOHr7qgxHF//bNfhEUD1tsX7LsyfqX9ZczPIa5i8BaGr2q5Ze+BGRTBA4pVMk4/3ALHRGaGNXhDjdT3nBtJkL1JAj780+ccObKxTAvB/fJwVIaDiOWZH+o+NzJhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExXBLmxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CB1C4CEF0;
	Mon,  1 Sep 2025 04:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756699691;
	bh=8n+ZuGOwVskIkUL1IWD7BbgHrNgaykzQ+uT1sWEAI70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExXBLmxscsUFiN0z6Nb7VMRuNdiCVncTbv1CiE3Fv5VFS/gMGiQ0pEwmCor0/bR2A
	 or/5xBUiStLYDux18it7pZELTizmmk78Jbz31US70OajjDLOqIXOVyq65EG5lUw8Qw
	 JP8cm9k1LcBCkzNj4XyFKn0aSNnJeRCpTElDlL+oR4EEroAMhpA4jZyhg6vwl/5bTb
	 QcqP38ywhwQPxBWH+NVbboPVXDfXaSe7SB7tRYEiZGLya5y11Nf3yq6ibG9oKgJwZh
	 On7HmtG5QuOxx/7e+Os+VqRUBSJNuB2DicHiUHu59hEg4/ff1n4T04G73savpDo/qg
	 MVborQyGaZ0gg==
Date: Mon, 1 Sep 2025 06:08:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, andreas@kemnade.info, krzk+dt@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	shuah@kernel.org
Subject: Re: [PATCH v4] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250901-tough-rigorous-porpoise-f14ae2@kuoka>
References: <20250830001421.126707-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250830001421.126707-1-jihed.chaibi.dev@gmail.com>

On Sat, Aug 30, 2025 at 02:14:21AM +0200, Jihed Chaibi wrote:
> Update the main TI TWL-family binding to be self-contained and to fix
> pre-existing validation errors.
> 
> Following maintainer feedback, the simple power and PWM bindings are
> now defined directly within this file, and their legacy .txt files
> are removed.
> 
> To ensure future patches are bisectable, child nodes whose bindings
> are in other patches (audio, keypad, usb, etc.) are now defined using
> a flexible 'additionalProperties: true' pattern. This removes hard
> dependencies between the MFD and subsystem bindings.
> 
> The complete dtbs_check for this binding is clean except for two
> warnings originating from pre-existing bugs in the OMAP DTS files,
> for which fixes have already been submitted separately [1][2].
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v4:
>   - Reworked binding to be independent and bisectable per maintainer
>     feedback by using 'additionalProperties: true' for child nodes.
>   - Added board-specific compatibles to the 'power' node enum.
>   - Added definitions for 'clocks' and 'clock-names' properties.
>   - Renamed 'twl6030-usb' child node to 'usb-comparator' to match
>     existing Device Tree usage (twl6030.dtsi).
>   - Fixed some spelling/grammar erros in the description.
> 
> Changes in v3:
>   - New patch to consolidate simple bindings (power, pwm) and add
>     definitions for all child nodes to fix dtbs_check validation
>     errors found in v2.
> 
> Changes in v2:
>   - This patch is split from larger series [3] per maintainer feedback.
>   - Added missing sub-node definitions, resolving dtbs_check errors.
> 
> [1] https://lore.kernel.org/all/20250822222530.113520-1-jihed.chaibi.dev@gmail.com/
> [2] https://lore.kernel.org/all/20250822225052.136919-1-jihed.chaibi.dev@gmail.com/
> [3] https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
> 
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 208 +++++++++++++++++-
>  .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
>  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
>  4 files changed, 206 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index f162ab60c..444e2b2b5 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -11,9 +11,9 @@ maintainers:
>  
>  description: |
>    The TWLs are Integrated Power Management Chips.
> -  Some version might contain much more analog function like
> +  Some versions might contain much more analog functionality like
>    USB transceiver or Audio amplifier.
> -  These chips are connected to an i2c bus.
> +  These chips are connected to an I2C bus.
>  
>  allOf:
>    - if:
> @@ -76,6 +76,107 @@ allOf:
>            properties:
>              compatible:
>                const: ti,twl4030-wdt
> +
> +        audio:
> +          type: object
> +          properties:
> +            compatible: true

This should list the compatibles.

> +          additionalProperties: true
> +
> +        keypad:
> +          type: object
> +          properties:
> +            compatible: true
> +          additionalProperties: true
> +
> +        pwm:
> +          type: object
> +          $ref: /schemas/pwm/pwm.yaml#
> +          description: PWM1 and PWM2
> +          properties:
> +            compatible:
> +              enum:
> +                - ti,twl4030-pwm
> +            '#pwm-cells':
> +              const: 2
> +          required:
> +            - compatible
> +            - '#pwm-cells'
> +          additionalProperties: true

This cannot be true.

> +
> +        pwmled:
> +          type: object
> +          $ref: /schemas/pwm/pwm.yaml#
> +          description: PWMA and PWMB (connected to LEDA & LEDB terminals)
> +          properties:
> +            compatible:
> +              enum:
> +                - ti,twl4030-pwmled
> +            '#pwm-cells':
> +              const: 2
> +          required:
> +            - compatible
> +            - '#pwm-cells'
> +          additionalProperties: true

Cannot be true.

> +
> +        twl4030-usb:
> +          type: object
> +          properties:
> +            compatible: true

Missing compatibles.

> +          additionalProperties: true
> +
> +        gpio:
> +          type: object
> +          properties:
> +            compatible: true
> +          additionalProperties: true
> +
> +        power:
> +          type: object
> +          additionalProperties: false
> +          description:
> +            The power management module inside the TWL4030 provides several facilities
> +            to control the power resources, including power scripts. For now, the
> +            binding only supports the complete shutdown of the system after poweroff.
> +          properties:
> +            compatible:
> +              description: |
> +                The compatible string determines the specific power configuration.
> +                Multiple compatible strings may be used to specify fallback configurations.
> +                "ti,twl4030-power": Standard power control.
> +                "ti,twl4030-power-reset": Recommended for OMAP3530 and similar SoCs
> +                  that require a special configuration for warm reset to work correctly.
> +                "ti,twl4030-power-idle": Loads the TI-recommended configuration for
> +                  idle modes into the PMIC.
> +                "ti,twl4030-power-idle-osc-off": Uses the recommended idle configuration
> +                  but also shuts down the external oscillator. This may not work on all
> +                  boards depending on the oscillator wiring.
> +                Board-specific compatible strings may also be used.

Do not add descriptioons to compatible. You are just duplicating the
names. Look at other examples if you want to add description to actual
compatible for some reason.

> +              maxItems: 2
> +              items:
> +                enum:

I really do not know what you want to express here. This is not a
correct syntax.


> +                  - ti,twl4030-power
> +                  - ti,twl4030-power-reset
> +                  - ti,twl4030-power-idle
> +                  - ti,twl4030-power-idle-osc-off
> +                  - ti,twl4030-power-beagleboard-xm

This wasn't in original binding and I did not see explanation of changes
in the commit msg.

> +                  - ti,twl4030-power-omap3-evm
> +                  - ti,twl4030-power-n900
> +
> +            ti,system-power-controller:
> +              type: boolean
> +              deprecated: true
> +              description: |
> +                DEPRECATED. The standard 'system-power-controller' property
> +                on the parent node should be used instead.
> +
> +            ti,use_poweroff:
> +              type: boolean
> +              deprecated: true
> +
> +          required:
> +            - compatible
> +
>    - if:
>        properties:
>          compatible:
> @@ -115,6 +216,43 @@ allOf:
>            properties:
>              compatible:
>                const: ti,twl6030-gpadc
> +
> +        pwm:

Do not define properties in if: block, but in top level.

Best regards,
Krzysztof


