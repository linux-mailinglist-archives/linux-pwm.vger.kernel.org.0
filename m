Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C763F146
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 14:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiLANL0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 08:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiLANLY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 08:11:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5557B4F1
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 05:11:23 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB8A46601601;
        Thu,  1 Dec 2022 13:11:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669900282;
        bh=rJX/OvkJvH5IhNxH/xMksQl7S1Jl1zglOwTTa9llV2c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ghOktZk8/TjxXBxTxmavsyTF7g8EyMimJ9ei5wFANPpTUpZZ7+pWIFhVnYXoRrTCG
         TaPnKfBYXrrzuTyhsnvZBk1qfzmZzZ2BI/waFWnGShlFMikrAHvgLga6o2l/E8e5Iy
         loPHSYI8+P0Q7oDGCcH7F8gv9BDkm41L1vK1LfE84Ms9yiRFLe4xJszN0nN/yVSUDk
         g5YsKGUxSdH0a0FzNz5TABRcXXcy3gOCbGeE9ut5Ngt85tQ6YKYpigE0N6oN5OUheF
         79JB83VsBDd8Pi2NZo/1Sh0a8hFSFqhLsocItzh5+N/P4USgAhFrnLxsD1Qt1BCPxr
         /lVRT1pNTAIVA==
Message-ID: <e3299122-8977-de7a-5030-6519bc99f658@collabora.com>
Date:   Thu, 1 Dec 2022 14:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 08/11] pwm: mtk-disp: Propagate errors in .get_state()
 to the caller
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-9-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221130152148.2769768-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Il 30/11/22 16:21, Uwe Kleine-König ha scritto:
> .get_state() can return an error indication. Make use of it to propagate
> failing hardware accesses.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


