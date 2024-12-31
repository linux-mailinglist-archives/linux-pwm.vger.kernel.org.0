Return-Path: <linux-pwm+bounces-4528-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD389FF106
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991A01882DBA
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED11ACEC5;
	Tue, 31 Dec 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PukRBQ5w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F201A4E77;
	Tue, 31 Dec 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735666821; cv=none; b=LgHA5TROcw/Q6dlaYbixbyQZIGJRJ8plDZuZKF4GVn8rTa6gYPqT1vf05nY5CjyKq5o/CUFB3dSywjbm5/VnTFhBfFsOEk0KPBvK+XvfhPasEn0IAps1l8xjwN0xBWB830qA70lBjVSdRMV3uic/a+IPItEqBvj57euhrPn6UzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735666821; c=relaxed/simple;
	bh=KPKlddnHotXsfufI2OrnfgpHlQTyrgzYueZmZmkYwHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyiOZaz/YAtC2FvduQhoOwT0D+q7TjKD186PmyhO9uwnn7/nnqdXhlyn33V8cO9xNYWAS04Vq3VojnD4q0qfPa5S2H6ZHriixBFJ0S4VwGKkowVqfEitkZaEpkSAAdfLs6J459RZa1SVh/BWeVKgGXiWpKDWdTMWYoRRLj+Pm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PukRBQ5w; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Sg5EtDHCrmOLwSg5Ht72J3; Tue, 31 Dec 2024 18:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735666272;
	bh=crc3HC0D3iciYfP0aty4FRSyX4CvPSjuN6ckre/pvrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=PukRBQ5w+GRkwN2A2/quDSXLhMNZ92h/i8Gw3rxE/nOtNOiZ62nwHfqOqP4vQOyJy
	 81r/fDlZ4WqSDiObmUVvRo58b6xkoZ2gmFpWc8uZ+4WB3EFZg3MX4QoZGHCxtoJJVp
	 bL00+ZvQMji4t4/QKbt7h/2lmRou07KamZmWEi81A4qsAGUHVTkOonuHig5JJinU0U
	 ODVUzzdyIYHyu5FEQU8THXHtisoovhb57fJfXsExwJFs+x6rX46tBu2NmP4qQPkaI6
	 89UuPkD4rY7Z/23550r7jjpqvtKseChC/JnXN2a/XezHm6dwVtkhgVx7elmtjBMmUk
	 psvXQ/jDOoA1g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 31 Dec 2024 18:31:12 +0100
X-ME-IP: 90.11.132.44
Message-ID: <86521cdf-1dc6-4b37-b356-160142674285@wanadoo.fr>
Date: Tue, 31 Dec 2024 18:31:07 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] pwm: max7360: Add MAX7360 PWM support
To: mathieu.dubois-briand@bootlin.com, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kamel Bouhara
 <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-3-37a8d22c36ed@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241223-mdb-max7360-support-v2-3-37a8d22c36ed@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/12/2024 à 17:42, mathieu.dubois-briand@bootlin.com a écrit :
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

...

> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "no parent device\n");
> +
> +	chip = devm_pwmchip_alloc(pdev->dev.parent, MAX7360_NUM_PWMS,
> +				  sizeof(*max7360_pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops = &max7360_pwm_ops;
> +
> +	max7360_pwm = to_max7360_pwm(chip);
> +	max7360_pwm->parent = pdev->dev.parent;
> +
> +	max7360_pwm->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_pwm->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "could not get parent regmap\n");
> +
> +	ret = devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret != 0)
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip");

Missing return, or done on purpose?

> +
> +	return 0;
> +}

