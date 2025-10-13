Return-Path: <linux-pwm+bounces-7451-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261BBD575C
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 19:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD80F4C0906
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B428727C;
	Mon, 13 Oct 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0ik8Aj+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED7283CA3;
	Mon, 13 Oct 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374101; cv=none; b=H72mj2PVLDyf6v66qW+OkDLjOZW6fhs09wVKSmbzDVjK77hlNt2E0GZ5uh63Kg4dQP1iQooqWXXTWseGIUW4uSySG1UfI+GExXefxWtjQkmZlZx3RbwlNDiNlPQsJ2Iifg8sPo6/7GWgPuGs076Iic62WNqx6W6W9wPzundpkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374101; c=relaxed/simple;
	bh=elwGg7bAxs37xxGUqiUArj6P97nHlNxZfgLS3Wd1CyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE9mAN/ulYxkITFXtAy+l1gahrcB2KXB2lD173ERrFc6xFT/mjcZegGXfENccV8K0410boy3td2yxB9yh+3gs3Z9G9W24zDX54xEFs/4VMtojfNP8FNTts2hABZElff7Vjkps1z/ONzaShu6DcLCecCFWl05PQXN3k3MdQZahXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0ik8Aj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D31C4CEFE;
	Mon, 13 Oct 2025 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760374101;
	bh=elwGg7bAxs37xxGUqiUArj6P97nHlNxZfgLS3Wd1CyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0ik8Aj+3Zh2hpmVrK05uKhSNXSQFg5mKOv+1ewCFmP5D3O4Yc5gnx/5rZdpHsUpa
	 dWAx1WMi4mEu+Y4n9qsIi5IFrDql7U3b/ztL3E20N93kp3O+8o2vxlJiU/lYg5Zo6o
	 a90s4pErWdUT8xZ/M0L3b6us4lXWRobDbyp3DV0OXNCNSEc/QqU69m9y7K/VnrScdn
	 SZhQRZ82zsyBv08zwajcNUgzIONvqyPiMiY0qk6f/DM7crPcettPkvZhB0kuljToT3
	 JW5pvDr92ge+VIYxzr0L2tgo5UJ5C/80RUoTG8vYMUhz+93KkFlNBh2UVV0MqYlNql
	 1+x+kvSxfmowg==
Date: Mon, 13 Oct 2025 18:48:18 +0200
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
Subject: Re: [PATCH v15 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <ayuqnx7fjfe3zwicvdbdr3qsgb4w6s2gwjt7r3m5ikzrylmium@hsrxazwelnvp>
References: <CGME20250930122729eucas1p2c4f1c07a4a504a59ba691b407a39420d@eucas1p2.samsung.com>
 <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ixctn32fehw7zduh"
Content-Disposition: inline
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>


--ixctn32fehw7zduh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v15 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello,

my diff on top of your changes looks as follows:

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dd6db01832ee..e7f770ecfe84 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -812,9 +812,8 @@ config PWM_XILINX
 	  will be called pwm-xilinx.
=20
  config RUST_PWM_ABSTRACTIONS
-	bool "Rust PWM abstractions support"
+	bool
 	depends on RUST
-	depends on PWM=3Dy
 	help
 	  This option enables the safe Rust abstraction layer for the PWM
 	  subsystem. It provides idiomatic wrappers and traits necessary for

i.e. make RUST_PWM_ABSTRACTIONS invisible, it is only supposed to be
selected and there is little (or even no?) use to enable it without a
selector.

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index c9fd1d8d17bc..a5666052b7ce 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -121,6 +121,7 @@ fn round_waveform_tohw(
         wf: &pwm::Waveform,
     ) -> Result<pwm::RoundedWaveform<Self::WfHw>> {
         let data =3D chip.drvdata();
+        let status =3D 0;
=20
         if wf.period_length_ns =3D=3D 0 {
             dev_dbg!(chip.device(), "Requested period is 0, disabling PWM.=
\n");
@@ -141,18 +142,13 @@ fn round_waveform_tohw(
         if period_cycles =3D=3D 0 {
             dev_dbg!(
                 chip.device(),
-                "Requested period {} ns is too small for clock rate {} Hz,=
 disabling PWM.\n",
+                "Requested period {} ns is too small for clock rate {} Hz,=
 rounding up.\n",
                 wf.period_length_ns,
                 rate_hz
             );
=20
-            return Ok(pwm::RoundedWaveform {
-                status: 0,
-                hardware_waveform: Th1520WfHw {
-                    enabled: false,
-                    ..Default::default()
-                },
-            });
+            period_cycles =3D 1;
+            status =3D 1;
         }
=20
         let mut duty_cycles =3D ns_to_cycles(wf.duty_length_ns, rate_hz).m=
in(u64::from(u32::MAX));

i.e. round up for too small period requests ...

@@ -189,7 +185,7 @@ fn round_waveform_tohw(
         );
=20
         Ok(pwm::RoundedWaveform {
-            status: 0,
+            status: status,
             hardware_waveform: wfhw,
         })
     }

=2E.. and return 1 then

@@ -355,7 +351,7 @@ fn probe(
                 "Clock rate {} Hz is too high, not supported.\n",
                 rate_hz
             );
-            return Err(ERANGE);
+            return Err(EINVAL);
         }
=20
         let chip =3D pwm::Chip::new(

at least pwm-stm32 uses EINVAL. Having said that, I wonder if this check
is sensible here at all. pwm-stm32 does it to ensure that
mul_u64_u64_div_u64() does the right thing, but this exact issue doesn't
exist here.

Otherwise looks fine I think.

Best regards
Uwe

--ixctn32fehw7zduh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjtLU8ACgkQj4D7WH0S
/k4oaggAhdfagEFpKozser/0n1q4mr04hh5Zneh1XD8FkXH3oRpDUZVb8r4ePsFA
8VTDCq/Es7HpPe5XowvaKMybERSkXoV2ixoJFwtZx381Tdc6uqptStUKGMfzltsN
u8j6b213lzwtg9WgBM6hk+rUUzm9rzJ/Iz0VrEgGF+iIt0l7MBSInjZ+I0JDmbMu
bL6/wiWdHBVvcq+QAX4Edf3RHMX/a9s1htv/+uxWRbFf4/xRn+1gOuDBjJbTqA0j
44JY4XEZiBlBTvxMR+CiI/pq/K5ttn9kpOttYIgVfYiru6YPMLyozSLAL4zpxQDP
TRJOj1WQexbASB2Smr3Z4MgE60NYlw==
=gshz
-----END PGP SIGNATURE-----

--ixctn32fehw7zduh--

