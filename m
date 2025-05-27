Return-Path: <linux-pwm+bounces-6150-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E7AC5056
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82023B1D26
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ED82749D9;
	Tue, 27 May 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6p04V9O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4A13A41F;
	Tue, 27 May 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354228; cv=none; b=nhVjE6Mcg7Pa7XpSCy635suCL9IP2GLcC5kYiMRGsW88WNi6oX2Fd390nuYojZS1TTCzvKvZCZgACE3JvH/1m9l932ITusBnmoeWA5w8NHDc/CXzMKnfucy6xgr241fhMaFvxaAO2ACsWJ8ZgjKEl1QPsuNOhAaR7ymrCixn3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354228; c=relaxed/simple;
	bh=sWjTd1b4saAt0goojyaoXWF5Z91e7Gpdg64+FdJRQdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFcQvcRbHANlF8HAlRxXQ6hi7liqhX978BlHg9Ag66cF7+N3HFrDpbR0WnHx8In51YCAburupu8Ov03BtEafKkw1ZV+vlSE2MaFRYr1NBwKG7uA09MUPAztUJD4wfbDTlFqgP2kmmXh0xB5oYX7dC9ItKaoMer2HE3XOmp6e/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6p04V9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CF8C4CEE9;
	Tue, 27 May 2025 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748354227;
	bh=sWjTd1b4saAt0goojyaoXWF5Z91e7Gpdg64+FdJRQdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6p04V9OH+I6LP9PFnOQd04QlUaLSHclDi8RwzQnPa/ZoYB3xTIINen5RcI5pZzP/
	 /A51/Up3p/o1dhnrgXkSGn/cqIsCKpiwLUlGVWYmbpFQ46jjJDNwHBkarOzjv6/8hq
	 MHm2Ba7DW3CgKo0t0RdJ5aVQ4QSccBwD1+SnIMPv73rKC+297u2I2gsq+GWTiFIh3n
	 z9u3az4G9eX/oSt1ro3XQaNZcQtZF3IVZDCLmdkFWbIZjseEYWykQD4sZbXiqYARKr
	 R+mpP0W3DF6FGH1IbM8u+NdObThTmQtgb/3a9phecV4UZOw11wmK323sF9S5ae8O3G
	 0s2jkagEOzKFg==
Date: Tue, 27 May 2025 15:57:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Michal Wilczynski/Kernel (PLT) /SRPOL/Engineer/Samsung Electronics" <m.wilczynski@samsung.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <3qdplpa3w2uxq7emonc4tufr4mae3xelk4habdhfvuvw5vxwe3@qdyu4rkeobhd>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
 <aDMHEcpJn8nyJHFV@pollux.localdomain>
 <db8e34c9-daff-43d9-b79b-8ec1bc98a00f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rnawmuhzlrg5qj6b"
Content-Disposition: inline
In-Reply-To: <db8e34c9-daff-43d9-b79b-8ec1bc98a00f@samsung.com>


--rnawmuhzlrg5qj6b
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
MIME-Version: 1.0

Hello,

On Tue, May 27, 2025 at 02:44:57PM +0200, Michal Wilczynski/Kernel (PLT) /S=
RPOL/Engineer/Samsung Electronics wrote:
> W dniu 25.05.2025 o=A014:03, Danilo Krummrich pisze:
> > On Sat, May 24, 2025 at 11:14:56PM +0200, Michal Wilczynski wrote:
> >> +impl pwm::PwmOps for Th1520PwmChipData {
> >> +    // This driver implements get_state
> >> +    fn apply(
> >> +        pwm_chip_ref: &mut pwm::Chip,
> >> +        pwm_dev: &mut pwm::Device,
> >> +        target_state: &pwm::State,
> >> +    ) -> Result {
> > I assume those callbacks can't race with pwmchip_remove() called from d=
river
> > remove()? I.e. the callbacks are guaranteed to complete before pwmchip_=
remove()
> > completes?
>=20
> Yeah this is my understanding as well - this is something that the PWM=20
> core should
> guarantee. Fairly recently there was a commit adding even more locking
> 1cc2e1faafb3 ("pwm: Add more locking")

I confirm that starting with that commit pwmchip_remove() and the driver
callbacks are properly serialized. Before that this an issue, even
though it was hard to hit. (Because if you triggered the callbacks via
sysfs the locking in sysfs code implicitly worked around the problems.)

Best regards
Uwe

--rnawmuhzlrg5qj6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg1xK0ACgkQj4D7WH0S
/k7AoAgAgE6kPJ1bWcoaVzz4NG5KVOPDcjUi7+v9I5B79DFiy/xRcsUpAci8rFOd
ndfUs3BSC7MNhbGn3TqPLdHFu13JlfAM8SiaomyGJY//cFZyLYea6eW2ZSBFA8ja
NQH+C3AEG3OjnOgVQ53AcGR85thfg/hpk08UV+rWZ70xC9s6nFZZO3xn0r6sjCdr
3ETCq0a9KPvv3BrAHBGEmTD3+dsEgPFWJqje7I0+FUheZzqwn/M4OqmU5t6SMbL4
NGFc6KEWx6747Do9zqL5qKcIiDKqVlebkcYSPalO1epD4cMgSLKop259dBGIGKYF
cdg6otbdDgUaWHNIiPNAyvpYlpgEsg==
=IUKj
-----END PGP SIGNATURE-----

--rnawmuhzlrg5qj6b--

