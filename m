Return-Path: <linux-pwm+bounces-4837-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2FAA2F3DF
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7B33A0791
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4A1F4632;
	Mon, 10 Feb 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sap1xWyb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890D2580D8;
	Mon, 10 Feb 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205855; cv=none; b=pcqKzFI6JxRQa9PRWPhOz6udfHRAzBmW1RVQ6H71Ju6+R2WOpMj1Ufx+g6NTwvppz3QkUKtbyLksH2a0JmoytLn85fUyVXnrS965wcOkeLiSX4P1LnfZqhH0nWbEfcymJcO+OzfhfGuuqc9E8NgXwjznh0YtKjj/eXbfNTXgZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205855; c=relaxed/simple;
	bh=pJIYPWJ+5c+OJAajVySyzvOkJYxLdGI/XLkulyWGlJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jhPgAQyFl7yJ+cswhFEIBQcIcqmWH9A6VCydAlwIQJB6BE8yfVvPsJMkXC2Z9U0Io3SiwAlJPw9yrySa1iBdohzbraVqHCI2NzCIimjUcl5zTymnfRYj8gzUOMZZcM6zAraSdJMPTDAWvrM0Yiomm8gokHvKRdU7D0R6jnIO/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sap1xWyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6BDC4CED1;
	Mon, 10 Feb 2025 16:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205855;
	bh=pJIYPWJ+5c+OJAajVySyzvOkJYxLdGI/XLkulyWGlJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Sap1xWyb/Xua4wOkYzVszhdi1qatQ6+kI68L3yl8aizC4TP6ZfceuQNPR4xa3UP4a
	 GcGTPc4GzCih4oxnvKRM/JRcfJuxnwVJIPoBOP1pO4+IDJnyNmdLDruSE2QX9xhwvX
	 EhUrumg/0Jp5TOiR5H4oAa8Nh6yapeQllKnvCKasdsEqs/3JdNOjgUxdnbJMtu2bKj
	 uu5e23d5Ub57GKgZKwkPFpklHe4zyCPoxx37+rrOX/YBbmpHvx75c8jQAkjW+Mm5Ih
	 f6h4+4B0fGSmfE1IbxIjpBOqxH9dXNOp9s5TIWkHXgqzUov/To0QI/h/YJy73ztR71
	 aOcRpvV+6+PbA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, ukleinek@kernel.org, alexandre.torgue@foss.st.com, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 wbg@kernel.org, jic23@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 olivier.moysan@foss.st.com
In-Reply-To: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
Subject: Re: (subset) [PATCH v3 0/8] Add STM32MP25 timers support: MFD,
 PWM, IIO and counter drivers
Message-Id: <173920585199.1896384.5521926980550161552.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 16:44:11 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 10 Jan 2025 10:19:14 +0100, Fabrice Gasnier wrote:
> This series adds STM32MP25 support on MFD PWM, IIO, counter timer drivers.
> This new timer variant is managed by using a new DT compatible string.
> It comes with a slightly updated register set, some new features and new
> interconnect signals inside the SoC. There is also a new instance (TIM20).
> Same feature list as on STM32MP1x is supported currently, except for PWM
> capture (not enabled, by DT).
> The device tree files add all instances in stm32mp251 dtsi. PWM, counter
> and trigger examples are provided for stm32mp257f-ev1 board.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: mfd: stm32-timers: add support for stm32mp25
      commit: 4c1d04d013e3e5073a7e78e57cba82c3cd81d586
[2/8] mfd: stm32-timers: add support for stm32mp25
      commit: 3c81d423568ad28540a7dab4ca8ea66ded9b352f

--
Lee Jones [李琼斯]


