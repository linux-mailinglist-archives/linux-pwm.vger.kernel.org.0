Return-Path: <linux-pwm+bounces-6245-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15FACEDDF
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CDB170A3F
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jun 2025 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D3217654;
	Thu,  5 Jun 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua9Z62JT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904B142A97;
	Thu,  5 Jun 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119958; cv=none; b=N7cLqOmZLmt25+7+fgzGJq1LosVimvCFPwMOsrPVIoY4fXaFbbcYIXR3rTaf1rEakfunpT98wBy/9+YGJQJdMxqmoQSFt1xudnX+mAIeGHiS1srxT9asgdG8OVG3w+qeCJc4cl7XktZ7HKnGxGOru9dRXAL1vOxzfMYIhV6BixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119958; c=relaxed/simple;
	bh=7OhA0PovjsmvN9Ea8pjicG1JaTKuYtzo56D5nmggPkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoMLEzVjC8otzBElIPIwt+tb3rgDFkX1IrrtAmlm6sqh1aSZEWVhVL9fhocgKl8ogTPgjC6Ln81fpMU86Nvyj+TYljDCIuqD2GNERLUZNE5TL87ABBjPqnOOhlgBVEY+2hdYtXifND+WpD2KS1u597suL333UiDd8DpZR2fgO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua9Z62JT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4C6C4CEE7;
	Thu,  5 Jun 2025 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749119957;
	bh=7OhA0PovjsmvN9Ea8pjicG1JaTKuYtzo56D5nmggPkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ua9Z62JTbGBwyF7nkPI9iUc5Lu6bHbSiOu05EB1wU24/vXt6tLEJpTaTLZlTBhDBy
	 nZ4zpxoPDwdIe/BcX9n1otNSJe3fi+t1ChyT89C1kmf5c5n2yliUMsuO9oXgV/QZ2E
	 3HIDyWcQwc1jLgyUje1d037D5dqyi5HQEJ3tfGeNFkAKAkfP6Ol5+QqRR+M1U6vK4W
	 N3siwD8vc/H/pXwVMmEd++AttR+sBGmg8g85Kcdz9EY2/g4hkjARLn96FKs87nsTfv
	 ffklBq1zBtNhqOlipgFbTzxq9u10nYsQHUwO77ELFSD/tXijCR6VaR+g7uHanXmHc4
	 BVLq2DrXd6T+w==
Date: Thu, 5 Jun 2025 12:39:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <q6dkihyfosi3k4mtrvyff54nbsjpovmujdbmoqhapo7daznpja@of2p5gtmcq2m>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ilvp5okyjxiiq75c"
Content-Disposition: inline
In-Reply-To: <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>


--ilvp5okyjxiiq75c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
MIME-Version: 1.0

Hello,

I don't speak Rust, so please double-check all my feedback if it really
applies.

On Sat, May 24, 2025 at 11:14:56PM +0200, Michal Wilczynski wrote:
> Introduce a PWM driver for the T-HEAD TH1520 SoC written in Rust. It
> utilizes the Rust PWM abstractions added in the previous commit.
>=20
> The driver implements the standard PwmOps for the PWM framework,
> supporting configuration of period, duty cycle, and polarity for the
> TH1520's PWM channels. It uses devm managed resources for the PWM chip
> itself and Rust DevRes for I/O memory. Clock management is handled using
> Rust's RAII pattern.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/pwm/Kconfig       |   6 +
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm_th1520.rs | 272 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 280 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b080e8f3d873b1e401b3a2fe1207c224c4591fc..0cfac73aea65076c5ccb50a25=
ea686fb86b472b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20986,6 +20986,7 @@ F:	drivers/mailbox/mailbox-th1520.c
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
>  F:	drivers/pmdomain/thead/
> +F:	drivers/pwm/pwm_th1520.rs
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>  F:	include/dt-bindings/power/thead,th1520-power.h
>  F:	include/linux/firmware/thead/thead,th1520-aon.h
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b5bd5c13b3a5e5a575a0fbfb2e285f5665b7a671..796fcd8343b7c8e30f62edc2e=
0fecf0e9b1ae20e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -684,6 +684,12 @@ config PWM_TEGRA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-tegra.
> =20
> +config PWM_TH1520_RUST
> +	tristate "TH1520 PWM support (Rust)"
> +	depends on RUST_PWM_ABSTRACTIONS
> +	help
> +	  Generic PWM framework driver for TH1520 SoC.
> +
>  config PWM_TIECAP
>  	tristate "ECAP PWM support"
>  	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARC=
H_K3 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 539e0def3f82fcb866ab83a0346a15f7efdd7127..6890f860ada6f1a6ed43dd3a3=
a9584cd2fa877f3 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -70,3 +70,4 @@ obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
>  obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> +obj-$(CONFIG_PWM_TH1520_RUST)	+=3D pwm_th1520.o
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..4665e293e8d0bdc1a62a4e295=
cdaf4d47b3dd134
> --- /dev/null
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2025 Samsung Electronics Co., Ltd.
> +// Author: Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +//! Rust T-HEAD TH1520 PWM driver
> +use kernel::{c_str, clk::Clk, device, io::mem::IoMem, of, platform, prel=
ude::*, pwm, time};
> +
> +const MAX_PWM_NUM: u32 =3D 6;
> +
> +const fn th1520_pwm_chn_base(n: u32) -> u32 {
> +    n * 0x20
> +}
> +const fn th1520_pwm_ctrl(n: u32) -> u32 {
> +    th1520_pwm_chn_base(n) + 0x00
> +}
> +const fn th1520_pwm_per(n: u32) -> u32 {
> +    th1520_pwm_chn_base(n) + 0x08
> +}
> +const fn th1520_pwm_fp(n: u32) -> u32 {
> +    th1520_pwm_chn_base(n) + 0x0c
> +}
> +
> +const PWM_START: u32 =3D 1 << 0;
> +const PWM_CFG_UPDATE: u32 =3D 1 << 2;
> +const PWM_CONTINUOUS_MODE: u32 =3D 1 << 5;
> +const PWM_FPOUT: u32 =3D 1 << 8;
> +const PWM_INFACTOUT: u32 =3D 1 << 9;
> +
> +struct Th1520PwmChipData {
> +    clk: Clk,
> +    iomem: kernel::devres::Devres<IoMem<0>>,
> +}
> +
> +impl Th1520PwmChipData {
> +    fn _config(
> +        &self,
> +        hwpwm: u32,
> +        duty_ns: u64,
> +        period_ns: u64,
> +        target_polarity: pwm::Polarity,

Why "target_polarity"? duty_ns and period_ns also don't contain
"target_"?

> +    ) -> Result<u32> {
> +        let regs =3D self.iomem.try_access().ok_or_else(|| {
> +            pr_err!("PWM-{}: Failed to access I/O memory in _config\n", =
hwpwm);
> +            EBUSY
> +        })?;
> +
> +        // Calculate cycle values
> +        let rate_hz_u64 =3D self.clk.rate().as_hz() as u64;
> +
> +        if duty_ns > period_ns {
> +            pr_err!(
> +                "PWM-{}: Duty {}ns > period {}ns\n",
> +                hwpwm,
> +                duty_ns,
> +                period_ns
> +            );
> +            return Err(EINVAL);
> +        }
> +        if period_ns =3D=3D 0 {
> +            pr_err!("PWM-{}: Period is zero\n", hwpwm);
> +            return Err(EINVAL);
> +        }

You don't need to check for period_ns =3D=3D 0 explicitly. This case then
hits period_cycle =3D=3D 0 below.

> +
> +        let mut period_cycle =3D mul_div_u64(period_ns, rate_hz_u64, tim=
e::NSEC_PER_SEC as u64);

if period_ns is big and rate_hz_u64 > NSEC_PER_SEC this might overflow.

Typically refuse to probe if rate_hz_u64 > NSEC_PER_SEC and call
clk_rate_exclusive_get().

> +        if period_cycle > u32::MAX as u64 {
> +            period_cycle =3D u32::MAX as u64;
> +        }
> +        if period_cycle =3D=3D 0 {
> +            pr_err!(
> +                "PWM-{}: Calculated period_cycle is zero, not allowed by=
 HW\n",
> +                hwpwm
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let mut duty_cycle =3D mul_div_u64(duty_ns, rate_hz_u64, time::N=
SEC_PER_SEC as u64);
> +        if duty_cycle > u32::MAX as u64 {
> +            duty_cycle =3D u32::MAX as u64;
> +        }
> +
> +        let mut base_ctrl_val =3D PWM_INFACTOUT | PWM_CONTINUOUS_MODE;
> +        if target_polarity =3D=3D pwm::Polarity::Normal {
> +            // FPOUT=3D1 for Normal
> +            base_ctrl_val |=3D PWM_FPOUT;
> +        } else {
> +            // Inversed, FPOUT=3D0
> +            base_ctrl_val &=3D !PWM_FPOUT;
> +        }
> +        regs.try_write32(base_ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)=
?;
> +        pr_debug!(
> +            "PWM-{}: _config: Initial CTRL write (polarity, mode): 0x{:x=
}\n",
> +            hwpwm,
> +            base_ctrl_val
> +        );
> +
> +        // Write period and duty registers
> +        regs.try_write32(period_cycle as u32, th1520_pwm_per(hwpwm) as u=
size)?;
> +        regs.try_write32(duty_cycle as u32, th1520_pwm_fp(hwpwm) as usiz=
e)?;
> +        pr_debug!(
> +            "PWM-{}: _config: Period_cyc=3D{}, Duty_cyc=3D{}\n",
> +            hwpwm,
> +            period_cycle,
> +            duty_cycle
> +        );
> +
> +        // Apply period/duty by toggling CFG_UPDATE from 0 to 1.
> +        // The `base_ctrl_val` (just written to HW) has CFG_UPDATE=3D0. =
Now set it.
> +        let ctrl_val_for_update =3D base_ctrl_val | PWM_CFG_UPDATE;
> +        regs.try_write32(ctrl_val_for_update, th1520_pwm_ctrl(hwpwm) as =
usize)?;
> +        pr_debug!(
> +            "PWM-{}: _config: CTRL write with CFG_UPDATE: 0x{:x}\n",
> +            hwpwm,
> +            ctrl_val_for_update
> +        );
> +
> +        Ok(ctrl_val_for_update)
> +    }
> +
> +    fn _enable(&self, hwpwm: u32, ctrl_val_after_config: u32) -> Result {
> +        let regs =3D self.iomem.try_access().ok_or_else(|| {
> +            pr_err!("PWM-{}: Failed to access I/O memory in _enable\n", =
hwpwm);
> +            EBUSY
> +        })?;
> +
> +        // ctrl_val_after_config already has mode, polarity, and CFG_UPD=
ATE correctly set.
> +        // Now add the START bit. START bit auto-clears.
> +        let ctrl_to_start =3D ctrl_val_after_config | PWM_START;
> +        regs.try_write32(ctrl_to_start, th1520_pwm_ctrl(hwpwm) as usize)=
?;
> +        pr_debug!(
> +            "PWM-{}: _enable: CTRL write with START: 0x{:x}\n",
> +            hwpwm,
> +            ctrl_to_start
> +        );
> +        Ok(())
> +    }
> +
> +    fn _disable(&self, hwpwm: u32) -> Result<()> {
> +        let regs =3D self.iomem.try_access().ok_or_else(|| {
> +            pr_err!("PWM-{}: Failed to access I/O memory in _disable\n",=
 hwpwm);
> +            EINVAL
> +        })?;
> +
> +        let mut ctrl_val =3D regs.try_read32(th1520_pwm_ctrl(hwpwm) as u=
size)?;
> +        pr_debug!("PWM-{}: _disable: Read CTRL: 0x{:x}\n", hwpwm, ctrl_v=
al);
> +
> +        // Ensure CFG_UPDATE is 0 before updating duty (Limitation #4)
> +        if (ctrl_val & PWM_CFG_UPDATE) !=3D 0 {
> +            ctrl_val &=3D !PWM_CFG_UPDATE;
> +            regs.try_write32(ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
> +            pr_debug!(
> +                "PWM-{}: _disable: Cleared CFG_UPDATE, wrote CTRL: 0x{:x=
}\n",
> +                hwpwm,
> +                ctrl_val
> +            );
> +        }
> +
> +        // Set duty cycle to 0
> +        regs.try_write32(0, th1520_pwm_fp(hwpwm) as usize)?;
> +        pr_debug!("PWM-{}: _disable: Wrote 0 to DUTY (FP) register\n", h=
wpwm);
> +
> +        // Apply the 0% duty by toggling CFG_UPDATE from 0 to 1
> +        // Use the ctrl_val that has CFG_UPDATE cleared (or was already =
clear)
> +        ctrl_val |=3D PWM_CFG_UPDATE;
> +        regs.try_write32(ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
> +        pr_debug!(
> +            "PWM-{}: _disable: Set CFG_UPDATE, wrote CTRL: 0x{:x}\n",
> +            hwpwm,
> +            ctrl_val
> +        );
> +
> +        Ok(())
> +    }
> +}
> +
> +impl pwm::PwmOps for Th1520PwmChipData {
> +    // This driver implements get_state

I don't spot the get_state implementation?!

> +    fn apply(
> +        pwm_chip_ref: &mut pwm::Chip,
> +        pwm_dev: &mut pwm::Device,
> +        target_state: &pwm::State,

In C code I like these variables be called "chip", "pwm" and "state"
respectively. Is that possible here, too?

> +    ) -> Result {
> +        let data: &Th1520PwmChipData =3D pwm_chip_ref.get_drvdata().ok_o=
r(EINVAL)?;
> +        let hwpwm =3D pwm_dev.hwpwm();
> +
> +        if !target_state.enabled() {
> +            if pwm_dev.state().enabled() {
> +                data._disable(hwpwm)?;
> +            }
> +
> +            return Ok(());
> +        }
> +
> +        // Configure period, duty, and polarity.
> +        // This function also latches period/duty with CFG_UPDATE.
> +        // It returns the control value that was written with CFG_UPDATE=
 set.
> +        let ctrl_val_after_config =3D data._config(
> +            hwpwm,
> +            target_state.duty_cycle(),
> +            target_state.period(),
> +            target_state.polarity(),
> +        )?;
> +
> +        // Enable by setting START bit if it wasn't enabled before this =
apply call
> +        if !pwm_dev.state().enabled() {
> +            data._enable(hwpwm, ctrl_val_after_config)?;
> +        }
> +
> +        Ok(())
> +    }
> +}
> +
> +impl Drop for Th1520PwmChipData {
> +    fn drop(&mut self) {
> +        self.clk.disable_unprepare();
> +    }
> +}
> +
> +fn mul_div_u64(a: u64, b: u64, c: u64) -> u64 {
> +    if c =3D=3D 0 {
> +        return 0;
> +    }
> +    a.wrapping_mul(b) / c
> +}

Is this save if a * b > U64_MAX? I would have expected such a function
to already exist in generic code.

> +static TH1520_PWM_OPS: pwm::PwmOpsVTable =3D pwm::create_pwm_ops::<Th152=
0PwmChipData>();
> +
> +struct Th1520PwmPlatformDriver;
> +
> +kernel::of_device_table!(
> +    OF_TABLE,
> +    MODULE_OF_TABLE,
> +    <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
> +    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
> +);
> +
> +impl platform::Driver for Th1520PwmPlatformDriver {
> +    type IdInfo =3D ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_TA=
BLE);
> +
> +    fn probe(
> +        pdev: &platform::Device<device::Core>,
> +        _id_info: Option<&Self::IdInfo>,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        let resource =3D pdev.resource(0).ok_or(ENODEV)?;
> +        let iomem =3D pdev.ioremap_resource(&resource)?;
> +
> +        let clk =3D Clk::get(pdev.as_ref(), None)?;
> +
> +        clk.prepare_enable()?;

Is there something like devm_clk_get_enabled() such that the drop
function becomes redundant?

> +        let driver_data =3D KBox::new(Th1520PwmChipData { clk, iomem }, =
GFP_KERNEL)?;
> +        let pwm_chip =3D pwm::devm_chip_alloc(pdev.as_ref(), MAX_PWM_NUM=
, 0)?;
> +
> +        let result =3D pwm::devm_chip_add(pdev.as_ref(), pwm_chip, &TH15=
20_PWM_OPS);
> +        if result.is_err() {
> +            pr_err!("Failed to add PWM chip: {:?}\n", result);
> +            return Err(EIO);
> +        }
> +
> +        pwm_chip.set_drvdata(driver_data);
> +        pr_info!("T-HEAD TH1520 PWM probed correctly\n");

Please degrade to pr_debug. Each driver emitting a message is an
annoyance.

> +        Ok(KBox::new(Self, GFP_KERNEL)?.into())
> +    }
> +}
> +
> +kernel::module_platform_driver! {
> +    type: Th1520PwmPlatformDriver,
> +    name: "pwm_th1520",
> +    author: "Michal Wilczynski",
> +    description: "T-HEAD TH1520 PWM driver",
> +    license: "GPL v2",
> +}

Best regards
Uwe

--ilvp5okyjxiiq75c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhBc88ACgkQj4D7WH0S
/k6MCwgAmH6luE1Gvacr9B2cr0B5Oc37cNczAiM0g5LXlECg/MAyxvMyLJZU39Ty
NfypdYP4HVJ7fbaySzY8yridWfaK08J0Hlfq0oCCwBaSZ0wnV/2i1ZuJbO76PJ8I
m0JuyT5w6cQIfnUZKAfEjLGGXi/sTQoJVc/5wHbFfVA2vb398y13/cmgiu7DHqOZ
5Sec8L9rm+v5pLZN5PcdxrETfKGcFVuIWz3Un9g7wYTP/ASrXoJhZ4M1ctliAfB1
scOblaUEn4o5/SDE9NEmN56BUvUYoBMA8KsYZ1pIyDRMLwQ7CGEsw6LiDyhcAigZ
remDwm6kqooeF/7QZCPz/Bh+iYSK2g==
=WleQ
-----END PGP SIGNATURE-----

--ilvp5okyjxiiq75c--

