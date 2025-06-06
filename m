Return-Path: <linux-pwm+bounces-6250-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4FAACFB2B
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCF51895F38
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 02:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1273EA63;
	Fri,  6 Jun 2025 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO0Wxtgs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD175C96;
	Fri,  6 Jun 2025 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749176187; cv=none; b=EIb5Va6YJ45Ht7d100b/qGoJLroepa5X04J8Fk7mQ4gtufTthY621DbENsn20nKsdby6t4zJ3CM3Iw1gtwB02K0ruTkJCyAUoU6Ki6qrNSlXQcCcC/vTmV8rKmPws+umpLGO3rTIf+TAASLemNv46F7p2duf24ncRQWrCPKlONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749176187; c=relaxed/simple;
	bh=wLz27OhmpWOMF3fZD3h6HrziarJBuqb8KFTIz16hHw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJnPHm/JdS0r5KqAYchRwj1sDD9ZneNutv+dcDnoAj168oO1Muj0QLOj4b2W89KOcv7O19fhIvUyruJrz3KtVmzmbTTQCi+N6vPjEzB+gNKj3RNGx+uRrfofqGj9/kLyl9EDYsYLQaBANaiT2Uikdw+WlmboT7TdC8aF8jtuUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO0Wxtgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC362C4CEE7;
	Fri,  6 Jun 2025 02:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749176187;
	bh=wLz27OhmpWOMF3fZD3h6HrziarJBuqb8KFTIz16hHw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UO0WxtgspT3sXf83z00pbvllyXup00F2TBOsDTsnrDvz7k6/tNj2tS5ONZKgsPIs8
	 15wuH6zUVfYCe+nMzxk1cK71LSsghqiqDyLh5jhrgxtbCKwfmHL3QZ0+NUcTolc27o
	 3/dVaPwhsm+pjURPXv5Po9fGfd/aU+MdE1Xt6KCvZ4E7HeUyEYZ017Ko0QpdEe/Sc3
	 +4kiBCJylIRv0UeE8KoSEQQgpL2jA64C6BRnodYo9RUahwvE0omYECytN4eiCsJw1F
	 58BGmv4K2IGDP1n6yhBuK176Jlu94Ea+nW5yYj8jcsw5DPORs6bRZiqyC/ThFfp1VL
	 CwM4Jt1sxwAuw==
Date: Thu, 5 Jun 2025 21:16:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>, linux-pwm@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dave Ertman <david.m.ertman@intel.com>, devicetree@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	William Breathitt Gray <wbg@kernel.org>, linux-iio@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Message-ID: <174917618272.3791802.11051043079285296957.robh@kernel.org>
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-2-a6434b0ce60c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-rk3576-pwm-v2-2-a6434b0ce60c@collabora.com>


On Mon, 02 Jun 2025 18:19:13 +0200, Nicolas Frattaroli wrote:
> The Rockchip RK3576 SoC has a newer PWM controller IP revision than
> previous Rockchip SoCs. This IP, called "PWMv4" by Rockchip, introduces
> several new features, and consequently differs in its bindings.
> 
> Instead of expanding the ever-growing rockchip-pwm binding that already
> has an if-condition, add an entirely new binding to handle this.
> 
> There are two additional clocks, "osc" and "rc". These are available for
> every PWM instance, and the PWM hardware can switch between the "pwm",
> "osc" and "rc" clock at runtime.
> 
> The PWM controller also comes with an interrupt now. This interrupt is
> used to signal various conditions.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/pwm/rockchip,rk3576-pwm.yaml          | 77 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 84 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


