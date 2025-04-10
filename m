Return-Path: <linux-pwm+bounces-5436-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB1CA83CAA
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142F64C0D2C
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 08:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7954520C496;
	Thu, 10 Apr 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NIXQOVlI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177891E5B84;
	Thu, 10 Apr 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273186; cv=none; b=Hrw1vrp5HQKJHpcqUUWuEVPOJMdfCDKMOi13FOuRhgNEfg4fLBklbtAmcS1BMUCUuvxQhXIEh5BZkAFTw/qKNciQdXymj9Zv4a6q0z9+kJfHmsLNSzt6njg7qAwwVtbN+KJGppligi2p2FLE+MfIXFPixptGRSYU0+F8KHO2KMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273186; c=relaxed/simple;
	bh=JH0ysD7QlUmh3YZt2NcU9owTunnHQH6W/wNghS58NQI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=TwvqH5k0WxOJyrTf334vRYkKKI04Sb2ZVYJLraTUeN8KXKm1P7lkuLZc9dt001t0bDyzb8vJGhsn2+EZZSYpNr4fJ04IGF1yICRA1o0Tpt/zDbkzJwhalmD6BhqouwsnOmCnvorCO3VwzkFKqGhwrLxRdCzf97dZoRIl4Q/2cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NIXQOVlI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D63034327A;
	Thu, 10 Apr 2025 08:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744273181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Y5h+5OSRWIwQZiitm22COKTZGTsAm6UEQXwd9f9Grk=;
	b=NIXQOVlIrym6KHvZ8zKy+qyJJYRaB6rzZvV1l2dctN9BM7O9xMfH4KCGwQoUewtNavGD9l
	UBub7ZB9EJXHeHkffmFMFZpKwduUBxFGmEmMbN9qUQzSzkj4n7OzJerLwlfXCb1+tkw32Y
	Aa6lBxB574wk2kfDRXLmAgKci/NcV4jEznQXBH7Dex4YJQUHCYxjHgCvOqSrnOM4Fy9mGX
	9I1/jses8ZD8ieH1QsKASBBG8m9TpkWw1LG0Ew2teQhH+cufhYIvyoMCuB2uFVFVVO01m0
	LI6UNdBkzBHpDr7SqGszCBdIQ/Q4nVcla9E9kqu/AoSxP0nqVg7P3Uk1l6ZnNw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 10:19:39 +0200
Message-Id: <D92T8KH7F8Q1.3MYEC6SZEEGNB@bootlin.com>
To: "ALOK TIWARI" <alok.a.tiwari@oracle.com>, "Lee Jones" <lee@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>
Subject: Re: [External] : [PATCH v6 01/12] dt-bindings: mfd: gpio: Add
 MAX7360
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
 <a9d8ca30-3836-49b3-898c-c351b2c44a76@oracle.com>
In-Reply-To: <a9d8ca30-3836-49b3-898c-c351b2c44a76@oracle.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvffuvefhofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvffdugeeiudevjedtteettefftefhvdeileekhffgleeiteeufeejvedvledtffenucffohhmrghinhepuhhrlhguvghfvghnshgvrdgtohhmpdguvghvihgtvghtrhgvvgdrohhrghdprghnrghlohhgrdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheprghlohhkr
 dgrrdhtihifrghrihesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 5:22 PM CEST, ALOK TIWARI wrote:
>
>
> On 09-04-2025 20:25, Mathieu Dubois-Briand wrote:
>> Add device tree bindings for Maxim Integrated MAX7360 device with
>> support for keypad, rotary, gpios and pwm functionalities.
>>=20
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>>   .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++++++
>>   .../devicetree/bindings/mfd/maxim,max7360.yaml     | 171 +++++++++++++=
++++++++
>>   2 files changed, 254 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.y=
aml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
>> new file mode 100644
>> index 000000000000..21d603d9504c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/gpio/max=
im,max7360-gpio.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp2=
4O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvakCad_v0$
>> +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas=
/core.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujl=
nN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvacsB3d9k$
>> +
>> +title: Maxim MAX7360 GPIO controller
>> +
>> +maintainers:
>> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
>> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> +
>> +description: |
>> +  Maxim MAX7360 GPIO controller, in MAX7360 chipset
>> +  https://urldefense.com/v3/__https://www.analog.com/en/products/max736=
0.html__;!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-=
xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvavZnHZJk$
>> +
>> +  The device provide two series of GPIOs, referred here as GPIOs and GP=
Os.
> typo: The device provides two series of GPIOs,
>> +
>> +  PORT0 to PORT7 pins can be used as GPIOs, with support for interrupts=
 and
>> +  constant-current mode. These pins will also be used by the torary enc=
oder and
> typo: ie rotary encoder ?
>> +  PWM functionalities.
>> +
>> +  COL2 to COL7 pins can be used as GPOs, there is no input capability. =
COL pins
>> +  will be partitionned, with the first pins being affected to the keypa=
d
>> +  functionality and the last ones as GPOs.
>> +
> typo: partitionned -> partitioned

Thanks for your review, I fixed all 3 typos.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


