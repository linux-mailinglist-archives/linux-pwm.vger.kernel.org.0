Return-Path: <linux-pwm+bounces-5279-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF130A705A9
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCB03A5AF4
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC27F2571A9;
	Tue, 25 Mar 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bYa2sGYw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F631FAC34;
	Tue, 25 Mar 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918186; cv=none; b=fQA2gNP0dqgeFzxhF9YWv9Mu2vjTxpIz0IicTesz4y3TKMAFLdnBBPPcZzYwoBv96Icgyyf14pLK+pG6j390qcsFcFazxhISlNTjUIvgu12W3Xxh0Ba0wiAcokGoiIwqc3/Ck2OqrPH/LEL1bg4rRhNjVzMRJcYKtAS3aI/bpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918186; c=relaxed/simple;
	bh=Qe52kL0ACIPcE875tWxkuiGfJ1bHn3ADQTfa6h9DYQY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Qv2keMk9zMegVMLUkZxBJtmYVoVvtjUyAqDjVpPFnNte/MAf4YWNlMUc9vOc5AUD6W573SWCmh9cfvzME2ah609eL4Oj/DLQJYvPflUjKwstnV3wC7IoN9wt6HIt43uWaUWHrKWQZwZUyea+SfYzxSMpgwvJCFojH801MTOENpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bYa2sGYw; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 241594434C;
	Tue, 25 Mar 2025 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742918181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xE/EuykUXaV9X7CEIc4chwri4tAOokRK/Wzf/U3t4z4=;
	b=bYa2sGYw1SA1l2YEq9xd7GQiJjYwj+39GGRJuOVmXbUEjwMrKqHX9PAuFXvUh34dUjjNJh
	+z5XXQlK7Oi6vF2WLuEsWF2+yB9r5PvxRuNaAggHSz9QeiKFaI/lmgFNJ+g68anduJmpxv
	nL+JoVaCyJMRaye5+R0rBJvmG5v8SgHc8OiTXgtav4RWyKOAAisozT28Jl6O6o+lxUg503
	iJkcMCrZLsTAmfpqWOdk2u8gkp5hHYfvBDhgFxw2RJGe9h/RIOMntuFP0i3QMr1r74VSWv
	qx8D832aLwsQvQQAYJRi7vT2S8+j/C6zwIT94fwclERGCFqdzsR0lPZ+kefo4g==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 16:56:20 +0100
Message-Id: <D8PGXIKGXXK9.244NSFST6C0YD@bootlin.com>
Subject: Re: [PATCH v5 10/11] input: misc: Add support for MAX7360 rotary
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
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>
 <Z9q0eaxhecN0kGKI@smile.fi.intel.com>
In-Reply-To: <Z9q0eaxhecN0kGKI@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeftdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Mar 19, 2025 at 1:11 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:26PM +0100, Mathieu Dubois-Briand wrote:
> > Add driver for Maxim Integrated MAX7360 rotary encoder controller,
> > supporting a single rotary switch.
>
> ...
>
> > +static irqreturn_t max7360_rotary_irq(int irq, void *data)
> > +{
> > +	struct max7360_rotary *max7360_rotary =3D data;
> > +	int val;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val=
);
> > +	if (ret < 0) {
> > +		dev_err(&max7360_rotary->input->dev,
> > +			"Failed to read rotary counter\n");
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	if (val =3D=3D 0) {
> > +		dev_dbg(&max7360_rotary->input->dev,
> > +			"Got a spurious interrupt\n");
> > +
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	input_report_rel(max7360_rotary->input, max7360_rotary->axis,
> > +			 (int8_t)val);
>
> This is strange:
> 1) why casting to begin with?
> 2) why to C type and not kernel (s8) type?
>

I believe the cast is needed, as, while the value read with
regmap_read() is stored in an int, the underlying value is indeed a
signed 8 bits integer.

Without cast negative values will not be correct: -1 (0xFF) -> will be
interpreted as 255 (0x000000FF).

Ok for s8.

Thanks for your review
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


