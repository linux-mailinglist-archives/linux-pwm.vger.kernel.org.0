Return-Path: <linux-pwm+bounces-5075-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46261A4E806
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 18:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53638C7326
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C5292FB0;
	Tue,  4 Mar 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWHK7L9S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BF259C80;
	Tue,  4 Mar 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104191; cv=none; b=B9X0eoRYDTeCKW/EVnMumOndUBcxrCaKtl0IWEf1RB9Rvnv+Pp3NyVptjffYO+5K72cqe+hYYf2fgnSZ7kNg/ZzGraA3ZdCw+G2HAnh28nXuDiGz+2C5148uBRGkK6/VgJBq5s4k9hZbPfaKyxGFkNFm/STZdJYkjbYUfrNo1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104191; c=relaxed/simple;
	bh=AVsISUnjl4Jdf9DLrSq7Ms07xPjVJ+xBd7hhdqHu8xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U93NLX4Tcv+VZqn2kvAVi451GasEtx0zDkW5HU9fry3Q6uYYcz/lSFKbxaryAV4vB+lVt3PlKjeXgiMNcQ0kpH2w64VyOKJW9/WvIaGjyNKpsQQA5k/OSYJVQPnZmkwL7ZW52uRXo5GQhLbDzyv3wgBMy2ms3IZxPQefabuthkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWHK7L9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255ECC4CEE5;
	Tue,  4 Mar 2025 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741104190;
	bh=AVsISUnjl4Jdf9DLrSq7Ms07xPjVJ+xBd7hhdqHu8xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWHK7L9SAZrlh8gLOBE0RKDPtg/bO0rkF/NjBcM7vl0b4/nwn/xMycp4+HWh1Hcp3
	 bh0NrUEXcb9z20k4egJZWTGM7CAHxd5D3Eyw8gEnIJTtvs6rbdySosaCU8yUuvYJ8y
	 j+h/eUhx4MWKp9CdxpA04uLesTfKBltjEOSIzeP8Rog5tNVLgJv+FSEfsDtxTqmtYT
	 s/SdgwsAfsqDhXaVamY7XUFNtt8f0LCDJ1NI6oKBoXy2ehSzC7jtLXkrz6/XR2Mn8r
	 N5yvOB8DvJc03dAkOs1lBNax5D7J52EbLyEYM0LMn+Co9E+u7nFs4vV6bk52Wgoc3U
	 aI0wRBt3L7cOQ==
Date: Tue, 4 Mar 2025 17:03:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Message-ID: <ovnmhbzwwimil3opuv6e2ayyntlx7upxfkzm5qdfskx2x7hl7x@wmtul33ttow5>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <dbfb17df-90e2-4a7c-9921-9dff5e9382f4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6v4ftly6nfumon3z"
Content-Disposition: inline
In-Reply-To: <dbfb17df-90e2-4a7c-9921-9dff5e9382f4@kernel.org>


--6v4ftly6nfumon3z
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
MIME-Version: 1.0

Hello Krzysztof,

On Tue, Mar 04, 2025 at 10:53:53AM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2025 07:24, Uwe Kleine-K=C3=B6nig wrote:
> > instead which gives you a more exact result. The challenge here however
> > is that the multiplication might overflow. If you know that the result
> > fits into a u64, mul_u64_u64_div_u64() is the function that gets this
> > right for you.
> >=20
> >>  	chan->pwm_value =3D min(val, max);
> >>  }
> >> [...]
> >> ---
> >> base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
> >=20
> > My git repo doesn't know that commit. Given that you said your patch
> > bases on that other series, this isn't surprising. Please use a publicly
> > available commit as base parameter, otherwise you (and I) don't benefit
> > from the armada of build bots because they just silently fail to test in
>=20
> As you can easily see in the signature, this patchset was generated by
> b4 and such tag was added automatically. No point in stripping it even
> if it is not useful (life, happens).

My request was not about stripping it, but making it useful. I don't
know the b4 patch sending side, but git send-email has the capability to
make it more useful in this scenario. I didn't check, but
`b4 --edit-deps` which Abel mentioned sounds about right.

The relevant documentation for the git side is the paragraph "BASE TREE
INFORMATION" in git-format-patch(1).

Best regards
Uwe

--6v4ftly6nfumon3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfHJDkACgkQj4D7WH0S
/k5KMQf8C1vVFoqeXHKeMvA0VZ7JGsVsCt7VFg8DysvNLBYOq6gZ9s5qG3s3uQ+Q
9z5ADdmVnt37kOZ4KmKfPoA0Pcc72fE3gpMIGrVJVARIYqmKazM/9C/eYhJ9Gx4o
uzU8EFAlRBJnAio/EuVujSdBF64M15eCOW3WBT/KqmYDK/AKXxeCZkwYRshLy0nX
4RtdSOYTTj8I+YSH7KwEp8BbjQ3WAWD4YRF/kjhXz2EXwSUHDRP26WGhIIw98OUv
SRBVJH7UI9tMKre5IL2oLPWH51eMzV13SNnRTQi4YBJNqrBf9vRc5WFAXUTw7Agi
InOScbX37Bp6BsBkoPHW20ttnIuBZA==
=s9yo
-----END PGP SIGNATURE-----

--6v4ftly6nfumon3z--

