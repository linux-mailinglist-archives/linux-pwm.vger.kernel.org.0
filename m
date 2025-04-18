Return-Path: <linux-pwm+bounces-5570-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981FA93998
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 17:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509AD464A5B
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73281211285;
	Fri, 18 Apr 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jRh0PjBQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC638FB9;
	Fri, 18 Apr 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990017; cv=none; b=QFHWcwGXbgCOo+H1UdXzlTNKtby+yn+fcVkdTLrL738VqYLZp4av+5n8sw1osw5ZvfdrYHFitYYuLKb60c8uct2wv/UquuEgm9y23gzjxEWTt6+lP9BpO6j+BDiEIl1qM1G7zMY2viODfw9kEwqLlh0hss6PwqKCXo8J2HXzs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990017; c=relaxed/simple;
	bh=XWSsNQuWP0x2aUg9USTmWsxm+dnGjwDvN4FzCiXZMoo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=gcftZ02DWbNtE82k+2z6kLYlHVHsf3ZiSjBR7RgIf99OAfDkcsCsLP9P8s8DCIFvB4H28/goBiE0EQDUBi8WmDrhxEeCVOBb6raONV6GdkzHa/HJ65TOvlg8T7XHpCr97A857XtdXTrYpE2rITlRns9yvI60hYeQ5hxt5HVuVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jRh0PjBQ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BC97431BA;
	Fri, 18 Apr 2025 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744990006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNDVjS9Ecf/JVJ+se63WO9MhluBgtWHZjFkXlGycTfI=;
	b=jRh0PjBQf+DtVoqsLFAM80NGxwbyPkkPSCdcERiSIGYksp9EK1p5UkOY6OI/w7CtMcgo3w
	qg/xNIZdROduFXw+V7QZGPzwOO+GGsTAqCn82QHizytQoNE+dYX9g8r588MtnBhsgBrCX/
	py1ZUZDQkFbiXnAb35zazjfBrBxBAjAQXcN0fnoHEI2ekpCVLOdNd8hROR819Bl1WZvBz6
	TaV/SHNLz2g7dLw1Vw/yRWi7HYu8kH3MQuIWlLo+MK0SYLQMQCUXP7PZBoc0yX1j+ZMfni
	slkE8zpd262MJKsRnRdjUBLG83Cb3IbsUBOZnMmvsllaSHWwsZoYhIAT3pq/OA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Apr 2025 17:26:44 +0200
Message-Id: <D99VBXHNLWCW.2PQQZ21537GHQ@bootlin.com>
Subject: Re: [PATCH v6 09/12] gpio: max7360: Add MAX7360 gpio support
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
 <20250409-mdb-max7360-support-v6-9-7a2535876e39@bootlin.com>
 <aAFE18Yn5rtnuooc@smile.fi.intel.com>
In-Reply-To: <aAFE18Yn5rtnuooc@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Apr 17, 2025 at 8:13 PM CEST, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:55:56PM +0200, Mathieu Dubois-Briand wrote:
>
>> +#include <linux/slab.h>
>
> I don't think you use this header directly.
>

Right.

> ...
>
>> +static int max7360_gpio_probe(struct platform_device *pdev)
>> +{
>> +	struct regmap_irq_chip *irq_chip;
>> +	struct gpio_regmap_config gpio_config =3D { };
>> +	struct device *dev =3D &pdev->dev;
>> +	unsigned long gpio_function;
>> +	struct regmap *regmap;
>> +	unsigned int outconf;
>> +	int ret;
>> +
>> +	regmap =3D dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
>
>> +	gpio_function =3D (uintptr_t)device_get_match_data(dev);
>
> Somebody pointed me out the Linus' rant on uintptr_t, so he prefers not t=
o see
> this in the entire kernel. He suggested to use (unsigned long), but ideal=
ly one
> should operate with the info structures instead.
>

Ok, let's define my own platform data structure, this is not a lot of
work to be honest.

> ...
>
>> +
>> +		/*
>> +		 * Port GPIOs: set output mode configuration (constant-current or not=
).
>> +		 * This property is optional.
>> +		 */
>> +		outconf =3D 0;
>> +		ret =3D device_property_read_u32(dev, "maxim,constant-current-disable=
", &outconf);
>> +		if (!ret) {
>> +			ret =3D regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
>> +			if (ret)
>> +				return dev_err_probe(dev, ret,
>> +						     "Failed to set constant-current configuration\n");
>> +		}
>
> This will look better as if-else:
>
> 		ret =3D device_property_read_u32(dev, "maxim,constant-current-disable",=
 &outconf);
> 		if (ret) {
> 			outconf =3D 0;
> 		} else {
> 			ret =3D regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
> 			if (ret)
> 				return dev_err_probe(dev, ret,
> 						     "Failed to set constant-current configuration\n");
> 		}

Yes, actually there is no need to set outconf if the property was not
specified.


Thanks for your review.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


