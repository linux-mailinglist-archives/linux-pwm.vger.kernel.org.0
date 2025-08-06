Return-Path: <linux-pwm+bounces-6973-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9CB1C7B6
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59367622A09
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAE28D8EE;
	Wed,  6 Aug 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KY9Y+E59"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D41823DD;
	Wed,  6 Aug 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490998; cv=none; b=MNDvcLC5e0F/9hjOd3PGlNdfNMq8Hr4pR1G2nsw7u+dyLowsC1BsLO4WmujnxrGSlw9PnQ1oER+ofwqgzGfxO1U8i0AWgjhV4qln7sgtN1VCtFvs0K7Q6kz8zQK3EHfyLL8Lahra6tsUyS92pxCoF7uTeTH/GNKJOQwvci8Zclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490998; c=relaxed/simple;
	bh=3vnFjNfdaPh9SkFU3xP/Tt9Wl47FarfEWi3jrckk/M0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=pDA/lL22ol9sgMpgd/u3r57mktipVA186dKnbaIHFllF1tGlF/M84tka3/YdYCCJ2hWFdG9UPjxccdLZvTaJdNglmI8rMnGvmPh2BfzUcdt3npwBu9/xeVVUwxaQWiMSn0DNo5lnE2KcXAlnIIyidSrF3sUhvC/r8rvzKX/yQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KY9Y+E59; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9683438ED;
	Wed,  6 Aug 2025 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754490994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTJr4tzpqtVoTjg53YR9Pm/8memoRI7DH2lY0xra0mI=;
	b=KY9Y+E59AUQWeNFvBIpOIf7XAa1Bh8a0TQRAnd6eEEo4LNTOTd6g8n/G3ZOOa0Nwi3LnaT
	zIl3QZEocK4LNBQlJiuLSpuv6F06Zq9cQM9GjIkZ/LHiwE94EGJL22bWAilud3HlOuujnu
	Q9q9tSMlo42aQXmp6OJl3j9iapfgWM3QcloMvC/YEr2yjIXUd3d6K8DjweMkF7U67TsXW3
	vhxizfgJJ+FyF5GNnkUfVNJVZdf30ksz7St7wKj0yFRx/6yPuVH+HReS0SeWrQS2LJDanu
	4jblGZcX1JlBx2l1MYxE4d53DPqPG2KA0bDH/S/RDt89AV/ST/iAuE+v3nWk2A==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 16:36:32 +0200
Message-Id: <DBVF5EWK7WRF.3Q0CRECYQOER0@bootlin.com>
Subject: Re: [PATCH v12 04/10] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
 <20250722-mdb-max7360-support-v12-4-3747721a8d02@bootlin.com>
 <2msg7e7q42ocjewv35rytdtxwrfqrndpm2y5ustqeaeodencsd@nfdufgtevxte>
 <DBVBZ48R7DNR.850O5X7MLMEF@bootlin.com>
 <praujgmc3c63j6brecp5kwn7tbdd7rcxmrxn67kxhxcr7rpyhw@pfbsgycx4aop>
In-Reply-To: <praujgmc3c63j6brecp5kwn7tbdd7rcxmrxn67kxhxcr7rpyhw@pfbsgycx4aop>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Aug 6, 2025 at 4:02 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Aug 06, 2025 at 02:07:15PM +0200, Mathieu Dubois-Briand wrote:
>> > I think the right thing to do here is:
>> >
>> > 	if (wf->period_length_ns > MAX7360_PWM_PERIOD_NS)
>> > 		return 1;
>> > 	else
>> > 		return 0;
>>=20
>> I can definitely do that, but now I'm a bit confused by the meaning of
>> this return value: is it 0 on success, 1 if some rounding was made,
>> -errno on error? So I believe I should only return 0 if
>> wf->period_length_ns =3D=3D MAX7360_PWM_PERIOD_NS, no?
>>=20
>> Or reading this comment on pwm_round_waveform_might_sleep(), maybe we
>> only have to return 1 if some value is rounded UP. So I believe the test
>> should be (wf->period_length_ns < MAX7360_PWM_PERIOD_NS).
>
> Right,
>
> 	if (wf->period_length_ns < MAX7360_PWM_PERIOD_NS)
> 		return 1;
> 	else
> 		return 0;
>
> So 0 =3D request could be matched by only rounding down, 1 =3D request co=
uld
> be matched but rounding up was needed, negative value =3D error.
>

Ok, thanks for the explanation.

I will fix the return value, and a new version should come soon.

Best regards,
Mathieu


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


