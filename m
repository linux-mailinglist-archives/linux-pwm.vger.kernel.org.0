Return-Path: <linux-pwm+bounces-6845-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F2B06F54
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jul 2025 09:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7621A66251
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jul 2025 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF228B7DB;
	Wed, 16 Jul 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mLqF3euY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9045025F790;
	Wed, 16 Jul 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651982; cv=none; b=EA2s0CTMPvupHTAnmK0CpvZs1m19eCBQj9vFklPsy5dU0FooZajDyGo0DIlHvzxu8aKzFM+RXULHh+f+wf5d2xZ2cDwL5Z7tDFvgx/Z1BDalARJSrrIs8tGtLzDiLCr7Q+FMv3xL8xWJGyGrlnmgKf+IZ0Yl97naeUNLcG1rosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651982; c=relaxed/simple;
	bh=WvyN1vdWhCD7797ocIEM78+/KhxekVcT+AOQcmtLic8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=G2DdaP382i1zys2uJo9rZehjS3ofC3MpJUOaYcFICs34dCod2qnuzfRHn+ZVh+6BNw8txYxKUqui5QhmgISHcDGE3/kHImY8/zLEMNaPUm7GPMPHmjUeWmwCZis2en8xpWRr+EG7T3uAet5pd81/CXu1Y9WW0wi8tY6ReZDU1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mLqF3euY; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D80CE44365;
	Wed, 16 Jul 2025 07:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752651976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVnzIorq+3eHat4uDbQQ9kodVbAlWxfOepQytsnXCts=;
	b=mLqF3euY4Wg+hiLmK9WFO8FKhslC4FY6ba0ydsshfwu6wScP4ri8sN/QCy8x5I9ibFsCTd
	SOZGIV69Sy2iVQKktLmos+zAlVbkgvc9rRAo0PXLFcOPyw/7eQHB6CzaFMTqvgsq1i3AvX
	bP9xstnjzuEPzwRaoYZASBcDJ6ZbSdlVrIhwHSygli4PZANm37lTVUdCBimH+7YRcObyGM
	RUzMZ23/2z3jy/ZkaDpooUVxEdKOJdipUKgC/XDchW8m9KDK2aM+XbUca2/NUVaOBa9Iyj
	vkJDbHl7ccq8h2jISugRA0+Q+RRbGGeCT/11KrUbSpWoE3j1Z8rPVe1aepmshQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 09:46:14 +0200
Message-Id: <DBDB9TTHTCKT.2MZJIDJGFPTDB@bootlin.com>
Subject: Re: [PATCH v11 04/10] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250711-mdb-max7360-support-v11-0-cf1dee2a7d4c@bootlin.com>
 <20250711-mdb-max7360-support-v11-4-cf1dee2a7d4c@bootlin.com>
 <j6zavgfpiq7s7cnfkghn2y6fv4h4ziqtpyp7igwmovqlyuasoq@hozlyjcpsxth>
In-Reply-To: <j6zavgfpiq7s7cnfkghn2y6fv4h4ziqtpyp7igwmovqlyuasoq@hozlyjcpsxth>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjedugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheplefhhfetleegfeegfedviedtvedvvddtfedvfeegheeitdeiiefgvdeiteetlefgnecuffhomhgrihhnpegrnhgrlhhoghdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Jul 11, 2025 at 4:50 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Hello Mathieu,
>
> On Fri, Jul 11, 2025 at 11:29:44AM +0200, Mathieu Dubois-Briand wrote:
>> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
>> new file mode 100644
>> index 000000000000..0eb83135f658
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-max7360.c
>> @@ -0,0 +1,193 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2025 Bootlin
>> + *
>> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
>> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> + *
>
> A link to the data sheet here would be awesome. I found it at
>
> https://www.analog.com/media/en/technical-documentation/data-sheets/MAX73=
60.pdf
>

Sure, I will add the link.

>> [...]
>> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
>> +					   struct pwm_device *pwm,
>> +					   const struct pwm_waveform *wf,
>> +					   void *_wfhw)
>> +{
>> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +	u64 duty_steps;
>> +
>> +	/*
>> +	 * Ignore user provided values for period_length_ns and duty_offset_ns=
:
>> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of=
 0.
>> +	 */
>> +	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS)
>> +		duty_steps =3D MAX7360_PWM_MAX_RES;
>> +	else
>> +		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_MAX_RES / MAX736=
0_PWM_PERIOD_NS;
>
> I read through the data sheet and I think the right formula for
> duty_steps is:
>
> 	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS) {
> 		duty_steps =3D 255;
> 	} else {
> 		duty_steps =3D (u32)wf->duty_length_ns * 256 / MAX7360_PWM_PERIOD_NS;
> 		if (duty_steps =3D=3D 255)
> 			duty_steps =3D 254;
> 	}
>
> (Using magic constants here, but in the end these should be cpp symbols
> of course.)
>
>> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX_RES, duty_steps);
>> +	wfhw->enabled =3D !!wf->period_length_ns;
>> +
>> +	return 0;
>> +}
>> +
>> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>> +					     const void *_wfhw, struct pwm_waveform *wf)
>> +{
>> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +
>> +	wf->period_length_ns =3D wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
>> +	wf->duty_offset_ns =3D 0;
>> +
>> +	if (wfhw->enabled)
>> +		wf->duty_length_ns =3D DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PE=
RIOD_NS,
>> +						  MAX7360_PWM_MAX_RES);
>> +	else
>> +		wf->duty_length_ns =3D 0;
>
> The matching code here is:
>
> 	if (wfhw->duty_steps =3D=3D 255)
> 		wf->duty_length_ns =3D MAX7360_PWM_PERIOD_NS;
> 	else
> 		wf->duty_length_ns =3D DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERI=
OD_NS, 256)
>
> This is arguably a strange design, but f_OSC =3D 128 kHz and the fixed
> period being 2 ms is a strong indication that the divider is 256 and not
> 255. If you don't agree to the manual (e.g. because you measured the
> output and saw your formula to be true), please add a code comment about
> that.
>

Yes, I did a few measurements, and you are right. I'm fixing the code as
you described.

> When you have measureing equipment at hand it would be great if you
> could verify that the right fromhw implementation isn't:
>
> 	wf->duty_length_ns =3D DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERIO=
D_NS, 256)
>
> even for wfhw->duty_steps =3D=3D 255. (Which would mean that the PWM cann=
ot
> provide a 100% duty cycle.)
>

No, I confirm, values from 0 to 254 provide a duty cycle from 0 to
254/256. A value of 255 provides a 100% duty cycle.

>> +static int max7360_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct pwm_chip *chip;
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	regmap =3D dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
>> ...
>> +
>> +	ret =3D devm_pwmchip_add(dev, chip);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
>
> Please start error messages with a capital letter.
>

Fixed, thanks.

> Best regards
> Uwe

Thanks for your review,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


