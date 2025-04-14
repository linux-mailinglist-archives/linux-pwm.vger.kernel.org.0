Return-Path: <linux-pwm+bounces-5475-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B432A879B3
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A823AC05B
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610931FECAB;
	Mon, 14 Apr 2025 08:03:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757F42077;
	Mon, 14 Apr 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617837; cv=none; b=J/6en4528Vp5YimmwFimoONQ59ZoafPbGrjDcQRcFIC/1aasM1124uTyhLaOk1sFQL+eJaWLSjRWYhgB6IpncGjYMA6JnohEefDF5E1eH+4SFxK6yOsrmHi+cjauy8uzSrN9UfIW2DXMajYas/IO8p4p2BBpSN7cAj6j9GCgaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617837; c=relaxed/simple;
	bh=UUj7ArAKKBHBo3T95CmKN7qumBdR3O7wa+qSurIRlCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOgS7YI8TZUrIW+wWAQSj9zZ2Qir2LxN+kdR6ihYDYjZ6ajS9vYuz75OB7/ZPtU2J3/ytISNUQwLePeajERA+azPZBLNrgs2yaK9VHIaAgsRUSGds9hwhVHSU+HKAEfaKoh36dO9Ixnnkt7I+DGrQOVtGaoJH8UWwt1Msr0DJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7AD2B343029;
	Mon, 14 Apr 2025 08:03:54 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:03:44 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, inochiama@gmail.com, geert+renesas@glider.be,
	heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	elder@riscstar.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support
 for BPI-F3
Message-ID: <20250414080344-GYA28186@gentoo>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-8-guodong@riscstar.com>
 <5lfnxricxm2k3fuf6nfvjd6cbkmsjkx7inoi52uy5uwwvld7sq@abn4i62tdics>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5lfnxricxm2k3fuf6nfvjd6cbkmsjkx7inoi52uy5uwwvld7sq@abn4i62tdics>

Hi Uwe,

On 07:58 Mon 14 Apr     , Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Apr 11, 2025 at 09:14:21PM +0800, Guodong Xu wrote:
> > +&pwm14 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pwm14_1_cfg>;
> > +	status = "disabled";
> > +};
> 
> I wonder if the pinctrl properties can better be added to the SoC's
> .dtsi file. (Only applies if this is a canonical choice, i.e. there is
> no other possible output configuration.)
> 
I'd agree it's a good idea and should follow, but unfortunately in the
practical case, all pwm able to route to at least two different pins..

https://developer.spacemit.com/documentation?token=YiJZwXA2Ri4nJikV9E1cp6nqnMh
see section: 4.5 Multi-Function I/O Pin Assignments

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

