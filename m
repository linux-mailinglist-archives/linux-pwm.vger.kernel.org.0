Return-Path: <linux-pwm+bounces-3607-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15ED99AE22
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 23:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05ABC1C21984
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095071D1721;
	Fri, 11 Oct 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxQ9oK7h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71521D0B97;
	Fri, 11 Oct 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682815; cv=none; b=eV2F9qJQGQ6r9Sd6B3FVNdfxRCV001x1gtIpxJcFmIOhL/mM+KGYuTKNFaOMOfaHVwoLFdKPkasQGBAes9J3pl/ZkNILCf4qiqQW5QziPwlgx6mbnWqRwGsNR6xVp8nVv5MwVl4ibogZ0V+Z/U/SmUvg4LbI4KTehkLeZ0DvuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682815; c=relaxed/simple;
	bh=SZxVqnlDX2ext6XsnMSa9oxc/oNLkxgT2g6Ecz705Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgJ9/+VCyIZCOB+PKLJaeHOYJi/j4qLfLKxf74k7FY3b65k4RSh9hET3SxEvGd2wS6hC1Q7wjDVpdx9gIwEmJq3RRjvXLEWFUU2l6MUhyEkjkmftgFCTF9FQ5RZho03lWr0oRat8WMbJpb4dPJonuPhmOaCCicF6bp7j+n7jmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxQ9oK7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD560C4CEC3;
	Fri, 11 Oct 2024 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728682815;
	bh=SZxVqnlDX2ext6XsnMSa9oxc/oNLkxgT2g6Ecz705Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HxQ9oK7hPngDKk7UnUIzPWT5AGxRp8Tc2PsHxivbWXIF0mhnNiUU/6NtZNxHujk5c
	 1ANqY/fh44B94A5a73/fay+MM8KOzaiVCouI4yuZNEvEd109HVfH39TScKfEvfu4ns
	 FPAQkAvbvpyooGopDMi5fdz5f6rl3h+I/iT3PITgZsAJITEMl1TMCASaxdl45O4aI6
	 MOgmYZRVOltrZaQsSvKRUcFKKoiYLzrP2BywMVl3u0r6kHwuqyT3MDmjoCurD/ErgC
	 YKhab6HIBYko84JsUfKBkwigw+ySKS1wqjrT6kh3rMowInkJvSJB8NTwkOSNr+FMWe
	 5BL00DSVGb1YQ==
Date: Fri, 11 Oct 2024 23:40:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: mvebu: drop dependency on OF_GPIO
Message-ID: <wwxidppxcodndobastxss6whfr52wd32pmfvjipwtuk2mc6wuk@gzprx5lmfwor>
References: <20241008081555.23465-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fhv6c2jotwqhe2n3"
Content-Disposition: inline
In-Reply-To: <20241008081555.23465-1-brgl@bgdev.pl>


--fhv6c2jotwqhe2n3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] gpio: mvebu: drop dependency on OF_GPIO
MIME-Version: 1.0

On Tue, Oct 08, 2024 at 10:15:55AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> This driver doesn't really depend on interfaces from OF_GPIO so the
> Kconfig dependency can be dropped.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Good idea! :-)

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--fhv6c2jotwqhe2n3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcJmzkACgkQj4D7WH0S
/k47nwf/cMUJUngDiDJMPy2QJn+mY4euKI6XuuIMYVq6BHKnhLqaY17ZLT48cIBg
YUa9BgcPzjfXBquAjr/e/nOg+Kd1eGcYgWhjS4r7AlfIwok6yNDlR4kqqqcb07rG
4ZWz2wgC4aq2hr1baB4MlhusQkWZ8B72mIrPrnMUA7K0hsPhRcsNI5yJT8iN/XQa
tDaCmooeQbvYBbaJQsjqtYiw1IUTJkQJUSn7cONAFEZyajG5XMukKFEsKZb/RhKG
f2LGYOLmsZpjhwNgXgYBzUr+T1MdzdkOTXlYXEwcKNiAf9OKFxc3C/3FPUnISv0v
tG+1Ei1aZiXUzLhmjxV07dX05cROgw==
=/vwq
-----END PGP SIGNATURE-----

--fhv6c2jotwqhe2n3--

