Return-Path: <linux-pwm+bounces-4910-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A2A3623B
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC676170D5E
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D502673A1;
	Fri, 14 Feb 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dav+8sus"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A13234;
	Fri, 14 Feb 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548204; cv=none; b=kAIYbN/WHpDzWfATju8VgVPpIsdjYOocXyot8ohkBEg19oNUBnIpa8HJnbdyHUmdudfM3x7+SN/2AFJCnjDBzgbAHsWvQU4Auqzk+/ae2PEJQPvp5xfn8VHeep0fm27pR6oQbpzbU7F0jZITAdrbpYjcQnNSMImSc42Y8O5gAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548204; c=relaxed/simple;
	bh=TG0xmfKkdGCLTdkpVoqtkePlbBY6zdq8gtzJjlZj16E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=rd9t5Cf3tNS60/VOSq+cvrcfRLPYSj3nPBsTrNZJYB2H85QPxXmUS2VHIAwBX1aChkjcl7ccJgHtM3c+YW1L8GbcRHzbSWFy1RSQx5GEnBSjhNF4Fook1c7p05M4fex+y5mPvFENUTuYOFgDlxEvY3GeYRXFmlVPRMZJP6I+Aq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dav+8sus; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEABD44305;
	Fri, 14 Feb 2025 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739548199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69qA403PSDbxwZhDUp8oR/q0a9JjXlx2hGab0Dld0Z8=;
	b=Dav+8susmRMhLBPQAqVqjwAoocdEZoWUXe+To5AeWBg+gwwGdYRhrseBwpmlk20vfaY9sc
	t8hG01G4ynHzDSR25lZyHxbhfPZ1GvUG7HKijkD7lAM2k84ON2/oxE3NEDWPc89fUGBOyK
	uM2W9sPHU0WTdipxhr/1V5pxdk4gLGOjrw8BdhNdAUw1vBkNqKvtVbOCIVE/qqjzPiV8zL
	lbb8e1px1ZpnyoUsNdnZf5Nynzy8aRXIlvWo+sCtmH3p+uUsWP40qHfWfrGKV0h5f668Gb
	3ACFErufX8KA7DDmn22NG7JwWzsx2cdhGMzItc0ceyIvOm5LGgEZninGVqv5qQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 16:49:57 +0100
Message-Id: <D7SADDQZUERA.PT8QLVZ9ZN1N@bootlin.com>
Subject: Re: [PATCH v4 06/10] regmap: irq: Add support for chips without
 separate IRQ status
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
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-6-8a35c6dbb966@bootlin.com>
 <Z69eue2dV37vw61v@smile.fi.intel.com>
In-Reply-To: <Z69eue2dV37vw61v@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Feb 14, 2025 at 4:18 PM CET, Andy Shevchenko wrote:
> On Fri, Feb 14, 2025 at 12:49:56PM +0100, Mathieu Dubois-Briand wrote:
> > Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
> > provide an IRQ status for each separate line: only the current gpio
> > level can be retrieved.
> >=20
> > Add support for these chips, emulating IRQ status by comparing GPIO
> > levels with the levels during the previous interrupt.
>
> Thanks, this will help to convert more drivers to regmap
> (e.g., gpio-pca953x that seems use similar approach).
>
> ...
>
> > +static irqreturn_t regmap_irq_thread(int irq, void *d)
> > +{
> > +	struct regmap_irq_chip_data *data =3D d;
> > +	const struct regmap_irq_chip *chip =3D data->chip;
> > +	struct regmap *map =3D data->map;
> > +	int ret, i;
>
> 	unsigned int i;
> ?

I agree, but signed int index variables are used in all functions of
this file. What would be the best approach here? Only fix it on code
parts I modified? On the whole file?

>
> > +	bool handled =3D false;
> > +	u32 reg;
> > +
> > +	if (chip->handle_pre_irq)
> > +		chip->handle_pre_irq(chip->irq_drv_data);
> > +
> > +	if (chip->runtime_pm) {
> > +		ret =3D pm_runtime_get_sync(map->dev);
> > +		if (ret < 0) {
>
> > +			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
> > +				ret);
>
> Can be one line.
>

Yes. Kind of the same question here: should I fix only the code close to
the parts I modified or the whole file?

> ...
>
> > +		for (i =3D 0; i < d->chip->num_regs; i++)
> > +			d->prev_status_buf[i] =3D d->status_buf[i];
>
> Hmm... Wouldn't memcpy() suffice?
> But okay, this seems to be not a hot path and the intention is clear.

Yes... I don't know why I didn't use memcpy. I will fix it.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


