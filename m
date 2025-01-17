Return-Path: <linux-pwm+bounces-4659-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC419A1531B
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B81885088
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F618A6A7;
	Fri, 17 Jan 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pj7UM1Qu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FF33062;
	Fri, 17 Jan 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128877; cv=none; b=c2mtGVeCw55hK7PzoT9WSQ/7zOLkDq5eP8zc6OqrhxIE9wa6SLDHFIKZ1WDwUsV5W1eb4ZZga0HeFJZNs1FPupx6rva/gTjnixtlbG5kzIjtI0aICQXXhH+E0EBTyTXcyeUZmiMljBf4z8A8MZgd5zoPzV8wp5c8XtU/YZOaOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128877; c=relaxed/simple;
	bh=Qj10ZHIZvLsm79+pV9p3pc1UU7z132gm/dpFPIHy5BQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=tLTvfSMQvLDhQpbu7mA+jcihFoZrQQo3J/QzNhH9ScI2NmNph/W2keSfwu04tlk52mWBuGEi8yrm5mVOkeit/dSjjoOlxCOyMgI7BET8xVqoX6w+q3IYa/MdV4+DiM+GiMx5meW4g6npwWvAzdV0hXyWgvRUnDDhczOa7Iu5tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pj7UM1Qu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A357440008;
	Fri, 17 Jan 2025 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737128866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUbim1SaJlo0edxSD2KaiF57Zvw18iMPt4AJUuoV9w8=;
	b=pj7UM1Qutxasd+MYyXB0JIGh9axUAiFYcUVfzust2lf1Wwe84jYQPLfgHSRRwK1dT8PJTT
	y8d2q5vIai1jYvCQxqJntKigYbK0UZ+4ZdhfN2c8HaCgI34XV7S8T3735Q8FMa4b9fGN86
	lmgf6HVea6YD2lQg2nHnAJ3lZAPY/F2eVPo+p2Ui7ucm9XxP739da8D0kExZ8Rsnz1zzly
	ScmxO/R/tBDGdjMcGjRHcn267g0cxMjvoCKLy2unfBjfQdVPQys1QskdfdaWdJMoiieQ63
	o7h0ysOxPW04oyJF5bT2pOWH77M0jKvvCKaOyREPFnSa3F98m1CEC5myZXqVDw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 16:47:45 +0100
Message-Id: <D74GSFVY17UV.GMN119MAVAK0@bootlin.com>
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-3-9519b4acb0b1@bootlin.com>
 <f22l3uqgt65utxehv2zmozqixjkktp4trpr42xr5arvp6o5zcf@g5iriaeskqa5>
 <D74EQQNADWDP.FQ5XFK8TB5XH@bootlin.com>
 <v4bf6bharih6zgz52ya5twfyf47wh3fu56ovic5gjxak2jhufy@q3eudujjwrhm>
In-Reply-To: <v4bf6bharih6zgz52ya5twfyf47wh3fu56ovic5gjxak2jhufy@q3eudujjwrhm>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Jan 17, 2025 at 3:40 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Jan 17, 2025 at 03:11:29PM +0100, Mathieu Dubois-Briand wrote:
> > On Fri Jan 17, 2025 at 10:33 AM CET, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello Mathieu,
> > >
> > > On Mon, Jan 13, 2025 at 01:42:27PM +0100, mathieu.dubois-briand@bootl=
in.com wrote:
> > > > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > ...
> > > > +static int max7360_pwm_apply(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > > > +			     const struct pwm_state *state)
> > > > +{
> > > > +	struct max7360_pwm *max7360_pwm;
> > > > +	u64 duty_steps;
> > > > +	int ret;
> > > > +
> > > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (state->period !=3D MAX7360_PWM_PERIOD_NS) {
> > > > +		dev_warn(&chip->dev,
> > > > +			 "unsupported pwm period: %llu, should be %u\n",
> > > > +			 state->period, MAX7360_PWM_PERIOD_NS);
> > > > +		return -EINVAL;
> > >
> > > Please don't emit error messages in .apply(). Also a driver is suppos=
ed
> > > to round down .period, so any value >=3D MAX7360_PWM_PERIOD_NS should=
 be
> > > accepted.
> > >
> > > Also note that you might want to implement the waveform callbacks
> > > instead of .apply() and .get_state() for the more modern abstraction
> > > (with slightly different rounding rules).
> > >
> >=20
> > Sure, I just switched to the waveform callbacks, it was quite
> > straightforward.
>
> sounds great. Note that the detail in rounding that is different for
> waveforms is that a value that cannot be round down to a valid value
> (because it's too small) is round up. This is a bit ugly in the drivers
> but simplifies usage considerably. So you never return -EINVAL because
> the values don't fit.
>

Sorry, I'm not sure I got it right. Does this affect the three members
of pwm_waveform (period_length_ns, duty_offset_ns, duty_length_ns) ? So
on this device where the period is fixed and I cannot define an offset,
does that mean I will silently accept any value for period_length_ns and
duty_offset_ns ?

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


