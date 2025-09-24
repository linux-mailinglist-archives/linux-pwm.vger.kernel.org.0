Return-Path: <linux-pwm+bounces-7348-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F3B9A480
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4633B3B2F25
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED913090EA;
	Wed, 24 Sep 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O23Wobn1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F1308F17;
	Wed, 24 Sep 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724622; cv=none; b=nZ33//yVVj4bfTkoH+94b8Ll9MQUMVcLq3aybsA9X4zyU0wiphuZUjxKPF8ceEpliN/cKjCfpOqIDlgvdxuKfMhnwzuqk3XBkd5oNRsHt3n4t8urTqIp2UIJDitzw7CXcRySmWacLizXlccTbSCKNrH+cFypiy9A9+Jy/MS61Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724622; c=relaxed/simple;
	bh=CHQFVu+qUmZhlGFnmG/lbIESrIvQNwUe71U5xpqDdMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKasXjSD0g8qXLeqsCpJyQgc40ia75+C5iXYe8mkOp9awpxZY4NVLPWqHjYMORtBoO4dRPIZEhMlYI0h4ahf5ezwD/a7o2tZ43BSgtwL+PykBGMyIcB5DAFmri/4OjS2s+xzGEcfouWl53MnvJlhEoUM7juXwCGyfXi8sW+LxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O23Wobn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4557EC4CEF0;
	Wed, 24 Sep 2025 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758724620;
	bh=CHQFVu+qUmZhlGFnmG/lbIESrIvQNwUe71U5xpqDdMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O23Wobn107PrPbRMnZrOEG7BX2knYhRIcBzXw4cmobOG3H5efM6zuj2zmoBKVh4jd
	 ZxKLhBhgxg+98tmH2vw76YMfYCJMkGAE9u2DGQ/t0tnFxq2p47zZ7F5HB0IcX2LUDd
	 rn89cpz4msq12FOEfv90tRFNceS7eYwRmcKXPXqElvzWxi30VjPXFnuGK+G/AzgKmz
	 P1y87FM0KMWqQUWqaQOaSJoq5gqrME9Kbwi4nrvQ25kb50IC7nomAFcMo9fcd1nU+G
	 4Vu/q294zkYxxEZsj5DTpmcEDP9UavBm+YLwPS8455HwH0MnEFfOi5YNm4vMs2M6Dg
	 TVX4bzMAoHmVA==
Date: Wed, 24 Sep 2025 16:36:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: max7360: Clean MAX7360 code
Message-ID: <ke5evprfv754iksvrt4puej26oqi277iurlgeoakqg7hnzv3i7@ft4utkuck623>
References: <20250924-mdb-max7360-pwm-optimize-v1-1-5959eeed20d8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvmm3r3gyivaszc6"
Content-Disposition: inline
In-Reply-To: <20250924-mdb-max7360-pwm-optimize-v1-1-5959eeed20d8@bootlin.com>


--qvmm3r3gyivaszc6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: max7360: Clean MAX7360 code
MIME-Version: 1.0

Hello Mathieu,

On Wed, Sep 24, 2025 at 11:06:40AM +0200, Mathieu Dubois-Briand wrote:
> Duty steps computation can never end in values higher than
> MAX7360_PWM_MAX: remove useless use of min().
>=20
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Suggested-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

I'll pick that up once the driver makes it into my tree.

Thanks for caring
Uwe

--qvmm3r3gyivaszc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjUAgcACgkQj4D7WH0S
/k5TpggAtveaVPit0N/UecXwkRnYbWggcahTBGqwbRa02ABB5wus8bd7ePHFN1Gz
8AISkZ/acM8u7MtXcjUG9OwLrEQBVApRPFF5YwF9raNIFylr7ClNJiA+Qn4mAjlN
BpJ23LZUJZJTTXtx8T+AJdJV3Lwae368BL/xUqfcgLUrlqQTYuD2pJq+nWzLkp09
LLoX1mUo4WqQrHgHatgujDXN0RFMfgmLp4T5f5LWoDCBO2QhRINRUGlqEt3dzoX4
mtY5/guZl8CiLnfwxY09tY27efZS5FUd+IfDGhSk943Sr/E0o6hsGXulnc7FTJbl
U/i0/3Y5PPydo6R5JSITfslLoEQHaQ==
=QN2K
-----END PGP SIGNATURE-----

--qvmm3r3gyivaszc6--

