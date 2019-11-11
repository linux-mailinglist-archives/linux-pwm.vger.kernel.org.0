Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB6F823E
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 22:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKKVau (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 16:30:50 -0500
Received: from mout.web.de ([212.227.15.4]:35193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfKKVat (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 16:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573507844;
        bh=fxVlF1Zgg15ZCrFLhofu+Bts3rxSUammJp/efUAaH9I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CGijAHat0Gz2UxRVgC9zkfNqnN1rxRhksN7bzFsks6ITVMvgEmSxVdOigxDZZdUnz
         Y1jNQxJL3tQXfIA5bn0ys6iTuWhqQM9DZ1reMnilh4hm6Zi8Ltzt0bOr6MQp6MVHer
         Cs5l4sRk7zD6EISrQWpJS2cnYxrnvTff/xD91tuo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN87U-1iWT8N3YVc-006hmr; Mon, 11
 Nov 2019 22:30:43 +0100
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: simplify error handling
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
 <a7a4656d-98b4-6bbb-e389-fe7028a38f97@web.de>
 <20191111200800.7njfdz7w3offt6we@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8328c71e-0a9a-31f4-afb5-b4b1bf28b004@web.de>
Date:   Mon, 11 Nov 2019 22:30:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111200800.7njfdz7w3offt6we@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iNXGVR4sAfwA4nVSeSOdAnYXCwXNfH56QeO2rBJcwvdE9XTdrvS
 p7VqmMxHXhuaby7Qy2W7pkCm7j9dnZPY4pWB4DYixNMjc9kbCSv5O8MdDPdikfAKhkKGKhx
 WUqbIqHRdGJ5s2HS9WbQcTKbiboJ5ZhFMGUcGkDMYgeI7qcOPfOIIlER2h18GpseTiGZNIo
 +1xi5qTJEbo3T05HJZ9jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ORNKvg2W+C0=:ULIALGlmb/7YDVc9+OZx5x
 nGwshEqQkV2Gp/Ao0dZd6B7elzJ1g30cgaTwbWpxHmlvwbbAMwzIVxsXNeiijWLyNabADvV+J
 lEX4x4RHUAnzwl5yevjwC4oTecdnPR5zTmVfrmuFVP82VTha/eSZHyCUnuwtVgM9NS2c4thlS
 AWpkYDePz8myqkRrxn7T/22UiqAMU18Vb39sAoTQ1Oze+LQs9Q6fv4Au4gsLHBXwpGgZPBjGB
 Bfg2d1tk4iq5yvFuB8ZIKVsGwlvSSEPmtYs5GecSV/iUQBHC6y0moYrFF0nn+3HadG1f42QaM
 IJmQX/oTSowoqxUHi4wpye5OiKzw6tVK2211MNyLhTJwLblpiX35BdBUnKhXvoyfRzz27zCow
 Fy7ONNs5sEbneoAMpp0tu26/Vk3ne1MCEXFFC4XjGf9R1jWrRZS5//WOByYa8ch+3D6F1OlFq
 PmYcLjpiZKdhCGnbBVP1MH6IZoEVEU5FtvIiKV4axLpPnnegMTddvF82Cqmt4C+XxG/4eE63R
 FaseZp5lhN0BWVBkNomn23oE6dePnA8OW4oMCzTr3mhRtmlXpUdtl/XzqQApFhCIZ2u+96rnF
 +drd3iMhGe1JCoOk+5bVOVHckAYbfq1yz0OyHImHfZs17MQ7fNk48VrQtaagnlz9YkhZCKV8b
 XSSml+780SnkGUAYMLaJtgSOymX3yPYmyOCNuwXQye2jo/mxSoN7w+vYDyNGbdW37pDTCc+36
 xG081oUY98CKMdfs9f06NAnHHAb0c7/6QnrNQY/ev1cXMgpNizn9LQuG52N8A/TK41JDmYia+
 4v2kwbOOHbVw9STAf2RU943v0VNC3hdWizBshqinKChBWcmBGlRQhScChw+GkfgFIk9H/Umdm
 T0n7iGSWIkbNRhGrHolJNButUxpkK6WrxINVeSx6Pio0Utl406WPPnwFXni9gb+nhHalvDuoB
 ldd6QDpj+mRhrmzZbxmnYpdI7QeRn47iLUTHGEBFBShGv8Q0Arpi2h2zUXrtCyxa/TH1eRI9Q
 iGvk62E5unH3WQFikNsv0xdPxzaM0VrzjORoZCVizGduu09Jtyn25CQJ/xZ8tNW8OieFuJTgH
 ECClUJiB0BcIusbRvdKkEZIlL2WoF/6X2sXgVS74a0j8M3u6R4UfeuXtexWIKkzpaxOQtpgkL
 SpGK7atustKarCz/x+OEesIgwGnl+XHL2FVQ6WsA7alexKijUpesa3QzZEwVnT8/E4xCcjmtV
 Mph/30eukqyrzvKRwUJFRRifif7tLWNzO19VJeQwc75VBzz/SIREbElMfxvE=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

>> Do you really want to call the function =E2=80=9Cof_node_put=E2=80=9D a=
t two places now?
>
> Yes, this is in my eyes more sensible.

Thanks for this explanation.


> Either you have the expected path and the error path interwinded,
> and the error path interwinded,

This is also reasonable then.
This design approach provides the possibility to release a few resources
earlier before using additional functionality.


> or you have to duplicate some cleanup.

* This can be required.

* I imagine that specific software infrastructures can help to avoid
  such duplication, can't they?


> IMHO the latter variant is the one that is easier to understand and the
> one where it's less likely to oversee a needed cleanup.

I am curious on how the clarification will be continued.


>>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> =E2=80=A6
>>>  	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
>>>  	if (!omap) {
>>> -		pdata->free(dm_timer);
>>> -		return -ENOMEM;
>>> +		ret =3D -ENOMEM;
>>> +		goto err_alloc_omap;
>>>  	}
>> =E2=80=A6
>>
>> I suggest to reconsider your label name selection according to
>> the Linux coding style.
>
> Documentation/process/coding-style.rst states: "Choose label names which
> say what the goto does or why the goto exists." So I'd say my names are
> perfectly fine.

The guidance from the example after this quotation might be still too ters=
e
so far, isn't it?


>>> @@ -339,13 +334,28 @@ static int pwm_omap_dmtimer_probe(struct platfor=
m_device *pdev)
>> =E2=80=A6
>>> +err_pwmchip_add:
>>> +
>>> +	/*
>>> +	 * *omap is allocated using devm_kzalloc,
>>> +	 * so no free necessary here
>>> +	 */
>>> +err_alloc_omap:
>>> +
>>> +	pdata->free(dm_timer);
>>
>> Would the use of the label =E2=80=9Cfree_dm_timer=E2=80=9D be more appr=
opriate?
>
> Either you name your labels after what the code at the label does
> (then "free_dm_timer" is good)

I got used to this approach.


> you name it after why you are here (and then err_alloc_omap is fine).

This choice can trigger special software design consequences.


> I prefer the latter style and then the label
> name always has to correspond to the action just above it (if any).
> That's why I grouped the "err_alloc_omap" label to a comment saying that
> *omap doesn't need to be freed.

I am also curious if any other contributors would like to share more
views around this choice.


>>> +put:
>>> +	of_node_put(timer);
>> =E2=80=A6
>>
>> Can the label =E2=80=9Cput_node=E2=80=9D be nicer?
>
> I agree that the label name is bad.

I find your agreement on this aspect interesting then.


> I kept the name here and after the 3rd patch the label names are consist=
ent.

Can such an evolution be questionable?

Regards,
Markus
