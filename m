Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF299BCD5
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfHXJoV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 05:44:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:51411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfHXJoV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 24 Aug 2019 05:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566639851;
        bh=o25+H6F80CL7d71UPSF8mu/OUpqJZUbmDQzA3VpDamo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ktSl/ZDfKw+6djwR6auE4UBReMMkjXtRktYBhI7y9X1ISreouMCWEnH9bKryXNT5c
         L/YQl/SWv7wcQsCw1SAjZFIDdwSe9DKRcm9PIQ1TqCmbyErxQ8goS8ou1eBegA1XNz
         MYWEXtBGjc+tENPGAbjLaTlYb6ZV8j/rOWDKFpPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1iSIsi1SXz-00j3kB; Sat, 24
 Aug 2019 11:44:11 +0200
Subject: Re: [PATCH 3/3] pwm: bcm2835: suppress error message during deferred
 probe
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
 <20190824093032.cunkmukx73vl4hy3@pengutronix.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <141b0cb0-fa5c-ba3b-12cd-8e8252b1eb4e@gmx.net>
Date:   Sat, 24 Aug 2019 11:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824093032.cunkmukx73vl4hy3@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:CvREUcbmlepWWdGvEeJuPg4orUnjs7BbFSLlS4nG/SaJk3+BAJa
 EE1t5qSXzeD4Ytt0jkWh4z3ZRk/jc8oDVNCaB6YbOv6e7FdHY0Onj2LtGNfI2Nx0uUK6DKX
 U1wMmDfScvLOo5OOjUwvFh3eaQnZM7S/9tx5CAMmhtEld2T/qrzhUGnp+v7Pi7/Fp0XFAwX
 P2VaKPc2A+IQuksNc019w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+/nI3fmllLA=:d0Nw+1A8072vxyjSDsW2o9
 Txk2xVL2nrTnHpokn4arZeN56cyiaNZSzqhBM+Mh67qRwK4SVlAcBhKieZ5PU5o4UmbeufMqL
 ZPGOjhiWVkPd4NsbSHsSm/YhJgZEXKs3Wy52B8oHGrZg9SiO/5Nrq4A/I9pGG61kX9hr5dC8u
 i1vleGeyGYJbaBeyHyxyPCH9p0VOTlVmEphvu+vdL++Gv1/4BhzqkRXfC61GawLubQQs3MjVT
 wPgzHjeCoBEZ9i6PCFYTSr/UhZBIZRTDZYe82btfCw1bU3gnrA0myVmOjLjhbpk3DzcMJD5yn
 uLBnC6e7q3gSdpJkldff8CBDuixUkbYQIXTXoPjCLNWjzsftFNdT7yw7SUp6XI1tyxnq30i7b
 03SijeiJasYdDoswxYz2CxwDJFW7zJNobHFtcL2Lk2zrorCVko7tpTg/WDppqxKhyWH/rvnxY
 bZxYu8/lph5SdZ21+zEPTSvdibaU4ziGuy8xpCEXgr7/g15zWHPD3Vl43BgVa9Hz5khRPLSZ9
 1MUXQvYAcqX34wrM0hkXiNPgcigLsuVvBVVIQ7B195kNLFQwn7IRLEihgNbQwHvuNVxwc1Djz
 M1JNFXUrrrxrpUh8B7LLoa8R7/HsM4RzAeZEFgz5wIqAA+2Yw/iemHQ4GFlifnxNNNpuD/6dk
 W75rOUdkGnmyjyRt3ybMwpnjXxlkORB/9fz0YMSD2X3nhCEkK2yYRUVoyEhVASUxSKrr0nJd1
 LgXs/UQlkfkecKTdDflT7/G/afmb88ewEwSir8X3TGO/k1G6hi8rsGJK/mDEz8Wk+sdoPgULK
 Cff6ccNcNGKah1mZY1Kfg99pe6nGVB5x+LgJ3036XFXswak5pLIQAGmbEoRbLhjHRVBV5Zu+O
 USiEorinA3fHqSDQe7Btlko2pxqElitpynohHFy+7zGHsMd0jDGA/0+iBwuxq2MjClG3WJMHL
 qRVk174uaKMydCmPLD6/ec70NkKIASVET0/kNGrWWGv21uhXv6jvwwAGwJZMdc8N8qYQm3LeM
 7/MpRNKvXfCiaAVzlddDPFsjsrRZdSCSIJ7nrJcjXqh0o6nw4/Vi/BEuPtoWd8JOQ3v4Qr8a8
 sPu3WWC4E6YUrdAMcZl1nBcvWQmwCSAc3usszuuwDxiyytojTSzwZbweWZDScpfbMI83P2TNB
 glpkc=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 24.08.19 um 11:30 schrieb Uwe Kleine-K=C3=B6nig:
> On Sat, Aug 24, 2019 at 09:07:25AM +0200, Stefan Wahren wrote:
>> This suppresses error messages in case the PWM clock isn't ready yet.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>  drivers/pwm/pwm-bcm2835.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
>> index 2c82386..ce362be 100644
>> --- a/drivers/pwm/pwm-bcm2835.c
>> +++ b/drivers/pwm/pwm-bcm2835.c
>> @@ -153,7 +153,10 @@ static int bcm2835_pwm_probe(struct platform_devic=
e *pdev)
>>
>>  	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
>>  	if (IS_ERR(pc->clk)) {
>> -		dev_err(&pdev->dev, "clock not found: %ld\n", PTR_ERR(pc->clk));
>> +		if (PTR_ERR(pc->clk) !=3D -EPROBE_DEFER) {
>> +			dev_err(&pdev->dev, "clock not found: %ld\n",
>> +				PTR_ERR(pc->clk));
>> +		}
>>  		return PTR_ERR(pc->clk);
>>  	}
> I would have used:
>
> 	if (IS_ERR(pc->clk)) {
> 		int err =3D PTR_ERR(pc->clk);
> 		if (err !=3D -EPROBE_DEFER)
> 			dev_err(&pdev->dev, "clock not found: %d\n", err);
>
> 		return err;
> 	}
>
> This calculates the error code only once and make the dev_err line short
> enough to not make it necessary to add a line break.
Sure that's better. Will send V2 soon
>
> Best regards
> Uwe
>
