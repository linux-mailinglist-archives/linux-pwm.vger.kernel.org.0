Return-Path: <linux-pwm+bounces-7031-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04FB24A9C
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79886723DC3
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641132E611F;
	Wed, 13 Aug 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="BFeVysPt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB12E8899;
	Wed, 13 Aug 2025 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091874; cv=pass; b=ccsiAMIWVdaNaRZPY1x6d3VrqhitDPPWDpx3AF1ae0W5j1Z6WBsUCZIUEJ3Oy4T/F6RMTd3rh3tD96ci76g11W7GhpZvC7cwlT9V1HIMJWJ/kVw2sNv1IUpAdq0+0R1Eoi776cIxbBkuv1+C4434fd3M2PMTmbnT8nPRMn1jhEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091874; c=relaxed/simple;
	bh=iL88IyH4csTuiVKL5WFtJqMSKUZhYR2vJlQwTJBNCyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/3KZPPUvi0cbD07NBITWn+a0+FhorcLzst7J/eJYh6NHHSy7KCLATVHdajON1NHkXmHK8r9W0y0CgVPZY7H39YLhQfnoOhRJUgP5MPiAq09ShfnMo7yGxtnAwvMVepUzwySyc2CRxmVn7bxGTl48jxkGb9eQ+0opZOaCa6rMl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=BFeVysPt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755091863; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gm8ZqbrArfSxMgKx4Se7hI59QU1SVh3IfH5aYnoR6xfpxr2+e7kbluJR+xoEQP8vwJH/ZPdbvmJBYeW02sav2yvqj0nwKGq7tahbQI5XaK2mbOLKJioIhf7GRcmH+R65/dzQKBn+oJpp9AqotYDhPmXVKqoIJU5bOH45vKM41HI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755091863; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1PO4JwgNl3v4lcBIWYkGeBsmkYenxYCJt0c4vl9JYKo=; 
	b=Ttp1JZ47Db6HXXWuaUdmSGm6791sxj4o4KYWHm30f14ZTTeFt+5I6e4UPalju50j/DjaniUYC1/V6MDDKfUi5tGW4eNHHrVexCOAiEC/nYyynH4AIw/TC0gATzawxoYFR/bQcEBedOucyr0AJBNuyRJqO7zeHz/L6SvNbCQEaFQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755091863;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=1PO4JwgNl3v4lcBIWYkGeBsmkYenxYCJt0c4vl9JYKo=;
	b=BFeVysPtKmnvVmoE8wZBfy5QEmwPgZlv7HeUqHv15c82hAoQJe+Mp6BwplVJyh++
	FLb7HWf0oU/iY5vBRp2BxEDv0gDHbFujujsmFLP7riiQpBU9dhIxR5yoPaAZKSyDT9c
	uhRIngyRReUz57474MiupguM9UEQxzWdAW8CuQvc=
Received: by mx.zohomail.com with SMTPS id 175509186228158.30300497816302;
	Wed, 13 Aug 2025 06:31:02 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Greg KH <gregkh@linuxfoundation.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org
Subject:
 Re: Patch "pwm: rockchip: Round period/duty down on apply, up on get" has
 been added to the 6.16-stable tree
Date: Wed, 13 Aug 2025 15:30:57 +0200
Message-ID: <13940446.uLZWGnKmhe@workhorse>
In-Reply-To: <ztjkhfhr4oyqgarh4wrqtcgu4gh3fqnfnakdx34wlj37ggpiin@fibgy2g4zldp>
References:
 <20250808223033.1417018-1-sashal@kernel.org>
 <2025081209-vista-preorder-bd6f@gregkh>
 <ztjkhfhr4oyqgarh4wrqtcgu4gh3fqnfnakdx34wlj37ggpiin@fibgy2g4zldp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Greg & Uwe,

On Tuesday, 12 August 2025 22:15:37 Central European Summer Time Uwe Kleine=
=2DK=C3=B6nig wrote:
> Hello Greg,
>=20
> On Tue, Aug 12, 2025 at 12:53:49PM +0200, Greg KH wrote:
> > On Tue, Aug 12, 2025 at 12:36:48PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Aug 12, 2025 at 10:53:11AM +0200, Greg KH wrote:
> > > > On Sat, Aug 09, 2025 at 11:45:23AM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > while the new code makes the driver match the PWM rules now, I'd =
be
> > > > > conservative and not backport that patch because while I consider=
 it a
> > > > > (very minor) fix that's a change in behaviour and maybe people de=
pend on
> > > > > that old behaviour. So let's not break our user's workflows and r=
eserve
> > > > > that for a major release. Please drop this patch from your queue.
> > > >=20
> > > > Now dropped, but note, any behavior change is ok for ANY kernel ver=
sion
> > > > as we guarantee they all work the same :)
> > >=20
> > > Your statement makes no sense, I guess you missed to add a "don't".
> > > Otherwise I'd like to know who "we" is :-)
> >=20
> > {sigh} yes, I mean "any behavior change is NOT ok..."
>=20
> Ahh I though you wanted to say "any behavior change is ok for ANY kernel
> version as we don't guarantee they all work the same". So let me explain
> a bit:
>=20
> A PWM consumer (think fan driver) gets an opaque handle to the used PWM
> device and then requests something like: "Configure the PWM to have a
> period length of 50 ms and a duty length of 20 ms." The typical PWM
> cannot fulfill the request exactly and has to choose if it configures
> (say) period=3D46 ms + duty=3D16 ms, or period=3D52 ms and duty=3D26 ms (=
or
> possibly a mixture of the two, or an error code). Traditionally each
> driver implemented its own policy here and so the generic fan driver
> knows neither the possible hardware restrictions (another hardware might
> be able to do period=3D51 ms and duty=3D19 ms) nor how the driver picked =
one
> of the options. Making things harder, it depends on the use case which
> policy is the best, which also explains that different drivers picked
> different algorithms. And also it's unclear even what "nearest" means.
> For example a hardware might be able to configure period=3D17 ms or
> period=3D24 ms in reply to a request of period=3D20ms. You probably say t=
hat
> 17 ms is nearer. But if you think in frequencies the request of
> period=3D20ms corresponds to 50 Hz and then 24 ms ~ 41.6667 Hz is better
> than 17 ms ~ 58.8235 Hz.
>=20
> To improve that situation a bit at least new PWM drivers are supposed to
> round down both values. The commit under discussion modifies an existing
> driver to align to that policy. So from a global point of view this is
> an improvement, because it makes things a bit more deterministic for a
> PWM consumer that doesn't know about the hardware details. The down side
> is that a PWM consumer that does know these details might depend on the
> actual implementation of the previously implemented policy.

As the author of the patch in question, I thought I should also chime
in to elaborate on what this means in real terms on the hardware this
patch is applicable to. In my testing, I've found the difference is
usually a few tens of Hertz at a scale of tens of thousands of Hertz at
best. However, out of an abundance of caution, I didn't want this to be
picked up by literally every stable kernel still supported, because if
this causes an actual observable functional change in the real world
then it's only accidental as a regression. This should not be the case,
but I'd rather not tempt fate here.

What it does do however, aside from improving consistency here, is that
it makes the PWM core no longer produce a warning on kernels built with
PWM_DEBUG whenever the fan on my RADXA ROCK 5B changes speed. As someone
who worked on both a new PWM driver where I wanted PWM_DEBUG on at the
time as well as running this existing driver on the aforementioned device
while working on other drivers of this SoC vendor, I did not want to
switch between kernel configs all the time, and this greatly improved
my willingness to keep on living.

So in conclusion:
1. this does not change behaviour for any real-world use case, as the
   difference is so tiny it drowns out in the usual tolerances of PWM
   consumers to account for clock shenanigans.
2. even if someone does rely on 0.01% differences in PWM output on a
   consumer device SoC, they would probably appreciate predictable
   behaviour going forward, instead of their requested rate having
   an error that is either positive or negative depending on how
   the math works out. But they'd probably appreciate this change as
   part of a new major release, not a stable patch release.
3. The real motivation is making me less sad while working on other
   things.

Kind regards,
Nicolas Frattaroli

>=20
> So this is a change in behaviour, but it adds to the consistency of the
> PWM framework. If you want to make an LED blink or drive a fan, that
> (most likely) doesn't matter to you. If you drive a robot arm in a
> construction facility, it might.
>=20
> The mid term solution is a new PWM API that gives more control to the
> consumer. The framework bits for that are already done and three drivers
> are implementing that and two more are in the making. (And if you use
> these with the legacy consumer function you also get the round down
> behaviour.)
>=20
> Best regards
> Uwe
>=20




