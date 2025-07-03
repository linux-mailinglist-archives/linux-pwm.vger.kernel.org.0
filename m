Return-Path: <linux-pwm+bounces-6713-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D582AF8273
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 23:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3761C47F60
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3B2BD5BF;
	Thu,  3 Jul 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM2xOjYP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCC76C61;
	Thu,  3 Jul 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577130; cv=none; b=Geb96UBprV7kF2poC5oFIvoR0DmQzAg43MRzCVnaPwUkIshFpUxDeTezPFYj8/2Qk2G6nz83axuAP8JkD+4UpT0FPEYVWq+BBjeaMLMCAqVfjLA3OyRYFijOpuWcdmggp1dE29pc9Q5Bd3B6IHFaJeOCrI6wBLf4o4yHaTb/IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577130; c=relaxed/simple;
	bh=BccBPphFegUfvo9vaJnC2YeCQIMSxr8COvMz3kKjdFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDCkBee9PZNI2luuH+4t828tuyJdP2TMj3msA7DAoVsOxb7WA8TI7NV868vQpOUGJjgWOu/qqKPc+yw9T/jy4gyLn9E4yTwiY1LHNhbX9l2PI2d41Hp5oShoGog71yrb58AzOzfQshMI/lViayMpeRKVO+LDHUhwUNDj1sG/W54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM2xOjYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2B6C4CEEB;
	Thu,  3 Jul 2025 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751577130;
	bh=BccBPphFegUfvo9vaJnC2YeCQIMSxr8COvMz3kKjdFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MM2xOjYPR/IlHPzFnc4v2tVz/O2tS3X1RNb1e1zd37lyGL3SuN4QC2cD2rggrgojM
	 YqnQMLcCzLbZYB97rUY8sid3KisERGoNEM89VfLjSqmgPU4GFfBsbGO/oMLjNDC6CB
	 +bmZ5tUZ0Uj0Z5JJHvqMlBG5QZAUjDq9eCOGUaaLy9RA7rzjPaVijO25n2XibWN2/A
	 s4rdeHqvUtmuJ1qG71Px/2qpMUJm45f1tAwV9dQb+oTmxlm5jzgEVWE8uOiGVSnZrW
	 7OjzF+BqqRhVtSUZU8NXUsq095I++8WhR8gdQ5XmKnXnTj+i7ie+9J+OuR+w6ZyKfC
	 FOk/GBTTD0aUw==
Date: Thu, 3 Jul 2025 14:12:08 -0700
From: Drew Fustini <fustini@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 8/8] riscv: dts: thead: Add PWM fan and thermal control
Message-ID: <aGbyKAYPc3Hqc+uY@x1>
References: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
 <CGME20250702135003eucas1p114a5ce5dea469242940b7e2e44a7ad59@eucas1p1.samsung.com>
 <20250702-rust-next-pwm-working-fan-for-sending-v7-8-67ef39ff1d29@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-rust-next-pwm-working-fan-for-sending-v7-8-67ef39ff1d29@samsung.com>

On Wed, Jul 02, 2025 at 03:45:36PM +0200, Michal Wilczynski wrote:
> Add Device Tree nodes to enable a PWM controlled fan and it's associated
> thermal management for the Lichee Pi 4A board.
> 
> This enables temperature-controlled active cooling for the Lichee Pi 4A
> board based on SoC temperature.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Reviewed-by: Drew Fustini <fustini@kernel.org>

I'll apply this to the thead-dt-for-next branch once the PWM driver is
accepted by Uwe.

Thanks,
Drew

