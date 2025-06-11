Return-Path: <linux-pwm+bounces-6292-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E6AD574E
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A5A3A5571
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0129ACF1;
	Wed, 11 Jun 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDuEvEK+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3F28A71D;
	Wed, 11 Jun 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648920; cv=none; b=uuJgs6tXA03kTZBJvDv6gcV+ah0iAdbE9CWjf+cbmSFkMWH2Zsnkxu8XHn3OjZG9K/3Xrmb/CIMFjmXOTKyjwNdsPrIwl6dK7TKTmv5Gc247d4YKe0FE+LkRJSqHJLxOMxgEc+Gjvtzlx9V2wzf+AP89WPZ9YxPwOddWOkgrTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648920; c=relaxed/simple;
	bh=hkFr+Bx51wr83EaGtiwARjlngiHTI7OKLDw5jUc9D7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSrcE3FJdcOygE78OQFYgVgucjgZ1wV90IdDtsS1DK+rhRVQkZQNKfQ9eQAGeXb0NO/QuWs2zQS8x5k34YMnyBtISVyTsvrFf2sIIBe172gtMed28ozr7XHHcq9fkVwXDmzAqwKcOvqw0F3TdqfCi6OFa5XEssJSsOqRdE4fNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDuEvEK+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2eeada3df1so22484a12.1;
        Wed, 11 Jun 2025 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749648916; x=1750253716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7+YJEMDJ36thuIfANjb3mLZl0V1QkdkPulFRUlEhRc=;
        b=QDuEvEK+drMX51ldkME7a350gCa0isJtAl7LiDVUDvkpnGK4P9ifnkib8AjzxteCbo
         7Kw9aDyEvT/7jpknkDECjMiJqxFAaJaSMKuNYjyemwmYqkmojfO9qMqclsLyXlhardWB
         rnFRGSUoRebqwN5hDyUJeoSR4rfcXeFGLB7OSo6JuxuZn+gdtsTLT0F+HSi+5YCcR2hc
         5Z+QG5nonthmkGJW8E/8mH5wdfATVRbdHLydMjoeDzNqAN4jc9kw1S6yHJX9PE1vN1CT
         KkHIYwYs4AdGQXZyeFX98dspySN3MzQulCnlwRDEsIqqJsF9IImtl/Wu/xrK6eQjU7mp
         iiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749648916; x=1750253716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7+YJEMDJ36thuIfANjb3mLZl0V1QkdkPulFRUlEhRc=;
        b=pkNPki4mE9pTS/Dj7SewWKkylZ2p/oTY39483MADVbDYLPB3mgM/vGQvcD2izV2Eiw
         kYl/tAuc85A5BZphnG/L2RxQvYiGh73RTZHGTvbEjJD9p8oEC8sPnj7LLxmTGlvYKTw6
         x0mReUqlCBCOMBgD4Sm24f1y5WKRV9PbTIeAdNb/8fO/x+cZPlc1BhxsDkdxunIPyAeb
         ac1NGoSr8dYk3ED5Nb/Y/WkJgqJFGAomP0pDIOs8aO3jrWOHmFndEn7IOb6muo94O0QR
         uum3rUgtJ1WOWA+AyXrgFy8LrbRlvWb16m+8MwWx8Hw5mgbeIzvXdrpiii+Up37dcQmT
         ncxA==
X-Forwarded-Encrypted: i=1; AJvYcCU0T7wKRAe9/Ge637F1rbqRM7x+tMbIiDfDe3UGxfU9Uv9ZO8+Fkj97qK70bdOsAQinN/wZOMohB+9Tiqf3Xa8=@vger.kernel.org, AJvYcCUYtjkjCSc7xjtFwcrfZZfcRtCGvEdcTQGhZe4gsAsN1zaLvwuetmkYJMcGJ6Mo/MxMokxr/HqB2KvrPfQh@vger.kernel.org, AJvYcCVCuMERZGkB5WDaGUJWliYVfCLNfb5B4Un4fhR1ucgfJFuWUDVAkjG/+KMprEO3ODDYmrnbYEjdE7z9@vger.kernel.org, AJvYcCWcs9w2FfyugTOh9hO4otx1/+6yDHjBUkpdVAV5Z+qYtN687rNGxD/tTzOrbEFn68xqf3zzlHRGgKCD@vger.kernel.org, AJvYcCXw2kzBJ2F677sdG5PZLEBiJypTzeYWMW3ULeCTp9rU8aGZuRYnT3U1kJH+uLgCWL1hh+dmIm9e0FkA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6l4fE81GhuyFy73D4uVDQ7NCcm+CsvFfsuB/oZ7FFgpz9xat
	ve9Jr5WBXuI2eHLd8pPWtLXXiZT+Y8CKi/ewiH6Cqj6Cj3KsBRDO4vAI4RFCBnA44UifHaJS28A
	Hf2fIo2Ub7bNHnSO8oY+9/ZT6k1PBQJI=
X-Gm-Gg: ASbGncvrE2GUw8JN+0dV9XehRFwo99cEBz0alM0aKycOsBg76R925WYBoQFw2YNALWv
	ZoDcyUiI7fX1mT8vUlPQxq5TaPOVdop0VgSU9q85+zagMD9im4p4DdDyDaroTNRPHrFgPb3kgMo
	CuepyNW6aViI1kBJWIeids15X/ZEeUUjGCkQpDIIMECG4=
X-Google-Smtp-Source: AGHT+IGbJpFZ+Qk6FvdsQn7PW78XJk+bb1d1PTP/d+zpCYzn/eIeprshnIC7HU+/be04GHkcxAD23HE18OQvHrvC4pg=
X-Received: by 2002:a17:90b:2f8b:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-313af1e1bfdmr2041537a91.5.1749648916482; Wed, 11 Jun 2025
 06:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250610125332eucas1p2da441aa44760236527afc82495af95d1@eucas1p2.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-1-753e2955f110@samsung.com>
In-Reply-To: <20250610-rust-next-pwm-working-fan-for-sending-v2-1-753e2955f110@samsung.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Jun 2025 15:35:04 +0200
X-Gm-Features: AX0GCFucCUfitmsrkVpmEkyboIYu-vqz9Ti13iybORi8Z5Q-FoT6_3kpjtnZoMo
Message-ID: <CANiq72mW2ZsBh8WxY26Knh=FxxPHWK_ikbS9iZip2qRLJAXiNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] rust: Add basic PWM abstractions
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Some docs-only/nits quick review for future versions and other
patches. Some may apply multiple times.

On Tue, Jun 10, 2025 at 2:54=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> +//! This module provides safe Rust abstractions for working with the Lin=
ux
> +//! kernel's PWM subsystem, leveraging types generated by `bindgen`
> +//! from `<linux/pwm.h>` and `drivers/pwm/core.c`.

The second part we typically do with a "C header" reference to
`srctree/...` which will get rendered as clickable link to the file
(please check other files to see how it is usually done).

I would also simplify, e.g. typically abstractions try to be safe, and
the bindings typically come from `bindgen`, so I would just say e.g.

    //! PWM subsystem abstractions.
    //!
    //! C header: ...

What types are you using from `drivers/pwm/core.c`, by the way?

> +use crate::{
> +    bindings,
> +    device::{self, Bound},
> +    error::{self, to_result, Result},
> +    prelude::*,
> +    str::CStr,
> +    types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
> +};

At least a couple of these already come from the prelude.

> +/// Maximum size for the hardware-specific waveform representation buffe=
r.
> +/// From C: #define WFHWSIZE 20

This would be rendered as a single paragraph, so I would split it into
two by adding a newline in between.

In addition, please use code spans (i.e. backquotes) where possible.

> +/// PWM polarity. Mirrors `enum pwm_polarity`.

We don't link consistently C types, but if you wanted, you could link
them (either `srctree/` link to a file or a docs.kernel.org to a
concrete C item if it is rendered there -- either is fine).

(Eventually we want to have an automatic way to do so, similar to
intra-doc links)

> +    /// Normal polarity (duty cycle defines the high period of the signa=
l)

Please end sentences/docs with a period.

> +    Normal,
> +    /// Inversed polarity (duty cycle defines the low period of the sign=
al)

I suggest a newline between these.

> +impl From<bindings::pwm_polarity> for Polarity {
> +    fn from(polarity: bindings::pwm_polarity) -> Self {
> +        match polarity {
> +            bindings::pwm_polarity_PWM_POLARITY_NORMAL =3D> Polarity::No=
rmal,
> +            bindings::pwm_polarity_PWM_POLARITY_INVERSED =3D> Polarity::=
Inversed,
> +            _ =3D> Polarity::Normal,
> +        }
> +    }
> +}

Should this be fallible? i.e. should the default case be an error / is
the C enum expected to have any other value ?

(I have no context, so this may be all expected, of course)

> +/// Represents a PWM waveform configuration. Mirrors struct pwm_waveform=
.

Code span.

> +    /// Duration the PWM signal is in its "active" state during one peri=
od,
> +    /// in nanoseconds. For a typical "normal" polarity configuration wh=
ere active is high,
> +    /// this represents the high time of the signal.
> +    pub duty_length_ns: u64,

The first paragraph of an item is the "short description", i.e. it
acts as a title when it gets rendered in item lists. So it should be
short if possible. For instance, here I would add a new paragraph
between the two sentences.

(Ditto for other cases).

> +    /// This type must be `Copy`, `Default`, and fit within `WFHW_MAX_SI=
ZE`.

Please use intra-doc links wherever possible, e.g. [`Copy`] and
[`WFHW_MAX_SIZE`] (assuming they work).

> +    /// # Safety
> +    /// C-callback. Pointers from C must be valid.

Please add a newline between these to match the usual style. Also,
"C-callback" is not a precondition, so I would move it outside the
safety section (above), unless you want to restrict C to be the only
one calling this or things like that (in which case I would clarify).

> +    unsafe extern "C" fn read_waveform_callback(
> +        c: *mut bindings::pwm_chip,
> +        p: *mut bindings::pwm_device,
> +        wh: *mut core::ffi::c_void,

Please avoid `core::ffi::` -- nowadays you should be able to just
write e.g. `c_void`, and that will get you the `kernel::ffi::` one
(https://docs.kernel.org/rust/coding-guidelines.html#c-ffi-types).

> +    ) -> i32 {

Unless the C side uses an explicitly `s32`, which as far as I can see
it doesn't in this case, please use `c_int` instead (i.e. please match
the C signatures in callbacks, even if they happen to resolve to that
type).

Finally, in another patch I noticed the `author` key -- we are trying
to move to the `authors` (plural) one, so please use that one.

Thanks!

Cheers,
Miguel

