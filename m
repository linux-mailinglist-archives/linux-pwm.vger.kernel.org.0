Return-Path: <linux-pwm+bounces-6881-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC86B115AB
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 03:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B567B5F48
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 01:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29681C5F1B;
	Fri, 25 Jul 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+aJSYfp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6352BAF4;
	Fri, 25 Jul 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406236; cv=none; b=LsM3ZeHzVOJcgYQQ5G1U2h9yc2Hq0KDsXkmEoB3x8iBvKtX0+pRx7ADC4TOePsNUv21PrOavabU9zjOf2wPpg5fULloJynByk3Ye3dGfC9/XRf2Tnl5ByuXRVcPTGNXoOei/NzaQIvAeS5jPy4mmuVazfM3CzOTUQX8Vity3HgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406236; c=relaxed/simple;
	bh=MnFJ7F8dY8RvB8dXoNRYk2Dv6tZAdeeE7q2scZZoEqo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=egdeXJG1exf/9WoYJFv3gqbE5qtZRzyGlxgwz06Ns/p5601+HmSqrYG8oGAcebUbDHDJYvwRl3VuGods9YRsVS7xqCxztuj3cUhmo7ZNcDPvpZimuT9MQbLwj1mjWKrb6SIGPqX/t80drPOK+idLC+KpW15uac4GEx+g9XaVa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+aJSYfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A8CC4CEED;
	Fri, 25 Jul 2025 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753406236;
	bh=MnFJ7F8dY8RvB8dXoNRYk2Dv6tZAdeeE7q2scZZoEqo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=o+aJSYfpF5TboYnl9G/eoK+bTmhLeJ66iWVe6BHwQs3bR/2tvsw9pQxqOpyt0EOw2
	 TR+gdWEvAmJfeENxYksaR7BmiI4XrAvoEULKXdbWDm2dxTG46REvQdPhjgS4S3qaiu
	 0j9I2mS9GM//n0dGFnc+7f3FMdJ+u1Bc7g9v7KAbQCRDP8KD0RrIJD+IBXF5NqQFI1
	 EXfKIEqY1uQMhAUY1IdgJO95MPT+5mwsfTHzxNbM6DN7n/QHnOFz7+s+mOt20WEbQE
	 0vxfdpXeVLCMFrNzaKs8lLosT4jCFDObiDSRtGeW6R35BG9oAD3iEj581vNe6K8GyH
	 BM0yjnIR2/5mg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-8-0ca23747c23e@samsung.com>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com> <CGME20250623180907eucas1p10c0ca6b667debcc8139402d97e4ef800@eucas1p1.samsung.com> <20250623-rust-next-pwm-working-fan-for-sending-v5-8-0ca23747c23e@samsung.com>
Subject: Re: [PATCH v5 8/9] riscv: dts: thead: Add PVT node
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
To: Albert Ou <aou@eecs.berkeley.edu>, Alex Gaynor <alex.gaynor@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Fu Wei <wefu@redhat.com>, Gary Guo <gary@garyguo.net>, Guo Ren <guoren@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Trevor Gross <tmgross@umich.edu>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Date: Thu, 24 Jul 2025 18:17:15 -0700
Message-ID: <175340623531.3513.5896709502242556676@lazor>
User-Agent: alot/0.11

Quoting Michal Wilczynski (2025-06-23 11:08:56)
> Add PVT DT node for thermal sensor.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index 26996422e1efe5d2dde68819c2cec1c3fa782a23..bef30780034e06b07aa29b27b=
0225ea891a4b531 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -669,6 +669,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
>                         thead,pad-group =3D <1>;
>                 };
> =20
> +               pvt: pvt@fffff4e000 {

Node name should probably be 'thermal-sensor@fffff4e000' then.

