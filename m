Return-Path: <linux-pwm+bounces-6606-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F941AEE849
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 22:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F02E3A38CE
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26445230BF0;
	Mon, 30 Jun 2025 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9/a6/Nx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867222E3FA;
	Mon, 30 Jun 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315246; cv=none; b=QD9k/tou/pHcR1TMBa/C/WD5M9fjscCBikQjsmo7wl1ip8jRq6pAHbwWDRX5ne0YN+THyDqPS90h8ufdqO3GHgL1PN+fJiZTOaOhxLiiX3/12gIa8afQOUhi0soihWa+GsUTddOyhJo8FIW6pX3JI3CdmB9brXgEb7R4SYuAyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315246; c=relaxed/simple;
	bh=mm6D6rN9YCLi05ZkS4Yr8AiNEs/PMDAf3hD+0ETdEvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgO9T5H3j6dY1X/W+Y+jHKz82BJ8HlulOAax6hxaiHSkyJWwo2tv6rYRsyj/nMjQM8AgLURCnrB7vnLJN0MQ06woWy+kvf6CBVJGggGsk9Ruj6QUiaIOwSsl8MBeP3V3NqpmeWBA7W4h8WB0Y81NgpQ9e0FDaiFoebX24H3vpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9/a6/Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FFEC4CEE3;
	Mon, 30 Jun 2025 20:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751315245;
	bh=mm6D6rN9YCLi05ZkS4Yr8AiNEs/PMDAf3hD+0ETdEvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9/a6/NxFgycREwnlDhrZgtvp8pAFZImQNec5/c/twV2DgQ0znTyfrop3lQKZeZ7h
	 fgQ39nnpkRhWhAyw5J5AKzgtDzpQvA8Z6tMKD+u2aCTt3+GoDm8ccE4Xg5Q9i1qZUL
	 +AD2WCWeY8ARVpccuvjwuKYMzBHzXkqT3laSqVLK03++8wYeeec8cBrN+EjhvUvlLZ
	 T9RKDw2/uEOdkpuEHNebR6fa64ajz0bL7erRyjy6bsF3BlvXYHo+XO1du383Eg2Cjc
	 pjDM2rlbVJL/SPYAj2u0PIRbIwo4D6mqHolSxIp6xoG2RrlsNvRZAJD3WF1ySGItIF
	 otdth+1F2/mOQ==
Date: Mon, 30 Jun 2025 13:27:23 -0700
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
Subject: Re: [PATCH v5 8/9] riscv: dts: thead: Add PVT node
Message-ID: <aGLzK8wTFcWuR4Zv@x1>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180907eucas1p10c0ca6b667debcc8139402d97e4ef800@eucas1p1.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-8-0ca23747c23e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-8-0ca23747c23e@samsung.com>

On Mon, Jun 23, 2025 at 08:08:56PM +0200, Michal Wilczynski wrote:
> Add PVT DT node for thermal sensor.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 26996422e1efe5d2dde68819c2cec1c3fa782a23..bef30780034e06b07aa29b27b0225ea891a4b531 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -669,6 +669,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
>  			thead,pad-group = <1>;
>  		};
>  
> +		pvt: pvt@fffff4e000 {
> +			compatible = "moortec,mr75203";
> +			reg = <0xff 0xfff4e000 0x0 0x80>,
> +			      <0xff 0xfff4e080 0x0 0x100>,
> +			      <0xff 0xfff4e180 0x0 0x680>,
> +			      <0xff 0xfff4e800 0x0 0x600>;
> +			reg-names = "common", "ts", "pd", "vm";
> +			clocks = <&aonsys_clk>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		gpio@fffff52000 {
>  			compatible = "snps,dw-apb-gpio";
>  			reg = <0xff 0xfff52000 0x0 0x1000>;
> 
> -- 
> 2.34.1
> 

The PVT sensor is useful for more than just the fan so I'm okay with
taking this even though the PWM driver has yet to be accepted. I have
applied this patch to thead-dt-for-next [1] as commit c31f289 [2].

The required clk driver fix has been applied to thead-clk-for-next [3]
as commit 0370395 [4], so PVT sensor will be able to be tested in next.

Thanks,
Drew

[1] https://github.com/pdp7/linux/commits/thead-dt-for-next/
[2] https://github.com/pdp7/linux/commit/c31f2899eab084b3557e9f9e10fc7898113ef18d
[3] https://github.com/pdp7/linux/commits/thead-clk-for-next/
[4] https://github.com/pdp7/linux/commit/0370395d45ca6dd53bb931978f0e91ac8dd6f1c5

