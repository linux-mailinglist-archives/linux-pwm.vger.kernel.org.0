Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C80F825C
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 22:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKKVio (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 16:38:44 -0500
Received: from mout.web.de ([212.227.15.4]:57027 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKKVio (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 16:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573508319;
        bh=wy+c4oquk6E0ChKo/LOL0mYKRewC/xnPYTJIenkxXYg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DFPombttEBs9/S/7/XEvA3GBGB/xo8ay7ubOQ81IoSS6RHOMbVZyTGvKawgyHEdNd
         ggW3tIUCJWrJfln930e2jEoBMa+dYROgdEvN+ZU1w9LTo54qIx3QRgicJdN7ko+Bp7
         4CpZhDd+VyPtcQrWVMzNq5mW59bEcFtsRHJvADSg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZRnx-1iBF4M1iqD-00LENl; Mon, 11
 Nov 2019 22:38:39 +0100
Subject: Re: [3/4] pwm: omap-dmtimer: put_device() after
 of_find_device_by_node()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
 <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
 <20191111200907.vclloogaiu3mqxsn@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d4c63704-8c4c-c1c8-ab97-ce9701cf2da4@web.de>
Date:   Mon, 11 Nov 2019 22:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111200907.vclloogaiu3mqxsn@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nP9Z7W5UiLyx/EffgYoTkPSszofWkQ0e+kZHHzlzYvb8OpEMMDY
 76kiaSGN5u5hkQSjyYco2D78gCsi2D8H3Ky9FBpgrWtcH7QxaaJVoeKIvYwObbgAd3ByUE6
 lIotJfPg6g+ImoWY55DwonxLOPVGV1W0sr+X7Re2RlVOj2hTv0OBhJZs+YoMSnaKd+11qPj
 355dXBdH66LlM/dJEFvwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6CPD/RWlefM=:TJCzaL8/4u9A3/QA5YZS1a
 HktkhBYUq0eVJBleZDktWEAcAXZ6ifkkykAKEC6n99iP9LW9/dZz/wZYEPZw3W/iSKUpqiwC3
 ACedoEeB5MV+Lvgiz1EOAYlCas+AY9GCY549C6peeEjG4VozafWEKs1wyfOT9qBN0iUifCgnV
 v0awSR3pfa8Pp33sQfClfZKvRgMI+ZWDZi7cy6DypvYqm1uIBw9A5EgCniRuDZi8yZOJ/3zdc
 z4CpwA0pbGGDWDrtYIyti9JSx5ip4WEDBB/+AoVEFq5M9V2Xd2V5XiISdioLnRC4w0rYzh16n
 PK6Wtsb1v8yGnRAMx0F9IKSkjmNyqgXqBvKXigsM6HKG881144hEx2Wt8L3T/MWm9pSeWCaAA
 o6nHL839Q2D5FUEvno0ukv5mMBb22G3hQ99xuQEV9F/Ohj+AQq2V9ZserrE1JV1xnLBylfJga
 PMPnPK9VB3mlUz/Yv5oYl041KM0V4UNQAd6xEOcHWuPJoxWXFBbC1bQ1iunyU5uG3hF8RpRzP
 i5zUIAeWdZ5r4zFHey/T+XlevN7RBoCoJMVILhiO4xFindXnMsyTq4ElGjBQkZMINbrZN6uDz
 ffQeB8r0qzU25eQgUMIvCq7l4cG2YdFdK/7Db6sKC3qFrckaszjfsng0EgsMLNIffVi/7kE9J
 F1aEeV+cYKWjYjMtxZHlJZEsxKMQeCY1BOEvTCHAcYwh0Y4uadqEhURPQ/BuHPr/djEmYsREk
 dDwJ+A5QehT5BGRGnV7UFIf9geHKQ/JDXBQb1evFO0HPb/SK0qmOJh02In6iK9EfpDQMQ3usG
 aoWYrYkbbTjIerC+qU2dER+VLCnavq+rR2jhR1VwCsHY8hsZvAiSItGyHNe5uJELUUHKRpKBu
 kBBTqGufjkJPLjQStMOmLzVFRmXHJ4whOiRkayvVZji7Vf0jp1YSSDdK3WtyvPw7Wc/7+SDbk
 YMlcRNUPIfX9cSiCU2lzUQJzuRZmwunA/X8VtWODFIkIxFlhTP6UTpk/wZ+I9udEHtKMGkdW0
 ljM48jvBvLU8ozRU2tT2DTSZWLwgpM5ORPTVlhHL8lm0CZnGaC9q+sXPzpWYmyTOhpfwCYPCT
 wyOYc4Np3ygq5ooSVEmn4+Zif453TGnwNUNzP6NB3HkPfJVbHDh1rjMpJwOiaMUYw6tz9GnKI
 gQspsgNFx1GsGY5gha1Lrk2ZxDvHceyQ5LZmL7pTUSQOOkY3PfOnUItmIf8AL55r6B+qDPsUa
 LjXOkiFxkv/E02HGe+YKmMQZKBo9ctghxYdjt1OV3Q0tRS8jrN1CX6/oBQlA=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3D31f4f5b495a62c9a8b15b1c=
3581acd5efeb9af8c#n151
>
> Are you a bot?

I hope not.

But I got used to the need to point specific suggestions out several times=
.
Would you like to mention any actions in the commit message explicitly?

Regards,
Markus
