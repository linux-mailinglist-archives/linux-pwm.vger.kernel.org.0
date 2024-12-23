Return-Path: <linux-pwm+bounces-4471-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D2E9FB3B5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A72418851FC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA91B87C6;
	Mon, 23 Dec 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="giAIkHKo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF138185935;
	Mon, 23 Dec 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976394; cv=none; b=Gry0RUCJdPFKShLDzRVc+noJ5uCzo1OUK2NSJpDfj9fv6bsaXJPfppnoJGdKFZTnkTXN4bESwCLpBtrmWWXvI0E5UmRnNChWVBFSTxw4olScz+eeMlGkrCMIlqjEcXAKj8SRVT60PEXpEY3HCBGPRUg1BWHVtJeTiCIquv3bIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976394; c=relaxed/simple;
	bh=9pt2mc+Hro4IIBg9xJYmH4WsQ2sUFDkjFv56f9JI1uk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=VvmTXqdXXpahhj+CqBPHcDRRigEcjwyAXrHWEsiX+pwUC70ujD+cHeh4Vnb79zZCdBiO9neQwo43o5pAXGgFBhIksyguZhYQVROVTDireGzc1Y9k0FD2QiDonEJXJmpgOzVl7kXedWG04iiq/QtSVXcRfcscVIGbWffEA8HZ5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=giAIkHKo; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41C8820003;
	Mon, 23 Dec 2024 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734976383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cjk9UW1eNK3gMr3FoXqpO4YXl9Ku7rP8HoF2YRA4Gwc=;
	b=giAIkHKoW/gX+auGN1N7k0FYAV2QOsFWbzIcBhjlq3F6QW35otMOAKSfBZSld4rNQ9SEmz
	8SQoVY0IG5XSxQ4I1YTPdNctu0BB/Tosy3O++ZAypbzBSuitSNhW5BY/D5Hpd9DnD4M6kl
	kmamYKd2hG71PxiiZiiRoxc8rC0XkPUArnYc12yS1E7AghwdUAUR4/0NNKNLSoWrJUSS4E
	Sz+Z+RTj7zjYoLieK2lGiGQ6gTlWiYqtY4gjBFzTT7HOI5wz9Nc44YAorKDtNCgz2RC/LZ
	BkxaZVyjNnowJDbq7/jitj2YpCNMRSA1NAADrtGbrqxszJb0bNfC69d3Gpt52Q==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Dec 2024 18:53:03 +0100
Message-Id: <D6J9SRCAVWY8.1RY8GDZHEBG3P@bootlin.com>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v2 0/7] Add support for MAX7360
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <f5memlwoahjjvvian4hutan724msi3ojbkhdaoqvtqstnhvfqt@xkdyrpfvy2gp>
 <guxwaw4gapkak3ooy5njkcehk7r7zcfy5ibbkzvnqzwth443hj@wcqvllfixfg5>
In-Reply-To: <guxwaw4gapkak3ooy5njkcehk7r7zcfy5ibbkzvnqzwth443hj@wcqvllfixfg5>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Mon Dec 23, 2024 at 6:09 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> Hello Mathieu,
>
> On Mon, Dec 23, 2024 at 06:05:39PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Dec 23, 2024 at 05:42:32PM +0100, Mathieu Dubois-Briand wrote:
> > > - Removing device tree subnodes for keypad, rotary encoder and pwm
> > >   functionalities.
> >=20
> > How did you test the pwm? Just using sysfs? Without a node there is
> > hardly any other usage left, because you cannot pass the pwm to e.g. a
> > pwm-fan node. So it might be sensible to drop the nodes for keypad and
> > rotary encoder, but I think you better keep the pwm one.
>
> I think I was to quick here. It might just work ...
>
> Best regards
> Uwe

Hi Uwe,

I also had some doubt here, keeping the node might be bit more clear but
I thought you wanted me to drop it.

And yes, as you said, it does work. For reference, I test it using some
pwm-led:

pwm-leds {
	compatible =3D "pwm-leds";

	battery {
		label =3D "battery";
		pwms =3D <&max7360 0 2000000 0>;
		max-brightness =3D <128>;
		linux,default-trigger =3D "heartbeat";
	};
};

Where &max7360 is a reference to the root node (io-expander@38 in the
binding example).

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


