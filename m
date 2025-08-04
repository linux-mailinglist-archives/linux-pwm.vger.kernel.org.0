Return-Path: <linux-pwm+bounces-6955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A54B1AB3F
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 01:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8247A388A
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 23:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2637242D99;
	Mon,  4 Aug 2025 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVxZmQyn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699B221FA0;
	Mon,  4 Aug 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348984; cv=none; b=h1aUgKLEvEo1w8O0M7+9IofjDeDiyJlL/mV/JrFZNuNJGomAeXbVp3ed/XZdob6/uwr+ULUqlui3YwvWjgjX+gw6Woqvcf6pgFGm+ok0HrIaeyTEkzhUlnrg/CYqd+f6VFhQUvOOUOnMUlhM1hzNlDpcrDap/emoNSS48dvvDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348984; c=relaxed/simple;
	bh=3/vwe1XfvmMm4ujcTxs+rwqNUcpr/NIeYqaZ9EdeA34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoUjJXmz5g0PxW2NFk+1dsn3sVFYf8eGl5XShsYyoCZDGGteXzQYBMaxnPcVOeioCS6G3bGe/lktwtO3mL/D16UBvin369/CZK+bqFskLGc6ksOmbrn9i/DkrbQgNfwfvmPR/97lBEIuzd5eRE6Y+qnSDM0PodmnemcHEOnWRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVxZmQyn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24286ed4505so1020365ad.3;
        Mon, 04 Aug 2025 16:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754348983; x=1754953783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrE8b9KIiuoHC4GcqpFRJBb0WIhhrwvoYsW5y95hd+0=;
        b=bVxZmQyndKj/hnt+pDNyqfVsf7JTeIkSAxMKljCt9eTqjNumNfDm7x0TZWirJbGj1k
         e5tcMu7UCQHTddb5VAOCjwe5Y8FBHQDwXltjiUYIh2IwwMpEO85ugEvsn5HnzETcRF2y
         Y6EiD2CnbwrrW4q73c7TYZ53ZcU/q5RNRZufEzyCNih7sjTaCiiOA/cKqOrurDO3ivGj
         cw6XNw9Fg482dT3z6q22Iwd+urIbFUWdtHNASau5eDy1alqw8BKSMD4nqXseh5eVZA/M
         pwg1qDvhAr2+1u7zmPZLHervX7nvK/UIlaJcFt/MTsPEi/fM8+YxIQ3aRGzMLqd81xce
         w/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754348983; x=1754953783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrE8b9KIiuoHC4GcqpFRJBb0WIhhrwvoYsW5y95hd+0=;
        b=vOueOsV8E+5gPl+mfGR+0ocSHJbuoS8eCmYMlnKKIcSj2eCSz8gZ/XDTWtbtys13W0
         UOpsZzGKYUB+mBtsJ+GAys2ViFoohgj6hnff3RB/mkzA3DnNCQKOOfU/OyzUF6l+DhQP
         nWkyJaDvcH4BH3ouiNgnxEDiS+5vANLRkC2rblyHO1uzv2CZbqSMxeLhLeNNRKJQW1SW
         dmzb8h78v6worr2y27hG3a0xVnapPbmM4aajV8pg97mawD8sYIs8m1sG164X3CqQ4SL0
         oUAFyk48DJjMlJGhkKUQ62flo1hwCM/7PgzMhneSKeuLrTl3RBs0AGsLPkm3EZX0jpTz
         0MPA==
X-Forwarded-Encrypted: i=1; AJvYcCVJXAqGpEHKqMWz+pCYkoYGvRHcRkxAMJfVPxywvhRxS/Au+P97uDlxENsZJDU12Dbn3c/DIn/2E1gV@vger.kernel.org, AJvYcCWc7Lfn42txobYV9dB1T2/fdRnkiamT8xUWhhXR7oZ/inqD2378vwd7i59WWenx0w37MQMs2nUs01199RsqU5M=@vger.kernel.org, AJvYcCWrnAazMGIVfn4C6GYAE9WtIGqOFLRcuNNzl2QFExZJ31J4fXd6wyDlTH8JaqfibglsiVCSlYOYdLtak6LH@vger.kernel.org, AJvYcCXCAJyHwE0QP3xgsqqdLcjr8WfRl2yr6m09C/pidSAmWY6NcRaIFdUh+aHGlnn5kh2tzMlMz1iLGKoZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gfSPtLQafWuOmC9abCr1D8JS6i6m045W4CnJ8Zdip4n2ph4s
	qbhZOgK7BBfo6qmnpmCwpUhRmgw68iZSMmAS4eBb/YhgIRv0pHt3W/iHbGf+BERmV3lXNQmKLQX
	ywYThLVndS7YXSJXMSSBqSZuEPWxSFDg=
X-Gm-Gg: ASbGnctrQATCOrgE0r7tlsQ9Z4EO8C/AJTdBolXmG72MM1cq/6iCWNc4+2PaFPMRR54
	cDl427KZyIeFXC9HgofIDRhqAF2nvUAbB6GSaxKiB8qpQtT1dYrWVBO2CTPJhrrAc4Jud8BiDwJ
	97q7QEqc9NfOa/GVFsqqnIsMDBLZkzpM+5PbTXDDyWBPJAVeK2bj+b+6TmyZoteTdxZfASLHPq2
	QqAGvj8
X-Google-Smtp-Source: AGHT+IH1uFH1KAXD6GBBvZtSK4gxmxnIP3aOIMcwoGpeUoxH+7GptC/maaoOxBcynoToxbAD/EDonUS0Jy9v0p7iqok=
X-Received: by 2002:a17:90b:1804:b0:31f:55a7:6504 with SMTP id
 98e67ed59e1d1-321162c71c9mr7131328a91.5.1754348982575; Mon, 04 Aug 2025
 16:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com>
 <CGME20250717090833eucas1p16c916450b59a77d81bd013527755cb21@eucas1p1.samsung.com>
 <20250717-rust-next-pwm-working-fan-for-sending-v12-3-40f73defae0c@samsung.com>
 <42C9DF97-2E0F-453B-800A-1DA49BF8F29F@collabora.com> <8ad10cc3-6e7d-4a8b-b6f6-9568403ee2b3@samsung.com>
In-Reply-To: <8ad10cc3-6e7d-4a8b-b6f6-9568403ee2b3@samsung.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 Aug 2025 01:09:30 +0200
X-Gm-Features: Ac12FXxpw2EiBASGKxIRYM6i3YaHMXDUJFrbm7UTkLYwIhJtTP30cGnZkc_aEBs
Message-ID: <CANiq72=MvuhdcBoXKPMCzUQbFW2xEifZ9nO0OoXESGN3=R_1tQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] rust: pwm: Add complete abstraction layer
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
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
	Michael Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 12:29=E2=80=AFAM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> So I did try this and it does work, however it results in a cryptic
> linker error:
> ld.lld: error: undefined symbol: rust_build_error
> >>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
> >>>               drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1=
520::Th1520PwmDriverData>>::read_waveform_callback) in archive vmlinux.a
> >>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
> >>>               drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1=
520::Th1520PwmDriverData>>::round_waveform_tohw_callback) in archive vmlinu=
x.a
> make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
>
> I assume this could be fixed at some point to better explain what
> failed?

Yes, it would be nice to improve that -- I keep some references at
https://github.com/Rust-for-Linux/linux/issues/354 ("build_assert").

Ideally we would get some compiler support for those.

Cheers,
Miguel

