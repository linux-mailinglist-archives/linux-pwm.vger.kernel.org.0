Return-Path: <linux-pwm+bounces-5439-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64817A83D73
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 10:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206347A90AD
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6B204594;
	Thu, 10 Apr 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lKhmMuI3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C51B2186;
	Thu, 10 Apr 2025 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274924; cv=none; b=Uwlfnzb4gL0/d/NDz0E2EARza8Ii5L1nrGyTEdppvT5fXQPlIP+k3Fn8WwJttNqdr3+yZtTOeqvQmkLhS6H6mNuMR/VXf7G9lL5oa2KBc9XaaafTCHhyymcb9yGi6F9vzs4jkE9hvPjxniQIUJQ2nmUa3YL2FpaXW1CylU/WRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274924; c=relaxed/simple;
	bh=7IdCEDGXZBLr68XJCKq6CNpMxLNx1eJZtSRE//eGUe4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=G0gik4bqHsqZdwnwgESyh+8sHkKyRWb2bf9b8C0N98i4E+A3MKSxSMRXywbh3fm6/I3v/yA1AsrduF2OQpzTFuyWNIau5aW0PpPhMuZ4SMEcmWjKD1EoAkoM9PLClC+JQxSQtsEAdPbarizJ3zyRrBspWf4hICfqYb7a+R/bvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lKhmMuI3; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 370B843278;
	Thu, 10 Apr 2025 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744274920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP4LjAmMjlQiawomtTugWVJpM87iRcqAwQTDR8FpkFM=;
	b=lKhmMuI3ZwWiQUgN8odFkwnz//3t8O2pOxd+TLFnqeCvmj81Ho6zIKybpd0wOpe44hxJZ3
	VOwxP5tA4oUXGqwtGIbLMd70lXdjgfWZ0PeLFjGMEDPDd3DUH/SFNYRaBJ9Zl4VAAlEhTJ
	gZlVQHwNi+ehozANBhPPGrxDrb30VOL8fje+iG3Fq5iCqJ+ms0aWf67P1xuM2aWl2IgB5r
	ow+dp4vF9yGFOwzekzg2x5jUnj9a2qwKkcZInjrfkVmOBih/uIplWLO8avbCN8YOK56WG/
	6TCZjnZleWShPQmM8Ec8QiDtSxpACUN3wSrkGLSIZ2IZ/gaDxYpQDO3U4h9WiQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 10:48:38 +0200
Message-Id: <D92TURINAJOL.3ADIZ21U2DHCT@bootlin.com>
Subject: Re: [PATCH v6 04/12] pwm: max7360: Add MAX7360 PWM support
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
 <20250409-mdb-max7360-support-v6-4-7a2535876e39@bootlin.com>
 <Z_anx4eiPB9DJ97J@smile.fi.intel.com>
In-Reply-To: <Z_anx4eiPB9DJ97J@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekgeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 7:00 PM CEST, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:55:51PM +0200, mathieu.dubois-briand@bootlin.c=
om wrote:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>=20
>> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
>> 8 independent PWM outputs.
>
> ...
>
>> +static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *=
pwm)
>> +{
>> +	struct regmap *regmap;
>> +	struct device *dev;
>> +
>> +	regmap =3D pwmchip_get_drvdata(chip);
>> +	dev =3D regmap_get_device(regmap);
>> +}
>
> This will produce compiler warnings. Why do you have this at all?

Some leftover of a previous version, having this clearly does not make
any sense. I'm surprised I didn't get any compiler warning about this.

>
> ...
>
>> +	device_set_of_node_from_dev(dev, dev->parent);
>
> This needs broader discussion.

Yes, we can continue our discussion in the pinctrl thread.

Ok with all other comments. Thanks for your review.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


