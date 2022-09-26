Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90525EA9BB
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiIZPJf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbiIZPIv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 11:08:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BAA33376
        for <linux-pwm@vger.kernel.org>; Mon, 26 Sep 2022 06:41:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z6so10329500wrq.1
        for <linux-pwm@vger.kernel.org>; Mon, 26 Sep 2022 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2nV3OnX8WCDnxp7VmTZBQLJ8CRRFanST3tqzj4Y4KE8=;
        b=YA1QVKi9UhBceT8AYoU50XlwYm1lOjXb2nuUznMFTiWrlEK+LzOJWcLB2yqp+o1A6w
         bI1XP1RJWoBGDcNWWwN6OL265YVGYxudeRrZpoEVwxxW4/4Yi7xovqZ1h/YBF+6gkjMr
         HD3HUKt0HkfkclClzLJrVUh9gxPgYo+je1bhwvBmyAxMsghzNrnwi8k+HhBT6EvMW5nI
         YBI7y2/Aa6SDSE/3mYbNhWbQxOOgGf3NKXs4Q4banlgt57gqTvNqu2cwK89pTdN1Ip0T
         mOAys+URoeP83ML0gNV7IAxuTikg89HfJsEh0Tnbi2XkCTZ2VkdQUaslAuYWWbYRqApY
         8KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2nV3OnX8WCDnxp7VmTZBQLJ8CRRFanST3tqzj4Y4KE8=;
        b=ti7Z4ySSBHRN6iJj8mmci2id3QewFfj2jGQjrOW6PlBThJ8NozisgL7Fek6Ey0BOBN
         mD5Uisg9AhX6w9vO8Zu1rjDiwQENQIIpMOBCN6NE/f/t1I+a0azOzblDUjjMUi1PTTJd
         ceYZec0zY65cHBjOUWoq+43evHrBOAwySHkJS1dPOpTDpGUukRtyF2GMZdsLmbppd0xw
         WwY9jn/9b9scB2mk+IGazRU9xG+Nnr3WHKuDOqd1OwtDbvEOQCKEGK3Sv/yBDRuR6wc1
         zi0RuAEyZeELnWC/xPxYvu2WNyiHRk/t0p9b39EODECOoPz+5F0gcxuFw+IYGmv+gGSz
         rptw==
X-Gm-Message-State: ACrzQf03h/OUy/tZB80EyLwn6XZK5MZJqd4T5Hzq5UvsPDznBgZyGavt
        lcYV00WXOkhjoYBOKZ/sFcFUPQ==
X-Google-Smtp-Source: AMsMyM4Uq3HSM4U6VhE/gf8dGJYxbyoeho5aabOD87EFFcvHpRSUKodVZ5it2S0OCse+91AeNK77+A==
X-Received: by 2002:a05:6000:2cd:b0:22a:4831:dfd with SMTP id o13-20020a05600002cd00b0022a48310dfdmr13309159wry.706.1664199712029;
        Mon, 26 Sep 2022 06:41:52 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d6b42000000b00225307f43fbsm14449467wrw.44.2022.09.26.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:41:51 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:41:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee@kernel.org
Subject: Re: [PATCH -next] backlight: pwm_bl: Switch to use dev_err_probe()
 helper
Message-ID: <YzGsHadJ+HGJETJv@maple.lan>
References: <20220926133258.1104850-1-yangyingliang@huawei.com>
 <YzGrLsNrwEyL98nP@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzGrLsNrwEyL98nP@maple.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 26, 2022 at 02:37:50PM +0100, Daniel Thompson wrote:
> On Mon, Sep 26, 2022 at 09:32:58PM +0800, Yang Yingliang wrote:
> > In the probe path, dev_err() can be replaced with dev_err_probe()
> > which will check if error code is -EPROBE_DEFER and prints the
> > error name. It also sets the defer probe reason which can be
> > checked later through debugfs. It's more simple in error path.
>
> I'd prefer to have received these patches as a patchset rather than
> individual patches... but it is a good change so:
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Oops. My last mail neglected to mention that you did not sign off your
changes (meaning we cannot accept them). When you re-send this please
add a SoB and combine with the other similar patches.


Daniel.
