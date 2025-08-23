Return-Path: <linux-pwm+bounces-7150-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5EB32912
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Aug 2025 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89183B3652
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Aug 2025 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF01DF756;
	Sat, 23 Aug 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6xyp3MZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70C3BB48;
	Sat, 23 Aug 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958865; cv=none; b=uCD9x4zSvK/GHjjzygmm28HA6HjA1WW6hBj6a2JQDFxJKcBWCfwxHVmt/LfyDhfxB45T1viL8q0/uWR45zSczfn7Axuw6GSF1QMguuGZfbll/ra65Nk35E1h0LuSxbCuBnI/sVcNwXF3miUcWBofiTLRdL0DTK3TzTvKGqmfPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958865; c=relaxed/simple;
	bh=FKS13Ls82GgTKoYQ+noL3pXMTArz0NPS6LMA322WeXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP50unmPZten8KFHunGC4r9Knq11NPo6qo03ZFNQdsqBRE2qPwwdk3eG5STo5f3hnBgJSwXRsgDcKHCkpzITtYDpujvNKDkJMSjFfzzQzSOw9HTbx7f6WYTGC7MQDBy/YI5PV9kcmk236uqn+XlNRMDa/fu6tCU8MR3ZAmUHmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6xyp3MZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2467e454c46so237525ad.2;
        Sat, 23 Aug 2025 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755958862; x=1756563662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKS13Ls82GgTKoYQ+noL3pXMTArz0NPS6LMA322WeXw=;
        b=b6xyp3MZroKJQKnUoTyn6vanxh/h3dOl76IjO93PJDuxCA6cSjIYJ5AsowCF+4QX+3
         BJ+sXCkP/sJYLPzH4TYcXEVudrp0g42n5lC2naK7MryX2I7+zby7sIFh6hOLB9z4KETL
         qoLxgga+YohtXwNAhA4kJxjMxYuLvAJnv4NKqBGMonrTc4zIAb2l0byRyUlvIWu10U2b
         6wnUhncILheTAvJsTBvYLHxMBqSgiFsyTGUBCcy2Ov/hcoe3/SNzqW99H+XDgxaTkUkv
         pK78WgsjCbEoYBqjTe1+QSBaSZBHp664ExNtgr5YcEKeCxhRe7XsLOQOUyVw+aOGFfwM
         eNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755958862; x=1756563662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKS13Ls82GgTKoYQ+noL3pXMTArz0NPS6LMA322WeXw=;
        b=JSbLs/FyvJkH5cN4FaR8FIt+MgtGeLdzq8jWFA9hwE6d/GDMkE5FnFWtmpKwI+IM4C
         c8R50S1Q4H3/MF04Vtf7UYYRY+MI6I27YokT7X3GBxUju7VMesS+AT8RXls5TlGo0Laj
         LxBKsoo/Yjxkw6nCOIkBoZRde0BMZKDAVvOy33KT9W8WfFyfLabNVatPWOygnHgOORxG
         BAztflV6sgsPOTyXn2GFBrGtMc7qLyiaVpjoFGSBoQZ+yl+mIoLgj+BCaS+k6TU9VE60
         q3cYFvlid8ZD6MKd5MFf297ZJklRokQoWppEx/sLtHWASL+k8128gHB+IZjSV/osx8KO
         TOww==
X-Forwarded-Encrypted: i=1; AJvYcCUORXHeuV6sc8q9RULPerBhfdyZnFLg94cDZRTbmacWP6qPnPncVblKW6wKqAih26haSXQCKXK5+grjSInv@vger.kernel.org, AJvYcCW2rNQHkemQoHLIv20j+nrXoauIxrpXJtAKoMrr9TyBhtaCKzQXYyoKsvDfGsCLvCh4m5EUIoj6x0Ek@vger.kernel.org, AJvYcCWmwxtykAHLmxYO2A5/IjBf5VNWlPyrUiP+BbDpCx41DkAmTdNfhHJnAWtK4Nr1tA40UFoMWGKAaGipqa/uuWc=@vger.kernel.org, AJvYcCWxvFZOpCVJIsZ8PyjDvKcutm7CPgHjCj/JwoSng22slVnVNfaUf7i9lsq1WuUHwvJhTNx6B1/JXA/K@vger.kernel.org
X-Gm-Message-State: AOJu0YxILpsImYWZOejiC5qfFx9PKBm8Kg7RYejy3RaV+/bXbK6wja0v
	E9bSIb5CAVpaGyQl8RWSIjhvfnEAv7UxiuerqZ9g742x9NpCCZyOVPLlRLJz28MjYk2otmpkr3U
	zsg1byeVz4cF3hTUNKz7PmZwLING/fSM=
X-Gm-Gg: ASbGncszc2t5xQt+oLHXbc+1Yg0tU63U+YK61KVcxmOfy8IKr05uRkPGAQ3bcDnSEtR
	N3sCBFx2LIsjjEnnyQZnBZ0ziER/Le4Y1DT0yhYUW3x8xM5ktxwa+fFqM/D6HHboO2tmE+VNtMI
	0g78PxDU1wEePg64veGN6bb9mK2yUqlrxliQNySsFjFaVzvwCfCZwVHUXwG7GCKD7l9wuys8nam
	+smt6MIlwcW5PKyFkThCFRLEmbYaAQegGoJO1O86S/HlHQ0ueVXf5x7cQmD/FzCW70vDLFes3IJ
	QCbFLSPoqNzt8OKNvOLQlyy4gw==
X-Google-Smtp-Source: AGHT+IGVLaR8SAQwEUxUiy2CqfQseM2OkihMRfGlZd9/MU0z/dJwNrzQwurGCFk0ttB0GCjmTXBnJ39be3FpGZZbACA=
X-Received: by 2002:a17:902:e5d1:b0:246:9df4:d10 with SMTP id
 d9443c01a7336-2469df4127fmr3166135ad.8.1755958862532; Sat, 23 Aug 2025
 07:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083548eucas1p2a40775d53dfd9f8608671cc20003fd7d@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-7-df2191621429@samsung.com>
 <aKjXzyyYd9QneIKf@x1> <3aa6f79e-2ebf-4aff-a23c-7e79929a85f9@samsung.com>
In-Reply-To: <3aa6f79e-2ebf-4aff-a23c-7e79929a85f9@samsung.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 23 Aug 2025 16:20:51 +0200
X-Gm-Features: Ac12FXxJkYUU9nh5gGCQzR8dqN6e3fVSP-8HKfD18-Z-F1n5Giy4FK7WbmAKogU
Message-ID: <CANiq72kAVmfSyAs71pmmVCq8f-rA1BECZ9iCTcTxiLfsO9-V6g@mail.gmail.com>
Subject: Re: [PATCH v14 7/7] riscv: dts: thead: Add PWM fan and thermal control
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <fustini@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
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
	Michael Turquette <mturquette@baylibre.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 12:14=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> However as pointed in the discussion currently Rust
> requires LLVM, so people compiling with gcc will not be able to compile
> the driver for some time until the gcc support becomes better.

In case it helps/clarifies: the C side can be built with GCC (i.e.
building without `LLVM=3D1`, with Rust using its LLVM backend), but it
is a best-effort hack and the goal is to eventually use
`rustc_codegen_gcc` and/or GCC Rust. Some users/distributions use it
nevertheless.

Cheers,
Miguel

