Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411972CE2D7
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 00:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgLCXoA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Dec 2020 18:44:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:51647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgLCXoA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 3 Dec 2020 18:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607038938;
        bh=3eKdFiOtGI5MgELRJ4q+t2W60ujPhhXSS+ADUJXPjGc=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=fB1FNLbkPqG+JxDFIOfJ+IpPMHV7pscnFP03TexqZTEfbkeelDqgEQd5FLuL7gLk1
         1L9ECMQVlxTQY8PXWpPJHCFD2sTSPnqBR04jy9+28d0fnxwqOfQ32gFH+2vZ1tU1Wi
         vXEdlwu7hPZaWio4cPBkIK6+lL5aFgdVUf+OMLsw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1kuYUp1elh-00AIrm; Fri, 04
 Dec 2020 00:42:18 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sean@mess.org
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
Message-ID: <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
Date:   Fri, 4 Dec 2020 00:42:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Fv+JTQhspaxvXqsdnw5DBNaheLSrMeZ7raueg3GdB2CmhvmhNj
 vgnh3pqfag5YvkVG7bDmYgA5TxLO4Q650CYc0ewO+XA0ch9ogZttYYx/w/TOFNjJnWLo0dI
 q7i2BVikNHKYdTlNebPnWRX5vios77/DDDDHluBIUFToyyVW+M+yiimuk6Yuwzo4bXua7qx
 +v3+5Fuer2MLp0FsBSu3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lc7Th98aSDE=:2W7Pj2zcmIuH0f5LCmciEe
 FZDGc8OHPZvYrd5e8kRTMu5Eda29ubR6d/7++vzkTVPrR6+btvPHRo1eiOa+cshHjbJkGUzAv
 +4Oa895w/zp9x/i18sCNwzI106jGemSlONOUkrrEe85/l9ACZ3Ld/3ZtQFwQEPrkbu0WRzTKZ
 Ie5Ol/dXj/WLXKL0fCw9TJm87KdtRrKxLM1UFY1PFEUj0Vsx1PXzin2/ETckiUQj+B8cCywsS
 PB2m8Hl3wlxIW7ElQzgRo95jwGVcn+x8Wq+JLQZoFUISwHOaB+YT2urgiwJmb2Ve6SB0jgwZp
 DXuzjYB8AdNf/AeP6pLRscU8u1iNVFNhXdLXYoGzTvC4UTZWX1fTt4s9KIiQM/hhwmnAfLdaj
 a4fZ6ZY2Q3xdYJKTNuIUqnx+1yfW2FLvqH6pnZ/pv14l04Zc1IGsK8ENR9AnARn5F6QaNI3si
 e6RAs1zbYDyGqpfTT7BOjbvbnAbbXUR8+7xTy2qke+LgZ/m3a736h5ZOPizeRsfou+Uu+Bjv2
 7YuKIAY9dAXfsXxQihTp5wPgyQcBblgIIiejKZUaQ7MNR6dM4Hh3sT8WVTIdbKVLCyQQT3OWZ
 usi9HIp/kJU4YlmbvB4IBD00mKGntpn4cx8ok4BD9lB4iiuibxHWg9gLnayZVuPa4GVltFlTU
 rp3N4lTYOJh+uOzUEmkOy1XI9ftffuuVs+ajIDva8uj+o6a/nbpM4AUJAWq+E2dOTm3ym9PrM
 OTOoJK7RfchZAm7v7PDbpT7B0NutP1iySR9VSnVJNsnwR6jV+Bt6iK36HFgakwIx2sIyMozjU
 nNkg2deDn2xxMFzYIrNOrqtz0Ff8Jaw3SHK6kee6Z08EkB31QmD64OFG2yoPn9nM/KoHvzMhw
 zEE0ZHheNTYxfc7+nEDg==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Uwe,

First off, thanks for the review!

On 29.11.20 at 19:10, Uwe Kleine-K=F6nig wrote:

>
> Changelog between review rounds go to below the tripple-dash below.
>

Right, will do so in the next patch version.

>
> You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> you are sure that this won't discard relevant bits, please explain
> this in a comment for the cursory reader.

What about an extra check then to make sure that the period has not been t=
runcated,
e.g:

	value =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);

	/* dont accept a period that is too small or has been truncated */
	if ((value < PERIOD_MIN) ||
	    (value !=3D DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
		return -EINVAL;


> Also note that round_closed is probably wrong, as .apply() is
> supposed to round down the period to the next achievable period. (But
> fixing this has to do done in a separate patch.)

According to commit 11fc4edc4 rounding to the closest integer has been int=
roduced
to improve precision in case that the pwm controller is used by the pwm-ir=
-tx driver.
I dont know how strong the requirement is to round down the period in appl=
y(), but I
can imagine that this may be a good reason to deviate from this rule.
(CCing Sean Young who introduced DIV_ROUND_CLOSEST)

Regards,
Lino
