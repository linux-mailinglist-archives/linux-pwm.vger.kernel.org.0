Return-Path: <linux-pwm+bounces-6449-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC58AE107F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 02:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7533C3B23C9
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDDF1401B;
	Fri, 20 Jun 2025 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JznyF8u9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FFF4C79;
	Fri, 20 Jun 2025 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750380773; cv=none; b=o3aDJCfrwl2DaTrUZHvF4f2tVxd3UKipjSB0uZNg3e2hEh03AdNmXxbGVcx7g2wR4JRgfjwGy3yPsbqG7IGsJmjjCWhj8BBEussLgqqyJb05H9Yofn7C9H+afrn+eKTxZwyXKax4C1Ti5KZxLA0LwNgN+JpFss0YYbGh08hPh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750380773; c=relaxed/simple;
	bh=ArNMFWMOWO/Ezp/JG8136kkvpDFoqlGtBCU0I6dYd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgu8yzReZ+TD9ocIK4mCrjKlpzL1SVn3QAXSJfm4b3CQ1sn39Slz5BvR8G5ZFTFl/ZSkjmSf6hi8f9/RgUu9gsvCt8CKJXmW3Q5B/qxzDNs4tHgviWm0HUecXY1n5vFIhqV82/myWHSpIjM35RYnvCRGFg6lPnyNfDQEYH5EVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JznyF8u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5B7C4CEEA;
	Fri, 20 Jun 2025 00:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750380773;
	bh=ArNMFWMOWO/Ezp/JG8136kkvpDFoqlGtBCU0I6dYd6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JznyF8u9CMVwysl/pVIOQpzpdi4NmP+ZIvsYNyZvMGQIm1MKoSb4wvd7R1+cO2juI
	 I4E5jDmoxYdIJZt96RDM9url9J8gair5IM3+1Yw9lmP3HOUtjN6yPsWMvNlbz8wV0o
	 lNOxX8a34MO2cxTnTgQhEfzpc7CqBR8IaJLA4FtoP6HkT1PvkLXhCnF/Tq0GaGEp17
	 ppfmE+x4kieQF2y5qjAlPn+M4e5kX/b7Vn/fZVouiYTuySAT//OTJZpbB9mS3PnDXM
	 JmpawmYWS9UNfgO3FXBR6xelyIZHSkVH4TjyBUMojcZ3oGnf5IRIaAS42V/LG6f1KA
	 l/nKfcWgvf/jA==
Date: Thu, 19 Jun 2025 17:52:51 -0700
From: Drew Fustini <fustini@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/9] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <aFSw44++s7xMkJ9I@x1>
References: <CGME20250618122801eucas1p2f9ca464e9e5c8d954d5150500952aeed@eucas1p2.samsung.com>
 <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>

On Wed, Jun 18, 2025 at 02:27:33PM +0200, Michal Wilczynski wrote:
> This patch series introduces Rust support for the T-HEAD TH1520 PWM
> controller and demonstrates its use for fan control on the Sipeed Lichee
> Pi 4A board.
[snip]
> [2] - https://github.com/mwilczy/linux/commits/rust-next-pwm-working-fan-for-sending-v8/

I checked out your branch and get a compiler error about missing pwm.c:

$ make W=1 LLVM=1 ARCH=riscv
  CALL    scripts/checksyscalls.sh
  BINDGEN rust/bindings/bindings_helpers_generated.rs
rust/helpers/helpers.c:34:10: fatal error: 'pwm.c' file not found
Unable to generate bindings: clang diagnosed error: rust/helpers/helpers.c:34:10: fatal error: 'pwm.c' file not found

make[2]: *** [rust/Makefile:371: rust/bindings/bindings_helpers_generated.rs] Error 1
make[2]: *** Deleting file 'rust/bindings/bindings_helpers_generated.rs'
make[1]: *** [/home/pdp7/linux/Makefile:1280: prepare] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Did I do something wrong?

My kernel config:
ihttps://gist.github.com/pdp7/8f5b4324a43119f39d4c40158bf3325e

Thanks,
Drew


