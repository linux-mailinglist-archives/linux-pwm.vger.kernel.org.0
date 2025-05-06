Return-Path: <linux-pwm+bounces-5837-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ACCAAC464
	for <lists+linux-pwm@lfdr.de>; Tue,  6 May 2025 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A133B3A8ABC
	for <lists+linux-pwm@lfdr.de>; Tue,  6 May 2025 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B927F198;
	Tue,  6 May 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QKSOfD4B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669D27A478;
	Tue,  6 May 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535270; cv=none; b=qVDacWzz2gCOFNLSoyM4ruEDw24kAySX4pJCm7SmkrNVdeQqvxNh66KGVA5IibmOxBbnBMzR7sttGQpJNAuD/vz7lp0BCmG3SnG19HshXkzBgllMLiPBBuaZFMkMq7167L3SY6e2fxlGe04oyLc79oWlFd9N2j1SfxSFvLgBwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535270; c=relaxed/simple;
	bh=fKAjeUu7aJ2cAoUuZNbRM4pTCnVbVDOkQZPM/+G+pdE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=XluRxXYjiGJmxKmFQCpM4vgtWyqK/Qo8N+KqH972pH85zthIco1zv+BUjAssbgw8O95JJKpA6UNFtatUc5vq0ETZqOBIsokq09VZBRhKhsATiR8QjaXWpvhos+tzy5HRgxAbgS188VorUmHU7JKoApUMHMr4gPiaBae7LBZdA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QKSOfD4B; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD73B43B04;
	Tue,  6 May 2025 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746535264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sqKVcBEt6pQmMwRIYYIzEuUV/01lrMK0Zw8BI9CN/k=;
	b=QKSOfD4BfheMezgztCkjPf4/2L/rXlXNBI6VznfgOptD6RjikLqYOqRBLdlu4UdwlUw+uA
	YQWgQh5Mb8hGO8Qlod4DrEOyTSzUmPPk7YATMA7PvL/Yg9n/RCE01u/1vCdFqx4Yhx3VHl
	8PLnIt645r6+EF3G2mGcERTp89/Mq0vKccIh09vNzcC12JQTNKh1fN4ZgXTUvMdqYfqS8n
	+ILvwpmYyLZxipsa8SADLUYEPNZBqBZa6gaIRLBCik/BSZjvfxvvaeGA91PFBUIDsKoyRi
	d/7uHyDA76WT2xZ524HjSpFIDI1uTldbpg2zGODJ03l3qv3Pu1lWtA3D61Q0Rw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 May 2025 14:41:03 +0200
Message-Id: <D9P32VIGJX5V.1VV0F5MZ17QDW@bootlin.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 09/11] input: keyboard: Add support for MAX7360
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
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-9-4e0608d0a7ff@bootlin.com>
 <aBSii0rHox72GM5Y@smile.fi.intel.com>
 <aggrss4doko5scdlmyzdsujkifryzuzqdnpkh6sd33rg5ibqmm@aiikzv732rkq>
In-Reply-To: <aggrss4doko5scdlmyzdsujkifryzuzqdnpkh6sd33rg5ibqmm@aiikzv732rkq>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvffuvefhofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeethfeiheehheegheekueeigfekffdvheegfeeivefgkeeftdehhfdthfehueejfeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgth
 hgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue May 6, 2025 at 7:14 AM CEST, Dmitry Torokhov wrote:
> On Fri, May 02, 2025 at 01:46:35PM +0300, Andy Shevchenko wrote:
>> On Mon, Apr 28, 2025 at 01:57:27PM +0200, Mathieu Dubois-Briand wrote:
>> > +	error =3D matrix_keypad_build_keymap(&keymap_data, NULL,
>> > +					   max7360_keypad->rows, max7360_keypad->cols,
>> > +					   max7360_keypad->keycodes, max7360_keypad->input);
>> > +
>> > +	return error;
>>=20
>> 	return matrix_...(...);
>
> Because that function has multiple failure points please
>
> 	if (error)
> 		return error; // or return dev_err_probe()
>
> 	return 0;
>
> Thanks.


Noted, I will change this.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


