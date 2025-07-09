Return-Path: <linux-pwm+bounces-6797-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4909CAFE002
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF56C7B3632
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 06:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3125B26B750;
	Wed,  9 Jul 2025 06:37:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925526B741;
	Wed,  9 Jul 2025 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043067; cv=none; b=FMJmgyKodtkrBrZPKCrcKqxhoEw05ipE8sUFY7lmimfaDDLpDk18C1dwifFzrhHI0lvWKfoFp/ozMU03RtQnUJVUqh3aLcrsQ3fl1IPpYqHL1x+HhFQ4EQ9EZR371v+oP6yuyhVp4XO1OsDYvdcPUMt9neUG3WnSeBK1IXfbsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043067; c=relaxed/simple;
	bh=xeDoGCEhKBLAJ0n4b59kBuImWVwW2II1d4l3b934NIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+iny/Vg6GqDeymML3CkcTvFL46OzXr8AJauPskmzLYKk3VlEB0cNxSTsbGWj0JOWYYNpYTgRlLvPOxTzin8/C+JrDD9pIALIMbAkYquXYwjfCPkw2tUYc515W8OaCvsSsO3JzSVTw2fZXOnhThTZALg+wkYAhdIy/GTx8uonTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 531B0342289;
	Wed, 09 Jul 2025 06:37:43 +0000 (UTC)
Date: Wed, 9 Jul 2025 06:37:38 +0000
From: Yixun Lan <dlan@gentoo.org>
To: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, inochiama@gmail.com, geert+renesas@glider.be,
	heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com, Guodong Xu <guodong@riscstar.com>
Cc: elder@riscstar.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: (subset) [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT
 K1
Message-ID: <20250709063738-GYA488894@gentoo>
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <175198458423.86859.5882458274157023095.b4-ty@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175198458423.86859.5882458274157023095.b4-ty@gentoo.org>

Hi Guodong,

On 22:33 Tue 08 Jul     , Yixun Lan wrote:
> 
> On Tue, 29 Apr 2025 16:50:42 +0800, Guodong Xu wrote:
> > This patchset adds support for the SpacemiT K1 SoC in the PWM_PXA driver
> > and updates related device tree bindings. The changes enable PWM
> > functionality on the K1 platform through driver enhancements,
> > configuration updates, and device tree additions.
> > 
> > Functionality has been verified on the Banana Pi BPI-F3 board using PWM14,
> > configured as a pwm-backlight. Per community feedback, the actual
> > pwm-backlight node is not included in this patchset but can be found in
> > patch 7 of the v1 series, with modification of pwms property to 4-cell
> > format to match updated binding (#pwm-cells = <3>) since v3.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [3/6] riscv: dts: spacemit: add PWM support for K1 SoC
>       https://github.com/spacemit-com/linux/commit/9aebdfc21f755e0d2766683aa251435fb656ea47

found have to re-arrange the nodes according to ascending order of unit address,
so here is new version I've pushed, just FYI, please check (should have
no functionality changes)
       https://github.com/spacemit-com/linux/commit/66f56c7a64213948341521b5310064586a05c80e

> [4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
>       https://github.com/spacemit-com/linux/commit/8709d51024068d4c81dc785d63169d283d147cf3

-- 
Yixun Lan (dlan)

