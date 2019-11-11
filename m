Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A83F753A
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 14:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKNmF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 08:42:05 -0500
Received: from mout.web.de ([212.227.17.11]:59071 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKNmF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 08:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573479719;
        bh=6OzZTDobX1qW6aU8a5k9FJMLNxyGjCA8Fr6CeXxsDeY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PWN5+C6jzcPbsGpCU0dQPbbC7guynd72Nq0Gk6lmUBCqDDtUFyLcQ5kn13/dKC/6h
         jngUrvy3BNM3IECsHFYB17Bhga3eVTMbgRoMQgYIgW21DjRLCXM6DzjFuavXztWGdH
         yAfnEzg5HQuQFKYEcpRbksnd8mEvgBDgn0ySHrsc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBkLb-1ieIQC2SeN-00An2H; Mon, 11
 Nov 2019 14:41:59 +0100
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: put_device() after
 of_find_device_by_node()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
Date:   Mon, 11 Nov 2019 14:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CiPgPEsnOUeBUu3pmyaf/u5yCWvpIa9d81ExnECWJ5Kru7RP0/R
 shHlTY1cwJV8e7xDOdICZ4hyKButiWmzoxDC8OjLcmJHrbwvbVRFUzV2n6yowgFImyiZHJz
 G3KZt1p7IO9WLo8zYMyUBTm/K8bFzebC69QDcleg8Sh2Q8gmxQjAhbEG7hq2VCuPrtlq/e6
 pbhrQOi6QQ50XXFKn7VWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sjhQAGAM33o=:XlZyHv0FCJk8qWrfEZ3nFI
 CyCdr45xlkdqJRwpBDyUXH8tXoUBUf218lQR5FzU8p/3AMqiJIEG3CKN5vWn+sqFcrxeHj9Pu
 K60Gl0i479Fw32Bg7p/CtEYKxSHGSVJ5841wd+FdsI8g+WneZ6fsSi4veUK+JxfgOVEvaa9uv
 k7nsslMDMaOhsfuIP/dc2nY5WpZuDZKp5cJkmgfSxn0zgVHjIwzeH28ESy9nnCMjTX5G+KOet
 u69TZB9LoWlax1xHiD62uVUVGUWm3E9QxSKpHvuyyXJNWIIIz4Bf/dM0ybAsb98S20apAF6dm
 X3SVz518K2mBgbbgCohK/VPUdYFrRzEar33VL2d/JGymG4TazQwf4uq1hGpUiH5ieHv8KvY98
 x3gTc2qwwrLR/Z1fI4QXwZ7cXCPbPPrgLxfQMTrvXD1UtlbyGc9kTIYVI21vnFAil+5F3PHy9
 +WMDxMiZUw/xUx0ZBONDMgXk14KkMZ+e+bP58DCcdv4c3ilTeYF37rwPZCGqTgrCweLyyPsYu
 3t4WI3Zmbvb2f2bUwoUgQV8SSecIvsCNRPfAv/nMcVdJ06H5Tv720hdGKlZjFWmSL1Z3p8db5
 /qj5UGBZbxNJGpWjPelpmJaFuR9SkRFy6DbdCbT4EV24dSwvreW5xHF5gOwFAJkvUTPAc1ixK
 3ULpCeqZJO6nnW7xZMiKw8I96Q1Fzk+0yYXzJI0vXauJj86CKJtiiIiUMzPfj4m7TZDN5m3QP
 Lv1Rn11P8AUEFMsEFxan7V4RrZlrJkR9e2eLgCT/uJBBbirXbzLNX/Dr8o9baExTLDdeJFY/d
 3VMh6c84JqTdnBPsr099Hl6n92VzOg4F2KY2ARWnRZZjnu07f3QAeTz4WueZls6UOP3pYl8mA
 joCV1UhYOe7LdIqn6FlsVkyEBRxuYdfS+aC11cHcbmagtkq4iuP7g8mSXyyKY1SbL5FYMGjup
 qjXbdrRRRABJj4Kej4ELvyn7Hg1I4sefYrL1hHvqtZRekNdYmE0laUmXU0+RlcbBvpGk6yr+i
 wHUCBGJXopobxZFbGCCFt/pyq+Azl43xL73eDEhbKrMGHFCd9k/opquAfF3dg9w7mIhaXycj8
 RthbMgmPYxfWLg/pQN5inh/WNfTZQEnt5Jqlv6te1FoM18Ybms0hwA980eiXWv9PDnfIj2Ntg
 B+6zCM2KurezeBSHjl1X7ayV7IDatzqS7fIFzybAqHhTez9vvvHrdWzDGuDcm+B+uR6tJWStA
 EhptzCqg0Wjk3+MKa5x/OLal/HD2wO2bWMc7k4EPgnRX7E+18KJca6l36rBQ=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> This was found by coccicheck:
>
> 	drivers/pwm/pwm-omap-dmtimer.c:304:2-8: ERROR: missing put_device;
> 	call of_find_device_by_node on line 255, but without a corresponding
> 	object release within this function.

How do you think about to add a wording according to =E2=80=9Cimperative m=
ood=E2=80=9D
for your change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D31f4f5b495a62c9a8b15b1c358=
1acd5efeb9af8c#n151

=E2=80=A6
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
=E2=80=A6
> @@ -352,7 +352,14 @@ static int pwm_omap_dmtimer_probe(struct platform_d=
evice *pdev)
=E2=80=A6
>  	pdata->free(dm_timer);
> -put:
> +err_request_timer:
> +
> +err_timer_property:
> +err_platdata:
> +
> +	put_device(&timer_pdev->dev);

Would the use of the label =E2=80=9Cput_device=E2=80=9D be more appropriat=
e?


> +err_find_timer_pdev:
> +
>  	of_node_put(timer);
=E2=80=A6

Would the use of the label =E2=80=9Cput_node=E2=80=9D be better here?


> @@ -372,6 +379,8 @@ static int pwm_omap_dmtimer_remove(struct platform_d=
evice *pdev)
>
>  	omap->pdata->free(omap->dm_timer);
>
> +	put_device(&omap->dm_timer_pdev->dev);
> +
>  	mutex_destroy(&omap->mutex);
>
>  	return 0;

I suggest to omit a few blank lines.

Regards,
Markus
