Return-Path: <linux-pwm+bounces-7252-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0DB427A1
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA11B246AA
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ABF31A56C;
	Wed,  3 Sep 2025 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OARjYbMi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3502D4B52;
	Wed,  3 Sep 2025 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919444; cv=none; b=sGQX4uYpCc7gPUHTcnUyYZtMn7MlBT1uuuKuexqnE8KzOTzCtxvCVZnKJXOZwH4f2KwnQkUl/6tz13mRIxdSmKpmnmDlAK4kyWlMn53xyqTZ/yKSIn1LYvTade3kj8Mu+7HzElhvbdqk2bE3guHJm29cN6cNEaKDSyaUkJinQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919444; c=relaxed/simple;
	bh=v66mCPErr0U5rYPnAL21SbD+qMKt2cd/XENOOko6XQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAwg9alANgCFtgW5ImGoPI2PcM9emAsnTTAl1FH25uHEIKlN8QkFHwphuvbMmLGQjcwfLrhFUwkL1LhDwbm+4p0WX9sB866e/bQAY64MLYq3jyolhqfaXrkh+dEkM181GaGA/46qW82C8v0SjJHBighsTg1864bf2tlOtKvqv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OARjYbMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84821C4CEE7;
	Wed,  3 Sep 2025 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919443;
	bh=v66mCPErr0U5rYPnAL21SbD+qMKt2cd/XENOOko6XQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OARjYbMigZv9bPqeQqDIhr5dnqpL6WW+0aLk1tua8l+S8+07K9vNlggRWuudIoRkR
	 +51pOsBl79/CSRTjOlWqZghmd36HcS+p7WLpLKscqg2zbHzMXjxxQMt7YqI3Kk9jm9
	 5sG8p3Meoctdd7f0WESZIVo4QCup23FrkFN0WzHD8oZU99lRd+ervuQktG7/WbPusc
	 Ot6NVwYZsos+ktBA6PH4lklhsHwE8R+PYxtRavbLduqsJlEkOelXDvzVCfKvEK2djI
	 uvP0J7NhTtn+iqtjxM/eZYNnjKgDJbGPk4bVNCMMox4OLl7274LnWQOGVSB7qqyFCm
	 R03u/R40xJpVw==
Date: Wed, 3 Sep 2025 12:10:42 -0500
From: Rob Herring <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, andreas@kemnade.info,
	conor+dt@kernel.org, ukleinek@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v5] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250903171042.GB2493698-robh@kernel.org>
References: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com>

On Tue, Sep 02, 2025 at 11:29:21PM +0200, Jihed Chaibi wrote:
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
> Changes in v5:
>   - Restructured the entire binding to define properties at the top
>     level instead of if/then blocks, per maintainer feedback.
>   - Added specific compatible enums for new child nodes instead of a
>     generic 'compatible: true'.
>   - Set 'unevaluatedProperties: false' for 'pwm' and 'pwmled' nodes to
>     enforce strict validation.
>   - Expanded 'power' node compatible enum to include all board-specific
>     compatible strings (used in existing device trees, e.g. OMAP3-based
>     boards) for more complete coverage.
>   - Corrected the schema for the 'power' node compatible to properly
>     handle single and fallback entries.
> 
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
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 159 +++++++++++++++++-
>  .../devicetree/bindings/mfd/twl4030-power.txt |  48 ------
>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
>  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
>  4 files changed, 157 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index f162ab60c09..397eed9b628 100644
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
> @@ -181,6 +181,12 @@ properties:
>    "#clock-cells":
>      const: 1
>  
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: fck
> +
>    charger:
>      type: object
>      additionalProperties: true
> @@ -198,6 +204,131 @@ properties:
>        interrupts:
>          maxItems: 1
>  
> +  audio:
> +    type: object
> +    additionalProperties: true

blank line

> +    properties:
> +      compatible:
> +        const: ti,twl4030-audio
> +
> +  keypad:
> +    type: object
> +    additionalProperties: true

blank line

> +    properties:
> +      compatible:
> +        const: ti,twl4030-keypad

       required:
         - compatible

Otherwise, with no compatible you can put anything in the node. Same for 
the others with 'additionalProperties: true'


> +
> +  pwm:
> +    type: object
> +    $ref: /schemas/pwm/pwm.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      PWM controllers (PWM1 and PWM2 on TWL4030, PWM0 and PWM1 on TWL6030/32).

blank line

> +    properties:
> +      compatible:
> +        enum:
> +          - ti,twl4030-pwm
> +          - ti,twl6030-pwm

blank line

> +      '#pwm-cells':
> +        const: 2

blank line

Same formatting needed elsewhere.

> +    required:
> +      - compatible
> +      - '#pwm-cells'
> +
> +  pwmled:
> +    type: object
> +    $ref: /schemas/pwm/pwm.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      PWM controllers connected to LED terminals (PWMA and PWMB on TWL4030,
> +      LED PWM on TWL6030/32, mainly used as charging indicator LED).
> +    properties:
> +      compatible:
> +        enum:
> +          - ti,twl4030-pwmled
> +          - ti,twl6030-pwmled
> +      '#pwm-cells':
> +        const: 2
> +    required:
> +      - compatible
> +      - '#pwm-cells'
> +
> +  twl4030-usb:
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: ti,twl4030-usb
> +
> +  usb-comparator:
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: ti,twl6030-usb
> +
> +  gpio:
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: ti,twl4030-gpio
> +
> +  power:
> +    type: object
> +    description:
> +      The power management module inside the TWL4030 provides several
> +      facilities to control the power resources, including power scripts.
> +      For now, the binding only supports the complete shutdown of the
> +      system after poweroff.
> +      Board-specific compatible strings may be used for platform-specific
> +      power configurations.
> +      A board-specific compatible string (e.g., ti,twl4030-power-n900) may
> +      be paired with a generic fallback (generally for power saving mode).

blank lines between paragraphs and use '>' modifier on 'description' 
when you have paragraphs/formatting.

> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - ti,twl4030-power
> +              - ti,twl4030-power-reset
> +              - ti,twl4030-power-idle
> +              - ti,twl4030-power-idle-osc-off
> +              # Add all board-specific compatibles for completeness
> +              - ti,twl4030-power-omap3-sdp
> +              - ti,twl4030-power-omap3-ldp
> +              - ti,twl4030-power-omap3-evm
> +              - ti,twl4030-power-beagleboard-xm
> +              - ti,twl4030-power-n900
> +          - items:
> +              - enum:
> +                  - ti,twl4030-power
> +                  - ti,twl4030-power-reset
> +                  - ti,twl4030-power-idle
> +                  - ti,twl4030-power-idle-osc-off
> +                  # Add all board-specific compatibles for completeness
> +                  - ti,twl4030-power-omap3-sdp
> +                  - ti,twl4030-power-omap3-ldp
> +                  - ti,twl4030-power-omap3-evm
> +                  - ti,twl4030-power-beagleboard-xm
> +                  - ti,twl4030-power-n900
> +              - enum:
> +                  # Fallback (for power saving mode)
> +                  - ti,twl4030-power-idle
> +                  - ti,twl4030-power-idle-osc-off
> +      ti,system-power-controller:
> +        type: boolean
> +        deprecated: true
> +        description:
> +          DEPRECATED. The standard 'system-power-controller'
> +          property on the parent node should be used instead.
> +      ti,use_poweroff:
> +        type: boolean
> +        deprecated: true
> +        description: DEPRECATED, to be removed.
> +    required:
> +      - compatible
> +
>  patternProperties:
>    "^regulator-":
>      type: object
> @@ -271,6 +402,16 @@ examples:
>            compatible = "ti,twl6030-vmmc";
>            ti,retain-on-reset;
>          };
> +
> +        pwm {
> +          compatible = "ti,twl6030-pwm";
> +          #pwm-cells = <2>;
> +        };
> +
> +        pwmled {
> +          compatible = "ti,twl6030-pwmled";
> +          #pwm-cells = <2>;
> +        };
>        };
>      };
>  
> @@ -325,6 +466,20 @@ examples:
>          watchdog {
>            compatible = "ti,twl4030-wdt";
>          };
> +
> +        power {
> +          compatible = "ti,twl4030-power";
> +        };
> +
> +        pwm {
> +          compatible = "ti,twl4030-pwm";
> +          #pwm-cells = <2>;
> +        };
> +
> +        pwmled {
> +          compatible = "ti,twl4030-pwmled";
> +          #pwm-cells = <2>;
> +        };
>        };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> deleted file mode 100644
> index 3d19963312c..00000000000
> --- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -Texas Instruments TWL family (twl4030) reset and power management module
> -
> -The power management module inside the TWL family provides several facilities
> -to control the power resources, including power scripts. For now, the
> -binding only supports the complete shutdown of the system after poweroff.
> -
> -Required properties:
> -- compatible : must be one of the following
> -	"ti,twl4030-power"
> -	"ti,twl4030-power-reset"
> -	"ti,twl4030-power-idle"
> -	"ti,twl4030-power-idle-osc-off"
> -
> -The use of ti,twl4030-power-reset is recommended at least on
> -3530 that needs a special configuration for warm reset to work.
> -
> -When using ti,twl4030-power-idle, the TI recommended configuration
> -for idle modes is loaded to the tlw4030 PMIC.
> -
> -When using ti,twl4030-power-idle-osc-off, the TI recommended
> -configuration is used with the external oscillator being shut
> -down during off-idle. Note that this does not work on all boards
> -depending on how the external oscillator is wired.
> -
> -Optional properties:
> -
> -- ti,system-power-controller: This indicates that TWL4030 is the
> -  power supply master of the system. With this flag, the chip will
> -  initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
> -  system poweroffs.
> -
> -- ti,use_poweroff: Deprecated name for ti,system-power-controller
> -
> -Example:
> -&i2c1 {
> -	clock-frequency = <2600000>;
> -
> -	twl: twl@48 {
> -		reg = <0x48>;
> -		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> -		interrupt-parent = <&intc>;
> -
> -		twl_power: power {
> -			compatible = "ti,twl4030-power";
> -			ti,use_poweroff;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
> deleted file mode 100644
> index d97ca1964e9..00000000000
> --- a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Texas Instruments TWL series PWM drivers
> -
> -Supported PWMs:
> -On TWL4030 series: PWM1 and PWM2
> -On TWL6030 series: PWM0 and PWM1
> -
> -Required properties:
> -- compatible: "ti,twl4030-pwm" or "ti,twl6030-pwm"
> -- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
> -  the cells format.
> -
> -Example:
> -
> -twl_pwm: pwm {
> -	compatible = "ti,twl6030-pwm";
> -	#pwm-cells = <2>;
> -};
> diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> deleted file mode 100644
> index 31ca1b032ef..00000000000
> --- a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Texas Instruments TWL series PWM drivers connected to LED terminals
> -
> -Supported PWMs:
> -On TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
> -On TWL6030 series: LED PWM (mainly used as charging indicator LED)
> -
> -Required properties:
> -- compatible: "ti,twl4030-pwmled" or "ti,twl6030-pwmled"
> -- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
> -  the cells format.
> -
> -Example:
> -
> -twl_pwmled: pwmled {
> -	compatible = "ti,twl6030-pwmled";
> -	#pwm-cells = <2>;
> -};
> -- 
> 2.39.5
> 

