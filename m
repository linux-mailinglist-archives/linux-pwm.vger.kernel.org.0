Return-Path: <linux-pwm+bounces-5573-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E94A93AC4
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF2D1889262
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA024219A8D;
	Fri, 18 Apr 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QN1FI8mQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6DD218EB3;
	Fri, 18 Apr 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993225; cv=none; b=ELmzZkwGV+bNukRG/Dx5FAc0i5BQExzm334zy3H/7L2NBWnlfLsUU4cMJQa0ei45+SF3zdtUEiQlXGzFWxfbJzHItl7HOYgij0weUzAGXv99VMSniJ+v9PsN63ZVTIrtIWy0l7OASk/UDET0wNDLrb2x5KXvkuwp749g3DTYEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993225; c=relaxed/simple;
	bh=K48rndTQFDaaOgqbnB9bEd3QXRHyyPSM0ZTytB4DXGQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=eV3zo+wqdDnIiUNKIX5WHYxorYYbEY/LocJjJir/ysFIU6C5c8TGFGDgdam0Llxtbmjd/AnVLFEGIt2hA+3K/fVgnpdwDUNdrCVvJFB3EtuhK9BWV29pUlaxgIAkw4o0IByqArP41x6ple9DBOGm9khPlTHos99guj7CNJjVVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QN1FI8mQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E58543AF0;
	Fri, 18 Apr 2025 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744993215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8Rt+EG00BQ+3x+tc7srxHh256czauX3We3PGhtVTSQ=;
	b=QN1FI8mQISumOPJ0G2uRyToFIlX/neETYw7XQf4G/tOxcdrVHeIT4/Uyj+GvQsY0Aw719H
	p4/KLAbqVc2JdsXobEnpDu8QsPyda5YBFq+2w7wHi3I24rO3SOM5/z8x0eIeVdCuWjdTW2
	Sr4pUTkwdlb3vE1nkTAuX3LwPch7D4sTaXCjHg4YjioG6KUggmC8e702BByXLI+FtU06P8
	U7zEgO8v4X3ml01aiKaa/OcIwfReW+/9/ncu5iVlk9kYJUhYKqsVAaqbYivlo1VFI8EN4p
	ofEe8pZYe/N0T9kg1LvTk/7e48ja8w+CbnBRSXZfSucGE3xibeFQ28w13dothQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Apr 2025 18:20:14 +0200
Message-Id: <D99WGVRMZKJ2.RZOWU8FHTTEJ@bootlin.com>
Subject: Re: [PATCH v6 02/12] mfd: Add max7360 support
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-2-7a2535876e39@bootlin.com>
 <bb269f81-d33e-4292-89df-4c8cf40b3077@wanadoo.fr>
In-Reply-To: <bb269f81-d33e-4292-89df-4c8cf40b3077@wanadoo.fr>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedviedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegthhhrihhsthhophhhvgdrjhgrihhllhgvthesfigrnhgrughoohdrfhhrpdhrtghpthhtoheplhgvvgeskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Apr 18, 2025 at 5:52 PM CEST, Christophe JAILLET wrote:
> Le 09/04/2025 =C3=A0 16:55, mathieu.dubois-briand@bootlin.com a =C3=A9cri=
t=C2=A0:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>=20
>> Add core driver to support MAX7360 i2c chip, multi function device
>> with keypad, GPIO, PWM, GPO and rotary encoder submodules.
>>=20
>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.co=
m>
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>
> ...
>
>> +	ret =3D max7360_mask_irqs(regmap);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Could not mask interrupts\n");
>> +
>> +	ret =3D  devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>
> Nitpick: 2 spaces after =3D
>

Fixed, thanks!

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


