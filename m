Return-Path: <linux-pwm+bounces-2870-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634E93843D
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 11:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE8B20E6D
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8AD26D;
	Sun, 21 Jul 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aO9MGItZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DCCA6F;
	Sun, 21 Jul 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721555149; cv=none; b=VHTwkCSR/ij0R+8s+ONs6DA5ES7fsjqTlezYGIQ7imsJltLB0ZFGK+LV0IlwJZNWOQgvPVVgVOCBgGNv4g4iVb4m1TMHvpGLuEDCqAVfNX90PuKUN3Axabu7LnFydc8Pb3gPslUYu57AK7PazWxKGBHw2xwEmVWEoa0+p0wxp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721555149; c=relaxed/simple;
	bh=FYP0NlSfqcG2gSYXCooevyeOzlqh+0QyWfWGTaFmNl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HokKCzHaGYd7CY70vS2CZhXq1QrT54LFcaw5l8i4sN0y639ILBG9hgU2CyZpqJSPkKE1o5Dm2dCfxR/StD4EbbtTtDdnCTUS3NwSbrAIMdHgiE4Kpp8eYQ/RKyTChRZye9ywjXAtrDqmyWGWERLm+/ckTyKpItGpcjfVRPZ6b4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aO9MGItZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DBE15226;
	Sun, 21 Jul 2024 11:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721555097;
	bh=FYP0NlSfqcG2gSYXCooevyeOzlqh+0QyWfWGTaFmNl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aO9MGItZlGClRZWcEcm8xTlAksGgjDEelpgsy4DKGa8NWWo8DhdvDz34o9fky/V5Q
	 F3yESV2Tg4VjsduKcctbwX0WlGE0bxqNYIfOOtYYjmKwaaQOhNMIxRmynwNwsfoeo8
	 mQ8C1+BIzVjh7mmIWEHS8QmWKGzbXshNvYLQWU4A=
Date: Sun, 21 Jul 2024 12:45:20 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: Add Analog Devices ADP5585
Message-ID: <20240721094520.GA5732@pendragon.ideasonboard.com>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
 <20240719203946.22909-2-laurent.pinchart@ideasonboard.com>
 <f962a71c-6be7-4ad2-9753-e1f9ab7a38a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f962a71c-6be7-4ad2-9753-e1f9ab7a38a0@kernel.org>

Hi Krzysztof,

On Sun, Jul 21, 2024 at 11:23:12AM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2024 22:39, Laurent Pinchart wrote:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +  gpio-reserved-ranges: true
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +  - "#pwm-cells"
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,adp5585-01
> > +    then:
> > +      properties:
> > +        gpio-reserved-ranges: false
> > +    else:
> > +      properties:
> > +        gpio-reserved-ranges:
> > +          items:
> > +            - const: 5
> > +            - const: 1
> 
> Why reserved ranges are fixed? If they pins are *always* not accessible,
> then these are not GPIOs. This really looks incorrect.

It's model-dependent. The ADP5585 has 11 pins that can be used as GPIOs.
They are named GPIO 1 to GPIO 11 in the datasheet. The -01 variant uses
the pin associated with GPIO 6 for a different purpose, so GPIO 6 is not
usable. That maps to index 5 as GPIO numbers in DT bindings are 0-based.
I've decided to handle that as a reserved GPIO range to keep the GPIO 7
to GPIO 11 indices the same across all ADP5585 variants.

> Anyway, testing reports failures which *must* be addressed, one way or
> another.

Yes I'll fix that.

-- 
Regards,

Laurent Pinchart

