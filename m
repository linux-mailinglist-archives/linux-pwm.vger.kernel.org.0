Return-Path: <linux-pwm+bounces-3587-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65C0998D4F
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAEB281AFB
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47B1CDFD5;
	Thu, 10 Oct 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyB8D+9M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C427DA62;
	Thu, 10 Oct 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577530; cv=none; b=dZFxDAhR0+iDFo6DE7Ye6E6cM/+x6cZXj5ZLzapcbeDexK0bJP2P1WLMJMpRtOOqo6EE+FnTNAQV0k/w4Ccs3gFjMhnSUjY70WXkW9Q2kjT938lNh4bu47jjKqxNqXIdfiB/pyoNOxWmCKPiONkH2mfBN62HhFwOEd9W0bu5O2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577530; c=relaxed/simple;
	bh=kuhtG6pu0KbKdRV5X1pxoX5/EESlie9bsRHdD9lFH1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgsm6FjT4Gv3XgJ5vc2xC3KIsWr6twPShyd2EJqwllyT/hMebZty3g21QBKXxkpslvmlOSJFeFmKy0ASMvaoF+GnRAM7aneqtr3WAV9k6JKccyw2F/HCR2vfe+xKg44wS/S/+wePK9H2b34zTkD7t+hIsg30ep1cLLItTa93mdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyB8D+9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876C5C4CEC5;
	Thu, 10 Oct 2024 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577529;
	bh=kuhtG6pu0KbKdRV5X1pxoX5/EESlie9bsRHdD9lFH1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyB8D+9McXR1e2Ot6L4IemN+/dCjby7IWufPoXC70W3pkTBmzqV+oBZtaNmAuDwQU
	 xF9HnEdIjVax2v7KO+0fUwnd4rfddGmAirDLLK3FPCmVJ3PfOEjkAChyBbaJ5zccob
	 vlXD6dzANj5y0SEzJfqbPEqT6aoAoRsllkEGMVBB1Sa+yAzBwvE6RwPJ2Su9tm+nVj
	 lYTtwfsivqXX7zpO3UggovNrFY9vdUZdKInPqFUh6CXFMNwyaSi94CI/u9OkyZLwzF
	 0zq7sFhM7DIjuqk5onC9zPUad7rYwcD3U0eM59De//vA9YBlLsWBXjZkhpOsrWbyBr
	 3dnulVLzQv70A==
Date: Thu, 10 Oct 2024 17:25:23 +0100
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
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
Message-ID: <20241010162523.GJ661995@google.com>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk>
 <20241009104821.GF276481@google.com>
 <20241009105550.GG276481@google.com>
 <6707a8ec.df0a0220.376450.293e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6707a8ec.df0a0220.376450.293e@mx.google.com>

On Thu, 10 Oct 2024, Christian Marangi wrote:

> On Wed, Oct 09, 2024 at 11:55:50AM +0100, Lee Jones wrote:
> > On Wed, 09 Oct 2024, Lee Jones wrote:
> > 
> > > On Wed, 09 Oct 2024, Lorenzo Bianconi wrote:
> > > 
> > > > On Oct 02, Lee Jones wrote:
> > > > > On Tue, 01 Oct 2024, Lorenzo Bianconi wrote:
> > > > > 
> > > > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > 
> > > > > > Support for Airoha EN7581 Multi Function Device that
> > > > > > expose PINCTRL functionality and PWM functionality.
> > > > > 
> > > > > The device is a jumble of pinctrl registers, some of which can oscillate.
> > > > > 
> > > > > This is *still* not an MFD.
> > > > > 
> > > > > If you wish to spread this functionality over 2 drivers, use syscon to
> > > > > obtain the registers and simple-mfd to automatically probe the drivers.
> > > > 
> > > > Hi Lee,
> > > > 
> > > > IIUC you are suggesting two possible approaches here:
> > > > 
> > > > 1- have a single driver implementing both pinctrl and pwm functionalities.
> > > >    This approach will not let us reuse the code for future devices that
> > > >    have just one of them in common, like pwm (but we can live with that).
> > > 
> > > If you can have one without the other, then they are separate devices.
> > > 
> > > > 2- use a device node like the one below (something similar to [0])
> > > > 
> > > > system-controller@1fbf0200 {
> > > > 	compatible = "syscon", "simple-mfd";
> > > > 	reg = <0x0 0x1fbf0200 0x0 0xc0>;
> > > > 
> > > > 	interrupt-parent = <&gic>;
> > > > 	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > > > 
> > > > 	gpio-controller;
> > > > 	#gpio-cells = <2>;
> > > > 
> > > > 	interrupt-controller;
> > > > 	#interrupt-cells = <2>;
> > > > 
> > > > 	pio: pinctrl {
> > > > 		compatible = "airoha,en7581-pinctrl";
> > > > 
> > > > 		[ some pinctrl properties here ]
> > > > 	};
> > > > 
> > > > 	#pwm-cells = <3>;
> > > > 
> > > > 	pwm {
> > > > 		compatible = "airoha,en7581-pwm";
> > > > 	};
> > > > };
> > > > 
> > > > Please correct me if I am wrong, but using syscon/simple-mfd as compatible
> > > > string for the 'parent' device, will require to introduce the compatible strings
> > > > even for the child devices in order to probe them, correct? 
> > > > If so, as pointed out by Christian, this is something nacked by Rob/Krzysztof/Conor
> > > > (this is the main reason why we introduced a full mfd driver here).
> > > > 
> > > > @Rob, Krzysztof, Conor: am I right?
> > > 
> > > I don't see why separate functionality shouldn't have separate
> > > compatible strings, even if the registers are together.  Register layout
> > > and functionality separation are not related.
> > 
> > We've been happy to support both pinctrl and pwm devices before:
> > 
> >   git grep "\-pinctrl\|\-pwm" -- drivers/mfd
> >   git grep "\-pinctrl\|\-pwm" -- arch/*/boot/dts
> > 
> >   git grep "\-pinctrl" -- arch/*/boot/dts | wc -l
> >   602
> >   git grep "\-pwm" -- arch/*/boot/dts | wc -l
> >   856
> > 
> > What makes this particular device different to all of the others?
> >
> 
> Hi Lee,
> 
> this would be the final DTS following the "simple-mfd" pattern.
> 
> Can you confirm it's correct?

I can't confirm that it's 100% correct, but it looks okay to me.

> mfd: system-controller@1fbf0200 {

Not sure about the mfd: label though.

What is the device?

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
> 	gpio-ranges = <&mfd 0 13 47>;
> 
> 	#pwm-cells = <3>;
>  
> 	pio: pinctrl {
> 		compatible = "airoha,en7581-pinctrl";
>  
> 		mdio_pins: mdio-pins {
> 			mux {
> 				function = "mdio";
> 				groups = "mdio";
> 			};
>  
> 			conf {
> 				pins = "gpio2";
> 				output-high;
> 			};
> 		};
>  
> 		pcie0_rst_pins: pcie0-rst-pins {
> 			conf {
> 				pins = "pcie_reset0";
> 				drive-open-drain = <1>;
> 			};
> 		};
>  
> 		pcie1_rst_pins: pcie1-rst-pins {
> 			conf {
> 				pins = "pcie_reset1";
> 				drive-open-drain = <1>;
> 			};
> 		};
> 	};
>  
> 	pwm {
> 		compatible = "airoha,en7581-pwm";
> 	};
> };
> 
> -- 
> 	Ansuel

-- 
Lee Jones [李琼斯]

