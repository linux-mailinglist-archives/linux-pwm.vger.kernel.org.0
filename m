Return-Path: <linux-pwm+bounces-6811-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD437B003E1
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14561C80A8C
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636EE26A0FF;
	Thu, 10 Jul 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnatzMaX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C726A0B3;
	Thu, 10 Jul 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154918; cv=none; b=SuyyvChZMTcQT9bf75rLsj6RyLglLqYV4vuSu/W6tuzvh37iLhq0oftI+7Qwx8UcdEjnwzt8pT7gTJo6QVx1T6yiNiEvPqBBVsyCLzj3olg+ymJporPixcZbud2wMSuW1J937iW+LDzo79+oVHYVNUHB+EDUjKDCKXs9Rq0yZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154918; c=relaxed/simple;
	bh=SlMbXo298xvQjkFJyCKDy58mImmJ1m24txuya44+l64=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=kIt72RsL/qYaAY4uRPCJhL9zj6llBBtVQOv06B/JvCdo7gx2J77DlaMs2FxU2ZC1Q1izwF6XnVXAW9qj37FA0VZnuhB8RmykbAuAM/5DLa9gcIdd+F1eTTshiMuGJh6riRf5PO3stuxTO1nDoP75BtCrvj1pIGv7qpRZr29F8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnatzMaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B423C4CEE3;
	Thu, 10 Jul 2025 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752154916;
	bh=SlMbXo298xvQjkFJyCKDy58mImmJ1m24txuya44+l64=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=qnatzMaX9jyeMlbtDSEDGQ07J49VSiUNdF+y1WazyHlLZV2GgDtI9RcZhYCPMCTf4
	 L8NKGsccmI494iYQNXLWTHQx9yuXRJ22gB5/PFdV8vk1xW+uwYh8KGxWRMhhNIB3so
	 xYjo5/tiLvjFAOpfGqhtKMliOdmm3o0I/TPpoANt7U8fT8VHZwBteo18iBi68Df2NX
	 KDzIKmz9RousA36qqfDWNGr+bwQPvWJ7XT5fyr9RvSVZpE1uQxNEvIcAPLUYT1wCdh
	 3SAGXOTU1G8EbIYacwTLVeMzqsm7qY4W+d86IdE7yZZdxnsWF63i39LMlaN13d/YSt
	 Fk5lmQRLqokMw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 15:41:49 +0200
Message-Id: <DB8F2T9YIJ1B.13Q6T3CW0MV6U@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
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
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com> <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com> <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com> <DB8AQ15RTAJ2.3QXX8Q2FTFGCP@kernel.org> <e494422b-b989-4dc3-9828-b080dbf4c34d@samsung.com> <judbbl4d3z7nd2wi3grlwf3cmqgdycb5ljyyqx6r4w2zluhmwy@yxrqnf2hcnzw>
In-Reply-To: <judbbl4d3z7nd2wi3grlwf3cmqgdycb5ljyyqx6r4w2zluhmwy@yxrqnf2hcnzw>

On Thu Jul 10, 2025 at 3:36 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jul 10, 2025 at 12:29:59PM +0200, Michal Wilczynski wrote:
>> On 7/10/25 12:17, Danilo Krummrich wrote:
>> > I see that there is a new MAINTAINERS entry:
>> >=20
>> > 	PWM SUBSYSTEM BINDINGS [RUST]
>> > 	M:	Michal Wilczynski <m.wilczynski@samsung.com>
>> > 	S:	Maintained
>> > 	F:	rust/helpers/pwm.c
>> > 	F:	rust/kernel/pwm.rs
>> >=20
>> > I assume this is agreed with Uwe?
>
> I suggest to add
>
> 	L:	linux-pwm@vger.kernel.org
>
> then I'm happy with it. I'm definitively not capable to review the Rust
> details of Rust code. But I think Rust is readable enough that I can
> judge the algorithmic parts.

What about the merge strategy? Do you want to pick up patches yourself (thr=
ough
your tree), receive PRs from Michal or none of those?

