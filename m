Return-Path: <linux-pwm+bounces-4073-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718919C5C37
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1E3B800B2
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE410200118;
	Tue, 12 Nov 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQkBdyJI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4D20010A;
	Tue, 12 Nov 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422673; cv=none; b=KPHJnNRihufnqR/HcUhNJrAcaTL5/iodm8aZttaBWLmew9TSHaRo2dmbvBfrP2Z2HcXesszgHBLghW/Y/03d+WA9cNpvDsVQ7uMrNdm6ukvfzLyzgMxmtdEWb96AMqMmY/3BnyttZtiSYEvAR1mCn61rrU7Ul0X6PgJvMYDRdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422673; c=relaxed/simple;
	bh=EjPK34+AC2Pfhya/hAO/+gef3LLKikFCHohkMhTY3fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH0O+723Y20RYot48oSYP9IrMq8HCzRdFIhkbSgK/1k65WQRneevcZswg/HFiLARmMl3KOmaQivBnS+LQRf1XBVtjKtRvDIkPrI29Kv3OeQYqp7GVb4+o00dcTvkalvNXylVTHW2ytVIfFRvyeDC4VNk+Cb0tNZc+6/twJfhO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQkBdyJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8B7C4CED0;
	Tue, 12 Nov 2024 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422673;
	bh=EjPK34+AC2Pfhya/hAO/+gef3LLKikFCHohkMhTY3fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQkBdyJIPNx6GWYU+T7x82rGzvF8PeuQfl+zs/tOQRDrp2LJbaCDsytTuAlUH0nKQ
	 CrX2QB6TyMhise0BmTtJRqJrEqwTUYLiVqRKSdXW8kTwoM5jYxXrY9mtWd73RAmiu7
	 sXIhil1Q71nmi0K7oCMXIt8/aSH3EMQJuRs/RLsPuxJfNYmamJXsHZjRZYlLafXb1q
	 nXE/pO6NON06KK6vDHDkJBqa2QPHDH/Isva5SRn4c2+qPRcGBZ5Yh6fG1JOZOKQI45
	 MGy11AdgoqVsSGitWcvmduyYXmzKW+UEbGvYdnWMyWg4itCsl3YzwMhegY+dty5nZ6
	 h7LyGhAFVB9Ig==
Date: Tue, 12 Nov 2024 14:44:27 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: (subset) [PATCH v9 4/6] dt-bindings: mfd: Add support for Airoha
 EN7581 GPIO System Controller
Message-ID: <20241112144427.GI8552@google.com>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-4-afb0cbcab0ec@kernel.org>
 <173088099542.3237297.18018729158887853624.b4-ty@kernel.org>
 <ZyssJpR7xwbMzUsm@lore-desk>
 <20241106110046.GR1807686@google.com>
 <CACRpkdbf4Pb+n-F-K-JaUvytwCGUHHh8d2rYP4A9KgVTzqSnGw@mail.gmail.com>
 <20241111165120.GD8552@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111165120.GD8552@google.com>

On Mon, 11 Nov 2024, Lee Jones wrote:

> On Wed, 06 Nov 2024, Linus Walleij wrote:
> 
> > On Wed, Nov 6, 2024 at 12:00 PM Lee Jones <lee@kernel.org> wrote:
> > > On Wed, 06 Nov 2024, Lorenzo Bianconi wrote:
> > >
> > > > On Nov 06, Lee Jones wrote:
> > > > > On Wed, 23 Oct 2024 01:20:04 +0200, Lorenzo Bianconi wrote:
> > > > > > Add support for Airoha EN7581 GPIO System Controller which provide a
> > > > > > register map for controlling the GPIO, pinctrl and PWM of the SoC via
> > > > > > dedicated pinctrl and pwm child nodes.
> > > > > >
> > > > > >
> > > > >
> > > > > Applied, thanks!
> > > > >
> > > > > [4/6] dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Controller
> > > > >       commit: f49f37f3cfe1482d4dc77d26f3e8c38eab630d52
> > > > >
> > > > > --
> > > > > Lee Jones [李琼斯]
> > > > >
> > > >
> > > > Hi Lee,
> > > >
> > > > according to my understanding this patch has been already applied by Linus
> > > > here:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=devel&id=50dedb1eb1e6755ccab55f6140916c2d192be765
> > >
> > > An interesting choice.  Linus?
> > 
> > Yes I suggested that I merge patches 1-5 on oct 29 and applied the
> > day after:
> > https://lore.kernel.org/linux-gpio/CACRpkdYshPusdA7bDW2y8H_wp-Fm3N-YCsY1_Qn=dZqRiFy12w@mail.gmail.com/
> > 
> > It's because the bindings are dependent on each other, this one patch has:
> > 
> > +  pinctrl:
> > +    type: object
> > +    $ref: /schemas/pinctrl/airoha,en7581-pinctrl.yaml
> > +    description:
> > +      Child node definition for EN7581 Pin controller
> > +
> > +  pwm:
> > +    type: object
> > +    $ref: /schemas/pwm/airoha,en7581-pwm.yaml
> > +    description:
> > +      Child node definition for EN7581 PWM controller
> > 
> > Those refs will explode unless the two others are merged at the same
> > time.
> > 
> > Usually we merge the whole shebang through MFD but this one felt
> > different because there is no actual MFD driver, just using simple-mfd.
> > 
> > In hindsight I should probs not have been so trigger happy and give
> > some more time for this to settle... Merge window stress I guess. :/
> > 
> > It's fine to apply textually identical patches to two trees though as
> > git will sort
> > that out so technically it's no big deal, you can keep it applied if you
> > want.
> 
> It's okay.  Life will be easier for everyone if I remove it.

Okay, I dropped it from my tree.

Next time I would like a say/opportunity to Ack please.

-- 
Lee Jones [李琼斯]

