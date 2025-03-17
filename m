Return-Path: <linux-pwm+bounces-5205-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE539A651D6
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 14:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53056173AC2
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A879A23F422;
	Mon, 17 Mar 2025 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E/NFBWzO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DAE23F277;
	Mon, 17 Mar 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219502; cv=none; b=YoveTpzkIHgt0pzCdCovsx9RAk92vQFXspkxvYZhxjSj9mtvuy1gyJMDnd6FVJpR8vvrUuXctCT80J8zU3bqvHqQlxVedlBElhMsz0k/Wb9wH19GU26hMNKajZs/K+oKBkgVwxhnOoPXd1ii5USX7gDESByo7MsW6g7cLtmMijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219502; c=relaxed/simple;
	bh=6tXJmTOt9OvwD8ihnhNqIpB4znJb/dP1SVDxN15PS74=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:Mime-Version:
	 References:In-Reply-To; b=bcBe/gAtHOl5vBrm+vcB+6yk6MmQqMA/wWFct9zZ++x1dOKo4EoUewkTObJVO3sa3VyV1hpsbbgQZCqzMLC71yRC0ovOe67M+2sJPT4Q6EiYUn3yBvLOHLy4XUVjZuUeyYyDA0vw5PMROEyCdkGqe0yvX2Wb7iwCCfEVrwiX5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E/NFBWzO; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB8272058A;
	Mon, 17 Mar 2025 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742219492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NtgX5jhncJhxgIK5qQ5c2DwATuhUFn7mLC9sGWQROE=;
	b=E/NFBWzO3FHEBo7S/3dO98+JMqDNe/1qg+t5woNWhbfaghH3VMCjyHrUA7GTJV9tRLimnv
	BuLsyy+l9/4x9wSl1bSz7Niu88SAABfKR3Yng2iRswM6ixflGqoyZcC9XNESQ1oX+JCEYd
	FADlidkLQez+Q5ZNqSQcQQIbRIjlHw3U+Cbn2uIvOCANgfxKRiQrLpSu/lXdYdtE5WTa6b
	T7UCV6HBdO267bibsLhOULgnm5r0WKvKd3cfEgBizGQoNp1n45/9bh3G91GHaMBBBv60Ao
	DoPKoNz84I5Mx3H6CYWmiVl1QRd9+wnquYTBFWoNWG1k1SgVwPeXInflFoqPgw==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 14:51:30 +0100
Message-Id: <D8IL9KSYUQZK.MB94IIL9FUL1@bootlin.com>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Michael Walle" <mwalle@kernel.org>, "Mark
 Brown" <broonie@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Linus Walleij"
 <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 03/10] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-3-8a35c6dbb966@bootlin.com>
 <e7epeegrp6cz27s63gnqe7b6me7h3rn5d6mo7mbd6rwgnwyys6@j7f6cy4uy3wq>
In-Reply-To: <e7epeegrp6cz27s63gnqe7b6me7h3rn5d6mo7mbd6rwgnwyys6@j7f6cy4uy3wq>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkvefhvffuggfgofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelfeetjeetffegkeeukeehvdegleeklefggfdtieduvdfgkeeggefhfeekffefhfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrr
 hhordhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Mar 13, 2025 at 10:03 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> Hello Mathieu,
>
> On Fri, Feb 14, 2025 at 12:49:53PM +0100, mathieu.dubois-briand@bootlin.c=
om wrote:
> > diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> > new file mode 100644
> > index 000000000000..f1257c20add2
> ...
> > +
> > +static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device =
*pwm)
> > +{
> > +	struct max7360_pwm *max7360_pwm;
> > +
> > +	max7360_pwm =3D max7360_pwm_from_chip(chip);
> > +	max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm, false);
>
> Would be nice if pinmuxing would be abstracted as a pinctrl driver. Not
> sure how much effort that is. Maybe Linus has an idea?
>

Yes, I got some similar comments previously and I've been working on it:
the next version will gain a pinctrl driver.

> > +}
> > +
> > [...]
> > +
> > +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
> > +				      struct pwm_device *pwm,
> > +				      const void *_wfhw)
> > +{
> > +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
> > +	struct max7360_pwm *max7360_pwm;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	max7360_pwm =3D max7360_pwm_from_chip(chip);
> > +
> > +	val =3D (wfhw->duty_steps =3D=3D 0) ? 0 : MAX7360_PWM_CTRL_ENABLE(pwm=
->hwpwm);
>
> Does not setting MAX7360_PWM_CTRL_ENABLE result in the pin going to
> Hi-Z? If yes: That's wrong. You're only supposed to do that if
> period_length_ns =3D 0 was requested. If no: This needs a comment why
> duty_steps =3D 0 is special here.
>

Ok, I confirm this does set the pin in Hi-Z, I'm fixing it.

...

>
> Best regards
> Uwe

Thanks for your review.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


