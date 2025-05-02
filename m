Return-Path: <linux-pwm+bounces-5808-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAE8AA714C
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F689A22A3
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52624C083;
	Fri,  2 May 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d/uuvasm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453841DF75C;
	Fri,  2 May 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188044; cv=none; b=l4LKV7wzsVgnWbrpU94SCMbnFdeRO+GAEIDqGqVemlGZRd4bWMngJ+PHwEUB/opHVNS6Ee3S2ei8Xvcdoh0jlWkA1KY/8PwmCYwtwdJ1yuELNwGcwTnAuEDKwwL9BVcALOn3X9fCuH+9DgpG2vjdl63vEppZdZs4RKHX6MlRA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188044; c=relaxed/simple;
	bh=qzjeHjcOjowLZFXG/jZEPH3BZj/3SWbgVlFBrv8GAno=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Ujf8FCWuMzoAyxWc/LgbU4y3vBU87am760gdLLZ6S0m8BrcQbe8pND4bENGjbjIgaFoFdDThI1EILm98eVv98q4IH51CWA6sZUT7oNdGsrY1QZcc8QYKDISWVht5o3GirphP81H4SROz8oyix1qyO2jn/xDL4vTm8RDQ3wqHKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d/uuvasm; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19C0B43302;
	Fri,  2 May 2025 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746188033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThJ+c2xPN7+O9usD5U/qLq9TQibJ4VHLal34gC1vvYI=;
	b=d/uuvasmN9JzH4M4NCNhdkVa5tRVmROXv4Mq8GrwEzVYZj8oYVsai3/iqwy08Q7Df6UGr+
	xsG1TOu1eXgtMRRcoC3XPsWbwLuVqvDE4S6QJL9fiZZbn5NCYuhJrCNLtzl8bDnOysj/Y3
	VbxXGtFHZIEETA276bBvEl/fq/YkRLieftEni44Kq778fZ1aV+wAxSgCvqZkJQfG5fc5pf
	vzBkBuSrMkClwr6lKdpUSogXCcEv57SVZDahpLLsHUddVaiRmMto/vd6Klt64+ACM+8nYi
	Td/L9MKGKSB+zRNqstUgCNmPs+0vxZdmVOnJpimSYIXaZg/RfhGdIx1wjqWkQg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 14:13:51 +0200
Message-Id: <D9LNZVEKP7VV.2UC5AY0D45CR2@bootlin.com>
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
Subject: Re: [PATCH v7 04/11] pwm: max7360: Add MAX7360 PWM support
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-4-4e0608d0a7ff@bootlin.com>
 <aBScGRN-1C81gtC5@smile.fi.intel.com>
In-Reply-To: <aBScGRN-1C81gtC5@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvgedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 2, 2025 at 12:19 PM CEST, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 01:57:22PM +0200, mathieu.dubois-briand@bootlin.c=
om wrote:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>=20
>> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>> +					     const void *_wfhw, struct pwm_waveform *wf)
>> +{
>> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +
>> +	wf->period_length_ns =3D wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
>> +	wf->duty_offset_ns =3D 0;
>> +	wf->duty_length_ns =3D DIV64_U64_ROUND_UP(wfhw->duty_steps * MAX7360_P=
WM_PERIOD_NS,
>
> Does the numerator have already 64-bit type? Otherwise (u)int*(u)int will=
 be
> just an (u)int.
>

Err no, this section has been modified back and forth, but today we have
u8 * 2 * 1000000L, so we will always fit in a u32.

I will use DIV_ROUND_UP() instead.


> ...

OK with all other comments.

Thanks for your review.
Mathieu


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


