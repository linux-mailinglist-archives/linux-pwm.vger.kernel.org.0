Return-Path: <linux-pwm+bounces-4655-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E81A15156
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 15:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7831697E5
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2561FFC76;
	Fri, 17 Jan 2025 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c0FTmAFJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1121FF609;
	Fri, 17 Jan 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123095; cv=none; b=mZTE8P1iC3Pc9qQLF+zkza8b3LeAz1z5TA8EHs/NaaNARAKdcMTCBbDemoNsArtccxQdzunNSIg0G38+vTyXZ02Bhlg1+B06+b262LmF2v0vVBKnswcuLyeAo3CdaJPa49P3Qn/JIMYOE6BOeCJMMJYuERDXXA5oCKR64pfNx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123095; c=relaxed/simple;
	bh=Me246SJL54xrtLrgLYOve0FHhr6a7dzhnL3mtYfwI74=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=h3uVkKTMhWwv+5gXyR2VZ+Bh8fmG7AS6lb4DbDBWiSHiFhRR574NC75RxWsPlbbjaHX/vuh7HxGhQMozXraxGQdJ4oRmKLmU60Hb8dkog+v6/KQlbhM0mZtExTU50HldkOqpOt8mvgVC6u7QyNfStFH7c4Kge6JHKWwXOg4eTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c0FTmAFJ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 553F920004;
	Fri, 17 Jan 2025 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737123091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzZDikjR9clIGnmTv+VoIvPOgnUMRodTCnVhk/mabBU=;
	b=c0FTmAFJBk1PJzrL0vgS1Y0BNK/05UH3P9A0IdreLuGCB2+cYOy455TZAyjTEleeRDCA2E
	1XvGrX/KERV+3R7j3D62t4b09RJ503YWvq18lh6+LgQX8DSYMy7BHdEYD+eEiMLkdLKu/j
	5I0pCYj0egriASFgZxo/M9ubZDYMO+6SLmMScOjeD2pguwG8Y8RbhxhGx5uiObGqIe5cEu
	HYByuO5PdrESQ8+TUc5bOFt8l17cpgsLwSkAV63XULLTwkxgGD7E+OEhYs8Q/oP9BVfAUJ
	OUtuyWQJOGx+AMvK8uMEW9YPDbD05R2S/ZcFFkpbDeDW2F8aY5bypA5tCmP4dw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 15:11:29 +0100
Message-Id: <D74EQQNADWDP.FQ5XFK8TB5XH@bootlin.com>
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
In-Reply-To: <f22l3uqgt65utxehv2zmozqixjkktp4trpr42xr5arvp6o5zcf@g5iriaeskqa5>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Jan 17, 2025 at 10:33 AM CET, Uwe Kleine-K=C3=B6nig wrote:
> Hello Mathieu,
>
> On Mon, Jan 13, 2025 at 01:42:27PM +0100, mathieu.dubois-briand@bootlin.c=
om wrote:
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
...
> > +static int max7360_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct max7360_pwm *max7360_pwm;
> > +	u64 duty_steps;
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (state->period !=3D MAX7360_PWM_PERIOD_NS) {
> > +		dev_warn(&chip->dev,
> > +			 "unsupported pwm period: %llu, should be %u\n",
> > +			 state->period, MAX7360_PWM_PERIOD_NS);
> > +		return -EINVAL;
>
> Please don't emit error messages in .apply(). Also a driver is supposed
> to round down .period, so any value >=3D MAX7360_PWM_PERIOD_NS should be
> accepted.
>
> Also note that you might want to implement the waveform callbacks
> instead of .apply() and .get_state() for the more modern abstraction
> (with slightly different rounding rules).
>

Sure, I just switched to the waveform callbacks, it was quite
straightforward.

> > +static int max7360_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > +				 struct pwm_state *state)
> > +{
...
> > +	state->duty_cycle =3D mul_u64_u64_div_u64(val, MAX7360_PWM_PERIOD_NS,
> > +						MAX7360_PWM_MAX_RES);
>
> You have to round up here. I would expect that the checks in the core
> (with PWM_DEBUG=3D1) help you catching this type of error. In your case
> changing the configuration to
>
> 	.period =3D 2000000,
> 	.duty_cycle =3D 234379,
>
> should yield some hint in the kernel log.
>

Thanks for the reproduce steps: I saw the bug and fixed it. Also
MAX7360_PWM_MAX_RES had to be set to 255 and not 256...

> > +	return 0;
> > +}
>
> Best regards
> Uwe

I also fixed all other points mentioned in your mail. Thanks again for your=
 review.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


