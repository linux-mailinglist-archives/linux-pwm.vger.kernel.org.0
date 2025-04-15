Return-Path: <linux-pwm+bounces-5489-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C1A89D86
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF21A1900655
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B9B29291E;
	Tue, 15 Apr 2025 12:16:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047628469B;
	Tue, 15 Apr 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719396; cv=none; b=uWnDbbF2pKBrBArPZFohStH9ilQ/fxicw54AFRATVwtvmEPcPNERIokbcsW/5k+o5uSr7KblrUUJ68xfJ0OAVbe0grqD6Cffr85HKjPyUNErvAzT79hjJhMMA7dxfHAxNjpW8BXBXRZHXLf7oVcR5MmZBj7unIOjLBr3qv3mCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719396; c=relaxed/simple;
	bh=Jalx0jktLdqJ0meoKTF6WfsBEnJQ1W/zMyKteV/2hQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMrta1jM5czRbux7MlPFqqHEv5KA4tbLaXE3A+S1trw2t19W0kBNm+osouszP05UXoecG0CQVXmF1WG+e8Yvad3GgaA+0W84F6JhKZUxOnOclFAqac5gCYVq/uSOpVDT3F2R7RfoEOdwkiXP6feex+mVFUNjF0YbrXKX1IEPhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.238])
	by gateway (Coremail) with SMTP id _____8AxCGoZTv5n+wa+AA--.53053S3;
	Tue, 15 Apr 2025 20:16:25 +0800 (CST)
Received: from [127.0.0.1] (unknown [223.64.68.238])
	by front1 (Coremail) with SMTP id qMiowMAxTsUVTv5nuiqDAA--.38838S2;
	Tue, 15 Apr 2025 20:16:24 +0800 (CST)
Message-ID: <5bf96932-330c-483c-9a09-e84b73cd14ca@loongson.cn>
Date: Tue, 15 Apr 2025 20:16:20 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] pwm: loongson: Fix an error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Juxin Gao <gaojuxin@loongson.cn>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <6965a480-745c-426f-b17b-e96af532578f@stanley.mountain>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <6965a480-745c-426f-b17b-e96af532578f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxTsUVTv5nuiqDAA--.38838S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr17uryfKFW8XFW5trWUAwc_yoWDKFb_uw
	1I9rnrGr1DAr1qk34avFWfAFW2vFWUZw109wsrtw4Iqa4vg3Z5tFyrXrs2gFnrXr4fAF98
	X39rJryIk34rAosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_
	Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUUU

Hi Dan:

Sorry for my late reply and thanks for fixing my cheap mistake.

On 2025/4/9 19:00, Dan Carpenter wrote:
> There is a copy and paste bug so we accidentally returned
> PTR_ERR(ddata->clk) instead of "ret".
>
> Fixes: 322fc380cea1 ("pwm: Add Loongson PWM controller support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/pwm/pwm-loongson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> index 412c67739ef9..e31afb11ddd7 100644
> --- a/drivers/pwm/pwm-loongson.c
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -211,7 +211,7 @@ static int pwm_loongson_probe(struct platform_device *pdev)
>   	if (ddata->clk) {
>   		ret = devm_clk_rate_exclusive_get(dev, ddata->clk);
>   		if (ret)
> -			return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +			return dev_err_probe(dev, ret,
>   					     "Failed to get exclusive rate\n");
>   
>   		ddata->clk_rate = clk_get_rate(ddata->clk);
Thanks.
Binbin


