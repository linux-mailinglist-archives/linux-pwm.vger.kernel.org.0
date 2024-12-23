Return-Path: <linux-pwm+bounces-4457-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623F9FB0B5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 16:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D002E18827EC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FE139587;
	Mon, 23 Dec 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PFxTzXP6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD2EAD7;
	Mon, 23 Dec 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734967623; cv=none; b=lfyrLNVOpQQPF4DZJd5UuoAI7cUuAzyhQJJUGU4fJVIfpaPrFbJs1zU11sqaumyinP6im6k7sbU7QzYjWaIq4Y+Y0xbj3vw1KTjIzCWfzAFw/1fK4AE/n3Sluvbpk4VhRR/ZJLAzzfxw/jk6uh5x2V4YGoCiSZ6iergICQYvEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734967623; c=relaxed/simple;
	bh=1AxrEYae/8keZjZRylCLdAjkmWMXIDb85GQ0utouP50=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=H8eLU26HID6mzR6m9jQMmFdYuQGdyc+qDYpI1eyl0XmfyA9r7d2HBeGCufQjyPKhidh6VFwTpEdZoh60liZtlc+2Rxw1pFbD3BTiwFPWo0ZGDsw2p1JPt9FrB1ketmdLGwydtomlMrgbWBwZzQ2Em2O94odMJcgO+i43QoIcewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PFxTzXP6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 170061BF208;
	Mon, 23 Dec 2024 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734967612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tx3Bs+kugCr+GdrUnC6eLJ8dWD/v6KQ1F9CB3XGzs4I=;
	b=PFxTzXP6W4TWXsS2xW44fW08wHbSogjXdxQ7e1PWdEnd0w4gLfF/h99T/ETZcL6pR/unXI
	UTj8UErx2lW5wbtgYLedC1ZOtS+LG4KZRpSgnSd/pjT6n3oLOGBn6zUmHf6P6n6g7K3ZQ5
	KKo3017sSzRD/lzTjo4QfbzVXpga8AoOv4odD0StTmu+ZjPpXM0ChLyRg1Y/VUBenyA3xL
	3B8zlvHE7YpzniBuvd9MtjtghgJ7ZOthMgyKInmxzJtXSjZoPTzeCLbGe3K+pZ9Qic+hyq
	DGzeip5oSAOI+HYjGx+UOpfN6jRNMNUAMMfZxkAnodvgB6pl8j5j5F5B7E9Jnw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Dec 2024 16:26:51 +0100
Message-Id: <D6J6OTNHYWN8.1PGNZILBAGCS0@bootlin.com>
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
Subject: Re: [PATCH 4/8] pwm: max7360: Add MAX7360 PWM support
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-4-8e8317584121@bootlin.com>
 <dmfnpq57n3s32o33pm7wfppr5nttdvtuthe7hf32psmykotrox@mogq35gj6rjq>
In-Reply-To: <dmfnpq57n3s32o33pm7wfppr5nttdvtuthe7hf32psmykotrox@mogq35gj6rjq>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Dec 19, 2024 at 10:53 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Thu, Dec 19, 2024 at 05:21:21PM +0100, mathieu.dubois-briand@bootlin.c=
om wrote:
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >=20
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	max7360_pwm =3D to_max7360_pwm(chip);
> > +	ret =3D regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
> > +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm),
> > +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm));
> > +	if (ret) {
> > +		dev_err(&chip->dev, "failed to enable pwm-%d , error %d\n",
> > +			pwm->hwpwm, ret);
> > +		return ret;
> > +	}
> > +
> > +	do_div(duty_steps, MAX7360_PWM_PERIOD_NS);
> > +
> > +	ret =3D regmap_write(max7360_pwm->regmap, MAX7360_REG_PWMBASE + pwm->=
hwpwm,
> > +			   duty_steps >=3D 255 ? 255 : duty_steps);
> > +	if (ret) {
> > +		dev_err(&chip->dev,
> > +			"failed to apply pwm duty_cycle %llu on pwm-%d, error %d\n",
> > +			duty_steps, pwm->hwpwm, ret);
> > +		return ret;
> > +	}
>
> Huh, state->period isn't used at all. That is wrong for sure.
>

Yes this was definitely missing. Period is fixed by the chip, so I will
make sure the requested one is valid or return -EINVAL.

Thanks a lot for your review, I am preparing a new version of this
series that should address all your comments.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


