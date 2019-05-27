Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7032B520
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 14:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfE0M13 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 08:27:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfE0M13 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 08:27:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so16777893wrt.1
        for <linux-pwm@vger.kernel.org>; Mon, 27 May 2019 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uNYwHokJ6ylk7hXd5Q1wHtxzHNPKIKL1jhg/PwYShkY=;
        b=WkttSJJnmK5NNgI8tVEQh9iLifkpoSzumsNlNYOe5M44s/WssHodSfbSepXFfZm+21
         /HUCTfs+DAeHAp2SHLMpSQL2X3UYi+IOTq+lCzBVdAKut3/v80aM0OL7lCOCx3t+BkU4
         8kzwEs7P3wEBgncxa0lX293wD4k06VGoU/uRmq1CzbrkoRyFyaqUd5QJ5B6nN7uz69rj
         mFkFr4j/1uptrsJPk330YyHqvKzBSzFiO2Bq2MY9wq0TM+p68oXa+JWUf5xFvg0cU5Ov
         j+wOrONCj4nBvr77dtyvsCMDxQKSlfFz2Gaq5wg/8q1VNHTRcNNIlCCMQSeraWRiE1jL
         ItBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uNYwHokJ6ylk7hXd5Q1wHtxzHNPKIKL1jhg/PwYShkY=;
        b=Wy4P7mcQCLR5xGpTZO3KO4TFzELCl9UFOf2mOinpuv9g4yjinjEvKNd8nCfngebMnf
         +qnFPO5krkLM49traEk1eIWQiKij5IY7HMPTwDUudUvLuKpb5HjAxxq0EtWg6XBLr7qx
         vY+qfye1QFntjBFGc0a5uYso3fg0q3fssKFc/jisp8IDKQM240V+pEPPCe5ifcZ9GCRi
         davmmS/QgDupmPRwoTFYm5Fq5P5o+71MbHpQAzkRPReR4DcwTJBkZUoIGzJUfXgnhsBp
         QTf/vjNef06+yxZtY8daMhITS5FYzeObpdKjjXSFSnfDvDMDgSFF7OPV5mwbSShrdnL1
         6QFA==
X-Gm-Message-State: APjAAAXMBheL7bvdsnt7s23MypmyQ4VG5e2ffgJvboo0LmVxTilSUPYU
        Abc9KeJ4e0WHqPUv1qcX2z4CHA==
X-Google-Smtp-Source: APXvYqxScfM6D3qQK9pu8BJbb9EIzHRkKRd37gJRb+bAqNLgehRDoJkRq3OkCjkuHvmYr9sWOaZgUQ==
X-Received: by 2002:adf:e344:: with SMTP id n4mr21514694wrj.192.1558960046964;
        Mon, 27 May 2019 05:27:26 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g185sm9713750wmf.30.2019.05.27.05.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:27:26 -0700 (PDT)
Subject: Re: [PATCH 07/14] pwm: meson: add the meson_pwm_channel data to
 struct meson_pwm
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 mQENBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAG0KE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT6JATsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIW5AQ0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAYkBHwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8guQINBFYnf6QBEADQ+wBYa+X2n/xIQz/RUoGHf84Jm+yTqRT43t7sO48/cBW9vAn9
 GNwnJ3HRJWKATW0ZXrCr40ES/JqM1fUTfiFDB3VMdWpEfwOAT1zXS+0rX8yljgsWR1UvqyEP
 3xN0M/40Zk+rdmZKaZS8VQaXbveaiWMEmY7sBV3QvgOzB7UF2It1HwoCon5Y+PvyE3CguhBd
 9iq5iEampkMIkbA3FFCpQFI5Ai3BywkLzbA3ZtnMXR8Qt9gFZtyXvFQrB+/6hDzEPnBGZOOx
 zkd/iIX59SxBuS38LMlhPPycbFNmtauOC0DNpXCv9ACgC9tFw3exER/xQgSpDVc4vrL2Cacr
 wmQp1k9E0W+9pk/l8S1jcHx03hgCxPtQLOIyEu9iIJb27TjcXNjiInd7Uea195NldIrndD+x
 58/yU3X70qVY+eWbqzpdlwF1KRm6uV0ZOQhEhbi0FfKKgsYFgBIBchGqSOBsCbL35f9hK/JC
 6LnGDtSHeJs+jd9/qJj4WqF3x8i0sncQ/gszSajdhnWrxraG3b7/9ldMLpKo/OoihfLaCxtv
 xYmtw8TGhlMaiOxjDrohmY1z7f3rf6njskoIXUO0nabun1nPAiV1dpjleg60s3OmVQeEpr3a
 K7gR1ljkemJzM9NUoRROPaT7nMlNYQL+IwuthJd6XQqwzp1jRTGG26J97wARAQABiQM+BBgB
 AgAJBQJWJ3+kAhsCAikJEBaat7Gkz/iuwV0gBBkBAgAGBQJWJ3+kAAoJEHfc29rIyEnRk6MQ
 AJDo0nxsadLpYB26FALZsWlN74rnFXth5dQVQ7SkipmyFWZhFL8fQ9OiIoxWhM6rSg9+C1w+
 n45eByMg2b8H3mmQmyWztdI95OxSREKwbaXVapCcZnv52JRjlc3DoiiHqTZML5x1Z7lQ1T3F
 8o9sKrbFO1WQw1+Nc91+MU0MGN0jtfZ0Tvn/ouEZrSXCE4K3oDGtj3AdC764yZVq6CPigCgs
 6Ex80k6QlzCdVP3RKsnPO2xQXXPgyJPJlpD8bHHHW7OLfoR9DaBNympfcbQJeekQrTvyoASw
 EOTPKE6CVWrcQIztUp0WFTdRGgMK0cZB3Xfe6sOp24PQTHAKGtjTHNP/THomkH24Fum9K3iM
 /4Wh4V2eqGEgpdeSp5K+LdaNyNgaqzMOtt4HYk86LYLSHfFXywdlbGrY9+TqiJ+ZVW4trmui
 NIJCOku8SYansq34QzYM0x3UFRwff+45zNBEVzctSnremg1mVgrzOfXU8rt+4N1b2MxorPF8
 619aCwVP7U16qNSBaqiAJr4e5SNEnoAq18+1Gp8QsFG0ARY8xp+qaKBByWES7lRi3QbqAKZf
 yOHS6gmYo9gBmuAhc65/VtHMJtxwjpUeN4Bcs9HUpDMDVHdfeRa73wM+wY5potfQ5zkSp0Jp
 bxnv/cRBH6+c43stTffprd//4Hgz+nJcCgZKtCYIAPkUxABC85ID2CidzbraErVACmRoizhT
 KR2OiqSLW2x4xdmSiFNcIWkWJB6Qdri0Fzs2dHe8etD1HYaht1ZhZ810s7QOL7JwypO8dscN
 KTEkyoTGn6cWj0CX+PeP4xp8AR8ot4d0BhtUY34UPzjE1/xyrQFAdnLd0PP4wXxdIUuRs0+n
 WLY9Aou/vC1LAdlaGsoTVzJ2gX4fkKQIWhX0WVk41BSFeDKQ3RQ2pnuzwedLO94Bf6X0G48O
 VsbXrP9BZ6snXyHfebPnno/te5XRqZTL9aJOytB/1iUna+1MAwBxGFPvqeEUUyT+gx1l3Acl
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <f218f396-9f07-c81c-62cc-bd363abfcbaa@baylibre.com>
Date:   Mon, 27 May 2019 14:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525181133.4875-8-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> Make struct meson_pwm_channel accessible from struct meson_pwm.
> 
> PWM core has a limitation: per-channel data can only be set after
> pwmchip_add() is called. However, pwmchip_add() internally calls
> pwm_ops.get_state(). If pwm_ops.get_state() needs access to the
> per-channel data it has to obtain it from struct pwm_chip and struct
> pwm_device's hwpwm information.
> 
> Add a struct meson_pwm_channel for each PWM channel to struct meson_pwm
> so the pwm_ops.get_state() callback can be implemented as it needs
> access to the clock from struct meson_pwm_channel.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index d6eb4d04d5c9..d1718f54ecec 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -37,6 +37,8 @@
>  #define MISC_B_EN		BIT(1)
>  #define MISC_A_EN		BIT(0)
>  
> +#define MESON_NUM_PWMS		2
> +
>  static const unsigned int mux_reg_shifts[] = {
>  	MISC_A_CLK_SEL_SHIFT,
>  	MISC_B_CLK_SEL_SHIFT
> @@ -62,6 +64,7 @@ struct meson_pwm_data {
>  struct meson_pwm {
>  	struct pwm_chip chip;
>  	const struct meson_pwm_data *data;
> +	struct meson_pwm_channel channels[MESON_NUM_PWMS];
>  	void __iomem *base;
>  	/*
>  	 * Protects register (write) access to the REG_MISC_AB register
> @@ -435,8 +438,7 @@ static const struct of_device_id meson_pwm_matches[] = {
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>  
> -static int meson_pwm_init_channels(struct meson_pwm *meson,
> -				   struct meson_pwm_channel *channels)
> +static int meson_pwm_init_channels(struct meson_pwm *meson)
>  {
>  	struct device *dev = meson->chip.dev;
>  	struct clk_init_data init;
> @@ -445,7 +447,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  	int err;
>  
>  	for (i = 0; i < meson->chip.npwm; i++) {
> -		struct meson_pwm_channel *channel = &channels[i];
> +		struct meson_pwm_channel *channel = &meson->channels[i];
>  
>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>  
> @@ -480,18 +482,16 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  	return 0;
>  }
>  
> -static void meson_pwm_add_channels(struct meson_pwm *meson,
> -				   struct meson_pwm_channel *channels)
> +static void meson_pwm_add_channels(struct meson_pwm *meson)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < meson->chip.npwm; i++)
> -		pwm_set_chip_data(&meson->chip.pwms[i], &channels[i]);
> +		pwm_set_chip_data(&meson->chip.pwms[i], &meson->channels[i]);
>  }
>  
>  static int meson_pwm_probe(struct platform_device *pdev)
>  {
> -	struct meson_pwm_channel *channels;
>  	struct meson_pwm *meson;
>  	struct resource *regs;
>  	int err;
> @@ -509,18 +509,13 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	meson->chip.dev = &pdev->dev;
>  	meson->chip.ops = &meson_pwm_ops;
>  	meson->chip.base = -1;
> -	meson->chip.npwm = 2;
> +	meson->chip.npwm = MESON_NUM_PWM;
>  	meson->chip.of_xlate = of_pwm_xlate_with_flags;
>  	meson->chip.of_pwm_n_cells = 3;
>  
>  	meson->data = of_device_get_match_data(&pdev->dev);
>  
> -	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
> -				sizeof(*channels), GFP_KERNEL);
> -	if (!channels)
> -		return -ENOMEM;
> -
> -	err = meson_pwm_init_channels(meson, channels);
> +	err = meson_pwm_init_channels(meson);
>  	if (err < 0)
>  		return err;
>  
> @@ -530,7 +525,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	meson_pwm_add_channels(meson, channels);
> +	meson_pwm_add_channels(meson);
>  
>  	platform_set_drvdata(pdev, meson);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
