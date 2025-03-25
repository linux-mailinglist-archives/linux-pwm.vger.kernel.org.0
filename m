Return-Path: <linux-pwm+bounces-5276-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F9A7045B
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7B13A945E
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6725A652;
	Tue, 25 Mar 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CTzPC1gG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1627456;
	Tue, 25 Mar 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914627; cv=none; b=RcWvhEoFme07KPir2x+cNj/4oqUmmNfmjdgYQdZHxelMFLf8ReKobVlTKHiL4RLmdF3MuXUpgH25/AsQBkVINs7ui58Pw7QeRvzKHqLwp6MkEk40CpjhfpXU7PJ8tL6llLaXXsvTVsm9LrdYK5QQPLxlBGSBgVd951HfDeVYpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914627; c=relaxed/simple;
	bh=RYqHjWw3KTpaby0u6OwaBZc7ufnS+zuGBANKdwMFpf4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=FEQwdj67ZLe/o2WFhQGihAaTqppVD+KFf1S0js3BWNvOTyl/SZoykmAzNaqxslB6QzMXSuu0/92DNk0YQW7R7eB5d8Y1ajGBiSJKTwRoVrjH75Bjp7xG3k0LK2qJJeee6zmTTlzrgRKz83tcWuvxvEJnEjCRMrtGL505p1ekuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CTzPC1gG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0172D2047D;
	Tue, 25 Mar 2025 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742914623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBZ1CEC0QSASEo3c9ilc08bpvWeK9tdZuZ0/dmDvxvo=;
	b=CTzPC1gG1AcpU3Wp/Ap7na1XuvEWAIpIK6mF+neWSzfzTXp4iAIUOckj8vJzz/fx63Ek5n
	QeobZgh5fGmjoCDSjULN2or9wbUH3VEX+j0cUUV/7pOUgaZMbohWVzSi9wxbSk+muJ+YFz
	h4Xi5fYctiSsjW9QYZFVScarprkW0MkT1oFkXIe2mqvAb2cphiDLOYzMLVjnAWsBX72c+o
	+C/x1Jy/yt9dA80LnyyMPoy8L/ka+JPz+4w/cjq4gwzPWbrmNIusORtacSh3P4LibJg1as
	VnlKeFUuR1soGL8rBQPfY78CQXZOrwjrJHfiHTTumWuuLOeE9K0ALiuITVrz0g==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 15:57:01 +0100
Message-Id: <D8PFO3LSGWQD.38SX4PSHQ84W2@bootlin.com>
Subject: Re: [PATCH v5 09/11] input: keyboard: Add support for MAX7360
 keypad
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
 <20250318-mdb-max7360-support-v5-9-fb20baf97da0@bootlin.com>
 <Z9qybcY7VyQBvZMv@smile.fi.intel.com>
In-Reply-To: <Z9qybcY7VyQBvZMv@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Mar 19, 2025 at 1:02 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:25PM +0100, Mathieu Dubois-Briand wrote:
> > Add driver for Maxim Integrated MAX7360 keypad controller, providing
> > support for up to 64 keys, with a matrix of 8 columns and 8 rows.
>
> ...
>
> > +	help
> > +	  If you say yes here you get support for the keypad controller on th=
e
> > +	  Maxim MAX7360 I/O Expander.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called max7360_keypad.
>
> One paragraph is wrapped way too late or too early, can you make them app=
rox.
> the same in terms of a line width?
>

Thanks. I had a look at all other Kconfigs, I believe they are all fixed
now.

> > +
> > +	input_set_capability(input, EV_MSC, MSC_SCAN);
> > +	if (autorepeat)
> > +		__set_bit(EV_REP, input->evbit);
> > +
> > +	input_set_drvdata(input, max7360_keypad);
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL, max7360_keyp=
ad_irq,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>
> What's wrong with the interrupt flags provided by firmware description?
>

So same question as for the GPIO driver: IRQF_TRIGGER_LOW from the
firmware, but IRQF_ONESHOT from the driver? Or should everything come
from the firmware?

Thanks again for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


