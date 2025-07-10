Return-Path: <linux-pwm+bounces-6815-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4155B00810
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238F13A8405
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2E2741A6;
	Thu, 10 Jul 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn+yU0e9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FC198E9B;
	Thu, 10 Jul 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163594; cv=none; b=h5Bad3qassyEPCQcuHBDei4fDhV2YSNN9s8eeNO9fwp9EJTT7YhbvH+EtEFft8P0IIswEBr54byxdE0lgfhzOoZAtLRY1FvwsLj4ObgFS/XquTBGXPbCiq+VWnEjcCad9AjnyksDIyDg2GjQR1h0OR016Wo0dnybo1njOsYlkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163594; c=relaxed/simple;
	bh=Fk52qRo41GJW4xL0+HTc/RNFLjudUlL2qsEG2/excFE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MCcrpgCqrv907+dMX8wF/XwZ9FpdcC+xtV4cRAjkBuBH9L5+C/CkpnKKvkglzJMCETuhdH/FSnLb2773YS1gkyAXnXV3Um7wl4ukGmr36vUD2g8jUUJ7D6mwki59+vnxemwHEWIDl13TukDHmp+AO5kc9lFM0bkrqeTkgiut6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn+yU0e9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171ABC4CEE3;
	Thu, 10 Jul 2025 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752163593;
	bh=Fk52qRo41GJW4xL0+HTc/RNFLjudUlL2qsEG2/excFE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Wn+yU0e9Luzl4qwqU/u3K5hKm02tu5Ou1bSFcFxwq+rE28/Xfjm1wXJgV9FN+FOb0
	 HC4uxzA8QyZCfr5uiSqpnoIBrR8PXgtmNqfzaTHN1laNLrd6I00yRAizy+pDUXjr/K
	 +UzGmKFxbomOecwvxWoDUQawtejSWMMKKlxkd8UhswNKpmf1e5yNMqFlAG75B3Xm22
	 3Vyj+IDc8fhD+OuWBvL/3LDjfgtT7FnMgyz33vo3afhvFQDc9R31KrHgkbbShA352H
	 7oDEsTn90JoGAPNLkS4i6A6DvnFLq9b+4UCMLMD1gxGNDAHF4HNx9nWUGQ7c0DtXpN
	 1qzZqWBlfsHag==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 18:06:26 +0200
Message-Id: <DB8I5J8ZY7QF.2D8HEN6JX4HSZ@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com> <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com> <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com> <ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn> <e77eab1c-446f-4620-95be-d343684d1e95@samsung.com> <4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63>
In-Reply-To: <4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63>

On Thu Jul 10, 2025 at 5:25 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Hello Michal,
>
> On Thu, Jul 10, 2025 at 03:48:08PM +0200, Michal Wilczynski wrote:
>> On 7/10/25 15:10, Uwe Kleine-K=C3=B6nig wrote:
>> > On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
>> >> On 7/7/25 11:48, Michal Wilczynski wrote:
>> >>> The series is structured as follows:
>> >>>  - Expose static function pwmchip_release.
>> >=20
>> > Is this really necessary? I didn't try to understand the requirements
>> > yet, but I wonder about that. If you get the pwmchip from
>> > __pwmchip_add() the right thing to do to release it is to call
>> > pwmchip_remove(). Feels like a layer violation.
>>=20
>> It's required to prevent a memory leak in a specific, critical failure
>> scenario. The sequence of events is as follows:
>>=20
>>     pwm::Chip::new() succeeds, allocating both the C struct pwm_chip and
>>     the Rust drvdata.
>>=20
>>     pwm::Registration::register() (which calls pwmchip_add()) fails for
>>     some reason.
>

(Just trying to help clear up the confusion.)

> If you called pwmchip_alloc() but not yet pwmchip_add(), the right
> function to call for cleanup is pwmchip_put().

That is exactly what is happening when ARef<Chip> is dropped. If the refere=
nce
count drops to zero, pwmchip_release() is called, which frees the chip. How=
ever,
this would leave the driver's private data allocation behind, which is owne=
d by
the Chip instance.

So, in Rust we not only have to free the chip itself on release, but also t=
he
driver's private data. The solution Michal went for is overwriting the PWM
chip's dev->release() with a callback that drops the driver's private data =
and
subsequently calls the "original" pwmchip_release().

This is a common pattern in Rust that we use in DRM as well. One thing that=
 is
different in DRM is, that a struct drm_device (equivalent of struct pwm_chi=
p in
this case), has it's own release callback for drivers that we can attach to=
.

PWM does not have such a callback AFAICS, hence the Rust abstraction uses t=
he
underlying device's release callback and then forwards to pwmchip_release()=
.

Hope this helps. :)

