Return-Path: <linux-pwm+bounces-7306-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8166B558DA
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Sep 2025 00:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A10567965
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5205C2E718F;
	Fri, 12 Sep 2025 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="U/TSqtgk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464A27A47C
	for <linux-pwm@vger.kernel.org>; Fri, 12 Sep 2025 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757714876; cv=none; b=FeOxopxuX74E4cajxG7XbJ4mKD6jKENJI/Q2GEBnM5Utw9xDlY9ns6Hms1nCbX8xOgl1zeI3YDkDJhbN5Tx1L6uSYjW0NzKKUmy2cMG+0u+6Mip3ZzfL8T59MWqoKVM6XwxYVkvQDRtmys6lMs035gRSMNdt9L/7gJ3+iLqfRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757714876; c=relaxed/simple;
	bh=+yph0vA7hH7D2dOH8dcz8OTQ5zI8ZyZYi0J1x57wbuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO8tTspiy8eOpOC9zCfgqy71avppcDdsFvex1xLOvzoWVNmjMMhXKQl2D0uTqk9cwbNBXJQbnEtgRX/E/+PEkok50rKeE/nKt0PECAtSHntXvM/TJjfimtgU39O36FEzVif0KYAgVAtZnMnXdI3N7FBmRnLTiohwRLr46afk3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=U/TSqtgk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=XtZM
	38dcKGfPDowHADfBNhN+yZMd/DBKAr/Q56lBQhU=; b=U/TSqtgky9mRHKpLYuTy
	UfXd7XedJP9Hk+5/2IqTWU+ncNGhELZK0Vc0RXbSYaIz7Hw6VMZAT5JoyMYY6z4g
	WzMES95KXJxGoQ7e6ctjM2JN/2k4u/gVXKL/EPXHHKnINEvdgPhLK+f+fB3cHt9L
	BpsliJIKV+ndVoI8YPP2/7JNqgTQ5aLQNm6R5gAL99+5MFMbIChu6laV+I2f8W3m
	RpmupwmKLyH5mtQ8NSf2xEebzmoGbDEbi8by9Z1l1UyIN+iGY8UbAOXQISM6qt8c
	5VvYJPYCkQGivyZtg4DnvEdmEwmxNTAeKfuH6DGfDaXfeL6rCKUkNLis+l/AE6hJ
	Eg==
Received: (qmail 1499859 invoked from network); 13 Sep 2025 00:07:43 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Sep 2025 00:07:43 +0200
X-UD-Smtp-Session: l3s3148p1@dRQG4qE+rtYgAQnoAHJ8AC93OVDMgFWg
Date: Sat, 13 Sep 2025 00:07:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 10/37] dt-bindings: i2c: apple,i2c: Add apple,t6020-i2c
 compatible
Message-ID: <aMSZrp3pbS2CeBOE@shikoro>
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net>
 <20250828-dt-apple-t6020-v1-10-507ba4c4b98e@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-dt-apple-t6020-v1-10-507ba4c4b98e@jannau.net>

On Thu, Aug 28, 2025 at 04:01:29PM +0200, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,i2c" anymore [1]. Use
> "apple,t8103-i2c" as fallback compatible as it is the SoC the driver
> and bindings were written for.
> 
> This block is compatible with t8103, so just add the new per-SoC
> compatible using apple,t8103-i2c as base.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>

Applied to for-next, thanks!


