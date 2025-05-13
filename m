Return-Path: <linux-pwm+bounces-5946-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2EAB5396
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFEF8C136E
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9828CF45;
	Tue, 13 May 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S1hyStrD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1C1F1524;
	Tue, 13 May 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134867; cv=none; b=rLy8+waY/gE9sskRw6/fZ4CKKUG4xtQdKrDXsMz8AoZwHlPzf2kGPRffBjUYsrR8BkuQOq/0WUHypnv6En3Y/OfPDxESXtfBVTgxAzvQK1Mk1vsRfP3b+WiFcYSk4i9967tf6MOD4deVQJseeJSuC7G4gdUxrOOYU7c7ANFr1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134867; c=relaxed/simple;
	bh=PXJdoneHOMC99/uLU9ijBMdzBMKSPZ5UAMiFw3MgRyc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=VuyuREuCDK7kIVj90ykKIYMTPX9Xiyxdxs9DBGBXFxIUelWD9EwDXsUT4GvsJ7I0lJH/Q+Y7NNetARqe4kP6rAyQThI0dUkGfTta+jj01xZ2jMrdVnnMyJ8e6Rdg9ve7kFPC1OqZPGB8YiNaFgk81cu1zsm/sxVLrVRftTbws5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S1hyStrD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E6AB4329D;
	Tue, 13 May 2025 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747134856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKTxS/Fgg/f7k8WlIimNhYf5mVWwyERbEyvE9wVS1HY=;
	b=S1hyStrD27CAh44pTlyze9cf2t9bOIXFc3lhaVrzuJZAsNEGxNhYEdwkHIFfXlQlb9R0Jr
	c9d8sH56RSm4PX/E6Bmqu+Y8iLrFpiNMHilR1FxCZZPNJc6ztREVTzW1OfijJYWkUQ9M1H
	O3zYF87Obs/QWFC6vsrSIV9rUW2TVi5ZnIWj2afOO+zlBWd8jn4YzAuWJpq3O5aS+9f1Cy
	nw+opP05ili8zmQIXZEELg8f0KpQ505J9+RJGZv7fgsyooFtcIS8ONKfxaXVuj+jJbs7M6
	PoxTPf7l8OKsR/0ix/WdvHsegu8OISv0un1rCKpHIn/+DVrJzORHHiM5ZyWG9g==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 13:14:14 +0200
Message-Id: <D9UZM817JKQM.2CPWNUC1H2AJW@bootlin.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>,
 "Linus Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski"
 <brgl@bgdev.pl>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
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
To: "Lee Jones" <lee@kernel.org>
Subject: Re: [PATCH v8 02/11] mfd: Add max7360 support
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
 <aCG9lyaCGchBsqLE@smile.fi.intel.com>
 <D9UW14SJQ9HV.3BA1FYKMG9DE0@bootlin.com>
 <20250513093107.GC2936510@google.com>
In-Reply-To: <20250513093107.GC2936510@google.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlr
 dgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue May 13, 2025 at 11:31 AM CEST, Lee Jones wrote:
> On Tue, 13 May 2025, Mathieu Dubois-Briand wrote:
>
>> On Mon May 12, 2025 at 11:21 AM CEST, Andy Shevchenko wrote:
>> > On Fri, May 09, 2025 at 11:14:36AM +0200, mathieu.dubois-briand@bootli=
n.com wrote:
>> >
>> >> +#define MAX7360_REG_GPIO_LAST		0x5F
>> >
>> >> +#define MAX7360_FIFO_EMPTY		0x3f
>> >> +#define MAX7360_FIFO_OVERFLOW		0x7f
>> >
>> > Please, be consistent in style of the values.
>>=20
>> Is your point about the alignment of the values? Most of these are
>> aligned on column 41, including the ones above. I just have an exception
>> with MAX7360_PORT_CFG_*, as they are a bit too long. But as we are using
>> tabs here, indentation appears a bit broken in the patch.
>
> I believe the point was in reference to capitalisation.

Oh! Makes sense, I didn't saw that.

Thanks!

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


