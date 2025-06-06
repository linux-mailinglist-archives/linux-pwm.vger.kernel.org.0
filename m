Return-Path: <linux-pwm+bounces-6256-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F4AD050E
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292E8188AFB7
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88EB1B040D;
	Fri,  6 Jun 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NONsr/od"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65213D52F;
	Fri,  6 Jun 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223300; cv=none; b=Kw1UybB4hpWI6MyvZMSTPkABLUJwVAPNFO6ZElueQlhM4p9QS8dZdX+YxdcBUfKPntovb3k2vVNmuPeRmvXA9Ba1ovikLIL3g2ADhz8RUaxb6npY8dDq9ra+bu/qWjZSQU34EWNHD7ztJ61Wyc14Qlap3bwpY1d81e188riqEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223300; c=relaxed/simple;
	bh=gwPihyT66GFBCKXnAdMFwJ23HBwzvXhtzzRMUFfYe6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsCG8f0og9je5buxDrC2H+4Fi3n1FFp5SObzhwPrC0rY8yHfoYmzToJX48cvCSeTSvFnGFVud/NucDUUMP6LjPU1j2YRTG6MxJxvimqacUUnyIkhZ6nQRlX6tJfxUq47VqOPg2JVqcClMKMpVAav8tNaipD+w++iL5oO+iv3i3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NONsr/od; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311ea13388fso230781a91.2;
        Fri, 06 Jun 2025 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749223297; x=1749828097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y/pTaKdTa3jjo68DaVXoYV6RDpz4d2nIZzF6qf145E=;
        b=NONsr/odtLu+ufQxZ3rkKLyO5m5He/5utEPk7WhR0ajewDV91FG9Zz29u1EiJbeB3h
         27f+yXGGuYxPbB2okmXDAHe1Z9aWg8b2Rilze1ilVgoY46cJWOZNZGGL1RHs5p5RhdiH
         UdeKsY5TLtY42H9Wj6n8d03r6myUTmafT9mp+0hVaFR2DI7/EifYmQIkWutLeueABNXg
         1nCjpnlTXpIc5bBy9PyT/jI+fuNCuDKOik+xi6u0qK/ZO1+RfUbf2Ul4iRwDG2kNQzEi
         tywLpF3YO86kPh+Dir1BaavwAOxvSJ/v2z/i06rh9NeW00a3pv53ohFSXlt8cVlvNiFs
         h3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749223297; x=1749828097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y/pTaKdTa3jjo68DaVXoYV6RDpz4d2nIZzF6qf145E=;
        b=GK8L5KSmvUL4zS5vfuvtovVJtBTYdCSSdAXKugOdVgqgjBjGEHCJYYis2YgCq3TS58
         PMA+FFlq+UejjAQKufrDnLKf9WyvnRYYSeaBYYdqh/LXt2CnRhaSnD/70n1CQX67MELT
         riKXT+8zOMXB4YXn+h0pF7zZ2mJf+q4fcCtbW9T918FAk/GpJRn1XPFDFeioyE3MBw9K
         tUveodD91QKEEoVhos8Fl+ZgSzshKO/C1lysiCKsLMd+l1MySILma/ay3tHzDD1b02qP
         LB+FAu1Dms8CisZ0dUHh3yNQ1JeRzpbiOyK1pS9F5J6OKXckGVC2tT6gRlLOYUY6jRnv
         /L9A==
X-Forwarded-Encrypted: i=1; AJvYcCUy+FBrM2rs/2iDZeF+hXHDi/v4BLgAliTa6uPeS0pv7dXdnIJ5FoIPflxfthE3L7WkHKi54rdPNHJm@vger.kernel.org, AJvYcCWEdFecA3WtEzW91/xmtGltVaYE+tOuqs7l+AzNe7uMyeJKJjYfBzh2YzLxBdJshtiyhflSg9KLDO4AhD2R@vger.kernel.org, AJvYcCWhZSxDaH9rQHUDYRgD+eKhf9f6wuAZh2lKTULe4hDKC4NuO2lcJQnXu6+lR9l6AoNauSzNR3RwvK8jMz0QriU=@vger.kernel.org, AJvYcCXsikRJgRX7o8yUnaAD/qBgT2NValh1GfLUeVwOfZZwjawCJHPx+zFz8IkDQmvwGmQRkN4IM6OrjG/w@vger.kernel.org
X-Gm-Message-State: AOJu0YzvxNCN39JDX/xNunb1oYl4XmNmfb/9Zw14Ddn+rX5tmc/RwEPg
	MY8XrT4PIrxiDprNd1XzYPCq+1k/N+1Fd6mejlVsqpVk2zLAjqY0ePhm/VaE1RTzdqr9/+tA/l2
	d9DbfXjb+WX0kIwsKypErhyson/TCDVs=
X-Gm-Gg: ASbGnctTGXv4ykWakCquNxCql0ZF9PK4de1p+etG8E4DUlkuq4v8n0haXXI7uD5h4cG
	Age5dXQ/mRJegW3ufaEHkE3kQyHwrwOVOrLCVPuG0eiCej3KXUzB+hDBlg6gy5uqdni7RiOTbJD
	VOTdeAom6Ava92x4N7c+FTfN/eTANhBBWg
X-Google-Smtp-Source: AGHT+IFyOIamAdvMd6PyTbKxN9A+KfVhNlUc26UeNq5/4kcHIWj1RvrgAIyHNMb7SFTTos+AIoRpMNq1w6r+sr9p6LI=
X-Received: by 2002:a17:90a:d006:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-3134ded1839mr1619938a91.0.1749223297388; Fri, 06 Jun 2025
 08:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
 <q6dkihyfosi3k4mtrvyff54nbsjpovmujdbmoqhapo7daznpja@of2p5gtmcq2m> <b1c4792e-f997-4eba-a8ed-d2e3f76e3fdd@samsung.com>
In-Reply-To: <b1c4792e-f997-4eba-a8ed-d2e3f76e3fdd@samsung.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Jun 2025 17:21:23 +0200
X-Gm-Features: AX0GCFvFtqr5rx5vUZL_23m9VolSo1UVOelTmGY--77dwJA0BboM7GZ90cFl2gw
Message-ID: <CANiq72kVvLogBSVKz0eRg6V4LDB1z7b-6y1WPLSQfXXLW7X3cw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:08=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> You're right, thank you. The wrapping_mul is unsafe due to the overflow
> risk you pointed out.

What do you mean by "unsafe"? `wrapping_mul` does not trigger UB and
it intentionally provides wrapping arithmetic.

> The ideal solution would be to use the kernel's own mul_u64_u64_div_u64
> helper function.
>
> Rust maintainers: This binding doesn't seem to be available yet. Would a
> preparatory patch introducing a minimal rust/kernel/math.rs with  only
> this binding be the best way to proceed? It seems like a useful utility
> for more than just this driver.

Sounds good to me. We also recently had related discussions about
64-bit divisions in 32-bit architectures and `const fn`s, you may want
to take a look:

    https://lore.kernel.org/rust-for-linux/CANiq72ke45eOwckMhWHvmwxc03dxr4r=
nxxKvx+HvWdBLopZfrQ@mail.gmail.com/
    https://lore.kernel.org/rust-for-linux/20250502004524.230553-1-fujita.t=
omonori@gmail.com/
    https://lore.kernel.org/rust-for-linux/20250501015818.226376-1-fujita.t=
omonori@gmail.com/

I would also be careful choosing the names: if they are supposed the
same behavior, then please pick the same name as C. Otherwise, we
should avoid it. Either way, we should document them.

For instance, is this supposed to be `mul_u64_u64_div_u64`? I guess
not, given e.g. the `c =3D=3D 0` case.

I hope that helps & thanks!

Cheers,
Miguel

