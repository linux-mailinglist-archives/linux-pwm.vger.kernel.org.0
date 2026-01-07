Return-Path: <linux-pwm+bounces-7869-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E26AACFEE67
	for <lists+linux-pwm@lfdr.de>; Wed, 07 Jan 2026 17:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C246134139CF
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jan 2026 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C33446A4;
	Wed,  7 Jan 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KziO1atL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBB346FD7
	for <linux-pwm@vger.kernel.org>; Wed,  7 Jan 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801981; cv=none; b=oS2nBz6voZAoY5n/+shoSzF5YY+BpnNQIz6pHnUZ0STGDUAF7hbZz6L0yxy2HDd+0s1l6B9SXx8CPXyLPSDkfzoYR14k1lcsVHfQrvooIfNFAHQmUnIqR2iVLzFLzIgNEHvZAltDyPUaLirPg53Pive2CQX8+d0tksxCmFLlkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801981; c=relaxed/simple;
	bh=7OFNQcA6uqsXEiUwn5GUpmW7VKSRsWQTmn01vKNV7H0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NneXNuVjN/RmQUg/cQSCOO/qqEKLNPTZc0Cf0b1dW7L1MU0bqQoQXl0b51RdrUsJ2RzTYxUon/d20Vp8nG2vxzuJeVg+hyrLalcu+KaVJ8rMS/wQtg11Bfi+8RqMS46BX1xiE7tcEiBqLZkyoc75OldVw6HL0qOaFksXeH0zVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=KziO1atL; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1767801959; x=1768061159;
	bh=3g3VrAehq1DtdyJEabqqf3fDXyycbpVTX+V8NEpPD+w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KziO1atL1h1acJHJ/nknbCs7ObEO1ICTzusYp85opcS3th6hdnJOb1o4kr0TijZCW
	 gkhu7tFC8I7wgheAOzmlMPheEO3Vn+u63B2Cnp/yXsw6rQNg0wJb6BNYtc3uHZIWsL
	 AaxXJS008BZ//21a/Gnj6s0FxhPv2f7lwd5eFndRSDdDpI2VSkakvsqplsOlIHikut
	 B5ryQdmRlp1cJ0MAG5WuAAQQneDWMIj4OAPUenerwhgDyj8OIpbDJHEXgMW6CY3VWt
	 JF0d4fK0d0qnlJGeqT3/pEwO8waDmIg8sXCwTJBRZ3lFc8G+qzAAnv8dcjiTbTzh5H
	 vFaIwAf3sTkGw==
Date: Wed, 07 Jan 2026 16:05:56 +0000
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Message-ID: <fwaodg2ovh7j47ifwjhgeppxs3oiqht5ecbs7bmfbi7j6djejs@shwokpcmutr3>
In-Reply-To: <nwhixocvhii27jvcyg7ex5emewntgfhyxa4ds5vo2dphe7xfe4@ibjsjdd5fgmn>
References: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com> <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3> <2e2iahbzcepbzwgk7xeta2afxmycfjgv2zofzngqjvp4on46r2@mzpi4bz4uqie> <nwhixocvhii27jvcyg7ex5emewntgfhyxa4ds5vo2dphe7xfe4@ibjsjdd5fgmn>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 57d8dde4371b846314f7e2b8b867b714e4f3c48f
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Wed, Jan 07, 2026 at 04:54:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hey Sean,
>=20
> On Tue, Jan 06, 2026 at 11:30:34AM +0000, Sean Nyekjaer wrote:
> > On Tue, Jan 06, 2026 at 11:22:57AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Jan 06, 2026 at 08:01:57AM +0100, Sean Nyekjaer wrote:
> > > > After commit 7346e7a058a2 ("pwm: stm32: Always do lazy disabling"),
> > > > polarity changes are ignored. Updates to the TIMx_CCER CCxP bits ar=
e
> > > > ignored by the hardware when the master output is enabled via the
> > > > TIMx_BDTR MOE bit.
> > > [...]
> > > I have hardware using this driver, will set it up later this week for
> > > testing.
> >=20
> > Very cool, looking forward to hear if you can re-produce.
>=20
> I cannot. I have:
>=20
> =09# uname -r
> =096.11.0-rc1-00028-geb18504ca5cf-dirty
>=20
> (the -dirty is only from enabling the pwm for my machine, no driver
> changes)
>=20
> =09# cat /sys/kernel/debug/pwm
> =090: platform/40001000.timer:pwm, 4 PWM devices
> =09...
> =09 pwm-3   (sysfs               ): requested enabled period: 313720 ns d=
uty: 10000 ns polarity: normal
>=20
> and pulseview/sigrok detects 3.187251% with a period of 313.8 =C2=B5s.
>=20
> After
>=20
> =09echo inversed > /sys/class/pwm/pwmchip0/pwm3/polarity
>=20
> the output changes to
>=20
> =09# cat /sys/kernel/debug/pwm
> =090: platform/40001000.timer:pwm, 4 PWM devices
> =09...
> =09 pwm-3   (sysfs               ): requested enabled period: 313720 ns d=
uty: 10000 ns polarity: inverse
>=20
> and pulseview/sigrok claims 96.812749% with a period of 313.8 =C2=B5s.
> So the polarity change happend as expected.
>=20
> This is on an st,stm32mp135f-dk board.
>=20
> Where is the difference to your observations?
>=20

Thanks for taking a look!
I'm using the PWM for a backlight. With this [0] in my dts:

[0]:
=09backlight: backlight {
=09=09compatible =3D "pwm-backlight";
=09=09pwms =3D <&pwm4 0 125000 PWM_POLARITY_INVERTED>;
=09=09brightness-levels =3D <102 235 255>;
=09=09default-brightness-level =3D <80>;
=09=09num-interpolated-steps =3D <100>;
=09=09enable-gpios =3D <&gpiof 12 GPIO_ACTIVE_LOW>;
=09status =3D "okay";
=09};

Maybe that is doing something differently.

/Sean


