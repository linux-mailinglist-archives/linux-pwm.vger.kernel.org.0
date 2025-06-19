Return-Path: <linux-pwm+bounces-6448-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9AEAE0E53
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 21:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149893AB363
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789D24679C;
	Thu, 19 Jun 2025 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7jPXHyk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29904246787;
	Thu, 19 Jun 2025 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363031; cv=none; b=QKQIum5L7T1sSmNaGqOU07TMnF25sAExAyJ+vjemf/7+9gy3+vsetimcrrAQoxDyX/ml9JR4XSAKJWqkVJmXQieOMJDHF0ka1WeQo7V2WzePjrl0/DEdQG2w2uYxcw5hcAcjr01hAlU66k3rTFKmm0S667DFjj8t6jUq7kcCyGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363031; c=relaxed/simple;
	bh=ibWzxSUcPdGpnUffjV9oSw3Mgv/hOA1CQ+xqnIiMa/A=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=cX9UJ07YH+reXPk5AEboCfsH5wr7R6O3S1TQ+SQUk2e8kKUX9jOY03BYBwitVjpwwsVmKyv1kch9+vMOat0Ay17G70WZBqcqwnIs7zO6nA9tZqL90CjQBkDJhshyEklH7FAH1dgsX7/0j81aCoqjrQJfsbEiS8cW6o8Yk3dfaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7jPXHyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88289C4CEEE;
	Thu, 19 Jun 2025 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750363030;
	bh=ibWzxSUcPdGpnUffjV9oSw3Mgv/hOA1CQ+xqnIiMa/A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=g7jPXHykDJy4xCaKiVKrMn/tusr/gawzeCFHZsc615sMC0WdBFcbe0OEa/N2TwOU/
	 8cCrH8oAjJGS25DqiggSTogcvqHVrqG3TX2l/vfNry2tD22ByRLNj/3wo7br5XAs27
	 LbzPlS6RZBVgJ/aeKgQXXsKfz5ghIbHtulZDVyt/l4IVyTkWIXfwHi49CqD++c/KEm
	 ILBSgtmDHnclzgrdvUrpKTudmpzrPXV24U7LJ6smnPjOzyKzH1/Dine16SudrOKCaf
	 xFTD3rTebrWRDONzLhLiL2HHOSafqYpf6frftNckvxweqvVKY+Ee52uOZd32SnAOuF
	 0X3uMOw0XlNdg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250618-rust-next-pwm-working-fan-for-sending-v4-5-a6a28f2b6d8a@samsung.com>
References: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com> <CGME20250618122808eucas1p1734efef72b723602969465d6cd0c01d2@eucas1p1.samsung.com> <20250618-rust-next-pwm-working-fan-for-sending-v4-5-a6a28f2b6d8a@samsung.com>
Subject: Re: [PATCH v4 5/9] clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
To: Albert Ou <aou@eecs.berkeley.edu>, Alex Gaynor <alex.gaynor@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Fu Wei <wefu@redhat.com>, Gary Guo <gary@garyguo.net>, Guo Ren <guoren@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Trevor Gross <tmgross@umich.edu>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Date: Thu, 19 Jun 2025 12:57:09 -0700
Message-ID: <175036302986.4372.15656426260486761164@lazor>
User-Agent: alot/0.11

Quoting Michal Wilczynski (2025-06-18 05:27:38)
> Probing peripherals in the AON and PERI domains, such as the PVT thermal
> sensor and the PWM controller, can lead to boot hangs or unresponsive
> devices on the LPi4A board. The root cause is that their parent bus
> clocks ('CLK_CPU2AON_X2H' and the 'CLK_PERISYS_APB' clocks) are
> automatically gated by the kernel's power-saving mechanisms when the bus
> is perceived as idle.
>=20
> Alternative solutions were investigated, including modeling the parent
> bus in the Device Tree with 'simple-pm-bus' or refactoring the clock
> driver's parentage. The 'simple-pm-bus' approach is not viable due to
> the lack of defined bus address ranges in the hardware manual and its
> creation of improper dependencies on the 'pm_runtime' API for consumer
> drivers.
>=20
> Therefore, applying the'`CLK_IGNORE_UNUSED' flag directly to the
> essential bus clocks is the most direct and targeted fix. This prevents
> the kernel from auto-gating these buses and ensures peripherals remain
> accessible.
>=20
> This change fixes the boot hang associated with the PVT sensor and
> resolves the functional issues with the PWM controller.
>=20
> Link: https://lore.kernel.org/all/9e8a12db-236d-474c-b110-b3be96edf057@sa=
msung.com/ [1]
>=20
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

