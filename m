Return-Path: <linux-pwm+bounces-3422-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5378C98C5E0
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 21:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9951F21936
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 19:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367D1B5820;
	Tue,  1 Oct 2024 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="V5KHtRtl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4C286A8
	for <linux-pwm@vger.kernel.org>; Tue,  1 Oct 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810279; cv=none; b=KkUyjWV7liSjzAe1WtEntItt51UOPs1U461m25d3TEEvaQM/6RzaQvNpIMWGK+IOt82I7akJc5aW3G3bGrtZbrSwSe1C6AWn7QMobms/cPRpSH1gKQwMQX5TZc7kR7ulTIeBNBvSJ9vXTQ8tkwVVXtoZtTN8Gtm1eMAXobpgqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810279; c=relaxed/simple;
	bh=lIo8OG6VbAv8H4Grlk0j3HIMUEAfAXQn/RIndj4B8Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlodQzMhNdrog181M/pX4F3pAGrrq5ZwGGw4/tzh1tKUBDP5S3dym9B+q3jQu8bQJLN7kDCsPU2gNio1suZy7lXWpx3nI80SeUR7zR0m5wQXEvqmQ8BaamnNOAENkciZSd0hWJNhmvIN2eKSKlMwEdBhzyG25lBGXQcELBOkDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=V5KHtRtl; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1727810275; bh=lIo8OG6VbAv8H4Grlk0j3HIMUEAfAXQn/RIndj4B8Ks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V5KHtRtluKV4bT47DZaJlF55V5xhVeZmXX6jcYZ/JYw8ZZaxHDxWuZcIKoQ9Ks2eL
	 UyamxX49KFg88aHW8tN3tQJIogVe86HduVL0o+obpsNAMjMEguj4rSGjzo+DH8vkCB
	 /MX83AsrzmHmRftI+uPi4TLA1n1At6XfN89LD+43t514kDDr+k8Iwy1H/BL/WcTXcg
	 3g7Px/V+tpaj3N/+xWv4083ssVFF4fpwvSzElCEkZs01tPRDvDEhAWioJCkZuk+BiX
	 DBjU8qyZHd66Vyj3grrNq+F4IwJek/vFuTOvsiMcSoQJYCL5WsC+3WLC/rkmp8Z8oL
	 ox3O3qCnLBFVvYieZKHR0DsclEza7oVa8ID+F0O70EduF3Dx0Qef06kFHQ85zAO3n3
	 jR86hHBZe4ECpUuHBVlYWNzBeZtPyWtS9ZZur8kAuV2XZNoQz8Sh0Kp6yEsIYzZXCm
	 Q9KNpHCbp1zhewv3PntGSsTX52XNuiCgs3FCLeLCVDOZ4QUpqgRaJStic8ejLD4KNY
	 5XACRFn0q49EQBsjzWtaUN5lveVESPL75cf+ZZEHPpWrKTCz0JETd8GQidef6hRmtT
	 rn+bY0iFSZ9Vj2rgTwwlOX0zuxk2YB6X+8aDeGxpL+JKMhtoa/O5ISBXMoLjkGbsvW
	 LCntESKGfVa1VfYZSJmRv2cc=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id ECA461842FC;
	Tue,  1 Oct 2024 21:17:51 +0200 (CEST)
Message-ID: <b0199625-9dbb-414b-8948-26ad86fd2740@ijzerbout.nl>
Date: Tue, 1 Oct 2024 21:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] pwm: stm32: Implementation of the waveform
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
 David Lechner <dlechner@baylibre.com>, Kent Gibson <warthog618@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <332d4f736d8360038d03f109c013441c655eea23.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <332d4f736d8360038d03f109c013441c655eea23.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 20-09-2024 om 10:58 schreef Uwe Kleine-König:
> Convert the stm32 pwm driver to use the new callbacks for hardware
> programming.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
[...]
> +static int stm32_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	const struct stm32_pwm_waveform *wfhw = _wfhw;
> +	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> +	unsigned int ch = pwm->hwpwm;
> +	int ret;
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
> +		u32 ccer, mask;
> +		unsigned int shift;
> +		u32 ccmr;
> +
> +		ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
> +		if (ret)
> +			goto out;
> +
> +		/* If there are other channels enabled, don't update PSC and ARR */
> +		if (ccer & ~TIM_CCER_CCxE(ch + 1) & TIM_CCER_CCXE) {
> +			u32 psc, arr;
> +
> +			ret = regmap_read(priv->regmap, TIM_PSC, &psc);
> +			if (ret)
> +				goto out;
> +
> +			if (psc != wfhw->psc) {
> +				ret = -EBUSY;
> +				goto out;
> +			}
> +
> +			regmap_read(priv->regmap, TIM_ARR, &arr);
Did you forget to assign to ret?
> +			if (ret)
> +				goto out;
> +
> [...]

