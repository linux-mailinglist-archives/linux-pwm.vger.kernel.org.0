Return-Path: <linux-pwm+bounces-7289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57453B52912
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 08:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C907BD7DA
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBFD27FD54;
	Thu, 11 Sep 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPo9Elf5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00F270541;
	Thu, 11 Sep 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572603; cv=none; b=ILEEsMrmXrQBhuKqjSDIfgO1wjSGJG0/UttSaTNpfV6l0zZv1P+mM6EIh2GnORje+y06f0gc/rX0950hCVYHVjZDEPPiTmoB0q3PA/LFFk0j17vuJ9r5o9NJ8adllHSHtiODB9bouO5puuwQxo3dgl6V2B7WX+EX+lHECZerzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572603; c=relaxed/simple;
	bh=jpjp59z046Al/DP/hIOK7CgY0EfK/USap8eSfyAdDV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwKaD2z9uf7CAn1ReLUMzZXgH3OOYi33//76N2vi9ABJ2qXdl5Njl9jTU2DvE+rqMueInZzmRArsc745T5AotEH5yT5g6nuj0hvEJfptD8HxY2XIVgXKAaHVPStSR+i2mY21yxkFx4BNDh/e2+UAwpWBaB9IsRsN0CWIlH3rBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPo9Elf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7D1C4CEF1;
	Thu, 11 Sep 2025 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757572603;
	bh=jpjp59z046Al/DP/hIOK7CgY0EfK/USap8eSfyAdDV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPo9Elf5EKk9YwMsoP8tHVpiqoGP8pU1aYjOH7mhY+J+nqxjv7N111KFFDN6aByj7
	 hyrQk1CeF4FxuM0WRLO0Q38cJFZa9Z7iYcqWV0dyUJj+zdGSNGJodLMZhQe1xPWFCK
	 /6E9czRj96dwp5ILtywKEzTrwexp0AWrDIbclve/gEQ6cZggp2OIeMOmR8zjgISSpm
	 VLmIPSQWQehsm1x13oQb1PMsPnwJFk4yVZQd1xXeEtSv6oVSM3SNDMnjE4RO56AlxC
	 kltVDnUWlTAV8H0TSXKuIRzchP7kt5Rw7on3lUCsPo2ML/VwfZfOiJ4vZ6NT4d2dqp
	 Bw/JtHLtXM4Wg==
Date: Thu, 11 Sep 2025 08:36:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: andreas@kemnade.info, lee@kernel.org, krzk+dt@kernel.org, 
	tony@atomide.com, robh@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250911-curvy-doberman-of-thunder-1ef4aa@kuoka>
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
 <20250910160704.115565-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910160704.115565-2-jihed.chaibi.dev@gmail.com>

On Wed, Sep 10, 2025 at 06:07:02PM +0200, Jihed Chaibi wrote:
> Update the main TI TWL-family binding to be self-contained and to fix
> pre-existing validation errors.
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
> Changes in v7:
>   - Moved twl4030/twl6030-specific child node definitions (audio, usb..)
>     into the conditional 'if/then' block to improve schema accuracy.
> 
> Changes in v6:
>   - Refactored the ti,twl4030-power compatible schema to be much stricter,
>     removing obsolete board-specific compatibles (-n900, -beagleboard-xm),
>     that were added in v5. The schema now only permits specific, valid
>     fallback combinations. This change is supported by subsequent patches
>     in the same series (2/3) & (3/3), which update the affected DTS files.
>   - Enforced the presence of the compatible property on all relevant
>     sub-nodes by adding 'required: - compatible', closing a key validation
>     loophole.
>   - Applied various formatting cleanups for readability and correctness.
> 
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
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 232 +++++++++++++++++-
>  .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
>  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
>  4 files changed, 221 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index f162ab60c09b..95238a10ecda 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -9,11 +9,13 @@ title: Texas Instruments TWL family
>  maintainers:
>    - Andreas Kemnade <andreas@kemnade.info>
>  
> -description: |
> +description: >

Why?

>    The TWLs are Integrated Power Management Chips.
> -  Some version might contain much more analog function like
> +
> +  Some versions might contain much more analog functionality like
>    USB transceiver or Audio amplifier.
> -  These chips are connected to an i2c bus.
> +
> +  These chips are connected to an I2C bus.
>  
>  allOf:
>    - if:
> @@ -62,6 +64,7 @@ allOf:
>          pwrbutton:
>            type: object
>            additionalProperties: false
> +
>            properties:
>              compatible:
>                const: ti,twl4030-pwrbutton
> @@ -73,9 +76,109 @@ allOf:
>          watchdog:
>            type: object
>            additionalProperties: false
> +
>            properties:
>              compatible:
>                const: ti,twl4030-wdt
> +
> +        audio:

Don't define properties in conditional block.

Best regards,
Krzysztof


