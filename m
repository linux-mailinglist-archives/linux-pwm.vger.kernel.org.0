Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88115F7551
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 14:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKKNrz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 08:47:55 -0500
Received: from mout.web.de ([212.227.17.12]:33035 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfKKNrz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Nov 2019 08:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573480070;
        bh=8MyNxznkzl0xaPNTzkyqaK3UfO4Y4mVE0gO39mL9Kj4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g6saS5xVmr6ZoVR3GnJ/YfwlLz+vqwuPvsUI3zQwixOD5jV1UqYZVrACUa5tz0Cf6
         2hraRyEAkFnG5ErbmvOPvGv7oYUgWhhWam6Gghp3Wz3S/yP8y1B86kMJbJBCdoPXTK
         eVhJGClamMq3491k2adRBkCPR4jjSW1AiPWLtba0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQelV-1iJtCV0Onl-00U0Xd; Mon, 11
 Nov 2019 14:47:50 +0100
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: Allow compiling with COMPILE_TEST
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-4-u.kleine-koenig@pengutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f01b3443-9dcc-6485-4a05-a658d93326da@web.de>
Date:   Mon, 11 Nov 2019 14:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111090357.13903-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uj2vQBMasG+LCAwBnNTLrJNI+arYtkAU4Rh68Kljn/JYXfiMtfQ
 z55xJT9+jm2PpzeY6xoAFLWuH5aTMdCCkfa3PwvE4+XxlGXNUb0DOv9A4detGkI0n1wI+Oi
 sjJI502E0OEVP37NTWZJcqq9YNwQ+r+t+eZORw55+5AUjIfR6PhCEPlF8gyedWTEjhkT3ax
 sD8ys/SbleOTQ8l8m9aeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yd1SyIhVKig=:w21slXE85TOrPIqIZFvJLv
 jqb67gAMds+u0lHe8+gh/gF6yxZvV/ecx3+WFBSQQPP9O5NVqPECtUvv1vlW72ZlHfrO0LjhV
 /DTxq0fh8QfYE9igSSshW0Cz2WHXpCpU6U47nOjOae8+AS4DPeQLl43qzHTjk4PlWlwx9W8hB
 8HySMf7hrsrciPbZ2l090LEoDPaCrKr9hTcXOoo7V3OowvoDbFgnrEvuHeVb1nfM1XCtu3Mdr
 dfxD0WmBRI7EmU791ENq93NQQOJVEG36iK63irRw3wnLOc8Wj4HRM+cXYuvnN3doadwbgNjKY
 pMb6JqRv/3+wkcbAKx6mgc9t5F7gxdfDMwBUfupIEExguGjCPrpbCS9Lw/yk1arai/lVXE6Fi
 AnhFWpsFp36cXSe/Gur4bHH2hSGF7TIQyoXI18fwrByv13dtLrzoCrM3pp9RCiSRhmR4VCFNZ
 qrGmBnOgl2nbCyUJYYacLv5HSFdqMSSsedmnSyyuhfz+m8as7QcSqe9AljgDxhM967egj+okD
 FdA5V5Q7+DSOxQc49aUQH3hChy4nVFDP8b6TkSfB5Oa7V0NLkG6pq3EMEWqTACRoJP1iemi8q
 fIJrzTMYa4Y6R6IA4zJdkox5GLplMwhizg1nx4v36JuwENY/ZmB/BjWkXr54KExXrXUbr7b5w
 5lUGpfYFR/8DfOKTr7iCBEg4UUOfbqzQKGwFeiDuDU/GQApIAyBTBWz6+LKLCD3+gR9N6xxhZ
 w94mllGnDTZLiLQ/vddtQZKF88fTvdoHQOtpZ47atq+CCq1m8KvJfHGGU+RLA17zYIEw4ZOqx
 OCktaY6Ey6d0njqer2b4iEMhH+9wNsO43revQ+WUnp+MtkUPkYwL9YiWh/R7p8u2E3NhTDIMh
 MZAei7G9iczMJjWozGM4bDXRTB8Nof5e9VR6mPTVIjetSXuGRouWHVft+eTM14GMlPmNR7qBy
 pzwUuvaOzGTPX4XovB3fKkySHev8CFo9+rxKoCnbyA6TdMBT3gmeiEKshvJ9y3PXdSI83cgeq
 t0ESFodQllHMINavoj4iXuOv91iuAz+kVqRKtJnuZejgelWxH9KHSU6kS46074CQemZWIXY59
 XVowrVQwI39mKf3r8LWD1Y7QRDIpocTnpaCYwg+tiwba41fB4MR4EsdOMDJ9gEMJaGhNKYIjj
 MKfcUzfsqaxxojkcy1bHSDa0YpKzLhflCxQWZWxXlboqIKzlvgTS2UFJElnRT/oLSQHlH1wUb
 dlEgChpzqnT1hVAYHJqh/tySi7vcT1KvT/g7ncxAwNAOaBVqOGrsIVrewhr0=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> The dependency on OMAP_DM_TIMER is only a runtime dependency. Also
> OMAP_DM_TIMER cannot be enabled without ARCH_OMAP being enabled.

Will a more =E2=80=9Cimperative mood=E2=80=9D become relevant also for thi=
s change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D31f4f5b495a62c9a8b15b1c358=
1acd5efeb9af8c#n151

Regards,
Markus

