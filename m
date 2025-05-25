Return-Path: <linux-pwm+bounces-6121-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10FEAC3453
	for <lists+linux-pwm@lfdr.de>; Sun, 25 May 2025 14:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA0D7A1DAB
	for <lists+linux-pwm@lfdr.de>; Sun, 25 May 2025 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A051EF094;
	Sun, 25 May 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxyrIglo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA031C68A6;
	Sun, 25 May 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748174617; cv=none; b=Yv0mXt0q4lLBkugPdYCYFybXlUHJ022cxmWcQvl2Qlr/KJ9uGomKyM+UB8rL1Ko9PXIjOTH/zrGgdPcNywrBtBz+wLIzN/8qpPkMP2yCLRD4DsQxanIENRLnrT9JPDJSul2TLh29o/QXZHt6MOjOray1wvV3LoaPWqy4iYThbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748174617; c=relaxed/simple;
	bh=ZroNZhDGWJdIoldyG/mgeggU87AzdoTiS+PmGR/PpdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMyma8HGTxHmXg58RWoVqrjCuPfduFFM9QNXNgIedH4WqigsXrfj2nfBM5etjRzfXVKwUzVbRKXu0v7iNLpcNovFko+r+pryIgBq113MZGziY/c+fsO2dHIedT4jZTF1IWwFBLTbdHytY3OqbVLDTwabuy9UiHIWXTXBDqbgWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxyrIglo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3982C4CEEA;
	Sun, 25 May 2025 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748174617;
	bh=ZroNZhDGWJdIoldyG/mgeggU87AzdoTiS+PmGR/PpdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxyrIgloPxQEkwU/Tn8ICqbDkMKIEsHYjtig4BDG8X627bskdEvhXJB63YMq81H+q
	 A7ueDYXb9mKQwGU2uy72aetT0wubSV6eu1PEQkwavQ2as5t+P87lGWcEK0hLKrmFMx
	 TtDA5/mXAhyH8N8tHeKq/f/45Hl2F1TpDsIG3rTpKnu3rqXbq0wpKOs/IdWN35ZnoL
	 hbHZjbgLeRCSe0QebuwBZjzESJin8R8rKvWQbwp/ChV6AiETfbWXsjcUjM74d0dDMj
	 y7QOdo0yq62XXQ9BzBVxAcT6k6UcCySdzLY4vpnipb4MxjYNX+FrCvyEKTOeqId6mP
	 UVrLZrF4/QB8A==
Date: Sun, 25 May 2025 14:03:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <aDMHEcpJn8nyJHFV@pollux.localdomain>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>

On Sat, May 24, 2025 at 11:14:56PM +0200, Michal Wilczynski wrote:
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..4665e293e8d0bdc1a62a4e295cdaf4d47b3dd134
> --- /dev/null
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +//! Rust T-HEAD TH1520 PWM driver
> +use kernel::{c_st
> +
> +struct Th1520PwmChipData {
> +    clk: Clk,
> +    iomem: kernel::devres::Devres<IoMem<0>>,

Why IoMem<0>? If you put the expected memory region size for this chip instead
all your subsequent accesses can be iomem.write() / iomem.read() rather than the
fallible try_{read,write}() variants.

> +impl Th1520PwmChipData {
> +    fn _config(
> +        &self,
> +        hwpwm: u32,
> +        duty_ns: u64,
> +        period_ns: u64,
> +        target_polarity: pwm::Polarity,
> +    ) -> Result<u32> {
> +        let regs = self.iomem.try_access().ok_or_else(|| {
> +            pr_err!("PWM-{}: Failed to access I/O memory in _config\n", hwpwm);

Here and throughout the whole driver, please use the dev_*!() print macros.
Drivers have no reason to use the pr_*!() macros.

> +impl pwm::PwmOps for Th1520PwmChipData {
> +    // This driver implements get_state
> +    fn apply(
> +        pwm_chip_ref: &mut pwm::Chip,
> +        pwm_dev: &mut pwm::Device,
> +        target_state: &pwm::State,
> +    ) -> Result {

I assume those callbacks can't race with pwmchip_remove() called from driver
remove()? I.e. the callbacks are guaranteed to complete before pwmchip_remove()
completes?

If so, this function signature can provide the parent device of the pwm::Chip as
device::Device<device::Bound> reference.

This would allow you to access iomem more efficiently.

Instead of

	data.iomem.try_access()

you could do

	data.iomem.access(parent) // [1]

which does get you rid of the atomic check and the RCU read side critical
section implied by try_access().

Actually, I should have added this comment and explanation to the abstraction
patch, but forgot about it. :)

[1] https://gitlab.freedesktop.org/drm/kernel/-/blob/drm-next/rust/kernel/devres.rs?ref_type=heads#L213

