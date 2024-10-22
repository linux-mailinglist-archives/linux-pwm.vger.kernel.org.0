Return-Path: <linux-pwm+bounces-3754-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07819AB858
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B441F21AB9
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 21:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349B1CCB47;
	Tue, 22 Oct 2024 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGjRGhq6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356C1CC162;
	Tue, 22 Oct 2024 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631859; cv=none; b=MYQ/UvuNkE8zHoRE5ca/I77st0LJjwqE/yTrc+WQI5U+L+K2Ee9DCBpA2OuA77+ly/ShObAE/7jb0FJdeJXRiNHGUDT+up37uBbmZlAAkROJOlnKduFUz4XXIZqLJesZbnmYp3D+wtQJB4xCEzhxmdQ/6P6Yxwb7qznggyT3n/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631859; c=relaxed/simple;
	bh=YnGn/Bpg5SZBaBj2fGX+/WIoDB1fneYz8lbEhpsEVHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq2RBndqgvhDUivMgyrwl1li2+5lHWocxTVqx/pZEXU01p3SJtUeNaVHN/Yzza7vDl1cUAWQcz6kjt37FLzzy42nCa512z6kRm9YdkqxPCq7KPOtkLuailqt1EI2oANWQUoIDWlDXjSkQCHOQQdTBcHJwO9YF8gIiSAu2xX3vSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGjRGhq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20785C4CEC3;
	Tue, 22 Oct 2024 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729631859;
	bh=YnGn/Bpg5SZBaBj2fGX+/WIoDB1fneYz8lbEhpsEVHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGjRGhq6EQ2s5Yi32SnJjGsK7dTuEaxCNvtJ34zEjvDxgMDwcoajD+0AcEC/6EgAC
	 LU0j69Ch+cW56yzsRssvKPVX3sesQKUO5B1WsMIGuy1iCDPgLU0Yk4BVv1l77pes2P
	 5l9vOdCfrS7P0TqHYhe1Ca/WIi8yaN0ZlyaUtu7OTDqj/S9F9KvPkpwhClTQ8Rz4Ce
	 FymcQJWno77MmQRbJjhYIyt4HaafJPfLU/S/fxAFzKbGPKEW1n5C/+oSW6xk0UfwnP
	 sJeVwgCNAsCbH8ZsYB/+MYq9garb5VxntrIwFAxw1VCYN9R1SC9CTcGj0wleqLufLn
	 eywjPhYizq/nw==
Date: Tue, 22 Oct 2024 16:17:38 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Message-ID: <20241022211738.GB1565063-robh@kernel.org>
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
 <20241021190053.GA948525-robh@kernel.org>
 <6717cd70.df0a0220.850c6.7b5d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6717cd70.df0a0220.850c6.7b5d@mx.google.com>

On Tue, Oct 22, 2024 at 06:06:06PM +0200, Christian Marangi wrote:
> On Mon, Oct 21, 2024 at 02:00:53PM -0500, Rob Herring wrote:
> > On Fri, Oct 18, 2024 at 03:19:04PM +0200, Lorenzo Bianconi wrote:
> > > Introduce device-tree binding documentation for Airoha EN7581 pwm
> > > controller.
> > > 
> > > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 61 ++++++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..fb68c10b037b840a571a2ceee57f13cbae78da66
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> > > @@ -0,0 +1,61 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha EN7581 PWM Controller
> > > +
> > > +maintainers:
> > > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > > +
> > > +allOf:
> > > +  - $ref: pwm.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: airoha,en7581-pwm
> > > +
> > > +  "#pwm-cells":
> > > +    const: 3
> > > +
> > > +  airoha,74hc595-mode:
> > > +    description: Set the PWM to handle attached shift register chip 74HC595.
> > > +
> > > +      With this disabled, PWM assume a 74HC164 chip attached.
> > > +
> > > +      The main difference between the 2 chip is the presence of a latch pin
> > > +      that needs to triggered to apply the configuration and PWM needs to
> > > +      account for that.
> > > +    type: boolean
> > > +
> > > +  airoha,sipo-clock-divisor:
> > > +    description: Declare Shift Register chip clock divisor (clock source is
> > > +      from SoC APB Clock)
> > 
> > Where is the clock source defined?
> > 
> > You can specify the PWM frequency in PWM cells and should be able to get 
> > the APB Clock frequency. Then you can calculate the divider.
> >
> 
> Hi Rob,
> 
> this property is related to the Shift Register chip and is not related
> to the clock of the PWM.
> 
> It's really to configure the clock that will be feed to Shift Register
> chip if for whatever reason one OEM mount a different kind (but still
> register compatible) and requires to run at higher clock rate.
> 
> We can consider hardcoding it if really needed but considering the case
> with 2 different kind of shift register supported, I assume configuring
> this might be needed on some corner case Devices.
> 
> For the clock we are not 100% but we might have an idea of what is the
> source, but still it will be just referenced and enabled in the driver
> (it's always enabled).
> 
> Hope I can get some hint by you on how to proceed.
> 
> Is it ok with:
> 
> - Defining the attached clock
> - Keep the property
> 
> ?

So how is the PWM involved? I'm going to need a picture.

If this external shift register chip can be attached to any PWM and 
clock providers, then perhaps it needs to be its own node with a 'pwms' 
property and clock source.

I would suggest you go back to the version without these properties 
and that I already reviewed, then discuss adding them separately.

Rob

