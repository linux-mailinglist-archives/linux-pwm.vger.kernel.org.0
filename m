Return-Path: <linux-pwm+bounces-6825-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C42B00DAA
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 23:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522D15C1971
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 21:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF112FCE10;
	Thu, 10 Jul 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPkUlA0N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BD22338;
	Thu, 10 Jul 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182372; cv=none; b=AVXFfqkpNQwg2OxO3MFW8P/wUsXKJJrmQgEeq0lYr3TXa0r0FIb6KzSbfo3a5Mj0A9g1Z3xtmeGSidFqGJj8bzCKR10gevjNwnbBFRBF3HHD45cQNj3VJImw5sXsmtybXABKZ0R5MHiGUWynbmum2kJd14MwvkUcKfeeQnfHaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182372; c=relaxed/simple;
	bh=0zK4b9WCKbhDn6z7GD5R0mIS3pwTZmyc1BLcnwDAQs4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=WAHwIreK++6CLdMao0z0J11KwLWFkGtVAQBmGwa65Kiu1aO9ZrLXjtDmpfMxUa7pvqZLGsrQ/tfzogIof6ERYq3SYdPmg17Id0Dq5G1max3Gd9Qbh3sbVI6O8vLnQQcgptEvNibPJ8emEUEBJDqfARJXB36p/BQgvK5bWTwMN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPkUlA0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8929FC4CEE3;
	Thu, 10 Jul 2025 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752182371;
	bh=0zK4b9WCKbhDn6z7GD5R0mIS3pwTZmyc1BLcnwDAQs4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=vPkUlA0NUJLGY/Q4PvaaFqidAOKuSwxT+5jVUD9cwF/qy/NHVyyVRYgDzjtWs51TE
	 TgfvcQUsC55IDISpn13HnEy7SQybmToEkjdwJDu6iiQhJ16+k+cc+5JqQ/vj4m4ToW
	 iwjYVqttFqRRFrilkHJAj3kMi4f91IftPYkBz3+9Sg2wTit/UprIqtsoNOOs13Rc1K
	 voWpDI6wCmV+valiZDVLyo+3C9G/cVISn5p7R4pRMdHs2LFlrbAcGt+TnTUCjNihET
	 +Hiva66FTC+buuJJFdmDf+A+Dk/vyqoKWkVhxvpzUQq68t25OH58dtSdlTeCaWfIX0
	 /c+ZvJbVzx/cg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 23:19:24 +0200
Message-Id: <DB8OT5ZZ4SRO.WP5PBFLML683@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Cc: "Michal Wilczynski" <m.wilczynski@samsung.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Benno Lossin" <lossin@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Drew Fustini"
 <fustini@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com> <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com> <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com> <ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn> <e77eab1c-446f-4620-95be-d343684d1e95@samsung.com> <4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63> <DB8I5J8ZY7QF.2D8HEN6JX4HSZ@kernel.org> <cbxpqormchajfcnf7xxopd7j7igriqus4cuu5jfvxb3mbfb5tu@qz4rc67vjyif>
In-Reply-To: <cbxpqormchajfcnf7xxopd7j7igriqus4cuu5jfvxb3mbfb5tu@qz4rc67vjyif>

On Thu Jul 10, 2025 at 10:57 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jul 10, 2025 at 06:06:26PM +0200, Danilo Krummrich wrote:
>> On Thu Jul 10, 2025 at 5:25 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
>> > Hello Michal,
>> >
>> > On Thu, Jul 10, 2025 at 03:48:08PM +0200, Michal Wilczynski wrote:
>> >> On 7/10/25 15:10, Uwe Kleine-K=C3=B6nig wrote:
>> >> > On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
>> >> >> On 7/7/25 11:48, Michal Wilczynski wrote:
>> >> >>> The series is structured as follows:
>> >> >>>  - Expose static function pwmchip_release.
>> >> >=20
>> >> > Is this really necessary? I didn't try to understand the requiremen=
ts
>> >> > yet, but I wonder about that. If you get the pwmchip from
>> >> > __pwmchip_add() the right thing to do to release it is to call
>> >> > pwmchip_remove(). Feels like a layer violation.
>> >>=20
>> >> It's required to prevent a memory leak in a specific, critical failur=
e
>> >> scenario. The sequence of events is as follows:
>> >>=20
>> >>     pwm::Chip::new() succeeds, allocating both the C struct pwm_chip =
and
>> >>     the Rust drvdata.
>> >>=20
>> >>     pwm::Registration::register() (which calls pwmchip_add()) fails f=
or
>> >>     some reason.
>> >
>>=20
>> (Just trying to help clear up the confusion.)
>
> Very appreciated!
>
>> > If you called pwmchip_alloc() but not yet pwmchip_add(), the right
>> > function to call for cleanup is pwmchip_put().
>>=20
>> That is exactly what is happening when ARef<Chip> is dropped. If the ref=
erence
>> count drops to zero, pwmchip_release() is called, which frees the chip. =
However,
>> this would leave the driver's private data allocation behind, which is o=
wned by
>> the Chip instance.
>
> I don't understand that. The chip and the driver private data both are
> located in the same allocation. How is this a problem of the driver
> private data only then? The kfree() in pwmchip_release() is good enough
> for both?!

Not in the current abstractions, there are two allocations, one for the Chi=
p and
one for the driver's private data, or in other words the abstraction uses
pwmchip_set_drvdata() and pwmchip_get_drvdata().

Having a brief look at pwmchip_alloc(), it seems to me that PWM supports th=
e
subclassing pattern with pwmchip_priv().

We should probably take advantage of that. Assuming we do that, the Rust
abstraction still needs a release() callback because we still need to call
drop_in_place() in order to get the destructor of the driver's private data
type called. We actually missed this in DRM and I fixed it up recently [1].

@Michal: With the subclassing pattern the Chip structure would look like th=
is:

	#[repr(C)]
	#[pin_data]
	pub struct Chip<T> {
	   inner: Opaque<bindings::pwm_chip>,
	   #[pin]
	   data: T,
	}

And in the release() callback would look like this:

    extern "C" fn release(ptr: *mut bindings::pwm_chip) {
        // CAST: Casting `ptr` to `Chip<T>` is valid, since [...].
        let this =3D ptr.cast<Chip<T>>();

        // SAFETY:
        // - When `release` runs it is guaranteed that there is no further =
access to `this`.
        // - `this` is valid for dropping.
        unsafe { core::ptr::drop_in_place(this) };
    }

This is exactly what we're doing in DRM as well, I would have recommended t=
his
to begin with, but I didn't recognize that PWM supports subclassing. :)

I recommend having a look at [2].

[1] https://lore.kernel.org/all/20250629153747.72536-1-dakr@kernel.org/
[2] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-fixes/ru=
st/kernel/drm/device.rs

