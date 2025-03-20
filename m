Return-Path: <linux-pwm+bounces-5259-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A6DA6A1BD
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 09:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D983A16A5
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB5214A84;
	Thu, 20 Mar 2025 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M1AOPBfc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E44207A0F;
	Thu, 20 Mar 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460533; cv=none; b=UYmn1VjhrBPUOJvHBnL3GrCyYNcoXN24UQEAIgqXEQ+mUMPGEQnEvAtsWzdLqiLFno6I5gZr/cbPf+IF1YXIYhsKY5uQg1NSB7XOa6dH5i5vjdc5NXSzqAqxl6+JzChRVrFhVYpUcuRfp1N+q4wZQaOZM+WDvQpY5FgAvQwVBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460533; c=relaxed/simple;
	bh=piwWujZ95X2+r888zaO9uwHDGuG7wI2DPfi6mXKB+GI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=GqRqCEquf1HKZiQpD6co1xwzGOt0efI15RjNtXkESMg8J+uJJ1sUDBmrR95hbEfEV7aqybLhrCsltRnfS4nYh/FzoEY4YmAKXmpvy/ORRkEdOUJfgfHAQdXXJkd7GhGgq+rCPc3jz2XaS0CEhN0iCzti5uLWYEZUiuQNusJduYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M1AOPBfc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E348F443E5;
	Thu, 20 Mar 2025 08:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742460528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZBbFeB+cHAe3LqVeQ7qmEznxfKl0DVyWGj2Y+wzxXU=;
	b=M1AOPBfcrZy5xNZ96ThS+AYNGZK0EaxP4/ceehgcEh7QIZQ9fQp9h1+lFATIsdDI7fohAV
	vO7GFv1OKFzCHh2Dg9cz47TCZCQrGDgBG5icaqGA+VxVtuS9wUp6xhsZziey9E/Ev1RjUS
	cxdbws1ioCUMakOqh9hc37Y/OLDSu3Q2AeL2yLY4PMEBDfwHIHCR/PcVWHqR0KZxiqbQgT
	xnHv0OEJwGIqO464+FCO6xrvEAks8EknvRx10GlpIPCZNFvgoQXqamv0U0MpTHjxL+8Uuf
	WCPf0l1IdN0i6jEI0cHwAO9nZexQB/RaTmBiYKp+rMlpLKl+iXEd15e0ayc8Cg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 09:48:47 +0100
Message-Id: <D8KYPFLQHXY9.10R2C06GYEO17@bootlin.com>
Subject: Re: [PATCH v5 07/11] gpio: regmap: Allow to provide init_valid_mask
 callback
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
 <20250318-mdb-max7360-support-v5-7-fb20baf97da0@bootlin.com>
 <Z9mk8ZE1Z5_Zdyer@smile.fi.intel.com>
In-Reply-To: <Z9mk8ZE1Z5_Zdyer@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhor
 hhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Mar 18, 2025 at 5:53 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:23PM +0100, Mathieu Dubois-Briand wrote:
> > Allows to populate the gpio_regmap_config structure with
> > init_valid_mask() callback to set on the final gpio_chip structure.
>
> ...
>
> > -	chip->request =3D gpiochip_generic_request;
> > -	chip->free =3D gpiochip_generic_free;
>
> Stray change.

Oops, reminder of a dropped patch, thanks for noticing this.

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


