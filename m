Return-Path: <linux-pwm+bounces-3529-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109869940BB
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 10:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB3928708F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520FA208209;
	Tue,  8 Oct 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTfS0bHR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79181DE8AA
	for <linux-pwm@vger.kernel.org>; Tue,  8 Oct 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372642; cv=none; b=LlL1ZSyfaOIecuUz+NUPP3rh34dhj9AfRvwpn7I5tDFdZmAYb/AroO6kRQCVrV3F0y14ZmI8K0RSACwM6d8eyLgMNrQMUiMJWUXnDkgy8u6ZRnW5CY/IBc8zhfpV6BN51UtwS4DlTGdkQ4Uc0K2lG3mK69yCNnuV4i+sYk+3We8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372642; c=relaxed/simple;
	bh=MIlFw+X+hwItqBJNBL3q3FRanf2MmNZ0kQviipJu0dM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mf4t11zV2h21Xgcr4wTteLKlLX7EmzErB4vLSBdPyq00V3ncq/Q4y/z+JsetTZ5arBj6YjVxdQTvh3rIKJLo9tv3l+HE37xoFkgRISwW9vVi/wxzHw3t/P+BbELnx3UardiCeOu671jvCwyS40n6qYU1lAdnapzquh1LJHISQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cTfS0bHR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so2828505f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2024 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728372635; x=1728977435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+tfe05jkpva44hxBjr/Vz8A+uiJhI9IRRzSTlXsySY=;
        b=cTfS0bHRqUtF+L+T9VM56ZNmQaHZ1BzmSNSxLrF/aZNClZSoK75Dxw2FyD7tMXs4F5
         PJFSyeVwd5Ycq7VHnzZjXP2vI71Hbu4lsrtgYoFsQf0sk/MBDfpxMWaeuaHqcHXdT9n2
         6g5ZhBdbCyF6WmNoCdHRHEsgqsucXJxNkFlew6NbPFjZmVPMPBiYBk4iI/NILVkZ6+VZ
         IT0Jls3xnw19vQE6Li7O68+NpOLN/ilK+w5kF9862toa3rpj7tI66aEKZM4SATP2W07S
         cnPoqEb+Z7synYL8cqBmxFg6tpgFtW5V5a+I+nilNEWXlZ3La7+I0NmkbstXBid89rjs
         D7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372635; x=1728977435;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+tfe05jkpva44hxBjr/Vz8A+uiJhI9IRRzSTlXsySY=;
        b=MayRf/kIZ95Ucfb4VWCHTVLu1lWUFp/iJ5eLHM/xxQIvZWR7yoJvIadLpSa29aMZP7
         6RVGocqJJlHxgycVbq/MYZdUtfPQuRhZ8TZsx3yXIIDx3exw1iejVi4/ZSprs5ORzT3A
         p1ptA5uxkwcbGiRuEFDy6V6K4l80DztzCkatyyu8SLj78m4nHvI3t10uZHjSRZSsXQ44
         TqK1KvK3dH5Nr6QIfv6HLc0yY5k36t7UHRbXTN6+MESjO3qKGTKvcpiBSXqza3c8iQUS
         I7KiND8KjuRQATMae9UKQ97324EjWpbZOege+TdVGc+xIcjgJBQExE+H+0XRUN7KbTDP
         bmog==
X-Gm-Message-State: AOJu0YzPRsU0LhGF92XZsxYnoqO4AMLJ+dkbB2gjJ6rpfIfwNV1u74iY
	RK1e/UAoQMFLT7tHVFM4597Oe7KNPWlG9/3sGtinbuJeM444ZneFUZDSOIN3q/A=
X-Google-Smtp-Source: AGHT+IFV0m4+y5zOPB/SKH51eRkAv1SrzN8sTyMTJg+w7xkdUuieRr/IBcuAqEi0qM5bHYOpNSV2FQ==
X-Received: by 2002:a5d:570b:0:b0:37d:34f6:92a with SMTP id ffacd0b85a97d-37d34f60a85mr143716f8f.51.1728372635067;
        Tue, 08 Oct 2024 00:30:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed957asm99662485e9.44.2024.10.08.00.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:30:34 -0700 (PDT)
Message-ID: <478259f2-b7ec-4664-95cb-3ab56ae6d529@linaro.org>
Date: Tue, 8 Oct 2024 09:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] pwm: meson: Support constant and polarity bits
To: George Stark <gnstark@salutedevices.com>, u.kleine-koenig@pengutronix.de,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com
References: <20241007193203.1753326-1-gnstark@salutedevices.com>
 <20241007193203.1753326-2-gnstark@salutedevices.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241007193203.1753326-2-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 07/10/2024 21:32, George Stark wrote:
> Newer meson PWM IPs support constant and polarity bits. Support them to
> correctly implement constant and inverted output levels.
> 
> Using constant bit allows to have truly stable low or high output level.
> Since hi and low regs internally increment its values by 1 just writing
> zero to any of them gives 1 clock count impulse. If constant bit is set
> zero value in hi and low regs is not incremented.
> 
> Using polarity bit instead of swapping hi and low reg values allows to
> correctly identify inversion in .get_state().
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   drivers/pwm/pwm-meson.c | 75 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 98e6c1533312..5d51404bdce3 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -6,7 +6,7 @@
>    * PWM output is achieved by calculating a clock that permits calculating
>    * two periods (low and high). The counter then has to be set to switch after
>    * N cycles for the first half period.
> - * The hardware has no "polarity" setting. This driver reverses the period
> + * Partly the hardware has no "polarity" setting. This driver reverses the period
>    * cycles (the low length is inverted with the high length) for
>    * PWM_POLARITY_INVERSED. This means that .get_state cannot read the polarity
>    * from the hardware.
> @@ -56,6 +56,10 @@
>   #define MISC_B_CLK_SEL_SHIFT	6
>   #define MISC_A_CLK_SEL_SHIFT	4
>   #define MISC_CLK_SEL_MASK	0x3
> +#define MISC_B_CONSTANT_EN	BIT(29)
> +#define MISC_A_CONSTANT_EN	BIT(28)
> +#define MISC_B_INVERT_EN	BIT(27)
> +#define MISC_A_INVERT_EN	BIT(26)
>   #define MISC_B_EN		BIT(1)
>   #define MISC_A_EN		BIT(0)

Nice, seems I completely missed those 2 features!

> 
> @@ -68,6 +72,8 @@ static struct meson_pwm_channel_data {
>   	u8		clk_div_shift;
>   	u8		clk_en_shift;
>   	u32		pwm_en_mask;
> +	u32		const_en_mask;
> +	u32		inv_en_mask;
>   } meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
>   	{
>   		.reg_offset	= REG_PWM_A,
> @@ -75,6 +81,8 @@ static struct meson_pwm_channel_data {
>   		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
>   		.clk_en_shift	= MISC_A_CLK_EN_SHIFT,
>   		.pwm_en_mask	= MISC_A_EN,
> +		.const_en_mask	= MISC_A_CONSTANT_EN,
> +		.inv_en_mask	= MISC_A_INVERT_EN,
>   	},
>   	{
>   		.reg_offset	= REG_PWM_B,
> @@ -82,6 +90,8 @@ static struct meson_pwm_channel_data {
>   		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
>   		.clk_en_shift	= MISC_B_CLK_EN_SHIFT,
>   		.pwm_en_mask	= MISC_B_EN,
> +		.const_en_mask	= MISC_B_CONSTANT_EN,
> +		.inv_en_mask	= MISC_B_INVERT_EN,
>   	}
>   };
> 
> @@ -99,6 +109,8 @@ struct meson_pwm_channel {
>   struct meson_pwm_data {
>   	const char *const parent_names[MESON_NUM_MUX_PARENTS];
>   	int (*channels_init)(struct pwm_chip *chip);
> +	bool has_constant;
> +	bool has_polarity;
>   };
> 
>   struct meson_pwm {
> @@ -160,7 +172,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
>   	 * Fixing this needs some care however as some machines might rely on
>   	 * this.
>   	 */
> -	if (state->polarity == PWM_POLARITY_INVERSED)
> +	if (state->polarity == PWM_POLARITY_INVERSED && !meson->data->has_polarity)
>   		duty = period - duty;
> 
>   	freq = div64_u64(NSEC_PER_SEC * 0xffffULL, period);
> @@ -204,6 +216,46 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
>   	return 0;
>   }
> 
> +static void meson_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> +				   bool inverted)
> +{
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	const struct meson_pwm_channel_data *channel_data;
> +	unsigned long flags;
> +	u32 value;
> +
> +	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
> +
> +	spin_lock_irqsave(&meson->lock, flags);
> +	value = readl(meson->base + REG_MISC_AB);
> +	if (inverted)
> +		value |= channel_data->inv_en_mask;
> +	else
> +		value &= ~channel_data->inv_en_mask;
> +	writel(value, meson->base + REG_MISC_AB);
> +	spin_unlock_irqrestore(&meson->lock, flags);
> +}
> +
> +static void meson_pwm_set_constant(struct pwm_chip *chip, struct pwm_device *pwm,
> +				   bool enable)
> +{
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	const struct meson_pwm_channel_data *channel_data;
> +	unsigned long flags;
> +	u32 value;
> +
> +	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
> +
> +	spin_lock_irqsave(&meson->lock, flags);
> +	value = readl(meson->base + REG_MISC_AB);
> +	if (enable)
> +		value |= channel_data->const_en_mask;
> +	else
> +		value &= ~channel_data->const_en_mask;
> +	writel(value, meson->base + REG_MISC_AB);
> +	spin_unlock_irqrestore(&meson->lock, flags);
> +}

Those functions looks quite complicated, why can't they be part of
meson_pwm_enable/disable where we already write REG_MISC_AB ?

> +
>   static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>   {
>   	struct meson_pwm *meson = to_meson_pwm(chip);
> @@ -255,9 +307,9 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	int err = 0;
> 
>   	if (!state->enabled) {
> -		if (state->polarity == PWM_POLARITY_INVERSED) {
> +		if (state->polarity == PWM_POLARITY_INVERSED && !meson->data->has_polarity) {
>   			/*
> -			 * This IP block revision doesn't have an "always high"
> +			 * Some of IP block revisions don't have an "always high"
>   			 * setting which we can use for "inverted disabled".
>   			 * Instead we achieve this by setting mux parent with
>   			 * highest rate and minimum divider value, resulting
> @@ -284,6 +336,14 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   		meson_pwm_enable(chip, pwm);
>   	}
> 
> +	if (meson->data->has_constant)
> +		meson_pwm_set_constant(chip, pwm,
> +				       state->duty_cycle == state->period ||
> +				       !state->duty_cycle);
> +	if (meson->data->has_polarity)
> +		meson_pwm_set_polarity(chip, pwm,
> +				       !(state->polarity == PWM_POLARITY_NORMAL));
> +
>   	return 0;
>   }
> 
> @@ -318,6 +378,11 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	value = readl(meson->base + REG_MISC_AB);
>   	state->enabled = value & channel_data->pwm_en_mask;
> 
> +	if (meson->data->has_polarity && (value & channel_data->inv_en_mask))
> +		state->polarity = PWM_POLARITY_INVERSED;
> +	else
> +		state->polarity = PWM_POLARITY_NORMAL;
> +
>   	value = readl(meson->base + channel_data->reg_offset);
>   	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>   	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
> @@ -325,8 +390,6 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
>   	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> 
> -	state->polarity = PWM_POLARITY_NORMAL;
> -
>   	return 0;
>   }
> 
> --
> 2.25.1
> 


