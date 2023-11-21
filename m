Return-Path: <linux-pwm+bounces-117-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1397F3224
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A32BB220A1
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3A5676F;
	Tue, 21 Nov 2023 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDsfU+la"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32675676E;
	Tue, 21 Nov 2023 15:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DA6C433C8;
	Tue, 21 Nov 2023 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700579805;
	bh=M1nYtinCnsWhC2tpOtbJ63fN0uTx3TlppR1VVypU1y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDsfU+laScRlz40Tpd+SH5qqHSRXT79PNQ/Ozdtq+ybyV5vYCAZ/T9T0YVqgwh5rj
	 IKRhMgFHVkmJAOOLxQZaT1qGCNDgPWYq1n7lBCQhEu17+QEgvd02FjY6r7G4bYAdJj
	 Rp1PBV5HPvbpGrMKJEdJxT9d5lYED0dL205sD4AbtetNCEV/lGHpiERtF69nJQoi98
	 U/DP0XJpTf2E91RWwWb0rr32LpBwD0pdSN7K5mbNIamGaR3S+k351RSM2cXGPaCw+f
	 Qj5kMbLI9ddydvofpK0+ble7bCuNP4zOk9VWsmlU8iaIXd99hmBOuoC2D5G++3P5ka
	 nZY2SaHyZhMQA==
Date: Tue, 21 Nov 2023 15:16:40 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Rob Herring <robh@kernel.org>, Kees Cook <keescook@chromium.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-leds@vger.kernel.org, kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231121151640.GB173820@google.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>

On Tue, 21 Nov 2023, Uwe Kleine-König wrote:

> This prepares the pwm sub-driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Does this need to be taken in with the other 107 patches?

-- 
Lee Jones [李琼斯]

