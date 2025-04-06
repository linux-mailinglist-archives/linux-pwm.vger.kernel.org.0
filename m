Return-Path: <linux-pwm+bounces-5345-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB9A7CC62
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Apr 2025 02:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14076175D9C
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Apr 2025 00:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494CC4A23;
	Sun,  6 Apr 2025 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RMRG2WJI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A6518E25;
	Sun,  6 Apr 2025 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743898620; cv=none; b=PIiSTBayJe6lyBAeTMrzkCdXVEwwQ2Sc82obW07yyEKf9QFRx2hAJGLJqjGn2StRd1QhfksBzYasqfY7NlXF8P98GJHtIGPZiGjdDFpaC1hJ1G7BANw6btZoK21E//2YtfrFOOFaD9AQsXYdxmwVD7qYi2BWmkC7wk+1W5ya8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743898620; c=relaxed/simple;
	bh=1gU66AhCVQ458knRRqYdIvSsqU5W4dAUpbGEMUZD95M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hOVlO5W9wUxU6m/7X9aroMNJiTTjXN8Za1eWAN19DNeTWU+7itkAoL5KANIATBVRNP6AZLR4CbkSWcMLfYvcK2etK4aWhRByOQvUX8AWpTVC5qHvmh+A7R7snTe0ZsXogijvpGGH/OYi5lIfqMP96tUxUDstU3AwFbecj1xdJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RMRG2WJI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6D71433E8;
	Sun,  6 Apr 2025 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743898609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROu6wF0yx4tuSS3BhfWfPZ8/7j4ZcyS0KOFip7yllzk=;
	b=RMRG2WJIUh8Tkbsv3CMh3RIqOjXbovdt9DJmokY1EztSPfEr/qURcRQZUGiycQUbaR0b9q
	YoEA2qxhJOdA4TB6OHjcri/uNJX2S7IDdpihCz4S6blh6fEiundnK5sRmOlV5nthBiukDu
	uIzfJWKrBFt+v0Yfzw2q4tG6RXsbpow0qJbqIfn7u7Mz0eYeFWhTtkSnZg/TspTwBQ14FG
	bWWabd+C1dqZ41uG+0LjJ1TfnUCB1hUukzIHk1hf8Yjuowgdbyr34I9o5hAHMFNI0St1P/
	uOX6WxhBn0SiBvEKhEy7OhRcOEXF88b426lDEW+/cGjDdD1Y1V7DWz+VXdhfTg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Apr 2025 02:16:41 +0200
Message-Id: <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Jingbao Qiu"
 <qiujingbao.dlmu@gmail.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <unicorn_wang@outlook.com>, <dlan@gentoo.org>, <linux-pwm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800
 SoC
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
 <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>
 <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
In-Reply-To: <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleehjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdejnecuhfhrohhmpedfvfhhohhmrghsuceuohhnnhgvfhhilhhlvgdfuceothhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteeuvdelhfetudejvedtffegveejteeuvdduheethffgueetfeehgfdutdeftdetnecukfhppedvrgdtudemtggsudelmeelledvieemfhektddtmeduuddumegtughfjeemgeeghehfmeeisgejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeelledvieemfhektddtmeduuddumegtughfjeemgeeghehfmeeisgejhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehqihhujhhinhhgsggrohdrughlmhhusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhnihgtohhrnhgpfigrnhhgsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepughlrghnsehgvghnthhoohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: thomas.bonnefille@bootlin.com

Hello,

On Sat Jun 1, 2024 at 1:53 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, May 01, 2024 at 04:32:42PM +0800, Jingbao Qiu wrote:
>> [...]
>> +	if ((state & BIT(pwm->hwpwm)) && enable)
>> +		regmap_update_bits(priv->map, PWM_CV1800_OE,
>> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
>> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
>
> This looks strange. If BIT(hwpwm) is already set, set it again?!
> Also if you used the caching implemented in regmap, you don't need to
> make this conditional.
>

I was testing the series and noticed indeed an issue in this driver at
those lines. If PWM_CV1800_OE isn't set by something else than the
kernel it will never be set and so, there will never be a PWM outputted.

Using :
    if (!(state & BIT(pwm->hwpwm)) && enable)
Solved the issue but as Uwe said you can probably rely on regmap caching
to avoid this condition.

>
> ...
>=20

Do you plan on sending a new iteration some day ? I may have some time
to continue the upstreaming process if you need to.

Thank you for this series !
Thomas

