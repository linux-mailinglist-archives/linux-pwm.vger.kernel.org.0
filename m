Return-Path: <linux-pwm+bounces-7891-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF50D10D8A
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 581963005E9D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 07:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7432E6BA;
	Mon, 12 Jan 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRXnCK5X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94CF32E154;
	Mon, 12 Jan 2026 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202564; cv=none; b=YdZEQWHZCv57o0qxPCyhcuMlZEAOhOJlcvbhvlGsCzthOFug42tcHkmbqh7TwJX2/LqubPn1UFIwSL1ySOWuSaBdfj8ysT7Pf84HOcmOqp+zQaJaR0N9G/7kVS9LflV39D3VdbDFqMm4hHMPCpMjt38TN5vxidxZ2kznUBOFPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202564; c=relaxed/simple;
	bh=buaUr5EX7Q02jMTZFrrc6xTSzsJLr9E4gxPFi8ZXJmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3Q1iNtQ8AFB5yYR1P9To86I9YBUOOOp5i/EYhzHrySu/p2nIm4zYg5s4voETqYz0Xbn+I1bIMd4HLTbuJjb7FLX+xGAnh9C7hDYY67+VQWIDtpHuMzgmNcOiSbwWKlgUyllSt8O5Tulmtv6eaU5LdMKiZOFV5KTHuc/KF8bEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRXnCK5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039CAC116D0;
	Mon, 12 Jan 2026 07:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768202564;
	bh=buaUr5EX7Q02jMTZFrrc6xTSzsJLr9E4gxPFi8ZXJmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRXnCK5Xl4t/YvMPOF2YGkPC1kfZ3Db+9t13/Hp4AIbhsc3oYPDBbo7fPOa8jj7P/
	 rKdiQf9TL8sHRac/wdZ45nlXKL0G4OoGdgN0SgCo2Wq0M60KgaX7+0fvoCkodS1rde
	 TSnRrRSZiGqEmMkeMXD3vNr/BUXJGePk6sMxeZ+18c4kGNZ5hpSUg/qXTQ0rEFPPWN
	 PdFa7jBD9+Dv0pc5kukdp/quNBYtMQi8HMUwbLUR8YIcLSQ7aFEMUB9NQF0EJBoswe
	 tHeUbNR/E8CB3jGBGOHF8h2LNWy+yJTmaaH1xqRXh2jk2N9t2zjc3H2l0CB0vo5LUM
	 MnIo+4Vs9lzhA==
Date: Mon, 12 Jan 2026 08:22:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, j-keerthy@ti.com, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, n-francis@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <hvz5lw4xvujmdruoi2h2wk4dvanyg7y5xp5tp2rs4dygmza3s3@idcjbz6wbxh4>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
 <741ec8db-7804-4f31-969b-10724ec06823@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="77pt5nw3ug6fy26r"
Content-Disposition: inline
In-Reply-To: <741ec8db-7804-4f31-969b-10724ec06823@ti.com>


--77pt5nw3ug6fy26r
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

Hello Gokul,

On Mon, Jan 12, 2026 at 11:21:50AM +0530, Gokul Praveen wrote:
> On 10/01/26 04:23, Uwe Kleine-K=F6nig wrote:
> > As I cannot reproduce the issue, can you please check if adding
> >=20
> > 	pm_runtime_get_sync(pwmchip_parent(chip));
> >=20
> > to the probe function makes the problem disappear? Also please boot with
> >=20
> > 	trace_event=3Dpwm
> >=20
> > on the command line and provide the content of
> > /sys/kernel/debug/tracing/trace after reproducing the problem.
>=20
> sure Uwe, I will try this from my side.
>=20
> In the meantime, will you able to test the same on TI J784S4 EVM as the
> issue was reproduced on this board.

I don't have such hardware, sorry. The boards with TI SoC on my desk are
only a Beaglebone Black and a BeaglePlay. (And I didn't setup the
BeaglePlay yet, it was already quite a hassle to make the boneblack work
with a recent kernel. In the end it looks trivial, but
https://salsa.debian.org/kernel-team/linux/-/merge_requests/1777 plus
unreliable netbooting in the bootloader took me several hours to sort
out.)

Best regards
Uwe

--77pt5nw3ug6fy26r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlkoT8ACgkQj4D7WH0S
/k421gf+P2KRwsEYMQilGQVJQCilUGvD8/MZ90CKMmCPRNyxe/mgZ/3NRhWaEHma
YM9kemIep3behwLWXhGlqf9mVDXZxinUYhR6grkQLn4F86skEzCMNSBcdnO41Kqs
i3DELQHeInolzrBMK6n4hQy2Z2upOsgGv7lH224wVxgop27FETcB22M9Ljz5wwe9
nB7+V7elsy4VRNbUwg8ZUJD3WW/+JF2UD8bjMDT1f6mz9YBRB2oQiX7d+e0LY4D/
QOu3Xn95PMjcssEAUXJn3M0g1DfS6SqurekIFEBsPr9jTfhA7gdo6RcqfVfDeTIq
fWkTWyFKhDni7o81SJDiE/em24VtDQ==
=a+w5
-----END PGP SIGNATURE-----

--77pt5nw3ug6fy26r--

