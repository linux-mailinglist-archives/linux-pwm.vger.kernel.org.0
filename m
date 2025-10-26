Return-Path: <linux-pwm+bounces-7490-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48DC0A668
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Oct 2025 12:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF0347CF0
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Oct 2025 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E941E0DE8;
	Sun, 26 Oct 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V73ECIo6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A935B15F;
	Sun, 26 Oct 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477329; cv=none; b=lmddgVrvhsVGrTODM6TYTsiBFaRORxRIql59/8ClPsj2jI+PlWTyB6uFFboAOfUu10oKPgU7gO4xICZEG0ETXGYKsXDA+0X3+Rrv5Kcp6gqHDoF1HBPswa+9nRvv5mSWLZs+jBR9rJNg9IjFIyiZmXAk2odQI2elRxUI3Xa4uzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477329; c=relaxed/simple;
	bh=HTruYLUWVQCfi6SQXupL+CrOSj/QbB/ZlLpAIxMdvc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9j9jsjJPdl54+jrvKTH0bGY2tDuyLK47QEweI/dwlhcivXj7cj1CfE+ZPGSMmts42pWyUP743U7vJAKI50jIjxOCgmfQMCXRgendRoq5cD4C9vI1dBHAx6knfuWBSwH/jkmcd+7eJgOhy6G8A0lkfvM2CkNrORg02u8JlDev1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V73ECIo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85FEC4CEE7;
	Sun, 26 Oct 2025 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761477328;
	bh=HTruYLUWVQCfi6SQXupL+CrOSj/QbB/ZlLpAIxMdvc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V73ECIo6/qSjkcuLQGkEL6W2kesEMvM5bq9FRp1XGZVv8NiaM51qu6ldc7Qa7vdvc
	 QJVQt9rj0VGjJ3Gy3dSKM/SEQYNY2ZVaFbdLfK5gSkqtH/e31tfIa2Rts5siCzxzY2
	 ++KB+9gshe03RFO46IUNzIOpfNKG0z9tBnh15KrhE15ArshgIv8VfX2wL6hfdn1agY
	 kmtYZdQIUfFd0OlrGuGHovyiPNsn4FBP+UVcqgaB78lsKFzT5RHt7KeltqIFW5L/w5
	 d4NJwYQAuy/80sybUdG1hW3Tkm1eeo6/OMK4nyehaVTtqfQnPdokN35ICwjgd2KVLs
	 Dwqb+gBXVPLBA==
Date: Sun, 26 Oct 2025 04:14:50 -0700
From: Drew Fustini <fustini@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v16 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <aP4CqqOL7xEyFZ0w@gen8>
References: <CGME20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e@eucas1p1.samsung.com>
 <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
 <47ut33rck4xoh3d7d6t3d7twqag3u7eusbruc2i2veqf2umpga@ipamilvshysw>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hu0VeUTprsM8C7Nl"
Content-Disposition: inline
In-Reply-To: <47ut33rck4xoh3d7d6t3d7twqag3u7eusbruc2i2veqf2umpga@ipamilvshysw>


--Hu0VeUTprsM8C7Nl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 02:26:31PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Thu, Oct 16, 2025 at 03:38:00PM +0200, Michal Wilczynski wrote:
> > Michal Wilczynski (7):
> >       pwm: Export `pwmchip_release` for external use
> >       rust: pwm: Add Kconfig and basic data structures
> >       rust: pwm: Add complete abstraction layer
> >       pwm: Add Rust driver for T-HEAD TH1520 SoC
> >       dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
> >       riscv: dts: thead: Add PWM controller node
> >       riscv: dts: thead: Add PWM fan and thermal control
>=20
> I applied patches #1-#5 to
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/f=
or-next
>=20
> . If I should take the riscv dts changes, too, please tell me.

I can take them through my thead-dt-for-next branch.

Thanks,
Drew

--Hu0VeUTprsM8C7Nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCaP4CpAAKCRDb7CzD2Six
DFmwAP0XV04YlT43vkUJmO2Q22KkuSgNzqJMOqSjgRNYzlZG8AEA3UwESVtDL40X
5JE1LibqO78mAkoeDlA3Gy1lXXPr8AE=
=4yF3
-----END PGP SIGNATURE-----

--Hu0VeUTprsM8C7Nl--

