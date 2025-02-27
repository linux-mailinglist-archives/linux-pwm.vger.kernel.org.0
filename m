Return-Path: <linux-pwm+bounces-5014-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769FA4806D
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2025 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E9B1898B6C
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53329CE8;
	Thu, 27 Feb 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cElZXzl2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61A1C84C1
	for <linux-pwm@vger.kernel.org>; Thu, 27 Feb 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664865; cv=none; b=jXDHCfnzkh/gAMuiIZ5vR/sOGAW0DfMrtHU7LvujyofCOphZaISTb9VJq5eya8G/faAMgssE782t2aP9vx8mvfHxmcu0eB0r7vEj8NJKylLlxEZrWS/ERtPuFo1DKByaI1Dlq1PaOflLIQDk3ZhYV1VMICbb93NSdiFHmbY+rYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664865; c=relaxed/simple;
	bh=SRFDgDNdWZ5zf1bg96IKeBhSU3dvgKDPRtiXI4vFnac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=F+Uj2ngJ98hZSM6umUrJdMKMvvJOikHxViJ3PP9s2cH+uasazjLpzRehF1fkhqHdBJF5zPnsNGlVxIldIb7Vjb2BIQazpwdf9V00s7mKD/c+xEurcwhG77nWnrw+ksdig4bgepwvWVR+s+GOOH+gy6qe6/nnpWc+uwFETwmbU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cElZXzl2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250227140054euoutp0193b732493eb15788c9aff11da97b37e5~oFXaSkdeC0111601116euoutp01a
	for <linux-pwm@vger.kernel.org>; Thu, 27 Feb 2025 14:00:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250227140054euoutp0193b732493eb15788c9aff11da97b37e5~oFXaSkdeC0111601116euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740664855;
	bh=XFri3rmlbUoKmwQLzTUXC+1AppVaa7YSM5vKQGK1m3Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cElZXzl2KwIg7sfpVd0XQwtQav9WKBuoeGWPCyMZgB2NrE2uIhoTR4VSJzrbo2ztM
	 KtP1sypFNIELlxlBZNI9vpgA3NHO83ygLtNwHvRPWp7K2TKTYE3vVdxKor/ln1nzxX
	 kVMNR133k9uHoM6jxK1675Aj1LUhGbEVaAuxEQF8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250227140054eucas1p1754395c6b5e264d4ca1ff0bc2962ff38~oFXZ4v-sU3188831888eucas1p1r;
	Thu, 27 Feb 2025 14:00:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 3B.9E.20821.61070C76; Thu, 27
	Feb 2025 14:00:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250227140054eucas1p2bf6e3f2416e11e3c62a704682bf052bf~oFXZi0fGN1024710247eucas1p2N;
	Thu, 27 Feb 2025 14:00:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250227140054eusmtrp2292600fafa893e3fd7a23cc81fbe9e81~oFXZiJiU_0637906379eusmtrp2R;
	Thu, 27 Feb 2025 14:00:54 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-da-67c07016c72d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.2C.19920.61070C76; Thu, 27
	Feb 2025 14:00:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250227140053eusmtip203ef929152989046c51f8a0e822f6667~oFXYmY1Bc2598525985eusmtip2B;
	Thu, 27 Feb 2025 14:00:53 +0000 (GMT)
Message-ID: <ab3e42c0-70fa-48e0-ac93-ecbffef63507@samsung.com>
Date: Thu, 27 Feb 2025 15:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] gpiolib: introduce gpio_chip setters that
 return values
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
	<linus.walleij@linaro.org>, Michael Walle <mwalle@kernel.org>, Bamvor Jian
	Zhang <bamv2005@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Keerthy <j-keerthy@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250220-gpio-set-retval-v2-5-bc4cfd38dae3@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87piBQfSDTbekrbo/jCd2WLFtzVM
	FrsebGOzmDt7EqPFqe1NTBZT/ixnstg8/w+jxeVdc9gs7t5dxWjx++dcZouf8y+yOnB7LL52
	m9Vj4lldj52z7rJ7bFrVyeZx59oeNo/jN7YzeXzeJBfAHsVlk5Kak1mWWqRvl8CV0bDtCHvB
	DYWKnQ2XmRoYV0p2MXJySAiYSDR0T2PrYuTiEBJYwSix7+VPKOcLo0Try1lQzmdGif937zPB
	tGz8vZEJIrGcUWLPjgPMEM5HRonvi/YDORwcvAJ2EptXxYE0sAioSuxs/ssKYvMKCEqcnPmE
	BcQWFZCXuH9rBjuILSwQLrFiziMwW0RgOZNE/05VkJnMAhOBFizcygaSYBYQl7j1ZD7YFWwC
	hhJdb7vA4pwCLhI7Zk1mhqiRl9j+dg7YQRIC3ZwS579+ZIY420Xi8rP7bBC2sMSr41vYIWwZ
	if875zNBNLQzSiz4fR/KmcAo0fD8FiNElbXEnXO/2EBeYxbQlFi/Sx8i7Chx6+EKsI8lBPgk
	brwVhDiCT2LStulQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSOEyC8mbs5C8Mwth7wJGllWM
	4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBCez0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd5Z
	sQfShXhTEiurUovy44tKc1KLDzFKc7AoifMu2t+aLiSQnliSmp2aWpBaBJNl4uCUamBqeXyN
	zeKReVf7z2qPvroS0fuRfflbPzsEGgZeZbS1Kj93fpnxPJe1e1477OFifafz/NqO7+eDZDbM
	KzL6doF737dX53e9ODGjYcnaAA4XeZWFqz4FlLJFy1ydaZl12uq0xS61lnqDPZyrxCebC3lr
	65r1N/O882i0OXK0bOrcFw2zW07UsbicWXepqrBqhpHRsdnKV2Yyf3U4ojKlUOPwqV1C9YIi
	W885yWpYFc7btl+JYfaNA8/dT3Q0rP3s5lVQtlvPV7bXQNNadGnMmvOqHy7XfTwjxef24M1c
	TmH3yTolP49/77Ph1BN9ct238GSE05Vik0dv03+eFCo6v0v0opnn5QJZt5uvEgXzhESVWIoz
	Eg21mIuKEwG2JnH8zwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7piBQfSDTa/ZLHo/jCd2WLFtzVM
	FrsebGOzmDt7EqPFqe1NTBZT/ixnstg8/w+jxeVdc9gs7t5dxWjx++dcZouf8y+yOnB7LL52
	m9Vj4lldj52z7rJ7bFrVyeZx59oeNo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRn
	aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0bDtCHvBDYWKnQ2XmRoYV0p2MXJySAiY
	SGz8vZGpi5GLQ0hgKaPEzNXX2CASMhInpzWwQtjCEn+udYHFhQTeM0q0/vTtYuTg4BWwk9i8
	Kg4kzCKgKrGz+S9YOa+AoMTJmU9YQGxRAXmJ+7dmsIPYwgLhEksm9zCC7BIRWM4k0dnxkREk
	wSwwkVFi2c0ciPm1Ei8+d7NBxMUlbj2ZzwRiswkYSnS9hbiBU8BFYsesycwQNWYSXVu7oObI
	S2x/O4d5AqPQLCR3zEIyahaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNZt
	x35u3sE479VHvUOMTByMhxglOJiVRHhnxR5IF+JNSaysSi3Kjy8qzUktPsRoCgyMicxSosn5
	wHSRVxJvaGZgamhiZmlgamlmrCTO63b5fJqQQHpiSWp2ampBahFMHxMHp1QD056ktR8Zk25n
	HOg9OJuv3+eZeMI57l72wwnxLZoO71i1khn2dKnNOdudeHpBx10v7lmhjVPrDtyMlzxTrHrj
	g7T7bJ3+uW/OfD1wWcvXYu/2j5enpUR13syvWn9ly4mnBrnmlw8uCH/xi+W7auxzKZ7pn0xe
	F+8z7oras8vw6ZV4s1/nVHrMTnV4vrsSnJzz2sB4iWSeyobjiu98H/NOuOF9IePqjdu9y91P
	6SfMitr2ujV0VntLq+R59S93ou29XhxP4vf323/3G9cC7x3yyZzSU++85nvcFXhaenp8Ie/V
	n/c4tQObDvrnN1UWpwa47xK1Xz8vufja4Q7PjpmeG3M3rnzfYht/6dSUtS4VAkosxRmJhlrM
	RcWJAME63CZfAwAA
X-CMS-MailID: 20250227140054eucas1p2bf6e3f2416e11e3c62a704682bf052bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250227140054eucas1p2bf6e3f2416e11e3c62a704682bf052bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250227140054eucas1p2bf6e3f2416e11e3c62a704682bf052bf
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
	<20250220-gpio-set-retval-v2-5-bc4cfd38dae3@linaro.org>
	<CGME20250227140054eucas1p2bf6e3f2416e11e3c62a704682bf052bf@eucas1p2.samsung.com>

On 20.02.2025 10:57, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add new variants of the set() and set_multiple() callbacks that have
> integer return values allowing to indicate failures to users of the GPIO
> consumer API. Until we convert all GPIO providers treewide to using
> them, they will live in parallel to the existing ones.
>
> Make sure that providers cannot define both. Prefer the new ones and
> only use the old ones as fallback.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/gpio/gpiolib.c      | 27 +++++++++++++++++++++++++--
>   include/linux/gpio/driver.h | 10 ++++++++++
>   2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index b1e7d368bc7d..19f78ffcc3c1 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -926,6 +926,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>   	int base = 0;
>   	int ret = 0;
>   
> +	/* Only allow one set() and one set_multiple(). */
> +	if ((gc->set && gc->set_rv) ||
> +	    (gc->set_multiple && gc->set_multiple_rv))
> +		return -EINVAL;
> +
>   	/*
>   	 * First: allocate and populate the internal stat container, and
>   	 * set up the struct device.
> @@ -2757,11 +2762,21 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
>   
>   static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
>   {
> +	int ret;
> +
>   	lockdep_assert_held(&gc->gpiodev->srcu);
>   
> -	if (WARN_ON(unlikely(!gc->set)))
> +	if (WARN_ON(unlikely(!gc->set && !gc->set_rv)))
>   		return -EOPNOTSUPP;
>   
> +	if (gc->set_rv) {
> +		ret = gc->set_rv(gc, offset, value);
> +		if (ret > 0)
> +			ret = -EBADE;
> +
> +		return ret;
> +	}
> +
>   	gc->set(gc, offset, value);
>   	return 0;
>   }
> @@ -3501,9 +3516,17 @@ static int gpiochip_set_multiple(struct gpio_chip *gc,
>   
>   	lockdep_assert_held(&gc->gpiodev->srcu);
>   
> -	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set)))
> +	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set_multiple_rv)))
>   		return -EOPNOTSUPP;

The above change issues a warning on gpio controllers that doesn't 
support set_multiple() callbacks at all. I think that this wasn't intended.

>   
> +	if (gc->set_multiple_rv) {
> +		ret = gc->set_multiple_rv(gc, mask, bits);
> +		if (ret > 0)
> +			ret = -EBADE;
> +
> +		return ret;
> +	}
> +
>   	if (gc->set_multiple) {
>   		gc->set_multiple(gc, mask, bits);
>   		return 0;
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 10544f4a03e5..b2627c8ed513 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -347,6 +347,10 @@ struct gpio_irq_chip {
>    *	stores them in "bits", returns 0 on success or negative error
>    * @set: assigns output value for signal "offset"
>    * @set_multiple: assigns output values for multiple signals defined by "mask"
> + * @set_rv: assigns output value for signal "offset", returns 0 on success or
> + *          negative error value
> + * @set_multiple_rv: assigns output values for multiple signals defined by
> + *                   "mask", returns 0 on success or negative error value
>    * @set_config: optional hook for all kinds of settings. Uses the same
>    *	packed config format as generic pinconf.
>    * @to_irq: optional hook supporting non-static gpiod_to_irq() mappings;
> @@ -442,6 +446,12 @@ struct gpio_chip {
>   	void			(*set_multiple)(struct gpio_chip *gc,
>   						unsigned long *mask,
>   						unsigned long *bits);
> +	int			(*set_rv)(struct gpio_chip *gc,
> +					  unsigned int offset,
> +					  int value);
> +	int			(*set_multiple_rv)(struct gpio_chip *gc,
> +						   unsigned long *mask,
> +						   unsigned long *bits);
>   	int			(*set_config)(struct gpio_chip *gc,
>   					      unsigned int offset,
>   					      unsigned long config);
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


