Return-Path: <linux-pwm+bounces-6416-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2DADCFF1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E52161772
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158A33F9;
	Tue, 17 Jun 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/GWc64G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF02EF64C;
	Tue, 17 Jun 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170547; cv=none; b=cjpRvdj861QU3/OsIKT7eT0anUe4GZ4w0JUP/qgzCQc8wiqe8UI1ERs6W+L1U0sPFqAFkrtd3JoKBKfxlhXCF3Z6RinyjCCm7eHeS27QVefFtroklZPxfuQPDESUKUfZ7ODUuJuty6cKND8I6i5s3LXEBHEu33nZQ0lMOl8cuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170547; c=relaxed/simple;
	bh=vZuBZ/NNaKoHy+qHAglUSSdmBK5dd29+q/mxOIMvh84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbfiW+6lt2teaHVK3a08jiI6xGwKwksil5nJWAAdK6riJREuluq531YVQF0MDowRyXntdXJlhUepxej0Hgf4Iwh/Ch+E5zP1vMW8WcYSkfjDSDw10KTT7+VdDchq0ipAkWc2FqchpDUMtTKUsYL1QsKT9yPzrRvyKdVks8Sw7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/GWc64G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DEDC4CEF0;
	Tue, 17 Jun 2025 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750170546;
	bh=vZuBZ/NNaKoHy+qHAglUSSdmBK5dd29+q/mxOIMvh84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/GWc64G66Vuy5MgIrXBzCYErB5Q2I4uR6gECe1Ix4gejac53fgNL0sH1c8CJT0to
	 6sjnxKkIY+Dri1NME9ng3skoSb3aY1Dl/QO5iBKhpiu3I5ZXcEN6QCShKJ+IJiDcdg
	 pZuMNQNboqoWmYKwXjSDQ4FBATBhR0Lf62okWNDqSM2p/sThGwKZ2wXQpjfXKL/k3M
	 HpAyrH3KIIWMEbSNmcFPl/ySUzyQdWoWE2IE2SLpd7PAdXiY7H5/kp6eQePJG9vAJ6
	 Q1mRvt/WLKfuGDD9hj9JgXH73VqCZG3zjS18jmr/QyYUs+co+jKbMoOJdjTlLwxW89
	 1UHDRfg7kjKrA==
Date: Tue, 17 Jun 2025 16:28:58 +0200
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
Subject: Re: [PATCH v3 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <aFF7qqlexxh540FW@pollux>
References: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
 <CGME20250617140839eucas1p2d13775f8e6d34a516e93d3b426d5fb16@eucas1p2.samsung.com>
 <20250617-rust-next-pwm-working-fan-for-sending-v3-4-1cca847c6f9f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-rust-next-pwm-working-fan-for-sending-v3-4-1cca847c6f9f@samsung.com>

On Tue, Jun 17, 2025 at 04:07:27PM +0200, Michal Wilczynski wrote:
> +    fn write_waveform(
> +        chip: &mut pwm::Chip,
> +        pwm: &mut pwm::Device,

I think you can't hand out mutable references here. This would allow things like
mem::swap(), which I think are not valid on those structures.

> +        wfhw: &Self::WfHw,
> +        parent_dev: &Device<Bound>,
> +    ) -> Result {
> +        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
> +        let hwpwm = pwm.hwpwm();
> +        let iomem_guard = data.iomem.access(parent_dev)?;

Technically, this isn't a guard, hence would't call it that way.

> +        let iomap = iomem_guard.deref();
> +        let was_enabled = pwm.state().enabled();
> +
> +        if !wfhw.enabled {
> +            if was_enabled {
> +                iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
> +                iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
> +                iomap.try_write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
> +            }
> +            return Ok(());
> +        }
> +
> +        iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
> +        iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
> +        iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
> +        iomap.try_write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;

None of the offsets are known at compile time? :(

> +
> +        // The `PWM_START` bit must be written in a separate, final transaction, and
> +        // only when enabling the channel from a disabled state.
> +        if !was_enabled {
> +            iomap.try_write32(wfhw.ctrl_val | PWM_START, th1520_pwm_ctrl(hwpwm))?;
> +        }
> +
> +        dev_dbg!(
> +            chip.device(),
> +            "PWM-{}: Wrote (per: {}, duty: {})",
> +            hwpwm,
> +            wfhw.period_cycles,
> +            wfhw.duty_cycles,
> +        );
> +
> +        Ok(())
> +    }
> +}

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
> +
> +        let registration = pwm::Registration::new(chip, &TH1520_PWM_OPS)?;
> +
> +        Ok(KBox::new(
> +            Th1520PwmPlatformDriver {
> +                _registration: registration,
> +            },
> +            GFP_KERNEL,
> +        )?
> +        .into())

Here you are setting up the registration for the correct lifetime, however
drivers could extend the lifetime of the registration arbitrarily, which would
break the guarantee of the &Device<Bound> we rely on in the callbacks above
(e.g. write_waveform()).

Hence, pwm::Registration's lifetime has to be controlled by Devres. I'll also
add a corresponding comment in your registration patch.

> +    }
> +}

