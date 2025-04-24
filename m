Return-Path: <linux-pwm+bounces-5691-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F7EA9AE2F
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44717A474C
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E31BC3C;
	Thu, 24 Apr 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxm6+iDH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97A7F9;
	Thu, 24 Apr 2025 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499680; cv=none; b=ivUdjKA1d3rfGTrgg4wZv4TrvuOZPzQTq5VOLghq2rEhpujLwpZ8e/fp4gBfSxGY1ZR3rQR0CZPCf2501cElbwdvki9nYHFtCkGkOOKM97ofHFwUGRt5CZxnm3nhSSmlt0GChhLQeBylBatXUfetYMdBdQU9/vVrheNbXvrxDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499680; c=relaxed/simple;
	bh=w4ERmlgT37R8fqbbx4uVzFLB0bFMUP+qmxc5xgde/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXtFgVrlsoRjST+hhnbzGHxcG1sfGhkI5uBskoCC+FPnTW0SwrYbvOYgICwUC6idfrMMA8kbWyLWqudv5GZNBV7ruo0CxKjGnZHAneYSrpkm8ZQyvjz3238S6S+B9KvuMBb6zH3pyeLiUT2yAhqAL2McW8mdrBJ9JiIk13nDrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxm6+iDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE734C4CEE8;
	Thu, 24 Apr 2025 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745499679;
	bh=w4ERmlgT37R8fqbbx4uVzFLB0bFMUP+qmxc5xgde/7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxm6+iDHVTleShgiF8bFeJvckCUPbkg57ANzPMtBwns7jfQzzmQz0EFJ05T112lwB
	 WMYmpudJjzcHgAOUsrdINVZwv2/j3JmqCXznxVSHQq2h8faiVnOKb2RPegnUC/8c7p
	 CHaM/QMNsb9S3xfYYv2Uod/Thx792cyS2aY6xTHFYMs9lM9RC3snvzyGXMCbGnsq0q
	 S9nGIj8WSYURRlSOIHYy78OF6pj5n9fb8Tqqt9Sn/E9qC4HqxLGOVqzFxJrudWvFAS
	 cqzpZUf5gYP+kfQp7RKfjlVq62KmV3pjTBFhnjHgok0FqDpTUNUI3do98G9jOCTAvJ
	 KbiBb+ril+iaQ==
Date: Thu, 24 Apr 2025 14:01:12 +0100
From: Lee Jones <lee@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: ukleinek@kernel.org, alexandre.torgue@foss.st.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, jic23@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, robh@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v4 2/8] mfd: stm32-lptimer: add support for stm32mp25
Message-ID: <20250424130112.GD8734@google.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
 <20250314171451.3497789-3-fabrice.gasnier@foss.st.com>
 <20250404144006.GB372032@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250404144006.GB372032@google.com>

On Fri, 04 Apr 2025, Lee Jones wrote:

> On Fri, 14 Mar 2025, Fabrice Gasnier wrote:
> 
> > Add support for STM32MP25 SoC.
> > A new hardware configuration register (HWCFGR2) has been added, to gather
> > number of capture/compare channels, autonomous mode and input capture
> > capability. The full feature set is implemented in LPTIM1/2/3/4. LPTIM5
> > supports a smaller set of features. This can now be read from HWCFGR
> > registers.
> > 
> > Add new registers to the stm32-lptimer.h: CCMR1, CCR2, HWCFGR1/2 and VERR.
> > Update the stm32_lptimer data struct so signal the number of
> > capture/compare channels to the child devices.
> > Also Remove some unused bit masks (CMPOK_ARROK / CMPOKCF_ARROKCF).
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> > Changes in V4:
> > - Add DIEROK, ARROK status flags, and their clear flags.
> > Changes in V2:
> > - rely on fallback compatible as no specific .data is associated to the
> >   driver. Compatibility is added by reading hardware configuration
> >   registers.
> > - read version register, to be used by clockevent child driver
> > - rename register/bits definitions
> > ---
> >  drivers/mfd/stm32-lptimer.c       | 33 ++++++++++++++++++++++++++-
> >  include/linux/mfd/stm32-lptimer.h | 37 ++++++++++++++++++++++++++++---
> 
> At least the Clocksource driver depends on this.
> 
> I need Acks from the other Maintainers before I can merge this.

Suggest you resubmit the set as a [RESEND] to re-gain traction.

-- 
Lee Jones [李琼斯]

