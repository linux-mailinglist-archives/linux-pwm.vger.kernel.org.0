Return-Path: <linux-pwm+bounces-8789-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD1NAOB1+mkAPQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8789-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 00:57:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 957524D47BE
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 00:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1FF9302207E
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910432ED39;
	Tue,  5 May 2026 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="TdFzC2WV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444DC2DECB2;
	Tue,  5 May 2026 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021853; cv=pass; b=VxsEGwKfd366fNgDMDdrq+jXdofA+CFP27fFwi9ag3tfmPxB818VzfQ900gHjYywbSSs6iPWNruxLmhaquAmKTO3Osonwd6QaFU1hO1DyVkIQQmhYUopgswAP6DbUwFrJKC+HqTjXISdOfbChPcZPpMpVu96j0+a8UqJJvGuNQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021853; c=relaxed/simple;
	bh=R+ca3AMiLBWOUECbtm9IjAaUWVdGUVmacd/feCRKY2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJktJRiRjMsSPSa6KNVep5kPzwjMbF3F4RYwP1Nx4gXOP+N+P6CbRVWL4Iuhn/yifCjrYR7ZHoNzJkfzo3Uj/GC/GAc7/J7QCm+qdskqwaEjdMyg9rT/T0ORRvZqQMp8vpF6HtyLe97tpCCQiNE5oSfzo1OX0mHUHjk4tpvBBL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b=TdFzC2WV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1778021808; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TkBzLU05ksB2nEv8kqGU/EyYklw9RuRIllsqtAutyBeed/U7aSHbzP/0jA2AXvBGRMENGlyJwVsdHHrmR2YyLzF7bQwVFoZHTJoiLNeJKwwXidSQQa09Iu0g0v7b6ZLPTl0menX8L+zMQK0jLkg7Je3qa3Hpx/l0gmiBRiP2jeU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778021808; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nN1bsW6ym83D5h4xk8uw3mGGisLu7l3PYo92knzTzHs=; 
	b=liEnIGygPffnEAQtPIfEJ9KniLjismmiR4BlGvljE/DMTG3rrAWkFJrys7lSlRqxGoPzG/itVdQyrVnWPVsCUxZe/cuKSqPLqvCCUj3p1xSnjIrdmCBmOzzIw+Li1PvTz/EtdSwSFn6Ew6SLoGN2wDgPtWiv2GUyPcwhC34oDZA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778021808;
	s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=nN1bsW6ym83D5h4xk8uw3mGGisLu7l3PYo92knzTzHs=;
	b=TdFzC2WVuACGhfR1Td+zqRSNUVy1L/7MgfBuIW3cemd8j6q/F1aFES3DArc2E+zo
	FsYBaxO6hIaFKw/BUf7S0bUHxtfDoP4KUNCaw/VfXV5KNARZmBp3bW0dUSh4NRISmqj
	wcQj23tVTz7fzIyYktz/+yLzAYaHbJABNDUenuYQ=
Received: by mx.zohomail.com with SMTPS id 1778021805371420.73637190632087;
	Tue, 5 May 2026 15:56:45 -0700 (PDT)
Date: Tue, 5 May 2026 15:56:44 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com, robin.murphy@arm.com,
	markus.probst@posteo.de, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH REF 24/24] gpu: drm: tyr: use HRT lifetime for IoMem
Message-ID: <afp1rLvvdh_mo_g7@um790>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-25-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427221155.2144848-25-dakr@kernel.org>
X-Rspamd-Queue-Id: 957524D47BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8789-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deborah.brouwer@collabora.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 12:11:22AM +0200, Danilo Krummrich wrote:
> Take advantage of the lifetime-parameterized IoMem<'a> to use the
> memory mapping directly during probe, eliminating the Arc<Devres<IoMem>>
> indirection.
> 
> Since the IoMem is only used during probe, this also simplifies
> Register::read/write to be infallible -- the Devres access check is no
> longer needed, so reads return u32 directly and writes return ().

Hi Danilo,
Is the intended model that DRM drivers keep lifetime-bound resources such as
IoMem<'bound> only in platform drvdata and access them via Device::drvdata_borrow()?

Or is the expectation that drm::Driver should also have a lifetime-parameterized
Data associated type?

The reason I ask is that Tyr currently stores an MMIO handle in several areas,
(firmware, MMU/address-space management, and IRQ handling)  and it does register
accesses directly. See what we're trying to do:
https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com/

Moving IoMem<'bound> only into platform drvdata would require a big refactor
to thread &IoMem<'_> through those paths or fetch it from drvdata at each hardware
access site. So, I wanted to clarify the plan first before I start this work.

Thanks,
Deborah

> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Not yet updated to Tyr using the register!() macro, but probably good enough for
> reference.
> ---
>  drivers/gpu/drm/tyr/driver.rs | 14 ++++----
>  drivers/gpu/drm/tyr/gpu.rs    | 62 +++++++++++++++++------------------
>  drivers/gpu/drm/tyr/regs.rs   | 21 +++---------
>  3 files changed, 41 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index eaa84efdfdf7..d305ad433e03 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -10,7 +10,6 @@
>          Core,
>          Device, //
>      },
> -    devres::Devres,
>      drm,
>      drm::ioctl,
>      io::poll,
> @@ -23,7 +22,6 @@
>      sizes::SZ_2M,
>      sync::{
>          aref::ARef,
> -        Arc,
>          Mutex, //
>      },
>      time, //
> @@ -37,7 +35,7 @@
>      regs, //
>  };
>  
> -pub(crate) type IoMem = kernel::io::mem::IoMem<'static, SZ_2M>;
> +pub(crate) type IoMem = kernel::io::Mmio<SZ_2M>;
>  
>  pub(crate) struct TyrDrmDriver;
>  
> @@ -65,11 +63,11 @@ pub(crate) struct TyrDrmDeviceData {
>      pub(crate) gpu_info: GpuInfo,
>  }
>  
> -fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> -    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> +fn issue_soft_reset(dev: &Device<Bound>, iomem: &IoMem) -> Result {
> +    regs::GPU_CMD.write(iomem, regs::GPU_CMD_SOFT_RESET);
>  
>      poll::read_poll_timeout(
> -        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> +        || Ok(regs::GPU_IRQ_RAWSTAT.read(iomem)),
>          |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED != 0,
>          time::Delta::from_millis(1),
>          time::Delta::from_millis(100),
> @@ -109,12 +107,12 @@ fn probe(
>          let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
>  
>          let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
> -        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?.into_devres()?, GFP_KERNEL)?;
> +        let iomem = request.iomap_sized::<SZ_2M>()?;
>  
>          issue_soft_reset(pdev.as_ref(), &iomem)?;
>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
>  
> -        let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
> +        let gpu_info = GpuInfo::new(&iomem);
>          gpu_info.log(pdev);
>  
>          let platform: ARef<platform::Device> = pdev.into();
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index a88775160f98..bb0473c85bf7 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -10,7 +10,6 @@
>          Bound,
>          Device, //
>      },
> -    devres::Devres,
>      io::poll,
>      platform,
>      prelude::*,
> @@ -35,37 +34,36 @@
>  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
>  
>  impl GpuInfo {
> -    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
> -        let gpu_id = regs::GPU_ID.read(dev, iomem)?;
> -        let csf_id = regs::GPU_CSF_ID.read(dev, iomem)?;
> -        let gpu_rev = regs::GPU_REVID.read(dev, iomem)?;
> -        let core_features = regs::GPU_CORE_FEATURES.read(dev, iomem)?;
> -        let l2_features = regs::GPU_L2_FEATURES.read(dev, iomem)?;
> -        let tiler_features = regs::GPU_TILER_FEATURES.read(dev, iomem)?;
> -        let mem_features = regs::GPU_MEM_FEATURES.read(dev, iomem)?;
> -        let mmu_features = regs::GPU_MMU_FEATURES.read(dev, iomem)?;
> -        let thread_features = regs::GPU_THREAD_FEATURES.read(dev, iomem)?;
> -        let max_threads = regs::GPU_THREAD_MAX_THREADS.read(dev, iomem)?;
> -        let thread_max_workgroup_size = regs::GPU_THREAD_MAX_WORKGROUP_SIZE.read(dev, iomem)?;
> -        let thread_max_barrier_size = regs::GPU_THREAD_MAX_BARRIER_SIZE.read(dev, iomem)?;
> -        let coherency_features = regs::GPU_COHERENCY_FEATURES.read(dev, iomem)?;
> -
> -        let texture_features = regs::GPU_TEXTURE_FEATURES0.read(dev, iomem)?;
> -
> -        let as_present = regs::GPU_AS_PRESENT.read(dev, iomem)?;
> -
> -        let shader_present = u64::from(regs::GPU_SHADER_PRESENT_LO.read(dev, iomem)?);
> +    pub(crate) fn new(iomem: &IoMem) -> Self {
> +        let gpu_id = regs::GPU_ID.read(iomem);
> +        let csf_id = regs::GPU_CSF_ID.read(iomem);
> +        let gpu_rev = regs::GPU_REVID.read(iomem);
> +        let core_features = regs::GPU_CORE_FEATURES.read(iomem);
> +        let l2_features = regs::GPU_L2_FEATURES.read(iomem);
> +        let tiler_features = regs::GPU_TILER_FEATURES.read(iomem);
> +        let mem_features = regs::GPU_MEM_FEATURES.read(iomem);
> +        let mmu_features = regs::GPU_MMU_FEATURES.read(iomem);
> +        let thread_features = regs::GPU_THREAD_FEATURES.read(iomem);
> +        let max_threads = regs::GPU_THREAD_MAX_THREADS.read(iomem);
> +        let thread_max_workgroup_size = regs::GPU_THREAD_MAX_WORKGROUP_SIZE.read(iomem);
> +        let thread_max_barrier_size = regs::GPU_THREAD_MAX_BARRIER_SIZE.read(iomem);
> +        let coherency_features = regs::GPU_COHERENCY_FEATURES.read(iomem);
> +
> +        let texture_features = regs::GPU_TEXTURE_FEATURES0.read(iomem);
> +
> +        let as_present = regs::GPU_AS_PRESENT.read(iomem);
> +
> +        let shader_present = u64::from(regs::GPU_SHADER_PRESENT_LO.read(iomem));
>          let shader_present =
> -            shader_present | u64::from(regs::GPU_SHADER_PRESENT_HI.read(dev, iomem)?) << 32;
> +            shader_present | u64::from(regs::GPU_SHADER_PRESENT_HI.read(iomem)) << 32;
>  
> -        let tiler_present = u64::from(regs::GPU_TILER_PRESENT_LO.read(dev, iomem)?);
> -        let tiler_present =
> -            tiler_present | u64::from(regs::GPU_TILER_PRESENT_HI.read(dev, iomem)?) << 32;
> +        let tiler_present = u64::from(regs::GPU_TILER_PRESENT_LO.read(iomem));
> +        let tiler_present = tiler_present | u64::from(regs::GPU_TILER_PRESENT_HI.read(iomem)) << 32;
>  
> -        let l2_present = u64::from(regs::GPU_L2_PRESENT_LO.read(dev, iomem)?);
> -        let l2_present = l2_present | u64::from(regs::GPU_L2_PRESENT_HI.read(dev, iomem)?) << 32;
> +        let l2_present = u64::from(regs::GPU_L2_PRESENT_LO.read(iomem));
> +        let l2_present = l2_present | u64::from(regs::GPU_L2_PRESENT_HI.read(iomem)) << 32;
>  
> -        Ok(Self(uapi::drm_panthor_gpu_info {
> +        Self(uapi::drm_panthor_gpu_info {
>              gpu_id,
>              gpu_rev,
>              csf_id,
> @@ -88,7 +86,7 @@ pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
>              core_features,
>              pad: 0,
>              gpu_features: 0,
> -        }))
> +        })
>      }
>  
>      pub(crate) fn log(&self, pdev: &platform::Device) {
> @@ -208,11 +206,11 @@ fn from(value: u32) -> Self {
>  }
>  
>  /// Powers on the l2 block.
> -pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> -    regs::L2_PWRON_LO.write(dev, iomem, 1)?;
> +pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &IoMem) -> Result {
> +    regs::L2_PWRON_LO.write(iomem, 1);
>  
>      poll::read_poll_timeout(
> -        || regs::L2_READY_LO.read(dev, iomem),
> +        || Ok(regs::L2_READY_LO.read(iomem)),
>          |status| *status == 1,
>          Delta::from_millis(1),
>          Delta::from_millis(100),
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 611870c2e6af..0881b3812afd 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -7,16 +7,7 @@
>  // does.
>  #![allow(dead_code)]
>  
> -use kernel::{
> -    bits::bit_u32,
> -    device::{
> -        Bound,
> -        Device, //
> -    },
> -    devres::Devres,
> -    io::Io,
> -    prelude::*, //
> -};
> +use kernel::{bits::bit_u32, io::Io};
>  
>  use crate::driver::IoMem;
>  
> @@ -29,15 +20,13 @@
>  
>  impl<const OFFSET: usize> Register<OFFSET> {
>      #[inline]
> -    pub(crate) fn read(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<u32> {
> -        let value = (*iomem).access(dev)?.read32(OFFSET);
> -        Ok(value)
> +    pub(crate) fn read(&self, iomem: &IoMem) -> u32 {
> +        iomem.read32(OFFSET)
>      }
>  
>      #[inline]
> -    pub(crate) fn write(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>, value: u32) -> Result {
> -        (*iomem).access(dev)?.write32(value, OFFSET);
> -        Ok(())
> +    pub(crate) fn write(&self, iomem: &IoMem, value: u32) {
> +        iomem.write32(value, OFFSET);
>      }
>  }
>  
> -- 
> 2.54.0
> 

