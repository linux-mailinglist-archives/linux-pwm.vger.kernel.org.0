Return-Path: <linux-pwm+bounces-2392-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A90A901C5A
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 10:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFF02823BE
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1C558AD;
	Mon, 10 Jun 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fbc2JGTX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2F63C7;
	Mon, 10 Jun 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006815; cv=none; b=uI3C+QxYVoaFPODrxh+7O6nkWWQvP1GjOI+qnOISANTAy4QsapuxwGe25ex+bqxPgeC9+ZOLC++IMMNRqQJOGLxFVoRyATyw/ww+XsyXBFBY4fpwfkxUvItv1an5ljPa5NdE7eWfMORiiMBbR75FC+GK0JpM9TbvHdajNMCl+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006815; c=relaxed/simple;
	bh=Io/Z8pmSrin1ufDf1pTTnqKm0on+4xHG0V02DJ6G6fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiIiSnnOxBjTPL8iB+CMLzSMKSaoI4ldkWk2W44h3wuDv9n6B2l4tCnNRfNT7FsQPFN3yeLMSpmuuEhKPYYn0Pg4Uml32ErUjQ35DeDmJ+RvujHbJK4Z/THvwuPPP6Uv7mrGnH9iRykqeaiSsQFjW+3LcPTgYR6aHKdEuOYIqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fbc2JGTX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718006811;
	bh=Io/Z8pmSrin1ufDf1pTTnqKm0on+4xHG0V02DJ6G6fo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fbc2JGTXECrFLODOjNn5zPCS+TLlAAFYhQsu2hcMV7wlYO+4bYbR+S8HFQTxnSQVJ
	 6Lw4UXYbpVRg64axJD5r39bybViwB7dZRlj7x84GupRvj2cbdsQ5+UjO4joFxWbFhQ
	 hYssLYCiK4OTf/t3g9+LVyhiaJx5dVOusA3Cm3KCXl9wJh6gQ3Vb0vLY0Gr1MPMKpz
	 mnHV33QC32ZPJinIxRZ+yjf/gyt9Wkzqwg/4amvXJz/uAbjzenkmBekdVnWkxylBMS
	 ZxGV0Hb/jugOFt00Svd/44yfxnsSyv+M3SA+WB21BMhiEogAj5jYLtDvdyuG9e4S9F
	 mQrVlBtltHCxA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E36503780575;
	Mon, 10 Jun 2024 08:06:49 +0000 (UTC)
Message-ID: <ca6b4ce2-4ebf-409d-b87d-2024445b9392@collabora.com>
Date: Mon, 10 Jun 2024 10:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
 kernel-janitors@vger.kernel.org
References: <20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240607-md-drivers-pwm-v1-1-27237a2bec6a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/06/24 18:02, Jeff Johnson ha scritto:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx1.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-imx27.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-intel-lgm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-mediatek.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-pxa.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-samsung.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-spear.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-visconti.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> This addresses all of the issues in driver/pwm
> 
> Let me know if you want any of the individual module changes
> segregated into separate patches.
> ---
>   drivers/pwm/pwm-imx1.c      | 1 +
>   drivers/pwm/pwm-imx27.c     | 1 +
>   drivers/pwm/pwm-intel-lgm.c | 1 +
>   drivers/pwm/pwm-mediatek.c  | 1 +
>   drivers/pwm/pwm-pxa.c       | 1 +
>   drivers/pwm/pwm-samsung.c   | 1 +
>   drivers/pwm/pwm-spear.c     | 1 +
>   drivers/pwm/pwm-visconti.c  | 1 +
>   8 files changed, 8 insertions(+)
> 

..snip..

> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 19a87873ad60..0b5d68a90e83 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -395,4 +395,5 @@ static struct platform_driver pwm_mediatek_driver = {
>   module_platform_driver(pwm_mediatek_driver);
>   
>   MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
> +MODULE_DESCRIPTION("MediaTek Pulse Width Modulator driver");

MediaTek SoCs have got two different PWM IPs, one of which is used exclusively
for the Display PWM, and it is located in the DDP block.

So, there are two PWM IPs in one SoC:
  - A general purpose PWM IP
  - A DDP PWM IP

This driver is for the general purpose PWM IP.. so, please, can we change this
to "MediaTek general purpose Pulse Width Modulator driver"?

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   MODULE_LICENSE("GPL v2");


