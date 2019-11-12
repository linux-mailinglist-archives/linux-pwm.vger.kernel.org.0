Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83DEF89D1
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2019 08:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfKLHk2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Nov 2019 02:40:28 -0500
Received: from mout.web.de ([217.72.192.78]:50559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfKLHk1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 12 Nov 2019 02:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573544422;
        bh=Bx/I0yo1cYmt1qgy7b9s0S9BXeDFQ3nSHmzgRbJyA+8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=elsSpTlXI9QZgtgUpXANUkNyDi2InsaiIt7CAf67EipS+GiFBk7+5B+NUNxB1tPLT
         nytHejinKDudoKWI7JVjP4buhx3AcpyMExdXUKcMN3HebHHl3J+k74C8t/y4DNHlux
         9otOPUu7MfCAhAiClZ1VyvXOVWrDnzNSuBSq34VY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuuS5-1hmk1103O5-0108a6; Tue, 12
 Nov 2019 08:40:22 +0100
Subject: Re: [3/4] pwm: omap-dmtimer: put_device() after
 of_find_device_by_node()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Neil Brown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
 <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
 <20191111200907.vclloogaiu3mqxsn@pengutronix.de>
 <d4c63704-8c4c-c1c8-ab97-ce9701cf2da4@web.de>
 <20191111214619.whp2obgbrgb75a7k@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8f3c4829-8634-74f8-20c4-b63c01ba526e@web.de>
Date:   Tue, 12 Nov 2019 08:40:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111214619.whp2obgbrgb75a7k@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jrucYJTFomSJTLjFNd4jChPNn2ko2jJHvN+BoD2vZ4z/ROBMlO/
 F3pZIAjrEs4zEp+5KgS77X4FJb2i/rGp3wnOKiby98YOl7EeaLqDGPxi1VO8GDlRCIrmb1d
 s7sX25aCo45gwqUiX18k4aC/UjW6IFRFKFAc+QwPlijgqcnVhp1DDguS2M62aZgvDTlR2Tv
 CC/Mah/w9t+hlO/n/UVMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TFQsNmdxjHU=:rjEn1Dpq2uQ49HbBHVXUi1
 wMz1JXRbCvR3GYQ8DaaRjZS5u4lwi/X8wrI19HtFuxUj8c3ElNjLAvYEDuOcMymcyJIBtWJl4
 hG7Ht2op94uTKNuengbQ4/o+89+Psqm/1oWq79tpQfSQMJ5mJY8zofyPHGXf2GG858z11Q95m
 gyb/TVdgbnM3TEIT6fpBUZ/PgCslW585QgMEstgEPHS9rauMKIycQY/aoJbCqP5nOfLqBpjpS
 oFVnDooe4pTLGwaQkwPFmi5kT9sdySXTvTUka2skeAdVjZhfb4c7vuvWlNQ5Dbp64V8ct0DnG
 im0wmp6ucPpUMIPFn1BHIT2u28zBD5bUV0NjqQh312wBf9gDplj5/w9wXYr47VA/9fAP75Pim
 kz3d7gxk6OkGRQ/h4RqWIyJ5Oh6FMLfhJI80nG1galSgRf3Dfc1vebYp0FQJSrP3oote5JNt8
 wxEhP1D83Tv9R6N3lbh7eYHlguaP8b/MeSzbjsTJeMUmnPoClCGTtcDT8bY0aCAQSh+u2urRG
 bASiDN8c0fSpy9TWosPf2qq3UL52vzHkpoaaSPLLm39axEq35bhqFfvL79MrhlAVYOzK5K2Ob
 s1IFoB6RzxD60V84RM2wx3iAegnce+9HdmZ3WMTHxArie/7d5wakxtd+6FICfuQEQVyWW0tRA
 hXmTaBltA9qtpQKpCJehk7v+DPDemz0RUDYObRgtcey22bThDwMUOfFKNvNZmT7LNxmwF0pVA
 wkpP35z9psfOG34jsiuPSDaqRGggnuVLnGtqEX+c/NrRPSqkmOH7hCzuBLRfgBc4Skmu70FWk
 K1m1Y7cDTQnQNDAJ5TU6KsIIvUzhbco60z84BxRUDlRnYgQn0La7t4GcL1Nz1FU65kePrM+du
 ncLP1ee5T8gi2T1qeK/W/+Nleh6tP5Ob2927FW71sdJbzxrjJds4LfZO27jFIaj6xtnp1TQBo
 Ap0jwxpxEdjSpoY9rToKwHD2q/1y4zW/0bXyIHHZFYZCcestwk64EjBEA3UjqfI70LHWHq1CN
 Xx556m39cMBXag8IIPAwT5J+/o1FlirSNlfh4uoTrRTH4aEezbQJ1NOLlKLYIsfNUWKSfXYfS
 nYIRYMG+qavxhodDp5G7DFBuSBmPIx/aNCg3vls34obAk9CuS+BO2WHqHwEcMQxN0CUWks0QO
 WJtGBl7OsC2sNNj8wdXX39EpjYBula4hzWEsqaJxLCIbYiEBwBVPgl2dHYmYjz0RYzAoB+zoU
 T61vKJpIuWQOjRTzT/waysFSW94V6pwl21sVbZVfInx5bDkV8Ta0fV4Ps9sU=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

>> Would you like to mention any actions in the commit message explicitly?
>
> I don't understand your question,

I hope that remaining communication difficulties will be resolved better.


> but I assume the answer is "No, I want to keep the commit log as is".

I suggest to take another look at the relevance of the corresponding
Linux development documentation then.

Regards,
Markus
