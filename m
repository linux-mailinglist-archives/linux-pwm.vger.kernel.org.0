Return-Path: <linux-pwm+bounces-4782-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4207A29735
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C967B1885F7A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1191FF5E3;
	Wed,  5 Feb 2025 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eUFdnDa6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C21FF1B5;
	Wed,  5 Feb 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775976; cv=none; b=UdT982mrZcJh8TFGUlj4lcOWPKUYYqpeEBVV4Y0uNbHDraRZga0yuE0z66JHKSnJ7emLKxf9DpyVROcjCYO+8f9QC3ZLEXWZ46woyauZPvflJNf4ecZVLp94eyGwIpFaEzWgWP68Ks+A4LQOPgIVqImElL70WYF7AF47sA0uI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775976; c=relaxed/simple;
	bh=xEi9OzSb5y74wzAhw0gl9CcBZ4uRFA0Mf3Rt8hQK8Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBwrlgrxBLMoEDlCtnqBR32502eiXW6P5PSHUW/7fZpVx2jA4bw9wkkd6kOKqR8LNsdx748p7qyqZ0i8dlB7+J8iyAw/3/ICTlPQyGXx3KSBVaFYyxGSXVzCBOU+WNtXOIth0T4MmK34g1cJw/eibKNO5pEzRFTJbQpqhoJLKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eUFdnDa6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9207F44174;
	Wed,  5 Feb 2025 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738775972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJI890xtd2ohxN4K/jX7Ffk2Mr6juO+YA4vodND4z80=;
	b=eUFdnDa6L6gVPAbeKqtNywWl8KFX6EbjGj0oC8IU2V6CaTE1Zotaj593+7TCTS2jWroCbW
	y4+FBNOCVYhfgSY/z9QMr++CGlgvtXOQ54pS3mVCYmibxezQCY+cmH/fZmXKd2rKYs3cxH
	t/2cU1MjjX9R7fXA0peK/v0vIHVZcIY346oinAhLn+pl07Jjl4ltYUwmg6ZL0F8H4f6n17
	jieoYQq4uKH58lKeqoRUWDjqImVSdewAhxCAFrz5wL3099FKkfm51WYVEruk9DXdA4HJNL
	+0MDqiGSO4zw2nZzJIHznjBt45smSb7jlfhDCQxEpnszuE/CJaVHKsHGVieKgw==
Date: Wed, 5 Feb 2025 18:19:30 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
Message-ID: <20250205181930.3b800a13@bootlin.com>
In-Reply-To: <6js6k6xz3vuqshq2pfwqifby4t5q54ftztxxw2rau4j23xx2y5@u5xubi6v3uil>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
	<20250205095547.536083-3-herve.codina@bootlin.com>
	<ejdh76c4r44gxsdi7gwed65ste3wuunki2jgavc3wsfri5yaex@jccsywdfadgp>
	<20250205143737.1315baba@bootlin.com>
	<6js6k6xz3vuqshq2pfwqifby4t5q54ftztxxw2rau4j23xx2y5@u5xubi6v3uil>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtvdefvefgiedvtedvgedvgeelhfejkeejgefgvdfguedtudeiiedtieejffduhfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdou
 ghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Uwe,

On Wed, 5 Feb 2025 17:29:30 +0100
Uwe Kleine-König <ukleinek@kernel.org> wrote:

> Hello Hervé,
> 
> On Wed, Feb 05, 2025 at 02:37:37PM +0100, Herve Codina wrote:
> > On Wed, 5 Feb 2025 12:38:32 +0100
> > Uwe Kleine-König <ukleinek@kernel.org> wrote:  
> > > Does this also work if &soc_pwm2 has #pwm-cells = <2>? Would I need just
> > > 
> > > 	pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
> > > 		  <1 0 0 &soc_pwm2 4 0>,
> > > 		  <2 0 0 &soc_pwm1 3 0 0>;  
> > 
> > Yes, exactly.
> >   
> > > 
> > > then and
> > > 
> > > 	pwms = <&connector 1 57000 0>;
> > > 
> > > would then have the same effect as
> > > 
> > > 	pwms = <&soc_pwm2 4 57000>  
> > 
> > Yes, the last 0 (or any other values) in pwms = <&connector 1 57000 0> is
> > simply dropped in the translation (#pwm-cells = 3 in connector nexus to
> > #pwm-cells = 2 in soc_pwm1 node).
> > 
> > In more generic terms, it works in translation from #pwm-cells = N to
> > #pwm-cells = M by simply dropping the last N-M values.
> > 
> > Also note that even if values are dropped, you need to have them set when
> > you point the nexus node because #pwm-cells = 3 is set in the connector
> > node and need to be fixed and usable for all the entries in the
> > pwm-map table.  
> 
> Makes sense.
> 
> > > and the 0 is dropped then? Could I adapt the mapping that the effect is
> > > 
> > > 	pwms = <&soc_pwm2 57000 0>  
> > 
> > In this one, I think you miss the PWM number
> > 
> > If I read correctly this line you ask for the PWM 57000 from the soc_pwm2
> > controller. This doesn't make sense :)  
> 
> Some pwm chip devices with only a single output line use this. The first
> paramter is the default period (which is passed in the 2nd parameter
> normally) and the 2nd paramter are flags (normally the 3rd parameter).
> Back then the rationale was that for such hardware, the line index is
> zero always anyhow, and so could better be skipped.
> 
> Compare of_pwm_xlate_with_flags() to of_pwm_single_xlate(). pwm-pxa is
> the single offender using the latter. Thinking about that, it's easy
> enough to fix without breaking compatibility. I'll tackle that.
> 
> So for a PWM on pxa `<&soc_pwm2 57000 0>` works fine.

I see. In this case, a parameter shift during translation would be needed to
skip the PWM line index in the translated arguments. This is not currently
neither described in device-tree specicication [0] nor handled in the common
code of_parse_phandle_with_args_map() in the kernel.

This use case can appear for resources other than PWMs and IMHO it should be
nice to have it supported.

I think this support should proposed out of this series adding support for
PWM nexus nodes.

Is it blocking for this current series ?

[0] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf

Best regards,
Hervé

