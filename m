Return-Path: <linux-pwm+bounces-6442-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4693AE055B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 14:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B4176E6C
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB92224B04;
	Thu, 19 Jun 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2sVfizp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943621FF33;
	Thu, 19 Jun 2025 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335563; cv=none; b=AtrmXZNfIXB9waKDrIvNj2oM9ALSipA10OMoPQHmgpTU+9ofb4gf+++RkGlHxtCkNf82zpWPmUsdKS0zp0l08q4WNpj069K9aSaxIylVtZXmVdMSf4NPSq9L2AiuVMbuuFvoU8hLsmcpUAfNMfGr8Le1QTZQrxnRh6CWrP6XefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335563; c=relaxed/simple;
	bh=wOtxYd7FeByenB+qByLpAwEF4ztZQ/PR/wXrB5umFwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClV+7hjAmzOQDhZse8UI3UsSLEfEJUQxSTk7POo6FzWj2AsFmyqkRF3n6aSi/DMtMEUesqqVsim84NBOoJdQhWtIchHfNgnv//OCde1+HkDoGo6i3O4tJMppR5ovVlLUn60H7ZT6f2jsPNcrXhm0gTlEmv2RTmcQkOxPL4JIJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2sVfizp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C403C4CEEA;
	Thu, 19 Jun 2025 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750335562;
	bh=wOtxYd7FeByenB+qByLpAwEF4ztZQ/PR/wXrB5umFwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2sVfizp/8RjiMYlKKqsnF7R2f5DhvS65P6lko53nexYpYpd6ASNO5gMQTW1b6wF9
	 zPwiLBsX5cLhpZiCkZgzQVQOdQcMQm5H1vnJNo6bpRo7GX9qHdPkm2JwDVidusIK5D
	 Z6w2GJcarqXOat8r5iPWVfDEUaiBoZyw52kVkR9sCXSqkMERPv1qaKj3KNDARM2VQD
	 Vm6vnpZ7uzpVGuZO5tF7zbSQE1TOxg29rM8rHEykwQZpestS8+PRf4NHPYVvWOL/3e
	 VEg8L8mom599SmeL2gzNC+Fe2XHzh4jLy0k0Q4NnjvunpJIwOrwDwoFWZdWUkggm8k
	 SwdbZMnO/3p+A==
Date: Thu, 19 Jun 2025 14:19:14 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <aFQAQlB6gG3CElcN@pollux>
References: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
 <CGME20250618122807eucas1p22d41cd6a9ac5131d91d41dfb09b8c92a@eucas1p2.samsung.com>
 <20250618-rust-next-pwm-working-fan-for-sending-v4-4-a6a28f2b6d8a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-rust-next-pwm-working-fan-for-sending-v4-4-a6a28f2b6d8a@samsung.com>

On Wed, Jun 18, 2025 at 02:27:37PM +0200, Michal Wilczynski wrote:

<snip>

> +    fn write_waveform(
> +        chip: &pwm::Chip,
> +        pwm: &pwm::Device,
> +        wfhw: &Self::WfHw,
> +        parent_dev: &Device<Bound>,
> +    ) -> Result {
> +        let data: &Self = chip.drvdata().ok_or(EINVAL)?;

<snip>

> +impl platform::Driver for Th1520PwmPlatformDriver {
> +    type IdInfo = ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +
> +    fn probe(
> +        pdev: &platform::Device<Core>,
> +        _id_info: Option<&Self::IdInfo>,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        let dev = pdev.as_ref();
> +        let resource = pdev.resource(0).ok_or(ENODEV)?;
> +        let iomem = pdev.ioremap_resource_sized::<TH1520_PWM_REG_SIZE>(resource)?;
> +        let clk = Clk::get(pdev.as_ref(), None)?;
> +
> +        clk.prepare_enable()?;
> +
> +        // TODO: Get exclusive ownership of the clock to prevent rate changes.
> +        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
> +        // This should be updated once it is implemented.
> +        let rate_hz = clk.rate().as_hz();
> +        if rate_hz == 0 {
> +            dev_err!(dev, "Clock rate is zero\n");
> +            return Err(EINVAL);
> +        }
> +
> +        if rate_hz > time::NSEC_PER_SEC as usize {
> +            dev_err!(
> +                dev,
> +                "Clock rate {} Hz is too high, not supported.\n",
> +                rate_hz
> +            );
> +            return Err(ERANGE);
> +        }
> +
> +        let chip = pwm::Chip::new(dev, MAX_PWM_NUM, 0)?;
> +
> +        let drvdata = KBox::new(Th1520PwmDriverData { iomem, clk }, GFP_KERNEL)?;
> +        chip.set_drvdata(drvdata);

Sorry that I didn't spot this before: Is there a reason you can't pass drvdata
directly to pwm::Chip::new()?

If not, you can initialize the pwm::Chip's drvdata on creation of the pwm::Chip.

This has the advantage that your chip.drvdata() (see write_waveform() above)
becomes infallible.

(If there are reasons this isn't possible, there are other potential solutions
to avoid chip.drvdata() to return an Option.)

> +
> +        pwm::Registration::new_foreign_owned(dev, chip, &TH1520_PWM_OPS)?;
> +
> +        Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
> +    }
> +}

