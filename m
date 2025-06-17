Return-Path: <linux-pwm+bounces-6421-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5745DADDC8B
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 21:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BCC3AE849
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CC22EBB96;
	Tue, 17 Jun 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tQn+1aMb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD82EF9B3
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189391; cv=none; b=RgTG7p1A0j/FVYaRgUszUZOGhNiuWp5kvY0kakL6kx5y4vqnrrULZr6v9nTULd9oA+TzQFHcKBxe1TJFSLeik/QYTlqJK5s/KZ/OC1L08X2dFd85eWngIzMukVzf4aGoTEooe0KOTI20wC6q+o2sEvbnFWAq/O80o25Q9LOjObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189391; c=relaxed/simple;
	bh=l7SzB8NO+rrP5k4367W9aS0ArpEC+aDkSTC3pfTFz30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XDWPiLdnogVAvfOPJrjO2t1SsW7f2ENDiSSWS5GOSm0wIwGS4GfdEYuZBRBHJXZmr8W8hgFOC6orqgSQlvsdsbx/+eDsVwltN/JR/MYSHTAw+Bt8lKsE1Nta2WnIVwtgNIAcQe4oMHK5Xgywo4L78UPCiXCsjturmSzueUNBUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tQn+1aMb; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250617194308euoutp01d3a672694b9238bc98f21e4414cc7106~J6-nL_Jpt1181211812euoutp01W
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 19:43:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250617194308euoutp01d3a672694b9238bc98f21e4414cc7106~J6-nL_Jpt1181211812euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750189388;
	bh=SsrrapZlggFpVYw95Drc6h8mJo8KmYhpbhG7VYywjIs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tQn+1aMbwyFepAeZyTjCE0hzZXQjkbcCqJBGARftZbkUFKJLWTc9EfdDMG3TezNAh
	 DIlbOcm9eVbr72Cc5FNc0HMpIvgf9sldMIsyFi1JfXTsCWsUDcCuEV/qJQQp0PfA/q
	 NJT7rOLr+MUFVmvLKM0BTaZbJfXq8aja9MxXgRbc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250617194306eucas1p118ec57136b8265b7e13aeb1ea93a14b7~J6-l2QnM52077420774eucas1p1s;
	Tue, 17 Jun 2025 19:43:06 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250617194305eusmtip14ca5682a8b9fab2b3547be7105427287~J6-kraHC01904619046eusmtip1_;
	Tue, 17 Jun 2025 19:43:05 +0000 (GMT)
Message-ID: <98d6b8e5-4694-44df-9ba0-33e6c00d8183@samsung.com>
Date: Tue, 17 Jun 2025 21:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, Benno
	Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aFF7qqlexxh540FW@pollux>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250617194306eucas1p118ec57136b8265b7e13aeb1ea93a14b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250617140839eucas1p2d13775f8e6d34a516e93d3b426d5fb16
X-EPHeader: CA
X-CMS-RootMailID: 20250617140839eucas1p2d13775f8e6d34a516e93d3b426d5fb16
References: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
	<CGME20250617140839eucas1p2d13775f8e6d34a516e93d3b426d5fb16@eucas1p2.samsung.com>
	<20250617-rust-next-pwm-working-fan-for-sending-v3-4-1cca847c6f9f@samsung.com>
	<aFF7qqlexxh540FW@pollux>



On 6/17/25 16:28, Danilo Krummrich wrote:
> On Tue, Jun 17, 2025 at 04:07:27PM +0200, Michal Wilczynski wrote:
>> +    fn write_waveform(
>> +        chip: &mut pwm::Chip,
>> +        pwm: &mut pwm::Device,
> 
> I think you can't hand out mutable references here. This would allow things like
> mem::swap(), which I think are not valid on those structures.
> 
>> +        wfhw: &Self::WfHw,
>> +        parent_dev: &Device<Bound>,
>> +    ) -> Result {
>> +        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
>> +        let hwpwm = pwm.hwpwm();
>> +        let iomem_guard = data.iomem.access(parent_dev)?;
> 
> Technically, this isn't a guard, hence would't call it that way.
> 
>> +        let iomap = iomem_guard.deref();
>> +        let was_enabled = pwm.state().enabled();
>> +
>> +        if !wfhw.enabled {
>> +            if was_enabled {
>> +                iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
>> +                iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
>> +                iomap.try_write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
>> +            }
>> +            return Ok(());
>> +        }
>> +
>> +        iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
>> +        iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
>> +        iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
>> +        iomap.try_write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
> 
> None of the offsets are known at compile time? :(

Sadly they are computed based on runtime parameter hwpwm, so Rust can't
guarantee correctness during compilation :-(.

Thank you for your other feedback, appreciate it !

> 
>> +
>> +        // The `PWM_START` bit must be written in a separate, final transaction, and
>> +        // only when enabling the channel from a disabled state.
>> +        if !was_enabled {
>> +            iomap.try_write32(wfhw.ctrl_val | PWM_START, th1520_pwm_ctrl(hwpwm))?;
>> +        }
>> +
>> +        dev_dbg!(
>> +            chip.device(),
>> +            "PWM-{}: Wrote (per: {}, duty: {})",
>> +            hwpwm,
>> +            wfhw.period_cycles,
>> +            wfhw.duty_cycles,
>> +        );
>> +
>> +        Ok(())
>> +    }
>> +}
> 
> <snip>
> 
>> +impl platform::Driver for Th1520PwmPlatformDriver {
>> +    type IdInfo = ();
>> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
>> +
>> +    fn probe(
>> +        pdev: &platform::Device<Core>,
>> +        _id_info: Option<&Self::IdInfo>,
>> +    ) -> Result<Pin<KBox<Self>>> {
>> +        let dev = pdev.as_ref();
>> +        let resource = pdev.resource(0).ok_or(ENODEV)?;
>> +        let iomem = pdev.ioremap_resource_sized::<TH1520_PWM_REG_SIZE>(resource)?;
>> +        let clk = Clk::get(pdev.as_ref(), None)?;
>> +
>> +        clk.prepare_enable()?;
>> +
>> +        // TODO: Get exclusive ownership of the clock to prevent rate changes.
>> +        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
>> +        // This should be updated once it is implemented.
>> +        let rate_hz = clk.rate().as_hz();
>> +        if rate_hz == 0 {
>> +            dev_err!(dev, "Clock rate is zero\n");
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        if rate_hz > time::NSEC_PER_SEC as usize {
>> +            dev_err!(
>> +                dev,
>> +                "Clock rate {} Hz is too high, not supported.\n",
>> +                rate_hz
>> +            );
>> +            return Err(ERANGE);
>> +        }
>> +
>> +        let chip = pwm::Chip::new(dev, MAX_PWM_NUM, 0)?;
>> +
>> +        let drvdata = KBox::new(Th1520PwmDriverData { iomem, clk }, GFP_KERNEL)?;
>> +        chip.set_drvdata(drvdata);
>> +
>> +        let registration = pwm::Registration::new(chip, &TH1520_PWM_OPS)?;
>> +
>> +        Ok(KBox::new(
>> +            Th1520PwmPlatformDriver {
>> +                _registration: registration,
>> +            },
>> +            GFP_KERNEL,
>> +        )?
>> +        .into())
> 
> Here you are setting up the registration for the correct lifetime, however
> drivers could extend the lifetime of the registration arbitrarily, which would
> break the guarantee of the &Device<Bound> we rely on in the callbacks above
> (e.g. write_waveform()).
> 
> Hence, pwm::Registration's lifetime has to be controlled by Devres. I'll also
> add a corresponding comment in your registration patch.
> 
>> +    }
>> +}
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

