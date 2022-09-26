Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE65EA999
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiIZPGl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiIZPF2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 11:05:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF727A51D
        for <linux-pwm@vger.kernel.org>; Mon, 26 Sep 2022 06:37:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so10307554wrm.2
        for <linux-pwm@vger.kernel.org>; Mon, 26 Sep 2022 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KmT8737fPacCpbfR4MFMQYGBKsGn/TS8+soZ+8lgu8A=;
        b=clbYS2trrlEmEU5PvY7GzPsFpNhx42e6ugi0cebf+mDl7GN0ScQiuWEWx9oI//xRW3
         FTsIkMUYWsosA6ETER1iOAZBFulSPna7QojcudDzV9Gjh6ZXF7wC4rGSegNcRu5Ft1Ph
         BS6EkAyFfofpLQODvC8UOkGzOjiBE8Yy9RhewoiXrazdtQ66dWSPD0UTCdZ7tMxEGtpm
         I0Nzso8+fmeqOPEcJjAJbcee0EBTKVECyF0ypE7k8ssYF55yfuv05pqxHCCE502HYHIV
         otu9flHASZ3pJZp9q8hAk/btIyXiBMmqy1X8bMDp2FfG2NTKuhiguBJbMQWww47+H0Yz
         AXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KmT8737fPacCpbfR4MFMQYGBKsGn/TS8+soZ+8lgu8A=;
        b=uuZrzTUrNYd28/65K54vDNpPul3vnU5Br+Yb1kGrBS5AnktnVMqMlQ7ZnCEyTbiiE8
         lwTGIBlBNLm3IT0TViBWdHIBljjhVQ82INRaj/ygLqhr3MjdSxslEXQfC1YaaoBo5YIV
         8ZvwvT0QX21B5DoCnnvfhY3e81dpHaYJwe3wHVnXPCvl7qGs737/0gEIUHEbUH8dcJGv
         ClP4HRvvp/jN21JNcBH4hBqn2AuE7naMA3fjvZy+8jWqnDpQW7SZdGo3T+X20+ZsXvGe
         HPKOAuTu1DtF6TBbLtT7nZkjycb/vrSp3w/6GjTFsUHlBXy5wRk1NWuIbi2NEVuAyRlv
         k6pw==
X-Gm-Message-State: ACrzQf3ET1uWbAw8gRbZanOttW9444nUX650hKZNYC+v06SyywCu1Dku
        QuTCfPInIMjSMJ11MpkTDzmCLg==
X-Google-Smtp-Source: AMsMyM7qingDZgfmrbprEPmbkWZZkb8lMYITqDwe2EjvcBMstJgtHXpux5BlMKdCH7An7nEK+yxidg==
X-Received: by 2002:a05:6000:178d:b0:226:ffe8:72df with SMTP id e13-20020a056000178d00b00226ffe872dfmr13301991wrg.496.1664199473455;
        Mon, 26 Sep 2022 06:37:53 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b003a5c244fc13sm11536200wms.2.2022.09.26.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:37:52 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:37:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee@kernel.org
Subject: Re: [PATCH -next] backlight: pwm_bl: Switch to use dev_err_probe()
 helper
Message-ID: <YzGrLsNrwEyL98nP@maple.lan>
References: <20220926133258.1104850-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926133258.1104850-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 26, 2022 at 09:32:58PM +0800, Yang Yingliang wrote:
> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.

I'd prefer to have received these patches as a patchset rather than
individual patches... but it is a good change so:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
