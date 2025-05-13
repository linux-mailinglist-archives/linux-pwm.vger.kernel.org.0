Return-Path: <linux-pwm+bounces-5944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA97AB52AB
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 12:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D655188775F
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385CF253B65;
	Tue, 13 May 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO9Odf6y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9725393E;
	Tue, 13 May 2025 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131281; cv=none; b=X/Q6hStIWu2vikSWx79byvCBl6XC+pBH0KQyXXdEi5VxYOW9MkJ9CT/McKVtci2BRD/E8tLAR67noJSW8k2YZCVzbmS7iAUqgSJP2Y/SmJzozxMgVolIFLAC9g0QMzkG24AleOxiCO5Z4T5BsLE4aJ2g74NuXHwUwTP3Sv0izeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131281; c=relaxed/simple;
	bh=TudxigjBRZmDuW3JVuS0UdXgbmBBti/+Bcm5HABZycc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hXR6x5V7WwM33a0MJOvdjDPp7hAC0pvCH8HoGXPcheCX0rDrAxrI5KiVcuJGQYapZq/cVh/iSj7rdzhlF5K+KCI/CoSV2gSnmZoj+UBV0bud6Vllw9PWv1eCSuTa2dzaO9h216EmFv8hRkm+kw1NQjKDn8ksNUSPLuUfJNOgmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO9Odf6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A53C4CEE4;
	Tue, 13 May 2025 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747131280;
	bh=TudxigjBRZmDuW3JVuS0UdXgbmBBti/+Bcm5HABZycc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gO9Odf6yxgKQ/tjlCyh718juS1TDEPZcF+wxJN+UoX2qvYyLv8aw+tAO+keDPD+i1
	 IT03ndNxQJAga5CuP135TsbcLg59TiGomAO/x9C2N6LKAd9YqVC6qE00olsjRw3hCx
	 WXWuat4XwWf2z/1JE75K9uADTwx4eLKypgSmhme5ihpDSAUnFLC/4pgVEc0m2lW4y7
	 58BF5P4XzyGI4VLqc2GZcsJ8NliIeOMYsDPOZmQkYZlQ1HkINCT9x+Xi+sTJGSVDoF
	 XPmrqJviP7NQA8mzw6HYC3+y0IOz6rSNaovSt+T8xdHz0ATUsQrpzPDYDXAC4G4zwH
	 wgoQ/7utBR43g==
From: Lee Jones <lee@kernel.org>
To: daniel.lezcano@linaro.org, lee@kernel.org, alexandre.torgue@foss.st.com, 
 tglx@linutronix.de, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: ukleinek@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 jic23@kernel.org, robh@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
 devicetree@vger.kernel.org, wbg@kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 olivier.moysan@foss.st.com
In-Reply-To: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
References: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
Subject: Re: (subset) [PATCH v6 0/7] Add STM32MP25 LPTIM support: MFD, PWM,
 IIO, counter, clocksource
Message-Id: <174713127684.4157861.15977616973399970511.b4-ty@kernel.org>
Date: Tue, 13 May 2025 11:14:36 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-b75d9

On Tue, 29 Apr 2025 14:51:26 +0200, Fabrice Gasnier wrote:
> This series adds support for STM32MP25 to MFD PWM, IIO, counter and
> clocksource low-power timer (LPTIM) drivers.
> This new variant is managed by using a new DT compatible string, hardware
> configuration and version registers.
> It comes with a slightly updated register set, some new features and new
> interconnect signals inside the SoC.
> Same feature list as on STM32MP1x is supported currently.
> The device tree files add all instances in stm32mp251 dtsi file.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
      commit: 3f9ce9d0760ad68a9c20167664d026d91da66879
[2/7] mfd: stm32-lptimer: add support for stm32mp25
      commit: 4f8ceb0302b36c5f78bcc8d0e7cfa2372fba134c
[3/7] clocksource: stm32-lptimer: add support for stm32mp25
      commit: 5414bc8c57c41038b1994cd21a2cc0b8415c1544
[4/7] pwm: stm32-lp: add support for stm32mp25
      commit: 3f51b232c1da8e59eb562f1d81533334827a4799

--
Lee Jones [李琼斯]


