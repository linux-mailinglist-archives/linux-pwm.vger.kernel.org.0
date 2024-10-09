Return-Path: <linux-pwm+bounces-3564-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0FC99679C
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 12:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F05B20B96
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DA18E354;
	Wed,  9 Oct 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWnObNS1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466118E03E;
	Wed,  9 Oct 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470925; cv=none; b=imFcGr2+Ecko7EhOJBYnTnlL1xlO7JnVyeSHT20EszhBNHOALSM+DCcSoC44SmjnNnreZR6AVM08WxF/7Qj/io2VlZ6RxhTBe2+vGBPYZAUEEaaDaoNPOww3le3oSD+GXDNy6JBfK3MMcLVZ5T4OkMMRp179gn/MSuCl1Ewc9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470925; c=relaxed/simple;
	bh=o8zwS+U6LeYKFN9VysiAqAg2lYDixQmK+0AmbcHIRZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRUZw+lGtd6YCm5R15Jqa5UhgCGreYB00QsMF+fLeQYL1cljcWQBQXSpCIwNEJe4oSmBTCQ7ucTvEDxVkRag9XjMxYIcZcfpsXvr9tTT9g921oGaUbUKNi0oFjmjTF9xwq2kd9Ez43DCThbKFiMo1gA/tLpsCEQKSaxlGfxssOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWnObNS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A7FC4CEC5;
	Wed,  9 Oct 2024 10:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728470924;
	bh=o8zwS+U6LeYKFN9VysiAqAg2lYDixQmK+0AmbcHIRZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWnObNS1pDWpwmOs4rrWPCJo2d+QC7bN0jhLKY7QkXaCs8yC5idrRtLZF7zvDA8Qd
	 vtvFDXTsq2XfwJhKhljAToW0ghqwNMKVBO55i5f8mIHXQqP0r1FcxgZ6I1IFs/yzWs
	 KwkDvo+8uapUzylUrfRLh2Kd0Py0DKpLa2twe+4nXvxldbGP+Jl5IMURki+MBwV3dV
	 LDYcEsjJMRy0lpzyt5wjshC43/JlH7kZ/1qtso56Mlg66cEUgdA3NOKh5fz4147cl9
	 RBQhCZ4oD+dy1TPLxNkaReMiFaC5HXnYIgpC5k6brno2XLMx23YYyxStDifipkbPAd
	 9pPI/DHnJRifg==
Date: Wed, 9 Oct 2024 11:48:21 +0100
From: Lee Jones <lee@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
Message-ID: <20241009104821.GF276481@google.com>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwWscWk5axQI9H1t@lore-desk>

On Wed, 09 Oct 2024, Lorenzo Bianconi wrote:

> On Oct 02, Lee Jones wrote:
> > On Tue, 01 Oct 2024, Lorenzo Bianconi wrote:
> > 
> > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > 
> > > Support for Airoha EN7581 Multi Function Device that
> > > expose PINCTRL functionality and PWM functionality.
> > 
> > The device is a jumble of pinctrl registers, some of which can oscillate.
> > 
> > This is *still* not an MFD.
> > 
> > If you wish to spread this functionality over 2 drivers, use syscon to
> > obtain the registers and simple-mfd to automatically probe the drivers.
> 
> Hi Lee,
> 
> IIUC you are suggesting two possible approaches here:
> 
> 1- have a single driver implementing both pinctrl and pwm functionalities.
>    This approach will not let us reuse the code for future devices that
>    have just one of them in common, like pwm (but we can live with that).

If you can have one without the other, then they are separate devices.

> 2- use a device node like the one below (something similar to [0])
> 
> system-controller@1fbf0200 {
> 	compatible = "syscon", "simple-mfd";
> 	reg = <0x0 0x1fbf0200 0x0 0xc0>;
> 
> 	interrupt-parent = <&gic>;
> 	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> 
> 	gpio-controller;
> 	#gpio-cells = <2>;
> 
> 	interrupt-controller;
> 	#interrupt-cells = <2>;
> 
> 	pio: pinctrl {
> 		compatible = "airoha,en7581-pinctrl";
> 
> 		[ some pinctrl properties here ]
> 	};
> 
> 	#pwm-cells = <3>;
> 
> 	pwm {
> 		compatible = "airoha,en7581-pwm";
> 	};
> };
> 
> Please correct me if I am wrong, but using syscon/simple-mfd as compatible
> string for the 'parent' device, will require to introduce the compatible strings
> even for the child devices in order to probe them, correct? 
> If so, as pointed out by Christian, this is something nacked by Rob/Krzysztof/Conor
> (this is the main reason why we introduced a full mfd driver here).
> 
> @Rob, Krzysztof, Conor: am I right?

I don't see why separate functionality shouldn't have separate
compatible strings, even if the registers are together.  Register layout
and functionality separation are not related.

-- 
Lee Jones [李琼斯]

