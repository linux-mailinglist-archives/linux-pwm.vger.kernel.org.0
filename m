Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4D3D681
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436488AbfFKTJi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 15:09:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:48683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436487AbfFKTJi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 11 Jun 2019 15:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560280162;
        bh=MyYEwP7YvIobADb/WB/Pv8aOqt+i0pHQ6Dq2r92khBA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gvmActsI3L2uO9XTuB7f60MXi223Sk7gmKk7BSrcgHJ46jT66gjLVMXVuYHqS5g/R
         yudWpS2lDQBV1uwKkyzh/n9THuRHnf9KyS3UYef9bawNBS7DU4EqHwkYNfKh+54Zq+
         effT1JQSZnavts2KvzDxonOORBPLctGXcPUMEdYs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZKF-1h9S5J0lJD-00RKDh; Tue, 11
 Jun 2019 21:09:22 +0200
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
Message-ID: <ed61d2f6-e78c-be75-846c-706d13d6b956@gmx.net>
Date:   Tue, 11 Jun 2019 21:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:R+eDHxD0pLN0T5YAgZaXQI22Dhn4+G8cW6Lky3fvktP53OFw0Sh
 DG2XQBezRaBCnWH4P9rMXZreA5slv354wsMeTVNY7aAaHSxA7JrOjNrjLuRoeYsr24aimWs
 XaK8S3snDBw4/BDrDDZc1uTVXjRt8X2Nk0S1+jtSeuVkb9u687/S7UrTwaZFBzMni5sAXTm
 XTYrZACBNgucWwtPjsl9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1FGf8NcD8NM=:QEZW6RBksuOdy5r12Vsy9P
 ep3Bjlkl6irOHhaRNYSnTlEi0OAsRVaDhIm2x09tecE4lzVGu0OGG+bOI91onNaoDoXoZU/vY
 u06rSi5Rh21JFi0nxQDKjCVrB7dUmMJuV4qkSqFOtyaAIdAr3KjFsGcrsIbgp83axRYfzYchk
 xVQDdrsMhIRj/Q/GuOPSWGSOvhf+DP9c44dv1thNxFg/sMjyRy1UrPtsdOotMablC+whZHHX5
 TLwTqSyz8QZ1wYwIslyfqhvnmUwAsGxqiMqAVj5Ff7W+tKz2hI75j82wslfrfsDAApueyRKw8
 B9i3WzyEWpVblyVQuK69OjbesWnskKQ6IYsNBY/oGP/BeB5Lthh/od2Tb6nhjyvIcsYy2Gdsh
 oY7Qg+elNMQxTsa4NdlSk/mfNdrQl6W3Q6GD2wc05Hky1FbjrcIdoK4aIixY7i1z7FrtbpnKQ
 A0YmFTLzuQU0+kS9cswSyMgmroyZzMfuAnsGWNHqF8hfsGpmf/dWcn9g5s90exeJR3zf5v0Th
 35OMrs8C51RnuOaX4Jajf87Nc9qixcYX+K9GoKRGUVN4CSao3Id7hY4aw4VpktYdqrRRyrgng
 VCsHaEmLUxdjZeO/8rgDzK4Bj/KMaCJBaiMMug9ORE6Wm02WC3cIKTFQg5cOJOG3gn2mZkBBo
 mQwAQGFaQEpxPcK15tFLupNTiImTblUncO3O9A0qpJi6nks2CoRLzE5EQazcFUvqHl2Q+McmB
 FbGliv/ZmqoJHA9tt/nWneGTqJLx0Ny7/PQuDpSC/z7IbnDGigWIwlHrlJ3BakxtbfQcp7vTy
 wgsgk2ztydt0Qt7887AylMY+9D3kUV/yyLQamHsJ7bB2DKnBNIhKzERhwaBZAJYCaUtZmCVUY
 Egn1M1ueuzbrJPG7AMeSYfSs6mug3po85jBCMqGbMmDPVlVrzVkFrcJnd2GorcdTYIOvi48ga
 6NdCBfvRo5COMUpOxtJOZtHyVIjuomEvy7dWZfzYAwP2aQ3d6fPSy
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

Acked-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

