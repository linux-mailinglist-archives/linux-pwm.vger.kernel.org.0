Return-Path: <linux-pwm+bounces-5814-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDFCAA7445
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 15:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BFA17C91A
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA0255F32;
	Fri,  2 May 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PfV51jlS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21353A1DB;
	Fri,  2 May 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194296; cv=none; b=p3vJVFXTYX3dK+qnBH+tDYbieR3Gk4EHTeLipwD3Rfpnau3a+M7cYBuk5Rvv1NCr0LJzNvmbDSsbAI9/A8mSSikL85DvIcgwITnZUIRmpblAXCbuliLJRZdA+s+TZpgUp1RNzzCSEgRHGg8mlozltvRop3ai5KN74NaJXCqzjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194296; c=relaxed/simple;
	bh=jF0ACj55EBpFv4xPXMCtCQ3EGPvqoK59YN51NAA9LEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=F4w3WMhny0uNA7bXqJ+5dQa6iyPZyq3UeFIBm0fPEW+1BGU2sJAPRbPjsfEpoFEB8C4wUtlEQg5k1e4SANMAquWwBD1mGfqbNSLay7yhZyKK1zfhoysVqNNhWsPnET675b6mjd8ZLbPOhfdthSXVGTt0hi9b7LvmNjkT79deMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PfV51jlS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C7061FD4D;
	Fri,  2 May 2025 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746194286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P584kb5pC18NApXstRyZUdloelLwGilieD1MHWeQIGs=;
	b=PfV51jlS0bSWrPX0Fq4z7gubswGzSTUV2yhyyBK1MvhXioTMNlo66ly4tqaaUi8k0J0fjd
	X8C1zAcHBuxXtVo3axgKkKwY5KfLOBI3L3lGzryIeCvo0MAGe1QLORvvX369ODdc/YBe+y
	qjkn1VDLa++8X2yl2HQ7ym7rv2Miuy2pfwP2HrVEUr4VZhn/QR8z1LqDHHS0goWbeZ2hbx
	JFI6F277FyGEQeo+lc1j0f/G4Al6Zt+0EkW7BH+kW4uNuAuNoEWCK+zeAGN1t/wgOVYXvr
	V8QZU+rpzRBDHkqFx3arEmFcewWBmQhnIMfVG/f/DAnbSzOyuQuqt6qFACnaOw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 15:58:04 +0200
Message-Id: <D9LQ7NV1LJM9.F2GF0YEEDFEY@bootlin.com>
Subject: Re: [PATCH v7 10/11] input: misc: Add support for MAX7360 rotary
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
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-10-4e0608d0a7ff@bootlin.com>
 <aBSkCsw3GJ6RHeJV@smile.fi.intel.com>
In-Reply-To: <aBSkCsw3GJ6RHeJV@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 2, 2025 at 12:52 PM CEST, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 01:57:28PM +0200, Mathieu Dubois-Briand wrote:
>> Add driver for Maxim Integrated MAX7360 rotary encoder controller,
>> supporting a single rotary switch.
>
> ...
>
>> +struct max7360_rotary {
>> +	struct input_dev *input;
>> +	unsigned int debounce_ms;
>> +	struct regmap *regmap;
>> +
>> +	u32 steps;
>> +	u32 axis;
>> +	bool relative_axis;
>> +	bool rollover;
>> +
>> +	unsigned int pos;
>> +};
>
> I believe `pahole` can recommend better layout (look for the better posit=
ion
> of debounce_ms).
>
> ...
>

Oh yes it does on arm64. Moving it after the regmap pointer, it should
be better.

>> +static void max7360_rotaty_report_event(struct max7360_rotary *max7360_=
rotary, int steps)
>> +{
>> +	if (max7360_rotary->relative_axis) {
>> +		input_report_rel(max7360_rotary->input, max7360_rotary->axis, steps);
>> +	} else {
>> +		unsigned int pos =3D max7360_rotary->pos;
>> +
>> +		if (steps < 0) {
>> +			/* turning counter-clockwise */
>> +			if (max7360_rotary->rollover)
>> +				pos +=3D max7360_rotary->steps + steps;
>> +			else
>
>> +				pos =3D max(0, (int)pos + steps);
>
> Please, no castings for min()/max()/clamp(). It diminishes the use of tho=
se
> macros.
>

Sorry, I'm not sure to get the point. Should I use MIN_T() instead?

>
> ...
>
>> +static int max7360_rotary_probe(struct platform_device *pdev)
>> +{
>> +	struct max7360_rotary *max7360_rotary;
>> +	struct device *dev =3D &pdev->dev;
>> +	struct input_dev *input;
>> +	struct regmap *regmap;
>> +	int irq;
>> +	int error;
>> +
>> +	regmap =3D dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
>
> Missing return. Copy'n'paste error over all drivers?
>

Probably more an error while replacing all dev_err()+return by
dev_err_probe(), but yes. I will look for similar issues.

> ...

OK with all other comments.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


