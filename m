Return-Path: <linux-pwm+bounces-5444-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378E5A841BA
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 13:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E88A6B8D
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18291281530;
	Thu, 10 Apr 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c3Dq2l3r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C21D89FD;
	Thu, 10 Apr 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284587; cv=none; b=RoCPKguPi3AcTIQlNlpzZ6buzL+ifm92jOJM75Q2rJ7T4n6H8E9Ou1IANVyVbIt/yke547H6UY5eYMmLFClH3lEytsbijU8WnVHnzzq+cYVN/LNJMOT/FFG+wYEtao/MVbHYci4NPocTknxl6vVazOa00wbEHK2WO+qsWdyci6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284587; c=relaxed/simple;
	bh=HZES9pXg4cmaTiSlbNcW6mQ3TVO6SVmHNL0ZJvT71B8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=rQ4aomPXz0KW6OT9nIhZ73fHqpWRe+DNB848J+XLx+e+OGL78VRLPuvGAbwSxznOgqS97GE0O63rBAJVvwkPG0jPJ1wrZJKdfIP29t6hccXZoSejd8LFNk8KwvstMQl2tiIqwVaIoU+1ZvQ2RXE4LI2jMvg8xVaZ4XhQ4cUjz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c3Dq2l3r; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 946C842E7E;
	Thu, 10 Apr 2025 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744284576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPYbX6fgpQKH4gxTLPqiuRTln0p2CLo5Xpglajm7yQ4=;
	b=c3Dq2l3rV3r4VCBO5MdlBSCaimsTsADpHW1jyVn1NurkDOUKRhbehdmhwyZmJmn0wyBOBs
	BnEeLFYXW9fFdHbyovxfw/W7BJy4zAQujjXSitqCDb7RhQ2eU60RT9Suu4NzTxQbxCgq8g
	0gWIZs3CeuAra2uQ3m/UPqnLAIrix/S68CqhLJcYvt38/DNP32hWAyRMHqH3wNdFhTtCRJ
	azb88G7zUS2fmB+F3S2WKsQdMy9W4kvmjDGnCD0tgwr9pdfnGRAnKtk/ggK+16f7dsCT1E
	aJU9K2zkXzL03y4UllN74cgTARb3lp/Y+GSrklq2fLL801lTg2tgHbdohHYrfg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 13:29:35 +0200
Message-Id: <D92X9ZK07SIK.124N9HG8W7QEI@bootlin.com>
Subject: Re: [PATCH v6 10/12] input: keyboard: Add support for MAX7360
 keypad
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-10-7a2535876e39@bootlin.com>
 <chhnkepvlbiv6xvgh5zso526xsp4zk7tgzsqzoqe7b5jmvdyrw@afio6lmx55zv>
In-Reply-To: <chhnkepvlbiv6xvgh5zso526xsp4zk7tgzsqzoqe7b5jmvdyrw@afio6lmx55zv>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhor
 hhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 8:40 PM CEST, Dmitry Torokhov wrote:
> Hi Mathieu,
>
> On Wed, Apr 09, 2025 at 04:55:57PM +0200, Mathieu Dubois-Briand wrote:
> ...
>> +static irqreturn_t max7360_keypad_irq(int irq, void *data)
>> +{
>> +	struct max7360_keypad *max7360_keypad =3D data;
>> +	unsigned int val;
>> +	unsigned int row, col;
>> +	unsigned int release;
>> +	unsigned int code;
>> +	int ret;
>
> int error;
>

Ok using error on all similar cases.

>> +
>> +	do {
>> +		ret =3D regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val=
);
>> +		if (ret) {
>> +			dev_err(&max7360_keypad->input->dev, "Failed to read max7360 FIFO");
>
> This will return name pf the input device, whereas logging name of the
> platform device (representing the hardware device) would be much more
> interesting. You can either use max7360_keypad->input->dev.parent, or,
> better yet, add *dev pointer to struct max7360_keypad.
>

Makes sense, thanks.

> ...
>
>> +static int max7360_keypad_build_keymap(struct max7360_keypad *max7360_k=
eypad)
>> +{
>> +	struct input_dev *input_dev =3D max7360_keypad->input;
>> +	struct device *dev =3D input_dev->dev.parent->parent;
>> +	struct matrix_keymap_data keymap_data;
>> +	const char *propname =3D "linux,keymap";
>> +	unsigned int max_keys;
>> +	int size;
>> +	int ret;
>> +
>> +	size =3D device_property_count_u32(dev, propname);
>> +	if (size <=3D 0) {
>> +		dev_err(dev, "missing or malformed property %s: %d\n", propname, size=
);
>> +		return size < 0 ? size : -EINVAL;
>> +	}
>> +
>> +	max_keys =3D max7360_keypad->cols * max7360_keypad->rows;
>> +	if (size > max_keys) {
>> +		dev_err(dev, "%s size overflow (%d vs max %u)\n", propname, size, max=
_keys);
>> +		return -EINVAL;
>> +	}
>> +
>> +	u32 *keys __free(kfree) =3D kmalloc_array(size, sizeof(*keys), GFP_KER=
NEL);
>> +	if (!keys)
>> +		return -ENOMEM;
>> +
>> +	ret =3D device_property_read_u32_array(dev, propname, keys, size);
>> +	if (ret) {
>> +		dev_err(dev, "failed to read %s property: %d\n", propname, ret);
>> +		return ret;
>> +	}
>> +
>> +	keymap_data.keymap =3D keys;
>> +	keymap_data.keymap_size =3D size;
>> +	ret =3D matrix_keypad_build_keymap(&keymap_data, NULL, max7360_keypad-=
>rows, max7360_keypad->cols,
>> +					 max7360_keypad->keycodes, max7360_keypad->input);
>
> What if it fails? Error handling please.

Yes, forgot to return ret just below. Not adding logs as in most cases
matrix_keypad_build_keymap() will already print some logs. OK with that?

>
> Also, it looks like you are repeating what matrix_keypad_build_keymap()
> is already doing. If you pass NULL as keymap data, won't it do the right
> thing?
>

No, because matrix_keypad_parse_keymap() is using input_dev->dev.parent
and this device will not have any associated device tree node. It should
use input_dev->dev.parent->parent to get correct values.

There is a discussion ongoing about using device_set_of_node_from_dev(),
so the MFD child device reuse the node of the parent. But I tried to
avoid using it here, as I was able to come with another solution.
Discussion is in the thread of the pinctrl driver (patch #3).

Another solution would be to modify matrix_keypad_parse_keymap(),
allowing to pass a custom device. But again, I tried to avoid doing this
modification just for my own need.

> ...
>
> Thanks.

Ok with all other comments.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


