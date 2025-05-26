Return-Path: <linux-pwm+bounces-6134-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D1AC44FB
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 23:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C435D3BDE28
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491723F42D;
	Mon, 26 May 2025 21:52:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63C17332C;
	Mon, 26 May 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748296370; cv=none; b=iUcK8X7pUJ+JQ16wiRZBXR9LDwT/N7mFiinxTK9z0EK9R0GBQXS213pP58f6RX5aoFW0nxCMLYz/q4dQVeZ1XK9w0SJj4vMWmSwV5bKcxGn+40WbulBDYUnYVGcV2X/kmvmAwJ31if3kjio6qIiv9TJVSBp3eYx8d+xB79AXVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748296370; c=relaxed/simple;
	bh=xuQK2Nzt7v+UIB0/LhGXW8bMIZ25qIag4gy8UdeAwRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hjw1rniPuSf5PbVvnkMLdXHt1DS65UmWQRgED5wae8pHfLPUq3Pizd7B/LV14j9KeA/96cn/SZ3kdSO6k4VtgZ8WC3vghIwbO1MfnVf3jiSm07DIOphwKeRbkNQaP8mEVYf0JkK20MsD30vfXzqRaC2Qx1v+5h7/wkXlxI//xo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id F30B7342FB5;
	Mon, 26 May 2025 21:52:47 +0000 (UTC)
Date: Mon, 26 May 2025 21:52:43 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, inochiama@gmail.com, geert+renesas@glider.be,
	heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com, elder@riscstar.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v3 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
Message-ID: <20250526215243-GYA53128@gentoo>
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <20250429085048.1310409-5-guodong@riscstar.com>
 <paasmwjel652r25nxobidydtpxfjy7emerilmwqhvhtgrrtg6v@gowpzqdzvlfz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <paasmwjel652r25nxobidydtpxfjy7emerilmwqhvhtgrrtg6v@gowpzqdzvlfz>

Hi Guodong, Uwe,

On 18:54 Mon 26 May     , Uwe Kleine-König wrote:
> On Tue, Apr 29, 2025 at 04:50:46PM +0800, Guodong Xu wrote:
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > index 283663647a86..195eb8874f3c 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > @@ -20,4 +20,11 @@ uart0-2-pins {
> >  			drive-strength = <32>;
> >  		};
> >  	};
> > +	pwm14_1_cfg: pwm14-1-cfg {
> > +		pwm14-1-pins {
> > +			pinmux = <K1_PADCONF(44, 4)>;
> > +			bias-pull-up = <0>;
> > +			drive-strength = <32>;
> > +		};
> > +	};
> 
> There is a newline expected before the pwm14-1-cfg node, isn't there?
> 
Right, I could amend this and fix it while applying this patch
(so if there is no other serious issue, no need to resend)

-- 
Yixun Lan (dlan)

