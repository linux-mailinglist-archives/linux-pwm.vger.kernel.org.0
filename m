Return-Path: <linux-pwm+bounces-5819-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA926AA9254
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65377176138
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5B205AB9;
	Mon,  5 May 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jr7cWSqc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C02040A8;
	Mon,  5 May 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445963; cv=none; b=eB0/0ESVCTLDa0g03abKNeDJB/O13QPngGHaUpjXy61WhmeH76trDuQ0e6IXRaMg7CjRuv4Z4dBtjq4JZT9eqaSA78jwJN5O0sK9rHQLoIv+0q+1qyohcxXchHx66TIMxlwv7b4hnz4gjQoJZzHKQpNB1HYl14ja3TavO44qGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445963; c=relaxed/simple;
	bh=4kaZEUxGVTYwxOZIR6two8Odt1oN1JQHgkymxLgLVS8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=uiJjuz/RRu/4bIptTn5ySSCCtfqPh/2NNNH8b/nRpfkQQ2FYjnMCyxpfoRY1IetAvZsXNhMpnZx/pY71dWu9/duCGJtuLbRKx3au5Q2CNdSMjQmUiKNSeowrUP4VZ/vAsKJUmgHhR14XUMAzhKE2ujyd4l6C6GRiGBGVvnTd0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jr7cWSqc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F111432A2;
	Mon,  5 May 2025 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746445952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm8qmex3bAGRILrPZHXrirOvCQozzFYhA+oyW1nX2/A=;
	b=Jr7cWSqcIA1lpycR6i5nolFqFjVEdLgYXoW24zAYltxtUHfKBqnhE0pHou0wG9DxIvkI8z
	zFDQb6X1TEw32V5IEJX8uJCQG6mFBBZgkqkNbR9hmPQbK34Mw0vDp7L8Xa2Ppo03LRTv7/
	musII7g5mPco3A3vzxZBs0XnvdogiQed15QcxXnB3DsA1YmjKarmdiZgavq1ietgMfKMvD
	3Jd0n9feQ6jfJ/jPsCZwxt4ameL6rD6bVz9g0Rd6GWLnZKfbEXPHcnSVVP8BH4beHbIxPH
	2H+smQfh5OoSA2XEwdE3j6Z2KTM5sgnHcmZZHzOxrRmaXZV7Zzefu0nwAg/TFw==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 13:52:30 +0200
Message-Id: <D9O7F5Q6F1PS.2Q7R864GRUHZQ@bootlin.com>
Subject: Re: [PATCH v7 10/11] input: misc: Add support for MAX7360 rotary
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
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-10-4e0608d0a7ff@bootlin.com>
 <aBSkCsw3GJ6RHeJV@smile.fi.intel.com>
 <D9LQ7NV1LJM9.F2GF0YEEDFEY@bootlin.com>
 <aBTSNsCupbpAscwA@smile.fi.intel.com>
In-Reply-To: <aBTSNsCupbpAscwA@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkufevhffvggfgofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhtdeuhfehtdekueeltdejffdtuefgueffhfeiueegleffueevvefgtedtkeegjeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 2, 2025 at 4:09 PM CEST, Andy Shevchenko wrote:
> On Fri, May 02, 2025 at 03:58:04PM +0200, Mathieu Dubois-Briand wrote:
>> On Fri May 2, 2025 at 12:52 PM CEST, Andy Shevchenko wrote:
>> > On Mon, Apr 28, 2025 at 01:57:28PM +0200, Mathieu Dubois-Briand wrote:
>
> ...
>
>> >> +				pos =3D max(0, (int)pos + steps);
>> >
>> > Please, no castings for min()/max()/clamp(). It diminishes the use of =
those
>> > macros.
>>=20
>> Sorry, I'm not sure to get the point. Should I use MIN_T() instead?
>
> Are the second argument is compile-time constant? I don't think so. Hence=
 no
> use for MIN*()/MAX*(). First of all, try to answer to the Q: Why is the e=
xplicit
> casting being used? The second Q: How can it be easily fixed without usin=
g _t()
> variants of the macros?

Err right, no MIN/MAX of course.

Explicit cast is here because the unsigned int + int sum would result in
an unsigned int.

I will use an intermediate signed value. Also the whole logic here can
be simplified a bit, so I will rework the whole block.

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


