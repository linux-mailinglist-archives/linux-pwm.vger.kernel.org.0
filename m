Return-Path: <linux-pwm+bounces-4867-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17AA3265C
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19D3168FE2
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423920D516;
	Wed, 12 Feb 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B98dfFuc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB19271824;
	Wed, 12 Feb 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365066; cv=none; b=MRH4x/5gJjNxSXVHRm4TTsuTZpUaKCRjsTAH66uk+zvFrjeLbtupmYEsFdCGJacld/CTwG6BsNKtR5lttMSJv/uFxjhq51yTRw15WYOvj+jrdjsHWAORSqhXKW9I0FE41ti8U+n1qOzRIUhVHIQJJnDs5oYFbTyAVCRqWX9YxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365066; c=relaxed/simple;
	bh=OPanrCfS1lvnoz7OwCheozB8dxHqLkWEb7Fz9X5l1dg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=aaLyzrRBq6JJxWrvkljjezaJJFueHmUns7cRWZ/CiPeLzZknJSBYoWXn04LkFO+Uzr1yPoS2f9n3mQyqdQ1EA50w/S3J+iW8+LTclehzqNKK9t50oQNuPQuaqBsmaS0avs7VdRJ9RcXyUjfK5o7jSwCzYHksvzRgH2TaU7YaX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B98dfFuc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68FA242CCD;
	Wed, 12 Feb 2025 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739365056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQlDvmMNjG6HkmTEiN6yuUtQAxZ2XiJJ4GjbKF++9lE=;
	b=B98dfFucobdoepjJa/+I5uJim69YPNxpmIzqWZbtDGtT74sp09+RvN0m8WCOUlplsmj11t
	C+7hseTbDtcH3dNXP4f+LEAw8LQmksx2rM8BybUWtv9Ml4bJSurqALhWf8UdzL4K4jLlKU
	JKIIFhLzDosYGbhYwG57aIt99iv8fOhSbw+wdfwpAxmANXeZJYJhGmMsaKir6yzRVKbE1+
	csNMWKcihRpXeg44ZifqI1T7O8BKb2c0KUPy0yIUrSo5DAm9jkiWYwiOE/yXMSseIPGQ9k
	oajfa4yP0TsfYqAxEDULdtEDCH+tqaAw7T9oaaiXlyFZaWJftnFCrwTEsdKfxQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 13:57:34 +0100
Message-Id: <D7QHGB7D0VSG.X255SDU7DFOF@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <Z5eFGJspoGOINcG6@smile.fi.intel.com>
In-Reply-To: <Z5eFGJspoGOINcG6@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffhvffuvefofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheevtdekffeuleehkedtvdejhfeihfegtdduveeghedvveelgfevteekveelleetnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Hi Andy,

Thanks for your review. I've been addressing most of your comments in
this mail and the ones related to regmap-irq. I should be able to send a
new version in a few days.

However I have a few questions regarding some of the points.

On Mon Jan 27, 2025 at 2:07 PM CET, Andy Shevchenko wrote:
> On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Briand wrote:
> > +	parent =3D to_platform_device(pdev->dev.parent);
>
> Why do you need this? Can't the fwnode be propagated to the children and =
then
> the respective APIs to be used?
>

I'm not sure to understand this correctly, what do you mean by
propagating the fwnode to the children?

Just a quick summary of the situation and what I try to do. The device
tree looks like this, only keeping the interesting properties:

io-expander@38 {
  ...
  interrupts =3D <23 IRQ_TYPE_LEVEL_LOW>,
               <24 IRQ_TYPE_LEVEL_LOW>;
  interrupt-names =3D "inti", "intk";

  max7360_gpio: gpio {
    ...
  };

  max7360_gpo: gpo {
    ...
  };
};

Our pdev fwnode points either to the "gpio" or "gpo" nodes, the one from
our parent device points to "io-expander@38". Here we need to get the
"inti" interrupt from the parent node. What would be the correct way to
do it?

> > +	if (!max7360_gpio)
> > +		return -ENOMEM;
>
> > +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> > +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> > +		return -ENODEV;
> > +	}
>
> This is not needed, it is already done in GPIOLIB core.
>

I believe this is still needed:
- For gpos, we need the gpio count to correctly set the partition
  between gpo and keypad columns in max7360_set_gpos_count().
- For gpios, we need the gpio count to setup the IRQs.

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


