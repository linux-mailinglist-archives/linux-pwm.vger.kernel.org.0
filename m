Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43BEF81D0
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 22:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKVAk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 16:00:40 -0500
Received: from mout.web.de ([212.227.15.4]:33353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfKKVAj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 16:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573506033;
        bh=7C24VEyZ1XfuurGObrZvEdP7XVq4azQ9FcPQNanCR8U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HsU/5GGev2IcdEsE4XvkhIc9k4lV8xUVVD5ta2F1JSszieEcdsHrILKHidKQc/rA4
         wBASy7FVr5a2qFiUFzYRxivxrcpiPH9n/Bq1GeFrlsUz9EMLu6MX/9xXKSltwAq+gb
         YTNZQhmg+hGsRU2XYH0F6zKrbWEzyv2rF5S+6RYQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Letgd-1i7Lu33vf5-00qfQ7; Mon, 11
 Nov 2019 22:00:33 +0100
Subject: Re: [1/4] pwm: omap-dmtimer: remove pwmchip in .remove before making
 it unfunctional
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <dd3fe743-ee4a-153a-c044-40587568a494@web.de>
 <20191111200005.c37mecp44idxskjq@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2515600d-2f92-3e11-3bcc-c34ec63e29e2@web.de>
Date:   Mon, 11 Nov 2019 22:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111200005.c37mecp44idxskjq@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zfJPwPL+TCQ8ULDYjhhHSQvIT1OMYj6/bVczFz9e25AXR2pcCvS
 VjkvnWAYz1zMzX1YItvUANbLpmmSWF66N6luTm5F7m8148JVIuzizHLAV3AZKHaR/4o2ZZU
 EphA3NrcANbUVWvYsBXe892Y+S2r299TATxjLJQLvqYjNnTW4Mdr4M3gvmyKJDbLpWVKLfd
 9dEDkLh6gWW7XTjG6BEMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ifpfNJ376GA=:A3nqzdAENkGo4eHSb0gyF2
 noLBrUfC9r4dFxm8aGSDDEoKezNFD77JBG3zOczh7qmMrebKsHDmlryN+tlYV5iu/8HgRSTVk
 wxM1ubA2zi76WQ9ABYdL2+8NOwiuZmWsEbrH8QUvyWlWO4XKuaiOAVydZRLUKi+t83LroEyBk
 iMyfhxcQmqsfRSDav5QF+YfoMQMUzQI0lx2iE3I0tpH6zojDYmF+q00oSUDMEfPzucpEVgeDY
 mG1TH6mX6r7eFagpCIxQk6b974WBK/Pw5mq2iVbe9hx2bmzVchqDEwTwK4I8xipKH+2NQmlDa
 S2fzUjqrU2vNY7cWO2ZD0GvKNUNTgrQq8rTuqETQiA7DmfPVgZOMN3Hbanx5+npSizbufyTLT
 WHFhdJaoRKfwB4pljr7ctc3zDHg6cpuHu1sEly90SWtfRMb64DmS2+HWQ0pEr+DGNefIi5ky0
 lXHsQGiB8TI3N5v02+RdNuHjLqqklu+fhv7m6Oyf0dTD/kf7psLemguCpGzwkH/vJMDK9NKWm
 XmIfIjcqc5iqWBmOYNe8l/8Y7uIUGktWzWGJzPLPFzgUEFOYRhJAEMCaRs47WZUvwgG1yAvBk
 LyVrm2DpmhSozho1suJiDqnA4k9PSv1R19kYFiawGsI9lq1Y4wE3gvyBpfGMV9doci37K6P+x
 ujB7lPzFcD+/vdc2eSKsk1NUREwTzDGIbEHvbffLY9FBPs2qhqFXbphK4p/qOqQT/Z4zwREDw
 63hZclZXa0LVN9tHnHM7onhFXaSKoAxMiDrUwPHOKpYCohEmWD33QNtfjvGyhJN4E8CfMCaax
 JMkDSwq3inmTx/nbI2Q4pO+5S0LeNiRNigmtRwyGMTkH11knwJZ6fU/6qiKXK+J9lq/FK2ZlE
 ixbG3DyGSHKvEdPIpeZ3wZ4TMHKJ8tz+V82BSxH93+vN2OfMQh5o0xjZBe1m67S7JDxhxP3wI
 gQ693tqEXMZlBDQT/iXd9qLhWX8eoiCPMOFm4Nt/ZXgu5b9ZFBQvBSO+1qTcyar7BGjJlLMRd
 buthywZz3pv8OEBw7+gt+qD2AR5ZOvUBOhGECS1/vnE6MTI5lZ3SKoMbP1Svkbw2Xia1AwJKF
 zvVe+rFJ13+wOL1xYjizrNGgNWU2UWNrpk2B5/qh2Qs/EMxnhwOLnnAx1/khqTPzQlY+wF9ks
 4abmAB0M3sTSIM/8Mwvq0e56cDW0hGIdKya0dUR5D9XMWvkN+Q5gtqvHxNgHcmIRKNHc8oL0g
 KQWX7Bi93SXB6xKzHwMUyRg+JvttTe8UwjsnubhTzPij4xpKpRXPMogyw+xY=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

>>> In the old code (e.g.) mutex_destroy() was called before
>>> pwmchip_remove(). Between these two calls it is possible that a pwm
>>> callback is used which tries to grab the mutex.
>>
>> How do you think about to add a more =E2=80=9Cimperative mood=E2=80=9D =
for your
>> change description?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3D31f4f5b495a62c9a8b15b1c=
3581acd5efeb9af8c#n151
>
> I described the old behaviour and like my wording.

I find that the first paragraph contains useful information.
Would you like to specify any corresponding actions then
at this place?

Regards,
Markus
