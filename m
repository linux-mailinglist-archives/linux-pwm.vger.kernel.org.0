Return-Path: <linux-pwm+bounces-6607-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A9AEE858
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 22:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBE51777C6
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18BF230264;
	Mon, 30 Jun 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQdPVWlE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D6F1DDA15;
	Mon, 30 Jun 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315720; cv=none; b=BGYmtOlpITrD37ZzKhaadUIhL3U4qgn/OntuRv9GGRz4slbzr3eJpZ8CfQNa/1aO8JJjg5B6pJx4aZXr8AiwlUc05u0krEfF86yL4iWTGj6Tda1M3TefPRxohXwgJzpMddYvyGPf6GrIVSk/R4IldFAOCKbURL1COIFZ4MBOiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315720; c=relaxed/simple;
	bh=tQs2Z2Qlt33u9MXNYKvC5h012PuPJ3SbrN4OrPh6WUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erO+vHyKlcLq5QwVI1nxhxQHi/H95wdTuEAe8TlBK8fE3/fQCohzmiygDg/KyOAusMFD6+Rey25GqJ8y8yaYAVc2GZRtUPM0WI3d2b6ILRZsjXbduigpQxyzVtp2Xe8BM4s2IPaGf2vB9+B8dZarrhuvCjbwu6/PFdHrvNZsgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQdPVWlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278FC4CEE3;
	Mon, 30 Jun 2025 20:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751315720;
	bh=tQs2Z2Qlt33u9MXNYKvC5h012PuPJ3SbrN4OrPh6WUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQdPVWlEXvMQf260xJdBEwJ5mye0aeV5BlmUUkJyQiwtf4pqIzmLONkUBMckpQoc9
	 W/Gf30/G7C3LEJuIqE8b2ijFpfBO2Z9jhqb2AF62IGrJXteH9c6lSB7k7fBCecGEH4
	 9S37AvxNcIpOYeUr+5NNnQoXyK81waffWOCYOZO3Wl5bJYSH5r+QSkoDh0pB6SASoa
	 DPOgBmc691vLQSaDa82hz08t8TNYhHg5WTC600Nb4o3OTeYG0VTQsUc2pi48hpm25L
	 i1KUb5f1JjCndHAgnhqZQ0svQ3XmvjKUn0GJb4HFDru94h27kWiGJGdA5EqLj0LR9j
	 3d2oOyqVsae3g==
Date: Mon, 30 Jun 2025 13:35:18 -0700
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
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 5/9] clk: thead: Mark essential bus clocks as
 CLK_IGNORE_UNUSED
Message-ID: <aGL1BjGowU3HNsYE@x1>
References: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
 <CGME20250618122808eucas1p1734efef72b723602969465d6cd0c01d2@eucas1p1.samsung.com>
 <20250618-rust-next-pwm-working-fan-for-sending-v4-5-a6a28f2b6d8a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-rust-next-pwm-working-fan-for-sending-v4-5-a6a28f2b6d8a@samsung.com>

On Wed, Jun 18, 2025 at 02:27:38PM +0200, Michal Wilczynski wrote:
> Probing peripherals in the AON and PERI domains, such as the PVT thermal
> sensor and the PWM controller, can lead to boot hangs or unresponsive
> devices on the LPi4A board. The root cause is that their parent bus
> clocks ('CLK_CPU2AON_X2H' and the 'CLK_PERISYS_APB' clocks) are
> automatically gated by the kernel's power-saving mechanisms when the bus
> is perceived as idle.
> 
> Alternative solutions were investigated, including modeling the parent
> bus in the Device Tree with 'simple-pm-bus' or refactoring the clock
> driver's parentage. The 'simple-pm-bus' approach is not viable due to
> the lack of defined bus address ranges in the hardware manual and its
> creation of improper dependencies on the 'pm_runtime' API for consumer
> drivers.
> 
> Therefore, applying the'`CLK_IGNORE_UNUSED' flag directly to the
> essential bus clocks is the most direct and targeted fix. This prevents
> the kernel from auto-gating these buses and ensures peripherals remain
> accessible.
> 
> This change fixes the boot hang associated with the PVT sensor and
> resolves the functional issues with the PWM controller.
> 
> Link: https://lore.kernel.org/all/9e8a12db-236d-474c-b110-b3be96edf057@samsung.com/ [1]
> 
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index ebfb1d59401d05443716eb0029403b01775e8f73..cf7f6bd428a0faa4611b3fc61edbbc6690e565d9 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -792,11 +792,12 @@ static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_ac
>  		0x134, BIT(8), 0);
>  static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_pd,
>  		0x134, BIT(7), 0);
> -static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd, 0x138, BIT(8), 0);
> +static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd,
> +		0x138, BIT(8), CLK_IGNORE_UNUSED);
>  static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
>  		0x140, BIT(9), CLK_IGNORE_UNUSED);
>  static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,
> -		0x150, BIT(9), 0);
> +		0x150, BIT(9), CLK_IGNORE_UNUSED);
>  static CCU_GATE(CLK_PERISYS_APB2_HCLK, perisys_apb2_hclk, "perisys-apb2-hclk", perisys_ahb_hclk_pd,
>  		0x150, BIT(10), CLK_IGNORE_UNUSED);
>  static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", perisys_ahb_hclk_pd,
> 
> -- 
> 2.34.1
> 

I've applied this patch to thead-clk-for-next [1] as commit 0370395 [2].

Thanks,
Drew

[1] https://github.com/pdp7/linux/commits/thead-clk-for-next/
[2] https://github.com/pdp7/linux/commit/0370395d45ca6dd53bb931978f0e91ac8dd6f1c5
~                                                                                                                                                     
~                                                                                                                                                     
~                                                                                                 




