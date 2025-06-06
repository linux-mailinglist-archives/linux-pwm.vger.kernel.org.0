Return-Path: <linux-pwm+bounces-6258-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E1AD08EB
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 22:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B976A17A229
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B222068D;
	Fri,  6 Jun 2025 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSSCp/2x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF801218ABD;
	Fri,  6 Jun 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240589; cv=none; b=E7/9XJpcEfG//qnAQYIxuHzZpg3ThvgR7whGzuVFjmt8KYwUjiMqrDTB6z3hZocLIsZkitCYT8OSupTr8/5t/DTe5MbYjY6PJY+Lu0fy/lbmp2qNzGA3kQZ1qxLge/X0y9TRqO9L9eIoa4NB4/ARcG3HOjyYO2E5hHit3Tt8GcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240589; c=relaxed/simple;
	bh=47Vf4nOQZwM+Abm7uLMkrK0JA175p8GjRRjIrpt2/tY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gw1HK809Y1Ia2kkdHf1UPXBHdXhCq11tJVQi8RfxAg4bqMDuMz1A2V9EtVTy+XVPNkbCIwsdRC0v681yFjz+aqbjwUU277yV1hbJ4JQKc/+ZqTb4T1WYCwIDWzQfdyS+Fcv+GqPNvZ9U27o0uASQIjNJ3VSzM1f5cyCgDkMCIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSSCp/2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC0CC4CEF4;
	Fri,  6 Jun 2025 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749240588;
	bh=47Vf4nOQZwM+Abm7uLMkrK0JA175p8GjRRjIrpt2/tY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NSSCp/2x9jKNKnDQuj3wSudUxox2HuBaWGf3Pdb94Oae9y8Gh5N16NNc472FNNdo8
	 NkZvocAojxPvQj4YU006T/RuCoMnYXwqMJphIHxpPwCq0iRXVIo+MLvnAJuWPygzlI
	 6jL/FkFtlvrLMXWKJet7kVfP5CP32YgCspcHKOa8eL9bauSJkNgr7kqg4PKhjhWUbS
	 p6AfHIJHY0OTaJREXSFjHySAZ7gBjUyXWgyZ/riUHJCKa+2DiBOiQUJBookm+JnWjt
	 qlNOiFqzDHybRpL80rXTJluxCQ+WUeYv0G/27oBFcaVdsgl3J2E3+8yhGGaUgHaWmb
	 fH2VWXebOIrgA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Jun 2025 22:09:42 +0200
Message-Id: <DAFQ19RBBSQL.3OGUXOQ0PA9YH@kernel.org>
Cc: "Drew Fustini" <drew@pdp7.com>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
From: "Benno Lossin" <lossin@kernel.org>
To: "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com> <CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com> <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com> <q6dkihyfosi3k4mtrvyff54nbsjpovmujdbmoqhapo7daznpja@of2p5gtmcq2m> <b1c4792e-f997-4eba-a8ed-d2e3f76e3fdd@samsung.com>
In-Reply-To: <b1c4792e-f997-4eba-a8ed-d2e3f76e3fdd@samsung.com>

On Fri Jun 6, 2025 at 4:08 PM CEST, Michal Wilczynski wrote:
> On 6/5/25 12:39, Uwe Kleine-K=C3=B6nig wrote:
>> On Sat, May 24, 2025 at 11:14:56PM +0200, Michal Wilczynski wrote:
>>> +impl Drop for Th1520PwmChipData {
>>> +    fn drop(&mut self) {
>>> +        self.clk.disable_unprepare();
>>> +    }
>>> +}
>>> +
>>> +fn mul_div_u64(a: u64, b: u64, c: u64) -> u64 {
>>> +    if c =3D=3D 0 {
>>> +        return 0;
>>> +    }
>>> +    a.wrapping_mul(b) / c
>>> +}
>>=20
>> Is this save if a * b > U64_MAX? I would have expected such a function
>> to already exist in generic code.
>
> You're right, thank you. The wrapping_mul is unsafe due to the overflow
> risk you pointed out.

`wrapping_mul` is not `unsafe`, but the above code will result in an
incorrect result if `a * b` overflows (it won't be UB, since
`wrapping_mul` just wraps around to 0).

> The ideal solution would be to use the kernel's own mul_u64_u64_div_u64
> helper function.
>
> Rust maintainers: This binding doesn't seem to be available yet. Would a
> preparatory patch introducing a minimal rust/kernel/math.rs with  only
> this binding be the best way to proceed? It seems like a useful utility
> for more than just this driver.

Sounds good, but I would separate it into its own patch series, since
then you can iterate on both at the same time.

Are there also similar functions for signed and other sizes? If yes,
then we should add them via an extension trait on the primitive types.

---
Cheers,
Benno

