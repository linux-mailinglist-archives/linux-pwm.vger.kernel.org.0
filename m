Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541F44B316
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfFSH31 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 03:29:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbfFSH30 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 03:29:26 -0400
Received: from [192.168.178.24] ([109.104.35.35]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MplTn-1iONBF3oT7-00qFFZ; Wed, 19 Jun 2019 09:29:12 +0200
Subject: Re: [PATCH v2] pwm: bcm2835: improve precision of pwm
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>
Cc:     linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Sean Young <sean@mess.org>,
        Scott Branden <sbranden@broadcom.com>,
        Andreas Christ <andreas@christ-faesch.ch>,
        Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
 <1c7dc4ba-eb6e-b6da-3bfd-4b872f9c6498@gmx.net>
 <20190619072251.vhncrs2cnmtudrsj@pengutronix.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <59eed6bc-b99a-40b3-2dac-93dcbc7e922b@i2se.com>
Date:   Wed, 19 Jun 2019 09:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619072251.vhncrs2cnmtudrsj@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:q+Ew8d7vNFYFS3bCuXaasPOdIBTKb0lmlRMp+RQ83w4/sidq44Z
 JvGpInr17U43YbO7CgkSWfS2pqgAVgMqXuXcuUfUBFpwh8zdMiNQ4YnlLnY+DXk9yUI3a7m
 e+8JyV05POdH/UtIKuUWizAn+AlfrlwRdPOLWsOipjyB9Y9eJrULqWUiou8Y/FhqqLRapmu
 gDytjSkpf7Y+uRKFfNzZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vj/yBWuJUIE=:AxUbfKLXrwTewZ05RMKwWY
 o4mBWEuyCUjD7LuJJ50ioUtRhaJOKRDX1dRXdxh+L5ZygAmPA0oj1k5usrIh+qcFKnwqLwTLo
 jjYUmjb5V8ad0pi1YbPT729RZWLLOHHQdeDYDCipgFTZLj7jGQMKV523qy0RuOZoRPlWOHQXY
 uuFUlPCLK7UYvnSXlOwxDxt7aiJaVL/vVKF67dd4nTeKV2sngePk+XA2dG9K8O31oreCIZm/R
 +qsI5Nru7hNm6z5aA+8uzJaN7HySQbJi2K+66ro4vIus4GrBU0r9q4gB7sUyw38jdnOxN62L2
 qmr1axSuhIHRmcRwvKIg5gDH3dmJUUu1ucD2CuNUlh5snwzNiLoGZ0bs7VE5MFDnPleO7VLvf
 A5UB5VFOJRfeh8KnidAoHTrWgk/o+edxS7E8kpdi+knM7BAJbEBAv9qVR4IjI8AjSs/KhBz+B
 uzliCINM/thrXCZvVSFwMHdjC2luZHk9q+REfW/A769DYuYrOMijcRAc7hUG/Ucub8CuDgCNy
 vmtg4mhPGvBI184U2ZotTrWjm6Nk8SC0tHszlNaHb2IOF4RRwDzWrwWEzbxYgXoN5VrQoDaqT
 qjLSImPT+qTP3BK/IO1IlFl51pYZ393wgUzUEWlRlP5Vn4KiSuBJkaji5pT3ygK2LMbI5Ffbn
 ZfS8BS3W23U1cM9zQJh8T0HpQKIUv7nK6zeMzhqRa2ezx11DQnQbRRoL8ORpNvgAnLje3OKHc
 auOicfixNllwzhD00OdmFrGQhUjwoTUgx83YjXDGpg2KSEEjHgfaTHKYKug=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 19.06.19 09:22, Uwe Kleine-König wrote:
> Hallo Stefan,
>
> On Wed, Jun 19, 2019 at 07:21:43AM +0200, Stefan Wahren wrote:
>> Am 03.06.19 um 11:00 schrieb Sean Young:
>>> If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
>>> carrier ends up being 476kHz. The clock is set to bcm2835-pwm with a
>>> rate of 10MHz.
>>>
>>> A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
>>> this to 2100ns rather than 2200ns. So, use DIV_ROUND_CLOSEST() to reduce
>>> rounding errors, and we have a much more accurate carrier of 454.5kHz.
>>>
>>> Reported-by: Andreas Christ <andreas@christ-faesch.ch>
>>> Signed-off-by: Sean Young <sean@mess.org>
>> Acked-by: Stefan Wahren <wahrenst@gmx.de>
> you already acked that with a slightly different mail address a week
> ago. Was this intended?

thanks. Please ignore this email this was a typo. The correct domain was
gmx.net.

Stefan

>
> Best regards
> Uwe
>
