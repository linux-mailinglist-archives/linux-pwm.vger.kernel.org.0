Return-Path: <linux-pwm+bounces-4584-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E86A0B1B3
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 09:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9062D1886443
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0167234964;
	Mon, 13 Jan 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xjl0ttwN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2F233D69;
	Mon, 13 Jan 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758287; cv=none; b=pcZ/OxcsCaYn5XBgrvU0OG0ENNzaq17CaEldRwwCcTppQmv9eAbxIFPwm3eHnN/Vo3k55kGt2jI2wV4gCmItbwUxP/xJe2nH0U1WVZ111qGLU2h5KM/Vsu+3bIFyBtDLVckd1YAByLI1roUB+Za/3H+IPcM7MbgvzZRKGqdRUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758287; c=relaxed/simple;
	bh=2c6gS4kFlKAOPXXqleMPKWgxpbhFP75goYF7wGfdGW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1DpBAhs/F4is54K8emmCAgmMlA+8/YsdJAV968SdJDOssgTFbAoVs7dREw1AYJ7KrZc4j5bjrgEgsjKyABPYT/vSzRJMLAoqQMARAxWhRQjJ5A6KhjMF+clSLM+QaGx8unEAjTJjGSlCsco/UjpRE4Jed1vs5rMP9OFHmZNjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xjl0ttwN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736758277;
	bh=2c6gS4kFlKAOPXXqleMPKWgxpbhFP75goYF7wGfdGW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xjl0ttwNlFVoiyfB0MsOpGJKkRVp3tPZeg0MKaXIDxJrQNpuRWv9uYfk3lZlHRwtH
	 EB8z+ja8vB//UcMZWIqSVavPvx+UhQYB0HL/oYGRv6xfD1Q8lFdl9ovv9jXkcQMWNT
	 A0tGvBYIE4pCn3r9G1ZJhVVp0f2ETZ6BwCjMj6W5Au01UjAnhEApX3SJogUbg8ZUOI
	 rxOxrTV7/5UxwB+7uiSRxd5oEJKQ/0XWndbHRs+8zS6ikKOIrPCy0pQ7Ru1cmvnRXD
	 c3J7TindwDlwzlJ1Pp/R/xrjS6k3hfQvqqNlt8kh8JuyjBBgkWFQDCNamgEnkl3XuJ
	 sYmIooGFiE4Hw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CB4117E0CD5;
	Mon, 13 Jan 2025 09:51:17 +0100 (CET)
Message-ID: <99526d14-7c54-44a0-8549-832077d1b418@collabora.com>
Date: Mon, 13 Jan 2025 09:51:16 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm/mtk-disp: change mm clock as optional
To: Bincai Liu <bincai.liu@mediatek.com>, thierry.reding@gmail.com,
 ukleinek@kernel.org, u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, jitao.shi@mediatek.com
References: <20250113061506.23456-1-bincai.liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250113061506.23456-1-bincai.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/01/25 07:15, Bincai Liu ha scritto:
> mt8196 doesn't have mm clock. Make this clock optional for mt8196.
> 

This commit is okay, but you have to reflect that change in the bindings as well,
otherwise you get validation errors in devicetrees.

Cheers,
Angelo

> Signed-off-by: Bincai Liu <bincai.liu@mediatek.com>
> ---
>   drivers/pwm/pwm-mtk-disp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index bafd6b6195f6..ad7928cd607f 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -250,7 +250,7 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
>   		return dev_err_probe(&pdev->dev, PTR_ERR(mdp->clk_main),
>   				     "Failed to get main clock\n");
>   
> -	mdp->clk_mm = devm_clk_get(&pdev->dev, "mm");
> +	mdp->clk_mm = devm_clk_get_optional(&pdev->dev, "mm");
>   	if (IS_ERR(mdp->clk_mm))
>   		return dev_err_probe(&pdev->dev, PTR_ERR(mdp->clk_mm),
>   				     "Failed to get mm clock\n");



