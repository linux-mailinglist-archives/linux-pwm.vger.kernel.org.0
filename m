Return-Path: <linux-pwm+bounces-7959-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD7D3C2B0
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 09:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ED464E0A01
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48543B8BBB;
	Tue, 20 Jan 2026 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0xfAzWF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB6363C60;
	Tue, 20 Jan 2026 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898932; cv=none; b=rSDouCRkuFSgGbnC1zS040VMHLNfOeC642SlWGDSZNzjhF8X3xsNU9/rq+SMQCZKVBSykTJhVjaOVkFWACDmTwlp8HTyrmN+Qok3zfv5Q7iG/DltG0BpyZXX88CYBGSUnFCwEi3hv62CrmZMqj5C8LnefiSMYthk86w8RJLt5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898932; c=relaxed/simple;
	bh=P2f5VRfQXjNxJlBuPknRTMHoXdQiUEDYr/NdKY8/GZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTB688q+X33f6/d3mec6lv2QGTM033goLXXckCzKxukh8W1olMONgMftdd0QHApX1JI2vUDkMui6ZmRHdJOwkj5fpbXOuxjZB0YCI11alY6o8a4d9hV2/yi9puKqbyT7AD694JT7UgrMnkQeXGDdfseTsgyECnfUQe+DUi1/d1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0xfAzWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE962C16AAE;
	Tue, 20 Jan 2026 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768898932;
	bh=P2f5VRfQXjNxJlBuPknRTMHoXdQiUEDYr/NdKY8/GZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0xfAzWFO1LjHkQA5H5Nr/oMPHlXF4oL00eDIkgCyAtz78Mi0JXQ0IuWGsgqFifWE
	 4F1d7sT2HuwS5bbjfLR4PFMbDJeVuuZlqILz3c0dOILh4MOt3U5H+nUsabUa11Ofal
	 leEltVrKocV4WrDzgYGjNWltKE2Uf/lZTRgbtwCfFoKohR7EBiNlkLKKygIfXQombv
	 bS/uPTmMQZp2/QKU2PKfzlaFzGq24/X5p97uj4RpKmL+dqPwLovkZt0s+5uMEJpRs3
	 V9/GKE74f3gWpgz/I0ZPijttLMTf7GV2i1IXeX2NMD16FUFmQFf7uUDiU7/XKxz0UY
	 07AL/IEW7RY4w==
Date: Tue, 20 Jan 2026 09:48:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Michael Turquette <mturquette@baylibre.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: th1520: remove impl Send/Sync for
 Th1520PwmDriverData
Message-ID: <3cfeounnaphhezvjpz5igswml6iu3b6jhwhjn2g4ziimjdoefi@ge4ezxx6jxlr>
References: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
 <CGME20260113151335eucas1p157cd966c5f0f4e477fb11272810a0ae8@eucas1p1.samsung.com>
 <20260113-clk-send-sync-v4-3-712bc7d94a79@google.com>
 <90657b83-1cff-4c7d-adde-9b560c2be7c2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwsg2exzzhgvomkd"
Content-Disposition: inline
In-Reply-To: <90657b83-1cff-4c7d-adde-9b560c2be7c2@samsung.com>


--nwsg2exzzhgvomkd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] pwm: th1520: remove impl Send/Sync for
 Th1520PwmDriverData
MIME-Version: 1.0

Hello,

On Mon, Jan 19, 2026 at 10:45:56PM +0100, Michal Wilczynski wrote:
> On 1/13/26 16:12, Alice Ryhl wrote:
> > Now that clk implements Send and Sync, we no longer need to manually
> > implement these traits for Th1520PwmDriverData. Thus remove the
> > implementations.
>=20
> I thought this was already merged :-).
>=20
> Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

If I understand correctly this patch 3 depends on the first patch of
this series so I cannot pick it up via the pwm tree *now*. There is
another patch pending for the th1520 PWM driver, but as of now git seems
to cope well when merging the pwm's tree for-next with this patch.  So
it's fine for me if the series is picked up for 6.20-rc1 via the clock
tree.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

(Nitpick: If it was me who picked up patch 3 I would have capitalized
the "remove" in the Subject for consistency.)

Best regards
Uwe

--nwsg2exzzhgvomkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvQW4ACgkQj4D7WH0S
/k4CswgAqYG9PEeOEysrNpuhGW5U3OIozAveU6uV7f/WsAm8r9/z/awUrqqx9SsI
UuqhYcm/NXXK3TnrKeYfcU/03QiTBuwoZfyWVjwe2ZcJM0WRz0WcjRI65hmWgAIH
sG5NN32/KLyj1ITpCXRCSPEps5R1ucJYuzjRLTaTwrAzQDXT0OlEVd8vUVeHJjxW
DKuIm4QF/nBLtIq1JXv17rOqaU1mFQO3kZqYWu26GE50N5HwDDmJCflDeFVBmGpv
snGBFWLlwvMYCF+GnBxXeOQ8Of394Tt9EUP5YZhC6cktDl1zN5Y4H9DfhVgj26Rh
ZNbjBoDVXVZUlcwkA02YvTfmJcVzvw==
=Dmu0
-----END PGP SIGNATURE-----

--nwsg2exzzhgvomkd--

