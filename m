Return-Path: <linux-pwm+bounces-6883-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B6B120A5
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1C617B0D3
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486F42EE26A;
	Fri, 25 Jul 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QE+1rzc3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669E2EE265;
	Fri, 25 Jul 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456171; cv=pass; b=nbBdkiRWT9h0ZrZR9bFzlV3V4+qDr7puJ8uw6FA4G1pKMxDhd2GktcUj8WOQXClpaaq38m/h4Zc6iZHMQeOXDFtu6p4oXSYlI4Gk0E36kUwgV5zYze2s946cuTOc6JHSaSvuUTdC1MIjUQCu9ByqCjVZxXzqIZlDT44kRF9lPsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456171; c=relaxed/simple;
	bh=w/q7YXmYQo5hzxHYJrOKBSm8hKp1IgwuaIt41MKBlu0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MEIqWi2lcdPED8sL2Ycv2zrVZkBNHgYvl/4AIeYDPd2Qe3V54O96iqBmqPAwj+sVklf/OQP175yJ82zpoxjFblUlrgwjJDzN2Gph+ud31Pv0qllm2JTtV2InGj0zhSUWtdP8R0j1Pyzdyp5fOWs/xg5gre3msk0lBX4zaMfcUM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QE+1rzc3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753456138; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aJXR6a8q6dZxYmYb1+KpOaP5xjOrgMxKHNYdECzRR5QJmek/cfTFOY75qbIYgguq6ARPq9qJmb4qaVK8pgt56olCg9P/pqUuniPaONawvKK66N7hsTTwOEIHsNHxjIBA8rQspIl0b8ONPMWbP6wXwTvkXFCMWQ8dBMsLg2++llg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753456138; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ke+lVtmoyenH47nCVRy+b5168mhUwVX/VKLxEBmQcBw=; 
	b=QxcP3Cyfe1YTERLmahTy1qE1Yv4Xjan2hUkUenNpoutdyqp4cAoW6L76BBES14kDNwdUjXGXwZr+fNjVGJl84aSIw9N0vv5aTeQy/GBdaLVKvHmwyPNSECka0mhKzRfaIMNedBqxlm4SM+gEfTyDWwufP6tZdiyTttdThprB1ds=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753456138;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ke+lVtmoyenH47nCVRy+b5168mhUwVX/VKLxEBmQcBw=;
	b=QE+1rzc3QP2OK2xyvj5KS8T65DhKXFXbPAOd74SKmC+dyFRz0auClItJ9wuXkDUY
	nh15gCgocCehYaQqSfIphi/TeIlZG9E4O/sVW2pHDUIGpc4Yc3ZpTfkiJrkIDhcIf/1
	gqN9XK+Sqhqgzt2jjQj1SKo4jpWAqzT6a/mzbruw=
Received: by mx.zohomail.com with SMTPS id 1753456135651361.47805588339804;
	Fri, 25 Jul 2025 08:08:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v12 2/3] rust: pwm: Add Kconfig and basic data structures
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250717-rust-next-pwm-working-fan-for-sending-v12-2-40f73defae0c@samsung.com>
Date: Fri, 25 Jul 2025 12:08:37 -0300
Cc: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Drew Fustini <drew@pdp7.com>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benno Lossin <lossin@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Drew Fustini <fustini@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <437DA583-95FF-4ADF-9947-1F39D242E157@collabora.com>
References: <20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com>
 <CGME20250717090831eucas1p282ac3df2e2f1fc2a46e12c440abfbba1@eucas1p2.samsung.com>
 <20250717-rust-next-pwm-working-fan-for-sending-v12-2-40f73defae0c@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Michal,


Overall looks good, a few minor comments:

[=E2=80=A6]

> +
> +/// Wrapper for board-dependent PWM arguments [`struct =
pwm_args`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct Args(Opaque<bindings::pwm_args>);
> +
> +impl Args {
> +    /// Creates an `Args` wrapper from a C struct pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `c_args_ptr` is a valid, non-null =
pointer
> +    /// to `bindings::pwm_args` and that the pointed-to data is valid
> +    /// for the duration of this function call (as data is copied).
> +    unsafe fn from_c_ptr(c_args_ptr: *const bindings::pwm_args) -> =
Self {
> +        // SAFETY: Caller guarantees `c_args_ptr` is valid. We =
dereference it to copy.
> +        Args(Opaque::new(unsafe { *c_args_ptr }))
> +    }

from_raw()


> +
> +    /// Returns the period of the PWM signal in nanoseconds.
> +    pub fn period(&self) -> u64 {
> +        // SAFETY: `self.0.get()` returns a pointer to the =
`bindings::pwm_args`
> +        // managed by the `Opaque` wrapper. This pointer is =
guaranteed to be
> +        // valid and aligned for the lifetime of `self` because =
`Opaque` owns a copy.
> +        unsafe { (*self.0.get()).period }
> +    }
> +
> +    /// Returns the polarity of the PWM signal.
> +    pub fn polarity(&self) -> Result<Polarity, Error> {
> +        // SAFETY: `self.0.get()` returns a pointer to the =
`bindings::pwm_args`
> +        // managed by the `Opaque` wrapper. This pointer is =
guaranteed to be
> +        // valid and aligned for the lifetime of `self`.
> +        let raw_polarity =3D unsafe { (*self.0.get()).polarity };
> +        Polarity::try_from(raw_polarity)
> +    }
> +}
> +
> +/// Wrapper for PWM state [`struct =
pwm_state`](srctree/include/linux/pwm.h).
> +#[repr(transparent)]
> +pub struct State(bindings::pwm_state);

No Opaque<T>?

> +
> +impl State {
> +    /// Creates a `State` wrapper by taking ownership of a C =
`pwm_state` value.
> +    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
> +        State(c_state)
> +    }
> +
> +    /// Returns `true` if the PWM signal is enabled.
> +    pub fn enabled(&self) -> bool {
> +        self.0.enabled
> +    }
> +}
>=20
> --=20
> 2.34.1
>=20
>=20

If the lack of Opaque<T> is not a problem for whatever reason:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

=E2=80=94 Daniel


