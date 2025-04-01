Return-Path: <linux-pwm+bounces-5313-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE9A773DD
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 07:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE73188E19D
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 05:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46771AA1FF;
	Tue,  1 Apr 2025 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9H7O+hF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941604685;
	Tue,  1 Apr 2025 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485163; cv=none; b=XYNU2C70PC1K9mdWlGYMxvXczJAvhdRr5RLL8MhfOfYxk3sQpt+oxfgyrfPfriGuCkCcz+LQtGGHKqDgcGai8/8kgT6hw/fK3C2hSEZmrYDtf1dPCaP53XS3Wr7kpNuMCenTd1704WjUwvSzsEDnFFVYucDziaUlQ7t3SfJm0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485163; c=relaxed/simple;
	bh=WPMKUmMlk/0erHuslXvW1bTGXVxmsUG+iyQ6kSaAjUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEG0X4atBh+HSAfBXjH17kjdFwXNxHCwIOh5fNw41in8kMOhHvRanZ92122hunHkYT13XqqdaIuP7SV68F5WI/Vv+bw0LGpXSLkfyLWASPWZm1K6EuStDg6OKP7QxowFgxyv2MI8r+j5yTv1HbHe7zv8zTe+ydruBAFkFTza+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9H7O+hF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B72FC4CEE8;
	Tue,  1 Apr 2025 05:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743485163;
	bh=WPMKUmMlk/0erHuslXvW1bTGXVxmsUG+iyQ6kSaAjUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9H7O+hFdZHQHJxg8+1uA+JF+wv+cbYyeJHNhSJAAyiEHr3kYpX4DDm7Ka28nCEU4
	 l5Yy6p6W/sXGwdn0ka3cMi8G1/EH+Kp7zn0SHmumdnYYLeToC3TGZ7CU06rJYD+6EM
	 RsG6KoLWBXzIwVbkHUcGNwTi142TEE6WL3uZBz9G3C4Uyy8XgbUfGdIh2p6jiMuREH
	 SNV1PpEV2SO5OsY4TKGAnXW5Y1NQZRqmntbdnhLNMsnrjb9ZIb5+jgSqOOigZjpaE1
	 Csm6XXoCaZhnjA+iz0KHvKQ77pWtmyVyJEpg6xLPBq2n3OHu0yXtau0QPyNTd+ibEt
	 eZ+TN6YMdZ3sg==
Date: Tue, 1 Apr 2025 07:25:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Juxin Gao <gaojuxin@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 0/2] pwm: Introduce pwm driver for the Loongson
 family chips
Message-ID: <klmvpb4j3gxerivskg5eo2err4zrrs5tn4nxlwj2ngedg3vf2r@mgl22dvudeyy>
References: <cover.1743403075.git.zhoubinbin@loongson.cn>
 <zfdhcdy27q5dhaezc22bmx3dnmn2avazsfbpsd4k5lyjikmxnd@dsdbbokjjjag>
 <CAAhV-H5Ter6jYObtffAU_ixUy97UQyU13YRwKcE__hZAPZG5vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6kwa3kyw2w77eklm"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5Ter6jYObtffAU_ixUy97UQyU13YRwKcE__hZAPZG5vQ@mail.gmail.com>


--6kwa3kyw2w77eklm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/2] pwm: Introduce pwm driver for the Loongson
 family chips
MIME-Version: 1.0

Hello,

On Tue, Apr 01, 2025 at 09:28:25AM +0800, Huacai Chen wrote:
> On Mon, Mar 31, 2025 at 10:52=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@=
kernel.org> wrote:
> > On Mon, Mar 31, 2025 at 02:53:48PM +0800, Binbin Zhou wrote:
> > > This patchset introduce a generic PWM framework driver for Loongson f=
amily.
> > > Each PWM has one pulse width output signal and one pulse input signal=
 to be measured.
> > >
> > > It can be found on Loongson-2K series cpus and Loongson LS7A bridge c=
hips.
> > >
> > > Thanks.
> >
> > applied as v5.16-rc1 material to
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.=
git pwm/for-nexxt
>=20
> For v5.16-rc1? Maybe v6.15-rc1 or v6.16-rc1?

Huh, I meant v6.16-rc1. For the current merge window it's already too
late (and for v5.16-rc1, too :-).

Best regards
Uwe

--6kwa3kyw2w77eklm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfreMcACgkQj4D7WH0S
/k4hoggAq8l6Fjt4vphYSQD3C0V5rGYO1/FqSbgnPsMpNAGyzqc2xJFu/p941qLN
7DuGq7y0L9mAraVGUiQ5jzY3pNJu3eAKxNdBti7CDB8P78nqt+yturSjumWuNY8/
jayQe3r2zQfLUaUBt7Kx7Ue1jxhB3JBeYh3PVdPNMlKm1apLQTzVJwTnoQqnfPuU
m+EeVS8Qo+I0OxjL9lJJxe58d9/5qfQ2bOMERr6lB7K7Ub3wwtiMm8wCcqxtLRdK
jc8e9XddtK7ZFfkhw9g2ftwfSulgr4vypNfQFikWdCETjUVYemqvT5RIMpASg+1h
TiovqLfFJY0WjNXqTHdNmPuElLLKPQ==
=sogg
-----END PGP SIGNATURE-----

--6kwa3kyw2w77eklm--

