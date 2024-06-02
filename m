Return-Path: <linux-pwm+bounces-2322-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652138D76FC
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9740B1C21AD8
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9554720;
	Sun,  2 Jun 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q/hMyIaX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC4537FF;
	Sun,  2 Jun 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343433; cv=none; b=PRF90SSEDaRn5Dt/D6RWHvvUjdSlG1r/kDKz9sa9fmn5ewAPKDbCGzR+EUGVzJjAcNhLiS1jpmqYcA4VhABIEiw5RxQu07AxzoZ9uzrTmtdv3DPMeHpWZ86We71alYCK+zyNeTN2BUBxtGN/XHAKMgCMiAOpXcyP1JoP8hH868k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343433; c=relaxed/simple;
	bh=7uc1dFxQhU4B3TuqPQ7wNf0z173494wt+6TFV8F0t1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5WH0hBahFnKFbNCwzxl59D8hgaBvKa99O0navFjvxkOORnQYSrWAMbDfIAcjFl9iS6VrqwTuqV3zqk2k0Kr0QKAvNnRbV6KSfzmwVYbJ2f4LKBx/uRaAiV3OUbAhfGGqAhNZINK3XF/OAxZ+owNSrQy8gqDNqeUEYqt4LRLZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=q/hMyIaX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B3B939F;
	Sun,  2 Jun 2024 17:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717343423;
	bh=7uc1dFxQhU4B3TuqPQ7wNf0z173494wt+6TFV8F0t1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/hMyIaXuyPSc48P9lKOIr8VNKikwAfoAyV0mpU6jiPGdYHHChDF30tosQeapT1Ky
	 2nhWTulodpmo9ljS2skiFNMBVTgoZo+EODh3VpSnBBIGt/TlEhkZm/lkQzcCl7hEZv
	 1STyyiox8aQk1IhOKOtF0niyqWUNEpqbijfNhM4w=
Date: Sun, 2 Jun 2024 18:50:15 +0300
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
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add bindings for the Analog Devices
 ADP5585
Message-ID: <20240602155015.GI6683@pendragon.ideasonboard.com>
References: <20240602152412.29136-1-laurent.pinchart@ideasonboard.com>
 <20240602152412.29136-2-laurent.pinchart@ideasonboard.com>
 <de6c28c6-3139-441e-8738-c8842b9a274b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de6c28c6-3139-441e-8738-c8842b9a274b@kernel.org>

Hi Krzysztof,

On Sun, Jun 02, 2024 at 05:31:04PM +0200, Krzysztof Kozlowski wrote:
> On 02/06/2024 17:24, Laurent Pinchart wrote:
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > These bindings model the device as an MFD, and support the GPIO expander
> > and PWM functions.
> 
> Please use subject prefixes matching the subsystem, e.g. dt-bindings: mfd:
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

I'll do that. It would be nice if someone could teach checkpatch about
this rule.

> > These bindings support the GPIO and PWM functions.
> > 
> > Drop the existing adi,adp5585 and adi,adp5585-02 compatible strings from
> > trivial-devices.yaml. They have been added there by mistake as the
> > driver that was submitted at the same time used different compatible
> > strings. We can take them over safely.
> > 
> 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        mfd@34 {
> 
> mfd is Linuxism, so this should be probably "io-expander" or something
> similar.

Sure.

> > +            compatible = "adi,adp5585-00", "adi,adp5585";
> > +            reg = <0x34>;
> > +
> > +            vdd-supply = <&reg_3v3>;
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

-- 
Regards,

Laurent Pinchart

