Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8347051F72C
	for <lists+linux-pwm@lfdr.de>; Mon,  9 May 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiEIIuJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 May 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbiEIIR5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 May 2022 04:17:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E31ED28C
        for <linux-pwm@vger.kernel.org>; Mon,  9 May 2022 01:13:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 497451F43981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652083997;
        bh=nN5bkg+Kcbz+2Ef7HwzKBHrumC//NVeNu6tEQwdSl/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VNAHhwUGrv2v1zSCqOgvcBbccCi6o+VNeYGspH0tsMWIFhZnH4Vc8957cTcnpmL3y
         GS2wxkBBt4jymq9pjLhf2Njw4tKfJttt5mO798U6IEIy8usEisDOVJP1xcIaedx1c+
         gYq3XJ7vUZxNKC99BRiw1LBshO8ahUkQk7SibNA80LWlBHdthhT3C5S36GzYtCqBd+
         Q02bcrWuMW1x3vQyw8qDeBgcHpaVFrimAlvBXKP6myNxtNJtZZUIV/G0lZKZVa9BT1
         JUpV0pRVT7eUqmwYJKtD+KWYWsf2sfyaKqzKEKTygu/kTB+U/0x9XoZl945q0YhYdA
         /z9JXcR4wLgpA==
Message-ID: <92b2f870-2b98-77c6-f8c3-fdfbc455831c@collabora.com>
Date:   Mon, 9 May 2022 10:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] pwm: mediatek: Implement .apply() callback
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220507084337.167890-1-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220507084337.167890-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Il 07/05/22 10:43, Uwe Kleine-König ha scritto:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
> This just pushed a variant of pwm_apply_legacy() into the driver that was
> slightly simplified because the driver doesn't provide a .set_polarity()
> callback.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

