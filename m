Return-Path: <linux-pwm+bounces-6714-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7185AF8284
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969167A30B9
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA232BE7B5;
	Thu,  3 Jul 2025 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN6Y+S7/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AE2BD5BF;
	Thu,  3 Jul 2025 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577280; cv=none; b=VjwK2soWxLFwGJZUd0qSQV+HXjPHqexujPf4nymdC9vZZ007hIUA2HOwRFEmE7XSWEqHfumK3iZeaITeiYxvAPZu8zvHdVc38l98/IdiL2pio8ZayNxoI7NOVpBtWEVncJxx6YBuBK5a2M/NMWRlQ7Xkcql4ofV3imZmcb0W5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577280; c=relaxed/simple;
	bh=dT3HXJdueQ/TtIh10MafcagW9grURrInOFDiHaE4YAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8IWzOgOfjFakIadpnEwQd5DiUzWQGdrbhs8oCwIGJGOKQ7LHEiHG4bDamsKyXdYZnuVC1/xp9OQ+bFPRGBKgAETOzNQwy3AICp25TV8xDYsKdmQsQzlaw1cV4+WfGnoHkj+LyoWPJAdDC39VrrjDYteU0ajecx47x1VLesqr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN6Y+S7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674D6C4CEE3;
	Thu,  3 Jul 2025 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751577279;
	bh=dT3HXJdueQ/TtIh10MafcagW9grURrInOFDiHaE4YAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dN6Y+S7/irGC1QtJuoxuGkKwnvtHa2E3PZfRG8brGqKjhENIg5sioAaRoEwKW/GWg
	 Px8Zee01GDBXIyQpKdR6AmE7H/hcij1i6TaDgl0enlVzXeIxJK5yCFCt0ELN3RZqi7
	 MS1a85taNpTxP+e0HVLcTexZLqfXWIOHhlM8fIn5MlfpaViQm+0kGIVa6mwPb+yRQ7
	 Eihg1+bDXPdvTdYpEgh7v8qNSiPA+o+by5E1lcu1KgZLi9yRRmoaF0N1iKi5Gm+Hyl
	 AdexxqsUF/bp5/NP+pMeGcD+A3cJsi7TaRCzZFEx9PUac8awfMllymNHmf+v2xSIkC
	 IiV/b5sRd2JzQ==
Date: Thu, 3 Jul 2025 14:14:37 -0700
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
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 7/8] riscv: dts: thead: Add PWM controller node
Message-ID: <aGbyvc16om2v7Qpv@x1>
References: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
 <CGME20250702135002eucas1p29d0a0393fec6158a3ca158ea09b61cf1@eucas1p2.samsung.com>
 <20250702-rust-next-pwm-working-fan-for-sending-v7-7-67ef39ff1d29@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-rust-next-pwm-working-fan-for-sending-v7-7-67ef39ff1d29@samsung.com>

On Wed, Jul 02, 2025 at 03:45:35PM +0200, Michal Wilczynski wrote:
> Add the Device Tree node for the T-HEAD TH1520 SoC's PWM controller.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Reviewed-by: Drew Fustini <fustini@kernel.org>

I'll apply this to the thead-dt-for-next branch once the PWM driver is
accepted by Uwe.

Thanks,
Drew

