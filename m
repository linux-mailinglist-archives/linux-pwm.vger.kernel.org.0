Return-Path: <linux-pwm+bounces-3195-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECB9756A2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A29B25D8E
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3531A38CF;
	Wed, 11 Sep 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kN1SQopp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCql8XUa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139A64A8F;
	Wed, 11 Sep 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067593; cv=none; b=XHftsZzoreHV1NYNxwUMTOODmmAM1RyNbY6ID2uCtxJIGfDgaRnXK7oksF1f/a9fZz1C39hWpPnfA315U5Qaj1PkHCWfxf6fz3nsRcyIjqteSiw9wqmYmmr6IIRaCyEV7G3AO2OO5CGMaoWhTkz0arirZW13XLsu+NrmpOO7Kqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067593; c=relaxed/simple;
	bh=WYSo2PbdmOt952RgPLexG7kR5bugRClHNNEt8x7IqTE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MCuHtNNbdIZHGmCKD1cfAOepU9qgCU91EzkLNnEnSU2avmBNqNnumfyUZG+takBTLEJj3KlDYEfN3ydQ/5FRX+Ciusn43BxeUJKVsAdZIoxAz69wONCR10q/vroc0q4LxdKxDHjKiI76la8LbVyaHY0jMqbooqK9D+mijTLaw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kN1SQopp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCql8XUa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1088E1380199;
	Wed, 11 Sep 2024 11:13:11 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Sep 2024 11:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726067591;
	 x=1726153991; bh=W3/bFLF5GPmG/oJuoeXrc+CcLB5pp1RgCukpWqx8NY4=; b=
	kN1SQoppsrfhQ1aKwXkZbakGlLdt9X7n0Qpj/jN4UR1Y3eNgfSXpaqnXU2jvT2SO
	CkKtJctqSn1epUMSsgTMq94lbckLuTjWebG421B1IDhx+wTpY91SAQbai5EzqCLj
	R95I9h/Oyrbf0WnPZczXlzIg7iR9OZRJOQVGeLeTXeijjQZUN9pssjm0tQL1Ck4j
	zmCdVn/KgcSUzh3PEDQzQyXH51CECcn0v6jPm0mQP/MY+7V5gk0nq6+l3gCmtc/g
	ty+HY7W6MR9EvZlDKxtvn7S6GuJIvWJn5pCaHnSKZaMQioVWClMCwcd/dkDHZESD
	MQC/E8Utlc7jhB8oJkSUEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726067591; x=
	1726153991; bh=W3/bFLF5GPmG/oJuoeXrc+CcLB5pp1RgCukpWqx8NY4=; b=X
	Cql8XUardaZ101GAHySvPbidSWgvrUhHQTCY77YF3/JUkwctwdWEm38bkCyLGtt/
	8J16Bl06FqQMUJtlhObOyitk5m7QP44iPGfGHHv0aKH/ADQhxP5Aiy6+CoohSNhJ
	Rhh4Auxf90Hnlp1iddYVLU6hc1fMMYmgb2+cmg3Fjo/WnIAeHVoCzZhj1YgNYPcr
	1ohJKWJiuShFO5wslaYiWy/j2dw0LyVqm9nBXt8d//9b1SRq9ZTSl3YOskUEJXlB
	nwUS/fpAc5NQ4sli8XBxEYlbcPYALdQSiG546mzXcfi7kXY6pJzGjqIFv6FqVOCf
	5cJTRRRLjcMtic9xhj/4A==
X-ME-Sender: <xms:hrPhZv7WKy14IaSXDvrB34WD0cgYbD5Ijoe3JWsHr6GlacVyDBKooA>
    <xme:hrPhZk7a8Fxhynsc8w8RlayRPVgkEYNKUatMkcijCIuyuLVk0jSfOdBnS-5RByWau
    RcFm8SjrTnUKfsMc_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsohhunhgusehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdifrghttghhughoghesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehhshifvggvthgvnhesvhhishhiohhnvghnghhrrghvvghr
    shdrtghomh
X-ME-Proxy: <xmx:hrPhZmdf99FfYnKem1AvJRPrIWg_fpZhxEh7VXJW1DiQT-3DEsIlAw>
    <xmx:hrPhZgKV4S-Tu8NFrkX1SKt93sCnq7evJA8rGaJW17oS2EqYyvfRuA>
    <xmx:hrPhZjICCGVAAUPix4F6pKGjdQzOYquZK8famopAqgECfsZSkw7yfA>
    <xmx:hrPhZpx3YBmlZtpGZtemz01LfUC4tyicKeisD-A40BaSPyvkkrpYOg>
    <xmx:h7PhZgqUnZj763mof6oSn8RoTf9JC4c3LkDlkkuvY8-Y5nodlrUuSzYN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2F2D222006F; Wed, 11 Sep 2024 11:13:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 15:12:49 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Lukasz Majewski" <lukma@denx.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Thierry Reding" <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
 "Andrew Lunn" <andrew@lunn.ch>
Message-Id: <cff6b9b6-6ede-435a-9271-829fde82550d@app.fastmail.com>
In-Reply-To: <0e3902c9a42b05b0227e767b227624c6fe8fd2bb.camel@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <CAHp75Veusv=f6Xf9-gL3ctoO5Njn7wiWMw-aMN45KbZ=YB=mQw@mail.gmail.com>
 <0e3902c9a42b05b0227e767b227624c6fe8fd2bb.camel@maquefel.me>
Subject: Re: [PATCH v12 00/38] ep93xx device tree conversion
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024, at 09:02, Nikita Shubin wrote:
> On Mon, 2024-09-09 at 11:49 +0300, Andy Shevchenko wrote:
>> On Mon, Sep 9, 2024 at 11:12=E2=80=AFAM Nikita Shubin via B4 Relay
>> <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>> >=20
>> > The goal is to recieve ACKs for all patches in series to merge it
>> > via Arnd branch.
>> >=20
>> > It was decided from the very beginning of these series, mostly
>> > because
>> > it's a full conversion of platform code to DT and it seemed not
>> > convenient to maintain compatibility with both platform and DT.
>> >=20
>> > Following patches require attention from Stephen Boyd or clk
>> > subsystem:
>>=20
>> Does it mean you still have a few patches without tags?
>> What are their respective numbers?
>
> The clk is the last one as i think, all others can be ACKed by
> Alexander or by Arnd himself.

I've merged the series into the for-next branch of the arm-soc
tree now. The timing isn't great as I was still waiting for
that final Ack, but it seem better to have it done than to keep
respinning the series.

I won't send it with the initial pull requests this week
but hope to send this one once I get beck from LPC, provided
there are no surprises that require a rebase.

     Arnd

