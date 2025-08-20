Return-Path: <linux-pwm+bounces-7123-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E744AB2E6A9
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D4C188A448
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15512C15A5;
	Wed, 20 Aug 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="FMcI4mfX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F1202980;
	Wed, 20 Aug 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722000; cv=none; b=lEz3SfVaDDLvqMx59jM2KwQXFjS96RESIaDyxKWDuys+Ocmd6pPkYEOT3/VEogTYp8Nd2QoNA9uGmXrB1KvDHV+CJXyq/winsJW6Zp/VWJjjwQ6ZKEf5zTMWKnfoVc1pC2XasrIvSc93Q/6wyjF9vJ/eicAZZNzo/4aj/WHZtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722000; c=relaxed/simple;
	bh=IIqfESwQuJxaUjaRPHDf7MRAkvBWGcGv7IVn3inZCvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFYGtl0n6wdRRtmJS+AWtll5orxIHq6cgX+AhO0Owl74Twu0q1HdGF7FF9UV2jjuGN3O3JkJCBfC6mD6g68u+PihI0eqgQ214J7ChPlSp5FMXlS+NKvicegz4moCZ27WajY59ws//Xh+tSnB/HMwnL3Jh68wqrSa9cvf/zQp0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=FMcI4mfX; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755721995; x=1755981195;
	bh=t7NXEEuVH/wrVVp48tGTzSJA0b9aGiHDJRGZakt3E5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FMcI4mfXJHsguwdIMwtmxDEsuImO9BKJY1sTBvFWRZA8yZrY6Kgbq0nhIkluiecMy
	 BkPqodDUdDqZ6Mh1og6ovUQ2SjBhcshD01eYmtcwRiUhZrRCpgb2t9pky3woeyUVTh
	 6CeHQXAEjtIVgllaM1rRFlCJzbFtCVIBERIyal/YhR0p1XXN4tTmaWJ0qmuD6tP6Ua
	 uW82YfbpsCWg2ppoMyavvHRP/mcs91bzWD8g3dW3qg04pIuNK1Aed5mkrA1EqK3HXA
	 AkhrgcQ81t2xssUOH+6aNVboWNRk26I4rJw0/QDdFpJDfBYOpch1cSSvZqbnklLw24
	 S64ApfpVDUw0w==
X-Pm-Submission-Id: 4c6dST1yHnz2ScP7
Date: Wed, 20 Aug 2025 20:30:57 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
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
	Drew Fustini <fustini@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v14 1/7] pwm: Export `pwmchip_release` for external use
Message-ID: <aKYwgQBt62PyCEd9@archiso>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083541eucas1p2ad7d78418576b8bc8cbddd8efe83bbe9@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-1-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-1-df2191621429@samsung.com>

On Wed, Aug 20, 2025 at 10:35:36AM +0200, Michal Wilczynski wrote:
> The upcoming Rust abstraction layer for the PWM subsystem uses a custom
> `dev->release` handler to safely manage the lifetime of its driver
> data.
> 
> To prevent leaking the memory of the `struct pwm_chip` (allocated by
> `pwmchip_alloc`), this custom handler must also call the original
> `pwmchip_release` function to complete the cleanup.
> 
> Make `pwmchip_release` a global, exported function so that it can be
> called from the Rust FFI bridge. This involves removing the `static`
> keyword, adding a prototype to the public header, and exporting the
> symbol.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/pwm/core.c  | 3 ++-
>  include/linux/pwm.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 0d66376a83ec350e0c3718959f4d794efd71595a..a33da3dff608fdff91251e5fd07b0dbd295be022 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1600,12 +1600,13 @@ void pwmchip_put(struct pwm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(pwmchip_put);
>  
> -static void pwmchip_release(struct device *pwmchip_dev)
> +void pwmchip_release(struct device *pwmchip_dev)
>  {
>  	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
>  
>  	kfree(chip);
>  }
> +EXPORT_SYMBOL_GPL(pwmchip_release);
>  
>  struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
>  {
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 8cafc483db53addf95591d1ac74287532c0fa0ee..d86061024b52172edf3845bf9252a966f120e365 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -485,6 +485,12 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
>  #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
>  void pwmchip_remove(struct pwm_chip *chip);
>  
> +/*
> + * For FFI wrapper use only:
> + * The Rust PWM abstraction needs this to properly free the pwm_chip.
> + */
> +void pwmchip_release(struct device *dev);
> +
>  int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner);
>  #define devm_pwmchip_add(dev, chip) __devm_pwmchip_add(dev, chip, THIS_MODULE)
>  
> 
> -- 
> 2.34.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

