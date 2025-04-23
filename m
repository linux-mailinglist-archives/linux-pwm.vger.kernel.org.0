Return-Path: <linux-pwm+bounces-5677-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D0A9944E
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B221BA7D6F
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B328DEEA;
	Wed, 23 Apr 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF6z6ujC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762D289359;
	Wed, 23 Apr 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422862; cv=none; b=KDU7jAbLOWlzKyz3vLXzlxDPXD1Y87KGTYjJxxS/+OASfVScGRZtDJnmK92US3BwIjiO1T7g6p8OEWQJpaHEbxWQnCTNgBeVzNHUCRKl5QLsYPJXuJhKSNwO6L167DeYrf9ADH0+/uoLmLa0flTvqq1toRmUFGIXKKawrciIqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422862; c=relaxed/simple;
	bh=ERyjr27hGL4DKu520p+lnJcSombmkSYoRmQUhyArPT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti6QvEuZ/wv4oWchDvv3Jddiv9ejkHWELjWRzuT2Y2BhrbHpO+ICvZGbT2Nmi3HGaiJVtcMtIdk4wtBzPNO6TLFOjBzBAbEwuXZG0XlW+lcVmSdeg/CRE9E8Km3gSxhX5dF48vCicAEelxZu6V6HTRvBhVOTrl0DJWej/gjkV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF6z6ujC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB82C4CEE2;
	Wed, 23 Apr 2025 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422861;
	bh=ERyjr27hGL4DKu520p+lnJcSombmkSYoRmQUhyArPT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lF6z6ujCQiNWGWZ+GJRZCdwDz3m9udIxxNLIwteB6pkVucQDIcVL39LXdrkpgmcHs
	 NU3jd26BpNpHWjXuefwLSLmESkRcL2Lkkdtpg6o12onX6/4/nmuHLYA5IqtsrxFb3y
	 tzbQZRV5G6p9IJyf0c3EIe3y+u8SSKpjDgly2HBmGeanm7Qy7iGLlp2l6iIq63axpW
	 fWiEiieVheQeRkGCgVrVcH3nQ+9TcINtQ7oURNBy3eCle7ciRVvJWpLdYjEMX0b+x4
	 mbIn7BZex1D89baBOlK9kW8V3AldU4yIFz9IppzT9I6v/6R0wR2RO7qANgCsMLnnpL
	 xwiuePUNzpONg==
Date: Wed, 23 Apr 2025 10:40:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: p.zabel@pengutronix.de, hal.feng@starfivetech.com, elder@riscstar.com,
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
	paul.walmsley@sifive.com, spacemit@lists.linux.dev,
	conor+dt@kernel.org, dlan@gentoo.org, inochiama@gmail.com,
	palmer@dabbelt.com, linux-pwm@vger.kernel.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, drew@pdp7.com,
	devicetree@vger.kernel.org, geert+renesas@glider.be,
	krzk+dt@kernel.org, heylenay@4d2.org, duje.mihanovic@skole.hr,
	ukleinek@kernel.org, alex@ghiti.fr, unicorn_wang@outlook.com
Subject: Re: [PATCH v2 1/6] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT
 K1 PWM support
Message-ID: <174542285923.570390.16199020429609870497.robh@kernel.org>
References: <20250420070251.378950-1-guodong@riscstar.com>
 <20250420070251.378950-2-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420070251.378950-2-guodong@riscstar.com>


On Sun, 20 Apr 2025 15:02:46 +0800, Guodong Xu wrote:
> The SpacemiT K1 SoC reuses the Marvell PXA910-compatible PWM controller
> with one notable difference: the addition of a resets property. To make
> the device tree pass schema validation (make dtbs_check W=3), this patch
> updates the binding to accept spacemit,k1-pwm as a compatible string, when
> used in conjunction with the fallback marvell,pxa910-pwm.
> 
> Support for the optional resets property is also added, as it is required
> by the K1 integration but was not present in the original Marvell bindings.
> 
> Since the PWM reset line may be deasserted during the early bootloader
> stage, making the resets property optional avoids potential
> double-deassertion, which could otherwise cause flickering on displays
> that use PWM for backlight control.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: Accept spacemit,k1-pwm as a compatible string, when used in conjunction
>     with the fallback marvell,pxa910-pwm
> 
> .../bindings/pwm/marvell,pxa-pwm.yaml           | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


