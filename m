Return-Path: <linux-pwm+bounces-5571-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A03A93A00
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D799215C3
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DB213E60;
	Fri, 18 Apr 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VpNYh+gP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA815624B;
	Fri, 18 Apr 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990751; cv=none; b=oOePUWeXToOnCVrYMVN6zj/hWq3gDzXvejYzXyD2755JZTKTPIMyJokfibgbzfOSAZ/AkAQXx++y8h1Ufldow9u9SeIYRDvojYn8De5cvlexbYGtjHHhgzxUChfnIj1hINcvBeOomAhnKTD5Qx4COQ7sB/dmY3J9EcDeZ8lj+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990751; c=relaxed/simple;
	bh=SXD+Sr5Bu1sa1IrehS27JU8VV+GaNuxKJ5Tcu8UwzI8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=beuo9lcnPPYDL8MPp+vSAg5rAtEquEOeLKEUS+kArqr7FwaNwIDT8Dxxz1Tl4r4wA3mSNgZmicLFLB2jLx64AWv0BRF4PrdfoAIlcuRvdYwGJpc1NCfq8MpnGSz+7ZJLKdeDaAv+WQxf/HAX4nblUO8yh2Jrum5DjhwzbKkzM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VpNYh+gP; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B928431EB;
	Fri, 18 Apr 2025 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744990741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDQXvSIoUGCjM9r7U7iSfQKR2tkJ7iP64qIbMviAOxQ=;
	b=VpNYh+gPTnPo2FYviHN36KxuvmlaMiu0VeP16M2W+tluTM/JQVWasuQhyp+fFQ509yYz7o
	hcQ7PgwVO0uUHCYwNfja875oXKK8RsaH3KWy7sO74ezq9u5IGtLWqx/VhhjO2u44GZg02Y
	gmsKJQx9vSFQAV3skGcumId28e66dOcIAFw4QNRcjmXmiIZWwnut8CDIW9PhrIDJiwGlW3
	VM82vVzYTeogvsjQ7ScKOFXIEjOp8tlmI9oWpung5BZI5m2vpSsuS/TxpwII42vT7ghfXn
	XnZ07INMfFmo8NNYS7d75Nzkkp54GC8R1yz88uF+DfnpoWnvgeuGtywLNdC/pA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Apr 2025 17:39:00 +0200
Message-Id: <D99VLB8X9Y6T.3RO76KOQDUKZY@bootlin.com>
Subject: Re: [PATCH v6 02/12] mfd: Add max7360 support
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
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-2-7a2535876e39@bootlin.com>
 <aAFFh8dvgQDJMyOh@smile.fi.intel.com>
In-Reply-To: <aAFFh8dvgQDJMyOh@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Apr 17, 2025 at 8:16 PM CEST, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:55:49PM +0200, mathieu.dubois-briand@bootlin.c=
om wrote:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>=20
>> Add core driver to support MAX7360 i2c chip, multi function device
>> with keypad, GPIO, PWM, GPO and rotary encoder submodules.
>
> ...
>
>> +static int max7360_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev =3D &client->dev;
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	regmap =3D devm_regmap_init_i2c(client, &max7360_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to initialise regm=
ap\n");
>
>> +	i2c_set_clientdata(client, regmap);
>
> Is it used somehow? In children?
>

I cannot see where it would be used in the code, and removing it has no
effect. I will remove it.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


