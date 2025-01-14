Return-Path: <linux-pwm+bounces-4625-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35AAA10788
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 14:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB9A7A1F22
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931B4234CE4;
	Tue, 14 Jan 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F1Gtleo3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF8236A96;
	Tue, 14 Jan 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860616; cv=none; b=nod4BPmVj3vVQdChH93oTmx1qL/Ejs1FTtrU8RWA9Qtkusk+YEoGtjBNAGeLnS/sRgTW98taSspzkWmAd3KYhpQdtoTFcq2w7np0meie7rfHXyiha9GwlGstn1TLbJzXy0vhcD01JZKouoiAKQF8qsQ0e78vBI5GuWF0o7MWcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860616; c=relaxed/simple;
	bh=2ZVAng/Inj6jkvMDMhoSDiVL5LoO7yKWwTTyzy2aqfQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=LigzdXuJ4JYv3vx6m1Fo/rnSk0G7IKSzh3JInkbGeiGr8bIZRcDuvHXreBJrX0J8vobdlmmdAUbTGhbjRUlWMRiEZi9EQ17yYZdzuHzSjY6IlQklxKsVJr+3avXVbCBcvPaCWoTWGvMlE5x+cLwjTF7FE08U69YXhCGw9OT+3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F1Gtleo3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5188AE0004;
	Tue, 14 Jan 2025 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736860612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myZQOJI87mA4XcgDJGPsQggKBhPrWzCXJ2VO9rVft4o=;
	b=F1Gtleo3nWyhNf+ZZkzLt7JgvzgoxTQWPQXR6g7TnyHIG7iQDolPLuwKvfiBDFM6U9YM6k
	d6O+1X+FzE1xCiuxRP6Q+vEs4x7I6SUWGC09qWwoPMNHFFw4iprKjK7acs5oqfXnLeO16T
	MsVjBtBrNE9Ci0BOESdrT1TIZtcLbgT7Cmt1rLVPeRmrnUmFXddMrLFNwIXNO5NnudaVt+
	0cRHW1cRtMrSHELje697cA6f1s/U/qfLXDgjT8tNWTbjen0Rg4kMBhQmnkmj0dBPfNUc98
	R50QCyeWatUuWJBOhQtrXh+1JTOmzqEtniBwx2qkuHpq+Ws55zo0bCJBr/WAIQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jan 2025 14:16:51 +0100
Message-Id: <D71TP9JS7DGP.16OEP92IB5EVY@bootlin.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Subject: Re: [PATCH v3 6/7] input: misc: Add support for MAX7360 rotary
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-6-9519b4acb0b1@bootlin.com>
In-Reply-To: <20250113-mdb-max7360-support-v3-6-9519b4acb0b1@bootlin.com>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Mon Jan 13, 2025 at 1:42 PM CET, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 rotary encoder controller,
> supporting a single rotary switch.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
...
> +static irqreturn_t max7360_rotary_irq(int irq, void *data)
> +{
> +	struct max7360_rotary *max7360_rotary =3D data;
> +	int val;
> +	int ret;
> +
> +	ret =3D regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
> +	if (ret < 0) {
> +		dev_err(&max7360_rotary->input->dev,
> +			"Failed to read rotary counter\n");
> +		return IRQ_NONE;
> +	}
> +
> +	if (val =3D=3D 0) {
> +		dev_dbg(&max7360_rotary->input->dev,
> +			"Got a spurious interrupt\n");
> +
> +		return IRQ_NONE;
> +	}
> +
> +	input_report_rel(max7360_rotary->input, max7360_rotary->axis,
> +			 (int8_t)val);
> +	input_sync(max7360_rotary->input);
> +

I have a question about the type of events reported here.

I used rotary_encoder.c as a reference, so I'm reporting some EV_REL
events on a given axis, such as REL_X.

On the other hand, I know there is an out-of-tree version of this
driver that is instead reporting key events, such as KEY_DOWN or KEY_UP.
I also know there are existing applications that do rely on this
behaviour.

So my question is, what is the best kind of events to report here ?
Is there any guideline that do apply here? Should I better try to mimic
the behaviour of the existing out-of-tree driver, or should I mimic the
behaviour of rotary_encoder.c, so we have a similar behaviour for all
in-kernel rotary encoder drivers?

> +	return IRQ_HANDLED;
> +}
> +

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


