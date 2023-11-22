Return-Path: <linux-pwm+bounces-130-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64717F4090
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 09:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB62B20AE5
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655E20B06;
	Wed, 22 Nov 2023 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/KXIupC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945011CAB1;
	Wed, 22 Nov 2023 08:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BD2C433C8;
	Wed, 22 Nov 2023 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643140;
	bh=dS6I5+GxVq+w6MA4po9T77FdjKq8FGe7RNC3UWLZPKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/KXIupCo+k/nM8BDmk3FWCm2tPkfyFeac4K4VIyJ7w0lGXgUWgr6xibMmV54LE8E
	 t4JmT5q60y6txcAUL1hvJL+k6wHxtr9lQNWl53pRfVAnbe/xBEVpGOBL/d/aqmSvas
	 yfnKS/qTjqprFH84RZ+8KrUXMOPAXh+gOiQ7KkRb4S8pZSs4s9nzVxDbv5bIm3DAmo
	 rS6tm7e2jBmlOSF8e3eh7cAKERgsCpaVvaCy8BusvwNy+9H2BPs8BpreEKWjuhs+8y
	 F+Lir63lDzU5DbsEdak2l/sJaxzTH7POsCkNTuW2n6gSeHCN+vye/fokd/eJ8qqbOM
	 bpiUzsY00mySg==
Date: Wed, 22 Nov 2023 16:52:16 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 001/108] pwm: cros-ec: Change prototype of helper to
 prepare further changes
Message-ID: <ZV3BQMalgY7WZCVR@google.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121134901.208535-2-u.kleine-koenig@pengutronix.de>

On Tue, Nov 21, 2023 at 02:49:03PM +0100, Uwe Kleine-König wrote:
> @@ -233,7 +232,7 @@ static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
>  
>  	/* The index field is only 8 bits */
>  	for (i = 0; i <= U8_MAX; i++) {
> -		ret = cros_ec_pwm_get_duty(ec_pwm, i);
> +		ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, i);

Or just pass false for `use_pwm_type` because the path:
cros_ec_pwm_probe()
-> !ec_pwm->use_pwm_type
-> cros_ec_num_pwms()

`ec_pwm->use_pwm_type` is always false here.

