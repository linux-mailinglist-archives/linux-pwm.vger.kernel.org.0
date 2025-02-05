Return-Path: <linux-pwm+bounces-4788-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB6A29845
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6943E3A55EC
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDED1FC0EF;
	Wed,  5 Feb 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l2CdekW1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905597083A;
	Wed,  5 Feb 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778568; cv=none; b=kJTvQ3RcgS8uo4NNd5WEYNCR7kY5gY5RMAKwBWLwBo5z9zJbxfjF38F5C6HwYIXQWiMKQjHZQaUBlO4sbJ9Z+EIR6YWg2ZHAz2D7zxwHFV8Wc3XFVLZrabDrKb6mkUmv+WP71twkjkDTc8SOBu0pAlJh5rdTlEMoFajVnpkxl+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778568; c=relaxed/simple;
	bh=8lO6fMuFBE5rUDmcGzJEh/sm0slTZyqroFLDOFanbWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rprAXrZKTM8sCBbtG82FC3AmdpVyP9cR2HDUwGdrL6VGVajqRloK3Js/CDv+NXUNFYmAq+XJUUISF1hT5Ov3D82E8Sh/tqr4Wkllot1okkcpNMkrxxZ1gaOvKSYkP2WEShIujQ7pOFzfTEqOLS2AAPP0gUD6vUxnZYUC2wNbNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l2CdekW1; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23EA44321D;
	Wed,  5 Feb 2025 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738778562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgbouvaIpxAOI+/T/j6mufdIysNVPHBLHY7/8pAZJ8Q=;
	b=l2CdekW1RepJihNgiSiTw/1ixasWr5S4a+WcrjbPeHSeaXr3L6s1ig9/3XzAY3dIai8aDQ
	FGQziHfbz0/zTcLHfrzzNFLOE9/GdRrt26LYvbkKAo5CWmiDQQA74+7kH3Qyp0b0xr15bV
	8Jq8Ekw0akYgZIv1h2+uXNP7Smtv3wmbui7XPKW2L5gcGj974PmSUxNykul2EbMKwjMBAZ
	UJCKBSV+hNwXq470bcLob64MNVtBOfjl3gQUtOOsEySVpWKub/T3cn0QJm8hLZ3m6MXSWb
	NKygQmfWpovWd6I4bNGT7+yikBYb+rNR+C9DO4PDHcQtEkwJfb4hZbEUBc7/Ug==
Date: Wed, 5 Feb 2025 19:02:40 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje.mihanovic@skole.hr>, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: Add upgrade path to #pwm-cells = <3> for users
 of of_pwm_single_xlate()
Message-ID: <20250205190240.0cdb0473@bootlin.com>
In-Reply-To: <1829c1a040c707326d9c53aee3577763e2139d58.1738777221.git.u.kleine-koenig@baylibre.com>
References: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
	<1829c1a040c707326d9c53aee3577763e2139d58.1738777221.git.u.kleine-koenig@baylibre.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlseiiohhnqhhuvgdrohhrghdprhgtphhtthhopehhrghojhhirghnrdiihhhurghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrohgsvghrthdrj
 hgrrhiimhhikhesfhhrvggvrdhfrhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguuhhjvgdrmhhihhgrnhhovhhitgesshhkohhlvgdrhhhr
X-GND-Sasl: herve.codina@bootlin.com

On Wed,  5 Feb 2025 18:54:00 +0100
Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:

> The PWM chip on PXA only has a single output. Back when the device tree
> binding was defined it was considered a good idea to not pass the PWM
> line index as is done for all other PWM types as it would be always zero
> anyhow and so doesn't add any value.
> 
> However for consistency reasons it is nice when all PWMs use the same
> binding. For that reason let of_pwm_single_xlate() (i.e. the function
> that implements the PXA behaviour) behave in the same way as
> of_pwm_xlate_with_flags() for 3 (or more) parameters. With that in
> place, the pxa-pwm binding can be updated to #pwm-cells = <3> without
> breaking old device trees that stick to #pwm-cells = <1>.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

