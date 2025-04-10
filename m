Return-Path: <linux-pwm+bounces-5445-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDDBA841D5
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 13:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37771B82DDC
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE928368E;
	Thu, 10 Apr 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="opHvIk1+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F41DF991;
	Thu, 10 Apr 2025 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285002; cv=none; b=VHuYJHCnjUOh81bHK7I2K++rSY/ZLgsMLSiONcdgplwlOOnEnw+0szNKfDdRbji/X50HncuPOQHPQikDKwbdwwgMALPGkfNgQgl589KLrLZXgvXAsoEve8pHHwCPo/KKCKUan1xpFFruanOWhkedeTwpDGZD88g0xBNeUOHzXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285002; c=relaxed/simple;
	bh=eHb/z5NaMzfi8/yCbXSBDQBs4OP5wqvRmitFyoJYM0I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=abHbqxEmJE5E4fR1aidIPra/fpaVkBXf5ues306DJ31wjaal2cBzOuB6CeR0d9xBuUQQ6gvUrLtLKZNHfa387VwT3ruSiUtTKWpiM2caCAIdgu80BJrTyfwrY/aowT3nurxtndaDlFW4ucsx5e16Gp5dil5wOJUL5lY6z1TBswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=opHvIk1+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0827F44317;
	Thu, 10 Apr 2025 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744284992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAuMrXd/Y4l0cy73R/YgMicuHRMArAQfIUMm8p2VFyk=;
	b=opHvIk1+I05a7jvRdR/BdA1TVdtQN2MR8i5/67/6iika7wbO9a/DFnEbrlCYT7UULIsOhf
	MgqqjLr4EXD94+qff35JyFvj6ABvRF7wgb0omj7uzXDG8B/8sihwloa5p8mgK5TKqNOOcX
	l+Hbw9xsx3ZCE5b0pWzm9uFWp6YlyAeRqRaTx0+woFpjpXnTOf+zZmB+8bxmaRd4w/hU7t
	sLKuT+GOJORnZLZYZzgqyDuI3pXqP+l8vt6P7injqa4bEtmTozdM7FBsfCNq2uVusBTANG
	R3cCdBQlCuQLSDAKbGn5OocsXCkfAkg9RZUBeYOX+AcIN+MTxchBGpe+qgp1xA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 13:36:30 +0200
Message-Id: <D92XFAGJRKJR.2MTADDABV7OMK@bootlin.com>
Subject: Re: [PATCH v6 11/12] input: misc: Add support for MAX7360 rotary
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-11-7a2535876e39@bootlin.com>
 <qszbvz7xr4jhpqnae7mqmnqfv6qzppxjpmbavdknhdnjausqtt@rbjjgc2ozbmq>
In-Reply-To: <qszbvz7xr4jhpqnae7mqmnqfv6qzppxjpmbavdknhdnjausqtt@rbjjgc2ozbmq>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhor
 hhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 9:17 PM CEST, Dmitry Torokhov wrote:
> Hi Mathieu,
>
> On Wed, Apr 09, 2025 at 04:55:58PM +0200, Mathieu Dubois-Briand wrote:
>> Add driver for Maxim Integrated MAX7360 rotary encoder controller,
>> supporting a single rotary switch.
>
> Largely same comments as for the keypad driver: use "int error" for erro
> variable, selection of the device for logging. Also:
>

OK

>> +
>> +	input =3D devm_input_allocate_device(dev);
>> +	if (!input)
>> +		return -ENOMEM;
>> +
>> +	max7360_rotary->input =3D input;
>> +
>> +	input->id.bustype =3D BUS_I2C;
>> +	input->name =3D pdev->name;
>> +	input->dev.parent =3D dev;
>
> No need to be setting/overriding this, devm_input_allocate_device()
> already sets this up.
>

Ok, thanks!

>> +
>> +	input_set_capability(input, EV_REL, max7360_rotary->axis);
>
> The event type should come from the DT data I believe. Could we use at
> least parts of the regular rotary encoding bindings?

Ok, I should be able to add "rotary-encoder,relative-axis" property, as
for rotary_encoder.c.

>
> Thanks.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


