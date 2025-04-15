Return-Path: <linux-pwm+bounces-5490-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759DCA89E0A
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE09619015BA
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 12:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1164F2951B4;
	Tue, 15 Apr 2025 12:28:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4929292A;
	Tue, 15 Apr 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720095; cv=none; b=RLRNTaqt1ho/PUnvpbwBXxnjqfeGD3JLI/P6KEabGZf8KM9zFIkDbMZyy1LK85IWLQVugw5hEybSjPMYiDwxexhBU3pX6GnZZkjFcnrrjY74T9hzDPvtrgELR4b1Eqdj1WUqJidscq2jtJtDyQ/g/CNXMMvEIdqtHo36uyYp3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720095; c=relaxed/simple;
	bh=w2RPxSYRBEwwRENpvePKl+T3B+SWPu7DrBRdUIOspv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6x8voBu6Lge2KrITfVWcWaGOCDw/jOTfYdY6gslJXUythf/mJDkCbMYZAJEu2wZAIhzL3RzigQSD64AdQz6PzW0XABfW6bs3MFbbqpHGDVdpOBsXqcuYszwj3HGrJi+pabmuefYyClCcCmfbaws2vUL5tNX1LuLS9+yKk3I7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B8113335DE9;
	Tue, 15 Apr 2025 12:28:11 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:28:07 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor@kernel.org>, ukleinek@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, drew@pdp7.com, inochiama@gmail.com,
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de,
	hal.feng@starfivetech.com, unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
Message-ID: <20250415122807-GYA30943@gentoo>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-2-guodong@riscstar.com>
 <20250411-confider-spinster-35f23040d188@spud>
 <89b6142bacecd4a7742341b88dc1e28c4454527a.camel@pengutronix.de>
 <CAH1PCMZnJDcYKJR35WirQT95hte0NWvGBe4fjDuyZEgagvunAA@mail.gmail.com>
 <20250415101249-GYA30674@gentoo>
 <0bbd2842-72bc-47a7-832a-fc8833163e32@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bbd2842-72bc-47a7-832a-fc8833163e32@riscstar.com>

Hi Alex,

On 07:11 Tue 15 Apr     , Alex Elder wrote:
> On 4/15/25 5:12 AM, Yixun Lan wrote:
> > Hi Philipp,
> > 
> > On 17:54 Tue 15 Apr     , Guodong Xu wrote:
> >> On Tue, Apr 15, 2025 at 4:53 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> >>>
> >>> On Fr, 2025-04-11 at 17:44 +0100, Conor Dooley wrote:
> >>>> On Fri, Apr 11, 2025 at 09:14:15PM +0800, Guodong Xu wrote:
> >>>>> Add an optional resets property for the Marvell PWM PXA binding.
> >>>>>
> >>>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> >>>>> ---
> >>>>>   Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 3 +++
> >>>>>   1 file changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> >>>>> index 9ee1946dc2e1..9640d4b627c2 100644
> >>>>> --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> >>>>> @@ -31,6 +31,9 @@ properties:
> >>>>>     clocks:
> >>>>>       maxItems: 1
> >>>>>
> >>>>> +  resets:
> >>>>> +    maxItems: 1
> >>>>
> >>>> Do any of the currently supported devices use a reset? If not, then add
> >>>> this in tandem with the new compatible and only allow it there please.
> >>>
> >>> Also, if spacemit,k1-pwm can not work without the reset being
> >>> deasserted, mark it as required.
> > 
> > If I inerpret correctly, only reset requires explicitly being de-asserted,
> > need to mark as required? that's being said, if reset comes out as de-asserted
> >   by default after power reset, then not necessary?
> > (in other cases, some device block is in asserted state by default)
> 
> We can often benefit from the state that the boot loader has left
> things in, but I think it's better not to assume it if possible.
right, I agree mostly

> I suppose it might not be required though.
> 
> Anyway, the reset line is available to use; why not require it?
> 
maybe there are cases that users don't want to issue a reset..
so, want to make it optional.. I can think one example that,
display controller is up and working from bootloader to linux,
reset it will got a flicker picture..

anyway, my question was trying to understand the policy of
writting DTS hehind..

> 
> > thanks
> >>>
> >>
> >> Thank you Philipp. spacemit,k1-pwm can not work without the reset.
> >> I will add that in the next version.
> >>
> >> -Guodong
> >>
> >>> The driver can still use reset_control_get_optional.
> >>>
> >>> regards
> >>> Philipp
> > 
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

