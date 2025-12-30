Return-Path: <linux-pwm+bounces-7833-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0921CEA5FC
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Dec 2025 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0868301D64C
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Dec 2025 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FB32B99C;
	Tue, 30 Dec 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY9gtCTd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19E19E819;
	Tue, 30 Dec 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767117574; cv=none; b=aiskF/x85umbRqKGVae7/3oR/WwB1Q9PuKvVHE5wIcn3USGSYwMGt1/1UZBBEsZ55G1xMy0+B9ZkatX7xhWI3gLJzo7MHGsYmEFKTmJ4QXjol3ny02g9YZ7HHxsVbj7/7WlEpc/Kp3hQbvr96mk5WTRXx6da2yi32yyBJbuloGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767117574; c=relaxed/simple;
	bh=6GrivOnSV9jOqzRDnWFEmYWM9NxqNKhAy4AejbzzLN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFQm8ewBVHuGM/X+IcC893MdLDAmhB5qrp/zVmOPpqNGy3+8wIxldoP658Rz8g4ZY827v889349frKxcj1PWEiBDK46menHCMqoA5qImTAzHjXJzqA4zFRaJj32J4nBk0KvpXInl4iX1mWPBIKxUrYfOzLLlInm9FLaSYvCmOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY9gtCTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAD0C4CEFB;
	Tue, 30 Dec 2025 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767117574;
	bh=6GrivOnSV9jOqzRDnWFEmYWM9NxqNKhAy4AejbzzLN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oY9gtCTddPBLusMLKXjz44ZEQoG70XlxDQlVrLpwqqIhB/iHHkfWJlJgwVnZVgtji
	 40CA0Ucz22UH0WllS4RzbHhfrPVdcRLMytqaZPVKLY+o7xFcEz56r6pq3Um30d6DQh
	 TBBt/Wa+Ljgl9TOiNAZ/8pn7AeShmDaVQDtfUiKS3OW/u0kmhJcC9mklt01yBAxSgP
	 VReAvCEmBmJcy4Ff8mzF9g3LepSGOlvqUjndhZMygqcG6A/3V4MjDDffkBcHz1gu6P
	 BCKCoMLSYaUMvEX9erJXK1hqRzrcMXw7HOPTMcPkW1SHkIpSy5hncCuoCk4/r/0Wx7
	 Fxc3OGu0ZbCkA==
Date: Tue, 30 Dec 2025 11:59:33 -0600
From: Rob Herring <robh@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm: dts: lpc32xx: add clocks property to Motor
 Control PWM device tree node
Message-ID: <20251230175933.GA864856-robh@kernel.org>
References: <20251228224907.1729627-1-vz@mleia.com>
 <20251228224907.1729627-3-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228224907.1729627-3-vz@mleia.com>

On Mon, Dec 29, 2025 at 12:49:07AM +0200, Vladimir Zapolskiy wrote:
> Motor Control PWM depends on its own supply clock, the clock gate control
> is present in TIMCLK_CTRL1 register.

You say it is required, so does that mean this hasn't ever worked? Or it 
happened to work because something else turned on the clock?

> 

Fixes tag?

> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
> index 39af48470ed5..abd401fda94e 100644
> --- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
> @@ -304,6 +304,7 @@ i2c2: i2c@400a8000 {
>  			mpwm: pwm@400e8000 {
>  				compatible = "nxp,lpc3220-motor-pwm";
>  				reg = <0x400e8000 0x78>;
> +				clocks = <&clk LPC32XX_CLK_MCPWM>;
>  				#pwm-cells = <3>;
>  				status = "disabled";
>  			};
> -- 
> 2.43.0
> 

