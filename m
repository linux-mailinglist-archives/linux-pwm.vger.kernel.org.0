Return-Path: <linux-pwm+bounces-5028-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A1A4BF0E
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 12:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20337A9092
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4862010FD;
	Mon,  3 Mar 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="qphRwrCN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4A20102C
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002038; cv=none; b=bYOtZPo2u7nb3wAE5SQxL7Qk0H2JSmnoqT2RddgrilwoKrgN455v6grUXSj9d62Y+4VyEb8/OyKIDJ0VE2Zm5vxKnpUbtYY57Xr69A+RZ3/HXROYx/kcJxgQv9vigH0jBCgeEQ18N5zGBDpvlW9GfTvyKIhf7U8O02xipH2fqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002038; c=relaxed/simple;
	bh=xjKhMtLA9tK9j8SX+seT9UK5BSImtLHPUuXRUCeDyBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmitAUsLIkT0waeAO6DyCAJ5gGd+KxPGJqWpA0m5s4pda2AjCNML361aLM3PtuTLZkwA1WaoSAwalcgPvbonlNfjCs0D/qsUAKk1naW+EgDv9eA8OWAvT1m2GJjRsaR/gkwhH15Ca83j/aR7YuVpc4bJG4uTSG+BNvk+qyTbUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=qphRwrCN; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=W7xQaIM8KUgQYXUjWEz/yyKUU3dOwVVtoiKveZse1LQ=;
	b=qphRwrCNarcdXMc+8nT9gMvUDncjj28vFRItzfiNE/jdOd2yOkJll/C0YqOI+M2Lv7xxVV69I4kDC
	 EabyatzTV4QIi2a/uhHtenSOQTvgnl5afF0HzFmvDBTlBx3REPp83KwvYQxLaqXi/7tk4a3czrMRSI
	 xgOPVkiNuzqBXgPhGvTeLVEAHDwWVaCBb56qs9Zz5cVnGinA1MkMCkialX23Gp8qC6Mdum9rxl4KCu
	 3VMeU0juaMaLuz2lcY4aa2AjD6nutiVQVBifdXvBV3CXO1CKO+e2ypMhFdH54HYn4n/U6bDSNx7C9U
	 Zxl8AX8zA0VD+Ja7BOpB/LKmPsgqzqQ==
X-MSG-ID: 51c43871-f824-11ef-a39b-00505681446f
Date: Mon, 3 Mar 2025 12:40:34 +0100
From: David Jander <david@protonic.nl>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 linux-pwm@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
Message-ID: <20250303124034.726ba698@erd003.prtnl>
In-Reply-To: <tm57fsmijq4t4y4dpmtss63ekzpm5oefir5tz4aioxq5dx4or6@lgoqjpxc3axh>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-8-david@protonic.nl>
	<20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
	<20250228102201.590b4be6@erd003.prtnl>
	<9a1d75a2-66c0-46b6-91a1-4922b892dfb1@kernel.org>
	<20250228110931.7bdae7fd@erd003.prtnl>
	<tm57fsmijq4t4y4dpmtss63ekzpm5oefir5tz4aioxq5dx4or6@lgoqjpxc3axh>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Dear Uwe,

Thanks for chiming in!

On Fri, 28 Feb 2025 16:18:05 +0100
Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> wrote:

> Hey David,
>=20
> On Fri, Feb 28, 2025 at 11:09:31AM +0100, David Jander wrote:
> > On Fri, 28 Feb 2025 10:37:48 +0100
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >  =20
> > > On 28/02/2025 10:22, David Jander wrote: =20
> > > >    =20
> > > >>> +
> > > >>> +  motion,pwm-inverted:
> > > >>> +    $ref: /schemas/types.yaml#/definitions/flag     =20
> > > >>
> > > >> And PWM flag does not work?   =20
> > > >=20
> > > > I have seen PWM controllers that don't seem to support the
> > > > PWM_POLARITY_INVERTED flag and those where it just doesn't work. Sh=
ould all   =20
> > >=20
> > >=20
> > > Shouldn't the controllers be fixed? Or let's rephrase the question: w=
hy
> > > only this PWM consumer needs this property and none of others need it=
? =20
> >=20
> > CCing Uwe Kleine-Koenig and linux-pwm mailing list.
> >=20
> > I know that at least in kernel 6.11 the pwm-stm32.c PWM driver doesn't
> > properly invert the PWM signal when specifying PWM_POLARITY_INVERTED. I=
 agree
> > this is a probably bug that needs fixing if still present in 6.14-rc. B=
esides
> > that, if linux-pwm agrees that every single PWM driver _must_ properly =
support
> > this flag, I will drop this consumer flag an start fixing broken PWM dr=
ivers
> > that I encounter. I agree that it makes more sense this way, but I want=
ed to
> > be sure. =20
>=20
> Some hardwares cannot support PWM_POLARITY_INVERTED. Affected drivers
> include:
>=20
> 	pwm-adp5585
> 	pwm-ntxec
> 	pwm-raspberrypi-poe
> 	pwm-rz-mtu3 (software limitation only)
> 	pwm-sunplus
> 	pwm-twl-led (not completely sure, that one is strange)
>=20
> . ISTR that there is a driver that does only support inverted polarity,
> but I don't find it. For an overview I recommend reading through the
> output of:
>=20
> 	for f in drivers/pwm/pwm-*; do
> 		echo $f;
> 		sed -rn '/Limitations:/,/\*\/?$/p' $f;
> 		echo;
> 	done | less
>=20
> . (Note not all drivers have commentary in the right format to unveil
> their limitations.)
>=20
> For most use-cases you can just do
>=20
> 	.duty_cycle =3D .period - .duty_cycle

Yes, that is exactly what the relevant code in motion/simple-pwm.c does when
the "pwm-inverted" flag is present in the DT node.

> instead of inverting polarity, but there is no abstraction in the PWM
> bindings for that and also no helpers in the PWM framework. The problem
> is more or less ignored, so if you have a device with
>=20
> 	pwms =3D <&pwm0 0 PWM_POLARITY_INVERTED>;
>=20
> and the PWM chip in question doesn't support that, the pwm API functions
> will fail. So the system designer better makes sure that the PWM
> hardware can cope with the needed polarity.

Thanks for clarifying this!

@Krzysztof, do you think that given this situation it is acceptable to incl=
ude
the "pwm-inverted" flag in the dt-schema of the simple PWM motor driver?

The need for an inverted PWM signal is something very common in the case of
H-bridge motor drivers, where the PWM signal represents the actual logical
output level of each of the two halves of the bridge. Often the high-side
switches are used as the free-wheel position, so that 100% duty-cycle on bo=
th
channels is actually standstill, while 0% duty-cycle on one channel is full
speed in either direction. This isn't always the case though, hence the
importance for this to be able to be selected.

Best regards,

--=20
David Jander

