Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FD2CF76E
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 00:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgLDX1W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 18:27:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:35179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDX1W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Dec 2020 18:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607124342;
        bh=tRd3czlcgEfSQ1/izCZk9M5n6dlWTYetrUaNu4W98KI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DhYdgb7iOkbah+eFCBoIgY3p5yNgeDHjI2/DpRQFZEcgJayhJXzGCnx9ExRmnHeNo
         qPmd6AEAKOA3jq3kJvrKK/HTUl0GTYdXWaFXgjqHnjFMUpHIzzQy5upTn21fMzyrhQ
         VTwH6p5ebsOWV66QWIpD7bDc8SWftG5JLv2p53vI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1kiHUO3R0X-00WGyA; Sat, 05
 Dec 2020 00:25:41 +0100
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
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204112115.wopx5p5elgte7gad@pengutronix.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <5c7c96ff-5323-2dd9-b56d-57a10b6576f2@gmx.de>
Date:   Sat, 5 Dec 2020 00:25:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204112115.wopx5p5elgte7gad@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J7D3IljvcFKB8xabtlS2uf7mIZaz9+XeSc5RyjR+AeJhx/yu/Ig
 9fnMI5hViCJnwyAANq5AgLNFEqtODIfB3Xi6fzkWhcR7ughTwF5r7jVESFpQtuouMbQXJFE
 Ve7uP67v5nX1+0WPx0yxZAODO54fVftP3QhMJdpJwl78WkGboD0t/dmmgZPQcxTf/rFsDTt
 kFZjAvY3zFsIvufT1YWtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XieBGY4MbmE=:Uf5NVpwIdg1RzzYuW+q9dV
 XKJDJrdfBlm3e+IHt1pywcHCgY47S92lcnXRwFaTAkHoSLdDzN9eFoBvRA/Upp3w24afnck3x
 p7L/oyJ2VNFA7CiRq2Q8M02CWQND3Jl4hd2E7KaZfnlaN1KXe7ssjav+2uUUIJRJ48YoZK4dM
 kZ6QQNRwsGG16ZyMtVYFBeK6xEtE2SnFf/Kslq21ZR5s4lRnRk8FiCY2FWlrHX4hS1RI+ZYwN
 DjrHWEttscf4Rt64bnYGHKN7gohjGTX7Rfndp9O9NF0fsOob5Q/ilXYwmwOFtpI/tctxhMDVD
 +kkhY5e06FmUUtf7L1pA2Ss0IYhGkKbl2WsGfjs2KUHBraSYU1MJOWIhyPgqzMqJbm1DT8Gu0
 j6L5n6Wzpm2zmSXKhk0754bL3LLlsdBf1c1TWm4LVmlrIjHN6wZITLLHqHsoN0GKEECSLNnJm
 Ww3jb7uD+yIrfW3X7I0Jkh76gyrch/Ci+rYJp9fikbZh1f+Nu3lHzrqZRmjY3ahg9bG8ndnFH
 LKkJHk1jzXbkMMhy75oy9lQnIkzL2oR8C+Oje0sGkcIINXsu04YnwRoXPQooamYt1sSEoJkwU
 zUbtsJ6eqsUeMGR2Zl2BWsJsm8z0bc9SdYn+yS1azg3qGC9DUaSiiPmF4aiGC3X72f8Ft2ZXY
 61SK+sVDHnvf/JdFraJ1LSsiAv93I/HUFTSQNTrNVuv2gVPqTN1gCHEKURc+9FUUJDVqAejGS
 VJ5UmzBMBHXYTtpsrz1LTTfmO0yjrhGmGMqUULQe7RiLAqDh8NZxLtQ5AGFAT8zqB7T2WlMNP
 yAeXaSRkEg67U6usw7KO1Ng6mklxfYMe/RD+D3U98MANbe/KKEu0jypjDPO3oJ2viIRvU+3/S
 OwL1WLu6NXZpPrIZpF7g==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi,

On 04.12.20 at 12:21, Uwe Kleine-K=F6nig wrote:

>
> I'd make value an unsigned long long and check for > 0xffffffff instead
> of repeating the (expensive) division. (Hmm, maybe the compiler is smart
> enough to not actually repeat it, but still.)
I also prefer unsigned long long over u64 since thats what DIV_ROUND_CLOSE=
ST_ULL returns.
However since we have the constant U32_MAX for 0xffffffff we should use th=
at.

Thanks,
Lino

