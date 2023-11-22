Return-Path: <linux-pwm+bounces-132-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E4D7F4093
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98846B20AF8
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934C2D63B;
	Wed, 22 Nov 2023 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK39sHop"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46722EE8;
	Wed, 22 Nov 2023 08:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F57C433C9;
	Wed, 22 Nov 2023 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643167;
	bh=2hA0ipSUSD8tblpZzKbXBtE3Q3om8cYe+kHrqzYujrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK39sHopPz/8R+vbMJaUF4KOi6lvO4v+62xLYnr6NU8NsTtlpfGSoFrgOA+1avFj+
	 02sx6Zwd1Hp27OnpURgnI8MHKXzYI5dmHzQCG1lR2B7L9vGJ3Tx7Au4EJKQiBt7q2F
	 nEKKKQA/c6eLdgCDCIW92+Pc0At8sIRfxv1DaXkDIACICIJ9QDDLQjx2hTlKSP8GGz
	 yav5Oqr/XfKzwv1iepnPSjKYeDuk1nsBBFTzksyFiWdkGxlj0bSmnm63U2N+KemX5V
	 Mqeh10L6CyRrkJ29Xwjc8vIvAKeUNDg8g2iYn7SXhVV6ob2/dmXuYVyHutQXMdH6nN
	 X2yzjiKi2L0sA==
Date: Wed, 22 Nov 2023 16:52:44 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 051/108] pwm: cros-ec: Make use of
 devm_pwmchip_alloc() function
Message-ID: <ZV3BXAMCBkArwIm6@google.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-52-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121134901.208535-52-u.kleine-koenig@pengutronix.de>

On Tue, Nov 21, 2023 at 02:49:53PM +0100, Uwe Kleine-König wrote:
> @@ -41,7 +40,7 @@ struct cros_ec_pwm {
>  
>  static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *chip)
>  {
> -	return container_of(chip, struct cros_ec_pwm_device, chip);
> +	return pwmchip_priv(chip);

Or just replace every `pwm_to_cros_ec_pwm` to `pwmchip_priv`.

> @@ -226,13 +225,13 @@ static const struct pwm_ops cros_ec_pwm_ops = {
>   * of PWMs it supports directly, so we have to read the pwm duty cycle for
>   * subsequent channels until we get an error.
>   */
> -static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
> +static int cros_ec_num_pwms(struct cros_ec_device *ec, bool use_pwm_type)

As replied in previous patch, `use_pwm_type` in the path is always false.

> @@ -261,35 +260,36 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct cros_ec_pwm_device *ec_pwm;
>  	struct pwm_chip *chip;
> +	bool use_pwm_type = false;
> +	unsigned npwm;

To be neat, `unsigned int`.

[...]
> +	chip = devm_pwmchip_alloc(dev, npwm, sizeof(*ec_pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	ec_pwm = pwm_to_cros_ec_pwm(chip);

pwmchip_priv().

