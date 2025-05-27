Return-Path: <linux-pwm+bounces-6140-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02FCAC46C4
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 05:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85389164F6E
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 03:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097351C5F14;
	Tue, 27 May 2025 03:27:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F41C1F05;
	Tue, 27 May 2025 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748316428; cv=none; b=Qn59ngcx/2oDXovSXtn7XRUQfQMYea0O9GPUo+75RZ6HpjufZ4PbICCQF1Xwd1SI+nc+KfIX5AFNDGYBiYibdphHLrWc8jSJt1cfyGxkHSTFCeJgr7fns91ycnqVtKTVvuDk4DtdQidBknt9CtGpGrvlxSPcO6j3yG3aFTK/SNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748316428; c=relaxed/simple;
	bh=94EB6Hz0o5vXbTHp5TqSHnmCMnH4UkbGM8H8Ipy028I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXb4FU/RAyjq70qFUim+rNOoeQWe8ZwpWpz9uGf4J87+R+8BmsW5TH/OuTmA3d5TvmOXWjp5Ns643ALQGrQh+Iq3yWQkVXUOiiqrInCNAgUY3GMSEMhmGNeXAA3Q23wTocsT4JdUJ09+LiwU0Va9G4/m9A4d6vytxkFHsEWw+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 19E4B340C76;
	Tue, 27 May 2025 03:27:06 +0000 (UTC)
Date: Tue, 27 May 2025 03:27:01 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com,
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org,
	tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com, elder@riscstar.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v3 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
Message-ID: <20250527032701-GYA55693@gentoo>
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <20250429085048.1310409-5-guodong@riscstar.com>
 <paasmwjel652r25nxobidydtpxfjy7emerilmwqhvhtgrrtg6v@gowpzqdzvlfz>
 <20250526215243-GYA53128@gentoo>
 <CAH1PCMZhS4_u3nTdAQDfTTRVJ_61n-OYjmMuv2m4DHYDzGE0XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1PCMZhS4_u3nTdAQDfTTRVJ_61n-OYjmMuv2m4DHYDzGE0XA@mail.gmail.com>

Hi Guodong,

On 10:48 Tue 27 May     , Guodong Xu wrote:
> On Tue, May 27, 2025 at 5:52 AM Yixun Lan <dlan@gentoo.org> wrote:
> >
> > Hi Guodong, Uwe,
> >
> > On 18:54 Mon 26 May     , Uwe Kleine-König wrote:
> > > On Tue, Apr 29, 2025 at 04:50:46PM +0800, Guodong Xu wrote:
> > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > index 283663647a86..195eb8874f3c 100644
> > > > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > @@ -20,4 +20,11 @@ uart0-2-pins {
> > > >                     drive-strength = <32>;
> > > >             };
> > > >     };
> > > > +   pwm14_1_cfg: pwm14-1-cfg {
> > > > +           pwm14-1-pins {
> > > > +                   pinmux = <K1_PADCONF(44, 4)>;
> > > > +                   bias-pull-up = <0>;
> > > > +                   drive-strength = <32>;
> > > > +           };
> > > > +   };
> > >
> > > There is a newline expected before the pwm14-1-cfg node, isn't there?
> > >
> > Right, I could amend this and fix it while applying this patch
> > (so if there is no other serious issue, no need to resend)
> >
> 
> Thanks, Yixun.
> 
> By the way, do you plan to take patches 3 and 4 of this series into
> your tree? They only apply if the SpacemiT reset patchset is applied
> first.
> 
Yes, exactly. The dts patch will go through SpacemiT SoC tree, and we
have to wait untill reset patch series applied.

-- 
Yixun Lan (dlan)

