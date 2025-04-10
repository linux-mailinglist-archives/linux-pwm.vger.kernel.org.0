Return-Path: <linux-pwm+bounces-5437-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDAA83CD4
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57807B56C0
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA520AF88;
	Thu, 10 Apr 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KXHzFxW5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F31EBA03;
	Thu, 10 Apr 2025 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273369; cv=none; b=u83lKdk83wHR0qjWbPdepVlxF1CMwua5a+KDUT/qcp9TaixQHS0/ykLXSNIJN5KdCPRBvFV6qMojsJLe/nKvXebgCDxns8qM/IvG/em7B9rCT1FsPttLTUOFmxUTeVFe89OYeBOtpoam3Z4BmZmFpA8ItpB6GxEl+j9EiQ0iVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273369; c=relaxed/simple;
	bh=J2Xwb0BAaI+5Ws9mo7EriiJABVLHC5+GCzzr03j5I70=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=IVa3j1UhbW8Vwkmonyv2zxDVLq4I8351HXi3qMvXbQZnjjGISxiMEkaAuVEPKuqXMSzUH5wxeRMdjyeqO758loUyz9gnRzDmqTG5AXo125UZYWCRfGnzW9NL01RXtql64Kiu9zDceaOStWkRukhO1JgMub8bcEJ8VIgXkK8qkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KXHzFxW5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14CF643158;
	Thu, 10 Apr 2025 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744273364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue/3HBgf+//oq0TTM6uv2vmPqBX5UWYBBw5+A+yFldY=;
	b=KXHzFxW5lkXV6FcZBimiz9eUYQUWZ33xPZFFtIa/93VDIcBP1fl/D4DZzt8juXE1ZcvNeQ
	KUuCPbZxJTgsFVjuyJ4Rwg15o8YAG7zfIBpPQUEQkdto2CnjNVgcocWhxiHyW4mjrsPphf
	rQAAWR+YNOwXAUM7IpgbYJP1Ph0cGMYchSAkb4j/Vu5/VLioVWgGwC50FbZ9Bci+TOWJ5s
	EHl/2UF3kAe/ph/ekMxEqQbQu3MnJpQbkyfsj0z9v4rNPj57i8/n8Xb935DbXHOSjB67wg
	TEafQNJ2hBQTWuixtEyeMFlJF3OhuuenlVSRMRsZ3NgZ3YOYj8ffSux+CGHbtQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 10:22:42 +0200
Message-Id: <D92TAWMKKM8Z.7E4MKWHTXVMS@bootlin.com>
Subject: Re: [PATCH v6 01/12] dt-bindings: mfd: gpio: Add MAX7360
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
 <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
 <triuq2rqofk4psfauemu6uikizvphnqg7om5x4b6sjc3tjg2a4@5fvv5l4kollo>
In-Reply-To: <triuq2rqofk4psfauemu6uikizvphnqg7om5x4b6sjc3tjg2a4@5fvv5l4kollo>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhefhhfelhfekjeeugedtudelueetffejfffhkeeivedvveelgfetfeelveetvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehlv
 ggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 10:58 PM CEST, Dmitry Torokhov wrote:
> Hi Mathieu,

Hi Dmitry,

>
> On Wed, Apr 09, 2025 at 04:55:48PM +0200, Mathieu Dubois-Briand wrote:
>> Add device tree bindings for Maxim Integrated MAX7360 device with
>> support for keypad, rotary, gpios and pwm functionalities.
>>=20
>> +
>> +    i2c {
>> +      #address-cells =3D <1>;
>> +      #size-cells =3D <0>;
>> +
>> +      io-expander@38 {
>> +        compatible =3D "maxim,max7360";
>> +        reg =3D <0x38>;
>> +
>> +        interrupt-parent =3D <&gpio1>;
>> +        interrupts =3D <23 IRQ_TYPE_LEVEL_LOW>,
>> +                     <24 IRQ_TYPE_LEVEL_LOW>;
>> +        interrupt-names =3D "inti", "intk";
>> +
>> +        keypad,num-rows =3D <8>;
>> +        keypad,num-columns =3D <4>;
>> +        linux,keymap =3D <
>> +          MATRIX_KEY(0x00, 0x00, KEY_F5)
>> +          MATRIX_KEY(0x01, 0x00, KEY_F4)
>> +          MATRIX_KEY(0x02, 0x01, KEY_F6)
>> +          >;
>> +        keypad-debounce-delay-ms =3D <10>;
>> +        autorepeat;
>> +
>> +        rotary-debounce-delay-ms =3D <2>;
>> +        linux,axis =3D <0>; /* REL_X */
>
> Probably this has been already discussed, but shouldn't keyboard and
> rotary encoder be represented as sub-nodes here, similar to how GPIO
> block is represented?
>
> Thanks.

Yes, this has been discussed on v1 and I was asked to remove most of the
subnodes.

https://lore.kernel.org/lkml/58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.or=
g/

Thanks for your review.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


