Return-Path: <linux-pwm+bounces-7056-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0519AB26915
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0CDAA3EB0
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6D1F473A;
	Thu, 14 Aug 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Bea4MgOI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BE1F0E29;
	Thu, 14 Aug 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180670; cv=none; b=ZD30SoFwekHVOraoTPMxrevxf0uWqc9K+WinuUBNekkddVgF6dPrlwWorHu2Svop7Ar8ZozHIneIDqD/qID3uBBDri7Zd0I3FNHe0B5kt+kUhD3dQ4M142SH9O8+QIwTOXYMVQJ1eLyXwuqDym8jUPlnBnfPKyXLxwGuaVaw/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180670; c=relaxed/simple;
	bh=g5nEgrfMvzqF5xAHkSQGZWNmxD88JGyjLjhNV/ORsvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEgWLGZg4sJ29OoN5B8KJOsHRptTTz7NgqLIwU4jHpOzquJS8cevoWtKyl8C7u3av0rFFhA48IOfjYVlUpkFOujAJUjd6YWjnmmBMrlTsw9pBmRVLVpsH4lpyhp13HFLvqzbCll3yFfYj+Y8d5w4cinmOQmx1n2YctjXkANgS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Bea4MgOI; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AleR0jYJ5DHvKnLDLo4Rx8JfI+/zLDkGskHcM2qem8E=; b=Bea4MgOIZSyDaDYUB4fy8WFhWl
	Mw9jANWLwS7UTPEsJOwcvtj9FwG0X17GFAEqhuHxxITyPfcRoO0im2PJVFI2OIxGWPOoHm9977Ich
	yYBG9NnEGuDyD1ISeujvQ1jAJQNHs8Ic0/ykuI5Tm3yimx1TUEEZ/nyvN0vkRz2JaAs7K8rIQMl+U
	P/RPBkhNB3hv4KSf7ayQAQ7LNVtWuRxgDkyMPJarySK1J3+uEVrLjwmHDLxipCExD6YUYp/xlbGHe
	wUp5RhfjAYd2qBsMeeE7S2pahhjUpRH1OxiBaFKHV0WMoc3ofHGP5/0syIywALRkCqyL7a1ohm873
	P0HjMvIA==;
Date: Thu, 14 Aug 2025 16:10:55 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
 dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org,
 ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 4/9] mfd: dt-bindings: ti,twl4030-power: convert to
 DT schema
Message-ID: <20250814161055.332a829a@akair>
In-Reply-To: <20250814132129.138943-5-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
	<20250814132129.138943-5-jihed.chaibi.dev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Thu, 14 Aug 2025 15:21:24 +0200
schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:

> Convert the legacy TXT binding for the TWL4030 power module
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation.
> 
> Changes in v2:
> Simplified the description field by removing redundant '|' as it
> does not affect formatting in this context.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  .../bindings/mfd/ti,twl4030-power.yaml        | 69 +++++++++++++++++++
>  .../devicetree/bindings/mfd/twl4030-power.txt | 48 -------------
>  2 files changed, 69 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml b/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
> new file mode 100644
> index 000000000..713e2facf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,twl4030-power.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TWL4030-family Power Management Module
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +description:
> +  The power management module inside the TWL family provides several facilities
> +  to control the power resources, including power scripts. For now, the
> +  binding only supports the complete shutdown of the system after poweroff.
> +
> +properties:
> +  compatible:
> +    description: |
> +      The compatible string determines the specific power configuration.
> +        "ti,twl4030-power": Standard power control.
> +        "ti,twl4030-power-reset": Recommended for OMAP3530 and similar SoCs
> +          that require a special configuration for warm reset to work correctly.
> +        "ti,twl4030-power-idle": Loads the TI-recommended configuration for
> +          idle modes into the PMIC.
> +        "ti,twl4030-power-idle-osc-off": Uses the recommended idle configuration
> +          but also shuts down the external oscillator. This may not work on all
> +          boards depending on the oscillator wiring.
> +
> +    enum:
> +      - ti,twl4030-power
> +      - ti,twl4030-power-reset
> +      - ti,twl4030-power-idle
> +      - ti,twl4030-power-idle-osc-off
> +
yes, this is ugly use of compatible, but not easy being patched away.

> +  ti,system-power-controller:
> +    type: boolean
> +    description:
> +      Indicates that the TWL4030 is the power supply master of the system,
> +      allowing it to initiate system power-off.
> +
this too is deprecated, we already have the system-power-controller
node in the parent.

> +  ti,use_poweroff:
> +    type: boolean
> +    description: Deprecated name for ti,system-power-controller.
> +    deprecated: true
> +
I think we can even totally drop this and maybe add this whole stuff to
ti,twl.yaml, no extra file.

Regards,
Andreas

