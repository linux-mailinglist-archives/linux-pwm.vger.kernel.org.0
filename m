Return-Path: <linux-pwm+bounces-6149-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E924AC4F22
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1DD189FC76
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE092701B3;
	Tue, 27 May 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCyiXWXF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90B26FA4F;
	Tue, 27 May 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350835; cv=none; b=DpFE5lofZ+wRPvsyKYUpVdYUN6ZEZ1YVAS/BzhcTXlX4x63hV59Vzaav4hp4ySs9Z+ao+jYVrGUXh4IOBRDm8uQ4cwZ1mxB7yvnfR71W8vsg4ofWEGWsxKQT5qhq6nJi9jEUfbQEIbFypYjfMUlhWChA7gXgiJk4EUYo3V/cLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350835; c=relaxed/simple;
	bh=rH0fS1EkuuKxnjq68htChxno+6ZqIneRHLz2oaYXSAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTF8XOYCCWyyzc/o5vFREOdo3r02nO2JOalOZTHIU76pQYJC7h1u3LA9R2aTu4FpejXj2CUNpgDExIm6s9QwioFTZchsbOGe8CFys4dARwXsU6H/NpWlXkSAru24RSTK+p7vkZGuBpxIZ/UFXXmx96IcxLrzFnY9jIrRxi9fUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCyiXWXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92C6C4CEE9;
	Tue, 27 May 2025 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748350835;
	bh=rH0fS1EkuuKxnjq68htChxno+6ZqIneRHLz2oaYXSAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCyiXWXF4GD5OzmsDdQm2QCmHs7Xi1pg9wMxuwnVVw/8vkuYASFSMMHdip77oyxSj
	 tG5te1IK4mq50ciNIrEYi85zEql1zCDdnDDVCGPt1CbiJ9Rs6eW8JrIErnzB21A8E+
	 q3uNIMmCP+OaD/aBHdF70fX0jjuiilWmXwyIK0MFA6Kt618+D5QeN/cAztiUxPldF1
	 I8rnRBcwKcXHPPD5xL2q9zLQ5KVR3eqODR82grqgqX2zRz9ZEyFGW9dLjjhOVvtaAo
	 IKypfo7BvCathejm9qT0X/ls7XOmb6/+Z2jz0gwXOb0ShLBLhgxULyVnX7LEIFYrop
	 h4+pKxO03RMJA==
Date: Tue, 27 May 2025 15:00:27 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: "Michal Wilczynski/Kernel (PLT) /SRPOL/Engineer/Samsung Electronics" <m.wilczynski@samsung.com>
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
Message-ID: <aDW3a1sjeWWfwaq8@cassiopeiae>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
 <aDMHEcpJn8nyJHFV@pollux.localdomain>
 <db8e34c9-daff-43d9-b79b-8ec1bc98a00f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db8e34c9-daff-43d9-b79b-8ec1bc98a00f@samsung.com>

On Tue, May 27, 2025 at 02:44:57PM +0200, Michal Wilczynski/Kernel (PLT) /SRPOL/Engineer/Samsung Electronics wrote:
> W dniu 25.05.2025 o 14:03, Danilo Krummrich pisze:
> > On Sat, May 24, 2025 at 11:14:56PM +0200, Michal Wilczynski wrote:
> >> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..4665e293e8d0bdc1a62a4e295cdaf4d47b3dd134
> >> --- /dev/null
> >> +++ b/drivers/pwm/pwm_th1520.rs
> >> @@ -0,0 +1,272 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> >> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> >> +
> >> +//! Rust T-HEAD TH1520 PWM driver
> >> +use kernel::{c_st
> >> +
> >> +struct Th1520PwmChipData {
> >> +    clk: Clk,
> >> +    iomem: kernel::devres::Devres<IoMem<0>>,
> > Why IoMem<0>? If you put the expected memory region size for this chip instead
> > all your subsequent accesses can be iomem.write() / iomem.read() rather than the
> > fallible try_{read,write}() variants.
> The size of the memory region is not known at the compile time. Instead 
> it's configured
> via Device Tree. I'm not sure why it should work differently in Rust ?

There are two sizes:

  (1) The size of the actual MMIO region, which comes from the device-tree.
  (2) The size of the MMIO region that the driver knows it requires to work.

Let's say your driver uses registers with the following offsets.

REG0_OFFSET = 0x0
REG1_OFFSET = 0x4
REG2_OFFSET = 0x100

This means that the size of (2) is 0x100 + width of REG2 (let's say 0x4), which
means that you can safely define your MMIO memory type as IoMem<0x104>.

If you subsequently call pdev.ioremap_resource_sized() it will fail on runtime
if the MMIO region defined in the device-tree does not have a size of at least
0x104, i.e. (1) < (2). That's not a problem because if (1) < (2) your driver
can't work anyways.

In return, you can call the non-try variant of the read / write methods of
IoMem, which do boundary checks on compile time and hence are infallible.

Note that this does not prevent you to still call the try variants of read /
write in case you also have to deal with dynamic offsets that are not known at
compile time.

I hope this helps.

- Danilo

