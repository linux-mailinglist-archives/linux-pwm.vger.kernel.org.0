Return-Path: <linux-pwm+bounces-5889-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE750AB30AE
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 09:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519621664F3
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8295255F3F;
	Mon, 12 May 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="wB5ylTkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyjdWGF3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042117D2;
	Mon, 12 May 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747035597; cv=none; b=GxguhlCpnNMBDDS+iXXu8ZiKFwxmFiO29rZoVyMLEMWk7bP0D4WVJZkIUphZ9NZ4uPctBUHSUZQdD8HK/qKq5rt7RXhiLNk4ww6W04w3s7a1vl7GbjbXGI3vl0HFGX+806ZwL+ke4d1YBabzS7mtORaJJaPTILQdC/A/mAy8vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747035597; c=relaxed/simple;
	bh=FpVaSSarq4tcR4f2QJcjnTtngywjOYPRDDa3yoClAqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1ITOhmiOxxZpprsDjVDJ8evdGJWHNe0AyUxHKXasjuGbP+r7Wwj09DaK+H655iJCpWPTQFTLVt0TqmXnJWtZTq8C1vs/PR/FQ7H4NyZBCiSFY8MiQeLabigyO1q//5h3sDXVM87YBTXURsh+WiHrq5FoMMfrytGrWCgvAM5hT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=wB5ylTkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iyjdWGF3; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BD72413801E3;
	Mon, 12 May 2025 03:39:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 03:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747035593;
	 x=1747121993; bh=U6UHBQYTizP3JHafrKXPBXsDjdabH/MRB1uEvjLFgtY=; b=
	wB5ylTkW3CX/y03eygW5LVB4uVnwSG+EBG2fWO+ir9UUUHbITHtSsNqo3zEyNoh2
	SlUqvx5ptvRYrv5Rk488ZANdcyErdw6y/yEGN5seoKkQLAx3Y5X+VHf8ddTRFCG7
	fLgeTWdTqfQUP2KrYRYOIijzmgkCjDCa0q3wDsRTRalE+khrxV1WWPGMwWUjnx2T
	S557uo4BDb8BCCe55+eVMZXRzVDdjv0cPn/Dv0TBviEZRDRfRxUSEhawU3dCMG2N
	bv1yWcDRPKJYloUB+76FWbhEAp1bTGdCb6e5ZwHoOvVoOI4D0V25SqTEMYpEWW4P
	Wwwsd5e0HLPgN1V7WNUG9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747035593; x=
	1747121993; bh=U6UHBQYTizP3JHafrKXPBXsDjdabH/MRB1uEvjLFgtY=; b=i
	yjdWGF3AJ96SAs2zGoqbF8OS7cagWRUAMc/u0QDVlS/UkTx/7nBBaG9+JM0AaC7P
	fps6xCfI/iMRXLnNMVEHUGoHZlYpLw/eG/60mGUKumJLpmOdEOq5bvn+5w7cySe7
	Q+NCKsnEoG90hRapmRnhXzo35AkiOXPb/5//wbWJU20kbJI4FhygZPLa++kWQSz5
	SRub/Cl7VO/FydmN5/aK32f3VB/WdVuyfofKW9XJilcgyx21H+LvoTEAfbvEfehr
	gychjjp12JhEQRlENVMP4orUA6MfR2P1md/+JRD0XnqMbFC7b+AyQuWrjR1Zzzg3
	fz5Z3PxymeJ19YXnEzweQ==
X-ME-Sender: <xms:yKUhaIyq3iQqLbpJMcGLhZ4cICe8BhS2DvWlqXwl0LJmzRObyWVd-Q>
    <xme:yKUhaMSBDqnbAqflb_L0ABnnsGbNGU7AkZ06DRzuJTNMw9ygsv33J7f3695i0E-KA
    2vv_pFdr50v8tRJisU>
X-ME-Received: <xmr:yKUhaKWw05MYx4yKkWopxRJava5VRpLI6YMb85j3FF8AgPjXMjhCMldb1Ys2YsRzSd_01hheEXMsrGa0z8GQS3FZ-orYkMLX7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrsh
    houggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeev
    teegtddvvdfhtdekgefhfeefheetheekkeegfeejudeiudeuleegtdehkeekteenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdr
    shhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtphhtthhopeelpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhnihhnohhrihdrmhhorhhimhho
    thhordhggiesrhgvnhgvshgrshdrtghomhdprhgtphhtthhopehukhhlvghinhgvkheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghr
    mhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsg
    gvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphht
    thhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrvghnvghs
    rghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghijhhurd
    gurghsrdhjiiessghprdhrvghnvghsrghsrdgtohhm
X-ME-Proxy: <xmx:yKUhaGjg1VRAJdwAS1npQ6i0sEynWXh6ywcpxE0d0P3QVTY_jw5IxA>
    <xmx:yKUhaKDA0ZIuXCpGMHRjdQstx_ERPLeySTXWl7NdhNj3u52olSMJnA>
    <xmx:yKUhaHJgxcqUuMYFPjMCA0hXYOEDU9pr7MMVsXDFfTK_45TVn9rYeQ>
    <xmx:yKUhaBAOZuL9sR_rg-7WSsS34E9Y7muur31dJWq4weq-ve3H5uI-yA>
    <xmx:yaUhaKXhxI9Ap5xcy1DNxTykOUgrGQpTgV5UCiXO77hVRzhOmq-JHXTu>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 03:39:51 -0400 (EDT)
Date: Mon, 12 May 2025 09:39:49 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: =?utf-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <ukleinek@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
Message-ID: <20250512073949.GC2365307@ragnatech.se>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>

Hi Morimoto-san,

I like cleanup patches!

On 2025-05-12 06:33:12 +0000, Kuninori Morimoto wrote:
> Because current PWM Kconfig is sorting by symbol name,
> it looks strange ordering in menuconfig.
> 
> =>	[ ]   Renesas R-Car PWM support
> =>	[ ]   Renesas TPU PWM support
> 	[ ]   Rockchip PWM support
> =>	[ ]   Renesas RZ/G2L General PWM Timer support
> =>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
> 
> Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
> and sort it.

I think you also need to update the symbol names in the various config 
files found in tree. A quick look,

    $ git grep CONFIG_PWM_RCAR -- arch
    arch/arm/configs/multi_v7_defconfig:1206:CONFIG_PWM_RCAR=m
    arch/arm/configs/shmobile_defconfig:220:CONFIG_PWM_RCAR=y
    arch/arm64/configs/defconfig:1553:CONFIG_PWM_RCAR=m

    $ git grep CONFIG_PWM_RZG2L_GPT -- arch
    arch/arm64/configs/defconfig:1534:CONFIG_PWM_RZG2L_GPT=m

    $ git grep CONFIG_PWM_RZ_MTU3 -- arch
    arch/arm64/configs/defconfig:1556:CONFIG_PWM_RZ_MTU3=m

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 	- Based on linux-next/master
> 
>  arch/arm/configs/multi_v7_defconfig |  2 +-
>  arch/arm/configs/shmobile_defconfig |  2 +-
>  arch/arm64/configs/defconfig        |  6 ++--
>  drivers/pwm/Kconfig                 | 44 ++++++++++++++---------------
>  drivers/pwm/Makefile                |  6 ++--
>  5 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index dc4b722ad4b5..50c170b4619f 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1184,7 +1184,7 @@ CONFIG_PWM_BCM2835=y
>  CONFIG_PWM_BRCMSTB=m
>  CONFIG_PWM_FSL_FTM=m
>  CONFIG_PWM_MESON=m
> -CONFIG_PWM_RCAR=m
> +CONFIG_PWM_RENESAS_RCAR=m
>  CONFIG_PWM_RENESAS_TPU=y
>  CONFIG_PWM_ROCKCHIP=m
>  CONFIG_PWM_SAMSUNG=m
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 0ea34d5d797c..7c3d6a8f0038 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -203,7 +203,7 @@ CONFIG_RZ_DMAC=y
>  CONFIG_IIO=y
>  CONFIG_AK8975=y
>  CONFIG_PWM=y
> -CONFIG_PWM_RCAR=y
> +CONFIG_PWM_RENESAS_RCAR=y
>  CONFIG_PWM_RENESAS_TPU=y
>  CONFIG_PHY_RCAR_GEN2=y
>  CONFIG_PHY_RCAR_GEN3_USB2=y
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d0768584647c..fe021cbb6393 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1536,11 +1536,11 @@ CONFIG_PWM_IMX27=m
>  CONFIG_PWM_MESON=m
>  CONFIG_PWM_MTK_DISP=m
>  CONFIG_PWM_MEDIATEK=m
> -CONFIG_PWM_RCAR=m
> +CONFIG_PWM_RENESAS_RCAR=m
> +CONFIG_PWM_RENESAS_RZG2L_GPT=m
> +CONFIG_PWM_RENESAS_RZ_MTU3=m
>  CONFIG_PWM_RENESAS_TPU=m
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_PWM_RZG2L_GPT=m
> -CONFIG_PWM_RZ_MTU3=m
>  CONFIG_PWM_SAMSUNG=y
>  CONFIG_PWM_SL28CPLD=m
>  CONFIG_PWM_SUN4I=m
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c866ed388da9..d9bcd1e8413e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -534,7 +534,7 @@ config PWM_RASPBERRYPI_POE
>  	  Enable Raspberry Pi firmware controller PWM bus used to control the
>  	  official RPI PoE hat
>  
> -config PWM_RCAR
> +config PWM_RENESAS_RCAR
>  	tristate "Renesas R-Car PWM support"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on HAS_IOMEM
> @@ -545,26 +545,7 @@ config PWM_RCAR
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rcar.
>  
> -config PWM_RENESAS_TPU
> -	tristate "Renesas TPU PWM support"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
> -	  in Renesas chips through the PWM API.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called pwm-renesas-tpu.
> -
> -config PWM_ROCKCHIP
> -	tristate "Rockchip PWM support"
> -	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  Generic PWM framework driver for the PWM controller found on
> -	  Rockchip SoCs.
> -
> -config PWM_RZG2L_GPT
> +config PWM_RENESAS_RZG2L_GPT
>  	tristate "Renesas RZ/G2L General PWM Timer support"
>  	depends on ARCH_RZG2L || COMPILE_TEST
>  	depends on HAS_IOMEM
> @@ -575,7 +556,7 @@ config PWM_RZG2L_GPT
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rzg2l-gpt.
>  
> -config PWM_RZ_MTU3
> +config PWM_RENESAS_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>  	depends on RZ_MTU3
>  	depends on HAS_IOMEM
> @@ -586,6 +567,25 @@ config PWM_RZ_MTU3
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rz-mtu3.
>  
> +config PWM_RENESAS_TPU
> +	tristate "Renesas TPU PWM support"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
> +	  in Renesas chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-renesas-tpu.
> +
> +config PWM_ROCKCHIP
> +	tristate "Rockchip PWM support"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for the PWM controller found on
> +	  Rockchip SoCs.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5c782af8f49b..96160f4257fc 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -48,11 +48,11 @@ obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
>  obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
> -obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
> +obj-$(CONFIG_PWM_RENESAS_RCAR)	+= pwm-rcar.o
> +obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
> +obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
> -obj-$(CONFIG_PWM_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
> -obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
> -- 
> 2.43.0
> 
> 

-- 
Kind Regards,
Niklas Söderlund

