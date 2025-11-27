Return-Path: <linux-pwm+bounces-7708-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B4AC8FA01
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Nov 2025 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 789234E3B4F
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Nov 2025 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155D2E7F22;
	Thu, 27 Nov 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Te3h4T5r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263FA2EA75E
	for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263768; cv=none; b=no9Qztnva8xiHiMTJK2rJrcAKN6lP/y5Vps6JiidS2cxg9XyxpUP4WIYb04WqPZHXxj1ofub2IlGXp7Qq8y2kFR1x3sLxtP9N4Rt63cKbScY69b3ZCJKNaZ6BIeW9oPKGTu1ueEi7BeMUA1G5C7do/q2yes6sRPLiJJFgxBTA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263768; c=relaxed/simple;
	bh=EYz54li0Tf5ZqItql7ljl8sa27MZ+v8IaxZRE8NoV6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKCxLFADq7898AaTzuvOhe0IjrbUyq8AQ/WqyA//cxLrqzH6sOLsJkwyDu9zWBNpwBToZvVLHJPUomdtIjNQqDJI3qXwgHzLdELPMTuv6n1M7jzeKA4lr/SsEQZNmoE9Cb1FPo9H7cYPy2ckq+D6Gh76Gz78LMN055isX63kXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Te3h4T5r; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4C88524002A
	for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 18:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764263764; bh=rxfUmP3nTEwKCwzT4rSyIQZeADS2L5/gEgSO1NmuzWY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Te3h4T5rX8QQssEOHgwp+XKcnPN71s61KrRX0ghAabB3FaLaKyQSqM80+YSJomoma
	 3H9hAnc9+LVegoHt75bYoFQRFwVRby00aFGcNh+8z29ZvE5YO/N0/7tGQ2OBRp5GW5
	 dWXdOtvHkuMdmpgZUX8W/am2eRErq3AS3e44GIPGXVQWDtHMevWtcldWkASkKvXrdm
	 dUCSnBvO7ZhJ2Hen7Rl0vW+Si5zwofiwIaTd0SxplNFrUgy7DGW5nowtXAryfDPZht
	 SYl4qzyhXr2yx70h2kQLNHFWZJqFRGp2LIo44V70CaQCCiXSv7xE/++IQzBMUPcmUU
	 qKtcphV2Yiz8Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dHNPF3hVgz6tx7;
	Thu, 27 Nov 2025 18:16:01 +0100 (CET)
Message-ID: <7c527d65fd69ab8e293ec97f893410921984a30c.camel@posteo.de>
Subject: Re: [PATCH] Move pwm registration into pwm::Chip::new
From: Markus Probst <markus.probst@posteo.de>
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei	
 <wefu@redhat.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Thu, 27 Nov 2025 17:16:03 +0000
In-Reply-To: <20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de>
References: <20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Tr0vHZMpM2eDu77wNqsK"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-Tr0vHZMpM2eDu77wNqsK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-27 at 17:15 +0000, Markus Probst wrote:
> The `pwm::Registration::register` function provides no guarantee that the
> function isn't called twice with the same pwm chip, which is considered
> unsafe.
>=20
> Add the code responsible for the registration into `pwm::Chip::new`. The
> registration will happen before the driver gets access to the refcounted
> pwm chip and can therefore guarantee that the registration isn't called
> twice on the same pwm chip.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
> This patch provides the additional guarantee that the pwm chip doesn't
> get registered twice.
>=20
> The following changes were made:
> - change the visibility of `pwm::Registration` to private
> - remove the `pwm::Registration::register` function
> - add code for registering the pwm chip in `pwm::Chip::new`
> - add Send + Sync bounds to `PwmOps`
>=20
> Note that I wasn't able to test this patch, due to the lack of hardware.
> ---
>  drivers/pwm/pwm_th1520.rs |  4 +---
>  rust/kernel/pwm.rs        | 53 ++++++++++++++++++-----------------------=
------
>  2 files changed, 21 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 955c359b07fb..1919b5a1f69e 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -363,7 +363,7 @@ fn probe(
>              return Err(EINVAL);
>          }
> =20
> -        let chip =3D pwm::Chip::new(
> +        pwm::Chip::new(
>              dev,
>              TH1520_MAX_PWM_NUM,
>              try_pin_init!(Th1520PwmDriverData {
> @@ -372,8 +372,6 @@ fn probe(
>              }),
>          )?;
> =20
> -        pwm::Registration::register(dev, chip)?;
> -
>          Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
>      }
>  }
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index cb00f8a8765c..c5d03ee8bc95 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -173,7 +173,7 @@ pub struct RoundedWaveform<WfHw> {
>  }
> =20
>  /// Trait defining the operations for a PWM driver.
> -pub trait PwmOps: 'static + Sized {
> +pub trait PwmOps: 'static + Send + Sync + Sized {
>      /// The driver-specific hardware representation of a waveform.
>      ///
>      /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFH=
WSIZE`.
> @@ -585,7 +585,7 @@ unsafe fn bound_parent_device(&self) -> &device::Devi=
ce<Bound> {
>      /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refco=
unting
>      /// on its embedded `struct device`.
>      pub fn new(
> -        parent_dev: &device::Device,
> +        parent_dev: &device::Device<Bound>,
>          num_channels: u32,
>          data: impl pin_init::PinInit<T, Error>,
>      ) -> Result<ARef<Self>> {
> @@ -623,7 +623,21 @@ pub fn new(
>          // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-c=
ompatible with
>          // `bindings::pwm_chip`) whose embedded device has refcount 1.
>          // `ARef::from_raw` takes this pointer and manages it via `Alway=
sRefCounted`.
> -        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_se=
lf)) })
> +        let chip =3D unsafe { ARef::from_raw(NonNull::new_unchecked(chip=
_ptr_as_self)) };
> +
> +        // SAFETY: `c_chip_ptr` points to a valid chip with its ops init=
ialized.
> +        // `__pwmchip_add` is the C function to register the chip with t=
he PWM core.
> +        unsafe {
> +            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::nul=
l_mut()))?;
> +        }
> +
> +        let registration =3D Registration {
> +            chip: ARef::clone(&chip),
> +        };
> +
> +        devres::register(parent_dev, registration, GFP_KERNEL)?;
> +
> +        Ok(chip)
>      }
>  }
> =20
> @@ -654,50 +668,23 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
>  // structure's state is managed and synchronized by the kernel's device =
model
>  // and PWM core locking mechanisms. Therefore, it is safe to move the `C=
hip`
>  // wrapper (and the pointer it contains) across threads.
> -unsafe impl<T: PwmOps + Send> Send for Chip<T> {}
> +unsafe impl<T: PwmOps> Send for Chip<T> {}
> =20
>  // SAFETY: It is safe for multiple threads to have shared access (`&Chip=
`) because
>  // the `Chip` data is immutable from the Rust side without holding the a=
ppropriate
>  // kernel locks, which the C core is responsible for. Any interior mutab=
ility is
>  // handled and synchronized by the C kernel code.
> -unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
> +unsafe impl<T: PwmOps> Sync for Chip<T> {}
> =20
>  /// A resource guard that ensures `pwmchip_remove` is called on drop.
>  ///
>  /// This struct is intended to be managed by the `devres` framework by t=
ransferring its ownership
>  /// via [`devres::register`]. This ties the lifetime of the PWM chip reg=
istration
>  /// to the lifetime of the underlying device.
> -pub struct Registration<T: PwmOps> {
> +struct Registration<T: PwmOps> {
>      chip: ARef<Chip<T>>,
>  }
> =20
> -impl<T: 'static + PwmOps + Send + Sync> Registration<T> {
> -    /// Registers a PWM chip with the PWM subsystem.
> -    ///
> -    /// Transfers its ownership to the `devres` framework, which ties it=
s lifetime
> -    /// to the parent device.
> -    /// On unbind of the parent device, the `devres` entry will be dropp=
ed, automatically
> -    /// calling `pwmchip_remove`. This function should be called from th=
e driver's `probe`.
> -    pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) ->=
 Result {
> -        let chip_parent =3D chip.device().parent().ok_or(EINVAL)?;
> -        if dev.as_raw() !=3D chip_parent.as_raw() {
> -            return Err(EINVAL);
> -        }
> -
> -        let c_chip_ptr =3D chip.as_raw();
> -
> -        // SAFETY: `c_chip_ptr` points to a valid chip with its ops init=
ialized.
> -        // `__pwmchip_add` is the C function to register the chip with t=
he PWM core.
> -        unsafe {
> -            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::nul=
l_mut()))?;
> -        }
> -
> -        let registration =3D Registration { chip };
> -
> -        devres::register(dev, registration, GFP_KERNEL)
> -    }
> -}
> -
>  impl<T: PwmOps> Drop for Registration<T> {
>      fn drop(&mut self) {
>          let chip_raw =3D self.chip.as_raw();
>=20
> ---
> base-commit: fae00ea9f00367771003ace78f29549dead58fc7
> change-id: 20251127-pwm_safe_register-e49b0a261101

Just noticed 5 sec too late, that I forgot the "rust: pwm: " commit
message prefix.

Thanks
- Markus Probst

--=-Tr0vHZMpM2eDu77wNqsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmkoh1AACgkQNHYf+Oet
Q9Lang/9ExIjMoS1WvYfB1O/sExcx99/etOlOfZ3vdgz3zMi3Oa+VC5KlIylG6Vh
zxOj1ZgJA03K82Hs7WL0qH6LXqXXfSaHUticttjfbiXotSuKnyo24zWzro7jScRn
SycOJtd4QjL3Yh4nckpNPvi/cg392hip7kssXuqVZ2Qrkh94gv0iTaujo+mvfSoV
ACtPJKzZyTe3QkVOZSr0UarD9Yb5g7NXn61104JMGrg4PV57j/NUUt0hpiob85qp
YBba6TJk/XP8QckxS6urOtLZPjaQiGYIoEzYXSLaVR6Z6riJqZ7cFU4YHaeY8AXw
JVK+WaS0W2nkyI807jYav73AaHqz7OkZn6RNkU0v2D0sE+iHS/TzYEr8ZCrjIblc
bUqiBR65x53Crj9hliIsCXlzYD4FaYkPh8te5liMdHejDqsNL0FqF3ano9PbjmAm
7HBaq0q/W2o3yuUX66NsGtZJd9Ta9Qa1ZLMjHCi9aK3Punb+OM15YF+pqSSi6i7R
KGS6oREn81j4yCTCNMJl3D69IKWyGgw9Od/Y0uxXKBax2kHHZkUnXMF9OIZQQ0XD
Yz8QQJM5C3kgCKbjMKrRWXP5jpnVZ67cQQ/ZqCon2qBYPGiDbvg9bypD7E92q867
/5IQFbs0wUfP47vGfc8M9NLMDr7f72/gP27lG8mDHk7tgpCIXmA=
=BcfA
-----END PGP SIGNATURE-----

--=-Tr0vHZMpM2eDu77wNqsK--

