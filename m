Return-Path: <linux-pwm+bounces-7504-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA980C1402C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CCF464459
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6B3002C8;
	Tue, 28 Oct 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DME/ZmMH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1429ACD1;
	Tue, 28 Oct 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646148; cv=none; b=NG5B1NQw7h7zFyINd2H4wejA0D/TLbOfy8GQq9iYVfIasXlEI6ArbM6lxo1s5IhOOB++LVTWdv6VrwMsnO4mj84gYFEHb68bjnPCddu/aCsM3nGPyWelPcxbk8a1n3rH/OpXqKpD/0/oOo5cK/orBrG1xiCCmO0Nw/97crEiezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646148; c=relaxed/simple;
	bh=6kNXKXkNNZS7lISKkrrbAtTK05DhAr6N4veKjlqS9es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUZ5dJL5JhbNRFhxRvKFhC7nRq+dA7qxy+Ip9WZmQ3765nS/NZvUfB3SZe8RmDvexPVA7qaypVFR39gpww68rnWvzhCr3eXtGQZ354NOM98/UZs7u2m8yiMn//qRpu+IoJw+PYeDZTgO1DX+wmEkACzCwN7tQtL43Ao0n/HewlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DME/ZmMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52031C4CEE7;
	Tue, 28 Oct 2025 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761646147;
	bh=6kNXKXkNNZS7lISKkrrbAtTK05DhAr6N4veKjlqS9es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DME/ZmMHqQrihdz2PW4W/jIpRBor6dFlx1Duk5bKqqFoKA2KQfnbdL+CQDP0BUNmS
	 xBR0lHPrzkmCz9RKNQT8rVq7bFeB0pXvV6gfJnNXXYhxrBb67dSLyrJ/iuJrNBZP3O
	 UOwDhzW3Gl4F6o9CmYDHHEKGcusVLDCPWqR8Mo/7DWHrlwO0UPe0y+QKWkz/ktHLCb
	 bos6xzvlO05nqf0KKYy2HUsNc1W3IkshKPW73P7U2Lr1kZ8w/EFZcSMnM04OGKXxTX
	 9+8QL/rd3P33pqyHXMJaM7hP/+Ff81M7i7+LVGLEL0ZFnF8AvCo0XXS7zeskWhDHH8
	 pgc1p/UCagY9g==
Date: Tue, 28 Oct 2025 10:08:58 +0000
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
Subject: Re: [PATCH v16 6/7] riscv: dts: thead: Add PWM controller node
Message-ID: <aQCWOridtd0MsG4q@gen8>
References: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
 <CGME20251016133822eucas1p15e605481cd324276ec87ab596e1527e8@eucas1p1.samsung.com>
 <20251016-rust-next-pwm-working-fan-for-sending-v16-6-a5df2405d2bd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-rust-next-pwm-working-fan-for-sending-v16-6-a5df2405d2bd@samsung.com>

On Thu, Oct 16, 2025 at 03:38:06PM +0200, Michal Wilczynski wrote:
> Add the Device Tree node for the T-HEAD TH1520 SoC's PWM controller.
> 
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to thead-dt-for-next, thanks!

-Drew

