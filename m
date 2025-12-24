Return-Path: <linux-pwm+bounces-7824-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC62CDB721
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 06:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4F933007AAE
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 05:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C41FBC92;
	Wed, 24 Dec 2025 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBqnP2QO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40781DA62E
	for <linux-pwm@vger.kernel.org>; Wed, 24 Dec 2025 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766555859; cv=none; b=iw+nsLcDSRdtx6VVm1/tI3F1j2nj11JAjjXeCSyel6+K1J6D0aTtceXHhIErKqUN+3n38pwJNx3rpcFuk4LqfeFrdSoWWN61N13Dt+osDXkxR7zXO9PiTQXNufrILKFGHJmT6ySXQq366V540l9oEYB9KMxjFou85sPCJIMiyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766555859; c=relaxed/simple;
	bh=1dy5sdYgJxDLSQg+pWbq+5q4BekQWKbhPhmgl/qHr5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9QzCTdiLWaSaoaqJmdGoso0gyEzVAnmfD0agAa8SjZns1uvpIvtS7G6ZCvh9NaIfkJYLztCAk+KruNIbblBdQ6OXQ8nFCdbeL4/LOZ7onAxUt/5+bxWjMqaV59y61X8QkN07A6DoKF8qxpDgN5PwLhfTcT2+W81ylUDVQ5VEpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBqnP2QO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA548C4CEFB;
	Wed, 24 Dec 2025 05:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766555859;
	bh=1dy5sdYgJxDLSQg+pWbq+5q4BekQWKbhPhmgl/qHr5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBqnP2QOELlm33NUm2yDnBfJ4zeUSTW1p1+gL2wHX3So5HL3L9B02sRWqOx2vOu1P
	 ngnJqEjwlT6VXC+6q9IL/WBuP7tqBb9n6zEeLQN38l0V7hxsMWJMiQakM17xOArSuM
	 AtL0chayy4JimHO2dzaXNXEyqvHNQtDDab00B9zTAWYniMZdRDi+pg12Zss+LZ4Tjr
	 fiPcyAUMDU9YEXJ0088W7a3FFLQ1rX4qaCSRTMruFFaECI0soiJeqyFvQL1x4LlOpC
	 nwfT/HAtnGSMj52cghE2gdy7GFrINGZN3lIi2tyz98ZA1pIT8Kz2G5s24iQkPUWNBA
	 j06Uaux+MlqEA==
Date: Wed, 24 Dec 2025 06:57:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Jean Delvare <jdelvare@suse.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: argon-fan-hat: Add hardware dependency
Message-ID: <2l5iqxj2tgfvv4aszl74oatmlxwrfr4m7hy4y3lpybg2zhlrj7@p2ln65gnss64>
References: <20251103164752.533aee39@endymion>
 <05b5b096-33cd-45c4-9d9c-286d743c6916@mailbox.org>
 <f6c2d892b64057c079662e8bd64060d45c156288.camel@suse.de>
 <643bb99a-4d0e-47bc-a60e-208dcc151034@mailbox.org>
 <65639f87c800a1ffcd60d20bb9915772a0d7f456.camel@suse.de>
 <99609491-10bf-46f0-8178-a3c3d375b742@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7lwit6bhcuqlbjbf"
Content-Disposition: inline
In-Reply-To: <99609491-10bf-46f0-8178-a3c3d375b742@mailbox.org>


--7lwit6bhcuqlbjbf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: argon-fan-hat: Add hardware dependency
MIME-Version: 1.0

Hello,

it seems we all agree that this patch isn't suitable to go in as is. So
I mark it as "Changes-Requested" in patchwork and discard this thread
=66rom my inbox.

Thanks and happy holidays,
Uwe

--7lwit6bhcuqlbjbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlLgMoACgkQj4D7WH0S
/k7DkAgAqEJgDcMleM3w62EyDe3DZ7tIfICjYGew19fCUUVB7rp0y0KJXeOfDIe2
WhSyfJaz/T+cd4AtzROfxst9hHaiVXu1KZjtiwfg/lR1TXvhgrdbWaR6bfxEHecO
iH9upjplkJWtwCyisP+RgBANNh85Rzq7iX2WI+IdOroIPwKQxhcNhLNhUsRSHZhR
wYfE9MlF25gufMjBu5eTeGKTY1ibVIv93drAXy2cQLnSfa0d4P/av7AtmONst1Bb
dX4/1vtnWKlz0W+fozBKqL5zF9mK4UTCj4+JtfpodlWRpzp/XRULtIIhW/r6WUza
9gA+9TjO15hTQknMGDC1XeuBlDMpRw==
=fCeH
-----END PGP SIGNATURE-----

--7lwit6bhcuqlbjbf--

