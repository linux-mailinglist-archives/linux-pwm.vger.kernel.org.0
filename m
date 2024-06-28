Return-Path: <linux-pwm+bounces-2636-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950E91C0F2
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173B1B23D1F
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661651C0057;
	Fri, 28 Jun 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu02ujgO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977B1BE85C;
	Fri, 28 Jun 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584933; cv=none; b=fMOKTTWqQ2Q+Sc1MxRMTMxSS1nT4IhU9eHGbNfmS55UcGiP8nDqDGE3t/5brYRXycmqOpE8/+/DIK0LEeSTT4jYao5U8uHmVXgnLs7ts8SsgSebxeHU1M1fJXWwk/45FaDkM6g+ilBZ3yYp3AB4rLWfF13Bvd7bDX8U9kzxhUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584933; c=relaxed/simple;
	bh=o0+FtQLeO2U5JLYoyvwKKH3oaXIVFsGVeZboLFjghKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFrsI95RPmny82m+pSew7fuIxTuKLJbp5Ooc26ici/vUUe0JxN1aAay3EwhB/Q/XasMe1rHA1AiBgmj51aZe7Q6+asYWS6AgBRTIbgBUG0h6KUFBNvtddVrcGi4XiFHhlzP+cv2tTZoJif3hjB0nCRkjyOr9ts7gHi3KEaO2bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu02ujgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88819C2BBFC;
	Fri, 28 Jun 2024 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719584932;
	bh=o0+FtQLeO2U5JLYoyvwKKH3oaXIVFsGVeZboLFjghKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu02ujgOzG9d5fUcolSqf5bxAVmHpy6dZ5S0T1uPrLfBOtg+yFHwB1KaAEXkSU0du
	 ctkaxwqC33ETdkMU7jSNbMxGH6RlrziiewF4YsEeAEw+LdZsxL+wJjwr2ytlKXy2OZ
	 ++pQM0IhzEZiGHdhxu9PyOgNp/nqx7pqmayHI+8wVHrQfUoklJ7PvpR6vCxHkYv8c6
	 Iey0vKm6hMA4DQlJglfC/kXE858Gf6bDLglvno17PsdAK/kmUab+Ru+U8A+csxDGlH
	 qJPK0FBxbSMd34ubrREIzzhHz8CV44rJe4P6QLrUBTsZQH1/S9gFfhwqs3QUahdmWO
	 sqkqgQ3VzAzJQ==
Date: Fri, 28 Jun 2024 15:28:47 +0100
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: [GIT PULL] Immutable branch between MFD and Counter due for the
 v5.11 merge window
Message-ID: <20240628142847.GN2532839@google.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240626151343.GA2504017@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626151343.GA2504017@google.com>

Enjoy!

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-counter-v5.11

for you to fetch changes up to 304d02aa711369da89b4f8c01702bf1b5d1f7abc:

  mfd: stm32-timers: Drop unused TIM_DIER_CC_IE (2024-06-26 16:09:58 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Counter due for the v5.11 merge window

----------------------------------------------------------------
Uwe Kleine-König (4):
      mfd: stm32-timers: Unify alignment of register definition
      mfd: stm32-timers: Add some register definitions with a parameter
      counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x) instead of TIM_DIER_CCxIE(x)
      mfd: stm32-timers: Drop unused TIM_DIER_CC_IE

 drivers/counter/stm32-timer-cnt.c |   4 +-
 include/linux/mfd/stm32-timers.h  | 179 ++++++++++++++++++++------------------
 2 files changed, 96 insertions(+), 87 deletions(-)

-- 
Lee Jones [李琼斯]

