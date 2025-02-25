Return-Path: <linux-pwm+bounces-4984-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B1A43EC1
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 13:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D08F3A9DDA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9242267F58;
	Tue, 25 Feb 2025 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZaGHlup"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608B267B98;
	Tue, 25 Feb 2025 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485060; cv=none; b=bDu9zS7PfguPmzqvAySDvkhwUrozWvfYq7NsGVKh/YE7O7WonntQr96DAb87YVvNH/9RpqZbueTjDBIG1tLCEyBK5RuX96T2yoaY7cqM3utr7PqlwgwhTVUBmEo6gKzf92CLoTPb9t1onqXZiS9zBSluJhmD1gKO9+WwBbV5+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485060; c=relaxed/simple;
	bh=DUVqD32OXugfWSlqDcu3F8T+9NzMtljQrPVD82q8AAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f84/jzfAbPkLKTo2u4XUI6Y5ojMw9k0Gj416uSP05MCNhDEul5r7hUt/pIzyJ/bekqXJozH+xxIwuSXJJ+lvcSVO14w6omCtIRSA1/8g6wnPVG7gGL+Q4AJ61tvkSSYj1X1zlK4k4boHw45ZA6vu0zQwlrBvsTARxfTLEACZizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZaGHlup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04CC4CEDD;
	Tue, 25 Feb 2025 12:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740485060;
	bh=DUVqD32OXugfWSlqDcu3F8T+9NzMtljQrPVD82q8AAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZaGHlupbAt1P6YPlW0z2FHCs6uBsNeY7opWdS3UwkOP91znt7ISv0xL5CsKX9x47
	 h4Aqg5PTuJb3Fx8NyEMf2VnUjAkjmIRDAWiCUZyyA5l3YtKGgCOpEwUeEvMz0KJ40G
	 qc2sEITJjBmZSqeBbbMtYNjQcWBWzV/tuzA+iSixDqPBuyO/iJ8g7iPoID/Oq1i/HI
	 s3+R2ycQIHpw5bsIae8Dd2kyUG/Qs3dbx5I66PhMjBq4cp7pkFKtR0IO5sUiC11oqu
	 3HDKPNJiKx4Y6XcZPbn6pYNDiDjQSR35v1NcKTaoPToAPvcKJPD6hJ/nk7HtmJcRfe
	 yaPEDE3Qy9+UQ==
Date: Tue, 25 Feb 2025 13:04:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, ukleinek@kernel.org, alexandre.torgue@foss.st.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wbg@kernel.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 5/8] pwm: stm32-lp: add support for stm32mp25
Message-ID: <20250225-psychedelic-iguana-of-education-d5fff7@krzk-bin>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
 <20250224180150.3689638-6-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224180150.3689638-6-fabrice.gasnier@foss.st.com>

On Mon, Feb 24, 2025 at 07:01:47PM +0100, Fabrice Gasnier wrote:
>  	}
>  
>  	return pinctrl_pm_select_sleep_state(dev);
> @@ -246,6 +413,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
>  
>  static const struct of_device_id stm32_pwm_lp_of_match[] = {
>  	{ .compatible = "st,stm32-pwm-lp", },
> +	{ .compatible = "st,stm32mp25-pwm-lp", },

No driver data suggests device is backwards compatible. Commit msg
suggests not, so that's confusing.

Best regards,
Krzysztof


