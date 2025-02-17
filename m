Return-Path: <linux-pwm+bounces-4936-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFAA382CF
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2B0188B3AC
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9C219A81;
	Mon, 17 Feb 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gnQfqixc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9E16C850;
	Mon, 17 Feb 2025 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794772; cv=none; b=r0/u6Fzxvx+8VvVNPKU54skia9YTvbZC6S7x5OyHvTVjrEWphxzCzKbHb5WkPZ0H7huc6Qhs8sYzxT9Bcbvtzx9mudi4UES53/J1nlOvs165JbTyymf+AQ1G/aIYJgtMRGhIdFMHp/O9GXPrHR6TAws84BPOo6r/O5zZFuVSu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794772; c=relaxed/simple;
	bh=9kgC/V3qNkmeNamkYMHdidfNovuDvLGnvK/bhGmeUsE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=eaBVt1XJ0ZERkZY21LeuoPcF4VvdtAlWYDX9MO55DksgCkAgFdIWzTXhjXbUxMpS58V0yFAixVKdRzO73S5UiJSjiJShFMYsYb5rP8mIVINJ27ETb3oYgjVPGHiZrwW03LrjQ9GQ87jcZNWaxt5AZk3VoVPx0w5iSezUBPlHh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gnQfqixc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73786443DE;
	Mon, 17 Feb 2025 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739794762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUryUHsSyNveCM8ra3eNAsj4HLJFnzA9/YVXKHA+TZA=;
	b=gnQfqixcQkY+shV5lUNMH6t6Zxf8MFytJsH2aF+as31qt7dlRjeQ4KfHt+iaagb/6+Xmx9
	iIQpzny1DLfxc0eRKDM48JkP9tdsAgpU+YOr8YCLUvVcyh2Sy8tuMnULiQsSUHPQpEMZPy
	GozCbrh+Pl+w33v0SX5eUSchob5owlIAs3F06UAoyHgfTNFEetF1O/Lrn1YYmQ3O3cQfOL
	3k0QjMNr6wApZL4fS3pu88DtO+L68GdgKR6W/GHGGvaP2K+p4l6bdLr6/BJBvizmwg9F26
	6I3dY6mBDPPiuxIZv4/R0IpGnvjSsrot2Wb3nsOIfMTeS83cpqaDsnPwTa4/dw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Feb 2025 13:19:19 +0100
Message-Id: <D7UPRQW1B51Y.1GI2GOM7XBJOA@bootlin.com>
Subject: Re: [PATCH v4 04/10] gpio: regmap: Allow to provide request and
 free callbacks
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Sander Vanheule" <sander@svanheule.net>, "Lee Jones" <lee@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-4-8a35c6dbb966@bootlin.com>
 <e6194c5ed4f305f2150ab89a91a998028ac687c0.camel@svanheule.net>
In-Reply-To: <e6194c5ed4f305f2150ab89a91a998028ac687c0.camel@svanheule.net>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtohepshgrnhguvghrsehsvhgrnhhhvghulhgvrdhnvghtpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Sun Feb 16, 2025 at 2:17 PM CET, Sander Vanheule wrote:
> Hi Mathieu,
>
> On Fri, 2025-02-14 at 12:49 +0100, Mathieu Dubois-Briand wrote:
> > Allows to populate the gpio_regmap_config structure with request() and
> > free() callbacks to set on the final gpio_chip structure.
> >=20
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
> > =C2=A0drivers/gpio/gpio-regmap.c=C2=A0 | 2 ++
> > =C2=A0include/linux/gpio/regmap.h | 7 +++++++
> > =C2=A02 files changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> > index 05f8781b5204..ba72c23bcf97 100644
> > --- a/drivers/gpio/gpio-regmap.c
> > +++ b/drivers/gpio/gpio-regmap.c
> > @@ -261,6 +261,8 @@ struct gpio_regmap *gpio_regmap_register(const stru=
ct
> > gpio_regmap_config *config
> > =C2=A0	chip->names =3D config->names;
> > =C2=A0	chip->label =3D config->label ?: dev_name(config->parent);
> > =C2=A0	chip->can_sleep =3D regmap_might_sleep(config->regmap);
> > +	chip->request =3D config->request;
> > +	chip->free =3D config->free;
> > =C2=A0
> > =C2=A0	chip->request =3D gpiochip_generic_request;
> > =C2=A0	chip->free =3D gpiochip_generic_free;
>
> You probably have a bad rebase here, as the chip->{request,free} function=
s are immediately
> overwritten by gpiochip_generic_{request,free}. Perhaps those can actuall=
y be used if you
> provide a pinctrl driver for the MFD.
>

Thanks, indeed I missed this rebase issue. It's fixed now.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


