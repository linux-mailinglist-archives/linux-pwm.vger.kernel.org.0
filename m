Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54738F7504
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKNcg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 08:32:36 -0500
Received: from mout.web.de ([212.227.17.11]:42887 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfKKNcg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 08:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573479151;
        bh=lEZega4NQqb14eF8jrF2nOLSTFFT/Y2epxDcrqkCzpA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LksIZEZSVH8FEsI8t3Zh5h71vh5i9aWt992mzWjxI+plDm6Ggg7Wppuc3guewwC6d
         zDwd4O6ihA0iJ+VHAjWk3Zik68OVX2fdLFAHH9OTSGb7VCiS6+8YK5qmYNR4x0rgzv
         nVzi8Uh+dJSG4PgjX6rnJZEjd/0+pmF8Tqrf4fPc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZedc-1i2m3v2ejs-00lXOR; Mon, 11
 Nov 2019 14:32:31 +0100
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: simplify error handling
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a7a4656d-98b4-6bbb-e389-fe7028a38f97@web.de>
Date:   Mon, 11 Nov 2019 14:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JR0EW8xNBi+POd/MG9WbpEkvmVl78oVefTqYMfKp1EYsbLdSXc+
 Qx5gCx1cnoLy37iHpiH94s6rMlpykDOlnrc3e9Qiew2kTE+llqxwtYMQMt9bSohRN6JBLpm
 ZwDJgzHuBp9LritUXT4K4SaMxi7X8G3rWxJRB1iI8hsJLZE6NfcbVfKiDcCvMW3iBC5edvZ
 SOjQrw9VBEtFdz9LBuAjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a3J5GtyOYs4=:K1Qdhb8qmWE8EdilycbZMK
 0iWPChxI5aCpqH/qy22/q1V8HA2c6Gt1Iz15Vc7WNKYEfwB2SIdjlm4RjKg/fZr4FhXE6xkfa
 CpzKW//z4F+eF3yyT2V9YVl8Ml1Se/7hDOMNxuYVzhi7z5zSoAhgwBDZLjt7dKZS5iaAsxXRL
 VblVBtAoO6YpX8TmL5Rxp4Cc5kjMfseBaB5Q0u/HqMMd8ysKaSYE8SAb30ED8E0FJfgaFqdRg
 03IhzYDol5UNOMhsyelET2Ljwf7hFjdnczk78IFJQyBz6eBQAz8ZLAOdtb72ixobCLTAzHHqS
 p+tXoJarMHAsq/i5ADlQdEd4MPlGNvIzFlee2o2HDePnNyVbEElrAeaOzp1tRTRVatKXlyVca
 VlKrydGAxoxeQlGGXOowRWAS/RjybgEpUv5cu+7jkneGXSnud+ZVyFuSmlgpRNHhGy7mJe6yk
 U9OjTuM1HFOg0SM5fuEsjemD3Qf11fi5Sm5j5Kl5uZeyTRCQPyV2Te7cHf03fo3fbm/8ZrVEV
 xBwSeXcMl3gyaHek08BBtjOqQKuH1Pn6nSlzMHWkcSfeIj8eII7H3kax6wJnmVJ941qjchCbL
 +OU63SYMsbrQCDxU+12Ty7M1m5U+ZNNp5WfjG9pIRqmPVVEdTDjOrO81JkYUWI3oUIsSn0xxe
 mk6nG/FESkM6p8z9V5HrNsS6LAamW2qTFE16YDmfkWX91mGEA6v+KNINTH2hXJWJZbqLTYMvu
 KFJ1NDxV+vIlk1ygOAsKYdwq4dOPplO0nIrrwYUZLR7whrWv8EMC4CPIGw686NPkSnmypY4Lv
 PX3u6fpAqW0YaAF6ouT8SAZEIf33TxURMY8f/0qrIX5UtKg0Y/OtdlcAK3JBjSJnT/1DMcC70
 ePEPisDbsAsEmzgpjGGDAmkDC7T0etJGms8t98W70rzbAcs4yEO22rOqa7mJtAiuxQKNP3ki7
 MNIL775ks5fPBhy8UliZ8eP4b/jCp0KW0zK9CP/V/H93ItRVtDqyjItBqPQa5ZDfiG+W0PvET
 70GE6mkP8Ux8eUW/qrQLZVZlUeE/PcgreI4WK5tGuNO5DxSgoj1UMSvsLbTI1ZCAFZXaO9ydh
 6s7kyXxHSOE8egF45HqDJiOUydI1wqW0UC5XqwKxTecH8A36hHLoXu+Awmc+PuaUmpa66kD5j
 VpZ+Yf9VwkCg1RHNfeovnPPEZhmtZ51VNFCrAOgeqKucYenaohcL4xV/vcENjEdvBJJf7sVCY
 htNNBMGxwBM5fBGW1BmDvIjXDqF7sBY9MaVvZsYqRQiQg/9VlQn8YWDm08Bk=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Implementation note: The put: label was never reached without a goto and
> ret being unequal to 0, so the removed return statement is fine.

This can look fine (in principle) because the label was repositioned here.
Do you really want to call the function =E2=80=9Cof_node_put=E2=80=9D at t=
wo places now?


> +++ b/drivers/pwm/pwm-omap-dmtimer.c
=E2=80=A6
>  	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
>  	if (!omap) {
> -		pdata->free(dm_timer);
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto err_alloc_omap;
>  	}
=E2=80=A6

I suggest to reconsider your label name selection according to
the Linux coding style.


> @@ -339,13 +334,28 @@ static int pwm_omap_dmtimer_probe(struct platform_=
device *pdev)
=E2=80=A6
> +err_pwmchip_add:
> +
> +	/*
> +	 * *omap is allocated using devm_kzalloc,
> +	 * so no free necessary here
> +	 */
> +err_alloc_omap:
> +
> +	pdata->free(dm_timer);

Would the use of the label =E2=80=9Cfree_dm_timer=E2=80=9D be more appropr=
iate?


> +put:
> +	of_node_put(timer);
=E2=80=A6

Can the label =E2=80=9Cput_node=E2=80=9D be nicer?

Regards,
Markus
