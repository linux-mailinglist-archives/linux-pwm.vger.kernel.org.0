Return-Path: <linux-pwm+bounces-7876-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C6D03D12
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3CC130577B5
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1637F0E2;
	Thu,  8 Jan 2026 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeEyknwU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BA33D50C;
	Thu,  8 Jan 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859629; cv=none; b=QUH9q7zjAqz9UD/s36cjDG9DONWGN4j2CgkuTQytWIpODIzGM1lJgJha8y5JueUXkPII54UC7XcxVCvCeM8UUEXmj2L0/N3FHfL8u9zXop2ouxxNRNIOMixRsQvrt0yawgPaJUF9/oqXgJQ4s5kDmEydkDMwsPM+dk/hWU0Jdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859629; c=relaxed/simple;
	bh=orNWLfTHlAJ8gkhDTh1n4hji8OdYk3V3gHzDCeOjTCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWkVTM9x4UJLBk74eWDQbzyeMDxEmnFKaRYcXx4XUmrChLWtNmkxeR72/ZFT6IiEc3l/KnA3VCPIuENrsxSJnByShzqVGNIzDnHn7rbq1Kwu7MOCm59NIbZWUq+SMEuS/eQZJTYVWYX77DImQL8n2mPH8VTpToNNWzJIVNivsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeEyknwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A411C116C6;
	Thu,  8 Jan 2026 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767859623;
	bh=orNWLfTHlAJ8gkhDTh1n4hji8OdYk3V3gHzDCeOjTCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeEyknwUpcPuDGpjDkP5veIYOk0/yLzmXC9vcfaqfkIUQGTdf55Ic5EjmJuv/k+7Y
	 3o9+KTw2usDH1fiyOaK+rh9FomzW5QedExkQaTUWPtd9EaHfpzZuoeniqvpxPo5zYl
	 2e3w+n9klI1M4pnzEuv6sR4Ka+fCApWvYV+WakcOkc5n/Ae3jGX4mIM7u300WeGDGm
	 siMAl5+y1sWHvfvtlD3bR0uefUVbbUWceP5cb3yDu6qLK7gNCTe0gbQSc95O5AM917
	 0X8opl0h+IMwTQ2G92GKSQA1RD9+gBvuR7cHEz0KVPJZKACY2wf9qp9C0rGWT/moPA
	 cN7Kx0cKvpCqA==
Date: Thu, 8 Jan 2026 09:07:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260108-delectable-fennec-of-sunshine-ffca19@houat>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="k6t6konq3lslf4xs"
Content-Disposition: inline
In-Reply-To: <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>


--k6t6konq3lslf4xs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
MIME-Version: 1.0

Hi Daniel,

On Wed, Jan 07, 2026 at 12:09:52PM -0300, Daniel Almeida wrote:
> The current Clk abstraction can still be improved on the following issues:
>=20
> a) It only keeps track of a count to clk_get(), which means that users ha=
ve
> to manually call disable() and unprepare(), or a variation of those, like
> disable_unprepare().
>=20
> b) It allows repeated calls to prepare() or enable(), but it keeps no tra=
ck
> of how often these were called, i.e., it's currently legal to write the
> following:
>=20
> clk.prepare();
> clk.prepare();
> clk.enable();
> clk.enable();
>=20
> And nothing gets undone on drop().
>=20
> c) It adds a OptionalClk type that is probably not needed. There is no
> "struct optional_clk" in C and we should probably not add one.
>=20
> d) It does not let a user express the state of the clk through the
> type system. For example, there is currently no way to encode that a Clk =
is
> enabled via the type system alone.
>=20
> In light of the Regulator abstraction that was recently merged, switch th=
is
> abstraction to use the type-state pattern instead. It solves both a) and =
b)
> by establishing a number of states and the valid ways to transition betwe=
en
> them. It also automatically undoes any call to clk_get(), clk_prepare() a=
nd
> clk_enable() as applicable on drop(), so users do not have to do anything
> special before Clk goes out of scope.
>=20
> It solves c) by removing the OptionalClk type, which is now simply encoded
> as a Clk whose inner pointer is NULL.
>=20
> It solves d) by directly encoding the state of the Clk into the type, e.g=
=2E:
> Clk<Enabled> is now known to be a Clk that is enabled.
>=20
> The INVARIANTS section for Clk is expanded to highlight the relationship
> between the states and the respective reference counts that are owned by
> each of them.
>=20
> The examples are expanded to highlight how a user can transition between
> states, as well as highlight some of the shortcuts built into the API.
>=20
> The current implementation is also more flexible, in the sense that it
> allows for more states to be added in the future. This lets us implement
> different strategies for handling clocks, including one that mimics the
> current API, allowing for multiple calls to prepare() and enable().
>=20
> The users (cpufreq.rs/ rcpufreq_dt.rs) were updated by this patch (and not
> a separate one) to reflect the new changes. This is needed, because
> otherwise this patch would break the build.
>=20
> Link: https://crates.io/crates/sealed [1]
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

I don't know the typestate pattern that well, but I wonder if we don't
paint ourselves into a corner by introducing it.

While it's pretty common to get your clock from the get go into a state,
and then don't modify it (like what devm_clk_get_enabled provides for
example), and the typestate pattern indeed works great for those, we
also have a significant number of drivers that will have a finer-grained
control over the clock enablement for PM.

For example, it's quite typical to have (at least) one clock for the bus
interface that drives the register, and one that drives the main
component logic. The former needs to be enabled only when you're
accessing the registers (and can be abstracted with
regmap_mmio_attach_clk for example), and the latter needs to be enabled
only when the device actually starts operating.

You have a similar thing for the prepare vs enable thing. The difference
between the two is that enable can be called into atomic context but
prepare can't.

So for drivers that would care about this, you would create your device
with an unprepared clock, and then at various times during the driver
lifetime, you would mutate that state.

AFAIU, encoding the state of the clock into the Clk type (and thus
forcing the structure that holds it) prevents that mutation. If not, we
should make it clearer (by expanding the doc maybe?) how such a pattern
can be supported.

Maxime

--k6t6konq3lslf4xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaV9loAAKCRAnX84Zoj2+
drF9AYCSX3uIqUt1AfQjLa/7cN8Nwjutujodf3+SeFJhjhKEU4TvJ5vdsbn4Zp3P
gCxu2cwBgM1tKFg24E7US+/7XPI5vTIBKeN1VEPwwS1Ae6qHQgg8QBB/XncYTO7y
eDii4U8VGg==
=WjK0
-----END PGP SIGNATURE-----

--k6t6konq3lslf4xs--

