Return-Path: <linux-pwm+bounces-6303-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82112AD5CBD
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518D17AD7A3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818A20F078;
	Wed, 11 Jun 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax2uLJxY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183220C47A;
	Wed, 11 Jun 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660931; cv=none; b=mQl+Mw7pNQJ3DOeKYykuP9vsPqJ6Bz4aAYqCEmDoQBHD1BQSdZ4Gsd/KNpR1zw64fSfub9RxsTKymbt8YIYqNO1QjCdbSbH3iionopYfOdQsc8Qm4kwYkbJeUREluIkBb8KOCo2Aptj865yHR+wB+RuyYj8j2omi4qXZlLBGZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660931; c=relaxed/simple;
	bh=KyNFKemnRNzyt/7LqR30HwimFe7KXWQY+EiWh5tmzaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9+PHVmv0nWs/SInC6xJbw5TlhHksoiztcWVCbpEJlxFbkEpoKlInrBpQ6LKrOtSPxGmg1PO3K+DD33cu+R3y8qqmS3JNE7IQ7mDZIG1lMOjGbpktb0rqgGYv8X3QOOhSTQEIbzvZGmI2QGTfeTMSYWrrN49Aj43X+TF1SgteHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax2uLJxY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31306794b30so13681a91.2;
        Wed, 11 Jun 2025 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749660929; x=1750265729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyNFKemnRNzyt/7LqR30HwimFe7KXWQY+EiWh5tmzaI=;
        b=ax2uLJxYAzt3Xjjj45zhdd1k6hVad+uIXzoXOd4oaS/Wj+oRBdMKvHcZhiQamAWm1Y
         JBhyNrv4diEF57pyX+CmM+ax7i4JeT5aQVtQ03dpdpDOitxT/apLYXnmtulOpeg8Hb+V
         2PZWla/msdl0E6CRfk11xSit25l5hV0Hk0bLzIBCtnBDI7nNR27qaI1cAS084tENZ7LV
         12TzxJrUwz9TIDFMmJtEpviQ0+H/dZPzAcDGfx9g0wKvb1BiX0j13GcwQrbY3OYocsbD
         UT3uV08DJ+daDoaE92+VCh1mAO2f60HFKwhmqsvybYhQOR991vnlrnrOiNyBjUGS3qn3
         Z9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660929; x=1750265729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyNFKemnRNzyt/7LqR30HwimFe7KXWQY+EiWh5tmzaI=;
        b=aoQEIOZih06cb2wiG451/dgMVi2pDIVSSICE7r+wl71+atzPjCWppefsjzqBqqkD7G
         MK/dZ12DjVa6sfE8i/6alN0sgaZskUeqvcO0tuPjWgKdfC12xe+n4+X7HEupfwrLPPU6
         JllUsSpjDZZNikDDSXK6vV1WJWi0Ch1kxNMOavzlfRGwTS8qXC7HTmd46g8qRFpnbpCP
         LZUrIQ8AubzmhmdF5s9kJsDQqdmawgbLnudDlvR5LgqCn/+XrsjXOtY30Vlkx70tQe6d
         thGPYbZ7SVc3yS8uyALx70eEvrGdkGGGyG6kPFC7efa1Jpp/Y8QxOTiBU2HPsa8I0xZd
         qsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXD03ifCHIo+n3O7YAdAPmDjQQEaB3NpI+avZ3uA4J5/Pf/oGunsk4vQ9Teaw41mEbO/iSnjKLPX+C@vger.kernel.org, AJvYcCVSyDt9w7vVrRTreCfcoV3Iv7VxMA6PISVkkOhIZNh1oGjiEkjwhCDmZsdSLNYR61jLGLy/ur7UwwOm@vger.kernel.org, AJvYcCVZkHgKSj5vyi0EurTOxVWoJ2L4Rj86NpzNChiNqfzHlmAC7uT5YNnQlbuTVwZkqiWtrhGDfw9QaRsz@vger.kernel.org, AJvYcCX9JgSUXQhKG12I86l6yikpEENDdE0qRbKGzbyIjChyzvln2+BfxGHWuT7n1U67LJB8colagOFE9Qfgjhhu@vger.kernel.org, AJvYcCXRthceYES5Z4TzhsLhsvfA0vatEQLE580smTvFJ2QL81AZCCMBFNNg21x0239NGh2dwlSKFV8HVhCqvcbTrF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3/UOr7OGcdKgsStV1OfTGxrQrN4hDC6HpjvhE0FszdSOzezf
	+z/b7yAP/R2TLj6e/+TYk60LJ3qi/4l6RdR7DqSnu73CTF+2ON5K/4CKbK2dX0k3TZPkToj0FOf
	Nk8Ylf79qj2nobDsjBLVVlo7Ud3PiY4s=
X-Gm-Gg: ASbGncsHKpW92O2HI1mVEv0Y0MV6MK+ljAIxfTOIxZOcBtsOxEINuCrkInpE0VA+6u7
	kX7RF/CaWIZOl+7w47q2Mms1ki0HJR83RehpHftQbO4ObHo1eYEXXNqYh2tjYFRiG3TH8W7alXk
	2KYIo4bMyBztgaThUEx6ICclgv4hWDFcPA1nnbb4fns4c=
X-Google-Smtp-Source: AGHT+IE8o2IorCuFcUqW3Dxq8LkFc4fMvAMKwf+dTmyr9FxnqdwSW1OMco+JDmkRZVwCnFY7SBpojWZ8MSza5Nch4Qw=
X-Received: by 2002:a17:90b:1dcb:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-313af0f9611mr2302611a91.1.1749660929073; Wed, 11 Jun 2025
 09:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
 <aEifXZnLxKd2wa0w@x1> <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>
In-Reply-To: <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Jun 2025 18:55:15 +0200
X-Gm-Features: AX0GCFtO16UWgR7wAnoHoWp6WjbNacZo98Lk-lDtKNRkXYeSnMBe-Yw1GCMYPlU
Message-ID: <CANiq72=88Aa-Fe0b6XiSfsOq0mM3jUw_e+DxpRRQdrdtWFJHsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
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

On Wed, Jun 11, 2025 at 5:14=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> The kernel config option that is different on my setup is:
> CONFIG_RUST_BUILD_ASSERT_ALLOW=3Dy

Yeah, code must work with `CONFIG_RUST_BUILD_ASSERT_ALLOW=3Dn` -- the
config is an escape hatch just in case a user toolchain cannot build
the code for some reason.

In other words, if a `build_assert!` is triggered, then that is a bug
(likely in new callers misusing an API, but it could also be in the
callees, of course).

We may eventually remove it, or perhaps invert its meaning so that
`allmodconfig` doesn't enable it, which is how I guess you ended up
with it, right?

I hope that helps.

Cheers,
Miguel

