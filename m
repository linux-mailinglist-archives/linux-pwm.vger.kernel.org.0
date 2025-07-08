Return-Path: <linux-pwm+bounces-6767-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC88EAFC723
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 11:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99983162A8C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D3263F4E;
	Tue,  8 Jul 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OHchkSpV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6185258CF8;
	Tue,  8 Jul 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967153; cv=none; b=DjJqwsKqzmY4gjQ3V/ujZaS1RdXvt9OhkgUiG0U8x34KpzuEtBaF6xyKYwvKINW5m4aNA9TIvD6kntHtr4LseTcGp5jGF4E0BVdiAe3rnwrh2elDiLCb4hhzaWJR3QgRCHCNtP2rlJ+Qd4kOnLg6fKDwYFjXhYHZ1aPpPh+01u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967153; c=relaxed/simple;
	bh=1I60bl9wrWExT+hz6+BrPble5/gv0Q08kLXgIf9/HOI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=KJXsgAMlEFNacPjTXhnwWXGifJf7dmDwhsFOgLXsThShJf01RyYAmnxv3fc40Xc6kYog/2LD/oosEHgd2iRHpbfj3ilO2+nTFxDZm/ONJ/OELNMcOIBzzEM1gjoRbPiryIV8dP2f83jYurqt77pD7MV0/pJL2i+gUAver4JQ+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OHchkSpV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A01844341B;
	Tue,  8 Jul 2025 09:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751967148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiVIlldzdwfnJgeml3su1vpyy6HB/paT/1iGeKouukc=;
	b=OHchkSpVvQ3O+nsCElLAct4ZakwcZD7+J7cMwvGI8MSHsKPd7CIYBNtrOQZWWW6+4a2fj5
	Ususir7Hue/lO3QIM/VYqsFxbvWALMSofv4X3bR/Reyrg054HKwJ4Def0DxBSDxu+lc8n/
	mvx93y76lrQXQd5Sf6XlzGksgXpR0DRYjxDSCgkw3RuUo9DCXe3BBno+TN+d0ZzNE4xbC9
	Mfmhea47xNE3H/3DUmyIIyFggFM1UfMJL8v+Yid3LS4028KIl0/oDejRPVXFL12otk0D+t
	s2Mkr3NZq/TyaJvLL7R1eEQvQN24vkZ4OY7QaXoBVjigArl8nVys+ZPe1oWeLg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 11:32:27 +0200
Message-Id: <DB6KISI6134O.20T5XKNQ2SF8E@bootlin.com>
Subject: Re: [PATCH v10 09/11] input: keyboard: Add support for MAX7360
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
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-9-ce3b9e60a588@bootlin.com>
 <uibf7p6niiljlymzp24h2sk5dzhw5xschaqxj6wfpgge6b7hdo@czpfchjl7pvw>
In-Reply-To: <uibf7p6niiljlymzp24h2sk5dzhw5xschaqxj6wfpgge6b7hdo@czpfchjl7pvw>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrg
 hdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Jul 2, 2025 at 11:00 PM CEST, Dmitry Torokhov wrote:
> Hi Mathieu,
>
> On Fri, May 30, 2025 at 12:00:17PM +0200, Mathieu Dubois-Briand wrote:
>> +	if (!in_range(max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN,
>> +		      MAX7360_DEBOUNCE_MAX - MAX7360_DEBOUNCE_MIN)) {
>> +		dev_err(dev, "Invalid keypad-debounce-delay-ms: %u, should be between=
 %u and %u.\n",
>> +			max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN, MAX7360_DEBOUNCE_=
MAX);
>> +		return -EINVAL;
>
> Is it inclusive of MAX7360_DEBOUNCE_MAX or exclusive? Do we need + 1
> here?
>

Yes, I definitely forgot the +1 here.

> Anyway,
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Thanks.

Thanks for the review!


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


