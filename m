Return-Path: <linux-pwm+bounces-7365-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873ABAED55
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 02:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD14716C773
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 00:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9FF9463;
	Wed,  1 Oct 2025 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdK7wDUh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF3139E;
	Wed,  1 Oct 2025 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276874; cv=none; b=F4neBTNeP99vQDzZf7456tu7C2Y2vFBY9bGrdkeGN9U6bdJ5nGhfMGIfKlOJxh5koQhFA/wF02gNMO1DpYgOMbW9BK0h43V1TYa3ulBgYchkRlyOW+vFaizAaUetM9J8c5DZug5Hxj4NTTU+Z2hSJGx7pN/pwh7cDOr3pkR6wb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276874; c=relaxed/simple;
	bh=OS51U7OU5GJ0yf/o9GaQhMdAvaYjkphStJrxtY7XLnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI5q1jBs96O+g0DHcntZpmzKO/Siq34KS3TEUKEG2NvhxYq/9KxVoiIhRW+RoAi95aK34Id2HWF9FbRsHeZfJIBfUQfwW/SRikxK/KiRBeEAjowQ5x4wN1wQ5ueMjOhKQOsrvN/SBEnLPlzuNxLPqmy0VzeKbo89buJpPA8eEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdK7wDUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E64C4CEF0;
	Wed,  1 Oct 2025 00:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276873;
	bh=OS51U7OU5GJ0yf/o9GaQhMdAvaYjkphStJrxtY7XLnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdK7wDUhqAanqU5rG9sXWDlEBCTU3CexIcGMHyiKw0YKz/JijEWlO59/TSW74OgXD
	 BZlO5Nwdwd/OIoyB68U8hG11JOyLJWTOyVPrhFiiTvLnzJMKJ5o+9YXZH5CCkBWqO5
	 OmQKto6Kx3VWX/IvEa+ea8whSIqr1PJoxOMrV61jzV3UmYA1mYlWy1alF+PvBeHccX
	 Pj0L3iNJzg86fdKGykOFi6+p0bpWvrhhkOmrmuIgNQ/DnJZLPpEsFbcV5kzcjc34RE
	 pTFSuiN+m9sEa3haCPGUtFrJuQRDoKqWJednXnht0UBdX3QSCmpDeLvw0fbBUmzwkz
	 d8aqFwpcOLxpw==
Date: Tue, 30 Sep 2025 17:01:11 -0700
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
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: Re: [PATCH v15 5/7] dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM
 controller
Message-ID: <aNxvR5eNAB3NKbtT@x1>
References: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
 <CGME20250930122735eucas1p1c49ed11a4a48155c123ead6aec4b64a2@eucas1p1.samsung.com>
 <20250930-rust-next-pwm-working-fan-for-sending-v15-5-5661c3090877@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-5-5661c3090877@samsung.com>

On Tue, Sep 30, 2025 at 02:20:36PM +0200, Michal Wilczynski wrote:
> Add the Device Tree binding documentation for the T-HEAD
> TH1520 SoC PWM controller.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Drew Fustini <fustini@kernel.org>

Minor comment: if you do end doing another rev for other reasons, then
please remove the Tested-by and use this instead:

Acked-by: Drew Fustini <fustini@kernel.org>

Thanks,
Drew

