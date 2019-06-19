Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693344B14D
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 07:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfFSFWE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 01:22:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:33587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfFSFWE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 Jun 2019 01:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560921705;
        bh=0gDj1xAPXeyi4SMyiZbiyIGaB8HQWzPad47nh3Fqm7w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=el4v1VEs43Bd5oBZ3Kv1QrZGCwiYRV5ReRH+t2554vxd+9W7zXQ1qC+rCxh5CFilj
         Sk15Rx/bLqOh3OPOnTSAUeVkdnxj7cTz8ACCmvF8Of9K4B3QJkVcegRP3fohrO6ZYj
         zwiO3MqHBazy9nl81K8Gv4c1N/FGhwOGx+tb9Mn4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5eX-1hvoq53tET-00IyiX; Wed, 19
 Jun 2019 07:21:45 +0200
Subject: Re: [PATCH v2] pwm: bcm2835: improve precision of pwm
To:     Sean Young <sean@mess.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas Christ <andreas@christ-faesch.ch>
References: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <1c7dc4ba-eb6e-b6da-3bfd-4b872f9c6498@gmx.net>
Date:   Wed, 19 Jun 2019 07:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:qoG85SHjpUhZrGGD0GJJbVIGVhvVphYIwEpHoAWl8nkC8Xjf5Lm
 vqItpGm5O/Uq4UHrkXagAJCMByVM5+aaY6sndfYniKUFFBlqN+OLZZ2PUnVwXloBoWS03q6
 FfjDhLnVErAYFGFgC3Oyaa+BTWOH6oDxO0xEJ3N1j6GtYHzo0yTvxolA4wNwlLzJjKApT3X
 0+B6YQrZapNysZC4+bQKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B7msHSPgdj8=:TVC36hgbWevuxtjsTvLLLX
 fyH0XcJ+WFlYOOmNbyM+f7Td8DLxyvdKaZR9++L1cyWknQ49CsBBrp4sy0CFV8D+EBKOfcKua
 sTFX3fzO2JU9mMY3HCjmtQE812zzBsFTSeb/jQtnFNpVOlvy4pyzZUAZZl4Liui/LAKlNBfjh
 tkox8ygEssntuxxVFH0BPID+U6pvVrLOtc84rw1uNc6+hqfOjTEaj6dUCkDOS98ULNmeKU3eQ
 tV60O+shoFC4L9HRG/BYR1BIOA/ZbHLe7B3lccpK9NaRneumEf5MiBmpfUUNneIEKQN/wQlTu
 ZWfy2UBWJxi7g8IyTcCF9T5RAzpkuIwq1vqhYwy5ige3kxrPcW8kx3EP0u3lxS/xURo5VRPND
 zQPpCIWLnBnnwH3I/67OiiNDfZHSLmRnfNewVnhzsI4p+HhPPXYlRBFhtNeoqDjL5II5jOYI0
 d44h6I34/KIbW5hmoniTIzRGvkbMkAMz+Q792cMWMd3m6GJZLJ8ujsT4YuvbYeKkIvXTvHb7u
 cWBpgdo9sQT56yZICkhysAEU32eL9NjK7SxierMK4FOgqF4jbP+gC96juRkebz0LWMRPdc6bQ
 AUiuI8Wl7keWosyC56Ux6zmKBWF5hEKVLduyf5HC5iRC1iNPH2OQPiON7w2CnW96ZpDe4ggGA
 tEZK3doTlDA0ezq1KwQhSD6O8Ib/9uMNRzNF+nQG4CGoizN+6sTqWQV+3cIhq96zli3jTcaEX
 7Hc0ZevaPnIfJk5NN8GMMuNwU+r+XGWxs87RQlaBIIYhuf0q7zm6byxJJSo9K4QlZiFqwKoZW
 qqw0bbLZBEBR7OLBNPtEYW8VTCY1P+IKfPISupT+QMMKmJRcRX/lCve/44X6EtlA+QmOMkLL5
 Bph229lneIfuE7OhqHz4TS+DZe15COovN+Cl1T5j0ET8NH1+qTiKI1wsRFhZzAiIOZaCcClOw
 zZFF8sExBaoGIVrICFV/3vlHSTNu6RYZdlepJu3kkwbBKm/a1/S7g
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 03.06.19 um 11:00 schrieb Sean Young:
> If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
> carrier ends up being 476kHz. The clock is set to bcm2835-pwm with a
> rate of 10MHz.
>
> A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
> this to 2100ns rather than 2200ns. So, use DIV_ROUND_CLOSEST() to reduce
> rounding errors, and we have a much more accurate carrier of 454.5kHz.
>
> Reported-by: Andreas Christ <andreas@christ-faesch.ch>
> Signed-off-by: Sean Young <sean@mess.org>
Acked-by: Stefan Wahren <wahrenst@gmx.de>
