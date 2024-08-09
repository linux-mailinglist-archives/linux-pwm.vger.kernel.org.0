Return-Path: <linux-pwm+bounces-2988-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6594CCB5
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0D028907C
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BD190063;
	Fri,  9 Aug 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knY0Oo/n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8318FC68;
	Fri,  9 Aug 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193453; cv=none; b=qFXPnXyQwLDg84TVwMdjxzLBzof2My9gBbfiz1bCMYBSa+6PzDS9HaR8XyedS/AgpPy38DhTCP3YS0nIZwbWn6lm92UJnzBHCQthLt9Yhph5a51cz7vWt1RKrC1YKPM5Mydf1QIRWAhNtrRBFl2avgKr6NBbG+5KV/oS+OpFMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193453; c=relaxed/simple;
	bh=fVzlvtHFCnaUq2oe9WHI8ZqKZ37g0npwYHKtRgESLW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsCazi92WERVFNzm9a/2+QPswFn/zbJINDCtOGvIrfdqhHGEfFCSh/Mpf8WJ+WSjBSa7qj4aRRDABPuEVs9yGXM6PgbftUgxWx3tEZi9UK5AwyrBZUQ9rzOp3JYxanXOBcIQPc7r15dh92kokZdL4SVPt6Im//QlRmmrEBPu4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knY0Oo/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539C3C32782;
	Fri,  9 Aug 2024 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723193453;
	bh=fVzlvtHFCnaUq2oe9WHI8ZqKZ37g0npwYHKtRgESLW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=knY0Oo/nhPHM0e7Cc78srkwiNLBhdkb6v0hPKb2LO28OiKTgReu0Zz+wtX+AFh92+
	 SlXqe7+OAa2b9y0xw02/X1tQJK7pqgOI2sGfbO8FR1DmtgqmM8eza8+UTpXbiSiq/Q
	 LpksQRJtXx0a6VwTADB9NbFSXjA61clgjrOCT6uq6RXJkxslHx9IH9y2qHApb4OErY
	 BoWWs8LWevtoG07elghDbhBeUCwFfXJabPngLXkuXYQ4+tjRaSUEY4/yxrQQGkijNB
	 u3wb3+6qsInwNY1/KkiQY43RaxkyVQEfvXurDMzqP2od1CVaHC9Mq7wflvgSp1Q4jJ
	 0aAmUU10E1BiA==
Message-ID: <96f7b10a-e33e-4602-ab5f-4ebdac260592@kernel.org>
Date: Fri, 9 Aug 2024 10:50:49 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] pwm: lp3943: Fix an incorrect type in
 lp3943_pwm_parse_dt()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240809080523.32717-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
In-Reply-To: <20240809080523.32717-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jiapeng,

On 8/9/24 10:05, Jiapeng Chong wrote:
> The return value from the call to of_property_count_u32_elems() is int.
> However, the return value is being assigned to an u32 variable
> 'num_outputs', so making 'num_outputs' an int.
> 
> ./drivers/pwm/pwm-lp3943.c:238:6-17: WARNING: Unsigned expression compared with zero: num_outputs <= 0.

Which tool does emit this warning? My test build (with C=1 and W=1) 
doesn't emit it.

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9710
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

This problem was introduced in a commit in next:

Fixes: d6a56f3bb650 ("pwm: lp3943: Use of_property_count_u32_elems() to 
get property length")

Rob: I guess this wasn't the only conversion of this type. Maybe these 
others suffer from the same problem?!

> ---
>   drivers/pwm/pwm-lp3943.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
> index f0e94c9e5956..90b0733c00c1 100644
> --- a/drivers/pwm/pwm-lp3943.c
> +++ b/drivers/pwm/pwm-lp3943.c
> @@ -218,8 +218,7 @@ static int lp3943_pwm_parse_dt(struct device *dev,
>   	struct lp3943_platform_data *pdata;
>   	struct lp3943_pwm_map *pwm_map;
>   	enum lp3943_pwm_output *output;
> -	int i, err, count = 0;
> -	u32 num_outputs;
> +	int i, err, num_outputs, count = 0;
>   
>   	if (!node)
>   		return -EINVAL;

Nitpick (maybe even a subjective one):
While touching num_outputs, its scope could be reduced to the for loop.

Best regards
Uwe

