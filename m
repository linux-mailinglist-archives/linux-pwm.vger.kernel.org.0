Return-Path: <linux-pwm+bounces-4980-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA4A43EB1
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 13:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD2E3B0A5B
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D51267B1A;
	Tue, 25 Feb 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCgI0O+A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263A1FC7ED;
	Tue, 25 Feb 2025 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484818; cv=none; b=XOXXrdYI8Qm/Q4PS7ybSOf5utdiYdOe6/BA7iaVVaRzSbIVxMoLWEoU8v1B32By4yCHauBiRl3a8D3jEj5EohJrQ3A/e4usYQZqiPJU0soT/PGkGr5wsg09GBY2Tp1v1eqj3V+D+bnC+Rq504jgQf+gyh7cVzXQ6ev1dHV07fQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484818; c=relaxed/simple;
	bh=zK/7OWHlisi7f+Mu3OhLXwcUr3ILVz4O5JpSU16Ic/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHeI1SjhunOf/xyqORIYXB8JSK4+59Y2ojd25NUixWzXdYwooWK3RMDn2b5dVKvwdI0DRMAxLlym2exCY3lD3PEux+ufiEevQuFm06Prwe/nMw+VtGpUywLt0oUkX1X8nHqq8H4aaVVYmBQpgEzlN9JAKOHsUA1R26xPPdyPb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCgI0O+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11974C4CEDD;
	Tue, 25 Feb 2025 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484817;
	bh=zK/7OWHlisi7f+Mu3OhLXwcUr3ILVz4O5JpSU16Ic/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCgI0O+AW1ufry6XCxhLZnBkO/EIRWBB9+fpXUvOoB2Og05FcNmNF6XsmNZAITIJZ
	 IthKvYlg4qNweF2PF4+CEB5YnBgjJS/x0WrBc09DkHfeuwtV8piSExb4CuzuAhqA6s
	 BlqEbi3dTM4B/0g8F8qqM/UoXp9cjyDDJCyctexQV3P0AUlDQAo59UcJiR1LA92GUE
	 isP9t1+26z50TFacj3QTYLD95vbEp3OrQbf6qiIIUvyM6tIb2rqWCJa5yRFZuSNQgg
	 MYJpM8DrGg7spkhykh3AhAZXDbslZ3csNxTKimUk/GCojokiG9ifHBIm3B8FJ6YynK
	 DnG0GCOY4d4gg==
Date: Tue, 25 Feb 2025 13:00:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, ukleinek@kernel.org, alexandre.torgue@foss.st.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wbg@kernel.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 7/8] arm64: defconfig: enable STM32 LP timers drivers
Message-ID: <20250225-vague-tuscan-shark-ebec44@krzk-bin>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
 <20250224180150.3689638-8-fabrice.gasnier@foss.st.com>
 <f76a3a6c-795e-4fc8-905f-4655115ea99d@kernel.org>
 <696ac9eb-f223-4993-b288-b6c3e07f4ed7@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <696ac9eb-f223-4993-b288-b6c3e07f4ed7@foss.st.com>

On Tue, Feb 25, 2025 at 09:43:58AM +0100, Fabrice Gasnier wrote:
> On 2/25/25 08:48, Krzysztof Kozlowski wrote:
> > On 24/02/2025 19:01, Fabrice Gasnier wrote:
> >> Enable the STM32 timer drivers: MFD, counter, PWM and trigger as modules.
> >> Clocksource is a bool, hence set to y. These drivers can be used on
> >> STM32MP25.
> > 
> > 
> > Which upstream board? If you do not have upstream board, the defconfig
> > is pointless for us. It's not defconfig for your downstream forks.
> 
> Hi Krzysztof,
> 
> It's going to be used on stm32mp257f-dk and stm32mp257f-ev1 boards.

The defconfig commit should mention which upstream products use it.

> I can add the relevant DT for the(se) board(s) in next revision.

Does this mean there are no upstream users of this? Then this defconfig
change is no-op. We do not add enable things in defconfig just because
there is some downstream/fork using something. Defconfig is for our
(upstream) boards.

Best regards,
Krzysztof


