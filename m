Return-Path: <linux-pwm+bounces-1889-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E9B8A1234
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 12:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46EC1C2344A
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71C140E3C;
	Thu, 11 Apr 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qixGdOXI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508313DDD6;
	Thu, 11 Apr 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832715; cv=none; b=jxRsGCZb4Dr5JTqA5l6KJMUoMBx1dR5VSjz5DXvrT2knDieFTZmJg6VlA0mA7RBtfrqMZEa5M0CDf3URrS0M5Mw0fk29HP/TezfakojAIp2jlL9NVe7W+FkLicwvdBiHuXyViOnaVDM5x8nBhmUDjIL28NNvEjTUNq7wyP2Uu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832715; c=relaxed/simple;
	bh=D6JMxryqqfDxqjFdDz0KsohI3fQ2DDEdBVnKin6QWQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tZfqdcp6Al5pTWX1hnxwYiOmhLZORUxOoUWci7EUC/+JtpCTJNmlQJxKctxvKawl1atUcpYrSRmydKRjYsWbIz1RDgFkpenZv2DBj8DcBKncGLrk5BO/OkP4LG30AWYT3GTXeffDFLVy/ny9mfBGZX1rmABKAW2csjST7FPqfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qixGdOXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F5C433F1;
	Thu, 11 Apr 2024 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712832714;
	bh=D6JMxryqqfDxqjFdDz0KsohI3fQ2DDEdBVnKin6QWQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qixGdOXI0gJNkpiYUoUXv3CP0K3DF+6hg/K07WmVGHFC9ZsXILb3cL8+bG4GAEIcs
	 6PZ3xzj2YJuGKxlDVr5moi5gyqbLDJhyL3V4hRx9xzX7DvhYmARbYKE83RxKpaf53i
	 rSUWduG3Pd0usx4EySllM2tARdS//1pq60QjEbcrrETRiZnN0m2shAbip2m6P4Phvk
	 Q2EhcQ1eRYPiHiesoBe9ig57hWTlyg7OjsFRTUQX9471yUtOsyHXwhyLHED+I5zCw7
	 d+Pht1PXHWHM6qjpSLkaIeqXHLPBT2t68d631E8LdeCzfK6Uhq0m4f+5AvkXNs08x5
	 bqu7kfLaG58OQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 kernel@pengutronix.de, dri-devel@lists.freedesktop.org
In-Reply-To: <20240329133839.550065-2-u.kleine-koenig@pengutronix.de>
References: <20240329133839.550065-2-u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH v3] backlight: lp8788: Drop support for
 platform data
Message-Id: <171283271286.2290145.16947522198877039372.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 11:51:52 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 29 Mar 2024 14:38:39 +0100, Uwe Kleine-König wrote:
> The backlight driver supports getting passed platform data. However this
> isn't used. This allows to remove quite some dead code from the driver
> because bl->pdata is always NULL, and so bl->mode is always
> LP8788_BL_REGISTER_ONLY.
> 
> 

Applied, thanks!

[1/1] backlight: lp8788: Drop support for platform data
      commit: 150476e60a80ebb93d49aae7b636934eb04b83d2

--
Lee Jones [李琼斯]


