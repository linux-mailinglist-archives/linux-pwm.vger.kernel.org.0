Return-Path: <linux-pwm+bounces-297-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B83805434
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 13:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B09B20C93
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD75C065;
	Tue,  5 Dec 2023 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noqSCSMf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544E5C8F6;
	Tue,  5 Dec 2023 12:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431E4C433C7;
	Tue,  5 Dec 2023 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701779584;
	bh=wEIF6Nr+oPrHaYRlymYUNiDrxfNGPDcufqB218OIHfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noqSCSMfYTb9+Y2RAA+7d5pfxKv2+BUPfHQwJz3iKO62WcUNxcdZxyrrSeJBl+UPa
	 OHaJLMG6SO3DOhMlBwxMMoX4bI2rp1Vgs9PJuOEi3gr8537KuJY5zFVu5+NRp5OtyG
	 c/MBsq6wc/nVg+tOvQxs1OX6k/GpBS1IHU/wGyJ5R4Xu7nXv/M6dF3OncIqQrYta4T
	 W66S20rQqGCPHnzNL4XX3TQgtP/FipMy70rDecBGNMjWZyHQxjGud5G6GWNe+qd8Jy
	 AlDY99g9WAazWI/AivP6mF1H9AJYTDASAynFuniQLz36mRvWG20uDy2j5RTELlto/m
	 f/DNUq8pFkJvg==
Date: Tue, 5 Dec 2023 20:32:58 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: freescale: imx8-ss-dma: Fix #pwm-cells
Message-ID: <20231205123258.GH236001@dragon>
References: <20231106151326.812099-1-alexander.stein@ew.tq-group.com>
 <20231106151326.812099-4-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106151326.812099-4-alexander.stein@ew.tq-group.com>

On Mon, Nov 06, 2023 at 04:13:26PM +0100, Alexander Stein wrote:
> i.MX8QXP supports inverted PWM output, thus #pwm-cells needs to be set
> to 3.
> 
> Fixes: f1d6a6b991ef9 ("arm64: dts: imx8qxp: add adma_pwm in adma")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied, thanks!

