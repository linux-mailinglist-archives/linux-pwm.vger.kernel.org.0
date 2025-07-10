Return-Path: <linux-pwm+bounces-6807-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33857AFFF0F
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 12:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9113B119A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F9215F4B;
	Thu, 10 Jul 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHOptsQX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C72AEF1;
	Thu, 10 Jul 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142631; cv=none; b=okiIWVyyGg3mWIG3qc4SfcmJp86fbWQBUDaTtca/d2pozphLEaez8Fr3mBCZJwN9UwglRnN2l1Rv5c/QrFZ/WD0iBBlxI8bj0aLEbPD1ki5UCjI5dN5sp4884HmZaqUS90vV4Uig1Uqk4xkBex5poPPLL7XFjZ7ThtNxFB4B4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142631; c=relaxed/simple;
	bh=fiadbZJTOVijBGDI4SQbxUWDNXsmiOttH+ylENKymGE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OyAy3DbRf19jAg9u2JqPCeSvpxESBi118AErInttl+4x8Oi7SzMfZBtQ4vG1pGqZjpTjEdcL4nPTVKCHiorVhhYpBJDnk+5TCfSXn/gQHJA3ax8e9Xe6rTIMihNksO+m7UL6a76sifFpXHntzTRueG70OmHYYEq+ksaeUxFpOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHOptsQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911DFC4CEE3;
	Thu, 10 Jul 2025 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752142630;
	bh=fiadbZJTOVijBGDI4SQbxUWDNXsmiOttH+ylENKymGE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VHOptsQXxjGrjx+Epibq7qQYdIn3VPDfFMd20JJPXeMITVuNGQLN+hXAugz3/Z+AB
	 zguJuAGrZw/QlDKd3R8XJjLNVBzyeGURC46uQ6hM8/p06xwFSufr2tP9CPbU3LAgk1
	 WbiyR0+PqAEhA8KTFN6BerhC6lA5bpl7SBWWCV+VtbOkl4PZKlMMSAY3JF+svS+T2l
	 cT7lCpYgKs4itMuClsaNV3yn4vyQjJG7UCd6al4wQ9/anCtDxwsA5KtZR0iuADWlCg
	 n5HypetI6XoXSaTtFO2bK7AG4pGTvpX7eX3Vr22Vviw/fUoJCX5kVhzVSL9AB6hzt+
	 s0uEPLD0pCj9g==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 12:17:03 +0200
Message-Id: <DB8AQ15RTAJ2.3QXX8Q2FTFGCP@kernel.org>
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Miguel Ojeda"
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
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com> <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com> <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
In-Reply-To: <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>

On Thu Jul 10, 2025 at 10:42 AM CEST, Michal Wilczynski wrote:
> I was hoping you could clarify the intended merge path for this series,
> as it introduces changes to both the Rust and PWM subsystems.
>
> Is the expectation that the Rust maintainers will take the abstraction
> patches into the Rust tree first? Or would Uwe, as the PWM maintainer,
> pull the entire series? Any guidance on the coordination would be very
> helpful.

Except for the helpers I only see PWM code, so this is fully on Uwe's purvi=
ew I
think.

I see that there is a new MAINTAINERS entry:

	PWM SUBSYSTEM BINDINGS [RUST]
	M:	Michal Wilczynski <m.wilczynski@samsung.com>
	S:	Maintained
	F:	rust/helpers/pwm.c
	F:	rust/kernel/pwm.rs

I assume this is agreed with Uwe?

In case there's no agreement yet, the typical options are:

  1) Maintain the Rust abstractions as part of the existing MAINTAINERS ent=
ry.
     Optionally, the author can be added as another maintainer or reviewer.

  2) Add a separate MAINTAINERS entry; patches / PRs still go through the s=
ame
     subsystem tree.

  3) Add a separate MAINTAINERS entry; patches don't go through the subsyst=
em
     tree (e.g. because the subsystem maintainers don't want to deal with i=
t).

I don't recommend (3), since it's really just a fallback.

The above looks like (2). In this case I recommend to also add the C mainta=
iners
as reviewers, such that they can easily follow along and specifiy the tree =
(T:).

But, of course, that's up to you and Uwe.

> I understand that it may be too late in the development cycle to merge
> the full series. If that's the case, perhaps patch 2 could be considered
> on its own, as it hasn't received comments in the last couple of
> revisions. As another possibility, patch 1 and patch 3 are dependent on
> each other and could be applied as a pair, depending on your assessment.
>
> The RISC-V driver itself would need to wait for the IoMem series merge [1=
].
>
> [1] - https://lore.kernel.org/rust-for-linux/20250704-topics-tyr-platform=
_iomem-v12-0-1d3d4bd8207d@collabora.com/
>
> Best regards,


