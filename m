Return-Path: <linux-pwm+bounces-5937-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59DAB4E0A
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FA417618F
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3E42040B3;
	Tue, 13 May 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WxeALdY8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E6202C5A;
	Tue, 13 May 2025 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124751; cv=none; b=IZKQWnvanWmpnY7sDPgSg6VAQNddm6iNFKa1VAr80Qg3y9A2FVal14Fj/+bfRw+9rbKHmpSSg1mbyVi+uNM3YNGto8sCPOIsdnegXj2jFA33YhbQvg1TSGn5pwlgQxxU7w025lsp8Il+kL5YaGuSziOLupV/lWL0dqeoNGS4n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124751; c=relaxed/simple;
	bh=KmyKHA+amWKsGoGT7dggZMj1WfmDBtdepYE+juYv7zg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=jQ7Eupk5582TWqYWOEGsg8S2dJPrMS12Z4ujKhk3OurHSvMk2gCl3sADC8LUmp8h2R1YaiUkoMuWTlbCMqNGijsGJci2dtf4NkhrBX5rmr+wYo/pKuEnxupGJLvFU3+MdwWoaHOFEmqF6mAbaCH2FJRPRkkXRuyQI2nw0PP01is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WxeALdY8; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DD114341A;
	Tue, 13 May 2025 08:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747124741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaYT2F+5JVMz3q6yy4S7Oj1Azgj0lWFgsw5T0hxiTco=;
	b=WxeALdY8M10GpHf+0grO4hv46XBXpsMNoi2LtGiJI3QA0QA3r1ZeF3TmbCBgOx6RV+O+D7
	3OJUfy+gVkbjBnfVDpIcqhDov/JVGPEKs+O22kEj5/Ojk4/ePSeTyRscQU9qY3wLSw9hri
	kFGsLHN+0Sgd6bJ6ovUnA8vcXtIrTIhPUP0psPV/gNR3n4gYZFe8R9OMPbXwJwwKOqdTcX
	V8W4ZeImyBwdw5BZHxroSQz5qZche5A8tUEwmQcLuHzAPF6UGMW+y5WVA5+KMgbz4WfcU9
	yc8RuzAFCLhfjcjlDDodQ2GqXLEVxFQb1K8/J9PkSAR5off3+Wl7oS91jCWEGA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 10:25:38 +0200
Message-Id: <D9UW14SJQ9HV.3BA1FYKMG9DE0@bootlin.com>
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
Subject: Re: [PATCH v8 02/11] mfd: Add max7360 support
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
 <aCG9lyaCGchBsqLE@smile.fi.intel.com>
In-Reply-To: <aCG9lyaCGchBsqLE@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Mon May 12, 2025 at 11:21 AM CEST, Andy Shevchenko wrote:
> On Fri, May 09, 2025 at 11:14:36AM +0200, mathieu.dubois-briand@bootlin.c=
om wrote:
>
>> +#define MAX7360_REG_GPIO_LAST		0x5F
>
>> +#define MAX7360_FIFO_EMPTY		0x3f
>> +#define MAX7360_FIFO_OVERFLOW		0x7f
>
> Please, be consistent in style of the values.

Is your point about the alignment of the values? Most of these are
aligned on column 41, including the ones above. I just have an exception
with MAX7360_PORT_CFG_*, as they are a bit too long. But as we are using
tabs here, indentation appears a bit broken in the patch.

OK with all other points.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


