Return-Path: <linux-pwm+bounces-7128-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE089B2E757
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 23:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406DF7B55E5
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 21:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1C2797A5;
	Wed, 20 Aug 2025 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="IV5VEQVo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453A26E71E;
	Wed, 20 Aug 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724637; cv=none; b=j5H2pnDhHeFoOmL1phKKD/vDQA9/bgFiu9ygj6Hz6Oe9F4kanUJkhnX8Q2OK9R9vWcXpJNyJHwxq3wngKWvPXY4+B4MFL6yRUykITZ3dEXRD9mLhe3phMihEiaONzdqkGsPI4L23HhnYbKeFQP8v9R0EqXJGrUog07lg04uWF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724637; c=relaxed/simple;
	bh=hmKgBpis+IhmU/njLSbfcdokWcRusKjdaMgnbPMjLEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeN4FG1NcgKQ6BVWnxmdwhzYZjF8oFeyu4DzSg867/XwhWEmXOihFSzWoNKTWyrqLbHOsDPadHlBpW1hI1LxgjvjLsA8RJ9T+BlyKCzv6dV/TjRf8YTkw72OwhkBaXAXV2R7/R9JI4rv6UbRZrfTFaPOrXATrmRGEKDZrN/Af0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=IV5VEQVo; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755724633; x=1755983833;
	bh=fqJHnlhrPYGz8GtkFmxOodoZHHUoB7YfZ5UqommjP5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IV5VEQVoGy8r89/AzX/0j0QXioXUzhM6gRPmmLQCN5UBQyJd24AztT62WANBwlsvF
	 OBIEqPQABTD3NE0h+j70ybfdc7j/+VZGoL/ejDfUT8Yr6kB5j148i5TFtgklrG9A0Y
	 teV9SLmemCWiCST6/rOdG1olNit3+JqXCJ00RDmdhWjcscyd4czJFOgaHuiqQ/AQdr
	 yz69iq22YKALJIsSH/YezhF5t0n1fNhGmNAkbp8rlWDBwDV1JEs2wEukhlIDYvSTpp
	 2qY8qgzNa2CzirJk1omn3J6sMLhOJP6I7cFcxcjXRSjiwJbiR0xeyyCov8bSYXhiL8
	 jfzP1tcP8eR8Q==
X-Pm-Submission-Id: 4c6fRC1YSqz2ScDC
Date: Wed, 20 Aug 2025 21:17:03 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
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
	Drew Fustini <fustini@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v14 6/7] riscv: dts: thead: Add PWM controller node
Message-ID: <aKY7TwrE-k-LePza@archiso>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083547eucas1p265478a3c9cf55a71e4e4b7fcfc5aadae@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-6-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-6-df2191621429@samsung.com>

On Wed, Aug 20, 2025 at 10:35:41AM +0200, Michal Wilczynski wrote:
> Add the Device Tree node for the T-HEAD TH1520 SoC's PWM controller.
> 
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 42724bf7e90e08fac326c464d0f080e3bd2cd59b..513dc6977b2633503515ad260913156fbe57d92f 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -493,6 +493,13 @@ uart2: serial@ffec010000 {
>  			status = "disabled";
>  		};
>  
> +		pwm: pwm@ffec01c000 {
> +			compatible = "thead,th1520-pwm";
> +			reg = <0xff 0xec01c000 0x0 0x4000>;
> +			clocks = <&clk CLK_PWM>;
> +			#pwm-cells = <3>;
> +		};
> +
>  		clk: clock-controller@ffef010000 {
>  			compatible = "thead,th1520-clk-ap";
>  			reg = <0xff 0xef010000 0x0 0x1000>;
> 
> -- 
> 2.34.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

