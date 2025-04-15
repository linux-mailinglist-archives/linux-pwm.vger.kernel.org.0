Return-Path: <linux-pwm+bounces-5487-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17803A89D2F
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289871788AC
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A404292915;
	Tue, 15 Apr 2025 12:10:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459DD274647
	for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719044; cv=none; b=i70uwyRzP1qXp0+8PEsHF/cmN1cxcPkiO8lnmC5O96QVcRsWWWokCDzG6Z2QG9KwNiaDgnCXrEhWDuHZI1YWiOXq13h6bOjcGQya7rSJvbUvGg3Lja1f4YusX2bnAqcJq4MO1L4Av0NEj/XYB8FAq+LPfyHW4xLb3ov61aTMbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719044; c=relaxed/simple;
	bh=lnRqSs+UA/TqSvD99hUx2xkZw5R4kLOXslEB7rHxfBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyXJ9B8GAh54NMedFdKGt8pCZEZvA3cbIYyxnECxWaTGbn9IxirxYmmQQ7cR0iBKGLqsl0571ki7aBwy/t9FBgueWHH4rEFlUPnU17Ej0OCce7S6HGIoajo6Ag3nU0IEX+YxzjcCwMkclvsy2XODDARjpVsOvTX1WpUyd7c6dUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.238])
	by gateway (Coremail) with SMTP id _____8AxCGq6TP5nYwS+AA--.53031S3;
	Tue, 15 Apr 2025 20:10:34 +0800 (CST)
Received: from [127.0.0.1] (unknown [223.64.68.238])
	by front1 (Coremail) with SMTP id qMiowMDxfRuyTP5n2CaDAA--.2270S2;
	Tue, 15 Apr 2025 20:10:30 +0800 (CST)
Message-ID: <ad19c0a0-2179-4299-9f65-77163716a733@loongson.cn>
Date: Tue, 15 Apr 2025 20:10:25 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: loongson: Fix u32 overflow in waveform calculation
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-pwm@vger.kernel.org
References: <20250412122124.1636152-2-u.kleine-koenig@baylibre.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20250412122124.1636152-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxfRuyTP5n2CaDAA--.2270S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFWDuFyrZr4UtF4ktrWDAwc_yoW8ZFWrpF
	WUCw1Uur4rArW7Aa4DJF9avF13ZayrXFy3Ja95G34UCasIgwnrZr18KF9rGa47ury8GF1I
	qrWF9F15Aa1DXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==

Hi Uwe:

I'm very sorry for the late reply, I've been delayed for the past few 
days due to personal reasons.
I will be more aware of this in the future.

Also, heartfelt thanks to you and Dan for the patch.

On 2025/4/12 20:21, Uwe Kleine-König wrote:
> mul_u64_u64_div_u64() returns an u64 that might be bigger than U32_MAX.
> To properly handle this case it must not be directly assigned to an u32
> value.
>
> Use a wider type for duty and period to make the idiom:
>
> 	duty = mul_u64_u64_div_u64(...)
> 	if (duty > U32_MAX)
> 		duty = U32_MAX;
>
> actually work as intended.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/r/44f3c764-8b65-49a9-b3ad-797e9fbb96f5@stanley.mountain
> Fixes: 322fc380cea1 ("pwm: Add Loongson PWM controller support")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
> Hello,
>
> this is the approach that Dan suggested in reply to my suggested fix. This has
> the advantage to not involve a very long line. I didn't check but I'd expect that the compiler produces comparable results for both approaches and so they are more or less equivalent after compilation.
>
> Best regards
> Uwe
>
>   drivers/pwm/pwm-loongson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> index 412c67739ef9..6392c4e34136 100644
> --- a/drivers/pwm/pwm-loongson.c
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -118,7 +118,7 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>   static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   			       u64 duty_ns, u64 period_ns)
>   {
> -	u32 duty, period;
> +	u64 duty, period;
>   	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
>   
>   	/* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
>
> base-commit: 957062f2ba4790c495de606ecf8bc7398c0c710f
Thanks.
Binbin


