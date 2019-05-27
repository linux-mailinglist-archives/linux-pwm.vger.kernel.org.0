Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD82B541
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfE0Mal (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 08:30:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55720 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfE0Mal (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 08:30:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id u78so3143773wmu.5
        for <linux-pwm@vger.kernel.org>; Mon, 27 May 2019 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KCBnQSQIG5e0SbMw2qGIIWVisj1dQacQQ5NaC9OOdsI=;
        b=a0kX27whkYxCa+vnlk7kbRKoFx037MRKt54gCf6xjSdUjzRdHrd+OwVGVJvUSRFLnb
         sa90OCfPTyXh7FoctRf6jjCikUSF31ilKx8MvVV8UBzQnZpa3Pq4+DkgNPKJaF/oFHkF
         9xitIzCenFTzDVrwRa5OY6zzHg8Ima/gZk8Raal9WJLbtxy6xH+fQ4UDT6Pwo7x12Vyi
         oIzc2wbS/9uL52dlY8SLHHTO8C3XL7mw/eyBVj+XzTutaANWAyk3HV0wbjMHhZsRSwDu
         UEvfs3WMrSQ6SlO3UHvjgmzx0QI7Zguq0AMacGitIez0iuXByainydNVD03E9Fyti/w5
         Ff+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KCBnQSQIG5e0SbMw2qGIIWVisj1dQacQQ5NaC9OOdsI=;
        b=qIrWW513RDmZvefPE+BkEtYE9egBKcK6wDV00aTw+puc8uvfzcYVtNKIycvP6fnFOC
         yobDg0gcD0wGTtJgAlLs/1l0TvAIPHIie27MRVMb7xYe5IKeUzrfMXJRCIkzvlgkqQ9O
         r8pWz4BJq1LxQqGkbxuWXRcEdRls9vQlpe41UaVFUr0yrl9VFfnGrHaqyJvw850N7PVr
         o9S2LVaODXa+arUGivufxUd4RrpQjcMKDFmfhEV+9wlY9vzoiA4n5KuNv3Xlyzx61f10
         /uoNoU7l3hgIlyKMq9KBz9IjQ7/DmmVDsz2+UQsGICRIGZt4qcGaTQVdu3QBQf2CESZk
         ZSRw==
X-Gm-Message-State: APjAAAVckCgbauS/H8hkUy9q51aombauJ+DRChMdTupIXziaq+Nh4imw
        0CjXB2b8btyGcccQh92JScNmSA==
X-Google-Smtp-Source: APXvYqyEG6ZlK+E92ITcBfCpfsU875F7+cNbeSaLzogr2/2gcEimyGcruRDaIcuOzKCKK6jOE3bRVw==
X-Received: by 2002:a05:600c:240e:: with SMTP id 14mr3157460wmp.133.1558960238387;
        Mon, 27 May 2019 05:30:38 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a4sm9210277wrf.78.2019.05.27.05.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:30:37 -0700 (PDT)
Subject: Re: [PATCH 09/14] pwm: meson: move pwm_set_chip_data() to
 meson_pwm_request()
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-10-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <aa6e6832-6bbc-87d7-9937-b18aec83a2ff@baylibre.com>
Date:   Mon, 27 May 2019 14:30:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525181133.4875-10-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> All existing PWM drivers (except pwm-meson and two other ones) call
> pwm_set_chip_data() from their pwm_ops.request() callback. Now that we
> can access the struct meson_pwm_channel from struct meson_pwm we can do
> the same.
> 
> Move the call to pwm_set_chip_data() to meson_pwm_request() and drop the
> custom meson_pwm_add_channels(). This makes the implementation
> consistent with other drivers and makes it slightly more obvious
> thatpwm_get_chip_data() cannot be used from pwm_ops.get_state() (because
> that's called by the PWM core before pwm_ops.request()).
> 
> No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index ac7e188155fd..27915d6475e3 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -98,12 +98,16 @@ static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
>  
>  static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	struct meson_pwm_channel *channel;
>  	struct device *dev = chip->dev;
>  	int err;
>  
> -	if (!channel)
> -		return -ENODEV;
> +	channel = pwm_get_chip_data(pwm);
> +	if (channel)
> +		return 0;
> +
> +	channel = &meson->channels[pwm->hwpwm];
>  
>  	if (channel->clk_parent) {
>  		err = clk_set_parent(channel->clk, channel->clk_parent);
> @@ -124,7 +128,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  	chip->ops->get_state(chip, pwm, &channel->state);
>  
> -	return 0;
> +	return pwm_set_chip_data(pwm, channel);
>  }
>  
>  static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -460,14 +464,6 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>  	return 0;
>  }
>  
> -static void meson_pwm_add_channels(struct meson_pwm *meson)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < meson->chip.npwm; i++)
> -		pwm_set_chip_data(&meson->chip.pwms[i], &meson->channels[i]);
> -}
> -
>  static int meson_pwm_probe(struct platform_device *pdev)
>  {
>  	struct meson_pwm *meson;
> @@ -503,8 +499,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	meson_pwm_add_channels(meson);
> -
>  	platform_set_drvdata(pdev, meson);
>  
>  	return 0;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
