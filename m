Return-Path: <linux-pwm+bounces-4914-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C46A362A7
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B0F7A3B40
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EFD267396;
	Fri, 14 Feb 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oSmZ2275"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883D265CA1;
	Fri, 14 Feb 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549131; cv=none; b=u6OYsMEi/wiUwENV435Il6+QWP7rNFllbpy/Y7pwt+m8GCzCssxeLD1PDXYY/xFV7hTCG/j2e9y8zB829QZlyn+hUGh+QEnNmJAsqzLM7trRKxPvWTmJgAo3K/jP28WwKj2sDBfb+eBokvw4KvyQJ/xfry3g+GXmgOlzo/wnNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549131; c=relaxed/simple;
	bh=VEueH0DTAy/DA9dtTIPVe2CjrgE7xPdHN42it+9zNRI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=pCEISVlcfcI+RkIUhOIuioO0UuiQpMccJRKkBpwN1AmRabLAIYHFZg79jrLBfiPj8my9Dp3tT01fTQ+0USykKoyOw4N0A2rto7ySRHCTohl5p2hmecGWNVduueYL6SoXRAUncxKCi21wE8agwlPUGNqwhyUxIhuZZTyPqag069Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oSmZ2275; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B785344291;
	Fri, 14 Feb 2025 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739549121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y95BakCeN1FmQ85wwWtUikXXPtdWCe0MAjwsSsXZAT0=;
	b=oSmZ2275hXo8TQYnU2SHwakddlYlsw+UW07g/ujOFwRrrBaV/dhPM+v/W/8cdTFfhvYFR5
	ZozDlnnlHJAbspct9wBKKL3Q8taK1fTSFDiZPjQcdrKQj73XLOiNtOCAZ4x9No2z6sG1q7
	88KEzLUb0j4a71112gf4N6k3JkpMoNDXPk2ZYLbsdYHREmpKHB8wrPZxmdhf/NseYh9OJu
	tr2hCscYQ7lxVymykmH8Cldl3g8EnFnV6uGkeIBeC0RaIrQvcVgfUISReTDTjewyHGtcCS
	u+uL8Dhk4vZoBANe+0FvwgjKjO7/0/BACQQLHs+PYMZq3H1JpqBrcl/60gzh+A==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 17:05:19 +0100
Message-Id: <D7SAP5524DX0.3BQ74ZCQ62S7D@bootlin.com>
Subject: Re: [PATCH v4 03/10] pwm: max7360: Add MAX7360 PWM support
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
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-3-8a35c6dbb966@bootlin.com>
 <Z69c1BQHmlbmwUYf@smile.fi.intel.com>
In-Reply-To: <Z69c1BQHmlbmwUYf@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Feb 14, 2025 at 4:10 PM CET, Andy Shevchenko wrote:
> On Fri, Feb 14, 2025 at 12:49:53PM +0100, mathieu.dubois-briand@bootlin.c=
om wrote:
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >=20
> > Add driver for Maxim Integrated MAX7360 PWM controller, supporting up t=
o
> > 8 independent PWM outputs.
>
> ...
>
> > +#include <linux/of.h>
>
> Is this used? Cargo cult?
>

Right, not used anymore.

>
> > +struct max7360_pwm {
>
> > +	struct device *parent;
>
> Is it not the same as you can derive from regmap?
>

It is. I'm removing it.

Also, max7360_pwm structure will only contain the regmap, so I will
remove the structure and set the regmap directly as the pwm chip driver
data.

> ...
>

I have fixed all other points. Thanks for your review!


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


