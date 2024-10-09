Return-Path: <linux-pwm+bounces-3565-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ECE9967D0
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1171F2195B
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648619066B;
	Wed,  9 Oct 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE3Tiall"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699019048F;
	Wed,  9 Oct 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471363; cv=none; b=kX1zZOYCAFjU333DJAyu/tDkvJ8C6jrBxElSrDFEBw8P+NMSZR1tQE7BvmW0G4Y/Z5HU3qg6hv4ufZ4wlKhqOLsUfwbnnUafNqC7YeO/sCV1lvpjSXTkO0o30IqTTyDvgo/c9ZztmGga8xu2Kk7PWksiLIsHtmidRPPTf2fNnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471363; c=relaxed/simple;
	bh=iTfwPek46U0n5ya6D6iZcyM9CFuS7Bf6w/iiLN1DXJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgU3ysXGFS+9XJTwjaJdmg1VLgGRIx/qpyW2ubBlo+02xkZwTIieQofk19CIYbTutNHhpff47oBtGm9WLe5ax8cUbmasyUzomKudVkv9n23EYFRRDGqrXK3TzMsgUOgKsPhJ5HdzWKMxhv6K+0ac3kxJqxAuj2IKml4o6NmBlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE3Tiall; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48AEC4CECC;
	Wed,  9 Oct 2024 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728471362;
	bh=iTfwPek46U0n5ya6D6iZcyM9CFuS7Bf6w/iiLN1DXJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eE3Tiall50C2INIwqukLY+x5A5aZ/znduHmY737eecjqO6cncLv5VmqkafjZD+T9t
	 BbPL5x9tpgujQBaTx1ra5XRWU/6W9iiqleguDncwQIoRrZi2Vo4Pk+JFErOtGA2A/u
	 5ulpLLbiBYa2O1XH/meRlDvuCMz53qAQItX1zGx9MX97wI2JZ4FgqjUwPpwbTD4J9y
	 65SmjcHRa2V+dFnDeXSB6kHcPRnXO5BzvmOZqHH2zWUA4iIbqzsd61a3Qoq/WaX2qB
	 iaSP86dvVMnTmuh21Hi+CrKZvnHdkladZoCWQV2anUy9RFmHxg+ZEGZjh/vsaLItko
	 juH2VjnPnzrZg==
Date: Wed, 9 Oct 2024 11:55:50 +0100
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
Message-ID: <20241009105550.GG276481@google.com>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk>
 <20241009104821.GF276481@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009104821.GF276481@google.com>

On Wed, 09 Oct 2024, Lee Jones wrote:

> On Wed, 09 Oct 2024, Lorenzo Bianconi wrote:
> 
> > On Oct 02, Lee Jones wrote:
> > > On Tue, 01 Oct 2024, Lorenzo Bianconi wrote:
> > > 
> > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > 
> > > > Support for Airoha EN7581 Multi Function Device that
> > > > expose PINCTRL functionality and PWM functionality.
> > > 
> > > The device is a jumble of pinctrl registers, some of which can oscillate.
> > > 
> > > This is *still* not an MFD.
> > > 
> > > If you wish to spread this functionality over 2 drivers, use syscon to
> > > obtain the registers and simple-mfd to automatically probe the drivers.
> > 
> > Hi Lee,
> > 
> > IIUC you are suggesting two possible approaches here:
> > 
> > 1- have a single driver implementing both pinctrl and pwm functionalities.
> >    This approach will not let us reuse the code for future devices that
> >    have just one of them in common, like pwm (but we can live with that).
> 
> If you can have one without the other, then they are separate devices.
> 
> > 2- use a device node like the one below (something similar to [0])
> > 
> > system-controller@1fbf0200 {
> > 	compatible = "syscon", "simple-mfd";
> > 	reg = <0x0 0x1fbf0200 0x0 0xc0>;
> > 
> > 	interrupt-parent = <&gic>;
> > 	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > 	gpio-controller;
> > 	#gpio-cells = <2>;
> > 
> > 	interrupt-controller;
> > 	#interrupt-cells = <2>;
> > 
> > 	pio: pinctrl {
> > 		compatible = "airoha,en7581-pinctrl";
> > 
> > 		[ some pinctrl properties here ]
> > 	};
> > 
> > 	#pwm-cells = <3>;
> > 
> > 	pwm {
> > 		compatible = "airoha,en7581-pwm";
> > 	};
> > };
> > 
> > Please correct me if I am wrong, but using syscon/simple-mfd as compatible
> > string for the 'parent' device, will require to introduce the compatible strings
> > even for the child devices in order to probe them, correct? 
> > If so, as pointed out by Christian, this is something nacked by Rob/Krzysztof/Conor
> > (this is the main reason why we introduced a full mfd driver here).
> > 
> > @Rob, Krzysztof, Conor: am I right?
> 
> I don't see why separate functionality shouldn't have separate
> compatible strings, even if the registers are together.  Register layout
> and functionality separation are not related.

We've been happy to support both pinctrl and pwm devices before:

  git grep "\-pinctrl\|\-pwm" -- drivers/mfd
  git grep "\-pinctrl\|\-pwm" -- arch/*/boot/dts

  git grep "\-pinctrl" -- arch/*/boot/dts | wc -l
  602
  git grep "\-pwm" -- arch/*/boot/dts | wc -l
  856

What makes this particular device different to all of the others?

-- 
Lee Jones [李琼斯]

