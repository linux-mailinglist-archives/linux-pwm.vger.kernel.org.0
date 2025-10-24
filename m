Return-Path: <linux-pwm+bounces-7481-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB86C06A10
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Oct 2025 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D4450908E
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Oct 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD03203B5;
	Fri, 24 Oct 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdB13bXm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519631DDA9;
	Fri, 24 Oct 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314993; cv=none; b=ebCa17a2qSPmAzeejPtY0Ex2rUI14NZQwJudhapxIglmAwdQIYAp4ZXC6dQ7+NVjAYt9FIHQSn9rc3u5yZARQwHXsRcsd0pGHjKThtQJFwq9+DIQQ9/xIQelpRCZ9SScALebJ8J5PSK19FsuwuK73kBKIdxgLuA/G4W7riTKkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314993; c=relaxed/simple;
	bh=qEnNl4yAb28piqxRvBDsROmZ5MOV09FzzL0cqQOOLgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etJDPElxSAN6Nik7PLov29vNmAsUEpVf5faOsmlvmIjIkinotG0ezExAWL/VU+9S4uWALXWtLanJE6LV3mF4hWTBCkJbD6z5s/q69ID+gSGZtbythD1u3EyfJmlaqBOFrWwEuihvelV0tHaEVc4Tr8MPwB7vJMkru0GnMsyEtEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdB13bXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9255EC4CEF1;
	Fri, 24 Oct 2025 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761314993;
	bh=qEnNl4yAb28piqxRvBDsROmZ5MOV09FzzL0cqQOOLgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdB13bXm15bW8P4kG+yyeBVSDJMp30yf5dz0qvSutbcf+82PO6jgm69hKRwpcOweG
	 XDllLkMdF44QQH9QAoIh6/ZB7wGDBP/TFZ73itifaGkr+T/Rpvqg3fL98RnHv4xgmX
	 kFoPJWBcr3QfBq1eY1ZJO53o+OYWdWEuNTIkP4N9vms89VxF1vaQZWaSVLX2yAUBH8
	 MtdWWlC9gXNSHeF5vEs8KRGyce2aB/qvk/INGHwKeNE4TC8Diec89ExuLIbVYxOvSm
	 ATapuCnGUWVpXB18xcpeeIIKXjVlUQ9YLINfJoHltzohyjhBTRTpg1h3HFZ1sD70S4
	 wLc1/qYBgVQBg==
Date: Fri, 24 Oct 2025 16:09:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Benno Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Drew Fustini <fustini@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v16 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <p5addblaeofj6xdbgmvrknoozrxh75lsle6uqh4g2qku745ayw@uls3uoftpmuw>
References: <CGME20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e@eucas1p1.samsung.com>
 <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
 <3f9ab01c-470e-48b5-a309-71325ecc4906@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5lrbho5664iqhra"
Content-Disposition: inline
In-Reply-To: <3f9ab01c-470e-48b5-a309-71325ecc4906@samsung.com>


--s5lrbho5664iqhra
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v16 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello Michael,

On Wed, Oct 22, 2025 at 10:34:42AM +0200, Michal Wilczynski wrote:
> Since you mentioned last time that you were happy with the code, would
> you please consider picking up this series for linux-next? It would be
> great to get it in for wider testing to ensure everything is solid.

I took another look, and just being able to compile and understanding
very little Rust, I came up with:

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 79fbb13cd47f..c8f9f5b61bfa 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -15,38 +15,7 @@
     prelude::*,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};
+use core::{marker::PhantomData, ptr::NonNull};
-
-/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.=
h).
-#[derive(Copy, Clone, Debug, PartialEq, Eq)]
-pub enum Polarity {
-    /// Normal polarity (duty cycle defines the high period of the signal).
-    Normal,
-
-    /// Inversed polarity (duty cycle defines the low period of the signal=
).
-    Inversed,
-}
-
-impl TryFrom<bindings::pwm_polarity> for Polarity {
-    type Error =3D Error;
-
-    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Error> {
-        match polarity {
-            bindings::pwm_polarity_PWM_POLARITY_NORMAL =3D> Ok(Polarity::N=
ormal),
-            bindings::pwm_polarity_PWM_POLARITY_INVERSED =3D> Ok(Polarity:=
:Inversed),
-            _ =3D> Err(EINVAL),
-        }
-    }
-}
-
-impl From<Polarity> for bindings::pwm_polarity {
-    fn from(polarity: Polarity) -> Self {
-        match polarity {
-            Polarity::Normal =3D> bindings::pwm_polarity_PWM_POLARITY_NORM=
AL,
-            Polarity::Inversed =3D> bindings::pwm_polarity_PWM_POLARITY_IN=
VERSED,
-        }
-    }
-}
=20
 /// Represents a PWM waveform configuration.
 /// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
@@ -89,22 +58,6 @@ fn from(wf: Waveform) -> Self {
     }
 }
=20
-/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm.h=
).
-#[repr(transparent)]
-pub struct State(bindings::pwm_state);
-
-impl State {
-    /// Creates a `State` wrapper by taking ownership of a C `pwm_state` v=
alue.
-    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
-        State(c_state)
-    }
-
-    /// Returns `true` if the PWM signal is enabled.
-    pub fn enabled(&self) -> bool {
-        self.0.enabled
-    }
-}
-
 /// Describes the outcome of a `round_waveform` operation.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 pub enum RoundingOutcome {
@@ -164,13 +117,6 @@ pub fn label(&self) -> Option<&CStr> {
         Some(unsafe { CStr::from_char_ptr(label_ptr) })
     }
=20
-    /// Gets a copy of the current state of this PWM device.
-    pub fn state(&self) -> State {
-        // SAFETY: `self.as_raw()` gives a valid pointer. `(*self.as_raw()=
).state`
-        // is a valid `pwm_state` struct. `State::from_c` copies this data.
-        State::from_c(unsafe { (*self.as_raw()).state })
-    }
-
     /// Sets the PWM waveform configuration and enables the PWM signal.
     pub fn set_waveform(&self, wf: &Waveform, exact: bool) -> Result {
         let c_wf =3D bindings::pwm_waveform::from(*wf);

Does that make sense?

I consider applying your series and put the above space on top, to
create my first Rust patch :-)

Best regards
Uwe

--s5lrbho5664iqhra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj7iJ8ACgkQj4D7WH0S
/k6hYQgAhlp1k8GnQOshRf5MFOCWXtHvmPFyzN7GPGmVJw3NHwuKc4Gzrp7Y+B7Q
ZMh/RD1laNttxYcKljd1THglHWTj49XvkzVVLw1sZ6V+iMYJefsYGQuWl60Y/pJV
AW3tZtwOl0ea7cS1kyif7QvpobCTQVlIfs/mE2z5BxGvNPJIHFR/bW3a1m0hzjyM
Nz3s4s5LKStwW1EZVpFVaW9YBTvlsbuPdOK+KbeoITs3FQW4+wpRGk5Cm8qNFbAe
LaK06/87BrDvVpkHCuBNRwOGDucMxjf1CaQ4Ap/QZ/Pc0yh6ha46yv4YLxPDJwuu
q+rdvj7mq0Y3w4nlQi9Ui0FUKQadkg==
=trqv
-----END PGP SIGNATURE-----

--s5lrbho5664iqhra--

