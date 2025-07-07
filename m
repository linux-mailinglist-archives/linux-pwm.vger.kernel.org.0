Return-Path: <linux-pwm+bounces-6764-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E8AFBE3C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 00:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311867A2055
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF7261595;
	Mon,  7 Jul 2025 22:29:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3982186A;
	Mon,  7 Jul 2025 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927358; cv=none; b=cld3INtt372+Xc2DxIOPKs27ScJ+NusaEejOo69FsbGCivo1zRZewVRWYRg8tq8RJxgOauBGUy4xctIK2MzLKYTiGwufElOQkP10aTNCWr2FJ86uikcpqUgcHqOYKQUPBo/LS9sp3fdg8QEs+xzSplEqO0jDKOdQZPznR1f7JFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927358; c=relaxed/simple;
	bh=MDF8zUlS1Pi0x+G3G5UDKyYb4IezZltpmz4zl1fscw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owZXkTXi+RPvvXBGrLK4d1ZomjhXnldGpw2XZXLyNrD06PFRzpbE6AtsUosUmR0nPf/mIURVToYLKsytTBjs4AkRgSjHG14AZ0GZGaBsSdFULsGEIrvzlVtSOypuSniPlNVhw0PdMyzKF6WxLcjl3RF0N9/bFLVJGQzWyz70B0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 156F6340F39;
	Mon, 07 Jul 2025 22:29:14 +0000 (UTC)
Date: Mon, 7 Jul 2025 22:29:10 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, ukleinek@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, inochiama@gmail.com, geert+renesas@glider.be,
	heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com, elder@riscstar.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v3 6/6] riscv: defconfig: Enable PWM support for SpacemiT
 K1 SoC
Message-ID: <20250707222910-GYC408198@gentoo>
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <20250429085048.1310409-7-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429085048.1310409-7-guodong@riscstar.com>

Hi Conor,
  Can you take this patch? I've checked with riscv's tree for-next
branch, it's still applicable and meet the "savedefconfig" criteria.
  Thanks

On 16:50 Tue 29 Apr     , Guodong Xu wrote:
> Enable CONFIG_PWM and CONFIG_PWM_PXA in the defconfig
> to support the PWM controller used on the SpacemiT K1 SoC.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Yixun Lan <dlan@gentoo.org>

> ---
> v3: No change
> v2: Changed PWM_PXA from built-in to a loadable module (=m)
> 
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 3c8e16d71e17..3c4d9bb8f01e 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -257,6 +257,8 @@ CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
>  CONFIG_PM_DEVFREQ=y
>  CONFIG_IIO=y
> +CONFIG_PWM=y
> +CONFIG_PWM_PXA=m
>  CONFIG_THEAD_C900_ACLINT_SSWI=y
>  CONFIG_PHY_SUN4I_USB=m
>  CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

