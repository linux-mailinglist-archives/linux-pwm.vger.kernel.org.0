Return-Path: <linux-pwm+bounces-4458-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EED9FB0C9
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294CE1642B3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FD19D074;
	Mon, 23 Dec 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ga2/ZtHa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CC182BC;
	Mon, 23 Dec 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968309; cv=none; b=nuDgwnrII8drADWoSxJsMDHmiHGsgjZxwthMyG6Hz6YUHJksgodzcZ6BJtWtx8nGsOl0Hxp6lvDSgMaC1sB9rusK9rQxQxY+R7Fy1Caz3DQYiWERLDmKmPhqW9+pBxq78wPqXzeS9BxzZ1exYXyBRNeW7r36vn81NdQLkWJE60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968309; c=relaxed/simple;
	bh=uaLfURuzOkNBSfj5sUx00RxSLYZQgFLEtJ9+LCytNUo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=g4U4GNHbvPB3zRnTFB3XOhoDLJB32Mwppvl7xYGStn4Ef/qI6Hiwmx8chCCPQV313qgM5gRjltEdJY6GafYke8CXnN9/sEtUwe7oAJlbUYNN7beS4sxkl3KPB9u3sK/IE3a8zLEnuUmaY6o8l/5mupzr/+O04jfQlOTfbkjpeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ga2/ZtHa; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6E8B40006;
	Mon, 23 Dec 2024 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734968299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F85i2gcGXFN1XWOpKvV1lhIuzHTAUwRGExUYtZfnlcw=;
	b=Ga2/ZtHaei3hfTKqwBf+TwmjhFXHrmtfZ9ktV/fwLzFKHvO778Gvy+kSN2r5ING5N+lXGb
	0IolShWGQAlqOcD2Ok+j0AropBFl9ietgCV84zlzK7qQnO79Vgcwt7OGew6O5ELgphvDwq
	TUrgLZ1uQ1gm+kvKxROpW4m+zBvILs5q91kihKV4WzbYArq1WxBvid+SWVqQeEl6ELYB5h
	hhtQfXxu3Uvaf7JVY976jYgpxuMjAni3DkMuGAWchUe/lM6tcHbeY8EVyBVUTVFlxNkvbl
	tsurSVHHCoWwpmzs2ZHTwdKpE7g89+eFU7c9cUmAiZDfziPtDbHsd7/IPd9T6g==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Dec 2024 16:38:18 +0100
Message-Id: <D6J6XL605TZW.32SZT5CC3P1IH@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/8] input: keyboard: Add support for MAX7360 keypad
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-6-8e8317584121@bootlin.com>
 <Z2R1ju7pNd-BBLJ4@google.com>
In-Reply-To: <Z2R1ju7pNd-BBLJ4@google.com>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Dec 19, 2024 at 8:35 PM CET, Dmitry Torokhov wrote:
> Hi Mathieu,
>
> On Thu, Dec 19, 2024 at 05:21:23PM +0100, Mathieu Dubois-Briand wrote:
> > +
> > +	input_set_capability(input, EV_MSC, MSC_SCAN);
> > +	if (!max7360_keypad->no_autorepeat)
> > +		__set_bit(EV_REP, input->evbit);
> > +
> > +	input_set_drvdata(input, max7360_keypad);
> > +
> > +	flags =3D IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
>
> Shared? Why? And why do you need a temp variable?
>

Ok, this is probably wrong.

I have a board using the MAX7360, were both interrupt lines of the
chipset (INTI, interrupt for GPIO and rotary encoder and INTK, interrupt
for the keypad) have been both wired to the same pin on the CPU side. So
on this board, the interrupt line is indeed shared between the three
corresponding drivers.

Yet this is probably very specific to my board, as I have seen no data
about MAXIM suggesting this design. So having IRQF_SHARED is probably
more a hack than a valid implementation. I will drop it in my next
series.

>
> Thanks.

Thanks a lot for you review, I am preparing a new version of this series
that should address all your comments.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


