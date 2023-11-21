Return-Path: <linux-pwm+bounces-119-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D67F32D3
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34566B21FB8
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8A5812B;
	Tue, 21 Nov 2023 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MHr2G5PV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D0D185
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:54:00 -0800 (PST)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id 5Sq8rrFjXWcCI5T4Zrep1F; Tue, 21 Nov 2023 15:53:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5T4YrocqbhDny5T4Yrf2t2; Tue, 21 Nov 2023 15:53:58 +0000
X-Authority-Analysis: v=2.4 cv=fda+dmcF c=1 sm=1 tr=0 ts=655cd296
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=VYRiMrDiN7h3fOvPrbAA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n2o1uBXnp8cT9rrlINVcMDQE2oVTgADdskLt+ItqQP8=; b=MHr2G5PVD/2R2YbNbLWNAuPSIl
	XQ+E7j39R9JkwjjWqypfTNU/lWzEPG2um97PTNcdG3n3AJQn/+2KrLy1BmC0D1cfjRP59KYZVXuiV
	NtvjTL9fWvQ5H7FqZhXk+IfKzL4NFT9jxil2o4FvHaejMYuzaLb+qQjM9RU29sKJFXpA/HdQtlNgG
	MNF+ZEq68Ff8EalaPmqCwhmaV8oiY+dBNqnGetf7SCUBEOIGIpn/5l4AChMGaSK2FhHONVOHOLbHz
	i6h5WEG3+tafYCoSdG4c6KW+CCI5/Ba28vVp1dM2rQv0o2oOU/E05FfCBwQ1YtwqZa5mzsZkGVy13
	b1q7YAnA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:46436 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r5T4X-002AxH-2D;
	Tue, 21 Nov 2023 09:53:57 -0600
Message-ID: <b44c4a7d-4f86-4d53-8f11-ffeef91e1407@embeddedor.com>
Date: Tue, 21 Nov 2023 09:53:56 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 105/108] pwm: Ensure a struct pwm has the same lifetime
 as its pwm_chip
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-pwm@vger.kernel.org,
 kernel@pengutronix.de, linux-hardening@vger.kernel.org
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-106-u.kleine-koenig@pengutronix.de>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231121134901.208535-106-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r5T4X-002AxH-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:46436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFBnuyh+tcH3WxbOfB6hOru92VQoSuV/ZVzB1WbKQVi6LmhQvp1TqG5ffKMnH8eWEw/JmYFGVCzklEeS+vDQGjUCFHiPqgBhz6AyO/4D9aLeEvnKAN96
 q5PTqzs0VrsDezMelLxDq7+NRaRk26gCM/hPuu7hi2vN2LUO9uvjlmAPXrK6xxpry3z7Lh9MjQeeYPeQa5kmbgDvDanlSAMG+g8=



On 11/21/23 07:50, Uwe Kleine-König wrote:
> It's required to not free the memory underlying a requested PWM
> while a consumer still has a reference to it. While currently a pwm_chip
> doesn't life long enough in all cases, linking the struct pwm to the
> pwm_chip results in the right lifetime as soon as the pwmchip is living
> long enough. This happens with the following commits.
> 
> Note this is a breaking change for all pwm drivers that don't use
> pwmchip_alloc().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org> # for struct_size() and __counted_by()

Thanks for including __counted_by(). :)
--
Gustavo

> ---
>   drivers/pwm/core.c  | 26 ++++++++++----------------
>   include/linux/pwm.h |  2 +-
>   2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 15942210aa08..029aa1c69591 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
>   
>   void *pwmchip_priv(struct pwm_chip *chip)
>   {
> -	return (void *)chip + sizeof(*chip);
> +	return (void *)chip + struct_size(chip, pwms, chip->npwm);
>   }
>   EXPORT_SYMBOL_GPL(pwmchip_priv);
>   
> @@ -206,8 +206,9 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
>   {
>   	struct pwm_chip *chip;
>   	size_t alloc_size;
> +	unsigned int i;
>   
> -	alloc_size = size_add(sizeof(*chip), sizeof_priv);
> +	alloc_size = size_add(struct_size(chip, pwms, npwm), sizeof_priv);
>   
>   	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
>   	if (!chip)
> @@ -217,6 +218,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
>   	chip->npwm = npwm;
>   	chip->uses_pwmchip_alloc = true;
>   
> +	for (i = 0; i < chip->npwm; i++) {
> +		struct pwm_device *pwm = &chip->pwms[i];
> +
> +		pwm->chip = chip;
> +		pwm->hwpwm = i;
> +	}
> +
>   	return chip;
>   }
>   EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
> @@ -234,7 +242,6 @@ EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
>   int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>   {
>   	int ret;
> -	unsigned i;
>   
>   	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
>   		return -EINVAL;
> @@ -253,26 +260,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
>   
>   	chip->owner = owner;
>   
> -	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
> -	if (!chip->pwms)
> -		return -ENOMEM;
> -
>   	mutex_lock(&pwm_lock);
>   
>   	ret = idr_alloc(&pwmchip_idr, chip, 0, 0, GFP_KERNEL);
>   	if (ret < 0) {
>   		mutex_unlock(&pwm_lock);
> -		kfree(chip->pwms);
>   		return ret;
>   	}
>   
>   	chip->id = ret;
> -	for (i = 0; i < chip->npwm; i++) {
> -		struct pwm_device *pwm = &chip->pwms[i];
> -
> -		pwm->chip = chip;
> -		pwm->hwpwm = i;
> -	}
>   
>   	mutex_unlock(&pwm_lock);
>   
> @@ -303,8 +299,6 @@ void pwmchip_remove(struct pwm_chip *chip)
>   	idr_remove(&pwmchip_idr, chip->id);
>   
>   	mutex_unlock(&pwm_lock);
> -
> -	kfree(chip->pwms);
>   }
>   EXPORT_SYMBOL_GPL(pwmchip_remove);
>   
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b8e70ee01d31..a7294ef1495d 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -302,7 +302,7 @@ struct pwm_chip {
>   
>   	/* only used internally by the PWM framework */
>   	bool uses_pwmchip_alloc;
> -	struct pwm_device *pwms;
> +	struct pwm_device pwms[] __counted_by(npwm);
>   };
>   
>   static inline struct device *pwmchip_parent(struct pwm_chip *chip)

