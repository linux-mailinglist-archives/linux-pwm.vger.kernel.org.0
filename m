Return-Path: <linux-pwm+bounces-6008-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F69ABB646
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 09:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65850167944
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC14267B15;
	Mon, 19 May 2025 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSBfSPEK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722B2673AA;
	Mon, 19 May 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640160; cv=none; b=OI7+Rv04Rw1x55wjHaGVJ18jgaqrVgX2NzF5D92qK7KkfKxY+IGeOonQ9XMJs5JA9Am7jCVbLHOJNBTS4CtAbE8vX2OVItyJHb1CWzg2L6lwGSbwSAv7KHwu7ezfhiV2v2YXh0XaWEqxNy9VxAelLa1g9nY6elJ/j8hvYq2Nwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640160; c=relaxed/simple;
	bh=zVO3+aXmayvngbyw4PYPDuKbl+yyblwK0y0qXrmeAvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVAiw1+yFMNcoO0sDqU0LmuzxOQA6LHWe3OVx6EplYhG0Sn+z/WLLAwkyMlNwMuomuvwvFV+KcikiBe8aJ9ofjHmzk9Ys02ZU4l7bPDNHsBPSTXDAiOtYmrvZDpChndHYwmERayXrE0YWybpY9ZU3U8BL2BNSyrHo7YS8l3ddyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSBfSPEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246D8C4CEE4;
	Mon, 19 May 2025 07:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747640159;
	bh=zVO3+aXmayvngbyw4PYPDuKbl+yyblwK0y0qXrmeAvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSBfSPEKXsp/UlGw7oh6zxljPJhursDcFHV+SVB7eJixi2czxaPjMaAWCj8fR+g4o
	 wrHAs+OAquHVincN9MFKT5NIJksr8FZfvlJ/VYIJT3gOnzscxwi+qNgCx6esb2DVSK
	 yqt8NBb0L6+ISLqLcM414LnjsMRJFT3BwMa6RqEVtlDCun7+h8ndXvGhkb8//8QhXm
	 flNeM0oUQcX2TWnyv55TRJ9lv7n5mMb9JTN5COoBbcz1K7WbS/mqw0R8B/2JNq4BpX
	 KKzemZfAQPADmqX2YG9QT1gE781xOJIWt6p96zlvlcEKhgFnneo89LaJomzVsZoFtU
	 EvU8U3PVSEpPw==
Date: Mon, 19 May 2025 08:35:53 +0100
From: Lee Jones <lee@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: daniel.lezcano@linaro.org, alexandre.torgue@foss.st.com,
	tglx@linutronix.de, ukleinek@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jic23@kernel.org, robh@kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: [GIT PULL] Immutable branch between MFD, Clocksource and PWM due for
 the v6.16 merge window
Message-ID: <20250519073553.GH2936510@google.com>
References: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>

Enjoy!

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-clocksource-pwm-v6.16

for you to fetch changes up to 3f51b232c1da8e59eb562f1d81533334827a4799:

  pwm: stm32-lp: Add support for stm32mp25 (2025-05-13 11:13:56 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Clocksource and PWM due for the v6.16 merge window

----------------------------------------------------------------
Fabrice Gasnier (4):
      dt-bindings: mfd: stm32-lptimer: Add support for stm32mp25
      mfd: stm32-lptimer: Add support for stm32mp25
      clocksource/drivers/stm32-lptimer: Add support for stm32mp25
      pwm: stm32-lp: Add support for stm32mp25

 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |  40 +++-
 drivers/clocksource/timer-stm32-lp.c               |  61 +++++-
 drivers/mfd/stm32-lptimer.c                        |  33 +++-
 drivers/pwm/pwm-stm32-lp.c                         | 219 ++++++++++++++++++---
 include/linux/mfd/stm32-lptimer.h                  |  37 +++-
 5 files changed, 350 insertions(+), 40 deletions(-)

-- 
Lee Jones [李琼斯]

