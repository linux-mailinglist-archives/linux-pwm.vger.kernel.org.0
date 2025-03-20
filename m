Return-Path: <linux-pwm+bounces-5258-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43192A6A1B0
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 09:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D53A18927EA
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FDB214A84;
	Thu, 20 Mar 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L/6eYEZ2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E9130A73;
	Thu, 20 Mar 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460335; cv=none; b=ZzMTlwqiKvri3q6XGHfOoypJkYLHhEMshCucb9mCd239z9D48XlLMgxqD05NlcQL687Iid7HjaRBQhcrC2K+9Bxh4XSEdRzs9L67/9xcxHCb0P0CE2kWF5TjXApZ0Z/FgU+5BRKwtVqMMxhsrzIehDURy3ynnxD9zQe8qOBuqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460335; c=relaxed/simple;
	bh=uRy9sQef2mfIzmTtKIHoT2rO8SzOJ8M3K5MCAVMCx9U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=oz9snywhOk9EqdW9ke0bJMILuKKacztMDUuvfxsHpgFtRO+pmlGdTQeTPBNovNM+1XwbKGwiHpt9Xvv+SU+YYWFn9JVV0/z+UGT25GApMmPJK1cAE9mGkWZ7XDcgYLXUrq2bxPd3GrHNRRzOOH08qmE9Cg6hKXXxd598OscRIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L/6eYEZ2; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ED652057A;
	Thu, 20 Mar 2025 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742460330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/MOKCaazGQ+7IgrYNdLGkngEevazyJ/NSGVFcYF2io=;
	b=L/6eYEZ2aYVxXq4zrN7XHtnzbAllroxK4oze2qe3b1OOdHCIHcQx+yGnY+ZUx6lBEM2TOH
	VY75xAIJfhiOp9aNUgi9p5t0v/zZvQkFtLu66leRIsxq3FN9GnYIsuPrRuGDq6nEk2qcdo
	SmWQBA6wloJupAELJAWdCigv8+UrApjzP3Cqjr/Oj7RqO+iOIP83JINZodO6m0SHgBTmw2
	ltnu5DBQxX1c9KML7m4taTloVkL8/Q8CCZazm5/fUrpJVMLLvJMVkxzj/4bf9k/zEuxBHM
	cgo3F5SGccuPchuTsIap5tgZFzhQTEKEcWmu9s5uJT5dmAT5ItN069P11Z/Uxw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 09:45:28 +0100
Message-Id: <D8KYMWA0B1AD.3J83HQJAXF929@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 05/11] regmap: irq: Add support for chips without
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
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-5-fb20baf97da0@bootlin.com>
 <Z9mh0ENc1kDFrJlQ@smile.fi.intel.com>
In-Reply-To: <Z9mh0ENc1kDFrJlQ@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvffuvefhofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeethfeiheehheegheekueeigfekffdvheegfeeivefgkeeftdehhfdthfehueejfeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvr
 hhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Mar 18, 2025 at 5:39 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:21PM +0100, Mathieu Dubois-Briand wrote:
> > Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
> > provide an IRQ status for each separate line: only the current gpio
> > level can be retrieved.
> >=20
> > Add support for these chips, emulating IRQ status by comparing GPIO
> > levels with the levels during the previous interrupt.
>
>
> Some nit-picks below, but either way
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> >  			default:
> >  				BUG();
> > -				goto exit;
> > +				return ret;
>
> Hmm... BUG() implies unreachable, perhaps just a precursor patch to drop =
this
> goto completely?
>

Ok, I will add a separate patch to remove the goto.

> ...
>
> > +	/* Store current levels */
> > +	if (chip->status_is_level) {
> > +		ret =3D read_irq_data(d);
> > +		if (ret < 0)
> > +			goto err_alloc;
> > +
> > +		memcpy(d->prev_status_buf, d->status_buf,
> > +		       d->chip->num_regs * sizeof(d->prev_status_buf[0]));
>
> Perhaps array_size()?
>

OK

> > +	}

Thanks for your review, and thanks for the tag.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


