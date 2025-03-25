Return-Path: <linux-pwm+bounces-5273-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21CA703AD
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A77B169A99
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69625A64A;
	Tue, 25 Mar 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oAHnWyak"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2525A2DF;
	Tue, 25 Mar 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912965; cv=none; b=biiQV+GaDxPzpuETiZD8JN2PHp7vJzn9lncZtkjy1rZkxE55QaInE4nC3FmI/e6PmvWI8pL8uUBJECESET6XCu65IQh9guZOhaOpsldZRxf2RcnqGp7KQJM9K8WEFXNm/0NA8ax9BAntabU8wAjTmlbEHj4DjuG8bl2ju69I0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912965; c=relaxed/simple;
	bh=Vl3vvuU3EXqhhL0Aq4L5M6JCpv6r2cjM4xNvae15GQk=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:Mime-Version:
	 References:In-Reply-To; b=Ir+ZXJvD8UuOYVS3P4QCNltVYzobPR2UJgm+/7nBSR6sKsHwjs8CM2ThWulY1DORIykukc1lc0aYnvpkvswJhNopYPQTWmtvD2aFzQReWK9tuye2JQtzH/XkoIKlRVxwWFR592FA36yp/xLhVhkYBbiG98HsBwtSnoXj4hft5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oAHnWyak; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2305244297;
	Tue, 25 Mar 2025 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742912960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/w2I/hCM+TADHxxC0YZFOVsXPy5gKaRLqo80ZlcyTM=;
	b=oAHnWyaktVUyy0V9/uFdjA0D7NqFeMOTOABLtlGA/LYMCAHfnqVveZBXIbm9Yl/izlprG/
	GbOtt0+uvmzukhKHZgJ7tN+MiXIqmN1R6zQtQi/uXq8bZuzxBHfPZtGRxfK1Xw4qHYY1wS
	IFuePgNdYj4Y/Dq8aHLygwhQM5i3ckF9nUUgF6O+yRT9xQB0mCrox6VzPY5sM5p0/6GGLk
	kAaGk6GFgCulOKC19E7nNRhixE6YoY3M1CVsX0RMXdUsCk7PwrhE1p/vFYn0jfZeSkQ3WR
	YOWUaA/Kq3eABtnf208DEndGf24IUcouW3StcgqEQdMmNm2BtLTi0gbduRLR/w==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 15:29:18 +0100
Message-Id: <D8PF2VNMJ0TC.396PL4OJTTBOU@bootlin.com>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
In-Reply-To: <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkvefhvffuggfgofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelfeetjeetffegkeeukeehvdegleeklefggfdtieduvdfgkeeggefhfeekffefhfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Mar 19, 2025 at 12:18 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.c=
om wrote:
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >=20
> > Add driver for Maxim Integrated MAX7360 PWM controller, supporting up t=
o
> > 8 independent PWM outputs.
>
> ...
>
>
> > +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > +					   struct pwm_device *pwm,
> > +					   const struct pwm_waveform *wf,
> > +					   void *_wfhw)
>
> I would expect other way around, i.e. naming with leading underscore(s) t=
o be
> private / local. Ditto for all similar cases.

I get the point, but the 2 existing drivers based on pwm_ops structure
name it that way: drivers/pwm/pwm-axi-pwmgen.c and
drivers/pwm/pwm-stm32.c.

Also, the parameter is mostly unusable as-is, as it is a void*, so I
believe it also makes sense to have no underscore for the correctly
casted one, that we will be using in the function body (wfhw).

>
> ...
>
> > +static int max7360_pwm_read_waveform(struct pwm_chip *chip,
> > +				     struct pwm_device *pwm,
> > +				     void *_wfhw)
> > +{
> > +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
> > +	struct regmap *regmap;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	regmap =3D pwmchip_get_drvdata(chip);
> > +
> > +	ret =3D regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (val & BIT(pwm->hwpwm)) {
> > +		wfhw->enabled =3D true;
>
> Also can be (but up to you)
>
> 	wfhw->enabled =3D val & BIT(pwm->hwpwm);
> 	if (wfhw->enabled) {
>
> And also see below. Perhaps it is not a good suggestion after all.
>
> > +		ret =3D regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);
> > +		wfhw->duty_steps =3D val;
>
> Set to a garbage in case of error, why?
>

Ok, I'm fixing the whole block of code.

> > +	} else {
> > +		wfhw->enabled =3D false;
> > +		wfhw->duty_steps =3D 0;
> > +	}
> > +
> > +	return ret;
> > +}
>
> ...
>
> > +static int max7360_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct pwm_chip *chip;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	if (!dev->parent)
> > +		return dev_err_probe(dev, -ENODEV, "no parent device\n");
>
> Why? Code most likely will fail on the regmap retrieval. Just do that fir=
st.
>
> > +	chip =3D devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
>
> This is quite worrying. The devm_ to parent makes a lot of assumptions th=
at may
> not be realised. If you really need this, it has to have a very good comm=
ent
> explaining why and object lifetimes.
>

Thanks, I'm fixing this in this driver and similar code in keypad,
rotary and pinctrl. More details in the child mail.

Thanks for your review!
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


