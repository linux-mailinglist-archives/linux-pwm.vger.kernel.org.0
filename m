Return-Path: <linux-pwm+bounces-296-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06868805430
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 13:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DF01C20AA2
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9163D59E33;
	Tue,  5 Dec 2023 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJyCRqKU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708175C8F9;
	Tue,  5 Dec 2023 12:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E37FC433C7;
	Tue,  5 Dec 2023 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701779563;
	bh=xuJdQoSW/6bVDWd6DLIrWKYfDIQYTwdWvR4+vRYOAAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJyCRqKUNg5knyQ3nkNQ6ld37IhFDSA2AzZFLw0iCe+AjbtfGIC2npDCIV+76rZgj
	 io3xCJGT4zYqY4d0a/FgSmX19xTyPSKVa3DppE54dc0pF/vKcZsUYebIS7ZfnUaClv
	 fmbDpBgt19GxAIfdk3W+eFhuqdezHCk+T1pFcVeHLNLIjxkYC3F/z+R69Nl9HT1Y9G
	 swDkli1AjDZVOoRTeyli/kOiIlI7SeoZqUm4RPRZ2K4n49B4TFxjZB05rjF8R+KPTj
	 jxd3Vh6D+SlGSCvhksfeKul3WZnAicGufnECbgvfhvpD/x8jusC6jlSo7PssUaaqYI
	 DqtJHiIAD4oLw==
Date: Tue, 5 Dec 2023 20:32:38 +0800
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
Subject: Re: [PATCH v2 2/3] arm64: dts: freescale: imx8-ss-lsio: Fix
 #pwm-cells
Message-ID: <20231205123238.GG236001@dragon>
References: <20231106151326.812099-1-alexander.stein@ew.tq-group.com>
 <20231106151326.812099-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106151326.812099-3-alexander.stein@ew.tq-group.com>

On Mon, Nov 06, 2023 at 04:13:25PM +0100, Alexander Stein wrote:
> i.MX8QM/QXP supports inverted PWM output, thus #pwm-cells needs to be set
> to 3.
> 
> Fixes: a05c329644d81 ("arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied, thanks!

