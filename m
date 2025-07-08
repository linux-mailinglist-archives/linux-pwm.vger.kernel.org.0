Return-Path: <linux-pwm+bounces-6765-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A8AFC6D4
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 11:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BEF16EAA3
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE52C08C1;
	Tue,  8 Jul 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S9NoOUZo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EAA29B224;
	Tue,  8 Jul 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966046; cv=none; b=qv+XkoH9kZfLUcylPZRu6nzJGf3RECPggGLUKgyJB8g/QAPxM6W89nCszoLqUVAtqxs0v0wcau13uViB5SU7hXtZf0xilPW2kCACB6sbaWwdDyIqWTQig1Y1/4gmkf7GlfIzy+9ewbpaPujctnpRKHaH3qOseu2QEpx40MNuC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966046; c=relaxed/simple;
	bh=P0dWyoW87zDHAA8QBh31R0pJA2SovOolIm0JyMwdVSc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=jF3ic2uQhG0YETT1p8uwcikULDtcKwRZQ4Qq0mvtNlSstDBfosr1pP3EX5A43Jns4z3JKnhm1lwwWnInU4u+DTnKAUyU4VTk5zmfnKEsdpmNQkMcvWqd1xql+ZPZAzKygCkq+YWXl1ZDGxxgqq+NwsNtdKdcZg5EkESztVKtiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S9NoOUZo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97DF0432E9;
	Tue,  8 Jul 2025 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751966036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+3ankCFBI8RZvTwoXY2iWc9bSbD1frozwAdknBYHsg=;
	b=S9NoOUZodJD8PLOgSq0IbkY55tJyFJCNwF6eiUkPLcwFTtmK15t5QtlkVuqXdTaC3rWKRL
	2wyrq93a8Hdfdchr21YdbpZ1nmtTWpSILdb91uzhk6EkZzcJv2PWXTOWSvP5JYnv8Koo4D
	nCWnUyMpS9ztAMSnGRDpS2RiI2MZ+SduH9/g0COhAxqFjI/PSVyKhwa+o0dP9xjXEYEd2y
	LyTxlBgFdNfQmcjeXAp3XAjJy/IjTPz5IGZHj0xblkfGNpJEe/RMbFG4lauobSvrAnaPq8
	U5Codiy8GxS2XDwa4kvtu1sGxhe+ZQ1EG37y+bzkzswuC1MXPeHCq14tMNa0wQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 11:13:55 +0200
Message-Id: <DB6K4LIQEDW2.2IKGMK2O3WQ7A@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 08/11] gpio: max7360: Add MAX7360 gpio support
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
 <thomas.petazzoni@bootlin.com>, "Bartosz Golaszewski"
 <bartosz.golaszewski@linaro.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-8-ce3b9e60a588@bootlin.com>
 <aDny-kJqiPq-Yyx9@smile.fi.intel.com>
In-Reply-To: <aDny-kJqiPq-Yyx9@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffvufevhffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptefhieehheehgeehkeeuiefgkeffvdehgeefieevgfekfedthefhtdfhheeujeefnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 30, 2025 at 8:03 PM CEST, Andy Shevchenko wrote:
> On Fri, May 30, 2025 at 12:00:16PM +0200, Mathieu Dubois-Briand wrote:
>> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
>>=20
>> Two sets of GPIOs are provided by the device:
>> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>>   These GPIOs also provide interrupts on input changes.
>> - Up to 6 GPOs, on unused keypad columns pins.
>
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

>
> ...
>
>> +#include <linux/gpio/driver.h>
>
> Do we still need this header? I mean do we have anything used from it her=
e?
>

Yes, I believe we do, as we access gpio_chip members in
max7360_gpo_init_valid_mask().


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


