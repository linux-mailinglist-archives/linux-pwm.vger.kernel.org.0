Return-Path: <linux-pwm+bounces-5485-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685FDA89992
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 12:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DFC3B2820
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3410A1F3BBC;
	Tue, 15 Apr 2025 10:13:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6EB1F181F;
	Tue, 15 Apr 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711983; cv=none; b=C/7TgAZyqf88vytjOSoLvmQGycvPUYNl2ATunYJqAVbg0fejX59NrgtHY5cSJ+5vxqgshCvvVLNhK/aFX6wn8locAGAZLQwXVz+fgnB3q8/GzImmMSdBD4P+zn+4VmIAvEBY6s9v+OAEYVL7/9jvUqmLRPhReTlqRVKkrgBCXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711983; c=relaxed/simple;
	bh=cdpDLy1vtRwmaEa5Kx8WJ0+d1f8Ie+MQo5C6d4zf2GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrfaVBaQex3XCqMi9ETlNGBnmhmLRPPaQnMDpCyS7BsmCS5vFlHIChxUosHswwyiZGG1q6av+AIV5HccDehZQMSjTiEnEh5Vitl+24mwenSNaGziCh0by/k10dPmZouzx21XcijZOHSambEOc7CPvEALpo9UsnI2pEfROV7wGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7E184342FEB;
	Tue, 15 Apr 2025 10:13:00 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:12:49 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor@kernel.org>,
	ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, drew@pdp7.com,
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org,
	tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	elder@riscstar.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
Message-ID: <20250415101249-GYA30674@gentoo>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-2-guodong@riscstar.com>
 <20250411-confider-spinster-35f23040d188@spud>
 <89b6142bacecd4a7742341b88dc1e28c4454527a.camel@pengutronix.de>
 <CAH1PCMZnJDcYKJR35WirQT95hte0NWvGBe4fjDuyZEgagvunAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1PCMZnJDcYKJR35WirQT95hte0NWvGBe4fjDuyZEgagvunAA@mail.gmail.com>

Hi Philipp,

On 17:54 Tue 15 Apr     , Guodong Xu wrote:
> On Tue, Apr 15, 2025 at 4:53 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> >
> > On Fr, 2025-04-11 at 17:44 +0100, Conor Dooley wrote:
> > > On Fri, Apr 11, 2025 at 09:14:15PM +0800, Guodong Xu wrote:
> > > > Add an optional resets property for the Marvell PWM PXA binding.
> > > >
> > > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > > > index 9ee1946dc2e1..9640d4b627c2 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > > > +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > > > @@ -31,6 +31,9 @@ properties:
> > > >    clocks:
> > > >      maxItems: 1
> > > >
> > > > +  resets:
> > > > +    maxItems: 1
> > >
> > > Do any of the currently supported devices use a reset? If not, then add
> > > this in tandem with the new compatible and only allow it there please.
> >
> > Also, if spacemit,k1-pwm can not work without the reset being
> > deasserted, mark it as required.

If I inerpret correctly, only reset requires explicitly being de-asserted,
need to mark as required? that's being said, if reset comes out as de-asserted
 by default after power reset, then not necessary?
(in other cases, some device block is in asserted state by default)

thanks
> >
> 
> Thank you Philipp. spacemit,k1-pwm can not work without the reset.
> I will add that in the next version.
> 
> -Guodong
> 
> > The driver can still use reset_control_get_optional.
> >
> > regards
> > Philipp

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

