Return-Path: <linux-pwm+bounces-4467-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C3C9FB367
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 18:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0EF1654FD
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9681B218A;
	Mon, 23 Dec 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVmmm6os"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F233987;
	Mon, 23 Dec 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734973543; cv=none; b=cZ5BahCb4W40Dp1XMgEQWw44TKRCQSGcNyX8Z9KH58ZJQ7tpZlb29/kHndBqMz29QJdeKbavLmuTtL6ed57738JDyxJGN2tAB2pXCZgCp9RwKZr12w+RI8ODwNiEiPsKpTQGiAZuoVv8fKXMbNtpKk5DYs4QPheGFLSBqIDwTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734973543; c=relaxed/simple;
	bh=zRNgJvNtpTbrnhug4GVekoVroaJAp8+M8OpXpJZFuP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfPVIOYPxocJe56+qNwcV3qOLlnsg5uZx0dCCoA0qwj2uNYoDpJCTDOeTESh6DiZolD7JbDp5cfuOsfrwG09t/EVDucMNH6V13dhzaf1hzB9iLXG8xaUDgk2nyTg0wMqLfKemzS5BDE7P/pSRSHj9PQKsaNUNdftOZffH/CoAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVmmm6os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC98DC4CED3;
	Mon, 23 Dec 2024 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734973542;
	bh=zRNgJvNtpTbrnhug4GVekoVroaJAp8+M8OpXpJZFuP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVmmm6osBmKpBSwDHYuMU9ehRqxWFwKITHG1oAD6x7VBMPeLIJQgv5wMkENbJXCuq
	 DUXxyqdRY8rX2mSaqjARLcXwmX9soACi9RpCxTDDyPFdBvZraB/gwZUBRBGWBCwjhz
	 99JF3v/RO28gUp3e0af5cz69cVHLNzzg39r4CsMAXnuXdy9gLlwopNsxlr7PJjGenM
	 ZsdsrqTqA3Gk9yuxg6kejw93h+0yIqED/U1rXqlOEh6oKwkQWjSJ6da8Yc6IOoFr3m
	 cZypsVA1J3sSP/1Ha2ltpxF+XUYktwnnZ2NeCsInUoygUYVVQO2JwF2jhwe8UOOH9x
	 rgCaCqXquO/vw==
Date: Mon, 23 Dec 2024 18:05:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/7] Add support for MAX7360
Message-ID: <f5memlwoahjjvvian4hutan724msi3ojbkhdaoqvtqstnhvfqt@xkdyrpfvy2gp>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5odqxwxb7r4aev7t"
Content-Disposition: inline
In-Reply-To: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>


--5odqxwxb7r4aev7t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 0/7] Add support for MAX7360
MIME-Version: 1.0

Hello Mathieu,

On Mon, Dec 23, 2024 at 05:42:32PM +0100, Mathieu Dubois-Briand wrote:
> - Removing device tree subnodes for keypad, rotary encoder and pwm
>   functionalities.

How did you test the pwm? Just using sysfs? Without a node there is
hardly any other usage left, because you cannot pass the pwm to e.g. a
pwm-fan node. So it might be sensible to drop the nodes for keypad and
rotary encoder, but I think you better keep the pwm one.

Best regards
Uwe

--5odqxwxb7r4aev7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdpmGEACgkQj4D7WH0S
/k7Hrwf/ZvCvOo1jC/lTO8ayYb/ThxscqnH8hZHyhP//NCbvj9SUrAPlTzhHSzxX
O2IDQELMeDgh3VhMyCLtR+87pvLW64u4Ky6EyZTtjjH/V+aieGb/lV8CL6VgFf53
e1ZFSaRO4fchhFZmYfatgboqidrNhO9Nu0LEUuiuk7QAx7FVTTx7dLE0KDw+J9mq
Wc1fgdCAv7dFQ3cXSgF28Iq0CPlMTXKwPFw0TBZ6u/2nYt46UteIHVrhXVBCUqwI
Z58pHoXV/eZf3U1rfsgeHuZNwba1KX4rQCcWbi6CufuFSQmL+p/EFzSxpDtvCYyp
ZPLWP5ghYKfreOXQJ0ha8/5oJYb3bw==
=tf+P
-----END PGP SIGNATURE-----

--5odqxwxb7r4aev7t--

