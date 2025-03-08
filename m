Return-Path: <linux-pwm+bounces-5126-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73898A57DB3
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Mar 2025 20:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF29A188F1BE
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Mar 2025 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0EB1FCF47;
	Sat,  8 Mar 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGtaiHCz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1D1F5846;
	Sat,  8 Mar 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461313; cv=none; b=LF28RkWx9FYrwA3yrl3HC8UjiaTlsa5c1K3sSSJpzTWr9Mn3bNs6+hFSIXUDVso6c7g8N3+Cis8OMtGXS532cRrQLcx0ZnHdata2yS/gSH+GX5LX9P7D5+3FGpNkuxrqUQemp61AxvbT93GlvuiWSXO++iLwbYqQGhiMES2nCNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461313; c=relaxed/simple;
	bh=jSu4klko6vecPwS6K4eCxrxYeRWrFGaJHHTOwoB78Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISzFvMkvWQv7yphfCV8zsWlRgtlvhcEzsv6FdCTl4Cg6+OyHtVFXJw0jPTZXDNWv2Y2Nl4abVxZSZtzF9CCoa+VGJMjKWUDupto8C3OC6aXPDUyXwMW7RTw8uKmgisziiowbl4gFHxcVtvgDk9mI+cl9yEict9Y9w9q1lShJYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGtaiHCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C91C4CEE0;
	Sat,  8 Mar 2025 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741461312;
	bh=jSu4klko6vecPwS6K4eCxrxYeRWrFGaJHHTOwoB78Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGtaiHCz70/3ant67lJdfNjmyENzswOKNcvf1EeuDd4cS9fa113t5wIJZ72Z01Oyu
	 ncng3CgtZr4Kh6pwzIo6bFHk5sG0zC9mduYQJNNWO9eDpb40iu9akPQzJ1X37/JSGT
	 b1SQ0OT6+zO1BD1VSeoeM+/3w8749i4qwGERYQNPQ2JrPe2t6s9kMWuK/hHL59TFV1
	 SCbo/GXYnJTjBGXu2TyD7AxTqzvY0w4RKCmzZQis13GFdXc4Jqmm4SDwJZtB3z9V/u
	 KrN0AzmTPDvXU3rW2LHLO4LrovIRlI+BNizZvsEUuGT24zR4NM7RsW2q8FVIG1NY0F
	 t8o/DbMxG8f4A==
Date: Sat, 8 Mar 2025 20:15:08 +0100
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
Message-ID: <w6ac5ygm7bahqzmq6wxeu65puhftxwhmzzbijnyvr4smbcp5yk@f36iwerbbmg4>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <dbfb17df-90e2-4a7c-9921-9dff5e9382f4@kernel.org>
 <ovnmhbzwwimil3opuv6e2ayyntlx7upxfkzm5qdfskx2x7hl7x@wmtul33ttow5>
 <bdca9e9f-7e0d-4ca7-8e8b-f27ea8bb3b54@kernel.org>
 <fnxx2tduww5m3ljs3g5po23ucr4qfytzipgspcf2udkusg7ys6@semr224oy56d>
 <2bcd2718-9ae5-4475-86a3-93fce973d047@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovhqrpznagh7tuwa"
Content-Disposition: inline
In-Reply-To: <2bcd2718-9ae5-4475-86a3-93fce973d047@kernel.org>


--ovhqrpznagh7tuwa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
MIME-Version: 1.0

Hello Krzysztof,

On Fri, Mar 07, 2025 at 08:07:42AM +0100, Krzysztof Kozlowski wrote:
> On 07/03/2025 00:33, Uwe Kleine-K=F6nig wrote:
> > So summarizing we have: Iff you use --base with a non-public commit, it=
's
>=20
> Which is easily visible that it was not the case here. No human used
> format-patch thus no human used --base.

The human used b4 which used git format-patch --base (or something
equivalent). It really doesn't matter that it was only used indirectly,
my statement is true nevertheless.

> > useless and irrelevant. I fully agree. Our conclusion is different
> > though. You accept it's useless (and even request from me that I do the
> > same), and I asked the submitter to use --base as intended to make the
> > resulting information usable.
>=20
> Because you expect additional steps for users of b4 and pointing in
> review standard use of b4 is extremely nitpicking.

My request makes the difference between having build bot coverage and
not having it. I consider that something important so I don't agree this
to be nitpicking.

Looking at
https://lore.kernel.org/all/?q=3Dprerequisite-patch-id+change-id it also
doesn't seem soo unusual that people using b4 go through these
additional steps.

But I can hold out if you don't consider the result of patch checkers
relevant. That's why I intend to stop participating in this discussion
now.

Best regards
Uwe

--ovhqrpznagh7tuwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfMlzoACgkQj4D7WH0S
/k6PfAf9Frc4OceLDvOcRgEjG7GOIQu2fBx5T6mSq1TFzkDWEN+29PbCIf620baH
pzgdW/r829cHr+gDn6bJi47QyIyOnJjwzdbHH021WbuCJTZ+M9UFsKbY6uzl8/Kh
F2TYAOV5tjpaPTWF7agK7x1tODjUoQFh2DIQslgf2rVxAwexGW8lrkk+8wGOHVqI
i0f85CwiXo7C9GhaUL6DLzkM0vbtmfUdc5GVhacJ+OUY/XnuRnRefe2vSKhMVRwJ
gvL8ro5NJzRm5/YaNC/M8zhWA/Kgx+Sxkdiv8zZkVX+K92/vLQdwgiJXsPXM7JLR
7DhK6EXkO+jY94ftQ5QzPwP46+zl2A==
=tFQZ
-----END PGP SIGNATURE-----

--ovhqrpznagh7tuwa--

