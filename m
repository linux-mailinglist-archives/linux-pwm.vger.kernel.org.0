Return-Path: <linux-pwm+bounces-2746-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C7A92D1A5
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BE51F21C86
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D319149B;
	Wed, 10 Jul 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="li1YxcHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IB3v6d3P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFE1E488;
	Wed, 10 Jul 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614727; cv=none; b=LTgfrWf6l56HiesS7A97WmBuDASmnDvF9r1RECH1wKBYqFu2RuXXgJve276Zx5XejZ9ryInKy7+jfKLLEkPd07GIxRwfEMY9Pw1PYArmtBf0BByBRqVNrEiGwSPHaObESPIapc3QRKhy71hGhqyBrCK/kRvmYgzfBAwbz3/rQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614727; c=relaxed/simple;
	bh=XU81jlqPSEHhklnXvmeUHF4K+FfBTeR9jSQAbMBRniM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=I+qMFHWMO+rC+GJQRnBjALkPNoQdmi83uvXNlxqdXFE+rXyhDdSQDRGZpaOQdlLl162jhqm6YO8cNx6jmFaSWcCpC+syjdcbiz3/Lrefoo3vwCJ+bItS+lyliJSmVCM2JFNI1J8oSrCvwVSOF+67vkN0tqQWtYOXfHoDkQ3huUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=li1YxcHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IB3v6d3P; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 689051385136;
	Wed, 10 Jul 2024 08:32:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 08:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720614724; x=1720701124; bh=C2Se+H9RzY
	HkM+IvsyadLBKj3T9ynrUDq9Xcr2QdKUs=; b=li1YxcHH3YLCQ4Le7dl2muHN8j
	eMQ3UOnJF2Kn5c3G8TqV3FTvl3x6SSRi08Gli+0KxjlQo5baF/Uw2goGLZ0zV962
	O+0dbBjc96aY0X3OfzwO4T9Vq3oycXC9UY+jfbqIQZnCZkVYvcVt4rGn0CjXFfsI
	x01m2Qn7qm9aC1DjvEbzZv0Je+YJYwvl3wYilpL1OR+VQWic/lrfI/t/M23qmytk
	obEhpc4FUTd6l1ENJI4CdSmTJImc1fVa4dJ717DPMPYK0c3wYKrThMImwyvtD373
	9P0IhfOWjjqMlrqwtrY6DAjvnOcPjh+VSYYQXPLwHQjjvMtdYbw6d7BRU0KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720614724; x=1720701124; bh=C2Se+H9RzYHkM+IvsyadLBKj3T9y
	nrUDq9Xcr2QdKUs=; b=IB3v6d3Phr9VWTcxt8gBc2qcRz2azkcEcmvH0Yd+yEa3
	g9xn5bnLx1fKqjDN1R2Zwrnky673MsrPd0Hn7Zfe+mpOkhIbhvxlKL6EWJi8KkbX
	IrFCk/rCfEBcoMQESHdkxOZF2rJde3RKeJzGC1TYQYAwUr5rUc6AxDCMpu9CJo68
	u8ahhEa7s2NSp6hh+gt2paRMhj3TgijNx5vM4Xa4D6Wy4WXrTbE2i42ZrK2nFA+x
	fXw47caFr8RHQOKF6GXXnf4EYiRsZTNNuhj6Vvw1EVBliFbdLQJmwuIoZHpw0gkx
	+q4zkGZBCkISrLrcpnAZzZAhsHNa782s+ub2R7Xvqw==
X-ME-Sender: <xms:Q3-OZubytZE4eowk4SBwd6hMi1H9GUi8VnkX6U3DBiJe6th8n_5a_w>
    <xme:Q3-OZhYssSpvCnxNlzCJ9UZkhGWR04WPe8Nh1Ww-TQk3zUwsHMOxwG-QZoOEM6zOf
    eQ8ecMhmQcG3EOFMyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedugdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Q3-OZo_hswq48saoXU7mzKLp59S-ElC0pUMtf-ZdqPyc4tuSZaCSvw>
    <xmx:Q3-OZgrw9GGfjnJwhwXkfnRA_RU8P6fsBJiCeL3U7HL26R6CQOl-Wg>
    <xmx:Q3-OZpr0bvZIiYqiyQFln6EySrIEHwSZhi9tOoqN4tp0x1B8sPE-4Q>
    <xmx:Q3-OZuQd3ydDSldUIX01Q5l0z9-EQ4hy3zb3OhkIisG9b-K3WDSgLg>
    <xmx:RH-OZtLntWVOrwVwg-KdB-d6vurB4_VxNR9iIYGfWiVJaUprkM1Da6tC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 09148B6008D; Wed, 10 Jul 2024 08:32:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f45a3d9-429c-441e-a17c-33a163eb86c2@app.fastmail.com>
In-Reply-To: <663b1749afeb5cec281149fdb445ed36fdcbc68e.camel@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
 <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
 <241a4cf9830b0118f01e8fcf2853c62527636049.camel@maquefel.me>
 <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
 <663b1749afeb5cec281149fdb445ed36fdcbc68e.camel@maquefel.me>
Date: Wed, 10 Jul 2024 14:31:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Lukasz Majewski" <lukma@denx.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Sebastian Reichel" <sre@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Thierry Reding" <thierry.reding@gmail.com>,
 "Mark Brown" <broonie@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Ralf Baechle" <ralf@linux-mips.org>, "Aaron Wu" <Aaron.Wu@analog.com>,
 "Lee Jones" <lee@kernel.org>, "Olof Johansson" <olof@lixom.net>,
 "Niklas Cassel" <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Vinod Koul" <vkoul@kernel.org>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
Content-Type: text/plain

On Mon, Jul 8, 2024, at 09:34, Nikita Shubin wrote:
> Arnd, 
>
> Are we continuing this patch series ?
>
> You are silent since last version submit, which makes me a bit worried.
>
> If you suddenly changed your mind please let us know, cause anyway we
> have no possibility to merge these series without you.

Hi Nikita,

I definitely still want to merge your work, I was just not paying
attention while there were others commenting on it, and I don't
know what the current state is. If you are ready to have some
or all of the patches included in the next merge window, can
you send either the set of patches that were reviewed to
soc@kernel.org for me to pick up, or prepare a pull request
to that address?

       Arnd

