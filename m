Return-Path: <linux-pwm+bounces-2963-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52639458F3
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 09:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F2C2812D6
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555E15B134;
	Fri,  2 Aug 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="B+gbkflc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FC482EF;
	Fri,  2 Aug 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584187; cv=none; b=sr+K7eGaIPS75Gkr4OlmaudDkNAMetEupwf2eFd//k4eBKtAHMY0g8Ki5wYLp0p7zlmZC43s/Z9F+9cBrkCwQ1eXNdISsmT474YhAwR7k+ZKhXTBr8wxXg2mBNLfMWz1TPC023zb2gujoHMXKr0r6Cu1rsdylwE6O7vUReu2cbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584187; c=relaxed/simple;
	bh=xFfFI1VUxM96WEW9h09vMDS1bRrM3Fk2qt43Z+ICuZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uKMlx82TRvia6UWp4OhrxgBHFAjpXbHsmXLTKdxQt2nkyAneXWR0UJfnM2ufRgniRuORF05wQI7wF+PM0mc+EQCJxDoGGqeYTi5neBtTEbepFAXc6YTkOhNueFnNdGMYaL0lEzqQJtktPvBikksAi7Jl25CUH1a4OwWgnBuPcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=B+gbkflc; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3ca5:0:640:b181:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id D54DA614BA;
	Fri,  2 Aug 2024 10:36:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aS9oj3g9Gk0-oGKazRiT;
	Fri, 02 Aug 2024 10:36:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1722584173; bh=xFfFI1VUxM96WEW9h09vMDS1bRrM3Fk2qt43Z+ICuZ8=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=B+gbkflcsamzsGcKQTG4gVtLeiw5V77vFyRCXGV32y02UNz0jqZWx/MHlr09NS+AF
	 H/nuqOh4suJapcpzsjCr0oA+GzqaB3O/j3B06JXBVCF/TWiGCMWTOk55v0lhknim05
	 7duSEm+DNJsbKzrqYeFrO89AuJ66z0aYIFrJU63c=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <a1a27117725305dcd6135df193fe2b74646a9e26.camel@maquefel.me>
Subject: Re: [PATCH v11 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: "Rob Herring (Arm)" <robh@kernel.org>, Alexander Sverdlin
	 <alexander.sverdlin@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Damien Le Moal
 <dlemoal@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry
 Reding <thierry.reding@gmail.com>,  Vignesh Raghavendra <vigneshr@ti.com>,
 linux-pwm@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Ralf Baechle <ralf@linux-mips.org>, 
 Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  linux-ide@vger.kernel.org, Stephen
 Boyd <sboyd@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown
 <broonie@kernel.org>,  Hartley Sweeten <hsweeten@visionengravers.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,  Andrew Lunn
 <andrew@lunn.ch>, Richard Weinberger <richard@nod.at>, Eric Dumazet
 <edumazet@google.com>,  linux-sound@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>,  linux-input@vger.kernel.org, Jaroslav Kysela
 <perex@perex.cz>, Sergey Shtylyov <s.shtylyov@omp.ru>, Lukasz Majewski
 <lukma@denx.de>
Date: Fri, 02 Aug 2024 10:36:06 +0300
In-Reply-To: <f68b628c3978a4fb0e5989e3b6918c756da1fefb.camel@gmail.com>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
	 <172104541245.3725513.13547524352291855487.robh@kernel.org>
	 <f68b628c3978a4fb0e5989e3b6918c756da1fefb.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Mon, 2024-07-15 at 22:46 +0200, Alexander Sverdlin wrote:
> Hi Rob,
>=20
> On Mon, 2024-07-15 at 06:12 -0600, Rob Herring (Arm) wrote:
> > My bot found new DTB warnings on the .dts files added or changed in
> > this
> > series.
> >=20
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the
> > warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to
> > reply
> > unless the platform maintainer has comments.
> >=20
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> >=20
> > =C2=A0 pip3 install dtschema --upgrade
> >=20
> >=20
> > New warnings running 'make CHECK_DTBS=3Dy cirrus/ep93xx-bk3.dtb
> > cirrus/ep93xx-edb9302.dtb cirrus/ep93xx-ts7250.dtb' for
> > 20240715-ep93xx-v11-0-4e924efda795@maquefel.me:
> >=20
> > arch/arm/boot/dts/cirrus/ep93xx-edb9302.dtb:
> > /soc/spi@808a0000/codec@0: failed to match any schema with
> > compatible: ['cirrus,cs4271']
>=20
> well, this seems to come from the fact is still documented in a .txt
> file
> (Documentation/devicetree/bindings/sound/cs4271.txt), which is not
> really
> the scope of this series. Hope it's OK to ignore it for the series.
>=20

Indeed it resides in
Documentation/devicetree/bindings/sound/cs4271.txt.

Can we slip for the series ?

Actually i found this one on mail lists:

https://lore.kernel.org/lkml/20240709184231.125207-1-animeshagarwal28@gmail=
.com/

Conversion of cs4270.txt, Alexander isn't it almost the same thing as
cs4271 ?


