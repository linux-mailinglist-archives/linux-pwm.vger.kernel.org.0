Return-Path: <linux-pwm+bounces-7146-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68154B323C5
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 22:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EB71D6145C
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 20:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0C2ECD12;
	Fri, 22 Aug 2025 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TREzWGI/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23226B769;
	Fri, 22 Aug 2025 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895761; cv=none; b=ESDQ7SqP0pee4xn8WuhsN3ivXr/7WpSRLt0kkIx95Xcpjc+9pdKgHwtmRUtzZptaAWEcOnCYsHmAvoqMUJCU2G+SaeBKdrQUzoxvD8RQHeLL+ubMP40gIgUOhVAbgAjzqtsRugn95GlK32EVgjQW94R9yxK2zxvYtsaNpqGhbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895761; c=relaxed/simple;
	bh=wmRCLD9hOfy0sueOqSOzM5LT8HdFfskptuv1HyGoOiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHED+wvLcLJ5IkkQ2CeTqAZvHj7iDiTct2hlEaQE+sTKOEP7m805g+qY9qQ91vjdMk161RR7uY1r+4bYsZjuFhemPB0/tTzAzqm1arnFmFHfcXAH257U3N6g1slxLIoLlEbpIbTL4GDLNwujPDF15KU39MVytPcx9YJyXSrrMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TREzWGI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E0FC4CEED;
	Fri, 22 Aug 2025 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755895761;
	bh=wmRCLD9hOfy0sueOqSOzM5LT8HdFfskptuv1HyGoOiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TREzWGI/KHNYiYiVKXn4mwg3b3FDPsPm24JWVzD9c1QWsPwZ6vnvsxHNQPR75cOJD
	 h/72DFHoP8T0ao4DFDBGMhPYmu0IpfPbmRiWJNdFGLE8YO0Pa1T9ke5JUiElqtV6JH
	 lFeNa8Tmod24lBIkxtq/BTVX2iwnt1whenapPUEn1FFg3jKjuIiKO1JD/bpDEZJIA9
	 AbpPQ+Q8zrHEMbcdMsVdOUsMkUfoVPRiZcMnwgg2ORnHfLFsr+ZZ0lQLLbpHDjcAg3
	 N/Xw7dzGn05qpazPV5vG/uSe1RTsGssQHCRo+QUHzeniWihGOHjCssXmIX9qvG88hS
	 iXu7Mi4hl2xXg==
Date: Fri, 22 Aug 2025 13:49:19 -0700
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v14 7/7] riscv: dts: thead: Add PWM fan and thermal
 control
Message-ID: <aKjXzyyYd9QneIKf@x1>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083548eucas1p2a40775d53dfd9f8608671cc20003fd7d@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-7-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-7-df2191621429@samsung.com>

On Wed, Aug 20, 2025 at 10:35:42AM +0200, Michal Wilczynski wrote:
> Add Device Tree nodes to enable a PWM controlled fan and it's associated
> thermal management for the Lichee Pi 4A board.
> 
> This enables temperature-controlled active cooling for the Lichee Pi 4A
> board based on SoC temperature.
> 
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 67 +++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Do you think it makes sense to coordinate this with the "Initial thermal
management for Lichee Pi 4A board" series [1] from Icenowy?

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/20250816093209.2600355-1-uwu@icenowy.me/

