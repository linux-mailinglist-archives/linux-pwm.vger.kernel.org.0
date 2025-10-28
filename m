Return-Path: <linux-pwm+bounces-7505-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE52C1401C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E82EF4E3C7C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799AC302143;
	Tue, 28 Oct 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixeRD/jn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB25202963;
	Tue, 28 Oct 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646181; cv=none; b=Turkksq/QV9wKsm8ylxNwC1NhlOJZ9ZC+HL4MomXgBNPeAvbN/pHCS9jLd6U+J35ljbkyLSWy1AdXmnJaZz3UzPkT+Z0AW2fkjAO/eGvFKSeOi2Lvts8/4YMU4zd9XurViygq3qfRWVLcbtqQJ3MqIGGxUkaK3V9X53rtIlce18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646181; c=relaxed/simple;
	bh=Q7g2gyuPLSJChCHcvMFGH4HAyWjvBka1p5B2EDIKhmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx+lqYrfnNY5DW7WdUEkHzbDY4YjBiwiggwTpU27hqqC/dKGMDrYqm+zBrTyHtwap3Zpo9F6oOVIP3DpXu7IHi+xQFJQ4Np3bd9lHKJIJr5Goxtb2Iekm7HwwZPz9d1XUciwjKfIdmgMNdTimsGxUlqH/+WEIvf8HIidrS//3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixeRD/jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07486C4CEE7;
	Tue, 28 Oct 2025 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761646180;
	bh=Q7g2gyuPLSJChCHcvMFGH4HAyWjvBka1p5B2EDIKhmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixeRD/jnRPrSmS9fJPaZK6MChs5+lg18GLQo/GSADRXbs35ugkCYatWhwZ9WazBWy
	 xYl0WCOzrR+CH7qFbug6hZsjm+J8QzcIndDUMmlvcIsi8Dx44OzyYM3vWa1QRyPT/N
	 Z3Lb+8jCwz77IGFIJSD7cFxXH70jygxBS2VwkYmSbFVzAxvFPc/p6m+yHhG0gYdHXR
	 JLfd1SOPTqBCr7/jVk6P0SX6QwYDy3QAg0mXjbcbNjSTk4o/lcoveRovbQDdMZT5bZ
	 2AfmkMub8lm+wvEbdx7ZyXOZXfaSvnVce96RXJaG6i3EBAIHPhqMpuDWyQeC5H93t8
	 M+RlOYpZLnI3Q==
Date: Tue, 28 Oct 2025 10:09:31 +0000
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, Elle Rhumsaa <elle@weathered-steel.dev>
Subject: Re: [PATCH v16 7/7] riscv: dts: thead: Add PWM fan and thermal
 control
Message-ID: <aQCWWxWxN9sD3Dep@gen8>
References: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
 <CGME20251016133824eucas1p29ff4403869bcf49efe1c982d42a01f52@eucas1p2.samsung.com>
 <20251016-rust-next-pwm-working-fan-for-sending-v16-7-a5df2405d2bd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-rust-next-pwm-working-fan-for-sending-v16-7-a5df2405d2bd@samsung.com>

On Thu, Oct 16, 2025 at 03:38:07PM +0200, Michal Wilczynski wrote:
> Add Device Tree nodes to enable a PWM controlled fan and it's associated
> thermal management for the Lichee Pi 4A board.
> 
> This enables temperature-controlled active cooling for the Lichee Pi 4A
> board based on SoC temperature.
> 
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 67 +++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Applied to thead-dt-for-next, thanks!

-Drew

