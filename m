Return-Path: <linux-pwm+bounces-5207-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95B6A6541B
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 15:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA03170BD5
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B17245036;
	Mon, 17 Mar 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W6M9urUR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485092459FE;
	Mon, 17 Mar 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222688; cv=none; b=Hmbd14FFQGC1wJz1OPpgWrLEMZZTQ/6CzrUR77BYhN/OafWrToyOXPheU2mWwoz0du2rv/0sSPK/Td8/Wabpdp/HLel+8SeiAJOkB3GPN5EpMQqnLeWHmm86Qb7+mGiVv7gaPkrhj37gjOtIcN962umOu6dUcPqyaS6Ojx35BU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222688; c=relaxed/simple;
	bh=VkpWTCYEICFBtQwKpzObrfzZpr0tvkzC5CozTqVThw8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=RXW7sfWbt6wSz/8rIPS+EKDigNGESzh44Otn7QqsvKY0FRNtYQ7ZzH0Dr1JMIYf3COnz9rq1xTVSHkx7/tiS6bRARHF0fX/1O4sq7d4Ulwt5tYSoOcCKrSZCTMeBYO7OJb5su3Q8x3R4VTiQj7/F1iJRziq6H+IzQnvaC4+Sdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W6M9urUR; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77F2520580;
	Mon, 17 Mar 2025 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742222683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkpWTCYEICFBtQwKpzObrfzZpr0tvkzC5CozTqVThw8=;
	b=W6M9urUROw0JcmJwg0uLFTceqVb2aMnrVlkiX3lY1gjOhP/3UxUQJez9m4DyvL06W/4cQV
	JzvtW9fqe9DBvq5NlabZ/0F3qCE9JhsiE8YLFltJ/gp5r5na7PIK7zP132ukz6DZFkcB7K
	3nYMgphUPTvJglJGgaK/DAdgMItyxD1MPqvO+AhV8RVOvdLJbcZ2j44gHe0iUkhxZP921h
	Za/yDv/ouvlzVVchP1dOeTIygGI5KvrJTKo3YvAV/WY/L6alTmzFKEne0GN78BmfHjlj7b
	iVIZy/ppP8C2qV2xivMwmVFkUha0fAxLWcGqiIfSrwKmwC4BQMXvdryCRszylA==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 15:44:42 +0100
Message-Id: <D8IMEB2UP6KS.2GOJ4M6INKKN8@bootlin.com>
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
 <D7UOIHL2WOZP.LLGRKMILNJFU@bootlin.com>
 <Z7OXQqyPjtGgTySf@smile.fi.intel.com>
 <D8FAEPI26C8F.397VN87KK9VIO@bootlin.com>
 <Z9PikuvAR-XsYhPF@surfacebook.localdomain>
In-Reply-To: <Z9PikuvAR-XsYhPF@surfacebook.localdomain>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeljeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkufevhffvggfgofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhtdeuhfehtdekueeltdejffdtuefgueffhfeiueegleffueevvefgtedtkeegjeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegrnhguhidrshhhvghvtghhvghnkhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgth
 hgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Mar 14, 2025 at 9:02 AM CET, Andy Shevchenko wrote:
> Thu, Mar 13, 2025 at 05:43:00PM +0100, Mathieu Dubois-Briand kirjoitti:
> > On Mon Feb 17, 2025 at 9:08 PM CET, Andy Shevchenko wrote:
> > > On Mon, Feb 17, 2025 at 12:20:13PM +0100, Mathieu Dubois-Briand wrote=
:
>
> ...
>
> > > But what I have read above sounds to me like the following:
> > >
> > > 1) the PORT0-PORT7 should be just a regular pin control with the resp=
ective
> > > function being provided (see pinctrl-cy8c95x0.c as an example);
> >=20
> > Ok, so I created a pin control driver for the PORT pins. This will
> > effectively help to prevent concurrent use of pins in place of the
> > request()/free() callbacks.
> >=20
> > My only concern is: as there is no real pin muxing on the chip, my
> > .set_mux callabck in pinmux_ops structure is not doing anything. It
> > looks like I'm not the only one
> > (drivers/pinctrl/pinctrl-microchip-sgpio.c does the same thing), but I
> > hope this is OK.
>
> Hmm... This is strange. The PWM/GPIO block has 3 functions (GPIO/PWM/rota=
ry),
> How comes you have no switch between them?
>
> As far as I read in the datasheet this is controlled by register 0x40
> (and seems implicitly by other registers when it's in PWM mode).
>

Yes, on pins 6 and 7, we do switch between rotary encoder and other
modes by writing in the register at 0x40, but that's all. My point was
more about all other modes. There is no difference between PWM and GPIO,
at least in output mode: GPIO level is just a PWM with duty cycle either
to 0% or 100%.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


