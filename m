Return-Path: <linux-pwm+bounces-5945-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72BAB5301
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 12:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91ED09A44D8
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3C25742B;
	Tue, 13 May 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGeVCKf5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90B2571A8;
	Tue, 13 May 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131446; cv=none; b=iuTUYzCTDgu49wUH0tlBKyVAmxfF1ku0IWeyIbSNAJMOCLdJW7QBwr5HzU85vc3uiygygsuw2mCIIz+jG4BaXc30dfqoxWakleLKN167B0hruQ1TDepf2wouuz02jfgWYK7DTffBUg+1KIsTOEWffR/B9KYfgA5P+3QS1UcgQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131446; c=relaxed/simple;
	bh=1gM1XLcPgvrG+ys+qc6lxYqS0BilUpTT/Xx1KYUfe40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIH3dfXLijufruJU6VWaQd9vnhhOMYzSbs54Zx0+fDzihT0H31aSMXHm/3M2uru757tbKhUYcRZZHB96/gbiVLbDwBrkpGqw+6dtHWMPXYyyBT+8/BzatB3/F9p8wHKfye74ojG360Bf2mdKvUC7tL2DcmTwQx3cBbA9kW2EBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGeVCKf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A91CC4CEED;
	Tue, 13 May 2025 10:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747131446;
	bh=1gM1XLcPgvrG+ys+qc6lxYqS0BilUpTT/Xx1KYUfe40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGeVCKf5BhAzUcwQrQNKICGlkgCNdN3dH/UoO/2nAPKY9brPthNPn8gUGIf70g9YL
	 TMf8n+iVRsClxw1Va7+bTGdReYr/vKD3+z2XaEWycSj0tjnfF6K4StAwWXmIEGGM2t
	 CVdPEf7vLcUe9uiUFWZc0RtAZw6TRwAtwYOoPByVro1hqMizQnD0Ffzm5/oIR7K3EF
	 iAtCQrA0g6iL9FD+8KfsGzSIzrcuK6tU2Q4LczOxUzE7GFd2fCdi51Xx+JUlRDQIB/
	 yfgUiX7a4O2nR/rDMwFZ5vVlaRR8NV/dAjfW9/SNuHaOJiVEaxK9i6DkmBFFSnQfWq
	 EoKuvHVSEYLkw==
Date: Tue, 13 May 2025 11:17:20 +0100
From: Lee Jones <lee@kernel.org>
To: daniel.lezcano@linaro.org, alexandre.torgue@foss.st.com,
	tglx@linutronix.de, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: ukleinek@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jic23@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: (subset) [PATCH v6 0/7] Add STM32MP25 LPTIM support: MFD, PWM,
 IIO, counter, clocksource
Message-ID: <20250513101720.GH2936510@google.com>
References: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
 <174713127684.4157861.15977616973399970511.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174713127684.4157861.15977616973399970511.b4-ty@kernel.org>

On Tue, 13 May 2025, Lee Jones wrote:

> On Tue, 29 Apr 2025 14:51:26 +0200, Fabrice Gasnier wrote:
> > This series adds support for STM32MP25 to MFD PWM, IIO, counter and
> > clocksource low-power timer (LPTIM) drivers.
> > This new variant is managed by using a new DT compatible string, hardware
> > configuration and version registers.
> > It comes with a slightly updated register set, some new features and new
> > interconnect signals inside the SoC.
> > Same feature list as on STM32MP1x is supported currently.
> > The device tree files add all instances in stm32mp251 dtsi file.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/7] dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
>       commit: 3f9ce9d0760ad68a9c20167664d026d91da66879
> [2/7] mfd: stm32-lptimer: add support for stm32mp25
>       commit: 4f8ceb0302b36c5f78bcc8d0e7cfa2372fba134c
> [3/7] clocksource: stm32-lptimer: add support for stm32mp25
>       commit: 5414bc8c57c41038b1994cd21a2cc0b8415c1544
> [4/7] pwm: stm32-lp: add support for stm32mp25
>       commit: 3f51b232c1da8e59eb562f1d81533334827a4799

In future, please match the subject format with that expected by the
subsystem.  For this, `git log --oneline -- <subsystem>` is your friend.

I changed them all for you this time.

The above patches have been applied and submitted for build testing.
Once complete, I'll follow-up with an PR for the other maintainers to
pull from.

Note to self: ib-mfd-clocksource-pwm-6.16

-- 
Lee Jones [李琼斯]

