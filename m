Return-Path: <linux-pwm+bounces-5875-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B7AB0FA3
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C00716E6E8
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62852676FE;
	Fri,  9 May 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DR9hnALO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D834269AEE;
	Fri,  9 May 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784439; cv=none; b=tfq/XAE2jNPGGhtgSOzg7WYJ+o4GVlj05gggl57X46l3lYIzysSCQoMXUIHdfr5HOdiOEtHYRHtI0RGUnQgMsIZS4j8ER0xib6SV5wtP3uHMgj3iQMUu1Jn3PWrVptikosVWY/xilwLOn5nB8JSsyHtsoAE3hnnTlsNi77tCQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784439; c=relaxed/simple;
	bh=s7L62xg5AhYSBPqLtZLS+/N9HboWD+nvR4XXTw7AV18=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Rbh4BF0x2qroDJfF22hMfT8ZAX/nARV0C98ycSzxSYLNnef/VQt+9vDitE5UVdG22A4JZkSj7ofp05ov/KHn6sIksxeMUJT8ayyF+v3p7PlsYYSLISyqoajgWl8UlbIlJisS1XwfCC3tF0EWKspZPmG05LYfymbKg2Cgpp+kWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DR9hnALO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3A254326B;
	Fri,  9 May 2025 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746784429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j50PEjeqXZDrUMeEGIxCAVR6d8U98GtS3zwEHA1HFcA=;
	b=DR9hnALO9LwAG80j5ak+KWuJL/BSYM/nVDB7jUqtHVPXRlg6wf3SP1iiMpagJlg7ZwMiwm
	4s3x8MdeuW4bGnbEZAiLxBn4EvsYd3ITVtxj9OtCsOs60J2YVadl7PAn+kQ4cPHcEI3XAF
	Ax/8N6v4zRq3Ub+GnhLkab5eiDtlw6N+4jiO5bBmhlXYDhTO+xS4DHlkkmEk+2aecekCa6
	YsOG/YhhJp5kzHX8F0H5bpK1B21//3xGJy/Hklngy50/m1uFaGYfNNRKpTYAZPm6K2LyjB
	+ynrBQNg0fgPwUe6qaNjkQGeVGQMbbjXAdIkX8dsd5AUjQo8QuGTCOBSA7B1OQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 May 2025 11:53:47 +0200
Message-Id: <D9RJEFYN039A.UGCG0K6AAPLH@bootlin.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>
Subject: Re: [PATCH v8 02/11] mfd: Add max7360 support
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
 <69f72478-7102-4cfd-98d7-a93dcfe5a1a0@wanadoo.fr>
In-Reply-To: <69f72478-7102-4cfd-98d7-a93dcfe5a1a0@wanadoo.fr>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegthhhrihhsthhophhhvgdrjhgrihhllhgvthesfigrnhgrughoohdrfhhrpdhrtghpthhtoheplhgvvgeskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 9, 2025 at 11:29 AM CEST, Christophe JAILLET wrote:
> Le 09/05/2025 =C3=A0 11:14, mathieu.dubois-briand@bootlin.com a =C3=A9cri=
t=C2=A0:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>=20
>> Add core driver to support MAX7360 i2c chip, multi function device
>> with keypad, GPIO, PWM, GPO and rotary encoder submodules.
>>=20
>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.co=
m>
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>
> Hi,
>
> ...
>
>> +static int max7360_mask_irqs(struct regmap *regmap)
>> +{
>> +	struct device *dev =3D regmap_get_device(regmap);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	/*
>> +	 * GPIO/PWM interrupts are not masked on reset: as the MAX7360 "INTI"
>> +	 * interrupt line is shared between GPIOs and rotary encoder, this cou=
ld
>> +	 * result in repeated spurious interrupts on the rotary encoder driver
>> +	 * if the GPIO driver is not loaded. Mask them now to avoid this
>> +	 * situation.
>> +	 */
>> +	for (unsigned int i =3D 0; i < MAX7360_PORT_PWM_COUNT; i++) {
>> +		ret =3D regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
>> +					MAX7360_PORT_CFG_INTERRUPT_MASK,
>> +					MAX7360_PORT_CFG_INTERRUPT_MASK);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Failed to write MAX7360 port configuration");
>
> Nitpick: Missing \n
>
>> +	}
>> +
>> +	/* Read GPIO in register, to ACK any pending IRQ. */
>> +	ret =3D regmap_read(regmap, MAX7360_REG_GPIOIN, &val);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to read GPIO values: %d\n", re=
t);
>
> Nitpick: ret is not needed in the error message.
>
>> +
>> +	return 0;
>> +}
>
> ...
>
> CJ

Hi Christophe,

Thanks, I'm fixing the two messages.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


