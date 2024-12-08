Return-Path: <linux-pwm+bounces-4287-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40E9E86A1
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Dec 2024 17:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D511884669
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Dec 2024 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287551714C8;
	Sun,  8 Dec 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSLDoBm3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC750170A15;
	Sun,  8 Dec 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733676170; cv=none; b=HOgKlmeugNBzjZDbfYqqjhPcsnuI1WW8zQR7GUyyuQKWBvHRNo9m1PnCvbO6yJ64pNZMAfPOoeSihP+bHd1hZmOLYEiik+QRZupHh5DeljfO2F1KU/G6wZRpUJovAGjl/Ou/x8nroLH1fC74ZYsAnSMYLLVsgEGJtJEQn29AnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733676170; c=relaxed/simple;
	bh=tqTPLGWbTSMZOXidKNmcG/xT5UtzkOmJcVigxh/AOMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzefnmTNg2qSNdNb1wopIoCie6Ht0v4ur8CGAAxk0+t9Ug6vFtVN66+HJu+PiwX1jG1ZyJY7negnj1Jh3++D6zGfU2iW8Gw9iXU2Feq1ZWm+ZaPUJG/1rsm52IwfQRrKLaPyKA9Hy+giqNOTz9n9H8NgdVVmeN1zOtcEcnBAa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSLDoBm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D368C4CED2;
	Sun,  8 Dec 2024 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733676169;
	bh=tqTPLGWbTSMZOXidKNmcG/xT5UtzkOmJcVigxh/AOMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSLDoBm3IJlpM4CuZgxMi73iHwWGjzUXw8l5wfQHt++1u1g1Wc5h7BjOrxG1d5WDk
	 haJgrUFguT6dXbYCtbO+f+TeuENzzU7jN76j7Fdx8HlVLHa9s5kbcn+vlQ87+u6+aR
	 A0YsfgD9AOG8gH2PX9AFqfP7uIvnI+GE2EEjiDK9CIRyGxrTDPmfQoEUAQo8oAGQv7
	 o1SbuRVWOkCIw+dOKRqWWEWmvossdiTM/JeHfgCNlyxYgDT4Y0u9J/ITA3XPxmtlEF
	 cwxfyvPE0v528BY3MTC6655gYVLWWS5K740tPrrNdLLhzhfUifGsBPJz7vsmofV7Pi
	 aQaAUCn2HHSqQ==
Date: Sun, 8 Dec 2024 16:42:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: frequency: adf4371: add ref doubler
Message-ID: <20241208164242.013ac089@jic23-huawei>
In-Reply-To: <20241206152207.37928-3-antoniu.miclaus@analog.com>
References: <20241206152207.37928-1-antoniu.miclaus@analog.com>
	<20241206152207.37928-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 17:22:06 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the reference doubler.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/frequency/adf4371.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
> index 55bee06fb42d..dc01f2aafb9a 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -44,6 +44,8 @@
>  /* ADF4371_REG22 */
>  #define ADF4371_REFIN_MODE_MASK		BIT(6)
>  #define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK, x)
> +#define ADF4371_REF_DOUB_MASK		BIT(5)
> +#define ADF4371_REF_DOUB(x)		FIELD_PREP(ADF4371_REF_DOUB_MASK, x)\
>  
>  /* ADF4371_REG24 */
>  #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
> @@ -75,6 +77,9 @@
>  #define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
>  #define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
>  
> +#define ADF4371_MIN_CLKIN_DOUB_FREQ	10000000ULL /* Hz */
> +#define ADF4371_MAX_CLKIN_DOUB_FREQ	125000000ULL /* Hz */
> +
>  /* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
>  #define ADF4371_MODULUS1		33554432ULL
>  /* MOD2 is the programmable, 14-bit auxiliary fractional modulus */
> @@ -480,7 +485,7 @@ static const struct iio_info adf4371_info = {
>  static int adf4371_setup(struct adf4371_state *st)
>  {
>  	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
> -	unsigned int vco_band_div, tmp;
> +	unsigned int vco_band_div, tmp, ref_doubler_en = 0;
>  	bool ref_diff_en;
>  	int ret;
>  
> @@ -516,6 +521,10 @@ static int adf4371_setup(struct adf4371_state *st)
>  	    (!ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN_SE))
>  		return -EINVAL;
>  
> +	if (st->clkin_freq < ADF4371_MAX_CLKIN_DOUB_FREQ &&
> +	    st->clkin_freq > ADF4371_MIN_CLKIN_DOUB_FREQ)
> +		ref_doubler_en = 1;
> +
>  	ret = regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
>  				 ADF4371_REFIN_MODE_MASK,
>  				 ADF4371_REFIN_MODE(ref_diff_en));
> @@ -531,7 +540,8 @@ static int adf4371_setup(struct adf4371_state *st)
>  	 */
>  	do {
>  		st->ref_div_factor++;
> -		st->fpfd = st->clkin_freq / st->ref_div_factor;
> +		st->fpfd = (st->clkin_freq * (1 + ref_doubler_en)) /
> +			   (st->ref_div_factor);
No need for brackets on the previous line.

Otherwise this looks good to me.
>  	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
>  
>  	/* Calculate Timeouts */


