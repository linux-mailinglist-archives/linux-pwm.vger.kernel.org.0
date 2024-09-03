Return-Path: <linux-pwm+bounces-3082-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4A796A4AB
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E805BB21206
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2024 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1054F18BBAD;
	Tue,  3 Sep 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgCqPXZa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA701E492;
	Tue,  3 Sep 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381745; cv=none; b=YSYHG854Xuq8998zug2+NNJBUvpsN6PKdKIJae6IgE64MbUs1M1HVU4skPS6PcGwG5II2Fe77oed41Iy/IjDjB45LNjFi9OfFtA9SMo/YfIYxWZ7lHnTTlYKEU7HkWVKkC1Wq8ZxuuXh5GSvO9pD2RzqOIox1ESVZ752jRlMUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381745; c=relaxed/simple;
	bh=ysx2yq2EzG2SmeMo3CLySNMcvk3ddYkzx0Kw43XPAxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuvbiJqUwGe8I1RaEfq/DBlgANOv91ZwXsH4VE5c3xuzzKFbxV+5/eRvMYdA2LvqTAr9TYepvcvkHYAIcS2BZnhQPpojMcl3BnfGNyxgXt6AwmWesTZp3DXWmFa+7Ecf/8Ykuq1dxne8q52sJqiKPejwFCAsvYUfqiMXhHgnRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgCqPXZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A82BC4CEC4;
	Tue,  3 Sep 2024 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381744;
	bh=ysx2yq2EzG2SmeMo3CLySNMcvk3ddYkzx0Kw43XPAxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgCqPXZazwzGXgfGAhqlE+vpCryS6mxbB6qDi2nJMtReK0UuPyw1UIERUdA36XOgx
	 WDxqlO5jl7O5CapgicZ8MVPOkcojtyHi3qvPdKgYDGAzo9OtCWfBzAZh7QqeQC3MrK
	 1VrUL5vWukZR8FWRGHp14byhFqupVrqQpdh985FojvyqjwFs4XVGr5ZJAvd6PglQ4U
	 XQk5k3/pmyZBDIQdpxVRXXGile+ffCXoRKvpg0sEZmBvfU5PVA9tametbMV8sM87Jn
	 o84+B+tFOlo+AgtR5XGka5zi/SBUFzD/yIQOeONzQyeIzkRV4u7WAn1fGUSuI4RW7Z
	 YQeezY7rQRlQA==
Date: Tue, 3 Sep 2024 17:42:18 +0100
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
Message-ID: <20240903164218.GC6858@google.com>
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-2-98eebfb4da66@kernel.org>
 <20240903153353.GZ6858@google.com>
 <66d72ea9.df0a0220.21f5f.029f@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66d72ea9.df0a0220.21f5f.029f@mx.google.com>

On Tue, 03 Sep 2024, Christian Marangi wrote:

> On Tue, Sep 03, 2024 at 04:33:53PM +0100, Lee Jones wrote:
> > On Sat, 31 Aug 2024, Lorenzo Bianconi wrote:
> > 
> > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > 
> > > Add support for Airoha EN7581 GPIO System Controller which provide a
> > > register map for controlling the GPIO, pinctrl and PWM of the SoC.
> > > 
> > > Schema define cells for both gpio/interrupt controller and PWM.
> > > Moreover it provides a dedicated pinctrl node for pins and config
> > > definitions.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 433 +++++++++++++++++++++
> > >  1 file changed, 433 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> > > new file mode 100644
> > > index 000000000000..a9080c7f50f9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> > > @@ -0,0 +1,433 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/airoha,en7581-gpio-sysctl.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha EN7581 GPIO System Controller
> > > +
> > > +maintainers:
> > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > > +
> > > +description:
> > > +  Airoha EN7581 SoC GPIO system controller which provided a register map
> > > +  for controlling the GPIO, pins and PWM of the SoC.
> > 
> > This whole thing is just about pins.
> > 
> > The MFD portion of this submission doesn't do anything.
> >
> 
> Hi Lee,
> 
> thanks for the review. I think you missed the other series as it was
> requested to use MFD implementation due to shared register map.
> 
> > Please rework this to omit the MFD driver.
> 
> I'm a bit confused by this you mean in the schema? Putting PWM property
> in a pinctrl schema looks wrong to me :(
> 
> > 
> > After just a glance, it looks like simple-mfd _might_ work.
> 
> Simple-mfd works if register map are well defined and you can have
> something like
> - parent define the whole register
> - child can user reg property to register offset and subsection of the
>   parent register
> 
> Here it's all mixed and scrambled and also it was requested to have a
> very simple node that include both pwm and pinctrl property (cause that
> is how the HW register block is designed and schema must reflect HW)
> 
> Hope you can understand these reasons.

Thinking very quickly before I have to rush off.

Have you considered syscon?

-- 
Lee Jones [李琼斯]

