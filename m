Return-Path: <linux-pwm+bounces-6125-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE1AC3C48
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C177AB64B
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770FA1F1301;
	Mon, 26 May 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdR91CGU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFB1E9B0B;
	Mon, 26 May 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250126; cv=none; b=a9iNe6lN/Ymuw3k9tleEzMAQsUXJcjJbSHg5F4RN1LZK3GyfKVYWDjIZMxaqixPgMhGohXoH+4WYmq7OtfUsWTsnB83EUXjYgn3FrFEwppXMgRfhfWWEUYDRjlW+BWuH83NVnAPVSx/eP9+dWlD78ybOa7m5TTloKrFSnY4nX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250126; c=relaxed/simple;
	bh=dN/e6uhiPG0gbtb1wPFzzVl1DX4FB152MF7H9e4ibV8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KYvIPRtMnmVBk1XYGDHZhKzfJ2VxIjfCPlsr2gKhdD5vDdwZd/VDEMxwUdmUW1cuGiU7KIr7poRNPYZUyIvMepay/JibrWdhSZlQ9BfXU5jNRkizOsMT9O8P0HL1aVW8SmOQf3QicobjmELEtq2CIyjWCR48AVzVeYprDJyWVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdR91CGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355C0C4CEE7;
	Mon, 26 May 2025 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748250125;
	bh=dN/e6uhiPG0gbtb1wPFzzVl1DX4FB152MF7H9e4ibV8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bdR91CGUEmWkCYOZTftiSKKI4OzJqQ3ATjbzVx9FaySp2fTLbRstZR0/VYQMdirxI
	 ihEUXGt2TX9j6+AEXjLgjxoy2k+75rvx+6eVrFdYy08O3SYWwNXgUc3lr9051mnF+P
	 1z4TNJ4qwATNqXRl7ZOHvgzr6FHi1RPwcWgN/RE9cz9q7nEmTNHj7xPIVGo5D5RmiZ
	 RU6FAvPeVL6ri6u6wG7lbtL46aLMGxfau3O45zztpA0mqmuJnhFaHWe2hiY1SeSEE/
	 aOhDXjTYaI7vCq5OHwCdVJENXPFQUin5ak4mR7yipel7BrfRfmmFiKE/1aoIn+CaAE
	 e9FGsdk8YMIPg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 11:01:58 +0200
Message-Id: <DA5YY0YF28GO.3DONTQDLY6VBD@kernel.org>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Drew Fustini" <drew@pdp7.com>, "Guo
 Ren" <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 0/6] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
From: "Benno Lossin" <lossin@kernel.org>
To: "Michal Wilczynski" <m.wilczynski@samsung.com>, "Drew Fustini"
 <pdp7pdp7@gmail.com>
X-Mailer: aerc 0.20.1
References: <CGME20250524211519eucas1p218997c69b98b14d3af2eb6bf4e9d3187@eucas1p2.samsung.com> <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com> <aDJGgLZ9tITwGBxq@x1> <b5f4af17-05ef-453d-8f04-283590ae5b87@samsung.com>
In-Reply-To: <b5f4af17-05ef-453d-8f04-283590ae5b87@samsung.com>

On Mon May 26, 2025 at 10:22 AM CEST, Michal Wilczynski wrote:
> On 5/25/25 00:21, Drew Fustini wrote:
>> Thanks for the patch series. It will be great to have PWM working
>> upstream.
>>=20
>> I've not built Linux with Rust before, so I'm going through the quick
>> start [1]. I've also never built Linux with LLVM before but clang seems
>> like the best compiler to use for Rust. Are you using LLVM?
>
> Hi Drew,
> You're correct, Clang is the way to go for Rust in the kernel. I also
> followed the official quick start guide. To answer your question
> directly: yes, I'm using LLVM.

Just to let you know, there is an effort to get rustc to work with a gcc
backend rustc_gcc_codegen [1]. And there also is the gccrs project [2]
trying to create a gnu Rust compiler.

[1]: https://rust-for-linux.com/rustc_codegen_gcc
[2]: https://rust-for-linux.com/gccrs

They have made a lot of progress over the last year, so we're hopeful
that they become usable in the near future. But for the moment,
Clang/LLVM is the way to go.

Hope this helps!

---
Cheers,
Benno

