Return-Path: <linux-pwm+bounces-5810-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A0AA7232
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 14:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5834C1400
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691FE242D6A;
	Fri,  2 May 2025 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Woz6aWmH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF6182;
	Fri,  2 May 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189408; cv=none; b=ffl2XC2+8Mg8FZxLJEMKuKwnJ72eeOXerOX072htrxvSBPO2DuNuKh1GAADb7B//Jp6ajnLGPEFjVEvCqiKE5ScOXgUDqKQg0ClZJalx0MJHPcjg6QQLabDVYjmtvNp6pzrd4na989Q4Q0GCDi7TAm3pT5GfJ+Fgqsi5kBKpi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189408; c=relaxed/simple;
	bh=jt4cu7JoAcja/i7vDiI5Eo9ijTBc3g0OQvyp48ZU9nA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=AAvfddAGWsMir+uNYhnS2NGIucvT1+hG9AO2V2+vi2gQtk7FlF3FFeO2M0I4cysVPunvD+pHnWTfw+BFL73za5CvQ2baPrGo5TWIQBnoCpIxcSC0DRhu+IZ/5yXWkXkBckyUKm1bTpPkNWK63tWB2dz9G+MPZZncYkcdvPjYgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Woz6aWmH; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id A9458580015;
	Fri,  2 May 2025 12:08:09 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6597343978;
	Fri,  2 May 2025 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746187681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6J//V8N/2FPUCK55/Rt0fc9X9pPfCrpuRCbgqXf8ghE=;
	b=Woz6aWmHiSZ+6qQs+TFI8SsnPc7vh+aL//JQCRYBsQv9PNjJm1tuEBka1eaDwc+XaORNvC
	V8xicpuheO41nEXYkMBVvLHPv5BE6kj81YuBfeC1LUbu4IMy5SPOEFLtv0H3vhA2478BFv
	Ey9dHSyzrozhk9A9EJrtoW8bJ0QraiHWL0M1R5L2hXmra7k99iD83BHmjyDPVUpPhrse3Z
	PKxXddTxsr8Y4eIKvjxyNHkqTAk+kDlTS5vh/lHkdf1mbQ0WYdfcUylhyTmWcov136Rekp
	MiulJXV0CVcuTQmv5Mz7NDAc+hwHMMiQ64Xx6mEBkA9mbdoxwxjwvxHNIHNfbQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 14:07:59 +0200
Message-Id: <D9LNVDTBPE6Q.3KOYKLIH8PPZ7@bootlin.com>
Subject: Re: [PATCH v7 03/11] pinctrl: Add MAX7360 pinctrl driver
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
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-3-4e0608d0a7ff@bootlin.com>
 <aBSbKwmao-K-e1k8@smile.fi.intel.com>
In-Reply-To: <aBSbKwmao-K-e1k8@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 2, 2025 at 12:15 PM CEST, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 01:57:21PM +0200, Mathieu Dubois-Briand wrote:
>> Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
>> can be used either for GPIO, PWM or rotary encoder functionalities.
>
>> +struct max7360_pinctrl {
>> +	struct pinctrl_dev *pctldev;
>> +	struct pinctrl_desc pinctrl_desc;
>
> Does`pahole` agree with your choice of layout?
>

I believe so. `pahole drivers/pinctrl/pinctrl-max7360.ko` says:
struct max7360_pinctrl {
        struct pinctrl_dev *       pctldev;              /*     0     4 */
        struct pinctrl_desc        pinctrl_desc;         /*     4    44 */

        /* XXX last struct has 3 bytes of padding */

        /* size: 48, cachelines: 1, members: 2 */
        /* paddings: 1, sum paddings: 3 */
        /* last cacheline: 48 bytes */
};

>> +	chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	pd =3D &chip->pinctrl_desc;
>> +
>> +	pd->pctlops =3D &max7360_pinctrl_ops;
>> +	pd->pmxops =3D &max7360_pmxops;
>> +	pd->name =3D dev_name(dev);
>> +	pd->pins =3D max7360_pins;
>> +	pd->npins =3D MAX7360_MAX_GPIO;
>> +	pd->owner =3D THIS_MODULE;
>> +
>> +	device_set_of_node_from_dev(dev, dev->parent);
>
> I don't like this, but I have no better idea right now. Perhaps add a com=
ment
> on top to explain this call?
>

I'm adding this comment here, and a similar one in the PWM driver.

/*
 * This MFD sub-device does not have any associated device tree node:
 * properties are stored in the device node of the parent (MFD) device
 * and this same node is used in phandles of client devices.
 * Reuse this device tree node here, as otherwise the pinctrl subsystem
 * would be confused by this topology.
 */

OK for all other comments.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


