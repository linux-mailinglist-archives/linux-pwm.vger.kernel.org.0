Return-Path: <linux-pwm+bounces-7108-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD21B2D420
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 08:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371D31BC1778
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3252C11DB;
	Wed, 20 Aug 2025 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKiSnQBz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E52BCF46;
	Wed, 20 Aug 2025 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671813; cv=none; b=DkP1oBGkBdVCQNWGoYQgNCdm+nZEWZY3kq2mgnXCaQE+dOcqN1hVYlx32I4jaH0He3AB8E52MKcqCzf6F/h3c7WvH56dmbWm6CvLJHa0asRueWalx4zEMLuzRrARWz4cn6YcfOpawRP1egh10fmFUQgBzin8RWig/fTWZmD/kHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671813; c=relaxed/simple;
	bh=TeGFxK/Ez1DRQ5tHv+mVdHsV/wFNg/VNTD23hQjdB38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpJWEFuv91y8pY8w+OYr/9iWzsQjyAuQGbLZCLcdi9TjUoIYjINTHqDgoNp9rHhIm2+P6/EphA04bIX6EHROQ8hdOOs7kbbmqU2Hz6g4VtngN4gb2LS+0hXsa8UOxfdOWwh81ttk6/NoJK1Y2IZdWxJ8UVGxaNoVcI6s9Uottg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKiSnQBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3C7C4CEEB;
	Wed, 20 Aug 2025 06:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755671813;
	bh=TeGFxK/Ez1DRQ5tHv+mVdHsV/wFNg/VNTD23hQjdB38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKiSnQBzMiyijiIpvxJRXGfhK+fExTGQPeuJFGoZdbWb3GGXbWg/OIAeCabn1AogF
	 kytxO1Lexl/+P/IvOtzeKi2C7CcANrbsgEHWVuvPC9rD8Ym6Qpu2wyLfKHb9A0obnT
	 mdY2GxzsXuPP5r5x6AnIC7QuKlYB9gyUAFLxj5ayV+S5IWkkW+geGQ2Qhh2yJOzqBf
	 JE3JVpbc1ySxGkGKZQkOWrclLzjzOTK6JV5UcAmGU4pz3k5vq6A6jNNfrER3s1RxhA
	 jGXMulUlGIyOIXA/wowa/WsjvswAPneSSqowy2aKCsQHN+Xtw7uGe/G3z7Eg+q14zZ
	 V9fpqZAYP2BlA==
Date: Wed, 20 Aug 2025 08:36:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, linux-pwm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
Message-ID: <bssxtcjtp4pnt3cymcrqnuwdzgdhwk5udnqwsh3xvmo2kkd567@5ovlk34bb4or>
References: <20250816104904.4779-2-xry111@xry111.site>
 <n5kdswq7oduruqiruyup4rcdwrs76tlinz26swotzeqklterey@off5cbv5i4e5>
 <CAMpQs4LqEWSoMUZpcbyknuEvf48FMMgra+Jffk0AXvTiZYjANg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltoph65fy56dym4s"
Content-Disposition: inline
In-Reply-To: <CAMpQs4LqEWSoMUZpcbyknuEvf48FMMgra+Jffk0AXvTiZYjANg@mail.gmail.com>


--ltoph65fy56dym4s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
MIME-Version: 1.0

Hi Binbin,

On Mon, Aug 18, 2025 at 05:38:34PM +0800, Binbin Zhou wrote:
> On Sun, Aug 17, 2025 at 6:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@k=
ernel.org> wrote:
> >
> > Hello,
> >
> > [adding Juxin Gao to Cc:]
> >
> > On Sat, Aug 16, 2025 at 06:49:05PM +0800, Xi Ruoyao wrote:
> > > Per the 7A1000 and 7A2000 user manual, the clock frequency of their
> > > PWM controllers is 50 MHz, not 50 kHz.
> > >
> > > Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
>=20
> I have confirmed once again that this was indeed my mistake. Thank you ag=
ain!
>=20
> Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

Thanks for your confirmation.=20

My gut feeling is that this isn't very urgent and taking this as merge
window material for 6.18-rc1 is fine. I still applied it to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes
and will send it along if something more urgent pops up. Please tell me
if you think I should bother Linus with it and get it into 6.17.

Best regards
Uwe

--ltoph65fy56dym4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmilbP8ACgkQj4D7WH0S
/k6ZpQf9Gro+45aCGD4VgKF8IHEQrHPJH/F5jDeR0xmms1/pEbPYPS9CwZaq/af+
+TM+yJHbf2+WwHEPO8uloJMssgdC0UBnnsImLGRhXbB7QGCR8w5yMT5iCuCByIWi
oDXynvnKFVSQ3whPPG/7FeFNI/wHf5vCIrEfkKDvUCzN1XTzlwDnaV3VmIdSZ08/
/8klPqCyemsC2K8GIzSJbVu4Fkqt/wUIy34aVD91sMUxmyMm3o33h7ofs04TtO51
WQHd91h1m1DpuMKXUt9RZqvrSfmwDUtxz0+BIjYadCGhwJ6xCF8g8FZLhOsqdSe9
zgfbnJmyOWy6ADB/k9k06bUcAuokjA==
=pW4U
-----END PGP SIGNATURE-----

--ltoph65fy56dym4s--

