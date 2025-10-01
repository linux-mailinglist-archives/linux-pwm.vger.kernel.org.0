Return-Path: <linux-pwm+bounces-7377-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747AABB1B57
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 22:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039012A63E4
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3582D5A01;
	Wed,  1 Oct 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="ImUQ+auC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776E1946AA;
	Wed,  1 Oct 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351892; cv=none; b=j66Z7VWqmu2KBsSFFNvXdxO7qNGQQS2/sByXtMPwJr3yIzXyZXMF1+AV6asRI6Kv6Gm6oYu9f2WOUJPQ3CJIgnmGJ6hZKJuh0IJgtwAcYSvBPAjBTcQ3LawZ11fXhrBmZ0lfcES1cwcuHxKzw5hwKb29P0sYre/QeJrkeEl/pE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351892; c=relaxed/simple;
	bh=VPaXP4qHSspQ17XY5CPQB+lhfh+9TEuQQnadpD+XA7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ6JA/VhrdqQHadV0EYCrzA9Iwuqwp30mUzsqq0sIuIXqhoyyfG5zRYASwCYL9zRrPFzGJD/wiDv1T/6AunVdt/8Mva7GYhBf1iucJ771/ZuhBl2dd1PQafHprH+LGnqz6sxfsrR79CVGMEaIHtZQAZOnEjWrob1/u4XTyCjqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=ImUQ+auC; arc=none smtp.client-ip=145.131.90.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1759351881;
	bh=QbcGgb5EQSRVJLoUkXO4xyhEsG9J13OKh/OXOofe7G8=;
	h=Date:From:To:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
	 Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:
	 List-Unsubscribe:List-Unsubscribe-Post:Autocrypt;
	b=ImUQ+auCIzrbzgelzjZy/hT/6tYbxImGUQmh64wCOdKDUl20Co1kP7cTJ9lhFDrbR
	 qQ4QZlSxRPKLJxwjRAbiuePe78ERBtTjj3yUHwpj56F9g4Lcw7rD1f4TPANFVG6jzA
	 F8rvWj2+w96g7boCQZFbxZUGtuIibAjiT8peB42+PcniofccflsEr6bINEsaBUNBqe
	 +VCQyDAPoOkVF6bO0L4BKQEtA7NcZZXU1+GXhmBxJrgTAIP/l2WYOWAw2drtpyeLBx
	 ZsINN8ZnA3JZrn9ueU0l92T0EVFjY1yF5FNaIT+VMSk6FtfjKRBYPfKM8y5CggJ8Dg
	 fI1MewDrYAc9w==
Date: Wed, 1 Oct 2025 20:51:16 +0000
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
Subject: Re: [PATCH v15 1/7] pwm: Export `pwmchip_release` for external use
Message-ID: <aN2T-IZKQfqcd7I4@archiso>
References: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
 <CGME20250930122730eucas1p11afe23eee92daac1023a826768b1f92d@eucas1p1.samsung.com>
 <20250930-rust-next-pwm-working-fan-for-sending-v15-1-5661c3090877@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-1-5661c3090877@samsung.com>

On Tue, Sep 30, 2025 at 02:20:32PM +0200, Michal Wilczynski wrote:
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
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
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
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

