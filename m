Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40D0F74EC
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKKNau (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 08:30:50 -0500
Received: from mout.web.de ([212.227.17.12]:38781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfKKNat (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 08:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573479044;
        bh=JHH33tMP2aLGoG6hd2naWC08TzJP9RVr7wzSwHw3ztE=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=l0aA//K/2RUrcvaXa6LpH7HfrqH752jCD7l9izMdGUhweDv18ATC3v4UReY6iZyDK
         ZjUjqDn3E/dhzHIUNWGi/63wKDc8nitRz7/XTbgooFPsnqAgfDEhRu8szCxaOu7REm
         WS80h5XzBTFUiWgMgiDj/z5b7XWxDZxDvgZXFyeo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvPJ-1iRgwH19Wj-002W4m; Mon, 11
 Nov 2019 14:30:44 +0100
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: remove pwmchip in .remove before
 making it unfunctional
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dd3fe743-ee4a-153a-c044-40587568a494@web.de>
Date:   Mon, 11 Nov 2019 14:30:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PAt55k6uwKP2TmyddH0jsssRJEeK//fV47icg7lf3UsjXPIoVO2
 I/8URNiAkocLzhmqy3Q1RmZjJZq2aVHD+8nOVMtOrxY1DnP+uFdG4ewPc4ryKD76yPTgVzs
 kdZ12/4+DemnM1fcrjNs/z9wsnqqA6RmgQDcdrk+EAZv1UG9+L37pEIutkDuSkt9nuZQEu1
 2POmHeSZxju+L2vOaTrqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eRbNqoSFOG8=:G/A34WCrEb8bRF8Cczve5u
 hqGrLIC8R+qPmewKEWAWBUvzkx0pC7+c4O4x6GX8rIUpFnz1jykxpKi3LodDWDHncYTjX4Sm9
 c7Hl+4rS3lvnWgZNGo6eav2UcxWhMFAYSU2iraUvYiTwOFtBcdB4UCTqeMwJbnJhGnsmCUhqn
 HSV7mXIyqHZmZ9c4b1I/AwSZllT7vfJ6i3TshdOBBoFDqInrNzNYH1A69f7osaijo7CjwzLJV
 n6JoKAy6zqLw8h9hpWWBI1C1Vy2xKKmrGK3GBeBbcam29IfVESzYwk+E3WEg8jDTUbLDJHeCT
 ssb3I51rcvYhGMcADsJqOqIL+hJFIYQ7qRFyH+DEOD2tjcUonn+lrH7RUmPY6sQnfMc3SaJ5B
 oLxvjTSccpLPXrAYlsJHUPPQfPjxogUQ3WPiJ3GcsYe9RzArJmfdHXlDeYXuBiqu+iDxGZqkX
 JUhnQFssk+GYA3tntWVjJdsrCm5eWLo937pceF+cddf2Odd++MlPzpbX52Kbx1qaDLifiU0f7
 IKqvYD3NHCDfQqolzcux78DT/7dLgUJ8TFQy482c+Jxqkb9rdNU0py0wJGkcZJVY7fs21xZyf
 t6U6W+tvuKQ2TqEjp6skQjt51zTcileI0mNsAbxhzKvxkd06SDCsZLMInsWBhj7mSSPty78fp
 8phKGdWb6M0lSvDy1XepPjLINb4H+s80AqCH0hpGlNShPY7BXhhXVB5iLDq0AeIyfLkvllWwe
 0m+oyME7ZhS88DWFQCgVCREiNMXvA9sp7YGMOnZVhLUWehA6ifQhipF0RcGJsV9b7/LzEOYQm
 2CuUo42PuUrnkc7aDDbNXbdXfpkXaNEgQJKNU437btKHLF65EyruP9+viH9diF5cdGyniRkDf
 aVS+Fmdmqgy0/x2sMvv4Qf0RmHRvSJRAhWHF3d3yDvQiTiozl0be99XIBKRGgfbBEWQLpGb9W
 9gtKrilRfvHGLeeXNUpMyrpeLHX9+As4RzfKoQDZo4akMOsAYr+e+tAQo7MC+FXPxZA0ezyJe
 9W0MdEDK4CQORYm183kv4FRyuwZx16gH1KJTcuLdGbo4ELz8de++eMmCMoCfU8EYmNCaJbmeH
 JvvVHHdk/jIS9W/XyYSArUzZWU9Zi5OyUzyV3Tc6QOMe8syxMvb6ouVNFXx9Df7/EoPQCaQfI
 8775g+ZmhfPg08qyFRVl5ffWheI0J8PHX89lY0q3F+0h32wYv233ihpzpNo9RNMXOO/BTtNje
 gtYXt1e3zjZ19HOMZEG3Db9GtEXU5AQTdgVE+oIz9q4HhK2KIf4gfxlqHOPw=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> In the old code (e.g.) mutex_destroy() was called before
> pwmchip_remove(). Between these two calls it is possible that a pwm
> callback is used which tries to grab the mutex.

How do you think about to add a more =E2=80=9Cimperative mood=E2=80=9D for=
 your
change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D31f4f5b495a62c9a8b15b1c358=
1acd5efeb9af8c#n151


> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -351,6 +351,11 @@ static int pwm_omap_dmtimer_probe(struct platform_d=
evice *pdev)
>  static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
>  {
>  	struct pwm_omap_dmtimer_chip *omap =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&omap->chip);
> +	if (ret)
> +		return ret;
>
>  	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
>  		omap->pdata->stop(omap->dm_timer);

How do you think about to use the following statement variant?

+	int ret =3D pwmchip_remove(&omap->chip);

Regards,
Markus
