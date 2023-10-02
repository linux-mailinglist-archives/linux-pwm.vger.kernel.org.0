Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B187B5086
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Oct 2023 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjJBKoi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Oct 2023 06:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbjJBKoh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Oct 2023 06:44:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC97AAB
        for <linux-pwm@vger.kernel.org>; Mon,  2 Oct 2023 03:44:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 427EE6607105;
        Mon,  2 Oct 2023 11:44:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696243473;
        bh=yxGzisYm0+u3w64/RJUBU54VA1ZgDrJZO8umXla9JyM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h5SNnpgnCACwNxXJCh1TMm74yxzI/58CoKQuGmDMpO2rAyhASDZmYE4SJVPDni8ds
         vl0JTJfVUZWl/26DpKXzzj1DAbimSWxyhjGtHYV8BQe9GIAzQ9VqJC5cxo7tSj2MSZ
         0XhHLxQwzAPy21o3QhzwQuANERUYXhqZ53C8bpGBUm5Kt9UdwiGVNQ5mlRSxqw0wiV
         r34eHzyYBGdrlgjq1Q+VasOX1P8OKc+5ti/wDh/RxAvtNJzILpvS9XcZxAoC6MhSRv
         Q9ZclYyzsarmzjPoG3way7O1IvrCdcINND/K0yzvLVNgE8pVvsodeUMlylt3DRTJZ2
         LEpKhW/MLzvpQ==
Message-ID: <029d49b8-8cc1-2332-5e1b-041030692b71@collabora.com>
Date:   Mon, 2 Oct 2023 12:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/11] pwm: mtk-disp: Simplify using devm_pwmchip_add()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
 <20230929161918.2410424-6-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230929161918.2410424-6-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Il 29/09/23 18:19, Uwe Kleine-König ha scritto:
> With devm_pwmchip_add() pwmchip_remove() can be dropped from the remove
> callback. Then the remove callback is empty and can go away, too. With
> mtk_disp_pwm_remove() the last user of platform_get_drvdata() is gone and
> so platform_set_drvdata() can be dropped, too.
> 
> Also use dev_err_probe() for simplified (and improved) error reporting.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I actually wanted to do that myself, but I see you came in first. :-)

Looks good to me!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


